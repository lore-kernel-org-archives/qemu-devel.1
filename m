Received: from eggs.gnu.org ([2001:4830:134:3::10]:54083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTs6U-00056A-6A
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTs6R-0006CW-2h
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:24:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTs6Q-0006CG-TC
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:24:46 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19CFA7C228
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:24:47 +0000 (UTC)
Date: Wed, 18 Jan 2017 15:24:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118152444.GG30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gm5TwAJMO0F2iVRz"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-7-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/16] nbd: do not block on partial reply
 header reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 02:17:21PM +0100, Paolo Bonzini wrote:
> @@ -65,54 +67,34 @@ static void nbd_teardown_connection(BlockDriverState =
*bs)
>      client->ioc =3D NULL;
>  }
> =20
> -static void nbd_reply_ready(void *opaque)
> +static void nbd_read_reply_entry(void *opaque)

Please use coroutine_fn.

--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf4i8AAoJEJykq7OBq3PIw2MH/ihuk4v40y9VUfKBWh2qVuJ7
HGfjqryETxD7kd54QFfNcv5ysflR0rpB4R/xI3IuIFsVG2OV7eMd8oTLuj6DPtaL
mW4UyFnLZ44XllGG8uEFkZUhyc9TTDx0NP2uP5YcofoiS6xKRsSp7opZPCOzA15D
sx2901ZRhcAs3mRImD5jC+c+SW1o9drH0A9HmMB4dnxo3Fv8PYk5X5EAIfb+w1wp
y6IDrDlqLkeddFBvD/gheBOU11cb52aEE2YV5kpe1BTaPCrdFP0DODjlQkprtAIO
LweiqVUroirPU617ttqxtILCyxWFRXWrodMVWEDOokOKTnyk1waR+RlCb7OYMCE=
=pUEv
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--
