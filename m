Received: from eggs.gnu.org ([2001:4830:134:3::10]:36102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dTxEY-0005HR-2P
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 17:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dTxEU-0007Zx-R7
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 17:25:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:45126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dTxEU-0007Zl-KF
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 17:25:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dTxET-00083I-Ev
	for <qemu-devel@nongnu.org>; Sat, 08 Jul 2017 21:25:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5D7DE2E8190
	for <qemu-devel@nongnu.org>; Sat,  8 Jul 2017 21:25:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Jul 2017 21:19:03 -0000
From: Duane Voth <duanev@gmail.com>
Reply-To: Bug 1703147 <1703147@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149954874338.15421.5827897782818416258.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1703147] [NEW] Xfer:features:read truncating xml
 sent to gdb frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Around line 1326 in gdbstub.c:

            if (len > (MAX_PACKET_LENGTH - 5) / 2)
                len =3D (MAX_PACKET_LENGTH - 5) / 2;

is truncating processor reg description xml files longer than 2045
bytes.  Deleting these lines works for my immediate need, but they seem
to be trying to fix some buffer overrun condition so I won't offer a
patch until we understand their purpose.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1703147

Title:
  Xfer:features:read truncating xml sent to gdb frontends

Status in QEMU:
  New

Bug description:
  Around line 1326 in gdbstub.c:

              if (len > (MAX_PACKET_LENGTH - 5) / 2)
                  len =3D (MAX_PACKET_LENGTH - 5) / 2;

  is truncating processor reg description xml files longer than 2045
  bytes.  Deleting these lines works for my immediate need, but they
  seem to be trying to fix some buffer overrun condition so I won't
  offer a patch until we understand their purpose.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1703147/+subscriptions
