Received: from eggs.gnu.org ([2001:4830:134:3::10]:58466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dJ52L-0001MC-Bk
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 17:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dJ52G-00055v-FC
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 17:32:13 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:52784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dJ52F-00053G-Fq
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 17:32:08 -0400
From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Date: Fri,  9 Jun 2017 03:01:38 +0530
Message-Id: <1496957498-17127-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] Add manpage for QEMU Backup Tool
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

Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
---
 Makefile                        |   2 +-
 contrib/backup/qemu-backup.texi | 147 ++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 contrib/backup/qemu-backup.texi

diff --git a/Makefile b/Makefile
index c830d7a..f42cb1d 100644
--- a/Makefile
+++ b/Makefile
@@ -504,7 +504,7 @@ clean:
 VERSION ?=3D $(shell cat VERSION)
=20
 dist: qemu-$(VERSION).tar.bz2
-
+qemu-backup.8: contrib/qemu-backup/qemu-backup.texi
 qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.b=
z2,%,$@)"
=20
diff --git a/contrib/backup/qemu-backup.texi b/contrib/backup/qemu-backup=
.texi
new file mode 100644
index 0000000..41e2b16
--- /dev/null
+++ b/contrib/backup/qemu-backup.texi
@@ -0,0 +1,147 @@
+                  =20
+=20
+@setfilename qemu-backup-tool-manpage
+
+@documentlanguage en
+@documentencoding UTF-8
+
+\input texinfo
+@settitle Manpage_backup_tool 1.0
+@copying
+This is a manpage for qemu_backup_tool, version 1.0.
+
+Copyright @copyright{} 2016 Free Software Foundation, Inc.
+@end copying
+@ifinfo
+@direntry
+* QEMU: (qemu-backup-tool-manpage).    Man page for QEMU backup tool.
+@end direntry
+@end ifinfo
+@iftex
+@titlepage
+@sp 7
+@center @titlefont{QEMU_backup_tool}
+@sp 1
+@center @titlefont{Man Page}
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
+
+qemu-backup command [ command options].
+
+@node  list of Commands
+@chapter  list of Commands
+@cindex chapter, first dummy
+@itemize
+@item qemu-backup guest add [--id id] [--qmp socketpath]
+@item qemu-backup guest list
+@item qemu-backup drive add [--guest guestname] [--id driveid] [--target=
 target]
+@item qemu-backup drive list [--guest guestname]
+@item qemu-backup backup [--guest guestname]
+@item qemu-backup restore [--guest guestname]
+@item qemu-backup drive-remove [--guest guestname] [--id driveid]
+@item qemu-backup remove [--guest guestname]
+@item qemu-backup drive add [--all] [--guest guestname] [--target target=
]
+@item qemu-backup backup [--inc] [--guest guestname]
+@end itemize
+@node  Command Parameters
+@chapter  Command Parameters
+@cindex chapter, first dummy
+@itemize
+@item --guest: Name of the guest.
+@item --id: id of guest or drive.
+@item --target: Destination on which you want your backup to be made.
+@item --all: Add all the drives present in a guest for backup except cd-=
rom.
+@item --inc: For incremental backup.
+@item --qmp: Path of qmp socket.
+@end itemize
+
+@node  Command Descriptions
+@chapter  Command Descriptions
+@cindex chapter, first dummy
+@itemize
+@item qemu-backup guest add [--id id] [--qmp socketpath]
+This command adds a guest to the configuration file given its path to qm=
p socket.
+example:
+qemu-backup guest add --id=3Dfedora =E2=80=93qmp=3D/var/run/qemu/fedora.=
sock
+=20
+@item qemu-backup guest list
+This commands lists the names of guests which are added to configuration=
 file.
+=20
+@item qemu-backup drive add [--guest guestname] [--id driveid] [--target=
 target]
+This command adds different drives for backup in a particular guest by g=
iving the name of drive to be backed up and target imagefile in which we =
want to store the drive backup.
+example:
+qemu-backup drive add --guest=3Dfedora --id=3Droot
+--target=3D/backup/fedora/root.img
+qemu-backup drive add --guest=3Dfedora --id=3Ddata
+--target=3D/backup/fedora/data.img
+=20
+@item qemu-backup drive list [--guest guestname]
+This commands gives the names of the drive present in a guest which are =
added for backup.
+example: qemu-backup drive list --guest=3Dfedora
+=20
+@item qemu-backup backup [--guest guestname]
+=20
+This command makes the backup of the drives, in their respective given d=
estinations. The ids of drive and their destinations are taken from the c=
onfiguration file.
+example: qemu-backup backup --guest=3Dfedora
+=20
+@item qemu-backup restore [--guest guestname]
+This command is needed if we want to restore the backup. It will list th=
e commands to be run for performing the same but will not perform any act=
ion.
+example: qemu-backup restore --guest=3Dfedora
+cp /backup/fedora/root.img /var/run/qemu/fedora/root.img
+cp /backup/fedora/data.img /var/run/qemu/fedora/data.img
+=20
+@item qemu-backup drive-remove [--guest guestname] [--id driveid]
+This command helps remove a drive which is set for backup in configurati=
on of given host.
+example: qemu-backup remove --guest=3Dfedora --id=3Droot
+=20
+@item qemu-backup remove [--guest guestname]
+This command removes the guest from the configuration file.
+example: qemu-backup remove =E2=80=93guest=3Dfedora
+=20
+@item qemu-backup drive add --all [-guest guestname] [-destination desti=
nation]
+This command adds all the drives of the guest for backup other than CDRO=
M drive. Here all the backup drives will have the same names as original =
drives and target will be the destination folder.
+example: qemu-backup drive add --all --guest fedora --destination =3D/ba=
ckup/fedora/
+=20
+@end itemize
+
+
+@node License
+@appendix License
+=20
+QEMU is a trademark of Fabrice Bellard.
+=20
+QEMU is released under the GNU General Public License (TODO: add link).
+Parts of QEMU have specific licenses, see file LICENSE.
+=20
+TODO (refer to file LICENSE, include it, include the GPL?)
+=20
+
+@bye
+
+
+=20
+
--=20
2.7.4
