Received: from eggs.gnu.org ([209.51.188.92]:56027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gn2Gl-0007dn-KX
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gn2Gk-0000Md-Pp
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:15:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:51554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gn2Gi-0000JA-Rx
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:15:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gn2Ge-0004fS-Ck
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:15:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 497032E80D0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:15:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Jan 2019 14:03:39 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
Reply-To: Bug 1813305 <1813305@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154842501977.29408.13715859935418850955.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813305] [NEW] trace-root.h is not regerenerated
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

Public bug reported:

Hi,

I've just realized that after I reconfigured my qemu with
../configure --target-list=3Darm-softmmu,arm-linux-user,aarch64-softmmu,aar=
ch64-linux-user --enable-trace-backends=3Dsimple

$ make
did rebuild some stuff for the 'simple' trace, but it did not update trace-=
root.h until after I
$ make clean


I took me while to understand why I didn't get the traces I wanted (my trac=
e-root.h still thought it was configured for the default 'log').

I didn't check how easy it is to fix this in the build system.

Thanks

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813305

Title:
  trace-root.h is not regerenerated after re-configure

Status in QEMU:
  New

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
