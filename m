Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510D9C76195
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 07:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0CF2229A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 07:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0CF2229A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpSeQ-0001sH-FD
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 03:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57398)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hpSeG-0001U0-43
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hpSeF-0004Ci-3f
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:22:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hpSeE-0004BR-OD
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:22:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C45AC034DF3;
 Mon, 22 Jul 2019 07:22:12 +0000 (UTC)
Received: from localhost (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 058B219C77;
 Mon, 22 Jul 2019 07:22:05 +0000 (UTC)
Date: Mon, 22 Jul 2019 08:22:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190722072205.GB22361@stefanha-x1.localdomain>
References: <20190719185158.20316-1-alxndr@bu.edu>
 <20190719185158.20316-3-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20190719185158.20316-3-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 22 Jul 2019 07:22:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-net: check that tx packet has
 positive size
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


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 06:52:30PM +0000, Oleinik, Alexander wrote:
> virtio_net_flush_tx does not check that the packet size is nonzero,
> which causes q->aysnc_tx.elem to be set. Then, when the device is reset, =
there
> is an assertion failure since q->aysnc_tx.elem must be flushed/cleared.
> Zero-sized packets are unsupported - check packet size, prior to
> sending.
>=20
> Found while fuzzing virtio-net. The relevant stack-trace:
>  #8 in __assert_fail (libc.so.6+0x30101)
>  #9 in virtio_net_reset virtio-net.c:520:13
>  #10 in virtio_reset virtio.c:1214:9
>  #11 in virtio_pci_reset virtio-pci.c:1810:5
>  #12 in qdev_reset_one qdev.c:259:5
>  #13 in qdev_walk_children qdev.c:575:15
>  #14 in qbus_walk_children bus.c:52:15
>  #15 in qdev_walk_children qdev.c:567:15
>  #16 in qbus_walk_children bus.c:52:15
>  #17 in qemu_devices_reset reset.c:69:9
>  #18 in pc_machine_reset pc.c:2628:5
>  #19 in qemu_system_reset vl.c:1621:9
>  #20 in LLVMFuzzerTestOneInput fuzz.c:184:4
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  hw/net/virtio-net.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl01ZBwACgkQnKSrs4Gr
c8hVFAgAqTWjlehBGSOLg/f7tvxK65krJp4bcAO+1+Johqs/VekCNTA7Y2FKCxVN
gq+WyWJIyBwPXu9CO5C+VIbiYUnshPWUmQHatTqBKAF4Y7RxSrkxb04XMjWwN2Gc
erD4ZjTM3pSSEXgEskmdqzsU5teJs6HiWLquSTjXjkhnIHAeCAv5I2f4S2eYNkSf
YOljkbvcSuW6sEi9TNwxvql6Qp4fts22gLxUMVAcp7Zeeeh11Ltk+faKW3i5Lo19
FoXVatRaR+1/2tLWZTwBm3R0VKELZieA+iE9UhGngWvW4dT+4GBUY6ZfioWYdsFQ
cOWJkoyjlCToskGW5RYxt5/WOAWz7g==
=3iiC
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--

