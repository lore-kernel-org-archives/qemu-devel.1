Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B1BC34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BE724656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FX2cxlfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BE724656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4TdP-0007X9-Nt
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j4Tbw-0005Jm-Ed
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j4Tbu-0000wO-Nx
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37140
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j4Tbu-0000vN-KI
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582135089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aoMcZECwJyOP1Gq85SIjQEettvg8amgYeWvqcmYe9nc=;
 b=FX2cxlfvf5hAfGGDuubDsw3KNktpvpdMxvFpn5ao+DRXI33Lge/R69ggLRqtyA+8TjzKR3
 aWm6DUjRsK1U8LcIZFqJtGeBmkrCZLK6I0Y3mUIEN1qOEq69fkaN65L0D73RZr7T7Umpx0
 Gw+Cacj6FzTQ+Z2C7tZl7xZtd+cDDzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-CU0ZuIcaNweg1sy6yK-aoQ-1; Wed, 19 Feb 2020 12:58:00 -0500
X-MC-Unique: CU0ZuIcaNweg1sy6yK-aoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53F14107ACC5;
 Wed, 19 Feb 2020 17:57:59 +0000 (UTC)
Received: from localhost (unknown [10.36.118.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF9648;
 Wed, 19 Feb 2020 17:57:58 +0000 (UTC)
Date: Wed, 19 Feb 2020 15:14:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v3] virtio: increase virtqueue size for virtio-scsi and
 virtio-blk
Message-ID: <20200219151416.GJ1078625@stefanha-x1.localdomain>
References: <20200214074648.958-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200214074648.958-1-dplotnikov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NgG1H2o5aFKkgPy/"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NgG1H2o5aFKkgPy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 10:46:48AM +0300, Denis Plotnikov wrote:
> The goal is to reduce the amount of requests issued by a guest on
> 1M reads/writes. This rises the performance up to 4% on that kind of
> disk access pattern.
>=20
> The maximum chunk size to be used for the guest disk accessing is
> limited with seg_max parameter, which represents the max amount of
> pices in the scatter-geather list in one guest disk request.
>=20
> Since seg_max is virqueue_size dependent, increasing the virtqueue
> size increases seg_max, which, in turn, increases the maximum size
> of data to be read/write from a guest disk.
>=20
> More details in the original problem statment:
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>=20
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>=20
> ---
>=20
> v3:
>   * typos fixed
>=20
> v2:
>   * seg_max default value changing removed
> ---
>  hw/block/virtio-blk.c | 2 +-
>  hw/core/machine.c     | 2 ++
>  hw/scsi/virtio-scsi.c | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--NgG1H2o5aFKkgPy/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5NUMgACgkQnKSrs4Gr
c8i32Af/b3yKup0k8k+MZPXrxYV8oQkiTpBuHdtOH8wceXUMWvDeXJBGbixtJqr+
H1udQ2JVezNrOR+ZI/R0I8ZxSCfM9Zabqesn0QyYKAsURzajmaemMUdW4AYf8H0u
oIpyg7jcLn0yVX7hjEg2vtg+xvgjNofq9SCT+H+8dRkuv7lmxoVl6pq9V710A91k
ew063dldBOLcbeVbJpzqRi2kg6WMubZacFYxOHLmNBK+1GS1aNKGBIiZ1KKEqhw4
k6amBFGb+8W6IAMpElmUTqi6wyL6oTcw3hSmHlCLtaVqYzvfQ0WNoxo5PkvEfkhk
zRjSvNgQVa3m3DZkMz/tLvaquqoCsA==
=QAsH
-----END PGP SIGNATURE-----

--NgG1H2o5aFKkgPy/--


