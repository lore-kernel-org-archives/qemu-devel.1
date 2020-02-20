Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A61C11D14
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B4920722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKLTvciW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B4920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ppj-0000d9-Hc
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4por-00008x-3W
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4pop-0003Ut-WB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:41:00 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45419)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4pop-0003UB-R4
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:40:59 -0500
Received: by mail-oi1-x241.google.com with SMTP id v19so28359050oic.12
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 09:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4nlxobWH/cPSCiCSfq65vJtOY2phMuGKP+jugJ7vb7U=;
 b=bKLTvciW8haCddItSmr54wp4912pNQVo+8mDCbR8wOlSXipuHaWl469AA6LBBfcHdd
 uA7jU0wuFWiRxhCKughGi1DXTV2FWXJ0hd5D8OQFq1hbyCM7NMgNcLDbCvtgbgn9uHIC
 JX0CJ+3mNpFPh3s3rSV4QeF1+VP/ztrv76yt1Ztr+1K/oh6+AOmCEG5hmPpzXZPbz9d5
 1dwfbiic/lRD10biUROMf/rM/dD0rFsQff70jv17+I8kzmIf0eKM5XE8yyuiOAeEgRBN
 H1EFRHrr1PGcsaSz196yiCVWoiyKlcZlivBNZRkq6GyLV4PcFfQhjLgwslS4fAoaGs+t
 YCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4nlxobWH/cPSCiCSfq65vJtOY2phMuGKP+jugJ7vb7U=;
 b=BXTQhE7HCVRvOTSvPrwaWgYeMcO9D1o3ttouXsWfw6agz3BvFHPdENKLbjnMvuzJ23
 3s4bEdNCdz3IRTtrcPUk4EDZIJfyMfyJIc3Pp/8K4UR8O4hpshCRIt+KYQjpFENy0FdS
 qLlYOQ8gEMbnc2bZOv6Y6BY10kDWoR4DVmGjKUZYwsSqGPej/JVinGQviydN826pAanK
 OS0HKI9bw8D3rnrt6xExS8FM1mRe31mS0lW566DPMewETM6rmoPP0Wbb5RHhgj4O7Nvg
 JRiiArfA9ueGg83/3d21KKUPe24SlZ0kL620cwfuRzahJbOOD53gyllnyGBDdv+i5gFm
 qX4A==
X-Gm-Message-State: APjAAAXFpssVI+vp0gx2N2TlvDwnp9D2ftPPzGbDZIXWkBYXjZOv6RHM
 RN0/CcU7Ev5B1l047m3rNDV2LVoQ+oMwf2ZZ5YVeJQ==
X-Google-Smtp-Source: APXvYqzxKEtUFUxDXQXWx8RVLlrpx4GjIZ2EvXcQemnSSRTAl/Tjq29SO5A3mCEk6quLGRztpSi/sXPG+MKyQ8Fm3d0=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr2968452oid.98.1582220458939;
 Thu, 20 Feb 2020 09:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-18-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 17:40:48 +0000
Message-ID: <CAFEAcA9djfeZuU24Zp7shYDRucpRzaTFcxhNOtta4P0h-67hEg@mail.gmail.com>
Subject: Re: [PATCH 17/19] target/arm: Add formats for some vfp 2 and
 3-register insns
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Those vfp instructions without extra opcode fields can
> share a common @format for brevity.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/vfp.decode | 134 ++++++++++++++++--------------------------
>  1 file changed, 52 insertions(+), 82 deletions(-)
>
> diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
> index 592fe9e1e4..4f294f88be 100644
> --- a/target/arm/vfp.decode
> +++ b/target/arm/vfp.decode
> @@ -46,6 +46,14 @@
>
>  %vmov_imm 16:4 0:4
>
> +@vfp_dnm_s   ................................ vm=%vm_sp vn=%vn_sp vd=%vd_sp
> +@vfp_dnm_d   ................................ vm=%vm_dp vn=%vn_dp vd=%vd_dp
> +
> +@vfp_dm_ss   ................................ vm=%vm_sp vd=%vd_sp
> +@vfp_dm_dd   ................................ vm=%vm_dp vd=%vd_dp
> +@vfp_dm_ds   ................................ vm=%vm_sp vd=%vd_dp
> +@vfp_dm_sd   ................................ vm=%vm_dp vd=%vd_sp

I'm less convinced about the ds and sd ones because there aren't
very many uses of them, and now you have to go back from the
insn line to the format line to check which way round the single
and the double are if you want to confirm that the decode is right.

But anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

