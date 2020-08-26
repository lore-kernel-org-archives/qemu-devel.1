Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD7BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BB120786
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJfP5Ri5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BB120786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAssS-0002Fu-6W
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAsrs-0001oz-Pr; Wed, 26 Aug 2020 06:41:24 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:34419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAsrq-0000CZ-N6; Wed, 26 Aug 2020 06:41:24 -0400
Received: by mail-oo1-xc44.google.com with SMTP id k63so338406oob.1;
 Wed, 26 Aug 2020 03:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=upM97SJQbwCuvQMUzfxNZ0O+JU2pwrA3TFF9lX5Un20=;
 b=vJfP5Ri5NIJ4KVm7Nadi5XqJycYUpVTDEUlQmoRXF1OjbGhj38jiAGweb9OJE5I5sk
 wheSymyTxdOMlMhidGjyXo2AdT9X4KfVoEk8Hga1b8WtvLtfdglipdhX8RzBs+qAsbnn
 GeUeHFw+zFTX4CyVUB4l2zpHpHQW7PCJ7in4+Ve99I9MdD1SJM+mQBGvjVOKH1XWezhK
 sRryb82S3x40yIR4PrNBZP8Pcco+x8ZjDpxxPJIs/Kgt4hUxE6AsBtc6ATG38kEEDEXk
 tW6RjOsndrCEJJMSWZB+EPldWLNVnTk7Mcdhopl61PV9ujP00urUjkFhG1pQL3FKvExk
 7vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=upM97SJQbwCuvQMUzfxNZ0O+JU2pwrA3TFF9lX5Un20=;
 b=QUPau/Aog7uf1w/0cp84H35Yn3Rd1xar7rJSLyiGIKgbsoz4fm/bKs9BLCLAeV8FRH
 COmG6em3+rJjs4JsZyc+tMMK98+e2IL8YRZmYh6++CCK3rAb4B9o7rGYGGInjCD/vdcl
 DyA9FlyqjOWJYc1gJ70oOpANImhsB7JeGuzZAg4ZyOQudmoRmaoW+epD3MdLmDXPr2hX
 Fz9GWXkntNwNUTWXEy6DFE0Ng4ym9olqp3oLZszaBt4+biD6KZqGD4Z/+s8kB7V6n3gh
 C2ZRJFAKhBlrfmeHyJ1RK93/FUycth73YjEegn+rsZ3uQQOfBOPMGlWm1KXlo8YrJ+dr
 iA1g==
X-Gm-Message-State: AOAM530FGohta4LXT/uPJ8VRPzaxw12RljqQiQLnTBi6CBaCbN8oOkXO
 XrfZnO/zg+b6B28eFwnUR71IBQUvbYd5bklUptI=
X-Google-Smtp-Source: ABdhPJzmltxZdBtdykeHvI0dlGvcIrEQj6tLEYlwAmOrW5UZADl2miKN9eNqRtdDsEw43xq2JndL9x/0zTFzTJJTCDs=
X-Received: by 2002:a4a:be0c:: with SMTP id l12mr10135401oop.22.1598438480838; 
 Wed, 26 Aug 2020 03:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-11-pannengyuan@huawei.com>
In-Reply-To: <20200814160241.7915-11-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 18:40:45 +0800
Message-ID: <CAKXe6SKkSibTVtRQsD79Ruwrmg+=gcgPpyT-V3qx+o8SjHAXtw@mail.gmail.com>
Subject: Re: [PATCH 10/12] block/file-posix: fix a possible undefined behavior
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc44.google.com
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

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:32=E5=86=99=E9=81=93=EF=BC=9A
>
> local_err is not initialized to NULL, it will cause a assert error as bel=
ow:
> qemu/util/error.c:59: error_setv: Assertion `*errp =3D=3D NULL' failed.
>
> Fixes: c6447510690
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Aarushi Mehta <mehta.aaru20@gmail.com>
> Cc: qemu-block@nongnu.org
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

