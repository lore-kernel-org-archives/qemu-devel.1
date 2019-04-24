Received: from eggs.gnu.org ([209.51.188.92]:57350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBGz-0008Gs-2Y
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBGx-00013t-N6
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:44040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJBGx-000131-Gm
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJBGw-0007lo-Ic
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8B4BE2E80CC
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 06:05:56 -0000
From: Thomas Huth <1813305@bugs.launchpad.net>
Reply-To: Bug 1813305 <1813305@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154842501977.29408.13715859935418850955.malonedeb@soybean.canonical.com>
Message-Id: <155608595742.14092.14169597212291980221.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813305] Re: trace-root.h is not regerenerated
 after re-configure
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
https://bugs.launchpad.net/bugs/1813305

Title:
  trace-root.h is not regerenerated after re-configure

Status in QEMU:
  Fix Released

Bug description:
  Hi,

  I've just realized that after I reconfigured my qemu with
  ../configure --target-list=3Darm-softmmu,arm-linux-user,aarch64-softmmu,a=
arch64-linux-user --enable-trace-backends=3Dsimple

  $ make
  did rebuild some stuff for the 'simple' trace, but it did not update trac=
e-root.h until after I
  $ make clean

  =

  I took me while to understand why I didn't get the traces I wanted (my tr=
ace-root.h still thought it was configured for the default 'log').

  I didn't check how easy it is to fix this in the build system.

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813305/+subscriptions
