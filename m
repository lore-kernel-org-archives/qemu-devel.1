Received: from eggs.gnu.org ([2001:4830:134:3::10]:49453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dg6kA-0003JN-3Z
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dg6k5-0006De-O5
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:00:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dg6k5-0006Cu-I8
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:00:33 -0400
Date: Fri, 11 Aug 2017 11:00:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170811100023.GC4568@stefanha-x1.localdomain>
References: <1502387075-29078-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <1502387075-29078-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH 0/2] QEMU Backup Tool
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


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 11:14:33PM +0530, Ishani Chugh wrote:
> This patch series is intended to introduce QEMU Backup tool.
> qemu-backup will be a command-line tool for performing full and
> incremental disk backups on running VMs. It is intended as a
> reference implementation for management stack and backup developers
> to see QEMU's backup features in action.
> This patch series contains two patches,
>      1) Adding Manpage for the tool
>      2) QEMU Backup command line tool
>=20
> Ishani Chugh (2):
>   Add manpage for QEMU Backup Tool
>   backup: QEMU Backup Tool
>=20
>  Makefile                        |  15 +-
>  contrib/backup/qemu-backup.py   | 309 ++++++++++++++++++++++++++++++++++=
++++++
>  contrib/backup/qemu-backup.texi | 135 ++++++++++++++++++
>  3 files changed, 455 insertions(+), 4 deletions(-)
>  create mode 100644 contrib/backup/qemu-backup.py
>  create mode 100644 contrib/backup/qemu-backup.texi

Hi Ishani,
Please send a v2 with the DOCS .pdf issue and my review comments from
the previous email addressed:
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02021.html

Thanks,
Stefan

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZjYA3AAoJEJykq7OBq3PIB7EIAK7VOyA9Fe7SOiy97xDue0C/
aMLsJuotMrJLNYtIIMIosIKk3wxQxyJXvJ5ZkzJxzJJe3EXJ9lGW+qnakFP8gs9C
bQ3xqIQz4BmWaIsJl2V2Pq++gwD4VPhLHNBAPSKsnpz1ekycESUYkue/BguJ3C3k
6JLjoUOUAbcjdVhINW47h4GSyC/aWyY9FRlJfeXmHA/P0GlURl6iqjxd/ewg/9Wf
/AQKGgkFx4zKXawASy7vI8He9tc9ZeIOCMzfnvo7j0IqSDfbNb7hdzWUuiMACc4S
OPgtSTiLhgma6OgOnW93L7eTcsSr7VB8/08kQp20zIZztz9V1htsj3fojgpVhHY=
=1Kbn
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
