Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D5C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92A920780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPzujF1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92A920780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPYoC-0004YX-Vq
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 17:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPYmz-0003A1-J0
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPYmw-000401-Qs
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:44:44 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:37408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPYmv-0003rx-1I
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:44:42 -0400
Received: by mail-io1-xd44.google.com with SMTP id u11so4012605iow.4
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SSoJC6kBxpOwLWLph2ANBOU9z7Dj7/s90iW6DwM7ZWI=;
 b=oPzujF1K4WTsTi+bAIwF+KO6XXmIFDWnuSsXOAsln7ok6krTDj8DnmVFtNUrpnutKP
 L5HswckTYrLga32JhxC9J3ZfhAgxdAu7zjwl0ZFw3k+wMnPndcoPyKiLb/jtv5C+P/D8
 W2rmT+Z5wDRmONZlaMAcRNztgYukGuur3RTag/AAGD7bdv8LaFHV5SDdARGT1Kkd/Jmj
 /RcGF+TYTGpon08qaewWNXXG+w30SAuA3ZDfoBcQOR+/2WckozDSRxDQb1mV0NrNuwqr
 4KlZ7oMFGKgtuYjI1lPfJHp4Scz9Z9TbBkgvm59HHkUeB8X5nJ9BheDpd6To2DJxuTCF
 U9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SSoJC6kBxpOwLWLph2ANBOU9z7Dj7/s90iW6DwM7ZWI=;
 b=pyNwzrsax/Jb2dtMvDX9AGr+zXvFWx3MC6YQOTaKncj84zprJIbuc/3I/YZshWdcoX
 e5470lwCPYjOgorroFsJOKnPvIlSEnE5nH3XpcF5MubL6ioxNPvPQwp9bYd49D5fWJxA
 Wbq97cyzw+d5VqORipld3a7PcLGoDuS40PzCBcCtdbELvtUYQqONw/upb2IiQkPjkf6I
 Bm1828uTvxajL40KYawcCUDbiwP8qBxwSvkXq6z/vvz8i5KcxB8rIEkv0SKhcnDcuk/L
 ofLPeRAzo4HczXzCbOm60n0HdQrCyYVILfL1GHppbZLmQ2rFusGUuTftlMgOxdu+7V72
 QQHQ==
X-Gm-Message-State: AGi0PuYbENtlmMx0KCRvlCSv/zdA+7wy7FjI/T+u11QO7tnfeA44Apjc
 g7Xdk8e1hrxc5u375cQ8/7wkelobNHDkRff2lFKEjBlq
X-Google-Smtp-Source: APiQypLnWhCtW5xHUeQoMIIzq+EyhpzS/9+MryGnUrGbTqlS48loYx74sTeU4fckXkH8EBjUX37ul/l2F8xTtjTTOTw=
X-Received: by 2002:a02:1c82:: with SMTP id c124mr5212979jac.135.1587159877123; 
 Fri, 17 Apr 2020 14:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
 <20200417191022.5247-6-edgar.iglesias@gmail.com>
In-Reply-To: <20200417191022.5247-6-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 14:36:14 -0700
Message-ID: <CAKmqyKMkkT1-GbaLAnFqLgt0HU3956bDR+XBTjg1DxdPVeprJQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] target/microblaze: Add the pvr-user1 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 12:17 PM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add the pvr-user1 property to control the user-defined
> PVR0 User1 field.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/cpu.c | 4 +++-
>  target/microblaze/cpu.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index a850c7b23c..0759b23a83 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -193,7 +193,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                          (cpu->cfg.use_mmu ? PVR0_USE_MMU_MASK : 0) |
>                          (cpu->cfg.endi ? PVR0_ENDI_MASK : 0) |
>                          (version_code << PVR0_VERSION_SHIFT) |
> -                        (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0);
> +                        (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0) |
> +                        cpu->cfg.pvr_user1;
>
>      env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
>                          (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0) |
> @@ -290,6 +291,7 @@ static Property mb_properties[] = {
>                       cfg.opcode_0_illegal, false),
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
>      DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
> +    DEFINE_PROP_UINT8("pvr-user1", MicroBlazeCPU, cfg.pvr_user1, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index ef9081db40..7bb5a3d6c6 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -307,6 +307,7 @@ struct MicroBlazeCPU {
>          bool opcode_0_illegal;
>          bool div_zero_exception;
>          bool unaligned_exceptions;
> +        uint8_t pvr_user1;
>          char *version;
>          uint8_t pvr;
>      } cfg;
> --
> 2.20.1
>
>

