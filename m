Received: from eggs.gnu.org ([2001:4830:134:3::10]:33251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTaSM-0006cU-42
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTaSK-0005W4-VD
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:11:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:37408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTaSK-0005Va-O1
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:11:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTaSJ-0004dQ-Sg
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 22:10:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BCD112E802D
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 22:10:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Jun 2018 22:02:47 -0000
From: Waldemar Kozaczuk <1776920@bugs.launchpad.net>
Reply-To: Bug 1776920 <1776920@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152898515528.25954.5483198787570860596.malonedeb@soybean.canonical.com>
Message-Id: <152901376781.6853.16371617301483551851.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776920] Re: qemu-img convert on Mac OSX creates
 corrupt images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Also if I use the same image.qemu file and convert to vmdk format I get
even smaller file which for sure is wrong as well:

qemu-img convert image.qemu -O vmdk image2.vbox

ll image*
-rw-r--r--  1 *** ***  6684672 Jun 14 17:17 image.img
-rw-r--r--  1 *** ***  7012352 Jun 14 17:40 image.qemu
-rw-r--r--  1 *** ***   196616 Jun 14 17:40 image2.qemu
-rw-r--r--  1 *** ***    65536 Jun 14 18:00 image2.vbox

** Attachment added: "image2.vbox"
   https://bugs.launchpad.net/qemu/+bug/1776920/+attachment/5152725/+files/=
image2.vbox

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776920

Title:
  qemu-img convert on Mac OSX creates corrupt images

Status in QEMU:
  New

Bug description:
  An image created by qemu-img create, then modified by another program
  is converted to bad/corrupt image when using convert sub command on
  Mac OSX. The same convert works on Linux. The version of qemu-img is
  2.12.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776920/+subscriptions
