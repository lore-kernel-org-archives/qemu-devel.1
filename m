Received: from eggs.gnu.org ([2001:4830:134:3::10]:38408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBeLl-0007JF-1f
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBeLj-00085x-Ar
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:42:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:59462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBeLj-00084j-4s
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:42:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBeLi-0003YP-2B
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:42:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0ECFA2E80C7
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:42:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Apr 2018 10:28:50 -0000
From: Thomas Huth <1660599@bugs.launchpad.net>
Reply-To: Bug 1660599 <1660599@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170131114543.27337.90403.malonedeb@wampee.canonical.com>
Message-Id: <152473853013.21771.8469919382388122218.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1660599] Re: v2.8.0 won't compile if g++ compiler
 doesn't understand "-fstack-protector-strong"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which version of gcc (i.e. normal C-compiler, not g++) did you use here?
Can you still reproduce this issue with the latest release of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1660599

Title:
  v2.8.0 won't compile if g++ compiler doesn't understand "-fstack-
  protector-strong"

Status in QEMU:
  Incomplete

Bug description:
  For example, Ubuntu Trusty (LTS 14.04) uses g++ v4.8.5.
  Compilation fails with a syntax error saying that the ""-fstack-protector=
-strong" option in g++ is unrecognized.
  Instead, under Ubuntu Xenial (LTS 16.04), the g++ compiler is v5.4.0 and =
the compilation goes on smoothly.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1660599/+subscriptions
