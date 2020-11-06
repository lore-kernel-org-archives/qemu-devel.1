Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C004FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F108E206A4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RerSaBBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F108E206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb2Hi-0004B1-8z
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 09:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kb2GG-0002qQ-Ut
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:58:40 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kb2GF-0002mz-7a
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:58:40 -0500
Received: by mail-io1-xd43.google.com with SMTP id m9so1527010iox.10
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 05:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wImSXZg528umXKWV8iWb3tOZ1CJF+0+nBRwHJ18ii/4=;
 b=RerSaBBnX0pVeN9H9+I09Q+OtolkUAEesW5EkNa+PW4T0vABkQn/Rgj7gbg2zsnjBF
 Z2y3Wn8Oi/JGU9Cw8eUcbr91GnTvN3iRr3fA6fMluEuiNgwveUDmqUSQxcjhkrR7bN7J
 E7uHjX2K95iNH7ax2Ymkzhz0JNkw7zcZLl+ZbmkE3z0CjXQyEGZ2hZBVVVXj/xPQiwCE
 fxh3Ps0CJFzeY5I504T0tS9Dkie82yBpBUiOoO0Lg14Hq+RzCo7e4ohzAFz0GgBUKOMr
 wwb2eaDxHbux9AvWqs6CaLELs7IblrGLeWeHROeArhlpbCUoTMLEDjbgheZf9KRfPGwq
 YMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wImSXZg528umXKWV8iWb3tOZ1CJF+0+nBRwHJ18ii/4=;
 b=fXR55BBWmXf+oNCBIbqWvdkbPxosEXNX9gALITu0beC5G7bQ2iPrcLd6TQ0tADlBna
 TtYqLc4fL37ChQS0LbCyE/ggdBur+VDNLJkOhfdLqLD6Gzf+UlDxwWpa2/nduXRsOsfd
 82g91JXEcz1gJRnNQk5Aj3VjTAXNPy/68hXeloxlB82emfIHnJ2g9NuZCpjdhkUrGj2o
 Da4s7cOSyDDaAyX5EYTmNusSpPVZTV3hvBCRYFtdC013+ME0Tscfl6df85Dlm89jKqxF
 ilGAIvRPlU1/sMRjesl3YdldI3aPwq46W8z43t0QPcjXh7tc1mje3AAmym6jfiaXsIVv
 A6EA==
X-Gm-Message-State: AOAM533V3Hxvy+UQuR4dlcKD1cf5iioVoTUZBVaV5+dQJjMygShqNtM+
 JfZJEDndVKQXS0rrtHJvKMP3r2nq2FhOpBs76P5x5GYG
X-Google-Smtp-Source: ABdhPJyz0pgc/Q8sAzyTbJmzORx3pjNTR42WcY0GFxiPEI0IPq+RlPilA7d0SeCiOHoz9VygKXJVMg3ml/+1g5kk4W4=
X-Received: by 2002:a6b:9089:: with SMTP id s131mr1549598iod.36.1604671116790; 
 Fri, 06 Nov 2020 05:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20201022111302.8105-1-pankaj.gupta.linux@gmail.com>
In-Reply-To: <20201022111302.8105-1-pankaj.gupta.linux@gmail.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Fri, 6 Nov 2020 14:58:25 +0100
Message-ID: <CAM9Jb+izw67vqXQ-tOCuNugJeBUREopYuh0XHw5QZvKXP278fw@mail.gmail.com>
Subject: Re: [PATCH] physmem: improve ram size error messages
To: Qemu Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Li Zhang <li.zhang@cloud.ionos.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

>  Ram size mismatch condition logs below message.
>
>    "Length mismatch: pc.ram: 0x80000000 in != 0x180000000: Invalid argument"
>
>  This patch improves the readability of error messages.
>  Removed the superflous "in" and changed "Length" to "Size".
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Reported-by: Li Zhang <li.zhang@cloud.ionos.com>
> ---
>  softmmu/physmem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index e319fb2a1e..8da184f4a6 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -1756,15 +1756,15 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>
>      if (!(block->flags & RAM_RESIZEABLE)) {
>          error_setg_errno(errp, EINVAL,
> -                         "Length mismatch: %s: 0x" RAM_ADDR_FMT
> -                         " in != 0x" RAM_ADDR_FMT, block->idstr,
> +                         "Size mismatch: %s: 0x" RAM_ADDR_FMT
> +                         " != 0x" RAM_ADDR_FMT, block->idstr,
>                           newsize, block->used_length);
>          return -EINVAL;
>      }
>
>      if (block->max_length < newsize) {
>          error_setg_errno(errp, EINVAL,
> -                         "Length too large: %s: 0x" RAM_ADDR_FMT
> +                         "Size too large: %s: 0x" RAM_ADDR_FMT
>                           " > 0x" RAM_ADDR_FMT, block->idstr,
>                           newsize, block->max_length);
>          return -EINVAL;
> --
> 2.20.1
>

