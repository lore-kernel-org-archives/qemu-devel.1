Received: from eggs.gnu.org ([2001:4830:134:3::10]:36527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7Nim-000485-8z
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7Nii-0006r9-JP
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:35:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:58716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7Nii-0006p3-C9
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:35:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7Nig-0004pG-Qy
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:35:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C1E292E8081
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:35:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Oct 2017 15:23:42 -0000
From: Thomas Huth <1373362@bugs.launchpad.net>
Reply-To: Bug 1373362 <1373362@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140924104945.5098.74269.malonedeb@wampee.canonical.com>
Message-Id: <150894502232.27829.4338546368039524411.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1373362] Re: qemu-2.1.1 i386-softmmu compile
 error: q35_dsdt_applesmc_sta undeclared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing according to the last comment.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1373362

Title:
  qemu-2.1.1 i386-softmmu compile error: q35_dsdt_applesmc_sta
  undeclared

Status in QEMU:
  Fix Released
Status in qemu package in Gentoo Linux:
  New

Bug description:
  I try to compile qemu-2.1.1 (Gentoo/x86), but the i386-softmmu fails
  to compile:

    CPP i386-softmmu/q35-acpi-dsdt.dsl.i.orig
    ACPI_PREPROCESS i386-softmmu/q35-acpi-dsdt.dsl.i
    IASL i386-softmmu/q35-acpi-dsdt.dsl.i
    ACPI_EXTRACT i386-softmmu/q35-acpi-dsdt.off
    CAT i386-softmmu/hw/i386/q35-acpi-dsdt.hex
    CC    i386-softmmu/hw/i386/acpi-build.o
  /tmp/portage/app-emulation/qemu-2.1.1/work/qemu-2.1.1/hw/i386/acpi-build.=
c: In function 'acpi_get_dsdt':
  /tmp/portage/app-emulation/qemu-2.1.1/work/qemu-2.1.1/hw/i386/acpi-build.=
c:119:24: error: 'q35_dsdt_applesmc_sta' undeclared (first use in this func=
tion)
           applesmc_sta =3D q35_dsdt_applesmc_sta;
                          ^
  /tmp/portage/app-emulation/qemu-2.1.1/work/qemu-2.1.1/hw/i386/acpi-build.=
c:119:24: note: each undeclared identifier is reported only once for each f=
unction it appears in
  make[1]: *** [hw/i386/acpi-build.o] Error 1
  make: *** [subdir-i386-softmmu] Error 2

  Something seems to go wrong when generating the file
  i386-softmmu/hw/i386/q35-acpi-dsdt.hex:

  # grep -r q35_dsdt_applesmc_sta ../
  ../softmmu-build/x86_64-softmmu/q35-acpi-dsdt.dsl.i:/* ACPI_EXTRACT_NAME_=
BYTE_CONST q35_dsdt_applesmc_sta */
  ../softmmu-build/x86_64-softmmu/q35-acpi-dsdt.dsl.i.orig:        ACPI_EXT=
RACT_NAME_BYTE_CONST q35_dsdt_applesmc_sta
  ../softmmu-build/i386-softmmu/q35-acpi-dsdt.dsl.i:/* ACPI_EXTRACT_NAME_BY=
TE_CONST q35_dsdt_applesmc_sta */
  ../softmmu-build/i386-softmmu/q35-acpi-dsdt.dsl.i.orig:        ACPI_EXTRA=
CT_NAME_BYTE_CONST q35_dsdt_applesmc_sta
  ../hw/i386/acpi-build.c:        applesmc_sta =3D q35_dsdt_applesmc_sta;
  ../hw/i386/q35-acpi-dsdt.dsl:#define DSDT_APPLESMC_STA q35_dsdt_applesmc_=
sta

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1373362/+subscriptions
