Received: from eggs.gnu.org ([2001:4830:134:3::10]:59661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTmsS-0004Vc-8d
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTmsN-0001uw-Cu
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:50:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:57614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTmsN-0001un-72
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:49:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTmsM-0001Wv-6B
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 09:49:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 16FDA2E80C3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 09:49:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Jan 2017 09:36:52 -0000
From: Thomas Huth <788886@bugs.launchpad.net>
Reply-To: Bug 788886 <788886@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110526231249.30154.71705.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170118093652.13992.51173.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 788886] Re: Crash with -m32 and gcc-4.2 on Mac OS
 X 64bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which version of QEMU were you using? Can you still reproduce this
problem with the latest version of QEMU and the latest version of macOS?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/788886

Title:
  Crash with -m32 and gcc-4.2 on Mac OS X 64bit

Status in QEMU:
  Incomplete

Bug description:
  For building 32bit Qemu on Mac OS X 10.6.7 , i configure with --extra-
  cflags=3D-m32 --extra-ldflags=3D-m32. make with gcc-4.2 then crashes with:

    GEN   qemu-options.def
    CC    qemu-nbd.o
  gcc-4.2: -E, -S, -save-temps and -M options are not allowed with multiple=
 -arch flags
  make: *** [qemu-nbd.o] Error 1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/788886/+subscriptions
