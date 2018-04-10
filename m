Received: from eggs.gnu.org ([2001:4830:134:3::10]:51806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5vLV-0002VO-GT
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5vLU-0006IJ-PC
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:38:09 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Apr 2018 17:37:41 +0200
Message-Id: <20180410153748.22505-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Block layer patches for 2.12.0-rc3
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

The following changes since commit df6378eb0e6cfd58a22a1c3ff8fa4a9039f1ea=
a8:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180410-pull-requ=
est' into staging (2018-04-10 14:04:27 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to c1de5696d6a25b426432c147dfd7fb8a9eb86b89:

  qemu-iotests: update 185 output (2018-04-10 16:34:38 +0200)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Kevin Wolf (2):
      qemu-iotests: Remove _supported_fmt dmg
      commit/stream: Reset delay_ns

Philippe Mathieu-Daud=C3=A9 (1):
      hw/block/pflash_cfi: fix off-by-one error

Stefan Hajnoczi (1):
      qemu-iotests: update 185 output

Vladimir Sementsov-Ogievskiy (3):
      iotests.py: support unsupported_fmts in main()
      iotests.py: improve verify_image_format helper
      iotests: blacklist bochs and cloop for 205 and 208

 block/commit.c                |  2 ++
 block/stream.c                |  2 ++
 hw/block/pflash_cfi01.c       | 10 ++++------
 hw/block/pflash_cfi02.c       |  9 ++++-----
 tests/qemu-iotests/183        |  2 +-
 tests/qemu-iotests/185        | 10 ++++++----
 tests/qemu-iotests/185.out    | 12 +++++++-----
 tests/qemu-iotests/194        |  2 +-
 tests/qemu-iotests/205        |  2 +-
 tests/qemu-iotests/208        |  2 ++
 tests/qemu-iotests/iotests.py | 19 ++++++++++++++-----
 11 files changed, 44 insertions(+), 28 deletions(-)
