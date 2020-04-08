Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CF9C2D0EC
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 02:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF00C206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 02:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="w5TZ9R05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF00C206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM0QZ-0004M7-76
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 22:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jM0Pd-0003Pj-6m
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 22:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengli@smartx.com>) id 1jM0Pa-0002jE-Ug
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 22:25:56 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:43708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fengli@smartx.com>) id 1jM0Pa-0002gg-KZ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 22:25:54 -0400
Received: by mail-ua1-x942.google.com with SMTP id g24so2136092uan.10
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 19:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=QUsmYknwvXS5jHeVb9UmcxW3NPCdLzru5P2I7Y4+m/g=;
 b=w5TZ9R056RxEj/G40B2VmuyYxOkGhZosFtHnZ8FyFktgqGVO/8RSxCw4Pug+HJo77X
 jXYQcnKZqtEEAwNGIffGQ0QWf1PuK+dWtszCNQW4o93oFN1YA6i4JnAbPvjuFMOj55Mg
 stn5fnZ3LyAiVLrwDD0F7MxG7/NrE1X9fL19fYDUL+eFWAbWzFVSWsWs4BzGj3or5U5N
 hTL9sPo6xA5uvVZoKyaf6hD9h3xwo052v1mOS3agllGKF10Fk0AG3UVdVIlccz+Z2LGG
 +wvWbD/DCGJAEsjQWXPNwuezPQlt7AnohzJ+lfPj+1o9MhZOXnSjwYbAiJrKEPR3mXoE
 QoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=QUsmYknwvXS5jHeVb9UmcxW3NPCdLzru5P2I7Y4+m/g=;
 b=YNz4ibbCr7Lf/GT6bsA6Tn7bWCeXjIz3ikUCGBx+4FzowE3fowGsgkXcC9dUyyxGWg
 W02FjVZjBwc9bEvpQPjvqjNcDkLzkQnDYCvDKo2a+VNL/h4NE0cu5L3H9IoBlF3L5Ut5
 NdjC4eJWnzoRlOLGLiixqbUqSDOpsEDqIB17IlZdST+aXv6ETuzH0VJGC2yDSh+2m266
 gRZeyr1IiQ/HPXODwo/aub2JCVu2mOvN8hSEOAJ0ex6nA/bCNFQGuMabYIXW3TkFx2PD
 fHQcCi6RV41dr8vYROGcfCqtzRlX5BC0ZI9AuJIl2k7V3DPqcVQjZedo8PzYyGQCIZ8I
 IX1w==
X-Gm-Message-State: AGi0PuaS7KQb+qzq6W9xD2/JLbdBV2jaGtWybUJllSgMnPMBHVgMDhqX
 pZHFAK5smO8igSkLZ3lGUavf9VI4ElDzF6rxTTLf/DGZinF525755VEbs2XAYdCd4oUiCVb8Ad2
 SGGvQC35IK/47+2ratQaGe1mj
X-Google-Smtp-Source: APiQypIxlYLBkuhSqIdesEEbo+heGgN5IuHRJ6I6rUIA7VoYzpoD2u4eNTVKPJLIgIqQ3NYd/ceQOl+ix7Ds6q/fmXw=
X-Received: by 2002:ab0:1d10:: with SMTP id j16mr3893669uak.91.1586312753231; 
 Tue, 07 Apr 2020 19:25:53 -0700 (PDT)
MIME-Version: 1.0
From: Li Feng <fengli@smartx.com>
Date: Wed, 8 Apr 2020 10:25:42 +0800
Message-ID: <CAHckoCzojVSHLAwBP2QhFx3Gw6j9DVPRwNSML9D4GQMzKr9Y3g@mail.gmail.com>
Subject: hotplug issue of vhost-user-blk
To: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 raphael.norwitz@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::942
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
Cc: Kyle Zhang <kyle@smartx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

Hotplug of vhost-user-blk doesn't not work in qemu master branch and
all previous version.

The action I insert a vhost-user-blk disk is:
(qemu) chardev-add socket,id=3Dspdk_vhost_blk2,path=3D/vhost-blk.0,reconnec=
t=3D1
(qemu) device_add
vhost-user-blk-pci,chardev=3Dspdk_vhost_blk2,id=3Dspdk_vhost_blk2,num-queue=
s=3D4

Until here, it's well.

Then I unplug it from qemu:
(qemu) device_del spdk_vhost_blk2
(qemu) chardev-remove spdk_vhost_blk2
Error: Chardev 'spdk_vhost_blk2' is busy

The related code is here:
qmp_chardev_remove
    -> qemu_chr_is_busy
    -> object_unparent(OBJECT(chr));

 330 static bool qemu_chr_is_busy(Chardev *s)
 331 {
 332     if (CHARDEV_IS_MUX(s)) {
 333         MuxChardev *d =3D MUX_CHARDEV(s);
 334         return d->mux_cnt >=3D 0;
 335     } else {
 336         return s->be !=3D NULL;
 337     }
 338 }

My question is:
1. s->be is set to NULL when qemu_chr_fe_deinit is called.
However, the qmp_chardev_remove is blocked at qemu_chr_is_busy check,
then the object_unparent will not be called.
2. Is there a path that device_del will trigger the s->be that been set to =
NULL?

How should I fix this issue?
I have tested that comment the qemu_chr_is_busy works well.

Thanks in advance.

Feng Li

--=20
The SmartX email address is only for business purpose. Any sent message=20
that is not related to the business is not authorized or permitted by=20
SmartX.
=E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=8C=E6=
=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=EF=BC=
=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=9C=AC=
=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=8E=E5=
=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=AA=E5=
=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=E6=98=
=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.



