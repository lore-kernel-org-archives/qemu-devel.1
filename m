Received: from eggs.gnu.org ([2001:4830:134:3::10]:34694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dOSzN-0001Ia-NR
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dOSzK-0003Yz-F5
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:07:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dOSzK-0003Ya-5X
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:07:22 -0400
References: <1498155182-27351-1-git-send-email-chugh.ishani@research.iiit.ac.in>
From: John Snow <jsnow@redhat.com>
Message-ID: <9509537b-2984-db02-e8eb-084ec53e29a4@redhat.com>
Date: Fri, 23 Jun 2017 14:07:17 -0400
MIME-Version: 1.0
In-Reply-To: <1498155182-27351-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] Add manpage for QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com



On 06/22/2017 02:13 PM, Ishani Chugh wrote:
> qemu-backup will be a command-line tool for performing full and increme=
ntal disk backups on running VMs.  It is intended as a reference implemen=
tation for management stack and backup developers to see QEMU's backup fe=
atures in action. The following commit is an initial implementation of ma=
npage listing the commands which the backup tool will support.
>=20

Try wrapping your commit messages to about 72-73 columns or so.

> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  Makefile                        |   2 +-
>  contrib/backup/qemu-backup.texi | 132 ++++++++++++++++++++++++++++++++=
++++++++
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

It's OK to leave the newline in here.

> +qemu-backup.8: contrib/backup/qemu-backup.texi

What command do I need to invoke to actually build this? I guess it
doesn't get build unless I type "make qemu-backup.8" explicitly. Maybe
this should build with other manpage documents? (Unless Stefan told you
not to?)

>  qemu-%.tar.bz2:
>  	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar=
.bz2,%,$@)"
> =20
> diff --git a/contrib/backup/qemu-backup.texi b/contrib/backup/qemu-back=
up.texi
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

The file I am seeing generated includes this line and nothing else
afterwards.

I am doing this:

cd ~/src/qemu
mkdir -p bin/git
cd bin/git
../../configure --enable-docs --target-list=3Dx86_64-softmmu
make qemu-backup.8

Then I am attempting to view the manual:
man ./qemu-backup.8

but it appears mostly blank, so I think we probably have the wrong
syntax below. You can look at the intermediate file "qemu-backup.8.pod"
and see that it is mostly empty.

Am I doing this wrong?


As an aside, a question for the list:

Why are we using a perl script to convert texi->pod->man instead of just
using something like pandoc directly?

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
> +@node  List of Commands
> +@chapter  List of Commands
> +@itemize
> +@item qemu-backup guest add --guest guestname --qmp socketpath
> +@item qemu-backup guest list
> +@item qemu-backup drive add --id driveid --guest guestname --target ta=
rget
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
> +@item --target: Destination path on which you want your backup to be m=
ade.
> +@item --all: Add all the drives present in a guest which are suitable =
for backup.
> +@item --inc: For incremental backup.
> +@item --qmp: Path of qmp socket.
> +@end itemize
> +
> +@node  Command Descriptions
> +@chapter  Command Descriptions
> +@itemize
> +@item qemu-backup guest add --guest guestname --qmp socketpath
> +This command adds a guest to the configuration file given its path to =
qmp socket.
> +
> +example:
> +qemu-backup guest add --id=3Dfedora =E2=80=93qmp=3D/var/run/qemu/fedor=
a.sock
> +
> +@item qemu-backup guest list
> +This commands lists the names of guests which are added to configurati=
on file.
> +
> +@item qemu-backup drive add --guest guestname --id driveid --target ta=
rget
> +This command adds different drives for backup in a particular guest by=
 giving the name of drive to be backed up and target imagefile in which w=
e want to store the drive backup.
> +
> +example:qemu-backup drive add --guest=3Dfedora --id=3Droot
> +--target=3D/backup/root.img
> +
> +@item qemu-backup drive add --all --guest guestname --destination dest=
ination
> +This command adds all the drives of the guest for backup other than CD=
ROM drive. Here all the backup drives will have the same names as origina=
l drives and target will be the destination folder.
> +
> +example: qemu-backup drive add --all --guest fedora --destination =3D/=
backup/fedora/
> +
> +@item qemu-backup drive list --guest guestname
> +This commands gives the names of the drive present in a guest which ar=
e added for backup.
> +
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
> +example: qemu-backup restore --guest=3Dfedora
> +
> +@item qemu-backup drive remove --guest guestname --id driveid
> +This command helps remove a drive which is set for backup in configura=
tion of given host.
> +
> +example: drive remove --guest=3Dfedora --id=3Droot
> +
> +@item qemu-backup guest remove --guest guestname
> +This command removes the guest from the configuration file.
> +
> +example: qemu-backup guest remove --guest=3Dfedora
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
>=20
