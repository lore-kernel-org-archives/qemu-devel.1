Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5BEC2BA1A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 06:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84ADB206B6
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 06:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8lMbLTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84ADB206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSbEy-0007Tl-J2
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 02:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jSbE8-0006qj-H3
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 02:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jSbE8-0005d8-1d
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 02:57:20 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d]:36270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jSbE7-0005VX-Hf
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 02:57:19 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id v10so116266ybk.3
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2020 23:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ox6qPCg4P4424MHCAdbCEmI+olCsUhyFTboTUeyShmA=;
 b=o8lMbLTOr36pIGeuGuoYblCfnOkRVhoamIb1SQ8Wo1ewSIu/UYZd1VhxEuFWmh9vxv
 BFXjGYSfQLGvfzsFXInFQWMq5f2NLLXnfdqAjqpFJb+MOKU3ddG+KmIvLL/AfO9+bbau
 2Yc289PQfV0t/ss0kW+bTKT0LJAR5QVd2apfdKrHUcrxDEBBKgigFe/EkR87E8H5IwfZ
 M0ryMJw3CRgAG2IhxDKf88Zvs59DUeQFLtyHJqcVyMfhzO33SUE42Jr6fjK4SMv3CobJ
 bNUOJLRc/490jF9UODQxEnUU+pMMGCedw8sPN7hDpbGBQTLnBBKvvWIAz/ABDq+16mWL
 QgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ox6qPCg4P4424MHCAdbCEmI+olCsUhyFTboTUeyShmA=;
 b=aY08SHanw/kV4zfq7dAF/HPIVz7vZKeidWvng4InQSUe3bIP/oxwLGvTVHdqUzWjHl
 stz1cnrvqLumSJmxJOucCzB3g5PWCH0DceblYcCotznztTCrWX3AXA2vfSEzioA/+vy7
 75c0Y6BYHPeNO+M9M0yBTMi683XWNfV66O08v/uhaELM7tpPtzZ7TGKmCCjdOOtSDoiA
 xZ8wLudXotwCAD6/y47OAr+aHN8CWZL0QMN1ScjV9pJNwG9bc6kaTY1Wb13kwzQzggba
 8IglVxQ6GCLIP2QNBGZg4Wfv0vSys63nRZkoLohsdEDANkOrxxrhlyqDe5+GSlBTXY4F
 reHA==
X-Gm-Message-State: AGi0PuYNcxi51BSA58C9t3yefSHKgAlwx9dJqHRyYJeLvv8ik4oM/4+c
 OT3iiZtdap1yfeGTZoSjIf8aw6dS8Y2VUH4RpOg=
X-Google-Smtp-Source: APiQypJwyYCInHSCJZAybNwoplOzRRxYCnELXH74WgwPVfVWZEw86Li25M4BykZlm57zcsDRKPPWSQgCy1kXsSX49tI=
X-Received: by 2002:a25:734c:: with SMTP id o73mr29844849ybc.11.1587884238050; 
 Sat, 25 Apr 2020 23:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmUuRCDWMKZdgNNX43G4wfLvzgHcMuT=36JO_q8LnAVisg@mail.gmail.com>
In-Reply-To: <CAEUhbmUuRCDWMKZdgNNX43G4wfLvzgHcMuT=36JO_q8LnAVisg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 26 Apr 2020 14:57:06 +0800
Message-ID: <CAEUhbmXPXT4MRs1bZTMFUWv5Bhe20ZJcO12UUs7Pa4RQBragnA@mail.gmail.com>
Subject: Re: hw/net/cadence_gem: TX checksum offload does not work for
 fragmented packets
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Jason Wang <jasowang@redhat.com>, 
 "Peter A. G. Crosthwaite" <peter.crosthwaite@petalogix.com>,
 John Linn <john.linn@xilinx.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb2d.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::b2d
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,

On Tue, Apr 21, 2020 at 10:31 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi,
>
> The cadence_gem does the TX checksum offload by:
>
>                 /* Is checksum offload enabled? */
>                 if (s->regs[GEM_DMACFG] & GEM_DMACFG_TXCSUM_OFFL) {
>                     net_checksum_calculate(tx_packet, total_bytes);
>                 }
>
> However this will only work for non-fragmented packets. For fragmented
> packets, it just corrupts the packets by inserting wrong checksum to
> the fist fragment, or corrupts the data to be sent in other fragments
> than the first one.
>
> Any idea of how to solve this cleanly?

I suspect this is a common issue for all NIC models in QEMU. Could you
please comment?

Regards,
Bin

