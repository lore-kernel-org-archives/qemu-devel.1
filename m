Received: from eggs.gnu.org ([2001:4830:134:3::10]:37756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC9MD-0004DL-3W
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC9M9-0003Tk-1E
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:16:21 -0500
Received: from indium.canonical.com ([91.189.90.7]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC9M8-0003Tf-Ru
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:16:16 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC9M8-0003gE-12
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 19:16:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0201E2E80C3
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 19:16:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 18:58:31 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1133668 <1133668@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130226221710.3293.20274.malonedeb@soybean.canonical.com>
Message-Id: <151008111184.4486.6471391893044618292.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1133668] Re: Bad validate ELF MIPSel format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

To copy the information out of that web page for posterity:

the problem is that we weren't able to execute ELF files in linux-user
if they had had the section table stripped out of them. We fixed this in
the way suggested in that web page, by simply not checking the section
header size, since we don't care about the section headers when we load
ELF files. This was fixed in commit d3606f07440ee2c2bebea2 in 2011.


** Tags added: linux-user

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1133668

Title:
  Bad validate ELF MIPSel format

Status in QEMU:
  Fix Released

Bug description:
  Detail and temporary path:

  http://www.devttys0.com/2011/12/qemu-vs-sstrip/#comment-10161

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1133668/+subscriptions
