Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C24C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 07:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D150F22322
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 07:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D150F22322
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpSZm-0008T0-Mb
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 03:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55568)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hpSZb-00084c-4J
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hpSZW-0000po-SW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:17:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hpSZT-0000hh-CM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:17:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 507CE3083363;
 Mon, 22 Jul 2019 07:17:12 +0000 (UTC)
Received: from localhost (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B76019C77;
 Mon, 22 Jul 2019 07:17:09 +0000 (UTC)
Date: Mon, 22 Jul 2019 08:17:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190722071706.GA22361@stefanha-x1.localdomain>
References: <20190719185158.20316-1-alxndr@bu.edu>
 <20190719185158.20316-2-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20190719185158.20316-2-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 22 Jul 2019 07:17:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] net: assert that tx packets have
 nonzero size
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 06:52:24PM +0000, Oleinik, Alexander wrote:
> Virtual devices should not try to send zero-sized packets. The caller
> should check the size prior to calling qemu_sendv_packet_async.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  net/net.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/net/net.c b/net/net.c
> index 7d4098254f..fad20bc611 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -741,6 +741,9 @@ ssize_t qemu_sendv_packet_async(NetClientState *sende=
r,
>      size_t size =3D iov_size(iov, iovcnt);
>      int ret;
> =20
> +    /* 0-sized packets are unsupported. Check size in the caller */
> +    assert(size);

Please include the rationale:

  A return value of 0 means the packet has been queued and will be sent
  asynchronously.  Therefore this function has no way of reporting that
  a 0-sized packet has been sent successfully.  Forbid it for now and if
  someone needs this functionality then the API will require a change.

This way someone who hits this will understand why the assertion is
there.

Stefan

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl01YvIACgkQnKSrs4Gr
c8jsmAf/Tgls1HANTr5b7FTL5nynmeLnplu/d9GpQiW70jyYZ0PqbclkvDnZbFzO
B/yKYymv2M3mCggRY8z4/jaIbOTjv0IrHJGeWydWnhkl/2wwMpsk0h5yI4GrdZbI
w+HGr260eBJ8OpJz+y1/4CuWnniW0+GYmElkVy4QjrqfAqHs3SG7WYbSO5rUpOU3
1lNX7RfLynJ1WqzNqgSU9xKzvAuWBUgvWz2qAL47G6WeN6qcOuEAFGi38NFvIvYY
UDcm7MlqS7nkoczLX6JrYgplqL1bf/oefWPu/zgAHjtml4KewLQXaOt4PM8MYq1A
XQTbLQlDnJmrSqEZAosNs8Em0npImA==
=FxQS
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

