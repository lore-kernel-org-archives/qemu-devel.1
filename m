Received: from eggs.gnu.org ([2001:4830:134:3::10]:53851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dOPL0-000418-LG
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 10:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dOPKv-0001hg-Ip
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 10:13:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dOPKv-0001h4-8F
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 10:13:25 -0400
Date: Fri, 23 Jun 2017 15:13:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170623141317.GD12689@stefanha-x1.localdomain>
References: <1498155182-27351-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <1498155182-27351-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH v4] Add manpage for QEMU Backup Tool
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


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 11:43:02PM +0530, Ishani Chugh wrote:

I'm happy with the overall command-line interface.  A few minor comments
below.

> qemu-backup will be a command-line tool for performing full and increment=
al disk backups on running VMs.  It is intended as a reference implementati=
on for management stack and backup developers to see QEMU's backup features=
 in action. The following commit is an initial implementation of manpage li=
sting the commands which the backup tool will support.
>=20
> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  Makefile                        |   2 +-
>  contrib/backup/qemu-backup.texi | 132 ++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 133 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/backup/qemu-backup.texi
>=20
> diff --git a/Makefile b/Makefile
> index c830d7a..094f291 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -504,7 +504,7 @@ clean:
>  VERSION ?=3D $(shell cat VERSION)
> =20
>  dist: qemu-$(VERSION).tar.bz2
> -
> +qemu-backup.8: contrib/backup/qemu-backup.texi

This generates a man page.  Documentation should also be generated in
other output formats (.info, .html, .pdf, .txt).

Please add the other documentation output file formats (see Makefile for
examples).

>  qemu-%.tar.bz2:
>  	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.b=
z2,%,$@)"
> =20
> diff --git a/contrib/backup/qemu-backup.texi b/contrib/backup/qemu-backup=
=2Etexi
> new file mode 100644
> index 0000000..cdfad82
> --- /dev/null
> +++ b/contrib/backup/qemu-backup.texi
> @@ -0,0 +1,132 @@
> +\input texinfo
> +@setfilename qemu-backup
> +
> +@documentlanguage en
> +@documentencoding UTF-8
> +
> +@settitle QEMU Backup Tool
> +@copying
> +
> +Copyright @copyright{} 2017 The QEMU Project developers
> +@end copying
> +@ifinfo
> +@direntry
> +* QEMU: (QEMU-backup).    Man page for QEMU Backup Tool.
> +@end direntry
> +@end ifinfo
> +@iftex
> +@titlepage
> +@sp 7
> +@center @titlefont{QEMU Backup Tool}
> +@sp 1
> +@sp 3
> +@end titlepage
> +@end iftex
> +@ifnottex
> +@node Top
> +@top Short Sample
> +
> +@menu
> +* Name::
> +* Synopsis::
> +* list of Commands::

s/list/List/

> +* Command Parameters::
> +* Command Descriptions::
> +* License::
> +@end menu
> +
> +@end ifnottex
> +
> +@node Name
> +@chapter Name
> +
> +QEMU disk backup tool.
> +
> +@node Synopsis
> +@chapter Synopsis
> +
> +qemu-backup command [ command options].

s/[ command options]/[command options]/

> +
> +@node  List of Commands
> +@chapter  List of Commands
> +@itemize
> +@item qemu-backup guest add --guest guestname --qmp socketpath
> +@item qemu-backup guest list
> +@item qemu-backup drive add --id driveid --guest guestname --target targ=
et
> +@item qemu-backup drive add --all --guest guestname --target target
> +@item qemu-backup drive list --guest guestname
> +@item qemu-backup backup [--inc] --guest guestname
> +@item qemu-backup restore --guest guestname
> +@item qemu-backup drive remove --guest guestname --id driveid
> +@item qemu-backup guest remove --guest guestname
> +@end itemize
> +@node  Command Parameters
> +@chapter  Command Parameters
> +@itemize
> +@item --guest: Name of the guest.
> +@item --id: id of guest or drive.
> +@item --target: Destination path on which you want your backup to be mad=
e.
> +@item --all: Add all the drives present in a guest which are suitable fo=
r backup.
> +@item --inc: For incremental backup.
> +@item --qmp: Path of qmp socket.

Does this support both UNIX domain sockets (/path/to/qmp.sock) and TCP
(localhost:1234)?  Please document this.

> +@end itemize
> +
> +@node  Command Descriptions
> +@chapter  Command Descriptions
> +@itemize
> +@item qemu-backup guest add --guest guestname --qmp socketpath
> +This command adds a guest to the configuration file given its path to qm=
p socket.
> +
> +example:
> +qemu-backup guest add --id=3Dfedora =E2=80=93qmp=3D/var/run/qemu/fedora.=
sock

Careful, there is a En Dash (U+2013) character here instead of a
Hypen-Minus (U+002D):

s/=E2=80=93/--/

Please use the ASCII character so the example can be copy-pasted and
executes correctly.

> +
> +@item qemu-backup guest list
> +This commands lists the names of guests which are added to configuration=
 file.
> +
> +@item qemu-backup drive add --guest guestname --id driveid --target targ=
et
> +This command adds different drives for backup in a particular guest by g=
iving the name of drive to be backed up and target imagefile in which we wa=
nt to store the drive backup.
> +
> +example:qemu-backup drive add --guest=3Dfedora --id=3Droot
> +--target=3D/backup/root.img

The line is wrapped.  An example should not be formatted since it cannot
be copy-pasted into a shell with newlines in the middle:

example:
qemu-backup drive add --guest=3Dfedora --id=3Droot --target=3D/backup/root.=
img

> +
> +@item qemu-backup drive add --all --guest guestname --destination destin=
ation
> +This command adds all the drives of the guest for backup other than CDRO=
M drive. Here all the backup drives will have the same names as original dr=
ives and target will be the destination folder.

Read-only drives shouldn't be included either.  Please say "all drives
except read-only".

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZTSH9AAoJEJykq7OBq3PInfAH/2NLzsxOBtniDorSx5eUB95c
HtyoMwAuo+t9rSJJEL7OB4GuoqU72JftUE+LzRjGtxiic/71FETlajjC9cedXe4T
mRH8Ebk3WNauZWPS07J0tGS/c8L0Ya2UOxDIXR31TCKbKFSJeRtHhExymBA1i9EA
QwhaCAL4SUp5jaidzy2khBLP342kqfcK4NRVjysFcvUuCw0Aqo4XJ/sWtYN1DHNb
QQbjC6p0l1RIFQwxcheJ02Q0+gqPfnaEJ8dWqFCei9COmvTJvyPb75QHGt7kMetu
q/Pe7u9rgQ/lK0tf27Cj8k2QkLEmR9lD9vcqqWrL9L/JeAy3HRJujTbgAbjT+8U=
=+36e
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
