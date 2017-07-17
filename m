Received: from eggs.gnu.org ([2001:4830:134:3::10]:33423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX77O-0007DB-Nq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX77K-0003qY-RR
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:35:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dX77K-0003q8-Kp
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:35:22 -0400
Date: Mon, 17 Jul 2017 15:35:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170717143516.GR7163@stefanha-x1.localdomain>
References: <1500118925-10569-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o0y1lerN6xYE2ROn"
Content-Disposition: inline
In-Reply-To: <1500118925-10569-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH v5] Add manpage for QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com


--o0y1lerN6xYE2ROn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 15, 2017 at 05:12:05PM +0530, Ishani Chugh wrote:
> diff --git a/Makefile b/Makefile
> index 16a0430..1826a74 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -209,6 +209,8 @@ ifdef BUILD_DOCS
>  DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
>  DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
>  DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
> +DOCS+=contrib/backup/qemu-backup.html contrib/backup/qemu-backup.txt
> +DOCS+=contrib/backup/qemu-backup.pdf contrib/backup/qemu-backup.info

The patchew error occurred because you added file types that are not
built by default (pdf and info) to DOCS.  Please follow what qemu-doc
and the other documentation artifacts do instead of adding them to DOCS.

--o0y1lerN6xYE2ROn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZbMskAAoJEJykq7OBq3PIjp8H/1zcU7xCbb/NQH32Ca6I2BEE
y1bAv2MTyc+M0JxEMy2qB3paeJSpxldzWWPMGPGZRP0iBprGq3JRLxXIaCXy4D91
LMGpbt7vU/qvw4vU6J3S/VIi6wWuwCTPKm7gJCag70pHta7nU6xbYRjR1c5EE4kG
q+Vl2Fx+x+Gq9iJRS2SBww2S9++tkZPTgjxMBn8YWANnlOLN5AmvLcammooIxXWX
2MVwAiXrQ2SL2/HJo0/DZs6kbao8V6x1GTf5AfyfYLtBn6MWUNnPLYCowR0P02fw
9ZFqHz3H6NYgyLiX1Q7HcsHfEcL+lfXNnl17cz+d1OmKZhGbhoWmU0IXH8GdDHE=
=JPUp
-----END PGP SIGNATURE-----

--o0y1lerN6xYE2ROn--
