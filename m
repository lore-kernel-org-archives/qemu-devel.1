Received: from eggs.gnu.org ([2001:4830:134:3::10]:40481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLACL-0004NG-5W
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLACH-0001iX-Pa
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dLACH-0001hp-GX
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:27:05 -0400
Date: Wed, 14 Jun 2017 16:26:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170614152654.GE11398@stefanha-x1.localdomain>
References: <1497367206-4295-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Content-Disposition: inline
In-Reply-To: <1497367206-4295-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH v2] Add manpage for QEMU Backup Tool
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


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 08:50:06PM +0530, Ishani Chugh wrote:

Please include a commit description.  In this case it would be
appropriate to explain that qemu-backup will be a command-line tool for
performing full and incremental disk backups on running VMs.  It is
intended as a reference implementation for management stack and backup
developers to see QEMU's backup features in action.

> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  Makefile                        |   2 +-
>  contrib/backup/qemu-backup.texi | 139 ++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/backup/qemu-backup.texi
>=20
> diff --git a/Makefile b/Makefile
> index c830d7a..f42cb1d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -504,7 +504,7 @@ clean:
>  VERSION ?=3D $(shell cat VERSION)
> =20
>  dist: qemu-$(VERSION).tar.bz2
> -
> +qemu-backup.8: contrib/qemu-backup/qemu-backup.texi
>  qemu-%.tar.bz2:
>  	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.b=
z2,%,$@)"
> =20
> diff --git a/contrib/backup/qemu-backup.texi b/contrib/backup/qemu-backup=
=2Etexi
> new file mode 100644
> index 0000000..1db63c0
> --- /dev/null
> +++ b/contrib/backup/qemu-backup.texi
> @@ -0,0 +1,139 @@
> +@setfilename qemu-backup-tool-manpage

I think just "qemu-backup" is fine, judging by other uses of
@setfilename.

> +
> +@documentlanguage en
> +@documentencoding UTF-8
> +
> +\input texinfo
> +@settitle Manpage_backup_tool 1.0

All other uses of @settitle have a humand readable title like "QEMU
Guest Agent".  Please use "QEMU Backup Tool" or something similar.

> +@copying
> +This is a manpage for qemu_backup_tool, version 1.0.

Please drop this line.  Looking at man pages for ls(1), wget(1), etc
they tend to give the copyright and documentation license terms.

Please don't hardcode a version number for now.

> +
> +Copyright @copyright{} 2016 Free Software Foundation, Inc.

I suggest:

Copyright @copyright{} 2017 The QEMU Project developers

> +@end copying
> +@ifinfo
> +@direntry
> +* QEMU: (qemu-backup-tool-manpage).    Man page for QEMU backup tool.
> +@end direntry
> +@end ifinfo
> +@iftex
> +@titlepage
> +@sp 7
> +@center @titlefont{QEMU_backup_tool}
> +@sp 1
> +@center @titlefont{Man Page}
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
> +
> +@node  list of Commands
> +@chapter  list of Commands
> +@cindex chapter, first dummy
> +@itemize
> +@item qemu-backup guest add [--id id] [--qmp socketpath]

Both --id and --qmp are required options, please drop the block quotes
('[', ']').  The same applies to most options below, too.

> +@item qemu-backup guest list
> +@item qemu-backup drive add [--guest guestname] [--id driveid] [--target=
 target]
> +@item qemu-backup drive list [--guest guestname]
> +@item qemu-backup backup [--guest guestname]
> +@item qemu-backup restore [--guest guestname]
> +@item qemu-backup drive-remove [--guest guestname] [--id driveid]

It's more consistent to call it "drive remove" instead of
"drive-remove" since its dual is "drive add".

> +@item qemu-backup remove [--guest guestname]

"guest add" <-> "guest remove"

> +@item qemu-backup drive add [--all] [--guest guestname] [--target target]

Please move this below the other "drive add" definition.

> +@item qemu-backup backup [--inc] [--guest guestname]

Please move this below the other "backup" definition.

> +@end itemize
> +@node  Command Parameters
> +@chapter  Command Parameters
> +@cindex chapter, first dummy
> +@itemize
> +@item --guest: Name of the guest.

"id of guest" would make it clearer that --guest ID is the same value as gi=
ven
by --id ID.  Otherwise the reader might wonder what the difference
between a "name" and an "id" is.

> +@item --id: id of guest or drive.
> +@item --target: Destination on which you want your backup to be made.

Adding the word "path" may help make it clear that this is a file or
directory name.

> +@item --all: Add all the drives present in a guest for backup except cd-=
rom.

There may be other conditions besides excluding CD-ROM drives (e.g.
other read-only drives).  I suggest simply saying "Automatically add all
drives that are suitable for backups".

> +@node License
> +@appendix License
> +
> +QEMU is a trademark of Fabrice Bellard.
> +
> +QEMU is released under the GNU General Public License (TODO: add link).
> +Parts of QEMU have specific licenses, see file LICENSE.
> +
> +TODO (refer to file LICENSE, include it, include the GPL?)

Most documentation in docs/ is licensed under the GPL.  I recommend
following that.

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQVW+AAoJEJykq7OBq3PIxCsH/2eZ6YnBc97jPURIbUpZW8SI
wYLivEXoKvkBDTSf4O0Ow2KvCtaxKSp+3nP7TVHK72dZ+QsYgKjoIigNfDC/h9qb
GFBLIRZ7UiVYGf7Nu0iCIEfoWGEUkEf4wvEnwepl6vj7gXCUAKiMCH4mIJr+0K/6
1hlJxuvo7aufL6m5caZj2yfy6k6/QWcti12zheegyXIrEkhmXtGz+DnhrJMaxTl7
OS6DAQSjmMgBm2rfGQGXxRry0ljaAplZxve1C8y1LHjby2KQKM2TiflghXcp2gm0
Z5e1f4MdNh70asV47RE6dsbPTOjC5izi9VB0qcUv5pbBM/Wmrps26EiJ/Nyz5Y4=
=8Tjd
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
