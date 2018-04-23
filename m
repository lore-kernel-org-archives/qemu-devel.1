Received: from eggs.gnu.org ([2001:4830:134:3::10]:46903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fATV8-0005vL-R9
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 00:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fATV5-0003XD-QQ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 00:54:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:34492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fATV5-0003Wd-Jw
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 00:54:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fATV3-0005r5-8T
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 04:54:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2656F2E80CE
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 04:54:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Apr 2018 04:44:35 -0000
From: Nils Asmussen <1254443@bugs.launchpad.net>
Reply-To: Bug 1254443 <1254443@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131124134929.7635.53966.malonedeb@wampee.canonical.com>
Message-Id: <152445867549.12497.9460587316282689387.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1254443] Re: Periodic mode of LAPIC doesn't fire
 interrupts when using kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I don't have the latest version yet, but I just tested it with 2.3.0 and
it works.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1254443

Title:
  Periodic mode of LAPIC doesn't fire interrupts when using kvm

Status in QEMU:
  Incomplete

Bug description:
  It works fine when not using kvm and it does also work fine when using
  oneshot mode.

  Tested with qemu 1.6.1 (commit
  62ecc3a0e3c77a4944c92a02dd7fae2ab1f2290d).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1254443/+subscriptions
