Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6C2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00AA24650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDtnm60O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00AA24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihyay-0001PZ-Sn
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 11:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ihya9-0000kV-MR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ihya8-0002le-IB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:23:21 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ihya8-0002eQ-5D
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:23:20 -0500
Received: by mail-wm1-x341.google.com with SMTP id d73so6060650wmd.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 08:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=93lFf79Z5BsiQ8ixjZchGMBx01f4LNFznLOpaJdR3nM=;
 b=QDtnm60O8PGMGUooz7S44/CZSd/fBqWXMo31RYpzi/kodHqvvqbewcvXHZxRSgGr9x
 NVxGoEarvD8bgO3esbTfQGthow90h4tifwbTBxx0IyMkh+7FJ0HwbZ5gftoiMkhM2U+0
 UOw5zLOm3I8daDpH/0nil98XYQdhSaNAXE9C9YsO53KBGfa7CzhAkMCb0p35PBzq5hCi
 rRp930qcQVo823ieN5EUKYKRutUFlkWCrIFl7RZmDXJz9xPzQbbgSpM6nU6v5om9vRSv
 mwAnvejdaAyXeHDgPcPfn7p3sDy4jBQQ9ZkGqlboRSz7j4jkD2l5vJxH1V2HK2leyB6d
 PF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=93lFf79Z5BsiQ8ixjZchGMBx01f4LNFznLOpaJdR3nM=;
 b=T4I9lRISyBiKiSlKRF8YMzv3ZSLio9VsSMARlA0QCB89Ncm1vun990lHuvErP6dwtH
 6KL2jUSyY2E9cn5MwSSMSO9MBGDLYiyWenY2/mIwRMkpgywHZfbx3rHtGEM5j8NOWpkS
 eUMio2AGUJGg3Hqzk7mLTMIZOjU6VN4OKiItibd/1d81x2CnQBKArhDK8CkwfLluTn/f
 pEJ71hZukWzjwbVG8ucFcNsj57nxZ7HXsZ8lgVGaAwJtVnES6YyLDTog607Jz+kNDvTD
 /jkItHktLGD4ksedShM+qQDg5qSYZsbjWz2h48K8JuWPTgKdi7H5Pp+Z1u0GOWJ5BkGY
 54wg==
X-Gm-Message-State: APjAAAUz80WB2EaXuSYWlsvph/do3JGNCP03zInWPzDjSaRHOUv/MHxX
 T/jywLQYqJi6+QCRUSRbd0E=
X-Google-Smtp-Source: APXvYqywKblpEiOQOa7QdDgFgzaBmwovTuSKTQF8WcqkO26UIjUewPohYdsDVGVhCTsfBYFYygPdXw==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr10907516wml.67.1576772598564; 
 Thu, 19 Dec 2019 08:23:18 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o4sm6728433wrw.97.2019.12.19.08.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 08:23:17 -0800 (PST)
Date: Thu, 19 Dec 2019 16:23:16 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v4 0/2] virtio: make seg_max virtqueue size dependent
Message-ID: <20191219162316.GJ1624084@stefanha-x1.localdomain>
References: <20191216100451.28060-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6J7GEvtanOfV9oXA"
Content-Disposition: inline
In-Reply-To: <20191216100451.28060-1-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6J7GEvtanOfV9oXA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 01:04:49PM +0300, Denis Plotnikov wrote:
> v4:
>   * rebased on 4.2 [MST]
>=20
> v3:
>   * add property to set in machine type [MST]
>   * add min queue size check [Stefan]
>   * add avocado based test [Max, Stefan, Eduardo, Cleber]
>=20
> v2:
>   * the standalone patch to make seg_max virtqueue size dependent
>   * other patches are postponed
>=20
> v1:
>   the initial series
>=20
> Denis Plotnikov (2):
>   virtio: make seg_max virtqueue size dependent
>   tests: add virtio-scsi and virtio-blk seg_max_adjust test
>=20
>  hw/block/virtio-blk.c                     |   9 +-
>  hw/core/machine.c                         |   3 +
>  hw/scsi/vhost-scsi.c                      |   2 +
>  hw/scsi/virtio-scsi.c                     |  10 +-
>  include/hw/virtio/virtio-blk.h            |   1 +
>  include/hw/virtio/virtio-scsi.h           |   1 +
>  tests/acceptance/virtio_seg_max_adjust.py | 135 ++++++++++++++++++++++
>  7 files changed, 159 insertions(+), 2 deletions(-)
>  create mode 100755 tests/acceptance/virtio_seg_max_adjust.py

Bellissimo!  Thanks for doing this :)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6J7GEvtanOfV9oXA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl37o/QACgkQnKSrs4Gr
c8iePwf7BSqVF3w5x/Ipyt6ZMkMc3f8TTlwlxURL79iKWuo6nidGtjXs7SjWI439
alZwGtx5ok92CP0cS+b5e/vVDk186cUKc9jpYt7r0+aCpcTQK0ANKswCjEun0uxX
rKPlBXQ+BTVOVFof/vnfUAFlBGo7HI5xmUXe/uBS0Ng6ZCB2oMwDqAhRgD+Y9uLy
gtAkjG/k20G2nB+U5DDhbJMxXhPW9hZ9NLnXRI7N1a6w7Dev7+mPN1EBhO/ORbbM
Vh/dJOz6qj89R8wEZ2OUek3TQhG8b3lZZeUqn7iBNXapmn9C3scx/famICvAXYTf
zrnDc0ysTBYdapqYI2dgoeuYhaKg5w==
=nQRp
-----END PGP SIGNATURE-----

--6J7GEvtanOfV9oXA--

