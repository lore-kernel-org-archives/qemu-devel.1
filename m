Received: from eggs.gnu.org ([209.51.188.92]:38335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gm2f5-0007i0-E7
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:28:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gm2f3-0000wQ-MZ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:28:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:46290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gm2f3-0000bp-D7
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:28:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1glvBb-0003eb-NF
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:29:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A11212E80CC
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:29:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Jan 2019 12:19:18 -0000
From: Thomas Huth <1541643@bugs.launchpad.net>
Reply-To: Bug 1541643 <1541643@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160203233916.24772.15221.malonedeb@soybean.canonical.com>
Message-Id: <154815955834.1784.8024765785990062194.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1541643] Re: IA32_FEATURE_CONTROL MSR unset for
 nested virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1541643

Title:
  IA32_FEATURE_CONTROL MSR unset for nested virtualization

Status in QEMU:
  Incomplete

Bug description:
  I enabled nested virtualization for the kvm_intel module, and passed
  -enable-kvm and -cpu host to qemu. However, the qemu BIOS did not set
  IA32_FEATURE_CONTROL MSR (index 0x3a) to a non-zero value allow VMXON.
  According to the Intel manual Section 23.7 ENABLING AND ENTERING VMX
  OPERATION: "To enable VMX support in a platform, BIOS must set bit 1,
  bit 2, or both (see below), as well as the lock bit."

  I noticed an old mailing list thread on this
  (https://lists.nongnu.org/archive/html/qemu-
  devel/2015-01/msg01372.html), but I wanted to point out that the Intel
  manual (and all the physical hardware I've tested) specifically
  contradicts this response.

  Tested on kernel 4.3.3 and qemu 2.4.1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1541643/+subscriptions
