Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDB8C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C291F20C56
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9mMinZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C291F20C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD4HM-00057L-PX
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kD4Gb-0004Bo-5X; Tue, 01 Sep 2020 07:15:57 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:33731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kD4GZ-0006On-40; Tue, 01 Sep 2020 07:15:56 -0400
Received: by mail-oo1-xc43.google.com with SMTP id m25so198104oou.0;
 Tue, 01 Sep 2020 04:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GdgaIWJTdxDEGcgYK0aIsqUwGAVcNEhafo2FIe8vbzI=;
 b=c9mMinZqSKBXGKHtWXV6SMsbDpD9S63XX4uDGbKuPBLIHpo5a5iVNOtItdXReOhXez
 5tvSI4hdbpou961a8FhhVqAy517wprjCN02ny+JOvWIueFm2A6geEqgiHfMQyfBMk0R4
 GjYdAIFh8kFnDT8UQVabwI8dKRdDiNXvjduxJ+ye31LuTP3/5F5EADZiF9OVdDe1u3tX
 7/NBM2YwCxB3wZGuj+CfKRnpI0u6sEapj+G17GqdCqDXE2USpnLQ6i+PEIJK4iE2GRzl
 5jG7AndotLkoBPphkgVTsNoFvdJ88DvV8atfRM+lMn1t/kmqp3Nz/urJ8wCqvScVHOUr
 cDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GdgaIWJTdxDEGcgYK0aIsqUwGAVcNEhafo2FIe8vbzI=;
 b=TMK3hM/63ChaVaiyicM6g9sd9l1GOjvnNs7YOODxkqQ5TDay54lgwfeNuKc5LCmoxX
 QjW0zqwkzA5m/p9DMa+bFP+vaQP+RHFp9vu51Fg43AHwzK4EtxaGwMtJZ5farPNqkKHN
 VrhGeNXcCvhxRMOIQXwamPNpBiM0UptWcXadn70ajTaThaQwLkvrelOJQUQdprD5JbJz
 8uuwIY5AKXbwi55uwFiJpnaHmXPcfIwagOvDXkyoh7d/8OxQSfhaWjwSw9czUbD5i0ou
 3HMjAcwTeNux6y7zW5LXJ3xkgI73RyUOaFFuaziGMD0AxhWgbxu3b3ZVMuan0DlXY+gK
 14uA==
X-Gm-Message-State: AOAM533idh9vxlodX0VuAYnDbkwJ/lz/CbX7IA8N5/bPdd3wWHhatNAc
 ip5ZWABY76pngvU8axJM0v37bVvgLNmsNmWDYhI=
X-Google-Smtp-Source: ABdhPJzNMsKRF3dKW/mbN/4vMCK7o8OwfC1GBTrOfaOHDi6g9O3CrMAAC6qb5WBM2joESShZJr21TEbnSnZLt5UxOT4=
X-Received: by 2002:a4a:c587:: with SMTP id x7mr878027oop.60.1598958952683;
 Tue, 01 Sep 2020 04:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200831134315.1221-1-pannengyuan@huawei.com>
 <20200831134315.1221-10-pannengyuan@huawei.com>
In-Reply-To: <20200831134315.1221-10-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 1 Sep 2020 19:15:16 +0800
Message-ID: <CAKXe6S+H4vHwJnLD0Gw7R7ioE4qN6xnncf4ffaGjz=3DrEk0ag@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] block/file-posix: fix a possible undefined
 behavior
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc43.google.com
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
 Qemu Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8831=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:21=E5=86=99=E9=81=93=EF=BC=9A
>
> local_err is not initialized to NULL, it will cause a assert error as bel=
ow:
> qemu/util/error.c:59: error_setv: Assertion `*errp =3D=3D NULL' failed.
>
> Fixes: c6447510690
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Aarushi Mehta <mehta.aaru20@gmail.com>
> Cc: qemu-block@nongnu.org
> ---
> - V2: no changes in v2.
> ---
>  block/file-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 9a00d4190a..697a7d9eea 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2113,7 +2113,7 @@ static void raw_aio_attach_aio_context(BlockDriverS=
tate *bs,
>  #endif
>  #ifdef CONFIG_LINUX_IO_URING
>      if (s->use_linux_io_uring) {
> -        Error *local_err;
> +        Error *local_err =3D NULL;
>          if (!aio_setup_linux_io_uring(new_context, &local_err)) {
>              error_reportf_err(local_err, "Unable to use linux io_uring, =
"
>                                           "falling back to thread pool: "=
);
> --
> 2.18.2
>
>

