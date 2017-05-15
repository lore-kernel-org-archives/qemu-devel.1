Received: from eggs.gnu.org ([2001:4830:134:3::10]:49452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dACoR-0000SW-OD
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dACoO-0005pZ-1j
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:01:11 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 May 2017 12:00:52 +0200
Message-Id: <20170515100059.15795-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/7] curl: locking cleanups/fixes,
 coroutine conversion, remove aio_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

Compared to v2, this silences checkpatch and correctly destroy the mutex on
exiting from curl_open with an error.

Paolo

Paolo Bonzini (7):
  curl: strengthen assertion in curl_clean_state
  curl: never invoke callbacks with s->mutex held
  curl: avoid recursive locking of BDRVCURLState mutex
  curl: split curl_find_state/curl_init_state
  curl: convert CURLAIOCB to byte values
  curl: convert readv to coroutines
  curl: do not do aio_poll when waiting for a free CURLState

 block/curl.c | 217 +++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 121 insertions(+), 96 deletions(-)

-- 
2.12.2
