Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0679DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 01:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8844207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 01:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/r7TLqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8844207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbwa8-0003nu-W7
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 21:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jbwZc-0003Mz-7v; Thu, 21 May 2020 21:34:08 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:39278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jbwZb-0002iE-Hf; Thu, 21 May 2020 21:34:07 -0400
Received: by mail-yb1-xb44.google.com with SMTP id r128so3817785ybc.6;
 Thu, 21 May 2020 18:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RnIhCUeWyYFnMVWHyaW9l1v+Q0ux+BQflBD9CarHsdI=;
 b=s/r7TLqXJ1rdxV0kEZ/El4OUOUwLjTh0hrxrRl8Z0OQcR8MSbOQVq9/2zQNTQ2p4FN
 azUdiQl3I20s1HkSWXXF8voZQrm4uSuN5RxtJ6z3snvpPiSY7AkdwMz45KQ/KlFF2e29
 +5egr3PVjlptrnUVVkKUlrq0rCv+Rf46mp15rkq0DZkRFsT7HENb47spat7e2dzhUSEB
 qubojL4nJ5+iyPlQfeueYQe6QBHnDG2yEWTiu1hZGB54TJir2NIZvUEPHQlfYWCrw1xf
 sLDx0RdTQqPFlpI2T5sLaRa5iwQ3k1LCC2i3GO37GAI+Jbt0XPWSSQKGytkmF0rd+rAd
 DCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RnIhCUeWyYFnMVWHyaW9l1v+Q0ux+BQflBD9CarHsdI=;
 b=dM++IhKsqswiVE9aGU9qKF1d1asWEzctneEVN9gCEv5GZ50dou0vWLSG9TS+MP1v/t
 fAFdigEvdKnOPwADh2yVAbsbdHE3Ng7LfbpJ+peKBiHbFjBC3DzezCY4sWyb6aZbjVXY
 iOp5p9KiXZms/UY9waTkWttInEvaI2dfGigARNLTgY59qCYoxLZjVZb8MVG5UnbQSQJ6
 0ciWRYBQZjY7qPN2y6Ni6jR7EyBOPDAbd8cSK96KYw4ctysEvsC4zRqh49te10wndo//
 V4zgNZXXFYMZ3Ilf8B3yYp6rJEQOPHMC7+PldrZqQkHHj1eNDDJH1qkmtSmpsyLnWGrF
 jgKg==
X-Gm-Message-State: AOAM533re1+wJrLwUNZUItRTiV1Kz264kw1J3PAe9yscSJi64xucHyve
 lk3Cjtxat34rfw3prxvOE/mjDdfvxhqjgooTYW0=
X-Google-Smtp-Source: ABdhPJxidqW3Fnpucfpii/Cv/OcRdQQHHU2SlWbN0bPW0U5m8l5b1DLBErTRKddYJR3NjTJWCh7iiGeuP9Ylf7dDnjI=
X-Received: by 2002:a25:1045:: with SMTP id 66mr21756569ybq.314.1590111245994; 
 Thu, 21 May 2020 18:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878640.git.alistair.francis@wdc.com>
 <3033d22bf6385fc24a990c0e096696eea552c51d.1588878640.git.alistair.francis@wdc.com>
In-Reply-To: <3033d22bf6385fc24a990c0e096696eea552c51d.1588878640.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 22 May 2020 09:33:54 +0800
Message-ID: <CAEUhbmXawoSc5NRJBZuzOxksWzBKDL37UfY8icmnBzSZbT=fyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/riscv: spike: Remove deprecated ISA specific
 machines
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 8, 2020 at 3:21 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> The ISA specific Spike machines have  been deprecated in QEMU since 4.1,
> let's finally remove them.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/riscv/spike.c         | 217 ---------------------------------------
>  include/hw/riscv/spike.h |   6 +-
>  2 files changed, 2 insertions(+), 221 deletions(-)
>

[snip]

> diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
> index dc770421bc..b98cfea0e4 100644
> --- a/include/hw/riscv/spike.h
> +++ b/include/hw/riscv/spike.h
> @@ -39,11 +39,9 @@ enum {
>  };
>
>  #if defined(TARGET_RISCV32)
> -#define SPIKE_V1_09_1_CPU TYPE_RISCV_CPU_RV32GCSU_V1_09_1
> -#define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_RV32GCSU_V1_10_0
> +#define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_SIFIVE_U34
>  #elif defined(TARGET_RISCV64)
> -#define SPIKE_V1_09_1_CPU TYPE_RISCV_CPU_RV64GCSU_V1_09_1
> -#define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_RV64GCSU_V1_10_0
> +#define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_SIFIVE_U54
>  #endif

On a second thought, I think we should not use the SIFIVE CPU type
here for Spike.

It should use the one that is used by 'virt', eg: TYPE_RISCV_CPU_BASE{32,64=
}

Regards,
Bin

