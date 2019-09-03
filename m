Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE352C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AF522D6D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KfFJQrWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AF522D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5AMZ-0006KH-LK
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ALo-0005rn-91
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ALn-0002LN-15
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:04:07 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:44814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ALm-0002Ku-Nf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:04:06 -0400
Received: by mail-oi1-x232.google.com with SMTP id w6so463738oie.11
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QXdCOxdRr4JhFXbNuaXCvbN5G0um9X9Bke2llrs7tBQ=;
 b=KfFJQrWWzXzQvSYr5WqEKFhCgEaC5ry8Cu26wzRZDSpfZKT9Z8zngv/hXh5E3nqkRB
 icQNc2v4c4C7OZ/f0nzZDVDKhxEbAX9MkN0+7kwFpdW4AEIkADnHlFF0aS1zH0yNrhZQ
 EOUkSkoGZY3DbmQ/wU7C6F7AsdEG8srscyvSA2JEtbnT4SHP4qF4EEB2qonZultWnSAG
 1Ci3YaNAIfhw4TVu7Pg7+yzeROItxf1a9hH0UIKAm0vdlVEIsyun3qu8ASsB+IYhgFS/
 fqia1vRulW/1HYv9JKEbPgW7HJ9kigtlIt83IyKN15OQD+vdhfx5Qyfx1thTvEz2QZJS
 WKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QXdCOxdRr4JhFXbNuaXCvbN5G0um9X9Bke2llrs7tBQ=;
 b=s9QsRXT1LCzIfus3FJ5Y5qWr3pym7olgjXq8Ijg+Wf4hSBjBg+DXGIViQNCYaUIJB5
 2Mu2vlz8A32eZT7doJRsu6Sqa8dm/7A/K/+p8shXn2R0kad7iZA1TWJ2auhSMqg9aTV2
 /QRi3rWqXBPpS56z3jLYgpAH11dH+MY4WEHHQ9snkzOpMTv25Ww55yC2l+kfEdXULgEI
 4j1r1maA1zmQYUUdccmANLjE9lUy9W7Q8pDBE7cl0PkY6wwvU2nHhXVofXcNKazZGu7r
 t0Jhxxqo174pWwj+dArNEKrss79++U8s6Bh+TBxUSCyfv01zubM90RSAwk6wXy23uizN
 zMQw==
X-Gm-Message-State: APjAAAUeRKCtIQJ2vsFLxhCgkjkIsUHuZWSgL+qTSjhlHETV78UwqYZ0
 /JMIkcvE2hWQAXnh9cRiqJq1NmlROs21YMDlZ+6i0A==
X-Google-Smtp-Source: APXvYqyIdP0pYa+gsxSP1A6o/PwfAq4PrR6rvjKlw58zfRcw54tb68yq4Yxz8mVmmkQTw0mQvr8C8bQP65qlEzcXHDk=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr353847oib.48.1567523045261; 
 Tue, 03 Sep 2019 08:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190828184026.5840-1-ehabkost@redhat.com>
In-Reply-To: <20190828184026.5840-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 16:03:54 +0100
Message-ID: <CAFEAcA-AvFS2cbDH-t5SxgY9hA=LGL81_8dn-vh193vtV9W1Lg@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
Subject: Re: [Qemu-devel] [PULL v6 00/12] Machine + x86 queue, 2019-08-28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Aug 2019 at 19:40, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Sorry for taking so long after 4.1.0 to send this.  I had to sort
> out some conflicts with recent header cleanups.
>
> The following changes since commit 23919ddfd56135cad3cb468a8f54d5a595f024=
f4:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190827' i=
nto staging (2019-08-27 15:52:36 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to f4abcc0a75f1310dbe66b852ed97ec7caf2708d5:
>
>   i386/vmmouse: Properly reset state (2019-08-27 16:50:14 -0300)
>
> ----------------------------------------------------------------
> Machine + x86 queue, 2019-08-28
>
> Bug fixes:
> * Fix die-id validation regression (Eduardo Habkost)
> * vmmouse: Properly reset state (Jan Kiszka)
> * hostmem-file: fix pmem file size check (Stefan Hajnoczi)
>
> Cleanups:
> * NUMA code cleanups (Tao Xu)
> * Remove stale externs from includes (Alex Benn=C3=A9e)
>
> Features:
> * qapi: report the default CPU type for each machine (Daniel P. Berrang=
=C3=A9)
>
> ----------------------------------------------------------------

Hi. This generates extra warnings during 'make check'
that all look like:

qemu-system-ppc64: warning: Default splitting of RAM between nodes is
deprecated, Use '-numa node,memdev' to explictly define RAM allocation
per node

Can you suppress them, please (or fix them if they are
legitimate)?

thanks
-- PMM

