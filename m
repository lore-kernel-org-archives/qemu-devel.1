Received: from eggs.gnu.org ([209.51.188.92]:59176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5E-0007y0-H4
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5C-0004Pi-OE
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:58:40 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:57:50 +0100
Message-Id: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/33] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit c4e0780ed1ffd056f205348d387a61b4136a45=
df:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-p=
ull-request' into staging (2019-03-07 18:40:43 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to e88153ea9a40009a8ae7648282c0eac1b7f5494f:

  qcow2 spec: Describe string header extensions (2019-03-08 12:26:46 +010=
0)

----------------------------------------------------------------
Block layer patches:

- qcow2: Support for external data files
- qcow2: Default to 4KB for the qcow2 cache entry size
- Apply block driver whitelist for -drive format=3Dhelp
- Several qemu-iotests improvements

----------------------------------------------------------------
Alberto Garcia (1):
      qcow2: Default to 4KB for the qcow2 cache entry size

Andrey Shinkevich (4):
      iotests: open notrun files in text mode
      block: iterate_format with account of whitelisting
      iotests: ask QEMU for supported formats
      iotests: check whitelisted formats

Kevin Wolf (21):
      qemu-iotests: Test qcow2 preallocation modes
      qcow2: Simplify preallocation code
      qcow2: Extend spec for external data files
      qcow2: Basic definitions for external data files
      qcow2: Pass bs to qcow2_get_cluster_type()
      qcow2: Prepare qcow2_get_cluster_type() for external data file
      qcow2: Prepare count_contiguous_clusters() for external data file
      qcow2: Don't assume 0 is an invalid cluster offset
      qcow2: Return 0/-errno in qcow2_alloc_compressed_cluster_offset()
      qcow2: Prepare qcow2_co_block_status() for data file
      qcow2: External file I/O
      qcow2: Return error for snapshot operation with data file
      qcow2: Support external data file in qemu-img check
      qcow2: Add basic data-file infrastructure
      qcow2: Creating images with external data file
      qcow2: Store data file name in the image
      qcow2: Implement data-file-raw create option
      qemu-iotests: Preallocation with external data file
      qemu-iotests: General tests for qcow2 with external data file
      qemu-iotests: amend with external data file
      qcow2 spec: Describe string header extensions

Philippe Mathieu-Daud=C3=A9 (6):
      tests/multiboot: Improve portability by searching bash in the $PATH
      tests/bios-tables: Improve portability by searching bash in the $PA=
TH
      qemu-iotests: Improve portability by searching bash in the $PATH
      qemu-iotests: Ensure GNU sed is used
      ahci-test: Add dependency to qemu-img tool
      qemu-iotests: Add dependency to qemu-nbd tool

Stefan Hajnoczi (1):
      iotests: use iotests.VM in 238

 qapi/block-core.json                    |  26 ++-
 docs/interop/qcow2.txt                  |  54 +++++-
 docs/qcow2-cache.txt                    |  17 +-
 block/qcow2.h                           |  66 +++++--
 include/block/block.h                   |   2 +-
 include/block/block_int.h               |   2 +
 block.c                                 |  23 ++-
 block/qcow2-bitmap.c                    |   7 +-
 block/qcow2-cache.c                     |   6 +-
 block/qcow2-cluster.c                   | 182 +++++++++++-------
 block/qcow2-refcount.c                  |  88 ++++++---
 block/qcow2-snapshot.c                  |  22 ++-
 block/qcow2.c                           | 326 ++++++++++++++++++++++++++=
+-----
 blockdev.c                              |   4 +-
 qemu-img.c                              |   2 +-
 tests/Makefile.include                  |   4 +-
 tests/data/acpi/rebuild-expected-aml.sh |   2 +-
 tests/multiboot/run_test.sh             |   2 +-
 tests/qemu-iotests/001                  |   2 +-
 tests/qemu-iotests/002                  |   2 +-
 tests/qemu-iotests/003                  |   2 +-
 tests/qemu-iotests/004                  |   2 +-
 tests/qemu-iotests/005                  |   2 +-
 tests/qemu-iotests/007                  |   2 +-
 tests/qemu-iotests/008                  |   2 +-
 tests/qemu-iotests/009                  |   2 +-
 tests/qemu-iotests/010                  |   2 +-
 tests/qemu-iotests/011                  |   2 +-
 tests/qemu-iotests/012                  |   2 +-
 tests/qemu-iotests/013                  |   2 +-
 tests/qemu-iotests/014                  |   2 +-
 tests/qemu-iotests/015                  |   2 +-
 tests/qemu-iotests/017                  |   2 +-
 tests/qemu-iotests/018                  |   2 +-
 tests/qemu-iotests/019                  |   2 +-
 tests/qemu-iotests/020                  |   2 +-
 tests/qemu-iotests/021                  |   2 +-
 tests/qemu-iotests/022                  |   2 +-
 tests/qemu-iotests/023                  |   2 +-
 tests/qemu-iotests/024                  |   2 +-
 tests/qemu-iotests/025                  |   2 +-
 tests/qemu-iotests/026                  |   2 +-
 tests/qemu-iotests/027                  |   2 +-
 tests/qemu-iotests/028                  |   2 +-
 tests/qemu-iotests/029                  |   2 +-
 tests/qemu-iotests/031                  |   2 +-
 tests/qemu-iotests/031.out              |   8 +-
 tests/qemu-iotests/032                  |   2 +-
 tests/qemu-iotests/033                  |   2 +-
 tests/qemu-iotests/034                  |   2 +-
 tests/qemu-iotests/035                  |   2 +-
 tests/qemu-iotests/036                  |   2 +-
 tests/qemu-iotests/036.out              |   4 +-
 tests/qemu-iotests/037                  |   2 +-
 tests/qemu-iotests/038                  |   2 +-
 tests/qemu-iotests/039                  |   2 +-
 tests/qemu-iotests/042                  |   2 +-
 tests/qemu-iotests/043                  |   2 +-
 tests/qemu-iotests/046                  |   2 +-
 tests/qemu-iotests/047                  |   2 +-
 tests/qemu-iotests/048                  |   2 +-
 tests/qemu-iotests/049                  |   2 +-
 tests/qemu-iotests/050                  |   2 +-
 tests/qemu-iotests/051                  |   2 +-
 tests/qemu-iotests/052                  |   2 +-
 tests/qemu-iotests/053                  |   2 +-
 tests/qemu-iotests/054                  |   2 +-
 tests/qemu-iotests/058                  |   2 +-
 tests/qemu-iotests/059                  |   2 +-
 tests/qemu-iotests/060                  |   2 +-
 tests/qemu-iotests/061                  |  47 ++++-
 tests/qemu-iotests/061.out              | 103 +++++++++-
 tests/qemu-iotests/062                  |   2 +-
 tests/qemu-iotests/063                  |   2 +-
 tests/qemu-iotests/064                  |   2 +-
 tests/qemu-iotests/066                  |   2 +-
 tests/qemu-iotests/067                  |   2 +-
 tests/qemu-iotests/068                  |   2 +-
 tests/qemu-iotests/069                  |   2 +-
 tests/qemu-iotests/070                  |   2 +-
 tests/qemu-iotests/071                  |   2 +-
 tests/qemu-iotests/072                  |   2 +-
 tests/qemu-iotests/073                  |   2 +-
 tests/qemu-iotests/074                  |   2 +-
 tests/qemu-iotests/075                  |   2 +-
 tests/qemu-iotests/076                  |   2 +-
 tests/qemu-iotests/077                  |   2 +-
 tests/qemu-iotests/078                  |   2 +-
 tests/qemu-iotests/079                  |   2 +-
 tests/qemu-iotests/080                  |   2 +-
 tests/qemu-iotests/081                  |   2 +-
 tests/qemu-iotests/082                  |   2 +-
 tests/qemu-iotests/082.out              |  54 ++++++
 tests/qemu-iotests/083                  |   2 +-
 tests/qemu-iotests/084                  |   2 +-
 tests/qemu-iotests/085                  |   2 +-
 tests/qemu-iotests/086                  |   2 +-
 tests/qemu-iotests/087                  |   2 +-
 tests/qemu-iotests/088                  |   2 +-
 tests/qemu-iotests/089                  |   2 +-
 tests/qemu-iotests/090                  |   2 +-
 tests/qemu-iotests/091                  |   2 +-
 tests/qemu-iotests/092                  |   2 +-
 tests/qemu-iotests/094                  |   2 +-
 tests/qemu-iotests/095                  |   2 +-
 tests/qemu-iotests/097                  |   2 +-
 tests/qemu-iotests/098                  |   2 +-
 tests/qemu-iotests/099                  |   2 +-
 tests/qemu-iotests/101                  |   2 +-
 tests/qemu-iotests/102                  |   2 +-
 tests/qemu-iotests/103                  |   2 +-
 tests/qemu-iotests/104                  |   2 +-
 tests/qemu-iotests/105                  |   2 +-
 tests/qemu-iotests/106                  |   2 +-
 tests/qemu-iotests/107                  |   2 +-
 tests/qemu-iotests/108                  |   2 +-
 tests/qemu-iotests/109                  |   2 +-
 tests/qemu-iotests/110                  |   2 +-
 tests/qemu-iotests/111                  |   2 +-
 tests/qemu-iotests/112                  |   2 +-
 tests/qemu-iotests/113                  |   2 +-
 tests/qemu-iotests/114                  |   2 +-
 tests/qemu-iotests/115                  |   2 +-
 tests/qemu-iotests/116                  |   2 +-
 tests/qemu-iotests/117                  |   2 +-
 tests/qemu-iotests/119                  |   2 +-
 tests/qemu-iotests/120                  |   2 +-
 tests/qemu-iotests/121                  |   2 +-
 tests/qemu-iotests/122                  |   2 +-
 tests/qemu-iotests/123                  |   2 +-
 tests/qemu-iotests/125                  |   2 +-
 tests/qemu-iotests/126                  |   2 +-
 tests/qemu-iotests/127                  |   2 +-
 tests/qemu-iotests/128                  |   2 +-
 tests/qemu-iotests/130                  |   2 +-
 tests/qemu-iotests/131                  |   2 +-
 tests/qemu-iotests/133                  |   2 +-
 tests/qemu-iotests/134                  |   2 +-
 tests/qemu-iotests/135                  |   2 +-
 tests/qemu-iotests/137                  |   2 +-
 tests/qemu-iotests/138                  |   2 +-
 tests/qemu-iotests/139                  |   3 +
 tests/qemu-iotests/140                  |   2 +-
 tests/qemu-iotests/141                  |   2 +-
 tests/qemu-iotests/142                  |   2 +-
 tests/qemu-iotests/143                  |   2 +-
 tests/qemu-iotests/144                  |   2 +-
 tests/qemu-iotests/145                  |   2 +-
 tests/qemu-iotests/146                  |   2 +-
 tests/qemu-iotests/150                  |   2 +-
 tests/qemu-iotests/153                  |   2 +-
 tests/qemu-iotests/154                  |   2 +-
 tests/qemu-iotests/156                  |   2 +-
 tests/qemu-iotests/157                  |   2 +-
 tests/qemu-iotests/158                  |   2 +-
 tests/qemu-iotests/159                  |   2 +-
 tests/qemu-iotests/160                  |   2 +-
 tests/qemu-iotests/161                  |   2 +-
 tests/qemu-iotests/162                  |   2 +-
 tests/qemu-iotests/170                  |   2 +-
 tests/qemu-iotests/171                  |   2 +-
 tests/qemu-iotests/172                  |   2 +-
 tests/qemu-iotests/173                  |   2 +-
 tests/qemu-iotests/174                  |   2 +-
 tests/qemu-iotests/175                  |   2 +-
 tests/qemu-iotests/176                  |   2 +-
 tests/qemu-iotests/177                  |   2 +-
 tests/qemu-iotests/178                  |   2 +-
 tests/qemu-iotests/179                  |   2 +-
 tests/qemu-iotests/181                  |   2 +-
 tests/qemu-iotests/182                  |   2 +-
 tests/qemu-iotests/183                  |   2 +-
 tests/qemu-iotests/184                  |   2 +-
 tests/qemu-iotests/185                  |   2 +-
 tests/qemu-iotests/186                  |   2 +-
 tests/qemu-iotests/187                  |   2 +-
 tests/qemu-iotests/188                  |   2 +-
 tests/qemu-iotests/189                  |   2 +-
 tests/qemu-iotests/190                  |   2 +-
 tests/qemu-iotests/191                  |   2 +-
 tests/qemu-iotests/192                  |   2 +-
 tests/qemu-iotests/195                  |   2 +-
 tests/qemu-iotests/197                  |   2 +-
 tests/qemu-iotests/198                  |   2 +-
 tests/qemu-iotests/200                  |   2 +-
 tests/qemu-iotests/201                  |   2 +-
 tests/qemu-iotests/204                  |   2 +-
 tests/qemu-iotests/214                  |   2 +-
 tests/qemu-iotests/215                  |   2 +-
 tests/qemu-iotests/217                  |   2 +-
 tests/qemu-iotests/220                  |   2 +-
 tests/qemu-iotests/220.out              |   2 +-
 tests/qemu-iotests/221                  |   2 +-
 tests/qemu-iotests/223                  |   2 +-
 tests/qemu-iotests/225                  |   2 +-
 tests/qemu-iotests/226                  |   2 +-
 tests/qemu-iotests/227                  |   2 +-
 tests/qemu-iotests/229                  |   2 +-
 tests/qemu-iotests/231                  |   2 +-
 tests/qemu-iotests/232                  |   2 +-
 tests/qemu-iotests/233                  |   2 +-
 tests/qemu-iotests/238                  |   7 +-
 tests/qemu-iotests/243                  |  85 +++++++++
 tests/qemu-iotests/243.out              |  58 ++++++
 tests/qemu-iotests/244                  | 200 ++++++++++++++++++++
 tests/qemu-iotests/244.out              | 125 ++++++++++++
 tests/qemu-iotests/check                |  15 +-
 tests/qemu-iotests/common.config        |   2 +-
 tests/qemu-iotests/common.filter        |  38 ++--
 tests/qemu-iotests/common.nbd           |   2 +-
 tests/qemu-iotests/common.pattern       |   2 +-
 tests/qemu-iotests/common.qemu          |   2 +-
 tests/qemu-iotests/common.rc            |  15 +-
 tests/qemu-iotests/common.tls           |   2 +-
 tests/qemu-iotests/group                |   2 +
 tests/qemu-iotests/iotests.py           |  45 ++++-
 216 files changed, 1585 insertions(+), 423 deletions(-)
 create mode 100755 tests/qemu-iotests/243
 create mode 100644 tests/qemu-iotests/243.out
 create mode 100755 tests/qemu-iotests/244
 create mode 100644 tests/qemu-iotests/244.out
