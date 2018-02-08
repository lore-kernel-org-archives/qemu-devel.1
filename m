Received: from eggs.gnu.org ([2001:4830:134:3::10]:37023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejs7p-0004jE-Oe
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejs7n-0000UL-6W
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:44:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:43062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ejs7m-0000Te-W6
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:44:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ejs7l-0007Xh-Ia
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 19:44:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8129C2E80C3
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 19:44:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2018 19:32:31 -0000
From: Thomas Huth <1379688@bugs.launchpad.net>
Reply-To: Bug 1379688 <1379688@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141010081105.4873.97725.malonedeb@wampee.canonical.com>
Message-Id: <151811835138.27260.6433487248804025567.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1379688] Re: qemu's monitor and parallel create
 huge window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1379688

Title:
  qemu's monitor and parallel create huge window

Status in QEMU:
  Incomplete

Bug description:
  I have qemu 2.1. When I try to switch to monitor or parallel0, I get
  window which is 30 *thousand* pixels in height. It is only gray with
  no content. This did not happen with previous versions of qemu.

  Kwin crashes because it cannot handle such a huge window.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1379688/+subscriptions
