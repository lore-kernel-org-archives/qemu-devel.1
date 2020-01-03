Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B03C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 19:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73139215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 19:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSy9XWiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73139215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inSaE-0002aa-Ig
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 14:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1inSZK-0001xC-PQ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 14:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1inSZJ-0002RA-KY
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 14:25:10 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:45345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1inSZJ-0002KB-BJ; Fri, 03 Jan 2020 14:25:09 -0500
Received: by mail-lf1-x143.google.com with SMTP id 203so32457590lfa.12;
 Fri, 03 Jan 2020 11:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xTUvqn+r75BWI2EEq8v6znpfHSFqXzOk7H/2kzAp8Us=;
 b=aSy9XWiyDLR6CzPdmXGGaYMpWH4QlkWEmPjYHfZ+Spk6Btpyy0ZA0dbj/mMbBBjKHP
 CP8dqnKzfdKnyX8ZXLl+huX5oolHe5QL07ofh8ZEnke6WGzBEDyfqIMKoEdHsNeqCTnA
 zlfUvEHSSRizJxfw9Y+s7jbtAA8gNzVMVmzRCF/4LUtTopURGszPlEu3okIwMW2PIi0o
 QqELqTmAm3HNuM39mdy8NJLxcgg+WNBFWNEnYn+Z6TWhv1PNerhcxFqiMqHqulHFjtNW
 jQzyOXI7fsWAYSx2zG0nOBGjw7Utn1jZoMg/kh2BrKVElFBJ+tQztjv0C5iXPBfZLfVJ
 k7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xTUvqn+r75BWI2EEq8v6znpfHSFqXzOk7H/2kzAp8Us=;
 b=MzGtpvT+cdpu0jfsrEdxCrcPcTaoaKlAC+OzhReNljGH06oSnu7mHssEvuPJP0lsYq
 A/fhO07Y8a8027a1HS98fq0p3k0PkXNQxq5WikDGjeCJeAyz+Wk8qr3vHxWgoZXhtKFV
 KO5QnAkSZaCq5YWO9SciUnDSyyr0r2XEUBTp7iN3EqyTjJSm1wRLG71SkzLhqegm9hSj
 eBUiXmkAOw66ObrN8WiiEYCLgYZATYrcdbKF5YeNc20K3MnltM9nAomwriWymRmILZX7
 8TcXFK7v98kR6pxx/vC6JJa3TmlnE6L6LSc6iMC2AQE40x+p+bVzlNzcMTzsA6Olfen6
 /+aA==
X-Gm-Message-State: APjAAAVnTNLeAw+YFsz2YoSPPDg7N95KHLFh/piyCidheTuFjtPfe+1q
 pPFmWBwHrpaHz14mTOmFJWQTzm1G3qnofctneMU=
X-Google-Smtp-Source: APXvYqz44VYkKZoSLCslTJylkmQznnpOEuk7hMFLm8y6VAMAbWaAmPt+Z7jNmYGRYf6GTmQZuBHJCWd7dCtJX0vEr80=
X-Received: by 2002:a19:8a41:: with SMTP id m62mr50557290lfd.5.1578079507310; 
 Fri, 03 Jan 2020 11:25:07 -0800 (PST)
MIME-Version: 1.0
References: <1578023622-49180-1-git-send-email-yiting.wang@windriver.com>
In-Reply-To: <1578023622-49180-1-git-send-email-yiting.wang@windriver.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Jan 2020 11:24:40 -0800
Message-ID: <CAKmqyKO_gJDyvzzO81bxgOn2nE3-D7gR8Nx1yX5iSGxAO6Rj9Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: Set xPIE to 1 after xRET
To: Yiting Wang <yiting.wang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 3, 2020 at 12:01 AM Yiting Wang <yiting.wang@windriver.com> wrote:
>
> When executing an xRET instruction, supposing xPP holds the
> value y, xIE is set to xPIE; the privilege mode is changed to y;
> xPIE is set to 1. But QEMU sets xPIE to 0 incorrectly.
>
> Signed-off-by: Yiting Wang <yiting.wang@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/op_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 331cc36..e87c911 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -93,7 +93,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          env->priv_ver >= PRIV_VERSION_1_10_0 ?
>          MSTATUS_SIE : MSTATUS_UIE << prev_priv,
>          get_field(mstatus, MSTATUS_SPIE));
> -    mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
> +    mstatus = set_field(mstatus, MSTATUS_SPIE, 1);
>      mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
>      riscv_cpu_set_mode(env, prev_priv);
>      env->mstatus = mstatus;
> @@ -118,7 +118,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          env->priv_ver >= PRIV_VERSION_1_10_0 ?
>          MSTATUS_MIE : MSTATUS_UIE << prev_priv,
>          get_field(mstatus, MSTATUS_MPIE));
> -    mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
> +    mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
>      mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
>      riscv_cpu_set_mode(env, prev_priv);
>      env->mstatus = mstatus;
> --
> 2.7.4
>
>

