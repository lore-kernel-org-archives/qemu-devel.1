Received: from eggs.gnu.org ([2001:4830:134:3::10]:60561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1czX9W-0008Gp-1z
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 19:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1czX9S-0001AX-4L
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 19:30:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:38781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1czX9R-00018m-RF
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 19:30:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1czX9P-0006bM-De
	for <qemu-devel@nongnu.org>; Sat, 15 Apr 2017 23:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6356A2E80C2
	for <qemu-devel@nongnu.org>; Sat, 15 Apr 2017 23:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Apr 2017 23:24:00 -0000
From: Mark <1683084@bugs.launchpad.net>
Reply-To: Bug 1683084 <1683084@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170415232401.17219.37576.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1683084] [NEW] DNS server not working in QEMU
 usermode networking
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

Nslookup is returning "unknown host".
I try to ping 10.0.2.3 and it fails. Pinging 10.0.2.2 and 10.0.2.15 works c=
orrectly.
Downloading files via wget using a static IP works well.

Results of qemu monitor command "info network" included as an
attachment.

This bug was reported as a question on stack overflow:
http://stackoverflow.com/questions/43308310/dns-server-not-working-in-
qemu-usermode-networking.

This bug exists on 2.8.0 and 2.9-rc3.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "info network.png"
   https://bugs.launchpad.net/bugs/1683084/+attachment/4862880/+files/info%=
20network.png

** Description changed:

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1683084

Title:
  DNS server not working in QEMU usermode networking

Status in QEMU:
  New

Bug description:
  Nslookup is returning "unknown host".
  I try to ping 10.0.2.3 and it fails. Pinging 10.0.2.2 and 10.0.2.15 works=
 correctly.
  Downloading files via wget using a static IP works well.

  Results of qemu monitor command "info network" included as an
  attachment.

  This bug was reported as a question on stack overflow:
  http://stackoverflow.com/questions/43308310/dns-server-not-working-in-
  qemu-usermode-networking.

  This bug exists on 2.8.0 and 2.9-rc3.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1683084/+subscriptions
