Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A11C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 00:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F40E206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 00:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvX4pJ4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F40E206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38877 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRQmh-0000Xd-K4
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 20:31:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tedheadster@gmail.com>) id 1hRQlk-0008RR-Gf
	for qemu-devel@nongnu.org; Thu, 16 May 2019 20:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tedheadster@gmail.com>) id 1hRQlj-0000Me-Hu
	for qemu-devel@nongnu.org; Thu, 16 May 2019 20:30:40 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:42774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tedheadster@gmail.com>)
	id 1hRQlj-0000Kg-C4
	for qemu-devel@nongnu.org; Thu, 16 May 2019 20:30:39 -0400
Received: by mail-vs1-xe44.google.com with SMTP id z11so3493055vsq.9
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 17:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:reply-to:from:date:message-id
	:subject:to:cc;
	bh=5psjCtCLYITFeVX8zk8PWk+k2L6PoQe8DTLawu/HF90=;
	b=FvX4pJ4c4y+u1T1Y++RofTXacEWn0juW2pMLe1n2z55qeu8bxTyKHowitfV5DUV1S7
	kpbEtACgITjVsKhqecB2aqdux9t0Y1WK96MIBecitOX/4vMZ0M7E/brGcU8eEifly0Zg
	8ZhlHwNFcvJ33TfgKbCqGXQ8wfXj2VJge9iLtfMwg+uL2RPLCc4JVcr1S0biDJZAzuDh
	4+azerJVtyDheZcMS4AdzbzLKDp7BXGIl7MML9TD4fAUwt2Srcl8gbQVIOhgYlZTRF7D
	ZU1ii/Q6UwlTAXfkYFbAMqsFT0hAXMXtqCOEJs89su0gSEYscHD43jLwSCX2eXhObjiJ
	rgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
	:from:date:message-id:subject:to:cc;
	bh=5psjCtCLYITFeVX8zk8PWk+k2L6PoQe8DTLawu/HF90=;
	b=WJGGYhwOnrKMmHlR3ebXHzxxwq9aS4wbDpX+9OfPH+4ufYnAHZIQ4oeFdR2JoivWAJ
	xZtdNUmIhoqHweof2dMVEpPst4vCaIB2dFlZlfjx+baxob5TTWzykdou4VSRlC3Te7qL
	BzyRrOrfnvlw9sccJvkbSYXxLxMkd6CO/MAeJyogAKQj8MuiaGAQSVr+e3k1/RCQO7MR
	8nYU/J7hTVDajC+MPBDaJiTPUHNKBS9ODFo3DWeZaPo6zOILAhnnINUaB3Yu7FQvMDYS
	2UIVqNqKIXjDpyJAKj4MesErOva5HS5yy7RhuAHYWkipfzQ4BUdVYbNGsVRKvww/QTck
	somA==
X-Gm-Message-State: APjAAAUmwtMFlxi563fnAOCCwYq1l7up90Lr0dQakdBw0ionVBXWaFE8
	Z3OiHwxHFSghBjaCxuKVVU2ZXpGR0WBN7FFxGQ==
X-Google-Smtp-Source: APXvYqyoahBpNCFAA9xXDsn7X4mV24bkH9QiHapN+o2V44WpQXCkgPCOXPkwiWVgQtEhEwqMWasQzDYlt2GSeITU828=
X-Received: by 2002:a67:ee4f:: with SMTP id g15mr15570928vsp.38.1558053038010; 
	Thu, 16 May 2019 17:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8WD_bf=0=tyCumcNpVLtneio+vbd4JuFMmtWqSwXWFC-7PMg@mail.gmail.com>
	<6da0c28c-ef4f-8199-1cee-bf1f08387ff1@redhat.com>
	<ea9cf5ec-f259-9a23-eae1-1b2250c367b0@redhat.com>
In-Reply-To: <ea9cf5ec-f259-9a23-eae1-1b2250c367b0@redhat.com>
From: tedheadster <tedheadster@gmail.com>
Date: Thu, 16 May 2019 20:30:27 -0400
Message-ID: <CAP8WD_ZUVZJKk-tEfG8+yd6t_U9+A3a4s5_ohjU5KLP0tY5YwQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e44
Subject: Re: [Qemu-devel] Pentium Pro Feature Bugs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: whiteheadm@acm.org
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Matthew Whitehead <whiteheadm@acm.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo,
  I am running the kvm32 machine and I see a problem. Here is the
output of /proc/cpuinfo :

flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
cmov constant_tsc

I see something rather important missing: cpuid.

A lot of stuff breaks without cpuid, and I am fairly sure that qemu is
supposed to 'hard code' in support for it. It is present with both my
i486 and i586 virtual machines.

- Matthew

