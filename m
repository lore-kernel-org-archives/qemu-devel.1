Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82791C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114822085B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZXy2bxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114822085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW7ck-0001Jp-3s
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 20:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7bX-0000ku-Rg
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 20:40:19 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7bV-0001zd-SD
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 20:40:19 -0400
Received: by mail-io1-xd41.google.com with SMTP id r9so4079113ioo.7
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 17:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ICX1Xp+EaI63Qd1mVmI8zHsHirwka3xr1/asFy0com8=;
 b=BZXy2bxWM0fZMOnb168E7JUEKlQWmiKspGfqmrkAJqSI6P5ITAdSTsygeSVschSOnW
 xGBD4CgVLgIq/minY8N/RK+v+WYhfOhjW0S2QWVshkNtFduqO2IZdz69dnoYuGJmHxLj
 xJvA1ZnptRbXjkngbtTr+RbivNtthAKMtR6dCTWerax6QzGPAVIUf76eVaXHgy+yfdXG
 3uwZufkR7Fn4ild4Mp8XZ04/kSmppJdsbcPLB7e5bZZYWB10XNB9KlKwvSIagcrJMU7y
 vbbw02ZDsXJ59BlyMZY0rkFP2QsjCkCSBX6pS5SmI9Q0YZT9bGq9SO5xmx4z6lBkS/5h
 /WyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ICX1Xp+EaI63Qd1mVmI8zHsHirwka3xr1/asFy0com8=;
 b=AaeKqdKuPWsCWNbLNYutumPRmImMjtYq4jMVuz/saL5xcOwAyS12dx7ZJHXsIe78pv
 Hw93qeOkkE9ABrA1C59aT+aTHfY1yVdE4QGwqLdx6HgWUXz+amh+qOB1+jXOdtxOFfAf
 Je10pjGu60jZ4e08GBIGPXVo5nGaNVulM76r5Ab16gS86tygP/KRrC6Wq/tFfyTSmt0u
 U0EMDUUhrnu0wKGNgyHjaNGD3JuFCeYb+ms+0I2iTLQcBfv8GjaQdsVEER4DAsO21OwP
 tBv76nmvSNiV6kIU2p//2Bkjf9pJMWYHA64+p0WVNNHV8Z2rYkmCYV+KVt6uFhGkfg9R
 +BfQ==
X-Gm-Message-State: AOAM531S1Z043FIQ8V1eEvyoujh06eOa/uzrYmL8dxiBY0voch7VtP4k
 LXWRSpGCW4iVNd/Qo4ummbK8culMjrXbhij2U5U=
X-Google-Smtp-Source: ABdhPJwZ/WrXfiodwznHof8SjW1Sj6UhCYOsTqszquT9VED6HFMmuaxRoyVw7q2X4wdwroVu88FMi8jTWao/gS6U34M=
X-Received: by 2002:a02:c956:: with SMTP id u22mr3940621jao.135.1603500016720; 
 Fri, 23 Oct 2020 17:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201021170842.25762-1-alex.bennee@linaro.org>
 <20201021170842.25762-4-alex.bennee@linaro.org>
In-Reply-To: <20201021170842.25762-4-alex.bennee@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 17:28:29 -0700
Message-ID: <CAKmqyKMcUYDnZhYbP22T+dr+0RAmKMdHqW09HsG+hAfgeBgG4Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] device_tree: add qemu_fdt_setprop_string_array
 helper
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
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
Cc: julien@xen.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 stratos-dev@op-lists.linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, stefano.stabellini@xilinx.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 21, 2020 at 10:11 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> A string array in device tree is simply a series of \0 terminated
> strings next to each other. As libfdt doesn't support that directly
> we need to build it ourselves.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/sysemu/device_tree.h | 17 +++++++++++++++++
>  softmmu/device_tree.c        | 26 ++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
> index 982c89345f..8a2fe55622 100644
> --- a/include/sysemu/device_tree.h
> +++ b/include/sysemu/device_tree.h
> @@ -70,6 +70,23 @@ int qemu_fdt_setprop_u64(void *fdt, const char *node_p=
ath,
>                           const char *property, uint64_t val);
>  int qemu_fdt_setprop_string(void *fdt, const char *node_path,
>                              const char *property, const char *string);
> +
> +/**
> + * qemu_fdt_setprop_string_array: set a string array property
> + *
> + * @fdt: pointer to the dt blob
> + * @name: node name
> + * @prop: property array
> + * @array: pointer to an array of string pointers
> + * @len: length of array
> + *
> + * assigns a string array to a property. This function converts and
> + * array of strings to a sequential string with \0 separators before
> + * setting the property.
> + */
> +int qemu_fdt_setprop_string_array(void *fdt, const char *node_path,
> +                                  const char *prop, char **array, int le=
n);
> +
>  int qemu_fdt_setprop_phandle(void *fdt, const char *node_path,
>                               const char *property,
>                               const char *target_node_path);
> diff --git a/softmmu/device_tree.c b/softmmu/device_tree.c
> index b335dae707..a19873316a 100644
> --- a/softmmu/device_tree.c
> +++ b/softmmu/device_tree.c
> @@ -21,6 +21,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
>  #include "qemu/bswap.h"
> +#include "qemu/cutils.h"
>  #include "sysemu/device_tree.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/loader.h"
> @@ -397,6 +398,31 @@ int qemu_fdt_setprop_string(void *fdt, const char *n=
ode_path,
>      return r;
>  }
>
> +/*
> + * libfdt doesn't allow us to add string arrays directly but they are
> + * test a series of null terminated strings with a length. We build
> + * the string up here so we can calculate the final length.
> + */
> +int qemu_fdt_setprop_string_array(void *fdt, const char *node_path, cons=
t char *prop,
> +                                  char **array, int len)
> +{
> +    int ret, i, total_len =3D 0;
> +    char *str, *p;
> +    for (i =3D 0; i < len; i++) {
> +        total_len +=3D strlen(array[i]) + 1;
> +    }
> +    p =3D str =3D g_malloc0(total_len);
> +    for (i =3D 0; i < len; i++) {
> +        int len =3D strlen(array[i]) + 1;
> +        pstrcpy(p, len, array[i]);
> +        p +=3D len;
> +    }
> +
> +    ret =3D qemu_fdt_setprop(fdt, node_path, prop, str, total_len);
> +    g_free(str);
> +    return ret;
> +}
> +
>  const void *qemu_fdt_getprop(void *fdt, const char *node_path,
>                               const char *property, int *lenp, Error **er=
rp)
>  {
> --
> 2.20.1
>
>

