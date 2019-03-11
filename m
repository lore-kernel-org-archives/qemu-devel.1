Received: from eggs.gnu.org ([209.51.188.92]:48046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38qb-0007Yh-6B
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38qa-0003Qm-86
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38qa-0003QD-0P
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:16 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 01:30:47 +0100
Message-Id: <20190311003052.13778-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] travis-ci: Build EDK2 roms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Michal=20Pr=C3=ADvozn=C3=ADk?= <mprivozn@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

This series add a job to Travis CI to build the last EDK2 stable
release roms within QEMU.
This job is only triggered if a commit matches 'EDK2' or during
QEMU releases (when tags are pushed).

Job output: https://travis-ci.org/philmd/qemu/jobs/504460932
Duration: 33 min 51 sec (output 5080 lines)

Based on Laszlo's series "bundle edk2 platform firmware with QEMU":
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02846.html

Please review,

Phil.

Based-on: 20190309004826.9027-1-lersek@redhat.com

Philippe Mathieu-Daud=C3=A9 (5):
  roms/edk2: Avoid bashism in Makefile 'shell' function
  roms/edk2: Avoid bashism in script
  roms/edk2: Pass extra arguments to the build script via
    EDK2_BUILD_OPTIONS
  NOTFORMERGE roms/edk2: Use arm-linux-gnueabihf-gcc on Debian based
    distribs
  .travis.yml: Build and install EDK2 roms

 .travis.yml        | 21 +++++++++++++++++++++
 roms/Makefile.edk2 |  8 +++++++-
 roms/edk2-funcs.sh |  9 +++++++--
 3 files changed, 35 insertions(+), 3 deletions(-)

--=20
2.20.1
