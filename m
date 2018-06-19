Received: from eggs.gnu.org ([2001:4830:134:3::10]:32980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVNPT-0001gs-Oz
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVNPR-0007ya-6M
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:39:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVNPR-0007xe-0g
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:39:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 475C54021CC4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 20:39:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 19 Jun 2018 15:39:18 -0500
Message-Id: <20180619203918.65450-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] tests: Simplify .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com

Commit 0bcc8e5b was yet another instance of 'git status' reporting
dirty files after an in-tree build, thanks to the new binary
tests/check-block-qdict.

Instead of piecemeal exemptions of each new binary as they are
added, let's use git's negative globbing feature to exempt ALL
files that have a 'test-' or 'check-' prefix, except for the ones
ending in '.c' or '.sh'.  We still have a couple of generated
files that then need (re-)exclusion, but the overall list is a
LOT shorter, and less prone to needing future edits.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/.gitignore | 93 +++-----------------------------------------------------
 1 file changed, 5 insertions(+), 88 deletions(-)

diff --git a/tests/.gitignore b/tests/.gitignore
index 2bc61a9a58d..08e2df1ce1f 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -2,101 +2,18 @@ atomic_add-bench
 benchmark-crypto-cipher
 benchmark-crypto-hash
 benchmark-crypto-hmac
-check-qdict
-check-qnum
-check-qjson
-check-qlist
-check-qlit
-check-qnull
-check-qobject
-check-qstring
-check-qom-interface
-check-qom-proplist
+check-*
+!check-*.c
+!check-*.sh
 qht-bench
 rcutorture
-test-aio
-test-aio-multithread
-test-arm-mptimer
-test-base64
-test-bdrv-drain
-test-bitops
-test-bitcnt
-test-block-backend
-test-blockjob
-test-blockjob-txn
-test-bufferiszero
-test-char
-test-clone-visitor
-test-coroutine
-test-crypto-afsplit
-test-crypto-block
-test-crypto-cipher
-test-crypto-hash
-test-crypto-hmac
-test-crypto-ivgen
-test-crypto-pbkdf
-test-crypto-secret
-test-crypto-tlscredsx509
-test-crypto-tlscredsx509-work/
-test-crypto-tlscredsx509-certs/
-test-crypto-tlssession
-test-crypto-tlssession-work/
-test-crypto-tlssession-client/
-test-crypto-tlssession-server/
-test-crypto-xts
-test-cutils
-test-hbitmap
-test-hmp
-test-int128
-test-iov
-test-io-channel-buffer
-test-io-channel-command
-test-io-channel-command.fifo
-test-io-channel-file
-test-io-channel-file.txt
-test-io-channel-socket
-test-io-channel-tls
-test-io-task
-test-keyval
-test-logging
-test-mul64
-test-opts-visitor
+test-*
+!test-*.c
 test-qapi-commands.[ch]
 test-qapi-events.[ch]
 test-qapi-types.[ch]
-test-qapi-util
 test-qapi-visit.[ch]
-test-qdev-global-props
-test-qemu-opts
-test-qdist
-test-qga
-test-qht
-test-qht-par
-test-qmp-cmds
-test-qmp-event
-test-qobject-input-strict
-test-qobject-input-visitor
 test-qapi-introspect.[ch]
-test-qobject-output-visitor
-test-rcu-list
-test-replication
-test-shift128
-test-string-input-visitor
-test-string-output-visitor
-test-thread-pool
-test-throttle
-test-timed-average
-test-uuid
-test-util-sockets
-test-visitor-serialization
-test-vmstate
-test-write-threshold
-test-x86-cpuid
-test-x86-cpuid-compat
-test-xbzrle
-test-netfilter
-test-filter-mirror
-test-filter-redirector
 *-test
 qapi-schema/*.test.*
 vm/*.img
-- 
2.14.4
