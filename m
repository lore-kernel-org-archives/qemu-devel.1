Received: from eggs.gnu.org ([2001:4830:134:3::10]:54744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsw1X-0000YZ-V6
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsw1U-0001Eb-Nb
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:11:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dsw1U-0001Ci-EC
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:11:32 -0400
From: John Snow <jsnow@redhat.com>
References: <1504888905-22396-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1504888905-22396-2-git-send-email-chugh.ishani@research.iiit.ac.in>
Message-ID: <3c31dda5-167f-9027-1919-db2633cec304@redhat.com>
Date: Fri, 15 Sep 2017 15:11:24 -0400
MIME-Version: 1.0
In-Reply-To: <1504888905-22396-2-git-send-email-chugh.ishani@research.iiit.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/3] Add manpage for QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com



On 09/08/2017 12:41 PM, Ishani Chugh wrote:
> qemu-backup will be a command-line tool for performing full and
> incremental disk backups on running VMs. It is intended as a
> reference implementation for management stack and backup developers
> to see QEMU's backup features in action. This commit is an
> initial implementation of manpage listing the commands which the
> backup tool will support. The manpage will be built along with other
> docs when configure is provided with --enable-docs flag in the
> location contrib/backup in build directory.
>=20
> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  Makefile                        |  14 ++--
>  contrib/backup/qemu-backup.texi | 142 ++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 152 insertions(+), 4 deletions(-)
>  create mode 100644 contrib/backup/qemu-backup.texi
>=20
> diff --git a/Makefile b/Makefile
> index 337a1f6..794cac5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -209,6 +209,7 @@ ifdef BUILD_DOCS
>  DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga=
.8
>  DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt d=
ocs/interop/qemu-qmp-ref.7
>  DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt doc=
s/interop/qemu-ga-ref.7
> +DOCS+=3Dcontrib/backup/qemu-backup.html contrib/backup/qemu-backup.txt
>  ifdef CONFIG_VIRTFS
>  DOCS+=3Dfsdev/virtfs-proxy-helper.1
>  endif
> @@ -517,6 +518,8 @@ VERSION ?=3D $(shell cat VERSION)
>=20
>  dist: qemu-$(VERSION).tar.bz2
>=20
> +qemu-backup.8: contrib/backup/qemu-backup.texi
> +
>  qemu-%.tar.bz2:
>  	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar=
.bz2,%,$@)"
>=20
> @@ -728,16 +731,19 @@ fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-h=
elper.texi
>  qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
>  qemu-ga.8: qemu-ga.texi
>=20
> -html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-g=
a-ref.html
> -info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-g=
a-ref.info
> -pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-r=
ef.pdf
> -txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-r=
ef.txt
> +html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-g=
a-ref.html contrib/backup/qemu-backup.html
> +info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-g=
a-ref.info contrib/backup/qemu-backup.info
> +pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-r=
ef.pdf contrib/backup/qemu-backup.pdf
> +txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-r=
ef.txt contrib/backup/qemu-backup.txt
>=20
>  qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
>  	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi =
\
>  	qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
>  	qemu-monitor-info.texi
>=20
> +contrib/backup/qemu-backup.html contrib/backup/qemu-backup.pdf contrib=
/backup/qemu-backup.txt contrib/backup/qemu-backup.info: \
> +	contrib/backup/qemu-backup.texi
> +
>  docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
>      docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
>      docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7: \
> diff --git a/contrib/backup/qemu-backup.texi b/contrib/backup/qemu-back=
up.texi
> new file mode 100644
> index 0000000..7ad266c
> --- /dev/null
> +++ b/contrib/backup/qemu-backup.texi
> @@ -0,0 +1,142 @@
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
> +* List of Commands::
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
> +qemu-backup command [command options].
> +
> +@node  List of Commands
> +@chapter  List of Commands
> +@itemize
> +@item qemu-backup guest add --guest guestname --qmp socketpath
> +@item qemu-backup guest list
> +@item qemu-backup drive add --id driveid --guest guestname --target ta=
rget
> +@item qemu-backup drive add --all --guest guestname --target target
> +@item qemu-backup drive list --guest guestname
> +@item qemu-backup restore --guest guestname
> +@item qemu-backup guest remove --guest guestname
> +@item qemu-backup drive remove --guest guestname --id driveid
> +@end itemize
> +@node  Command Parameters
> +@chapter  Command Parameters
> +@itemize
> +@item --all: Add all the drives present in a guest which are suitable =
for backup.
> +@item --guest: Name of the guest.
> +@item --id: id of guest or drive.
> +@item --qmp: Path of qmp socket.
> +@item --target: Destination path on which you want your backup to be m=
ade.
> +@end itemize
> +
> +@node  Command Descriptions
> +@chapter  Command Descriptions
> +@itemize
> +@item qemu-backup guest add --guest guestname --qmp socketpath
> +This command adds a guest to the configuration file given its path to =
qmp socket.

In the generated output (contrib/backup/qemu-backup.html) this doesn't
actually create a newline, and the resultant text looks like this:

qemu-backup guest add =E2=80=93guest guestname =E2=80=93qmp socketpath Th=
is command adds
a guest to the configuration file given its path to qmp socket.

Looking at some other texi docs, @item appears by itself on a newline:

(from qemu-doc.texi:)

@item
QEMU can optionally use an in-kernel accelerator, like kvm. The
accelerators
execute most of the guest code natively, while
continuing to emulate the rest of the machine.

If your intention was to create a heading and a paragraph, you may need
additional markup to accomplish this. The resulting documentation is a
little difficult to read otherwise.

> +
> +example:

Perhaps "examples" as there are two that follow.

> +qemu-backup guest add --id=3Dfedora --qmp=3Dunix:/var/run/qemu/fedora.=
sock
> +
> +qemu-backup guest add --id=3Dfedora --qmp=3Dtcp:localhost:4444
> +
> +@item qemu-backup guest list
> +This commands lists the names of guests which are added to configurati=
on file.

"to the configuration file"

> +
> +@item qemu-backup drive add --guest guestname --id driveid --target ta=
rget
> +This command adds different drives for backup in a particular guest by=
 giving the name of drive to be backed up and target imagefile in which w=
e want to store the drive backup.

"of the drive",
"and a target image file where the drive backup is to be stored."

> +
> +example: qemu-backup drive add --guest=3Dfedora --id=3Droot --target=3D=
/backup/root.img
> +
> +@item qemu-backup drive add --all --guest guestname --destination dest=
ination
> +This command adds all the drives of the guest for backup other than CD=
ROM drive and read-only drives. Here all the backup drives will have the =
same names as original drives and target will be the destination folder.
> +
> +example: qemu-backup drive add --all --guest fedora --destination =3D/=
backup/fedora/
> +

extra space between destination and =3D/backup/fedora

> +@item qemu-backup drive list --guest guestname
> +This commands gives the names of the drive present in a guest which ar=
e added for backup.
> +

"of the drives", and perhaps "which have been configured for backup"

> +example: qemu-backup drive list --guest=3Dfedora
> +
> +@item qemu-backup backup --guest guestname
> +
> +This command makes the backup of the drives, in their respective given=
 destinations. The ids of drive and their destinations are taken from the=
 configuration file.
> +
> +example: qemu-backup backup --guest=3Dfedora
> +
> +@item qemu-backup restore --guest guestname
> +This command is needed if we want to restore the backup. It will list =
the commands to be run for performing the same but will not perform any a=
ction.
> +

Might be worthwhile to explain why it won't automatically perform these
actions for you, i.e. any one of these reasons:

- To allow you to safely shut down your VM to preserve data integrity
for drives that are (perhaps) not being restored
- To allow the administrator a chance to move backups that were moved
off-site back onto the server
- To allow the administrator a chance to move backups in a more
efficient way if possible/desired (a python utility may not always have
the best information for how to do an efficient restoration, for
instance...)

> +example: qemu-backup restore --guest=3Dfedora
> +
> +@item qemu-backup guest remove --guest guestname
> +This command removes the guest from the configuration file.
> +
> +example: qemu-backup guest remove --guest=3Dfedora
> +
> +@item qemu-backup drive remove --guest guestname --id driveid
> +This command helps remove a drive which is set for backup in configura=
tion of given host.
> +

"helps remove" should just be "removes"

> +example: drive remove --guest=3Dfedora --id=3Droot
> +
> +@item A full backup can be performed by following the given steps:
> +
> +Perform a full backup of 'vm001', which has one drive:
> +
> +qemu-backup guest add --guest vm001 --qmp /path/to/vm001.sock
> +
> +qemu-backup add --id drive0 --guest vm001 --target /backups/vm001-driv=
e0.img
> +
> +qemu-backup backup --guest vm001
> +
> +
> +@end itemize
> +
> +@node License
> +@appendix License
> +QEMU is a trademark of Fabrice Bellard.
> +QEMU is released under the
> +@url{https://www.gnu.org/licenses/gpl-2.0.txt,GNU General Public Licen=
se},
> +version 2. Parts of QEMU have specific licenses, see file
> +@url{http://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3DLICENSE,LICE=
NSE}.
> +@bye
> --
> 2.7.4
>=20

Looks good so far, thank you for your work this summer :)

Since Stefan gave his Reviewed-by for the whole series, I'll leave it up
to you as to whether or not you want to continue sending revisions. If
you'd like to move on and work on something else, I can always send some
fixup patches myself.

Let me know!

In the event that you'd like to press on:

Reviewed-by: John Snow <jsnow@redhat.com>
