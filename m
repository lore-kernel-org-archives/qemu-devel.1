Received: from eggs.gnu.org ([2001:4830:134:3::10]:34799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBnAr-0003gl-8z
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBnAn-0006yF-87
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:35:09 -0500
Received: from indium.canonical.com ([91.189.90.7]:47124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBnAn-0006xh-1t
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:35:05 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBnAm-000868-7p
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 19:35:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2EB902E80C3
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 19:35:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 19:17:46 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1605443 <1605443@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160722020729.820.92357.malonedeb@gac.canonical.com>
Message-Id: <150999586645.20015.5570109793222116224.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1605443] Re: QEMU epoll for i386-linux-user on
 arm host is broken in 2.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This was fixed by commit d9fe91d8689b078ac, which went into the 2.7
release.


** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1605443

Title:
  QEMU epoll for i386-linux-user on arm host is broken in 2.6

Status in QEMU:
  Fix Released

Bug description:
  I'm trying to get wine running on qemu-i386 on arm.

  I found that 2.5.1 is OK, but 2.6 is not.

  By bisecting, I found commit 928bed6a057cedd6110e634865e021a24029785a
  is the problem.

  I reverted this commit, and then epoll is OK now.

  It seems that the commit broke epoll of qemu-i386 on arm.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1605443/+subscriptions
