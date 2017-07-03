Received: from eggs.gnu.org ([2001:4830:134:3::10]:47244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7IG-00008n-9i
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7IF-0003hD-BM
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:46:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS7IF-0003fs-4y
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:59 -0400
Date: Mon, 3 Jul 2017 22:45:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1499111049-13721-22-git-send-email-mst@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499111049-13721-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 21/21] i386/acpi: update expected acpi files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

We dropped some dead code, update extected table binaries.

Fixes: 4d7e7f2702912 ("hw/acpi: remove dead acpi code")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-test-data/q35/DSDT        | Bin 7824 -> 7782 bytes
 tests/acpi-test-data/q35/DSDT.bridge | Bin 7841 -> 7799 bytes
 tests/acpi-test-data/q35/DSDT.cphp   | Bin 8287 -> 8245 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt | Bin 7899 -> 7857 bytes
 tests/acpi-test-data/q35/DSDT.memhp  | Bin 9189 -> 9147 bytes
 5 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/acpi-test-data/q35/DSDT b/tests/acpi-test-data/q35/DSDT
index 0dccad439b8e8e00b403c8d290a89630c4329d45..a6138c829142265255ac6f7bedd44757e944eb2f 100644
GIT binary patch
delta 22
dcmbPW`^<*RCD<h-O^$(qF?=Fd>c*MhWdTt92V(#L

delta 64
zcmaE6Gr^Y2CD<iof*b<_W9>w)R87tJV5j)#h5+Z_5Jql>bzD4Pwi6>a&pO8FMsA?E
PlS6>BrxVA<ydSavP8<?a

diff --git a/tests/acpi-test-data/q35/DSDT.bridge b/tests/acpi-test-data/q35/DSDT.bridge
index 8cd66c3b3143297a5262480e46be9ee811a6291f..6b90f606f8b76f71ea9c569f4e606aeecd9e239d 100644
GIT binary patch
delta 22
dcmZ2z``w1iCD<jTT#kW(@%u!s)QvMa<N#O32S@+_

delta 64
zcmexvv(T2yCD<iop&SDPqwGYkR87tJV5j)#h5+Z_5Jql>bzD4Pwi6>a&pO8FMsA?E
PlS6>BrxVA<JWe?PMT8MI

diff --git a/tests/acpi-test-data/q35/DSDT.cphp b/tests/acpi-test-data/q35/DSDT.cphp
index 3c28a17a69db15dc92c825c1502a7f86ab975c0d..976755ef2dc8ab68a82b64ab9fff793c4a113db9 100644
GIT binary patch
delta 22
ecmccbu+@RfCD<jzRDpqk@xnx|)QvNb$pZjYfCr-h

delta 64
zcmdn$aNmK;CD<h-UV(vu@!LeMR87tJV5j)#h5+Z_5Jql>bzD4Pwi6>a&pO8FMsA?E
PlS6>BrxVA<yyNl!W7ras

diff --git a/tests/acpi-test-data/q35/DSDT.ipmibt b/tests/acpi-test-data/q35/DSDT.ipmibt
index 3ceb876127725f199e3df903bc71e4023e2fa225..b3fa4359ff2cad5569bb625dff7be8f8b4590ba9 100644
GIT binary patch
delta 22
dcmca@yU~`*CD<ioqZ|VRW6eaa)QvNp<N#Ld2Q~lz

delta 64
zcmdmJd)t=FCD<k8wj2Wk<D!XNshXPc!A|kf4FS%<A&lG%>$rHpY$rx;o^_1Tjod(S
PCx-xMPbZFzdCqbGX)_Wf

diff --git a/tests/acpi-test-data/q35/DSDT.memhp b/tests/acpi-test-data/q35/DSDT.memhp
index bdbefd47a5398ed96498b77bfb6a74f7ea638db1..7341c405bfb7dd21b4ec5df92411963cdf894c4d 100644
GIT binary patch
delta 22
dcmaFrzT2J4CD<iow=x3*WAsF>)QvNJlmS`p2U`FD

delta 64
zcmdn({?whzCD<k8sWJltW8*}wR87tJV5j)#h5+Z_5Jql>bzD4Pwi6>a&pO8FMsA?E
PlS6>BrxVA<JYQu1Z_*M<

-- 
MST
