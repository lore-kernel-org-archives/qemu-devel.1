Received: from eggs.gnu.org ([2001:4830:134:3::10]:43808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cs5Mm-0002je-So
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 06:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cs5Mi-0005L4-NZ
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 06:25:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:60079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cs5Mi-0005K7-IS
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 06:25:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cs5Mg-0004Vh-MC
	for <qemu-devel@nongnu.org>; Sun, 26 Mar 2017 10:25:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9910F2E80AD
	for <qemu-devel@nongnu.org>; Sun, 26 Mar 2017 10:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Mar 2017 10:20:09 -0000
From: Danil <1660599@bugs.launchpad.net>
Reply-To: Bug 1660599 <1660599@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170131114543.27337.90403.malonedeb@wampee.canonical.com>
Message-Id: <20170326102009.25541.68185.malone@gac.canonical.com>
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

Could you provide the command you've used?
I tried `CC=3Dgcc-4.8 ./configure --enable-stack-protector && make` in Ubun=
tu 14.04 and qemu v2.8.0. It didn't set `-fstack-protector-strong` flag, on=
ly `-fstack-protector-all`.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1660599

Title:
  v2.8.0 won't compile if g++ compiler doesn't understand "-fstack-
  protector-strong"

Status in QEMU:
  New

Bug description:
  For example, Ubuntu Trusty (LTS 14.04) uses g++ v4.8.5.
  Compilation fails with a syntax error saying that the ""-fstack-protector=
-strong" option in g++ is unrecognized.
  Instead, under Ubuntu Xenial (LTS 16.04), the g++ compiler is v5.4.0 and =
the compilation goes on smoothly.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1660599/+subscriptions
