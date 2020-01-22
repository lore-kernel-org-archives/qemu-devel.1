Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9962EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6362D20828
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtoLbrN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6362D20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuDDx-0002Ix-8f
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuDCt-0001Pe-K1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuDCs-0002C5-Li
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:25:55 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuDCs-00029b-ES
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:25:54 -0500
Received: by mail-wm1-x341.google.com with SMTP id s144so1255318wme.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 02:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wGCSiEbfBjU3o7l1c9lFD2NDw3vrETJHXw11l+/U5Qg=;
 b=ZtoLbrN7ULPoSa1ffCK5AOF1AZysSkxNfY+rkfb2EZrLyCTNvnaFdmaT4XpZwsAdaF
 //xL9XEGuLJ9OfmOVvxj0wpyWRKSt+5jYZBqngzcw/k0KeTdL35h1fAt9kFYbLIaYfNe
 Q1IaNEJnFN3VcES1B4lbHgDhIUIjvzIWA1V4fvdQ4pgCOYuPmFmE/6Vl3s1qRipGSefc
 JPqsVW+TqKQa2uRxPChtfcfWXWQl4OLokxvpoXJXOTdWGeP3/uLfcaTh6E/BI38wyoaV
 gSRj5atLwOUJmgUy5I3GR6lKZGRbQwA1gJoQnkMuM/6KwLeiKVg4gwOoBHl1Jj6KFQU1
 K8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wGCSiEbfBjU3o7l1c9lFD2NDw3vrETJHXw11l+/U5Qg=;
 b=k/0IVY7InZsXtcy1FLH65+JjyRt+6TNM+k3VenU906Gl7ct4j+zBoJsNdK1kvHdTr9
 XVWhcFSyOta5l8O8z1iBLDQT/+BrBQ2ZFpSXaHrJ/CGCJsyxn4oeefMsNB7TOD0OZ0I+
 yEzpugZTf89E2IzGGhlnh3XF/OF50MAYk7nt4SX+LUspluTlDWB6IAkGxU8f6uETZRdT
 vgL9GwFx/LWTRk5HT1uHyKhA8Pf7J5GyWB8K9+ooE1IxbP1TgkPiCcJk+P3qi6CSNdR2
 v0XHaqhO0FzNe/KzZ4r/WmfsSYSkxJN5ytgZtNGtp05Vn+3U3XzkXXU336xVvp5x+igM
 eWjg==
X-Gm-Message-State: APjAAAVHIcRYci5Ypc0YFslURa1R3tnqTbRtVe17CEupfCVrUZpUt1aI
 ddLey3UE+xpDviP2KMfC6WVLYVCGJ8g=
X-Google-Smtp-Source: APXvYqynp3BsBnJNa6aNIRgcFfgckVZBvc+YZLPVqd5kAmbRxN0X67yAOl2i/2T6CSeL0v5w6EcNpg==
X-Received: by 2002:a7b:c30b:: with SMTP id k11mr2180530wmj.36.1579688753029; 
 Wed, 22 Jan 2020 02:25:53 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n189sm3569866wme.33.2020.01.22.02.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 02:25:51 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 193611FF87;
 Wed, 22 Jan 2020 10:25:51 +0000 (GMT)
References: <20200122080840.592054-1-mst@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: coding style fix
In-reply-to: <20200122080840.592054-1-mst@redhat.com>
Date: Wed, 22 Jan 2020 10:25:51 +0000
Message-ID: <874kwn23f4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Michael S. Tsirkin <mst@redhat.com> writes:

> Drop a trailing whitespace. Make line shorter.
>
> Fixes: 76525114736e8 ("vhost: Only align sections for vhost-user")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/virtio/vhost.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 25fd469179..9edfadc81d 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -551,7 +551,7 @@ static void vhost_region_add_section(struct vhost_dev=
 *dev,
>      trace_vhost_region_add_section(section->mr->name, mrs_gpa, mrs_size,
>                                     mrs_host);
>=20=20
> -    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER) {=
=20=20=20
> +    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER) {
>          /* Round the section to it's page size */
>          /* First align the start down to a page boundary */
>          size_t mrs_page =3D qemu_ram_pagesize(mrs_rb);
> @@ -566,8 +566,8 @@ static void vhost_region_add_section(struct vhost_dev=
 *dev,
>          if (alignage) {
>              mrs_size +=3D mrs_page - alignage;
>          }
> -        trace_vhost_region_add_section_aligned(section->mr->name, mrs_gp=
a, mrs_size,
> -                                               mrs_host);
> +        trace_vhost_region_add_section_aligned(section->mr->name, mrs_gp=
a,
> +                                               mrs_size, mrs_host);
>      }
>=20=20
>      if (dev->n_tmp_sections) {


--=20
Alex Benn=C3=A9e

