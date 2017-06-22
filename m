Received: from eggs.gnu.org ([2001:4830:134:3::10]:47020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dO6bc-0001mZ-Lw
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dO6bZ-0002ZT-Dc
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:13:24 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:37810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dO6bY-0002Xc-EQ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:13:21 -0400
From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Date: Thu, 22 Jun 2017 23:43:02 +0530
Message-Id: <1498155182-27351-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4] Add manpage for QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jsnow@redhat.com, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

qemu-backup will be a command-line tool for performing full and increment=
al disk backups on running VMs.  It is intended as a reference implementa=
tion for management stack and backup developers to see QEMU's backup feat=
ures in action. The following commit is an initial implementation of manp=
age listing the commands which the backup tool will support.

Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
---
 Makefile                        |   2 +-
 contrib/backup/qemu-backup.texi | 132 ++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 contrib/backup/qemu-backup.texi

diff --git a/Makefile b/Makefile
index c830d7a..094f291 100644
--- a/Makefile
+++ b/Makefile
@@ -504,7 +504,7 @@ clean:
 VERSION ?=3D $(shell cat VERSION)
=20
 dist: qemu-$(VERSION).tar.bz2
-
+qemu-backup.8: contrib/backup/qemu-backup.texi
 qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.b=
z2,%,$@)"
=20
diff --git a/contrib/backup/qemu-backup.texi b/contrib/backup/qemu-backup=
.texi
new file mode 100644
index 0000000..cdfad82
--- /dev/null
+++ b/contrib/backup/qemu-backup.texi
@@ -0,0 +1,132 @@
+\input texinfo
+@setfilename qemu-backup
+
+@documentlanguage en
+@documentencoding UTF-8
+
+@settitle QEMU Backup Tool
+@copying
+
+Copyright @copyright{} 2017 The QEMU Project developers
+@end copying
+@ifinfo
+@direntry
+* QEMU: (QEMU-backup).    Man page for QEMU Backup Tool.
+@end direntry
+@end ifinfo
+@iftex
+@titlepage
+@sp 7
+@center @titlefont{QEMU Backup Tool}
+@sp 1
+@sp 3
+@end titlepage
+@end iftex
+@ifnottex
+@node Top
+@top Short Sample
+
+@menu
+* Name::
+* Synopsis::
+* list of Commands::
+* Command Parameters::
+* Command Descriptions::
+* License::
+@end menu
+
+@end ifnottex
+
+@node Name
+@chapter Name
+
+QEMU disk backup tool.
+
+@node Synopsis
+@chapter Synopsis
+
+qemu-backup command [ command options].
+
+@node  List of Commands
+@chapter  List of Commands
+@itemize
+@item qemu-backup guest add --guest guestname --qmp socketpath
+@item qemu-backup guest list
+@item qemu-backup drive add --id driveid --guest guestname --target targ=
et
+@item qemu-backup drive add --all --guest guestname --target target
+@item qemu-backup drive list --guest guestname
+@item qemu-backup backup [--inc] --guest guestname
+@item qemu-backup restore --guest guestname
+@item qemu-backup drive remove --guest guestname --id driveid
+@item qemu-backup guest remove --guest guestname
+@end itemize
+@node  Command Parameters
+@chapter  Command Parameters
+@itemize
+@item --guest: Name of the guest.
+@item --id: id of guest or drive.
+@item --target: Destination path on which you want your backup to be mad=
e.
+@item --all: Add all the drives present in a guest which are suitable fo=
r backup.
+@item --inc: For incremental backup.
+@item --qmp: Path of qmp socket.
+@end itemize
+
+@node  Command Descriptions
+@chapter  Command Descriptions
+@itemize
+@item qemu-backup guest add --guest guestname --qmp socketpath
+This command adds a guest to the configuration file given its path to qm=
p socket.
+
+example:
+qemu-backup guest add --id=3Dfedora =E2=80=93qmp=3D/var/run/qemu/fedora.=
sock
+
+@item qemu-backup guest list
+This commands lists the names of guests which are added to configuration=
 file.
+
+@item qemu-backup drive add --guest guestname --id driveid --target targ=
et
+This command adds different drives for backup in a particular guest by g=
iving the name of drive to be backed up and target imagefile in which we =
want to store the drive backup.
+
+example:qemu-backup drive add --guest=3Dfedora --id=3Droot
+--target=3D/backup/root.img
+
+@item qemu-backup drive add --all --guest guestname --destination destin=
ation
+This command adds all the drives of the guest for backup other than CDRO=
M drive. Here all the backup drives will have the same names as original =
drives and target will be the destination folder.
+
+example: qemu-backup drive add --all --guest fedora --destination =3D/ba=
ckup/fedora/
+
+@item qemu-backup drive list --guest guestname
+This commands gives the names of the drive present in a guest which are =
added for backup.
+
+example: qemu-backup drive list --guest=3Dfedora
+
+@item qemu-backup backup --guest guestname
+
+This command makes the backup of the drives, in their respective given d=
estinations. The ids of drive and their destinations are taken from the c=
onfiguration file.
+
+example: qemu-backup backup --guest=3Dfedora
+
+@item qemu-backup restore --guest guestname
+This command is needed if we want to restore the backup. It will list th=
e commands to be run for performing the same but will not perform any act=
ion.
+
+example: qemu-backup restore --guest=3Dfedora
+
+@item qemu-backup drive remove --guest guestname --id driveid
+This command helps remove a drive which is set for backup in configurati=
on of given host.
+
+example: drive remove --guest=3Dfedora --id=3Droot
+
+@item qemu-backup guest remove --guest guestname
+This command removes the guest from the configuration file.
+
+example: qemu-backup guest remove --guest=3Dfedora
+
+@end itemize
+
+@node License
+@appendix License
+QEMU is a trademark of Fabrice Bellard.
+QEMU is released under the
+@url{https://www.gnu.org/licenses/gpl-2.0.txt,GNU General Public License=
},
+version 2. Parts of QEMU have specific licenses, see file
+@url{http://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3DLICENSE,LICENS=
E}.
+@bye
--=20
2.7.4
