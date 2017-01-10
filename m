Received: from eggs.gnu.org ([2001:4830:134:3::10]:52447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQxPE-00056G-GA
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQxPA-00018w-Ft
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:28:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:49339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQxPA-00018p-8o
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:28:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQxP8-0003H6-H8
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 14:28:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 732532EA028
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 14:27:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Jan 2017 14:10:21 -0000
From: Paolo Bonzini <bonzini@gnu.org>
Reply-To: Bug 601946 <601946@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100705154408.6052.2473.malonedeb@potassium.ubuntu.com>
Message-Id: <20170110141021.27094.64344.malone@chaenomeles.canonical.com>
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

The fact that it's now a coroutine_fn doesn't change much, if anything
it makes it simpler to handle multiple writes in parallel.

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
