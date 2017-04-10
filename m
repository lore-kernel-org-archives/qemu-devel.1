Received: from eggs.gnu.org ([2001:4830:134:3::10]:36315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVhw-000294-Uz
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVht-00019N-NQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:34:00 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cxVht-00018k-H6
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:33:57 -0400
Received: by mail-wm0-x242.google.com with SMTP id q125so8587301wmd.3
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:33:57 -0700 (PDT)
Date: Mon, 10 Apr 2017 10:33:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410093353.GI2567@stefanha-x1.localdomain>
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline
In-Reply-To: <20170323173928.14439-7-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] blockjob: move iostatus reset inside
 block_job_user_resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, jsnow@redhat.com


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 06:39:24PM +0100, Paolo Bonzini wrote:
> Outside blockjob.c, the block_job_iostatus_reset function is used once
> in the monitor and once in BlockBackend.  When we introduce the block
> job mutex, block_job_iostatus_reset's client is going to be the block
> layer (for which blockjob.c will take the block job mutex) rather than
> the monitor (which will take the block job mutex by itself).
>=20
> The monitor's call to block_job_iostatus_reset from the monitor comes
> just before the sole call to block_job_user_resume, so reset the
> iostatus directly from block_job_iostatus_reset.  This will avoid
> the need to introduce separate block_job_iostatus_reset and
> block_job_iostatus_reset_locked APIs.
>=20
> After making this change, move the function together with the others
> that were moved in the previous patch.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockdev.c |  1 -
>  blockjob.c | 11 ++++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY61GBAAoJEJykq7OBq3PINj8H/26RLfiK11GbxeiqXIVryron
DROoqZTG50PrZwhmniFr2WXbwS6f+vGJ9QKbppKfl3IWffZk4k7Q+lTvO+xa4gZG
LdU8sYLdPRYHJlNHs7oRwO3bKzXeokwDZIldhnluP8uergBpl/g762jtR6CQ5Ndm
jm0S0D7Bxg55aZeYdeaQylW35vuXzF+nHAw+s6DBQaRjboXfS9TsfQS5uDC+l6dD
gi7xhuyecJw84MCCAR5jWt8+Bffd0OgJSujBHNU/2T/BsIpIGaAjJpG0pQIgQfYy
anLuPu5ZvG1o2MA8N2LC9BgOsMCcfedPUn2qHEoC2T36yQ3vBhkOulPQqZxcz/E=
=KHmh
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--
