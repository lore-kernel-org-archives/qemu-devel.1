Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0DFC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13DE21D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yB9o8pyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13DE21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeDh-0005MS-SZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZeD6-0004qG-Cx
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:05:40 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:45461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZeD4-00055T-Gi
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:05:39 -0500
Received: by mail-ed1-x52f.google.com with SMTP id dg9so15233126edb.12
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wnlnQjWTspakA6Qbnw7h5Gm4pA0lDdBf1t4gTFiaXwU=;
 b=yB9o8pyAcMOMWuElWeTXT3tR9f7tkVJwWIFmMScuKlWLs/eit7pGi7aSgZq88FZ0Pp
 PlkPrLpYt3Tr30KTb1bRwRQgSIHE/+G6eW0/jcSawLpOYwkxWhwOE3lUlPWy6tTpFSDk
 qR5/SFTSR+uDc+0kphGaBdB+BrbAdM+ZQZnNXWGtOqNPf0xYUO/prvJQ3m3dcfqfKHmq
 UHbJaJsE0o7YwAP32beYhvIQO3vG6aQt/i1ZOsD27huFIuwv/FaS/G+eTOUsem5eS9fO
 GfAY3dfvlnj/BZq0owpf8rOhyJeIpp0U/JhJfdOGfPUN/2X02U/Hy94WhH7R2RIVftm7
 u/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wnlnQjWTspakA6Qbnw7h5Gm4pA0lDdBf1t4gTFiaXwU=;
 b=ZGyvxv8TmExhMftSIYKySTkTG6btG1cy6x/ARhN0GqK1czRNEV1mtsgcBFYi0YwiHR
 qQ+LCw1lxGwb1CJNXj82GE0hwU+LW7SwBtsmZpk8vXW3XcoaTVIITsW9wC26idBaSEUF
 bqY+fz0INVLRkKlMaZhGzJ8/H/lYso5ws7AsU/YG4auWte9fjP0MptQO4UuKNymxvFJ2
 TjU83Hy2uXMGxHA1rWFx6GFIi251lM6+HH3eeQVMUa5+Iy4hyaGY4hugliBayhY3OU2T
 rI9+IgJkkUvJi/wu/DBkKcUI2D+7jKHdlQWB6c4LKuaCLvELJtpOTGKh3xJzTCe0WPWV
 tqNg==
X-Gm-Message-State: AOAM533L2hZ9HBhPeDBTabRpI6tDiFrX+vGuqjU9yz+b/GHq5/n2c3sZ
 EOArJ7iYhuc367YWVrGc6xvYpKHRGT++156QlX7Oqg==
X-Google-Smtp-Source: ABdhPJxt0l3vnQAAiXhAUswZ40iBhqjXqHLAH1MZTX6/r4pxCjVucJ9kfT6UItQ79Izuot5Q2vitiUc5c3IoTZ4RRxU=
X-Received: by 2002:aa7:d699:: with SMTP id d25mr17405027edr.44.1604340336718; 
 Mon, 02 Nov 2020 10:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20200924092314.1722645-1-pbonzini@redhat.com>
 <20200924092314.1722645-43-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-43-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 18:05:25 +0000
Message-ID: <CAFEAcA_uk5VOeEQNyU9R-1kF9UE-MFpaC+2WMvbRXcwxYNa5xQ@mail.gmail.com>
Subject: Re: [PULL 42/92] cutils: introduce get_relocated_path
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Sep 2020 at 10:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Add the function that will compute a relocated version of the
> directories in CONFIG_QEMU_*DIR and CONFIG_QEMU_*PATH.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi; Coverity (CID 1432882) points out a bug in this code:

>  include/qemu/cutils.h | 12 +++++++++
>  meson.build           |  4 +--
>  util/cutils.c         | 61 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+), 2 deletions(-)
>
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index eb59852dfd..3a86ec0321 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -184,4 +184,16 @@ int uleb128_decode_small(const uint8_t *in, uint32_t *n);
>   */
>  int qemu_pstrcmp0(const char **str1, const char **str2);
>
> +
> +/**
> + * get_relocated_path:
> + * @dir: the directory (typically a `CONFIG_*DIR` variable) to be relocated.
> + *
> + * Returns a path for @dir that uses the directory of the running executable
> + * as the prefix.  For example, if `bindir` is `/usr/bin` and @dir is
> + * `/usr/share/qemu`, the function will append `../share/qemu` to the
> + * directory that contains the running executable and return the result.
> + */
> +char *get_relocated_path(const char *dir);

Side note -- this function makes it the caller's responsibility
to free the string it returns, but it doesn't mention that in
this documentation comment.

> +

> +char *get_relocated_path(const char *dir)
> +{
> +    size_t prefix_len = strlen(CONFIG_PREFIX);
> +    const char *bindir = CONFIG_BINDIR;
> +    const char *exec_dir = qemu_get_exec_dir();
> +    GString *result;
> +    int len_dir, len_bindir;
> +
> +    /* Fail if qemu_init_exec_dir was not called.  */
> +    assert(exec_dir[0]);
> +    if (!starts_with_prefix(dir) || !starts_with_prefix(bindir)) {
> +        return strdup(dir);

Here we return memory allocated by strdup(), which must be
freed with free()...

> +    }
> +
> +    result = g_string_new(exec_dir);

...but here we allocate and will return a string that must
be freed with g_free(), leaving our caller stuck for how
to tell the difference.

Using g_strdup() instead of strdup() is the easy fix.

thanks
-- PMM

