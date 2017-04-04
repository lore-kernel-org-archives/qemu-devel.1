Received: from eggs.gnu.org ([2001:4830:134:3::10]:36873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cvQ6l-0004C8-MW
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cvQ6i-0001RW-GD
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:10:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:51424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cvQ6i-0001Qt-A0
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:10:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cvQ6g-0000LE-L9
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 15:10:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9E4AB2E80C6
	for <qemu-devel@nongnu.org>; Tue,  4 Apr 2017 15:10:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Apr 2017 14:59:22 -0000
From: Yifan <yifanlu94@gmail.com>
Reply-To: Bug 1679358 <1679358@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170403221712.26304.98856.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170404145922.10270.33537.malone@wampee.canonical.com>
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

So there won't be a fix in the future? I'm working with debugging a
proprietary bootloader that I do not have the source code for. I wonder
if this becomes an issue for any other platform targets.

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
