Received: from eggs.gnu.org ([2001:4830:134:3::10]:57297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhynT-0005T5-OC
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 09:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhynQ-0006bq-KB
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 09:55:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dhynQ-0006bW-DB
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 09:55:44 -0400
Date: Wed, 16 Aug 2017 14:55:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170816135538.GA9792@stefanha-x1.localdomain>
References: <1502456640-9114-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1502456640-9114-3-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <1502456640-9114-3-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH 2/2] backup: QEMU Backup Tool
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


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2017 at 06:34:00PM +0530, Ishani Chugh wrote:
> qemu-backup will be a command-line tool for performing full and
> incremental disk backups on running VMs. It is intended as a
> reference implementation for management stack and backup developers
> to see QEMU's backup features in action. The tool writes details of
> guest in a configuration file and the data is retrieved from the file
> while creating a backup. The location of config file can be set as an
> environment variable QEMU_BACKUP_CONFIG. The usage is as follows:
>=20
> Add a guest
> python qemu-backup.py guest add --guest <guest_name> --qmp <socket_path>
>=20
> Add a drive for backup in a specified guest
> python qemu-backup.py drive add --guest <guest_name> --id <drive_id> [--t=
arget <target_file_path>]
>=20
> Create backup of the added drives:
> python qemu-backup.py backup --guest <guest_name>
>=20
> List all guest configs in configuration file:
> python qemu-backup.py guest list
>=20
> Restore operation
> python qemu-backup.py restore --guest <guest-name>
>=20
> Remove a guest
> python qemu-backup.py guest remove --guest <guest_name>
>=20
> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  contrib/backup/qemu-backup.py | 309 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 309 insertions(+)
>  create mode 100644 contrib/backup/qemu-backup.py

Please see my previous review comments.  They have not been addressed
yet:

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02021.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZlE7ZAAoJEJykq7OBq3PI4YsIAKjnsBGtDEza1K0cmXdONcQq
qphnt5GrtVUsF+9DGdxPlIgbr+tnRfU/rD3wM+a+G7luXuY5ZGcxwtMTHie1iTu0
UpYVwVkzR4w4JwC6BIz8CRDjQmKOi6TT2/pmrOo9rNQMRaaKkGd9xRUswnLRvps6
XsIg6/Qn00NQLBoskZJBne5U6Gjr05M/Hl5Sc0ePWNB2kJ83RVwp09Vz2BqZDa31
hbOrF8XWsF2TLxUsqAzQtknkEiYkPgdLWJLSHpwI557iRWgcTbNAvsPuh8BwIvLe
LYxUbbzHWlfuiilRM6siFSlhPRgym5REC10Q0BohxJEBjt5UUJBBENR5u9FPGsQ=
=qeLv
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
