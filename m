Received: from eggs.gnu.org ([2001:4830:134:3::10]:39721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwU2T-0007U7-Vj
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwU2O-00063I-W7
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:34:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:37440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwU2O-00062j-QB
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:34:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwU2N-00066X-7q
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 13:34:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 37D522E80C9
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 13:34:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:24:13 -0000
From: Thomas Huth <1013714@bugs.launchpad.net>
Reply-To: Bug 1013714 <1013714@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120615145323.29444.96098.malonedeb@soybean.canonical.com>
Message-Id: <20170407132413.12230.21659.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1013714] Re: Data corruption after block
 migration (LV->LV)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing according to comment #3

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1013714

Title:
  Data corruption after block migration (LV->LV)

Status in QEMU:
  Fix Released

Bug description:
  We quite frequently use the live block migration feature to move VM's
  between nodes without downtime. These sometimes result in data
  corruption on the receiving end. It only happens if the VM is actually
  doing I/O (doesn't have to be all that much to trigger the issue).

  We use logical volumes and each VM has two disks.  We use cache=3Dnone
  for all VM disks.

  All guests use virtio (a mix of various Linux distro's and Windows
  2008R2).

  We currently have two stacks in use and have seen the issue on both of
  them:

  Fedora - qemu-kvm 0.13
  Scientific Linux 6.2 (RHEL derived) - qemu-kvm package 0.12.1.2

  Even though we don't run the most recent versions of KVM I highly
  suspect this issue is still unreported and that filing a bug is
  therefore appropriate. (There doesn't seem to be any similar bug
  report in launchpad or RedHat's bugzilla and nothing related in change
  logs, release notes and  git commit logs.)

  I have no idea where to look or where to start debugging this issue,
  but if there is any way I can provide useful debug information please
  let me know.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1013714/+subscriptions
