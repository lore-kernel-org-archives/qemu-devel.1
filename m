Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA49C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 14:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6E623110
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 14:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7UBnZ/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6E623110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xaA-0003wa-1Q
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 10:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6xZM-0002qa-Uy; Sat, 15 Aug 2020 10:54:04 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:38156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6xZI-000441-TN; Sat, 15 Aug 2020 10:54:04 -0400
Received: by mail-yb1-xb41.google.com with SMTP id e187so6855402ybc.5;
 Sat, 15 Aug 2020 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ph1qXpLEHaugcS/5DVgu0940+oCbwQDK8vKa8i0QDgQ=;
 b=G7UBnZ/c+7XhrFQWE8Qmw+PNZyd+kBE10XvThUWUum15NBowNkJUvRM+KL54K5gdRk
 XNtxJSEVguCxJC2whQdkLqleG/UH+ER5MOE6MzfEtViKf6V3He/onzV/Re/Bhum48+8o
 FhIDb/H5Oi860UNuiXLVVlDDbOyRjsMWf9ixc+wCFvxfIt4B+3jFKWjN9+zpP/1rdyqM
 /HsjhO99gF8ZGlc/lDphiM7GplbOgkSf56qzeepSLpYf6tOPthLjpyf8Gw5Iya8OFJIp
 TQeiGhxV6JZ2P33KoLmhCz6MZNYOvZCEIXW2dzp8aGX8FZsIUf53B2OFDft0d0lB+HMb
 q2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ph1qXpLEHaugcS/5DVgu0940+oCbwQDK8vKa8i0QDgQ=;
 b=l1sRGSPj3bwXqZowtnPtMNcDqIyerg4z2SugKe/AT9JyicMGIBx6cGpLzpMy6lL9tb
 BO/vPyb5ynTE6ZgcYb3jF2qMCj7ca1Hqgm+k7eeyX3Oo27XhjyHBeAMNTfRKI5Cb0M4C
 yJEXc1VMoaSVgZ2bimCuW7UVItuR21XlmZJW19mLM6wVBwDQa7OxiEvsJw6FBltpsGtj
 ZAEooG/6Bcj55p9kRJ+JGwT1XuyD9kcGbhK1Xgsc5m7sWhDMN2OI1DFau2mrmaHyWUbU
 2vys0/by0PszvHElONe4dXVV+T1PfCH9HDIm5F6ERg7Sn5joJt8yyDYgTvm/x7vKlAKe
 0laA==
X-Gm-Message-State: AOAM5303pOooIBziG7vgZHlE50B0ByC/yTMDsD7imjHUZwOYv0PuZ7Ev
 nA/8CY3oB1mV8NMTGktFhcCC6yXx+bNMBFJH1RE2aen7c+s=
X-Google-Smtp-Source: ABdhPJwoj1rR9msfNlcqc4A2fLL1mCbYcn+xXPAQNhIDf50R6sKODI7cF4s1PBk8JrLY+wldiwRqjAW+hkzqmlT5drs=
X-Received: by 2002:a9d:2926:: with SMTP id d35mr3850216otb.181.1597461563114; 
 Fri, 14 Aug 2020 20:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-3-f4bug@amsat.org>
In-Reply-To: <20200814082841.27000-3-f4bug@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 15 Aug 2020 11:18:46 +0800
Message-ID: <CAKXe6S+dDg4KHu-7B=b4kpAvqE6b9MjAKgu9qZerqQ5Go6ZiUQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] hw/ide/core: Trivial typo fix
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=liq3ea@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Qemu Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2020=E5=B9=B48=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:29=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/ide/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index d997a78e47..f76f7e5234 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -709,7 +709,7 @@ void ide_cancel_dma_sync(IDEState *s)
>      /*
>       * We can't cancel Scatter Gather DMA in the middle of the
>       * operation or a partial (not full) DMA transfer would reach
> -     * the storage so we wait for completion instead (we beahve
> +     * the storage so we wait for completion instead (we behave
>       * like if the DMA was completed by the time the guest trying
>       * to cancel dma with bmdma_cmd_writeb with BM_CMD_START not
>       * set).
> --
> 2.21.3
>
>

