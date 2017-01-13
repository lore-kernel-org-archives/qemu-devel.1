Received: from eggs.gnu.org ([2001:4830:134:3::10]:44505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRxBO-0005l7-0s
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRxBK-000642-2X
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:25:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:48334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRxBJ-00062o-SH
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:25:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRxBH-0002D5-Aa
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:25:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 45B752E80BF
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:25:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jan 2017 08:10:14 -0000
From: Thomas Huth <893068@bugs.launchpad.net>
Reply-To: Bug 893068 <893068@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111121114443.4682.78512.malonedeb@soybean.canonical.com>
Message-Id: <20170113081014.14126.17791.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 893068] Re: Spanish keys { and [ did not work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this problem with
the latest version of QEMU (currently version 2.8)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/893068

Title:
  Spanish keys { and [ did not work

Status in QEMU:
  Incomplete

Bug description:
  The keys { and [ did not work inside the virtualized enviorment
  (widnows 7).  The problems happens ussing aqemu as a front end as well
  as invoking qemu-kvm from command line:

  qemu-kvm -m 8096 eclipse.img -smp cores=3D4,threads=3D2 -hdb ander.img -k
  es

  We have also notices this warning in the console:

  Warning: no scancode found for keysym 314

  The host system is gentoo stable with some exceptions (mainly qemu-
  kvm-0.15.1-r1, gcc-4.6.2 and kernel-3.2_rc2)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/893068/+subscriptions
