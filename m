Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6105FC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 07:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E6C21994
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 07:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E6C21994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpSkM-0004AO-Ia
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 03:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59773)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hpSkA-0003lm-Oy
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hpSk9-0001GD-Qm
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:28:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hpSk9-0001Ef-Km
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:28:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CE929308A9E0;
 Mon, 22 Jul 2019 07:28:20 +0000 (UTC)
Received: from localhost (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DACC360497;
 Mon, 22 Jul 2019 07:28:15 +0000 (UTC)
Date: Mon, 22 Jul 2019 08:28:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190722072814.GD22361@stefanha-x1.localdomain>
References: <20190719151920.22586-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <20190719151920.22586-1-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 22 Jul 2019 07:28:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] virtio-net: Always check for guest
 header length
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
Cc: Jason Wang <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 03:21:15PM +0000, Oleinik, Alexander wrote:
> While fuzzing the virtio-net tx vq, I ran into an assertion failure due
> to iov_copy offsets larger than the total iov size. Though there is
> a check to cover this, it does not execute when !n->has_vnet_hdr. This
> change always copies the guest header into the mhdr buffer and checks its
> length, even if mhdr is not needed.
>=20
> The call stack for the assertion failure:
>=20
>  #8 in __assert_fail (libc.so.6+0x300f1)
>  #9 in iov_copy iov.c:266:5
>  #10 in virtio_net_flush_tx virtio-net.c:2073:23
>  #11 in virtio_net_tx_bh virtio-net.c:2197:11
>  #12 in aio_bh_poll async.c:118:13
>  #13 in aio_dispatch aio-posix.c:460:5
>  #14 in aio_ctx_dispatch async.c:261:5
>  #15 in g_main_context_dispatch (libglib-2.0.so.0+0x4df2d)
>  #16 in glib_pollfds_poll main-loop.c:213:9
>  #17 in os_host_main_loop_wait main-loop.c:236
>  #18 in main_loop_wait main-loop.c:512
>  #19 in virtio_net_tx_fuzz virtio-net-fuzz.c:160:3
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  hw/net/virtio-net.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Please include a changelog below the '---' line in future patches.  For
example:

---
v2:
 * Unconditionally copy guest vnet_hdr because the size must always be
   checked

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl01ZY4ACgkQnKSrs4Gr
c8gv/wgAsJQx+lqeHHgxW/yP0C3NEKhXRFzg58D0RQ7z6cyxpHRUkUVVN9uRuZ2M
rWEbCy8O+LvhgR6dUbYxqjvnwdzZPb0Z6SVT27J0DSFc/DxkFojM6sdRlXn56+ij
soEh8qUgSXrkiTf8NhZw9PiTtRBYjTcLDhXkI0n6ppKbX9o4wNSSzOyJYy2ZHOyz
g945icpSXht29+YrNBZkWSjb1Kwk77olmhlCzv6piVXPI5o2oolOlGtu5IV1JZU0
nxrQFSbfzWWQE7uALL1nrLsxjQrfYzqjlV8q+2HUw/14pVfxuLTUtUk93CTnSr5X
tJLnWjrzkTpht+UIrzXP0p18l64oow==
=gq3x
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--

