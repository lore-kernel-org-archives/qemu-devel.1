Received: from eggs.gnu.org ([2001:4830:134:3::10]:44475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpwqs-00005B-AM
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpwqr-0005MP-LM
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:55:58 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 13:55:43 +0100
Message-Id: <1490014548-15083-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 0/5] keyval: Doc improvements and
 additional tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com

These are basically leftovers from review of "block: Command line
option -blockdev".  Non-test code is unchanged.  Nice to have in 2.9.

Markus Armbruster (5):
  test-keyval: Tweaks to improve list coverage
  keyval: Improve some comments
  test-keyval: Cover alternate and 'any' type
  keyval: Document issues with 'any' and alternate types
  MAINTAINERS: Add myself for files I touched recently

 MAINTAINERS            | 11 ++++++++++
 tests/Makefile.include |  2 +-
 tests/test-keyval.c    | 59 +++++++++++++++++++++++++++++++++++++++++++++++---
 util/keyval.c          | 57 ++++++++++++++++++++++++++++++++++--------------
 4 files changed, 109 insertions(+), 20 deletions(-)

-- 
2.7.4
