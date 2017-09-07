Received: from eggs.gnu.org ([2001:4830:134:3::10]:33168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dq2zJ-0007hc-Pd
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dq2zF-0001OM-8V
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:01:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:41968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dq2zF-0001Nt-2k
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:01:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dq2zD-00054v-PW
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 20:01:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B9A0A2E8470
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 20:01:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Sep 2017 19:42:11 -0000
From: Thomas Huth <1006702@bugs.launchpad.net>
Reply-To: Bug 1006702 <1006702@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120531033108.7430.49398.malonedeb@wampee.canonical.com>
Message-Id: <150481333144.29554.2514489732151272499.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1006702] Re: something wrong in function
 type_initialize() in object.c in the source code of qemu-1.1.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

That code has been remove with this commit:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D745549c8d0273d3a3d9c3=
701
... so I think we can close this ticket nowadays.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1006702

Title:
  something wrong in function type_initialize() in object.c in the
  source code of qemu-1.1.0

Status in QEMU:
  Fix Released

Bug description:
  In the function type_initialize() in file object.c, about line 237, the s=
entence : =

      memset((void *)ti->class + class_size, 0, ti->class_size - class_size=
);
  after the =

     if (type_has_parent(ti)){}
  will clean the information copied from the parent in the if block.
  I'm wondering whether this will lead to a bug. Thanks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1006702/+subscriptions
