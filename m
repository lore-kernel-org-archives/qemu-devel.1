Received: from eggs.gnu.org ([2001:4830:134:3::10]:41539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d4lZw-0004I8-KX
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 05:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d4lZt-0002oj-BA
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 05:55:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:36129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d4lZt-0002ob-4i
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 05:55:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d4lZq-0007A8-Ob
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 09:55:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AC70F2E80C1
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 09:55:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Apr 2017 09:47:52 -0000
From: Manuel Reimer <manuel.reimer@gmx.de>
Reply-To: Bug 1687270 <1687270@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170430094752.26847.19558.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1687270] [NEW] Can't write to 9p shared folder
 with qemu 2.9.0
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

When running a virtual machine with qemu 2.9.0 with this parameter for
sharing a folder:

-virtfs local,id=3Dfsdev1,path=3D$HOME/git,security_model=3Dnone,mount_tag=
=3Dgit

then the folder is shared to the VM but in some subfolders I can't
delete files. The guest system then reports that the file, I want to
delete, is "no file or folder".

I've downgraded to 2.8.0 now, which re-enables deleting my files.

Is this a known bug which will be fixed with a future version?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1687270

Title:
  Can't write to 9p shared folder with qemu 2.9.0

Status in QEMU:
  New

Bug description:
  When running a virtual machine with qemu 2.9.0 with this parameter for
  sharing a folder:

  -virtfs
  local,id=3Dfsdev1,path=3D$HOME/git,security_model=3Dnone,mount_tag=3Dgit

  then the folder is shared to the VM but in some subfolders I can't
  delete files. The guest system then reports that the file, I want to
  delete, is "no file or folder".

  I've downgraded to 2.8.0 now, which re-enables deleting my files.

  Is this a known bug which will be fixed with a future version?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1687270/+subscriptions
