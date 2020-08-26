Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2282C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8DE206EB
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAbB+pkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8DE206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsws-0003m1-3z
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAswD-0003MP-Pq; Wed, 26 Aug 2020 06:45:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAswC-0000fG-2h; Wed, 26 Aug 2020 06:45:53 -0400
Received: by mail-ot1-x341.google.com with SMTP id x24so1114077otp.3;
 Wed, 26 Aug 2020 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RbBNFzMDvZyUhev22A3E/Ny9cl0aKsDYPUNoEzutE5g=;
 b=KAbB+pkt6Y/JqkNiTGyysu48Haxrga+zWiKC1ze49E4apeKrTcg1ttjqSwS3ECivIi
 uO8dPEcJVqOmeI2NAjDxZsl898itxxvE2ONV+o4ht9I1gsdtQgf4O5pSgrcc7HCOwnJK
 IHAltV9Zt9cVxoWToCZedc3ri53NMe7GFGw8fi6ly+5CaXai9T6Ad5SQ67FOu+6Q/5J4
 qHaq49lKd2dPudTUCX9YhnUG95OI/4giFoD/4SCIUOJ1lPVaHtjr6Axlliu3T2aoUPve
 mrjiYT18AVaXGVhtzTyhsAz66nwEBkkgpEod60YPlQr/vK7rkslbUwj1xOAGBCnAj2qI
 vzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RbBNFzMDvZyUhev22A3E/Ny9cl0aKsDYPUNoEzutE5g=;
 b=PO2AWxUvO4M+naxRHIZ7ZkoSJIPFdLgWRIqHr6WPUvhi/87T+a/Hvzpsmf84lM4uEQ
 N8jbqtBg3rJFxdX+qSdrAXak7F4MiI4bL6Y/XgEpFI8gipUbILNWNX3yzvsPDZcHMCXf
 YjpokzMzS+OW9/akZRXHCP8OfYvzyEnGxa2UgllYyTaf1Iznz31syU1fHbMjpa1Z7+Ww
 nQgt8kvJ+Fk6GmFKYY1beAhIw7MwCqQ1DR+cWHSbBVFukupU1DRFWSS5M7Ra7vp+TKrg
 wfTUnQj4pkwR6St+HapvzA0xD3hsBMDMzr0dwfWgb9golwELY67LJ2yzGC0I1EoLwgwP
 kWEQ==
X-Gm-Message-State: AOAM531XrfwIghpe3UxuRNe+8wad6buysBnVTCtJibO82miPT7Lj5ynf
 9h3rLoJpnoPZUnq+NCZo2pIXysdZaqY7nn2Di3U=
X-Google-Smtp-Source: ABdhPJyVU5WGhwmN3GbXsvCX9wsUitzAlJalKb8tDYwXewpIqe6UXTEAf6amAOi6I8ErsVH+3wCr5Nh6Jld4JQYHnHY=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr6852886otn.333.1598438750565; 
 Wed, 26 Aug 2020 03:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-10-pannengyuan@huawei.com>
In-Reply-To: <20200814160241.7915-10-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 18:45:14 +0800
Message-ID: <CAKXe6SJFn7ZRSRk+e8V+QkVQK_6Oostr2m4RhMgYw1dxiMTFrA@mail.gmail.com>
Subject: Re: [PATCH 09/12] blockdev: Fix a memleak in drive_backup_prepare()
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-block@nongnu.org,
 Qemu Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:54=E5=86=99=E9=81=93=EF=BC=9A
>
> 'local_err' seems forgot to propagate in error path, it'll cause
> a memleak. Fix it.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: qemu-block@nongnu.org
> ---
>  blockdev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/blockdev.c b/blockdev.c
> index 3848a9c8ab..842ac289c1 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1801,6 +1801,7 @@ static void drive_backup_prepare(BlkActionState *co=
mmon, Error **errp)
>      if (set_backing_hd) {
>          bdrv_set_backing_hd(target_bs, source, &local_err);
>          if (local_err) {
> +            error_propagate(errp, local_err);
>              goto unref;
>          }
>      }
> --
> 2.18.2
>
>

