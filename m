Received: from eggs.gnu.org ([2001:4830:134:3::10]:39572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e0ROU-0001Dw-6y
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e0ROO-00014D-JW
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:06:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:38734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e0ROO-000126-DJ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:06:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e0ROM-0008WH-Hp
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 12:06:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7FECA2E80C7
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 12:06:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Oct 2017 11:53:44 -0000
From: Quentin Casasnovas <601946@bugs.launchpad.net>
Reply-To: Bug 601946 <601946@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100705154408.6052.2473.malonedeb@potassium.ubuntu.com>
Message-Id: <150729082459.7593.10336002211512254746.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 601946] Re: [Feature request] qemu-img
 multi-threaded compressed image conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

@Jinank I have not started working on this at all, so please go ahead!
Let me know if I can help with testing or anything, we make quite
extensive use of nbd and qcow2 images internally.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/601946

Title:
  [Feature request] qemu-img multi-threaded compressed image conversion

Status in QEMU:
  New

Bug description:
  Feature request:
  qemu-img multi-threaded compressed image conversion

  Suppose I want to convert raw image to compressed qcow2. Multi-
  threaded conversion will be much faster, because bottleneck is
  compressing data.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/601946/+subscriptions
