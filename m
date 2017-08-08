Received: from eggs.gnu.org ([2001:4830:134:3::10]:60032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1deyDC-0006De-Et
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1deyD7-0002Ko-Eq
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:41:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:60482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1deyD7-0002KO-8Y
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:41:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1deyD3-0000oT-NZ
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 06:41:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BDF092E8214
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 06:41:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2017 06:21:09 -0000
From: Thomas Huth <1357226@bugs.launchpad.net>
Reply-To: Bug 1357226 <1357226@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140815074951.24111.49052.malonedeb@wampee.canonical.com>
Message-Id: <150217327212.11063.12767350646755902886.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1357226] Re: qemu: uncaught target signal 11
 (Segmentation fault) - core dumped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1357226

Title:
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

Status in qemu package in Ubuntu:
  New

Bug description:
  steps to reproduce:
  pbuilder-dist utopic armhf create
  pbuilder-dist utopic armhf login
  apt-get install imagemagick
  convert foo.xpm foo.png
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault

  (doesn't matter if images are actually there or not)

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1357226/+subscriptions
