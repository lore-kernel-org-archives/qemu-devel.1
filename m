Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3860C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C015E21556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6U4dznS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C015E21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6X7g-0002zO-Rz
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6X6K-0001Y7-EG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6X6J-0005To-31
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:06:04 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:36707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6X6I-0005TA-TR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:06:03 -0500
Received: by mail-oi1-x232.google.com with SMTP id c16so12014231oic.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3wgkzP3gT0NkgSoIuJVlNrdgthhGYigiRR+LWKZjltc=;
 b=N6U4dznSTre+e3tToGQNnCowtb0ocKN96PcZHyf/uDHDnIAjcLMPkeQezRt6hiZdyz
 xfXe4IE59HWxGUG5YEHQ3Yrev85ofYJkNyokHrmifsi7O6xljKStharrh0XSJl1aLAWv
 +96XyM0RjQz2Ubg0CniY7cRT78IW8e4Tqmhs575ZoH1jwaF1egzMUbG1/TId657eYvPG
 mIrxQ25ZuncDwzOT2/9Pl3aLzwtI+4oSQtEvjN9safjZli+klHEd6B9C8oZngnwb6dkf
 uw/LiXQbXzmLJ1M8mMktXPOt0zODrSrJ+31Qh8DUdeosr9583iQdx98aMSMue3yjUyTf
 RY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3wgkzP3gT0NkgSoIuJVlNrdgthhGYigiRR+LWKZjltc=;
 b=Cge6n6wrcZ1Su2hyeB7+WC4FErX+4lmjqdLur6S2vf2NtZwFw7IGqLhHKDSf9UvfoK
 oSU2/D9vAzCrZZxXd18V/i4vOVvPPPqNKhgX7ht6OfV/T64kcQG639UdoywKXFIBCHTg
 B7pei2JMhn9FfYRyj7Cuel+I8/7HoQRW5GZEv+PuZXct6wW50HGswM62SvpJBs6W2rKz
 7NAVRNTx2rsQC4Zaw+PwPEKxTYbqMTLzfOLkcrmCLLzopHwHCvfrdozYzN11j0zykWYs
 +k/GhgqxlGQbAFIQ2aO8Cf9Peae0WFFEokR/Em8gwkZN4DyJwguJggcqvNkgCeeUsqFR
 JNeA==
X-Gm-Message-State: APjAAAU6yZzROhZ48YrZzBvpk+Gz0j5vWK/C9xuTJKR3M3OGfLF2qr9E
 rXHV6em8nuX2Ssf2EEk88NnkxseQH51qblxKcASZCw==
X-Google-Smtp-Source: APXvYqx+YANwDFfknZqSM6rK3kEIHyx4eDHuD88tFbAArT/CQeJ58oC19cZEKr78W+KjJ8UzpiAKyEwz19cG35GT5gM=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2806802oif.163.1582625161900; 
 Tue, 25 Feb 2020 02:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20200220160710.533297-1-mreitz@redhat.com>
 <20200220160710.533297-12-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-12-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 10:05:50 +0000
Message-ID: <CAFEAcA8YFHy9uf5WXP0qwkRkcxgC1ufOYDXQExsV8AVgU5OReQ@mail.gmail.com>
Subject: Re: [PULL 11/18] block: Generic file creation fallback
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 at 16:11, Max Reitz <mreitz@redhat.com> wrote:
>
> If a protocol driver does not support image creation, we can see whether
> maybe the file exists already.  If so, just truncating it will be
> sufficient.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Message-Id: <20200122164532.178040-3-mreitz@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Hi; Coverity thinks there's a memory leak in the error
codepaths in this function (CID 1419884): is it right?

> +static int bdrv_create_file_fallback(const char *filename, BlockDriver *drv,
> +                                     QemuOpts *opts, Error **errp)
> +{
> +    BlockBackend *blk;
> +    QDict *options = qdict_new();

We create the QDict here...

> +    int64_t size = 0;
> +    char *buf = NULL;
> +    PreallocMode prealloc;
>      Error *local_err = NULL;
>      int ret;
>
> +    size = qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
> +    buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
> +    prealloc = qapi_enum_parse(&PreallocMode_lookup, buf,
> +                               PREALLOC_MODE_OFF, &local_err);
> +    g_free(buf);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return -EINVAL;

...but here and in other error return paths we don't
free it (I think that might need a qobject_unref() but
am not sure).

> +    }
> +
> +    if (prealloc != PREALLOC_MODE_OFF) {
> +        error_setg(errp, "Unsupported preallocation mode '%s'",
> +                   PreallocMode_str(prealloc));
> +        return -ENOTSUP;
> +    }

(You could probably postpone qdict_new() to here to avoid
having to change the error handling paths above this point, but
you still need to deal with the error path for blk_new_open failing.)

> +
> +    qdict_put_str(options, "driver", drv->format_name);
> +
> +    blk = blk_new_open(filename, NULL, options,
> +                       BDRV_O_RDWR | BDRV_O_RESIZE, errp);
> +    if (!blk) {
> +        error_prepend(errp, "Protocol driver '%s' does not support image "
> +                      "creation, and opening the image failed: ",
> +                      drv->format_name);
> +        return -EINVAL;
> +    }

I guess for error-paths after blk_new_open() succeeds
that the blk object owns the options dictionary and
will deal with unreffing it for us?

> +
> +    size = create_file_fallback_truncate(blk, size, errp);
> +    if (size < 0) {
> +        ret = size;
> +        goto out;
> +    }
> +
> +    ret = create_file_fallback_zero_first_sector(blk, size, errp);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    ret = 0;
> +out:
> +    blk_unref(blk);
> +    return ret;
> +}

thanks
-- PMM

