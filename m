Received: from eggs.gnu.org ([2001:4830:134:3::10]:60774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCyu-0006Z0-PH
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCyr-0000EP-JV
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:06:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:57022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRCyr-0000E9-DE
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:05:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRCyq-0006S1-AN
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:05:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 253A72E80C9
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:05:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 06:54:36 -0000
From: Thomas Huth <1625295@bugs.launchpad.net>
Reply-To: Bug 1625295 <1625295@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160919174005.12059.42887.malonedeb@gac.canonical.com>
Message-Id: <20170111065436.20674.82520.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1625295] Re: qemu-arm dies with libarmmem inside
 ld.so.preload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Released with version 2.8

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1625295

Title:
  qemu-arm dies with libarmmem inside ld.so.preload

Status in QEMU:
  Fix Released

Bug description:
  When running raspbian inside qemu,the user has to first comment out
  the following line from /etc/ld.so.conf:

  /usr/lib/arm-linux-gnueabihf/libarmmem.so

  =

  Will future qemus will be able to work without changine /etc/ld.so.conf ?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1625295/+subscriptions
