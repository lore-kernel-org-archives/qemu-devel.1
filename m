Received: from eggs.gnu.org ([2001:4830:134:3::10]:39115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZCq6-0003o3-T8
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 06:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZCq3-00007P-Ls
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 06:10:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:34666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fZCq3-0008U4-CS
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 06:10:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fZCq2-0005Ed-AQ
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 10:10:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 497322E8019
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 10:10:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 Jun 2018 10:01:23 -0000
From: Alexander Richardson <1779447@bugs.launchpad.net>
Reply-To: Bug 1779447 <1779447@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153035288335.30029.15175462614252877889.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1779447] [NEW] SLIRP SMB silently fails with
 MacOS smbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

When using the -net user,id=3Dnet0,ipv6=3Doff,smb=3D/path/to/share/option,h=
ostfwd=3Dtcp::19500-:22 I can successfully mount_smbfs the shared directory=
 on the guest when QEMU is running on a Linux or FreeBSD host. However, on =
a MacOS host the mount_smbfs command just fails with
`mount_smbfs: unable to open connection: syserr =3D Connection reset by pee=
r`.
After some debugging it turns out this is because the smbd shipped by macos=
 is incompatible and doesn't use the same config file/command line argument=
s.

I have since got it working by compiling the sources form samba.org and
using the --smbd=3D configure option pointing to that binary.

Would it be possible to print a warning message or even better abort the
launch saying smbd is incompatible with QEMU if the -smb=3D flag is
passed? It appears that smbd should die with an error code on invalid
arguments so QEMU should be able to report that.


This was happening with QEMU built from git sources at c1c2a435905ae76b159c=
573b0c0d6f095b45ebc6.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1779447

Title:
  SLIRP SMB silently fails with MacOS smbd

Status in QEMU:
  New

Bug description:
  When using the -net user,id=3Dnet0,ipv6=3Doff,smb=3D/path/to/share/option=
,hostfwd=3Dtcp::19500-:22 I can successfully mount_smbfs the shared directo=
ry on the guest when QEMU is running on a Linux or FreeBSD host. However, o=
n a MacOS host the mount_smbfs command just fails with
  `mount_smbfs: unable to open connection: syserr =3D Connection reset by p=
eer`.
  After some debugging it turns out this is because the smbd shipped by mac=
os is incompatible and doesn't use the same config file/command line argume=
nts.

  I have since got it working by compiling the sources form samba.org
  and using the --smbd=3D configure option pointing to that binary.

  Would it be possible to print a warning message or even better abort
  the launch saying smbd is incompatible with QEMU if the -smb=3D flag is
  passed? It appears that smbd should die with an error code on invalid
  arguments so QEMU should be able to report that.

  =

  This was happening with QEMU built from git sources at c1c2a435905ae76b15=
9c573b0c0d6f095b45ebc6.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1779447/+subscriptions
