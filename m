Received: from eggs.gnu.org ([2001:4830:134:3::10]:57035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gRxGj-0002lx-MP
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gRxA1-0007do-88
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:33:42 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:35145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gRxA1-0007bs-1N
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:33:37 -0500
From: Fei Li <fli@suse.com>
Date: Wed, 28 Nov 2018 18:33:03 +0800
Message-Id: <20181128103308.26755-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH RFC 0/5] fix some segmentation faults and
 migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

These five patches are almost get the Reviewed-by and extracted from
previous "[PATCH RFC v7 0/9] qemu_thread_create: propagate errors to
callers to check."  The mentioned patch series have waited on one
multifd issue for a while and still needs a further discussion.

Thus separate(send) these five almost-done patches and hope they can
be merged for the next tag. Thanks for the review. :)


Fei Li (5):
  Fix segmentation fault when qemu_signal_init fails
  qemu_thread_join: fix segmentation fault
  migration: fix the multifd code when receiving less channels
  migration: remove unused &local_err parameter in multifd_save_cleanup
  migration: add more error handling for postcopy_ram_enable_notify

 migration/channel.c      | 11 ++++++-----
 migration/migration.c    | 14 ++++++++------
 migration/migration.h    |  2 +-
 migration/postcopy-ram.c |  1 +
 migration/ram.c          | 18 ++++++++++--------
 migration/ram.h          |  4 ++--
 migration/savevm.c       |  1 +
 util/main-loop.c         |  8 ++++----
 util/qemu-thread-posix.c |  3 +++
 util/qemu-thread-win32.c |  2 +-
 10 files changed, 37 insertions(+), 27 deletions(-)

-- 
2.13.7
