Received: from eggs.gnu.org ([2001:4830:134:3::10]:57839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfN5y-0001A7-LA
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfN5v-0005O8-De
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:16:06 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dfN5v-0005Nm-6a
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:16:03 -0400
Received: by mail-wm0-x22e.google.com with SMTP id t201so26174956wmt.0
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 02:16:02 -0700 (PDT)
Date: Wed, 9 Aug 2017 10:15:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170809091558.GC18003@stefanha-x1.localdomain>
References: <20170808203935.30021-1-ehabkost@redhat.com>
	<20170808203935.30021-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline
In-Reply-To: <20170808203935.30021-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2 4/5] qmp-shell: Accept QMP
 command as argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 05:39:34PM -0300, Eduardo Habkost wrote:
> This is useful for testing QMP commands in scripts.
>=20
> Example usage, combined with 'jq' for filtering the results:
>=20
>   $ ./scripts/qmp/qmp-shell /tmp/qmp qom-list path=3D/ | jq -r .return[].=
name
>   machine
>   type
>   chardevs
>   backend
>   $
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Rewritten using optparse module
> ---
>  scripts/qmp/qmp-shell | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZitLOAAoJEJykq7OBq3PIKFIIAL0oTooOTB2EHysS7S/R5oej
j2tjDIGA1hI+WB3gCE0xnxcnWbF7GvBCZFtcX0TEFEGOesClxSgwRHspqN6QhJzY
FHZZdC2vHkNNohPYN05mIUcRrcKtNXGq1noZ4QEaBbb6dIr7G025wCQ84pVcHOhM
d8F9j7PN6Q4+6Ox9SSaf+m/izUNdYvLYNeTX/TuDX+9Zj1UJGrGMINuqrZWRpy+E
aLMqrNcjk+OI1xvoFSw5PSffRzTA+iUgSU4TPboMWKFt/fksroKI5NjNAIVmhomw
zkdyTHBchAwOTtbxs3c/P+LUa9n4khsOvaPy65smuaNXNflg2zfYu3wDI6WG3js=
=gXks
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
