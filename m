Received: from eggs.gnu.org ([2001:4830:134:3::10]:45429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIWl2-0005kv-Co
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIWkz-0007bH-73
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:56:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:59041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dIWkz-0007bA-1I
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:56:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dIWky-0006kl-0q
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:56:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D2AFC2E8197
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 08:55:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Jun 2017 08:43:35 -0000
From: Thomas Huth <893956@bugs.launchpad.net>
Reply-To: Bug 893956 <893956@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111123113338.301.42834.malonedeb@gac.canonical.com>
Message-Id: <149682501508.8386.15479145248309541889.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 893956] Re: qemu-img bug with dynamic vhd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem with the latest version of QEMU
(currently version 2.9.0)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/893956

Title:
  qemu-img bug with dynamic vhd

Status in QEMU:
  Incomplete

Bug description:
  Hye, i found a problem with qemu-img when trying to get info of a
  dynamic vhd. I made imgae of my 60GB computer hard drive with
  disk2vhd. The dynamic vhd is 21gb size.

  With 1.0-rc3 version :
  running command: qemu-img info 60_GB.VHD
  qemu-img:  Could not open '60_GB.VHD' : File too large

  0.14.1 version give me wrong information :
  image: 60_GB.VHD
  file format: vpc
  virtual size: 127G (136899993600 bytes)
  disk size: 21G

  Thanks for reply.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/893956/+subscriptions
