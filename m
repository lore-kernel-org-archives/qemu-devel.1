Received: from eggs.gnu.org ([2001:4830:134:3::10]:45465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTrW7-00056W-Ke
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTrW3-0004Nl-Ju
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:47:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTrW3-0004NV-DO
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:47:11 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B1B81E20
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:47:11 +0000 (UTC)
Date: Wed, 18 Jan 2017 14:47:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118144708.GD30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/16] io: add methods to set I/O handlers
 on AioContext
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


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 02:17:19PM +0100, Paolo Bonzini wrote:
> This is in preparation for making qio_channel_yield work on
> AioContexts other than the main one.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/io/channel.h | 30 ++++++++++++++++++++++++++++++
>  io/channel-command.c | 13 +++++++++++++
>  io/channel-file.c    | 11 +++++++++++
>  io/channel-socket.c  | 16 +++++++++++-----
>  io/channel-tls.c     | 12 ++++++++++++
>  io/channel-watch.c   |  6 ++++++
>  io/channel.c         | 11 +++++++++++
>  7 files changed, 94 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf3/sAAoJEJykq7OBq3PI75kIALTsBIUFMIa6EL4s9CA/QVPS
MXoBRPFSDWWSgTsDChrRzAtXTZp5e0MWq7KQlZLtAf4ClGTvCx4BVCT2uMS57NsH
NfFRjoFPFdM8beBHzNJDvdb+PtTVtNCBu7Vm5MwH1r/RNgCrP3ZNWlBwgUPEN5dS
3Ur5yQPN/ZXtm0MoHjiTEhoEvnXCp8MB8KbhiPjU88ZJ3SX+54gqdxxo3RwoEyhA
Z31m96nwSnQKjG05IL5nuFNEClRj5VNGpXldDgZ/vbpjPUDJophU+Gey/aH4zjNI
yVPRUq+7Qx3xN3BZlu4jFScoiCFdhrYd21T7m+L6tEtaaZ/EcY0bBrvXLg/wPfw=
=4c24
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
