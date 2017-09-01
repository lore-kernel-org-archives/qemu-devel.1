Received: from eggs.gnu.org ([2001:4830:134:3::10]:55599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqII-0006yf-S0
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIG-0001Ry-LC
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:03:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnqIG-0001RU-Fr
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:03:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 864B781E1D
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 18:03:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:13 -0500
Message-Id: <20170901180340.30009-3-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 02/29] tests: Sort .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com

It doesn't matter if things are unsorted, but finding stuff in a list
is easier when it is sorted.  (Sorted under LC_ALL=C rules, rather than
en_US.UTF-8).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/.gitignore | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tests/.gitignore b/tests/.gitignore
index 64ecd6683b..8d35a58751 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -1,25 +1,27 @@
+*-test
 atomic_add-bench
 benchmark-crypto-cipher
 benchmark-crypto-hash
 benchmark-crypto-hmac
 check-qdict
-check-qnum
 check-qjson
 check-qlist
 check-qnull
-check-qstring
+check-qnum
 check-qom-interface
 check-qom-proplist
-multiboot/test.out
+check-qstring
 multiboot/*.elf
+multiboot/test.out
+qapi-schema/*.test.*
 qht-bench
 rcutorture
 test-aio
 test-aio-multithread
 test-arm-mptimer
 test-base64
-test-bitops
 test-bitcnt
+test-bitops
 test-blockjob
 test-blockjob-txn
 test-bufferiszero
@@ -35,18 +37,19 @@ test-crypto-ivgen
 test-crypto-pbkdf
 test-crypto-secret
 test-crypto-tlscredsx509
-test-crypto-tlscredsx509-work/
 test-crypto-tlscredsx509-certs/
+test-crypto-tlscredsx509-work/
 test-crypto-tlssession
-test-crypto-tlssession-work/
 test-crypto-tlssession-client/
 test-crypto-tlssession-server/
+test-crypto-tlssession-work/
 test-crypto-xts
 test-cutils
+test-filter-mirror
+test-filter-redirector
 test-hbitmap
 test-hmp
 test-int128
-test-iov
 test-io-channel-buffer
 test-io-channel-command
 test-io-channel-command.fifo
@@ -55,27 +58,29 @@ test-io-channel-file.txt
 test-io-channel-socket
 test-io-channel-tls
 test-io-task
+test-iov
 test-keyval
 test-logging
 test-mul64
+test-netfilter
 test-opts-visitor
 test-qapi-event.[ch]
 test-qapi-types.[ch]
 test-qapi-util
 test-qapi-visit.[ch]
 test-qdev-global-props
-test-qemu-opts
 test-qdist
+test-qemu-opts
 test-qga
 test-qht
 test-qht-par
 test-qmp-commands
 test-qmp-commands.h
 test-qmp-event
-test-qobject-input-strict
-test-qobject-input-visitor
 test-qmp-introspect.[ch]
 test-qmp-marshal.c
+test-qobject-input-strict
+test-qobject-input-visitor
 test-qobject-output-visitor
 test-rcu-list
 test-replication
@@ -92,8 +97,3 @@ test-write-threshold
 test-x86-cpuid
 test-x86-cpuid-compat
 test-xbzrle
-test-netfilter
-test-filter-mirror
-test-filter-redirector
-*-test
-qapi-schema/*.test.*
-- 
2.13.5
