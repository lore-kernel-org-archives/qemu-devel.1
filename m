Received: from eggs.gnu.org ([209.51.188.92]:57916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAQ-0000RH-5D
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAP-0001jZ-B0
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1h2QAP-0001iA-2F
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D36A307D8E2
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 00:48:44 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Sat,  9 Mar 2019 01:48:19 +0100
Message-Id: <20190309004826.9027-4-lersek@redhat.com>
In-Reply-To: <20190309004826.9027-1-lersek@redhat.com>
References: <20190309004826.9027-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/10] tests/uefi-test-tools/build.sh: work
 around TianoCore#1607
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

The edk2-stabe201903 release introduced Python3 support to edk2's
BaseTools; however the Python3 enablement breaks in a corner case (which
is nevertheless supported by the edk2 community), namely the in-module
parallelization that we utilize.

This is tracked under
<https://bugzilla.tianocore.org/show_bug.cgi?id=3D1607>. For now, work
around the issue (in advance) by forcing Python2. (The workaround is a
no-op before we move to edk2-stabe201903 in the roms/edk2 submodule.)

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 tests/uefi-test-tools/build.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/uefi-test-tools/build.sh b/tests/uefi-test-tools/build=
.sh
index e2b52c855c39..8aa7935c43bb 100755
--- a/tests/uefi-test-tools/build.sh
+++ b/tests/uefi-test-tools/build.sh
@@ -29,6 +29,9 @@ export PACKAGES_PATH=3D$(realpath -- "$edk2_dir")
 export WORKSPACE=3D$PWD
 mkdir -p Conf
=20
+# Work around <https://bugzilla.tianocore.org/show_bug.cgi?id=3D1607>.
+export PYTHON_COMMAND=3Dpython2
+
 # Source "edksetup.sh" carefully.
 set +e +u +C
 source "$PACKAGES_PATH/edksetup.sh"
--=20
2.19.1.3.g30247aa5d201
