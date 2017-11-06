Received: from eggs.gnu.org ([2001:4830:134:3::10]:33100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBn7Q-000170-3t
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBn7N-0004ut-1Z
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:31:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:46964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBn7M-0004u8-RQ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:31:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBn7K-0007UD-8A
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 19:31:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3FDF72E8179
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 19:31:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 19:18:12 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1679358 <1679358@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170403221712.26304.98856.malonedeb@chaenomeles.canonical.com>
Message-Id: <150999589239.4347.10880623847111437463.launchpad@gac.canonical.com>
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

** Tags added: arm

** Summary changed:

- ARM: SCTLR fields not being preserved
+ ARM: RES0/RES1 SCTLR fields not read-only

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1679358

Title:
  ARM: RES0/RES1 SCTLR fields not read-only

Status in QEMU:
  Confirmed

Bug description:
  There are fields in SCTLR that are RAO/SBOP or WI or in the case of
  the RR field, accessible only in secure mode. Currently it seems that
  qemu just propagates any write to SCTLR to the register and this
  screwed up in a bootloader that I am debugging.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1679358/+subscriptions
