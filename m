Received: from eggs.gnu.org ([2001:4830:134:3::10]:53293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCihq-0005kf-41
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCihb-00012S-63
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCihX-0000xP-RH
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:16 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:04:55 +0200
Message-Id: <1539770707-7289-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/15] tests: Prevent more accidental test
 disabling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

GNU make is perfectly happy to use 'check-FOO-y +=3D bar' to
initialize check-FOO-y.  (GNU Automake strictly insists that
you cannot use +=3D until after an initial =3D per variable, but
thankfully we aren't using automake).

As we have had more than one instance where copy-and-paste of
'check-FOO-y =3D bar' from a first test under category FOO into
an additional test, which ends up disabling the first (see
commits 992159c7 and 4429532b), it's better to just always use
the form that survives copy-and-paste, even for categories that
don't currently add more than one test.

Done with s/^\(check-[a-z]*-y \)=3D/\1+=3D/g

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5eadfd5..b68cbb3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -38,7 +38,7 @@ $(SRC_PATH)/scripts/qapi-gen.py
 SYSEMU_TARGET_LIST :=3D $(subst -softmmu.mak,,$(notdir \
    $(wildcard $(SRC_PATH)/default-configs/*-softmmu.mak)))
=20
-check-unit-y =3D tests/check-qdict$(EXESUF)
+check-unit-y +=3D tests/check-qdict$(EXESUF)
 gcov-files-check-qdict-y =3D qobject/qdict.c
 check-unit-y +=3D tests/check-block-qdict$(EXESUF)
 gcov-files-check-block-qdict-y =3D qobject/block-qdict.c
@@ -181,7 +181,7 @@ check-block-$(CONFIG_POSIX) +=3D tests/qemu-iotests-q=
uick.sh
 # All QTests for now are POSIX-only, but the dependencies are
 # really in libqtest, not in the testcases themselves.
=20
-check-qtest-generic-y =3D tests/qmp-test$(EXESUF)
+check-qtest-generic-y +=3D tests/qmp-test$(EXESUF)
 gcov-files-generic-y =3D monitor.c qapi/qmp-dispatch.c
 check-qtest-generic-y +=3D tests/qmp-cmd-test$(EXESUF)
=20
@@ -324,13 +324,13 @@ check-qtest-x86_64-$(CONFIG_SDHCI) +=3D tests/sdhci=
-test$(EXESUF)
 gcov-files-i386-y +=3D i386-softmmu/hw/timer/mc146818rtc.c
 gcov-files-x86_64-y =3D $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-fil=
es-i386-y))
=20
-check-qtest-alpha-y =3D tests/boot-serial-test$(EXESUF)
+check-qtest-alpha-y +=3D tests/boot-serial-test$(EXESUF)
=20
-check-qtest-hppa-y =3D tests/boot-serial-test$(EXESUF)
+check-qtest-hppa-y +=3D tests/boot-serial-test$(EXESUF)
=20
 check-qtest-m68k-y =3D tests/boot-serial-test$(EXESUF)
=20
-check-qtest-microblaze-y =3D tests/boot-serial-test$(EXESUF)
+check-qtest-microblaze-y +=3D tests/boot-serial-test$(EXESUF)
=20
 check-qtest-mips-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF=
)
=20
@@ -338,7 +338,7 @@ check-qtest-mips64-$(CONFIG_ISA_TESTDEV) =3D tests/en=
dianness-test$(EXESUF)
=20
 check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EX=
ESUF)
=20
-check-qtest-moxie-y =3D tests/boot-serial-test$(EXESUF)
+check-qtest-moxie-y +=3D tests/boot-serial-test$(EXESUF)
=20
 check-qtest-ppc-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF)
 check-qtest-ppc-y +=3D tests/boot-order-test$(EXESUF)
@@ -348,7 +348,7 @@ check-qtest-ppc-y +=3D tests/boot-serial-test$(EXESUF=
)
 check-qtest-ppc-y +=3D tests/m48t59-test$(EXESUF)
 gcov-files-ppc-y +=3D hw/timer/m48t59.c
=20
-check-qtest-ppc64-y =3D $(check-qtest-ppc-y)
+check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
 gcov-files-ppc64-y =3D $(subst ppc-softmmu/,ppc64-softmmu/,$(gcov-files-=
ppc-y))
 check-qtest-ppc64-y +=3D tests/spapr-phb-test$(EXESUF)
 gcov-files-ppc64-y +=3D ppc64-softmmu/hw/ppc/spapr_pci.c
@@ -377,7 +377,7 @@ check-qtest-sh4-$(CONFIG_ISA_TESTDEV) =3D tests/endia=
nness-test$(EXESUF)
=20
 check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESU=
F)
=20
-check-qtest-sparc-y =3D tests/prom-env-test$(EXESUF)
+check-qtest-sparc-y +=3D tests/prom-env-test$(EXESUF)
 check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)
 gcov-files-sparc-y =3D hw/timer/m48t59.c
 check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)
@@ -386,7 +386,7 @@ check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D tests/e=
ndianness-test$(EXESUF)
 check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)
 check-qtest-sparc64-y +=3D tests/boot-serial-test$(EXESUF)
=20
-check-qtest-arm-y =3D tests/tmp105-test$(EXESUF)
+check-qtest-arm-y +=3D tests/tmp105-test$(EXESUF)
 check-qtest-arm-y +=3D tests/pca9552-test$(EXESUF)
 check-qtest-arm-y +=3D tests/ds1338-test$(EXESUF)
 check-qtest-arm-y +=3D tests/m25p80-test$(EXESUF)
@@ -404,9 +404,9 @@ check-qtest-aarch64-$(CONFIG_SDHCI) +=3D tests/sdhci-=
test$(EXESUF)
 check-qtest-aarch64-y +=3D tests/boot-serial-test$(EXESUF)
 check-qtest-aarch64-y +=3D tests/migration-test$(EXESUF)
=20
-check-qtest-microblazeel-y =3D $(check-qtest-microblaze-y)
+check-qtest-microblazeel-y +=3D $(check-qtest-microblaze-y)
=20
-check-qtest-xtensaeb-y =3D $(check-qtest-xtensa-y)
+check-qtest-xtensaeb-y +=3D $(check-qtest-xtensa-y)
=20
 check-qtest-s390x-y =3D tests/boot-serial-test$(EXESUF)
 check-qtest-s390x-$(CONFIG_SLIRP) +=3D tests/pxe-test$(EXESUF)
--=20
1.8.3.1
