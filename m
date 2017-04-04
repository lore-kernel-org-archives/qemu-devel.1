Received: from eggs.gnu.org ([2001:4830:134:3::10]:40254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cvQGE-0007K1-E0
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cvQG9-0005kl-39
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:20:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:53047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cvQG8-0005kK-Mw
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:20:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cvQG7-0004PY-Bw
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 15:20:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 15A422E80C0
	for <qemu-devel@nongnu.org>; Tue,  4 Apr 2017 15:20:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Apr 2017 15:14:49 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1679358 <1679358@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170403221712.26304.98856.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170404151449.9940.24128.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1679358] Re: ARM: SCTLR fields not being preserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Well, I wouldn't object to a patch to fix it (it would have to correctly
handle the various different versions of the CPU architecture we
implement, etc), but I'm not planning on writing one today myself.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1679358

Title:
  ARM: SCTLR fields not being preserved

Status in QEMU:
  New

Bug description:
  There are fields in SCTLR that are RAO/SBOP or WI or in the case of
  the RR field, accessible only in secure mode. Currently it seems that
  qemu just propagates any write to SCTLR to the register and this
  screwed up in a bootloader that I am debugging.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1679358/+subscriptions
