Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28B6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 01:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A8A206D4
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 01:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXB02dAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A8A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRQcA-0005DZ-Al
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 21:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kRQbF-0004Se-9l; Sat, 10 Oct 2020 21:56:37 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kRQbD-0004Sh-J7; Sat, 10 Oct 2020 21:56:36 -0400
Received: by mail-ot1-x342.google.com with SMTP id q21so12584570ota.8;
 Sat, 10 Oct 2020 18:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iafPvEnAsyoEe4Ey2SSoAVShKbsoVPNle8hYe14TBV4=;
 b=OXB02dAdZIBTl+KrKmhVSLISLfzH0o8fLIIa7ThYZzQGNC9BPHZKkJS9tOEheZlZhn
 Nk3ZKSC+p881FErg8g3GlehIDx71JaPhZupjhx5TKJN/gHrEkxjboqnySgo/ee7FiaJJ
 A5qQ8+QARSc2n6dxE7fEvcCNvIqIECxzj6bdH3lCBoIKMHLYQN9YAcsU1hPyLAzjzmOI
 5QzJLSddWFSaX3Col5amAfm40K6Ysc7ZU7ozsrn/lRSgwo/AtSLwCUUo7PA/LZyXF0Os
 Ci7gkTmi1aSZ8Cv43ByhUMrqQ768C0JtxNyomAcmd5H9GgFYYxM8DuytCdxCFkhUkZws
 257A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iafPvEnAsyoEe4Ey2SSoAVShKbsoVPNle8hYe14TBV4=;
 b=JueJJ33jUeOcFAvsSzYuyUOgBybHbiTPopHadpp5FIiWzOcCjODR6/jmdpirC2gB7Q
 8GxQK4T5eDnCjFK9r8vUX2QOZFauMAyKHRAJquNZsKU6VkEFTjNKYfQhozPL8vzHal0a
 cvF+qFX9OXsmA31p/SC0yPPBgF5NJ7NeQbH5Rs6TL+ovlmObqAt8uCt8Nzdy5/JyYpaG
 +Wiapk7CJ+X+nnGM1ADlv6WNQ7KVeS3PcmFVH4kLz+VqMbwwXnPuwzq0FLJzUBUBXs6W
 Y8fbDWDgAMBxFDj2JxM7krbIIot3CxuvPdlijMlNWoJ8aZIKzmpVOAj+mKiavel+Xepf
 U5oQ==
X-Gm-Message-State: AOAM533Rbft2tOf8zeZMQwnErIqd0AluPFiRgHmqfyjRJIzpaISWdBAK
 mFScdG4VDB1UpkccRrAE92pk/e6oseNot6PEfcU=
X-Google-Smtp-Source: ABdhPJxkVrr/7++zNogbmBXafpoSSBO5maPk7oU2TXT65H3qOdsLZRPavxdebY1sDpMId4gfYGSGcOAHT0X6CzjxUwo=
X-Received: by 2002:a9d:1a2:: with SMTP id e31mr10721565ote.181.1602381393235; 
 Sat, 10 Oct 2020 18:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201010110730.1575180-1-kuhn.chenqun@huawei.com>
In-Reply-To: <20201010110730.1575180-1-kuhn.chenqun@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 11 Oct 2020 09:55:57 +0800
Message-ID: <CAKXe6SJWZ+ek-MefzJzDH=H=N90B67i5pV7CybA2maYq9Euk5w@mail.gmail.com>
Subject: Re: [PATCH] migration/block-dirty-bitmap: fix uninitialized variable
 warning
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x342.google.com
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
Cc: Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chen Qun <kuhn.chenqun@huawei.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=8810=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=887:08=E5=86=99=E9=81=93=EF=BC=9A
>
> This if statement judgment is redundant and it will cause a warning:
>
> migration/block-dirty-bitmap.c:1090:13: warning: =E2=80=98bitmap_name=E2=
=80=99 may be used
>  uninitialized in this function [-Wmaybe-uninitialized]
>              g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name=
));
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  migration/block-dirty-bitmap.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
> index 5bef793ac0..e09ea4f22b 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -1084,9 +1084,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DB=
MLoadState *s,
>              } else {
>                  bitmap_name =3D s->bitmap_alias;
>              }
> -        }
>
> -        if (!s->cancelled) {
>              g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name=
));
>              s->bitmap =3D bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
>
> --
> 2.23.0
>
>

