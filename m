Received: from eggs.gnu.org ([2001:4830:134:3::10]:51472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fDuC9-0007IU-Kv
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fDuC6-00032X-F6
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:01:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:49324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fDuC6-000310-9B
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:01:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fDuC4-0002Gk-Tm
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 16:01:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DD3CB2E80CB
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 16:01:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 May 2018 15:48:44 -0000
From: Richard Henderson <rth@twiddle.net>
Reply-To: Bug 1751422 <1751422@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151945759115.32735.10228929932246006018.malonedeb@chaenomeles.canonical.com>
Message-Id: <152527612443.557.8307542697783074795.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1751422] Re: some instructions translate error in
 x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I believe this to be fixed by cfcca361d77, which is present in 2.12 but
not 2.11.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1751422

Title:
  some instructions translate error in x86

Status in QEMU:
  New

Bug description:
  There is some instructions translation error on target i386 in many versi=
ons, such as 2.11.1, 2.10.2, 2.7.1 and so on.
  The error translation instructions include les, lds. I has got a patch, b=
ut I have no idea how to apply it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1751422/+subscriptions
