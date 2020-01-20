Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757ABC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C222073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXWhBHBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C222073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUvb-0000d4-1u
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itUVI-0005xU-O0
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itUVH-0005na-Dw
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:41:56 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1itUVG-0005mu-Ud
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:41:55 -0500
Received: by mail-wm1-x344.google.com with SMTP id d73so13938525wmd.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 02:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=H+3yUbprJV6xDZ23zFMat1QML4R+Ymh6QmBsR7Am1jQ=;
 b=iXWhBHBj4IB0xvFt3u4zD5qg2DZDDfDCQE6elAuNI/DzWd4gqDy7TjnBuPWlOvP3ry
 eZQwpf4WKvDC5dwaM9NVjQaVK/JWEJnoJpFTBhNBfLJNp5C8Vwp7t72DxqxPp/HSVFWu
 7fgUHMJ+/ddBhTdISucIYg7A5ZWuFIqwOZurIQ7I4dNN41Kzev28FEAV5PmpZ7BOSFmC
 lk3DdLU2QhbhguZyyqQAe5rUBiYwAsEoyaV6n1PXCcZuUmCHa5eEiTvYyMpwRMpbBb8/
 Z5zQc5qvgtKp5Wm48TUeNT05QWtNPv+F77G+VURFCwdyYOPh5EJ8Za1nmcKxfYIyZdio
 kPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H+3yUbprJV6xDZ23zFMat1QML4R+Ymh6QmBsR7Am1jQ=;
 b=X4ebLTdKMbkw11PfPYrg3WxNNtEdblm4iMDbrAa1wTnpoTChRjkuM87daFJ7os6IzQ
 452jqv8uEXlOhbcskPBgZWfGSAIb2uwery8leQZwm3IWRb01pH4ym+v+1F3X0nIbw2dP
 AKSuRqL7LUUxBvlO2jr1AYwZUP+lnvLpQsPttrqHlI6J2rzBBf25WP5iqPvZTfieAgwQ
 zCn/G1yg4KJBCELUZM8aVJczrHCv9eR77KZm8K1zq/qob3qSrOVWkPqzXr2TNibJmAcD
 e0iJG9lfmk5TaLfnfox7zxS9NmyNdx+H1/Oph4UACu35qZZ3l1hV4xtwiXAxj31aRndD
 nTIQ==
X-Gm-Message-State: APjAAAU35sjA4Syxx4p+oHYw0C27l/dCZuFl0fOjl5VjL7BgxA2mRANi
 8qErN233Hs8L/Rs+ughkr0A=
X-Google-Smtp-Source: APXvYqzWQBtgCnD2fV4Uibavtj2Ph3a1o4Jae80lmW8m0pyQc1LTxjwU8M8pa1yHtwi8pYWMx7g49w==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr18210611wmk.172.1579516913877; 
 Mon, 20 Jan 2020 02:41:53 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id k7sm330775wmi.19.2020.01.20.02.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 02:41:53 -0800 (PST)
Date: Mon, 20 Jan 2020 10:41:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH v2] vhost-vsock: delete vqs in vhost_vsock_unrealize to
 avoid memleaks
Message-ID: <20200120104151.GF345995@stefanha-x1.localdomain>
References: <20200115062535.50644-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline
In-Reply-To: <20200115062535.50644-1-pannengyuan@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 02:25:35PM +0800, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> Receive/transmit/event vqs forgot to cleanup in vhost_vsock_unrealize. Th=
is
> patch save receive/transmit vq pointer in realize() and cleanup vqs
> through those vq pointers in unrealize(). The leak stack is as follow:
>=20
> Direct leak of 21504 byte(s) in 3 object(s) allocated from:
>   #0 0x7f86a1356970 (/lib64/libasan.so.5+0xef970)  ??:?
>   #1 0x7f86a09aa49d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
>   #2 0x5604852f85ca (./x86_64-softmmu/qemu-system-x86_64+0x2c3e5ca)  /mnt=
/sdb/qemu/hw/virtio/virtio.c:2333
>   #3 0x560485356208 (./x86_64-softmmu/qemu-system-x86_64+0x2c9c208)  /mnt=
/sdb/qemu/hw/virtio/vhost-vsock.c:339
>   #4 0x560485305a17 (./x86_64-softmmu/qemu-system-x86_64+0x2c4ba17)  /mnt=
/sdb/qemu/hw/virtio/virtio.c:3531
>   #5 0x5604858e6b65 (./x86_64-softmmu/qemu-system-x86_64+0x322cb65)  /mnt=
/sdb/qemu/hw/core/qdev.c:865
>   #6 0x5604861e6c41 (./x86_64-softmmu/qemu-system-x86_64+0x3b2cc41)  /mnt=
/sdb/qemu/qom/object.c:2102
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Changes V2 to V1:
> - delete virtqueues after vhost cleanup to avoid use-after-free
> - aslo delete virtqueues in the error path of realize()
> ---
>  hw/virtio/vhost-vsock.c         | 12 ++++++++++--
>  include/hw/virtio/vhost-vsock.h |  2 ++
>  2 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4lg+8ACgkQnKSrs4Gr
c8iYLggAt6wCN2G2dZo+FST78japPgsdzq0uwyN4SFNtc6/SKhm2mB3DnHmPNM9z
cHatzK2ocBOInoWCw48cF8nAGucs889bd0hcp+u5iCFiAvVpAmIvvCGSKdB5v4NS
rND9Fi44bbCoasxv8Zvg/pwz0a/Ho/ptm5ashr8p76agauI7q/LJ/VYlvLyA49K3
eM0t5AfDAgoWV3zzHAf0sBOwH8OK+/xv/vGubMrWRJkOdv4BGadzcPDaCgHPJMoJ
h1of2ruAGLB3Q7aGvClKqvNkV/HVCTU+L3NUWvHf+RJNS5wMfZB3eNWjOKzzAVpf
7NThy/1V93hpH+SHTKVnMywcERvTFg==
=oaEa
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--

