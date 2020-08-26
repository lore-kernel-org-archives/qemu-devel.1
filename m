Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7B7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34DC2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdrbL/M7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34DC2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsbc-0004oI-33
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAsb4-0004FR-6N; Wed, 26 Aug 2020 06:24:02 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:35056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAsb2-00060u-CU; Wed, 26 Aug 2020 06:24:01 -0400
Received: by mail-il1-x144.google.com with SMTP id q14so1307191ilm.2;
 Wed, 26 Aug 2020 03:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PB8IdSQthDFHnfSEt9ULBNmBbLStF5rUjYOe2duw9AU=;
 b=vdrbL/M7QRSEk0/T68EkVB4E3yBKBav2YNP7BeBxEhJbqbrzjxCfD8iDQJuJOCRxzU
 fQXmO1JcNcaXShuRXNZ9kBXpN4aZC5cG9E/w/OoJGNw3/QdjpfPtekP85pzyyNn2Fh53
 gtGKNHpUIifoUs9Ms6Cm+NqyAKxyVuCn7k/XNfxtC4lQpxvVbvSFIMRROgHKha6MFIGQ
 vEYfgH5y6fjnM4s518ftuDK/DYut8Z/rK0e7wGkOYiB3Jg7wCxDDb5HgtulW8r9IE02K
 RkVjvL7lO3iG+ZiIoPdOUcxNbkoRY51RM8YXc+Eu4kmUkLGKcAYW18NJhp6ENaw/oNhz
 VUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PB8IdSQthDFHnfSEt9ULBNmBbLStF5rUjYOe2duw9AU=;
 b=A/5rYSihgeaXqx5/Uzg4j9Bs/BRE2bXzTyJQepusPp2vT8f56bD7M6M2Mc59H29jCR
 o1cZoRjifNJBlUo1eqsvJjLem8xdtOI2kCMGQcaRzk9B1ivTplCHaNLTcXqO2xBjcYPn
 rEOG09PkzwkGhEUA8MYZPNcxYsvj7tMmQ1ugQQ7kjRpCIrgksEB7VERwch2H7kIElIDa
 V5YxznJFIOJZ/xnkVERzo3+HMcv4EpuFnTCA8tBHlsmwW1b+Gn8G2G9+mcyg5grWzrC/
 dKaUc9XOq7B1EeqYJ604tPyws0SDReBKRvVW3t2MrZHjHX7flQa3g3ySvLFYYT8ErhNM
 YuRw==
X-Gm-Message-State: AOAM530ah4iYQbuE8hwN5FLT+Anfp71sovoyVzeisy6YMnFhxghsEPGT
 cvpdKeCMr0NbTqSN6Zh66Rn4XHAFcukjBAAnO5M=
X-Google-Smtp-Source: ABdhPJweCfoT7jw2qjL5pTWWTai3b9P6iqkni/Z8q7NgisOtArLvOiTLAwkBOHRrKZIfUIe5X67Q0C5xB37ruQupGW0=
X-Received: by 2002:a92:6901:: with SMTP id e1mr12597012ilc.209.1598437438960; 
 Wed, 26 Aug 2020 03:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-6-kuhn.chenqun@huawei.com>
In-Reply-To: <20200825112447.126308-6-kuhn.chenqun@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 18:23:23 +0800
Message-ID: <CAKXe6SKE_8GedHJEejDzx4L2ViT2kdZCo-uiuRdFh9+3AD_EOQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] hw/virtio/vhost-user:Remove dead assignment in
 scrub_shadow_regions()
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=liq3ea@gmail.com; helo=mail-il1-x144.google.com
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Pan Nengyuan <pannengyuan@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chen Qun <kuhn.chenqun@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Clang static code analyzer show warning:
> hw/virtio/vhost-user.c:606:9: warning: Value stored to 'mr' is never read
>         mr =3D vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
>         ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index d7e2423762..9c5b4f7fbc 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -603,7 +603,7 @@ static void scrub_shadow_regions(struct vhost_dev *de=
v,
>       */
>      for (i =3D 0; i < dev->mem->nregions; i++) {
>          reg =3D &dev->mem->regions[i];
> -        mr =3D vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd)=
;
> +        vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
>          if (fd > 0) {
>              ++fd_num;
>          }
> --
> 2.23.0
>
>

