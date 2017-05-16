Received: from eggs.gnu.org ([2001:4830:134:3::10]:46573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAent-0003Dy-CS
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAens-0001VU-Ks
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:29 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 16 May 2017 11:54:12 -0400
Message-Id: <20170516155420.10106-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/8] Block patches for curl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

The following changes since commit 3a8760664d5c1a1a93c9012bdb8ac07ab8fd4b0d:

  Merge tag 'tracing-pull-request' into staging (2017-05-12 10:39:35 -0400)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 2bb5c936c5827e1d831002f7a7517cb8c2c2201d:

  curl: do not do aio_poll when waiting for a free CURLState (2017-05-16 10:34:50 -0400)

----------------------------------------------------------------
Curl patches
----------------------------------------------------------------

Paolo Bonzini (7):
  curl: strengthen assertion in curl_clean_state
  curl: never invoke callbacks with s->mutex held
  curl: avoid recursive locking of BDRVCURLState mutex
  curl: split curl_find_state/curl_init_state
  curl: convert CURLAIOCB to byte values
  curl: convert readv to coroutines
  curl: do not do aio_poll when waiting for a free CURLState

Peter Krempa (1):
  block: curl: Allow passing cookies via QCryptoSecret

 block/curl.c         | 239 ++++++++++++++++++++++++++++++---------------------
 qapi/block-core.json |  12 ++-
 2 files changed, 153 insertions(+), 98 deletions(-)

-- 
2.9.3
