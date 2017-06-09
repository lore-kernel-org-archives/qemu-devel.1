Received: from eggs.gnu.org ([2001:4830:134:3::10]:36905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJLi4-0003cm-4h
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJLi1-0006RR-19
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:20:24 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  9 Jun 2017 10:20:15 -0500
Message-Id: <20170609152017.7286-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qobject coccinelle followups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, marcandre.lureau@redhat.com, qemu-trivial@nongnu.org

Inspired by https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02505.html

Surprisingly, the updated script didn't find any existing longhand
use as candidates for QDECREF() (our last such use was cleaned up
as a side effect, in commit b72fe9e), but it DID find another straggler
missed in commit 579cf1d1.

Eric Blake (2):
  qobject: Update coccinelle script to catch Q{INC,DEC}REF
  qobject: Catch another straggler for use of qdict_put_str()

 qemu-img.c                       | 2 +-
 scripts/coccinelle/qobject.cocci | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.9.4
