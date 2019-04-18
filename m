Received: from eggs.gnu.org ([209.51.188.92]:37979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hH4QD-0000ch-EW
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 06:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hH4OF-00057X-AP
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 06:35:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:48338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hH4OF-000577-5E
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 06:35:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hH4OD-0006vh-Mp
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 10:35:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9C85E2E80C9
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 10:35:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2019 10:21:45 -0000
From: Daniel Berrange <1824528@bugs.launchpad.net>
Reply-To: Bug 1824528 <1824528@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155507354518.20682.14175680260454866144.malonedeb@soybean.canonical.com>
Message-Id: <155558290608.6930.7720463120506539507.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] =?utf-8?q?=5BBug_1824528=5D_Re=3A_qemu_fails_to_comp?=
 =?utf-8?q?ile_on_gcc_9_=60error=3A_taking_address_of_packed_member_of_?=
 =?utf-8?q?=E2=80=98struct_=3Canonymous=3E=E2=80=99_may_result_in_an_unali?=
 =?utf-8?q?gned_pointer_value_=5B-Werror=3Daddress-of-packed-member=5D=60?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fixed in

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02524.html

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824528

Title:
  qemu fails to compile on gcc 9 `error: taking address of packed member
  of =E2=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointe=
r value
  [-Werror=3Daddress-of-packed-member]`

Status in QEMU:
  In Progress

Bug description:
  Qemu compilation fails with below error on ppc64le host with gcc 9(9.0.1 =
20190328)
  repo: https://github.com/qemu/qemu.git
  branch: master
  commit e1be98540ee672ef93292b65a986055512237c35

  =

    CC      net/dump.o
  hw/usb/dev-mtp.c: In function =E2=80=98usb_mtp_write_metadata=E2=80=99:
  hw/usb/dev-mtp.c:1708:36: error: taking address of packed member of =E2=
=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointer value =
[-Werror=3Daddress-of-packed-member]
   1708 |                             dataset->filename);
        |                             ~~~~~~~^~~~~~~~~~
  cc1: all warnings being treated as errors
    CC      net/eth.o
  make: *** [/home/kvmci/qemu-main/rules.mak:69: hw/usb/dev-mtp.o] Error 1
  make: *** Waiting for unfinished jobs....
    CC      net/announce.o

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824528/+subscriptions
