Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29954C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0259324680
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0259324680
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathieu-daude.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1x0L-0002Lk-5S
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 13:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j1wzW-0001Rs-HK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j1wzV-00046E-JN
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:44:06 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45051)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j1wzQ-00043z-0L; Wed, 12 Feb 2020 13:44:00 -0500
Received: by mail-yb1-f196.google.com with SMTP id f21so1573364ybg.11;
 Wed, 12 Feb 2020 10:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NL3wXaoIGtWfpUwtqV6fDPmGqSRvZJiQtc632RMh1tY=;
 b=dbMH2oWjfR402LfJISBGVIBgTw3Av/QEBYgA84B5j+2DYPY/3qNig0cJtrwMFBGnWT
 YjmTYbwl6/dtA/ARaQnqAALau/XmMj7dh3ZbYFhy+/9tTyoOrpkH1/knCSzaLyzwh8Kr
 +5Ne9SWRG93V7jecYVN8dNMt1RIQJ9kna/vh9dFv28VnRNbRwecO0dEhLRW5URVJv4fB
 +YXmHa00eieljh/d9HRtourphNEtoOIfy7OUOrq+YDaDrw59IqhHfGGxb2LmGHISQx9t
 +IPNzswehMuiyF/8pRhHfoK6sNQEqOZUdpWzeDXEhXeo26D9fiC2uo19wUYvfvAbkBB4
 qp6A==
X-Gm-Message-State: APjAAAUByDYjCeNh0Lj6bNla0ek7r2kAyo/0j9+fXSel1XfgYLSFijSS
 KCdzxjzbHRCArL7z3orsBCJqPQtaHiRqVWYyTI4=
X-Google-Smtp-Source: APXvYqxeIFOn33/XIvCpydzer3Uz2lL2VzfskxALYaoZ9c9PSc850q5k7+UdKEGm1F6IAxTYXFTRztx98F/flQg47V0=
X-Received: by 2002:a25:9902:: with SMTP id z2mr11567336ybn.309.1581533039224; 
 Wed, 12 Feb 2020 10:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20191221155306.49221-1-jhogan@kernel.org>
In-Reply-To: <20191221155306.49221-1-jhogan@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Wed, 12 Feb 2020 19:43:48 +0100
Message-ID: <CAAdtpL7CrEAZz5GWJoYCegchQ=-hdkcih07icgoFd-ghJ3nMBw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Orphan MIPS KVM CPUs
To: James Hogan <jhogan@kernel.org>, QEMU Trivial <qemu-trivial@nongnu.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.196
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Paul Burton <paulburton@kernel.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@ & Paolo.

On Sat, Dec 21, 2019 at 5:42 PM James Hogan <jhogan@kernel.org> wrote:
>
> I haven't been active for 18 months, and don't have the hardware set up
> to test KVM for MIPS, so mark it as orphaned and remove myself as
> maintainer. Hopefully somebody from MIPS can pick this up.
>
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: qemu-devel@nongnu.org
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 740401bcbb86..a798ad2b0b8a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -363,9 +363,8 @@ S: Maintained
>  F: target/arm/kvm.c
>
>  MIPS KVM CPUs
> -M: James Hogan <jhogan@kernel.org>
>  R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> -S: Maintained
> +S: Orphan
>  F: target/mips/kvm.c
>
>  PPC KVM CPUs
> --
> 2.24.0
>
>

