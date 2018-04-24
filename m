Received: from eggs.gnu.org ([2001:4830:134:3::10]:57528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fAvn3-0007z3-Mf
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fAvmy-0000oI-Px
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:07:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:33122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fAvmy-0000nH-JN
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:07:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fAvmx-0002GQ-Je
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 11:07:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8D3A72E80C8
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 11:07:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Apr 2018 10:50:48 -0000
From: Thomas Huth <1254443@bugs.launchpad.net>
Reply-To: Bug 1254443 <1254443@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131124134929.7635.53966.malonedeb@wampee.canonical.com>
Message-Id: <152456704899.9510.8255710382281416955.malone@wampee.canonical.com>
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

Ok, thanks for testing. So if this has been fixed in QEMU 2.3, I assume
that it is still fixed, thus let's close this ticket. If you hit the
problem again with the latest version of QEMU, please re-open this bug
or create a new one.

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1254443

Title:
  Periodic mode of LAPIC doesn't fire interrupts when using kvm

Status in QEMU:
  Fix Released

Bug description:
  It works fine when not using kvm and it does also work fine when using
  oneshot mode.

  Tested with qemu 1.6.1 (commit
  62ecc3a0e3c77a4944c92a02dd7fae2ab1f2290d).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1254443/+subscriptions
