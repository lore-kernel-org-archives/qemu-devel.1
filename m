Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82243C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85AF21D92
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCEtGcs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85AF21D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL3os-0004hf-Kl
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL3ng-0004Em-6j
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL3nd-00041F-Md
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600863783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kv1A67A6VQC6i5BXSb2Brotnw7HQ+z3Stnw9MZxJSco=;
 b=FCEtGcs81vbYwzHLFgGRF21Ewwb4Gndt6jtLbDiV3AG3lhqMcTwNExwJwI0gx+9c4A17II
 4ineRbemYKIDMycQF98almUIIBmVz1WCPTWpym0In4lBB/q10Yr8JKlyEZN6Eh+tHF1JZw
 Up/EPPyPgLbCtX19P8PScsQ9R+YOVBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-adn-R36aOn-W-bmYyRX3sA-1; Wed, 23 Sep 2020 08:22:58 -0400
X-MC-Unique: adn-R36aOn-W-bmYyRX3sA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D3DB8ECE47;
 Wed, 23 Sep 2020 12:22:57 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17A0F60C04;
 Wed, 23 Sep 2020 12:22:53 +0000 (UTC)
Date: Wed, 23 Sep 2020 13:22:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] virtiofsd: Used glib "shared" thread pool
Message-ID: <20200923122253.GB51019@stefanha-x1.localdomain>
References: <20200921213216.GE13362@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921213216.GE13362@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 05:32:16PM -0400, Vivek Goyal wrote:
> glib offers thread pools and it seems to support "exclusive" and "shared"
> thread pools.
>=20
> https://developer.gnome.org/glib/stable/glib-Thread-Pools.html#g-thread-p=
ool-new
>=20
> Currently we use "exlusive" thread pools but its performance seems to be
> poor. I tried using "shared" thread pools and performance seems much
> better. I posted performance results here.
>=20
> https://www.redhat.com/archives/virtio-fs/2020-September/msg00080.html
>=20
> So lets switch to shared thread pools. We can think of making it optional
> once somebody can show in what cases exclusive thread pools offer better
> results. For now, my simple performance tests across the board see
> better results with shared thread pools.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  tools/virtiofsd/fuse_virtio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: qemu/tools/virtiofsd/fuse_virtio.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- qemu.orig/tools/virtiofsd/fuse_virtio.c=092020-09-21 17:28:27.4444380=
15 -0400
> +++ qemu/tools/virtiofsd/fuse_virtio.c=092020-09-21 17:28:30.584568910 -0=
400
> @@ -695,7 +695,7 @@ static void *fv_queue_thread(void *opaqu
>      struct fuse_session *se =3D qi->virtio_dev->se;
>      GThreadPool *pool;
> =20
> -    pool =3D g_thread_pool_new(fv_queue_worker, qi, se->thread_pool_size=
, TRUE,
> +    pool =3D g_thread_pool_new(fv_queue_worker, qi, se->thread_pool_size=
, FALSE,
>                               NULL);
>      if (!pool) {
>          fuse_log(FUSE_LOG_ERR, "%s: g_thread_pool_new failed\n", __func_=
_);

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rPh0ACgkQnKSrs4Gr
c8h95ggAhwmJLoaBHHsErEpHJKkma6Mx70WHmYZCr+JoAogEvV0TjYfj83oOzRMZ
IAeaS78kppwaYJf4nmbbU5VW0jz0U88wVFO43D6N8tt9sWNPD6u8Zr9hlWN1tkUz
SIPiRfa4h+vSpZNdzEL8L/cnO3gdp3m+IyYnwz+fa+IAD3wgO6OOB4naLUzJEmLb
RWYTL081LUCRuRABTZWTiemr1sLOBNCmIHkoRVszqbhfOFwKO7b3ygqLC7mg8+9n
ajlN+XuMR8/rL+El1cct9m0ef6iimme3oj2lF/ihxCb4EdC77FsHdgFJFTANih6j
MC5FfBdd+AC++n0IxrkIeQiEEAqe3w==
=Ub6E
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--


