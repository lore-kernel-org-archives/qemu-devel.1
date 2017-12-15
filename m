Received: from eggs.gnu.org ([2001:4830:134:3::10]:60820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsQl-00074y-Q9
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsQk-0004Cc-Sn
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:01:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:48598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsQk-0004A9-JN
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:01:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsQQ-0008GU-TG
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:01:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7B95C2E81E8
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:01:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 15:51:25 -0000
From: Thomas Huth <1715007@bugs.launchpad.net>
Reply-To: Bug 1715007 <1715007@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150454728299.11465.16419614126542209437.malonedeb@wampee.canonical.com>
Message-Id: <151335308639.18701.17937336925345221884.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1715007] Re: hw/block/onenand.c:520: dead code ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715007

Title:
  hw/block/onenand.c:520: dead code ?

Status in QEMU:
  Fix Released

Bug description:
  qemu/hw/block/onenand.c:520] -> [qemu/hw/block/onenand.c:521]:
  (warning) Opposite inner 'if' condition leads to a dead code block.

  Source code is

          for (b =3D 0; b < s->blocks; b ++) {
              if (b >=3D s->blocks) {
                  s->status |=3D ONEN_ERR_CMD;
                  break;
              }

  I am not sure if the if condition can be merely deleted, or something more
  complex needs to be implemented.

  Recent qemu trunk.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715007/+subscriptions
