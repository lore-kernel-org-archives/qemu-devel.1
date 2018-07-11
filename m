Received: from eggs.gnu.org ([2001:4830:134:3::10]:43920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fd9VU-0007Lt-6E
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fd9VR-0006HK-80
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:25:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:49488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fd9VR-0006Fn-1g
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:25:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fd9VQ-0002Pf-2x
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 07:25:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 12ECF2E80CB
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 07:25:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jul 2018 07:10:10 -0000
From: Thomas Huth <1474263@bugs.launchpad.net>
Reply-To: Bug 1474263 <1474263@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150714085742.25422.46124.malonedeb@chaenomeles.canonical.com>
Message-Id: <153129301010.23804.16758501535776860257.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1474263] Re: "Image format was not specified"
 warning should be suppressed for the vvfat (and probably nbd) driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets...  can you still reproduce this bug
with the latest version of QEMU? At least for vvfat, the warning message
does not seem to occur anymore.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1474263

Title:
  "Image format was not specified" warning should be suppressed for the
  vvfat (and probably nbd) driver

Status in QEMU:
  Incomplete

Bug description:
  Running

  qemu -drive file.driver=3Dvvfat,file.dir=3D.

  displays

  WARNING: Image format was not specified for 'json:{"dir": ".", "driver": =
"vvfat"}' and probing guessed raw.
           Automatically detecting the format is dangerous for raw images, =
write operations on block 0 will be restricted.
           Specify the 'raw' format explicitly to remove the restrictions.

  However, since "images" provided by the vvfat driver are always raw
  (and the first sector isn't writeable in any case), this warning is
  superfluous and should not be displayed.

  A similar warning is displayed for NBD devices; I suspect it should be
  also disabled for similar reasons, but I'm not sure if serving non-raw
  images is actually a violation of the protocol. qemu-nbd translates
  them to raw images, for what it's worth, even if it may be suppressed
  with -f raw.

  Noticed on 2.3.0; the code that causes this behaviour is still
  apparently present in today's git master
  (f3a1b5068cea303a55e2a21a97e66d057eaae638). Speaking of versions: you
  may want to update the copyright notice that qemu -version displays.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1474263/+subscriptions
