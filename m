Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6406BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CC72080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuvjjfXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CC72080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5uy-0006nt-Jr
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kF5uE-0006Hb-V9
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 21:25:14 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kF5uD-00046f-E9
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 21:25:14 -0400
Received: by mail-ot1-x344.google.com with SMTP id y5so11029290otg.5
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 18:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=G+/byO/rwjw+1AMn9WDq+T3mT7mjzQjlnZ7p8uDM1p0=;
 b=RuvjjfXU0t4f10aCA9eh4VfLaAbveFPrOEZrFsxXgF8NBroJxprFU2nN4NxOn/r0g/
 5WYRONmbF9bszoOg8TzesIGFe63y5RF39V99VTKC/8RtcSGr6b9wp/W9M+3ZYLegVNZ6
 9LBARcR1qPzB43vWvd2qfV2Ml7jNqCFbTBrnVWK5Fk2+VN6VLz6wQTBjvBzs9T8DmwvG
 rUmhvTanrJvDR+VMeTYV6wGqx+Bis0WY3BZfHwA6UvyYDv7bQ6CnvEi1UA7XFNFXSHPR
 hJ4Nrd/+LOa17wZ0nlzDdSr73bEB3hNSVAFegL+/kgL+G9zB2s7phmEznhd8CtbuBeF6
 ycSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=G+/byO/rwjw+1AMn9WDq+T3mT7mjzQjlnZ7p8uDM1p0=;
 b=X2jaz7j3Q/1Bt9GPjCX4bwC9eAG56kfU04o4U3ceuZyKyKurrdP39owllT5o6glaUe
 1DEfDZe3/GQ7g68rGESVN97zdMDFjQLTFFrVtRl2qQN5Afl3Ykec9Z8b90RYelHzaWT/
 EYvLbEibCUkSGCPHxp5VbKunl+i2xSqOeHegBunSHGOgbbLDWhLMqGj1N2ZNkdWy3/6H
 OkvIWRNWRJjZG++EF4H91lX/7tM5gze5L/t6D9mptwn6I3HRBP4F0IzrVObU5CUdjd5n
 b7XXVzj6/7z5L+vqqX9CnQfpcKadcwM8/cEgzcEXK6aRNqaA+PFxLKzzuhLrDoT+75R3
 oJng==
X-Gm-Message-State: AOAM531clI9Qa52cM+lBAj6woqUdsJLqxuoNxigXzJdIaEFKpPZrEddf
 9cL/zYO30QFDTIgbcKE3xTJrpAIc/do61tzZyPo=
X-Google-Smtp-Source: ABdhPJzsZARNZ065lSWfsMAS2LE5kVStLzMt/zwR85zsAdHhipEpkAqBSjKJgetjJ/HN2OrjaTq8cq70D01n7VtSU+w=
X-Received: by 2002:a05:6830:2302:: with SMTP id
 u2mr12488172ote.181.1599441912249; 
 Sun, 06 Sep 2020 18:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <5F463659.8080101@huawei.com>
In-Reply-To: <5F463659.8080101@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 7 Sep 2020 09:24:36 +0800
Message-ID: <CAKXe6SKjq_0=WRwCVA-AnH21Zw=qPYP85Wh_2NUSzawzJSNp9A@mail.gmail.com>
Subject: Re: elf2dmp: Fix memory leak on main() error paths
To: AlexChen <alex.chen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x344.google.com
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
Cc: zhengchuan@huawei.com, Qemu Developers <qemu-devel@nongnu.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

AlexChen <alex.chen@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:16=E5=86=99=E9=81=93=EF=BC=9A
>
> From: AlexChen <alex.chen@huawei.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

>
> The 'kdgb' is allocating memory in get_kdbg(), but it is not freed
> in both fill_header() and fill_context() failed branches, fix it.
>
> Signed-off-by: AlexChen <alex.chen@huawei.com>
> ---
>  contrib/elf2dmp/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index 9a2dbc2902..ac746e49e0 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -568,12 +568,12 @@ int main(int argc, char *argv[])
>      if (fill_header(&header, &ps, &vs, KdDebuggerDataBlock, kdbg,
>              KdVersionBlock, qemu_elf.state_nr)) {
>          err =3D 1;
> -        goto out_pdb;
> +        goto out_kdbg;
>      }
>
>      if (fill_context(kdbg, &vs, &qemu_elf)) {
>          err =3D 1;
> -        goto out_pdb;
> +        goto out_kdbg;
>      }
>
>      if (write_dump(&ps, &header, argv[2])) {
> --
> 2.19.1
>
>

