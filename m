Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E178C47420
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42D120872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3Fg/Rkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42D120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO286-00074u-1b
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kO22z-0000or-SD
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:07:13 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:33032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kO22x-0001Wg-Qg
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:07:13 -0400
Received: by mail-il1-x143.google.com with SMTP id o18so2646660ilg.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KHDHpOYB+PDjXXF4mqlGcuHsX0U8A29kJBUR9WNuH38=;
 b=G3Fg/Rkp9Yx3XTaV3NlNvckDslf1rcqiymmP2q8LFse+mKnC9UZyfUBDx8yICV0J3y
 b+40yBfsFgVwlBEKwuOWHyCeNa5Tf4WVa/wSXckByuWVEQhcbk2wFgI16u1iiFjvQ5X4
 EtRh+ZiXol5QxNnXsEIUjMiP6BiLDqS2Yk39Pxt2zX8QYEr7u/nzJCrEVsQhkdXeZLGP
 AM34w5M6DXLi04ZgJGLnQh8/Cuu21QkxEvJ1Rhs7C8NI9OI9uwW9u7yZ2PD07K1KhKgO
 IWPL1YalBxbxht6eb3+elnpQm4rKU5AeI8LfWayXRQp9wivoB/8Pw6Av+CiMVT2AdKYn
 Dt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KHDHpOYB+PDjXXF4mqlGcuHsX0U8A29kJBUR9WNuH38=;
 b=RZLHDmvx4WRhNw6aKLjiN0heieYzvmNzEXoKBv6e+Up9VMLDwrB3Xu0DBp/u+vn/pt
 XeO+qSzpR+3FQZsQPUrcV0u/e9OPm9D2IdOx8m8Q8OI2shoU5Ur9p7Ld81wbVWq4YAqz
 /EEslRQrS1oNNPVjozVebWD+L9HL4UD/msHrVp50CTcCp4Ozg1nnhtvQx1RGMx7ASaZt
 rK8+LMkKfU/Gny40rAie0grib2B1hB77+rIeoDWVLudJeHu/+Z1Urnkss2dlf8SKQqlv
 yB+Pv8s1uUaDHIvRX46aPiTxeA6xWsc59CsaKln65VeiDmbN4FD9w98yTu8MrA/z8lm9
 ZpGQ==
X-Gm-Message-State: AOAM532y6Zzpc1dovhNtciCFp/WjayM3bxFIAaTcuTOeWtufkk8fie5n
 Ol5XS5Oe2I4f6UHiP8vX8QNXc32vjevW5n8yw08=
X-Google-Smtp-Source: ABdhPJykiDln7dkgUnDVUGw/QXkXXtnhXAZ7Z93nFMnaPdWqQWZO55L0V+V/Yho2prg/isi7hXy6MxXVDcAdUJh9poY=
X-Received: by 2002:a92:cd49:: with SMTP id v9mr3386643ilq.177.1601572030028; 
 Thu, 01 Oct 2020 10:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201001164322.1585392-1-f4bug@amsat.org>
 <20201001164322.1585392-2-f4bug@amsat.org>
In-Reply-To: <20201001164322.1585392-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Oct 2020 09:55:45 -0700
Message-ID: <CAKmqyKOEGnPE7WRSSc96kWSNV-oprN=tPwBskJGgx4P3EagACw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] util/cutils: Introduce freq_to_str() to display
 Hertz units
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Havard Skinnemoen <hskinnemoen@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Damien Hedde <damien.hedde@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 1, 2020 at 9:57 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Introduce freq_to_str() to convert frequency values in human
> friendly units using the SI units for Hertz.
>
> Suggested-by: Luc Michel <luc@lmichel.fr>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/qemu/cutils.h | 12 ++++++++++++
>  util/cutils.c         | 14 ++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 3a86ec0321..4bbf4834ea 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -158,6 +158,18 @@ int qemu_strtosz_metric(const char *nptr, const char=
 **end, uint64_t *result);
>
>  char *size_to_str(uint64_t val);
>
> +/**
> + * freq_to_str:
> + * @freq_hz: frequency to stringify
> + *
> + * Return human readable string for frequency @freq_hz.
> + * Use SI units like KHz, MHz, and so forth.
> + *
> + * The caller is responsible for releasing the value returned
> + * with g_free() after use.
> + */
> +char *freq_to_str(uint64_t freq_hz);
> +
>  /* used to print char* safely */
>  #define STR_OR_NULL(str) ((str) ? (str) : "null")
>
> diff --git a/util/cutils.c b/util/cutils.c
> index 8da34e04b0..be4e43a9ef 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -885,6 +885,20 @@ char *size_to_str(uint64_t val)
>      return g_strdup_printf("%0.3g %sB", (double)val / div, suffixes[i]);
>  }
>
> +char *freq_to_str(uint64_t freq_hz)
> +{
> +    static const char *const suffixes[] =3D { "", "K", "M", "G", "T", "P=
", "E" };
> +    double freq =3D freq_hz;
> +    size_t idx =3D 0;
> +
> +    while (freq >=3D 1000.0 && idx < ARRAY_SIZE(suffixes)) {
> +        freq /=3D 1000.0;
> +        idx++;
> +    }
> +
> +    return g_strdup_printf("%0.3g %sHz", freq, suffixes[idx]);
> +}
> +
>  int qemu_pstrcmp0(const char **str1, const char **str2)
>  {
>      return g_strcmp0(*str1, *str2);
> --
> 2.26.2
>
>

