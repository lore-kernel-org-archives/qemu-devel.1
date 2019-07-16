Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCB4C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C5E2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C5E2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOxE-0005CD-0F
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51827)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hnOwr-0004O9-JU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hnOwj-0004e6-PW
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:00:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:54408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hnOwh-0004ca-P4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:00:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hnOwe-0004GT-MV
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 15:00:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A4DFE2E80C9
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 15:00:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jul 2019 14:54:18 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: glaubitz
X-Launchpad-Bug-Reporter: John Paul Adrian Glaubitz (glaubitz)
X-Launchpad-Bug-Modifier: John Paul Adrian Glaubitz (glaubitz)
Message-Id: <156328885828.28617.11205877889338881511.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 2b190d7f301854e57e8d0a6961f6a57a33ebec9f
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836763] [NEW] Firebird crashes on qemu-m68k-user
 with pthread_mutex_init error
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1836763 <1836763@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Trying to use the Firebird database on qemu-m68k-user with a Debian
chroot fails with the database crashing with "ConfigStorage: mutex
pthread_mutex_init error, status =3D 95":

(sid-m68k-sbuild)root@epyc:/# apt install firebird3.0-server
Reading package lists... Done
Building dependency tree       =

Reading state information... Done
The following packages were automatically installed and are no longer requi=
red:
  cpio libip4tc0
Use 'apt autoremove' to remove them.
The following additional packages will be installed:
  firebird3.0-common firebird3.0-common-doc firebird3.0-server-core firebir=
d3.0-utils libfbclient2 libib-util
Suggested packages:
  firebird3.0-doc
The following NEW packages will be installed:
  firebird3.0-common firebird3.0-common-doc firebird3.0-server firebird3.0-=
server-core firebird3.0-utils libfbclient2 libib-util
0 upgraded, 7 newly installed, 0 to remove and 4 not upgraded.
Need to get 4,051 kB of archives.
After this operation, 15.9 MB of additional disk space will be used.
Do you want to continue? [Y/n] =

Get:1 http://ftp.ports.debian.org/debian-ports unstable/main m68k firebird3=
.0-common-doc all 3.0.5.33100.ds4-3 [35.3 kB]
Get:2 http://ftp.ports.debian.org/debian-ports unstable/main m68k firebird3=
.0-common all 3.0.5.33100.ds4-3 [14.5 kB]
Get:3 http://ftp.ports.debian.org/debian-ports unstable/main m68k libfbclie=
nt2 m68k 3.0.5.33100.ds4-3 [496 kB]
Get:4 http://ftp.ports.debian.org/debian-ports unstable/main m68k libib-uti=
l m68k 3.0.5.33100.ds4-3 [3,220 B]
Get:5 http://ftp.ports.debian.org/debian-ports unstable/main m68k firebird3=
.0-server-core m68k 3.0.5.33100.ds4-3 [2,368 kB]
Get:6 http://ftp.ports.debian.org/debian-ports unstable/main m68k firebird3=
.0-utils m68k 3.0.5.33100.ds4-3 [770 kB]
Get:7 http://ftp.ports.debian.org/debian-ports unstable/main m68k firebird3=
.0-server m68k 3.0.5.33100.ds4-3 [365 kB]
Fetched 4,051 kB in 2s (1,803 kB/s)          =

debconf: delaying package configuration, since apt-utils is not installed
E: Can not write log (Is /dev/pts mounted?) - posix_openpt (19: No such dev=
ice)
Selecting previously unselected package firebird3.0-common-doc.
(Reading database ... 33605 files and directories currently installed.)
Preparing to unpack .../0-firebird3.0-common-doc_3.0.5.33100.ds4-3_all.deb =
...
Unpacking firebird3.0-common-doc (3.0.5.33100.ds4-3) ...
Selecting previously unselected package firebird3.0-common.
Preparing to unpack .../1-firebird3.0-common_3.0.5.33100.ds4-3_all.deb ...
Unpacking firebird3.0-common (3.0.5.33100.ds4-3) ...
Selecting previously unselected package libfbclient2:m68k.
Preparing to unpack .../2-libfbclient2_3.0.5.33100.ds4-3_m68k.deb ...
Unpacking libfbclient2:m68k (3.0.5.33100.ds4-3) ...
Selecting previously unselected package libib-util:m68k.
Preparing to unpack .../3-libib-util_3.0.5.33100.ds4-3_m68k.deb ...
Unpacking libib-util:m68k (3.0.5.33100.ds4-3) ...
Selecting previously unselected package firebird3.0-server-core:m68k.
Preparing to unpack .../4-firebird3.0-server-core_3.0.5.33100.ds4-3_m68k.de=
b ...
Unpacking firebird3.0-server-core:m68k (3.0.5.33100.ds4-3) ...
Selecting previously unselected package firebird3.0-utils.
Preparing to unpack .../5-firebird3.0-utils_3.0.5.33100.ds4-3_m68k.deb ...
Unpacking firebird3.0-utils (3.0.5.33100.ds4-3) ...
Selecting previously unselected package firebird3.0-server.
Preparing to unpack .../6-firebird3.0-server_3.0.5.33100.ds4-3_m68k.deb ...
Unpacking firebird3.0-server (3.0.5.33100.ds4-3) ...
Setting up firebird3.0-common-doc (3.0.5.33100.ds4-3) ...
Setting up firebird3.0-common (3.0.5.33100.ds4-3) ...
Setting up libib-util:m68k (3.0.5.33100.ds4-3) ...
Setting up libfbclient2:m68k (3.0.5.33100.ds4-3) ...
Setting up firebird3.0-utils (3.0.5.33100.ds4-3) ...
Setting up firebird3.0-server-core:m68k (3.0.5.33100.ds4-3) ...
Setting up firebird3.0-server (3.0.5.33100.ds4-3) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based f=
rontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line=
 76.)
debconf: falling back to frontend: Readline
Password for firebird 3.0
-------------------------

Firebird has a special user named SYSDBA, which is the user that has access=
 to all databases. SYSDBA can also create new databases and users. Because =
of this, it is
necessary to secure SYSDBA with a password.

The password is stored in /etc/firebird/3.0/SYSDBA.password (readable only =
by root). You may modify it there (don't forget to update the security data=
base too, using the
gsec utility), or you may use dpkg-reconfigure to update both.

If you don't enter a password, a random one will be used (and stored in
SYSDBA.password).

Password for SYSDBA:

adduser: Warning: The home directory `/var/lib/firebird' does not belong to=
 the user you are currently creating.
ConfigStorage: mutex pthread_mutex_init error, status =3D 95
qemu: uncaught target signal 6 (Aborted) - core dumped
Aborted
dpkg: error processing package firebird3.0-server (--configure):
 installed firebird3.0-server package post-installation script subprocess r=
eturned error exit status 134
Processing triggers for systemd (241-6+b2) ...
Processing triggers for man-db (2.8.5-2) ...
Not building database; man-db/auto-update is not 'true'.
Processing triggers for libc-bin (2.28-10+qemu) ...
Errors were encountered while processing:
 firebird3.0-server
E: Sub-process /usr/bin/dpkg returned an error code (1)
(sid-m68k-sbuild)root@epyc:/# SEC_SQL=3D/usr/share/firebird/3.0/security.sq=
l T=3D/tmp/tmp.2kBDCgAevm T_SEC=3D/tmp/tmp.2kBDCgAevm/security.fdb isql-fb =
-q
SQL> create database '/tmp/tmp.2kBDCgAevm/security.fdb';
ConfigStorage: mutex pthread_mutex_init error, status =3D 95
qemu: uncaught target signal 6 (Aborted) - core dumped
Aborted
(sid-m68k-sbuild)root@epyc:/#

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836763

Title:
  Firebird crashes on qemu-m68k-user with pthread_mutex_init error

Status in QEMU:
  New

Bug description:
  Trying to use the Firebird database on qemu-m68k-user with a Debian
  chroot fails with the database crashing with "ConfigStorage: mutex
  pthread_mutex_init error, status =3D 95":

  (sid-m68k-sbuild)root@epyc:/# apt install firebird3.0-server
  Reading package lists... Done
  Building dependency tree       =

  Reading state information... Done
  The following packages were automatically installed and are no longer req=
uired:
    cpio libip4tc0
  Use 'apt autoremove' to remove them.
  The following additional packages will be installed:
    firebird3.0-common firebird3.0-common-doc firebird3.0-server-core fireb=
ird3.0-utils libfbclient2 libib-util
  Suggested packages:
    firebird3.0-doc
  The following NEW packages will be installed:
    firebird3.0-common firebird3.0-common-doc firebird3.0-server firebird3.=
0-server-core firebird3.0-utils libfbclient2 libib-util
  0 upgraded, 7 newly installed, 0 to remove and 4 not upgraded.
  Need to get 4,051 kB of archives.
  After this operation, 15.9 MB of additional disk space will be used.
  Do you want to continue? [Y/n] =

  Get:1 http://ftp.ports.debian.org/debian-ports unstable/main m68k firebir=
d3.0-common-doc all 3.0.5.33100.ds4-3 [35.3 kB]
  Get:2 http://ftp.ports.debian.org/debian-ports unstable/main m68k firebir=
d3.0-common all 3.0.5.33100.ds4-3 [14.5 kB]
  Get:3 http://ftp.ports.debian.org/debian-ports unstable/main m68k libfbcl=
ient2 m68k 3.0.5.33100.ds4-3 [496 kB]
  Get:4 http://ftp.ports.debian.org/debian-ports unstable/main m68k libib-u=
til m68k 3.0.5.33100.ds4-3 [3,220 B]
  Get:5 http://ftp.ports.debian.org/debian-ports unstable/main m68k firebir=
d3.0-server-core m68k 3.0.5.33100.ds4-3 [2,368 kB]
  Get:6 http://ftp.ports.debian.org/debian-ports unstable/main m68k firebir=
d3.0-utils m68k 3.0.5.33100.ds4-3 [770 kB]
  Get:7 http://ftp.ports.debian.org/debian-ports unstable/main m68k firebir=
d3.0-server m68k 3.0.5.33100.ds4-3 [365 kB]
  Fetched 4,051 kB in 2s (1,803 kB/s)          =

  debconf: delaying package configuration, since apt-utils is not installed
  E: Can not write log (Is /dev/pts mounted?) - posix_openpt (19: No such d=
evice)
  Selecting previously unselected package firebird3.0-common-doc.
  (Reading database ... 33605 files and directories currently installed.)
  Preparing to unpack .../0-firebird3.0-common-doc_3.0.5.33100.ds4-3_all.de=
b ...
  Unpacking firebird3.0-common-doc (3.0.5.33100.ds4-3) ...
  Selecting previously unselected package firebird3.0-common.
  Preparing to unpack .../1-firebird3.0-common_3.0.5.33100.ds4-3_all.deb ...
  Unpacking firebird3.0-common (3.0.5.33100.ds4-3) ...
  Selecting previously unselected package libfbclient2:m68k.
  Preparing to unpack .../2-libfbclient2_3.0.5.33100.ds4-3_m68k.deb ...
  Unpacking libfbclient2:m68k (3.0.5.33100.ds4-3) ...
  Selecting previously unselected package libib-util:m68k.
  Preparing to unpack .../3-libib-util_3.0.5.33100.ds4-3_m68k.deb ...
  Unpacking libib-util:m68k (3.0.5.33100.ds4-3) ...
  Selecting previously unselected package firebird3.0-server-core:m68k.
  Preparing to unpack .../4-firebird3.0-server-core_3.0.5.33100.ds4-3_m68k.=
deb ...
  Unpacking firebird3.0-server-core:m68k (3.0.5.33100.ds4-3) ...
  Selecting previously unselected package firebird3.0-utils.
  Preparing to unpack .../5-firebird3.0-utils_3.0.5.33100.ds4-3_m68k.deb ...
  Unpacking firebird3.0-utils (3.0.5.33100.ds4-3) ...
  Selecting previously unselected package firebird3.0-server.
  Preparing to unpack .../6-firebird3.0-server_3.0.5.33100.ds4-3_m68k.deb .=
..
  Unpacking firebird3.0-server (3.0.5.33100.ds4-3) ...
  Setting up firebird3.0-common-doc (3.0.5.33100.ds4-3) ...
  Setting up firebird3.0-common (3.0.5.33100.ds4-3) ...
  Setting up libib-util:m68k (3.0.5.33100.ds4-3) ...
  Setting up libfbclient2:m68k (3.0.5.33100.ds4-3) ...
  Setting up firebird3.0-utils (3.0.5.33100.ds4-3) ...
  Setting up firebird3.0-server-core:m68k (3.0.5.33100.ds4-3) ...
  Setting up firebird3.0-server (3.0.5.33100.ds4-3) ...
  debconf: unable to initialize frontend: Dialog
  debconf: (No usable dialog-like program is installed, so the dialog based=
 frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm li=
ne 76.)
  debconf: falling back to frontend: Readline
  Password for firebird 3.0
  -------------------------

  Firebird has a special user named SYSDBA, which is the user that has acce=
ss to all databases. SYSDBA can also create new databases and users. Becaus=
e of this, it is
  necessary to secure SYSDBA with a password.

  The password is stored in /etc/firebird/3.0/SYSDBA.password (readable onl=
y by root). You may modify it there (don't forget to update the security da=
tabase too, using the
  gsec utility), or you may use dpkg-reconfigure to update both.

  If you don't enter a password, a random one will be used (and stored
  in SYSDBA.password).

  Password for SYSDBA:

  adduser: Warning: The home directory `/var/lib/firebird' does not belong =
to the user you are currently creating.
  ConfigStorage: mutex pthread_mutex_init error, status =3D 95
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted
  dpkg: error processing package firebird3.0-server (--configure):
   installed firebird3.0-server package post-installation script subprocess=
 returned error exit status 134
  Processing triggers for systemd (241-6+b2) ...
  Processing triggers for man-db (2.8.5-2) ...
  Not building database; man-db/auto-update is not 'true'.
  Processing triggers for libc-bin (2.28-10+qemu) ...
  Errors were encountered while processing:
   firebird3.0-server
  E: Sub-process /usr/bin/dpkg returned an error code (1)
  (sid-m68k-sbuild)root@epyc:/# SEC_SQL=3D/usr/share/firebird/3.0/security.=
sql T=3D/tmp/tmp.2kBDCgAevm T_SEC=3D/tmp/tmp.2kBDCgAevm/security.fdb isql-f=
b -q
  SQL> create database '/tmp/tmp.2kBDCgAevm/security.fdb';
  ConfigStorage: mutex pthread_mutex_init error, status =3D 95
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted
  (sid-m68k-sbuild)root@epyc:/#

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836763/+subscriptions

