Received: from [2001:4830:134:3::10] (port=60728 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpd1y-0007IZ-P5
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpd1n-0002m3-S8
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:22:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:44862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpd1n-0002lv-9Q
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:22:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpbIe-0001mo-Ik
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 15:32:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B5CCB2E8BDE
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 15:26:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Aug 2018 15:09:29 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1785308 <1785308@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153332397534.32176.3210060625384706087.malonedeb@gac.canonical.com>
Message-Id: <153425936907.26399.15046214334236784588.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785308] Re: 0x8 exception encountered but not
 handled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

More generally, I think that if you care about getting this test case to
work under QEMU emulation you're going to have to be prepared to dig
into QEMU's internals to debug where we diverge from what the real CPU
does. Our x86 emulation is not very actively maintained and this isn't a
"real world" use case that many users are going to have problems with,
so my guess is it is unlikely to be fixed unless somebody with enough
interest in it to take a day or a week to debug what's going on does
that work.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785308

Title:
  0x8 exception encountered but not handled

Status in QEMU:
  Incomplete

Bug description:
  Present in all QEMU versions.

  OS is triple page faulting and crashing rather than handling the
  expected double page fault properly. The same OS works in Bochs so I
  know its not the problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785308/+subscriptions
