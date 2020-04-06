Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F49C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 19:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2478C206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 19:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d76FctLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2478C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLXCw-0002ct-8o
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 15:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLXBe-00014P-DF
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLXBc-0006j9-0a
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:13:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38937
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLXBb-0006ir-RB
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586200411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=POVW9ePUf/Ib4Kc+laUKo0y2kHQOilu154c/mjCyHmc=;
 b=d76FctLnEpJo7wNOj15yIQC9WwFlxDsA5N6FOxwrDaq43MEmDlvUyuSuhi4JguIOc3ojoC
 sLWS/nNq19TnhfzCgiZXXAUsemCbGKlVasFoZFpjYEdeV0r9ZVUiiNFVsG+PBKJVZwtydV
 9nR4Zzwe2bZ54B8UgbADRw5euguBQ54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-m2quIq1yM9255sn-sYspUg-1; Mon, 06 Apr 2020 15:13:27 -0400
X-MC-Unique: m2quIq1yM9255sn-sYspUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B5B71005513;
 Mon,  6 Apr 2020 19:13:26 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A5C162697;
 Mon,  6 Apr 2020 19:13:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] atomics: update documentation for C11
Date: Mon,  6 Apr 2020 15:13:18 -0400
Message-Id: <20200406191320.13371-3-pbonzini@redhat.com>
In-Reply-To: <20200406191320.13371-1-pbonzini@redhat.com>
References: <20200406191320.13371-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Ying Fang <fangying1@huawei.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Deprecate atomic_mb_read and atomic_mb_set; it is not really possible to
use them correctly because they do not interoperate with sequentially-consi=
stent
RMW operations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/atomics.rst | 290 ++++++++++++++++-------------------------
 1 file changed, 114 insertions(+), 176 deletions(-)

diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
index 00f3f7d3ed..e92752a64d 100644
--- a/docs/devel/atomics.rst
+++ b/docs/devel/atomics.rst
@@ -11,10 +11,15 @@ that is consistent with the expectations of the program=
mer.
 The most basic tool is locking.  Mutexes, condition variables and
 semaphores are used in QEMU, and should be the default approach to
 synchronization.  Anything else is considerably harder, but it's
-also justified more often than one would like.  The two tools that
-are provided by ``qemu/atomic.h`` are memory barriers and atomic operation=
s.
+also justified more often than one would like;
+the most performance-critical parts of QEMU in particular require
+a very low level approach to concurrency, involving memory barriers
+and atomic operations.  The semantics of concurrent memory accesses are go=
verned
+by the C11 memory model.
=20
-Macros defined by ``qemu/atomic.h`` fall in three camps:
+QEMU provides a header, ``qemu/atomic.h``, which wraps C11 atomics to
+provide better portability and a less verbose syntax.  ``qemu/atomic.h``
+provides macros that fall in three camps:
=20
 - compiler barriers: ``barrier()``;
=20
@@ -24,6 +29,14 @@ Macros defined by ``qemu/atomic.h`` fall in three camps:
=20
 - sequentially consistent atomic access: everything else.
=20
+In general, use of ``qemu/atomic.h`` should be wrapped with more easily
+used data structures (e.g. the lock-free singly-liked list operations
+``QSLIST_INSERT_HEAD_ATOMIC`` and ``QSLIST_MOVE_ATOMIC``) or synchronizati=
on
+primitives (such as RCU, ``QemuEvent`` or ``QemuLockCnt``).  Bare use of
+atomic operations and memory barriers should be limited to inter-thread
+checking of flags and documented thoroughly.
+
+
=20
 Compiler memory barrier
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -85,36 +98,14 @@ Similar operations return the new value of ``*ptr``::
     typeof(*ptr) atomic_or_fetch(ptr, val)
     typeof(*ptr) atomic_xor_fetch(ptr, val)
=20
-Sequentially consistent loads and stores can be done using::
-
-    atomic_fetch_add(ptr, 0) for loads
-    atomic_xchg(ptr, val) for stores
+These operations operate on any type that is as wide as an int or smaller.
=20
-However, they are quite expensive on some platforms, notably POWER and
-Arm.  Therefore, qemu/atomic.h provides two primitives with slightly
-weaker constraints::
+``qemu/atomic.h`` also provides sequentially consistent loads and stores c=
an::
=20
     typeof(*ptr) atomic_mb_read(ptr)
     void         atomic_mb_set(ptr, val)
=20
-The semantics of these primitives map to Java volatile variables,
-and are strongly related to memory barriers as used in the Linux
-kernel (see below).
-
-As long as you use atomic_mb_read and atomic_mb_set, accesses cannot
-be reordered with each other, and it is also not possible to reorder
-"normal" accesses around them.
-
-However, and this is the important difference between
-atomic_mb_read/atomic_mb_set and sequential consistency, it is important
-for both threads to access the same volatile variable.  It is not the
-case that everything visible to thread A when it writes volatile field f
-becomes visible to thread B after it reads volatile field g. The store
-and load have to "match" (i.e., be performed on the same volatile
-field) to achieve the right semantics.
-
-
-These operations operate on any type that is as wide as an int or smaller.
+which however are deprecated.
=20
=20
 Weak atomic access and manual memory barriers
@@ -208,135 +199,62 @@ They come in six kinds:
   dependency and a full read barrier or better is required.
=20
=20
-This is the set of barriers that is required *between* two ``atomic_read()=
``
-and ``atomic_set()`` operations to achieve sequential consistency:
-
-   +----------------+-----------------------------------------------------=
--+
-   |                |                 2nd operation                       =
  |
-   |                +------------------+-----------------+----------------=
--+
-   | 1st operation  | (after last)     | atomic_read     | atomic_set     =
  |
-   +----------------+------------------+-----------------+----------------=
--+
-   | (before first) | ..               | none            | smp_mb_release(=
) |
-   +----------------+------------------+-----------------+----------------=
--+
-   | atomic_read    | smp_mb_acquire() | smp_rmb() [1]_  | [2]_           =
  |
-   +----------------+------------------+-----------------+----------------=
--+
-   | atomic_set     | none             | smp_mb() [3]_   | smp_wmb()      =
  |
-   +----------------+------------------+-----------------+----------------=
--+
-
-   .. [1] Or smp_read_barrier_depends().
-
-   .. [2] This requires a load-store barrier.  This is achieved by
-          either smp_mb_acquire() or smp_mb_release().
-
-   .. [3] This requires a store-load barrier.  On most machines, the only
-          way to achieve this is a full barrier.
-
-
-You can see that the two possible definitions of ``atomic_mb_read()``
-and ``atomic_mb_set()`` are the following:
-
-  1) | atomic_mb_read(p)   =3D atomic_read(p); smp_mb_acquire()
-     | atomic_mb_set(p, v) =3D smp_mb_release(); atomic_set(p, v); smp_mb(=
)
-
-  2) | atomic_mb_read(p)   =3D smp_mb() atomic_read(p); smp_mb_acquire()
-     | atomic_mb_set(p, v) =3D smp_mb_release(); atomic_set(p, v);
-
-Usually the former is used, because ``smp_mb()`` is expensive and a progra=
m
-normally has more reads than writes.  Therefore it makes more sense to
-make ``atomic_mb_set()`` the more expensive operation.
-
-There are two common cases in which atomic_mb_read and atomic_mb_set
-generate too many memory barriers, and thus it can be useful to manually
-place barriers, or use atomic_load_acquire/atomic_store_release instead:
-
-- when a data structure has one thread that is always a writer
-  and one thread that is always a reader, manual placement of
-  memory barriers makes the write side faster.  Furthermore,
-  correctness is easy to check for in this case using the "pairing"
-  trick that is explained below:
-
-    +---------------------------------------------------------------------=
-+
-    | thread 1                                                            =
 |
-    +-----------------------------------+---------------------------------=
-+
-    | before                            | after                           =
 |
-    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-    | ::                                | ::                              =
 |
-    |                                   |                                 =
 |
-    |   (other writes)                  |                                 =
 |
-    |   atomic_mb_set(&a, x)            |   atomic_store_release(&a, x)   =
 |
-    |   atomic_mb_set(&b, y)            |   atomic_store_release(&b, y)   =
 |
-    +-----------------------------------+---------------------------------=
-+
-
-    +---------------------------------------------------------------------=
-+
-    | thread 2                                                            =
 |
-    +-----------------------------------+---------------------------------=
-+
-    | before                            | after                           =
 |
-    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-    | ::                                | ::                              =
 |
-    |                                   |                                 =
 |
-    |   y =3D atomic_mb_read(&b)          |   y =3D atomic_load_acquire(&b=
)    |
-    |   x =3D atomic_mb_read(&a)          |   x =3D atomic_load_acquire(&a=
)    |
-    |   (other reads)                   |                                 =
 |
-    +-----------------------------------+---------------------------------=
-+
-
-  Note that the barrier between the stores in thread 1, and between
-  the loads in thread 2, has been optimized here to a write or a
-  read memory barrier respectively.  On some architectures, notably
-  ARMv7, smp_mb_acquire and smp_mb_release are just as expensive as
-  smp_mb, but smp_rmb and/or smp_wmb are more efficient.
-
-- sometimes, a thread is accessing many variables that are otherwise
-  unrelated to each other (for example because, apart from the current
-  thread, exactly one other thread will read or write each of these
-  variables).  In this case, it is possible to "hoist" the implicit
-  barriers provided by ``atomic_mb_read()`` and ``atomic_mb_set()`` outsid=
e
-  a loop.  For example, the above definition ``atomic_mb_read()`` gives
-  the following transformation:
-
-    +-----------------------------------+---------------------------------=
-+
-    | before                            | after                           =
 |
-    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-    | ::                                | ::                              =
 |
-    |                                   |                                 =
 |
-    |   n =3D 0;                          |   n =3D 0;                    =
     |
-    |   for (i =3D 0; i < 10; i++)        |   for (i =3D 0; i < 10; i++)  =
     |
-    |     n +=3D atomic_mb_read(&a[i]);   |     n +=3D atomic_read(&a[i]);=
     |
-    |                                   |   smp_mb_acquire();             =
 |
-    +-----------------------------------+---------------------------------=
-+
-
-  Similarly, atomic_mb_set() can be transformed as follows:
-
-    +-----------------------------------+---------------------------------=
-+
-    | before                            | after                           =
 |
-    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-    | ::                                | ::                              =
 |
-    |                                   |                                 =
 |
-    |                                   |   smp_mb_release();             =
 |
-    |   for (i =3D 0; i < 10; i++)        |   for (i =3D 0; i < 10; i++)  =
     |
-    |     atomic_mb_set(&a[i], false);  |     atomic_set(&a[i], false);   =
 |
-    |                                   |   smp_mb();                     =
 |
-    +-----------------------------------+---------------------------------=
-+
-
-
-  The other thread can still use ``atomic_mb_read()``/``atomic_mb_set()``.
+Memory barriers and ``atomic_load_acquire``/``atomic_store_release`` are
+mostly used when a data structure has one thread that is always a writer
+and one thread that is always a reader:
+
+    +----------------------------------+----------------------------------=
+
+    | thread 1                         | thread 2                         =
|
+    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+    | ::                               | ::                               =
|
+    |                                  |                                  =
|
+    |   atomic_store_release(&a, x)    |   y =3D atomic_load_acquire(&b)  =
  |
+    |   atomic_store_release(&b, y)    |   x =3D atomic_load_acquire(&a)  =
  |
+    +----------------------------------+----------------------------------=
+
+
+In this case, correctness is easy to check for in this case using the
+"pairing" trick that is explained below.
+
+Sometimes, a thread is accessing many variables that are otherwise
+unrelated to each other (for example because, apart from the current
+thread, exactly one other thread will read or write each of these
+variables).  In this case, it is possible to "hoist" the barriers
+outside a loop.  For example:
+
+    +------------------------------------------+--------------------------=
--------+
+    | before                                   | after                    =
        |
+    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
+    | ::                                       | ::                       =
        |
+    |                                          |                          =
        |
+    |   n =3D 0;                                 |   n =3D 0;             =
            |
+    |   for (i =3D 0; i < 10; i++)               |   for (i =3D 0; i < 10;=
 i++)       |
+    |     n +=3D atomic_load_acquire(&a[i]);     |     n +=3D atomic_read(=
&a[i]);     |
+    |                                          |   smp_mb_acquire();      =
        |
+    +------------------------------------------+--------------------------=
--------+
+    | ::                                       | ::                       =
        |
+    |                                          |                          =
        |
+    |                                          |   smp_mb_release();      =
        |
+    |   for (i =3D 0; i < 10; i++)               |   for (i =3D 0; i < 10;=
 i++)       |
+    |     atomic_store_release(&a[i], false);  |     atomic_set(&a[i], fal=
se);    |
+    +------------------------------------------+--------------------------=
--------+
=20
 The two tricks can be combined.  In this case, splitting a loop in
-two lets you hoist the barriers out of the loops _and_ eliminate the
-expensive ``smp_mb()``:
-
-    +-----------------------------------+---------------------------------=
-+
-    | before                            | after                           =
 |
-    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-    | ::                                | ::                              =
 |
-    |                                   |                                 =
 |
-    |                                   |     smp_mb_release();           =
 |
-    |   for (i =3D 0; i < 10; i++) {      |     for (i =3D 0; i < 10; i++)=
     |
-    |     atomic_mb_set(&a[i], false);  |       atomic_set(&a[i], false); =
 |
-    |     atomic_mb_set(&b[i], false);  |     smb_wmb();                  =
 |
-    |   }                               |     for (i =3D 0; i < 10; i++)  =
   |
-    |                                   |       atomic_set(&a[i], false); =
 |
-    |                                   |     smp_mb();                   =
 |
-    +-----------------------------------+---------------------------------=
-+
+two lets you hoist the barriers out of the loops, and replace a
+``smp_mb_release()`` with a (possibly cheaper, and clearer as well)
+``smp_wmb()``:
+
+    +------------------------------------------+--------------------------=
--------+
+    | before                                   | after                    =
        |
+    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
+    | ::                                       | ::                       =
        |
+    |                                          |                          =
        |
+    |                                          |     smp_mb_release();    =
        |
+    |   for (i =3D 0; i < 10; i++) {             |     for (i =3D 0; i < 1=
0; i++)     |
+    |     atomic_store_release(&a[i], false);  |       atomic_set(&a[i], f=
alse);  |
+    |     atomic_store_release(&b[i], false);  |     smb_wmb();           =
        |
+    |   }                                      |     for (i =3D 0; i < 10;=
 i++)     |
+    |                                          |       atomic_set(&b[i], f=
alse);  |
+    +------------------------------------------+--------------------------=
--------+
=20
=20
 Memory barrier pairing
@@ -347,11 +265,13 @@ always, be paired with another barrier.  In the case =
of QEMU, however,
 note that the other barrier may actually be in a driver that runs in
 the guest!
=20
-For the purposes of pairing, ``smp_read_barrier_depends()`` and ``smp_rmb(=
)``
-both count as read barriers.  A read barrier shall pair with a write
-barrier or a full barrier; a write barrier shall pair with a read
-barrier or a full barrier.  A full barrier can pair with anything.
-For example:
+For the purposes of pairing, ``smp_read_barrier_depends()``, ``smp_rmb()``
+and ``smp_mb_acquire()`` all count as read barriers; ``smp_wmb()` and
+``smp_mb_release()`` both count as write barriers.
+
+A read barrier shall pair with a write barrier or a full barrier;
+a write barrier shall pair with a read barrier or a full barrier.
+A full barrier can pair with anything.  For example:
=20
       +--------------------+------------------------------+
       | thread 1           | thread 2                     |
@@ -387,9 +307,6 @@ access and for data dependency barriers:
       |                    |  z =3D b[y];                   |
       +--------------------+------------------------------+
=20
-``smp_wmb()`` also pairs with ``atomic_mb_read()`` and ``smp_mb_acquire()`=
`.
-and ``smp_rmb()`` also pairs with ``atomic_mb_set()`` and ``smp_mb_release=
()``.
-
=20
 Comparison with Linux kernel memory barriers
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -424,24 +341,45 @@ and memory barriers, and the equivalents in QEMU:
          ``atomic_cmpxchg``    returns the old value of the variable
          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-  In QEMU, the second kind does not exist.  Currently Linux has
-  atomic_fetch_or only.  QEMU provides and, or, inc, dec, add, sub.
+  In QEMU, the second kind does not exist.
=20
 - different atomic read-modify-write operations in Linux imply
   a different set of memory barriers; in QEMU, all of them enforce
-  sequential consistency, which means they imply full memory barriers
-  before and after the operation.
-
-- Linux does not have an equivalent of ``atomic_mb_set()``.  In particular=
,
-  note that ``smp_store_mb()`` is a little weaker than ``atomic_mb_set()``=
.
-  ``atomic_mb_read()`` compiles to the same instructions as Linux's
-  ``smp_load_acquire()``, but this should be treated as an implementation
-  detail.
+  sequential consistency.
+
+- in QEMU, ``atomic_read()`` and ``atomic_set()`` do not participate in
+  the total ordering enforced by sequentially-consistent operations.
+  This is because QEMU uses the C11 memory model.  The following example
+  is correct in Linux but not in QEMU:
+
+      +----------------------------------+--------------------------------=
+
+      | Linux (correct)                  | QEMU (incorrect)               =
|
+      +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+      | ::                               | ::                             =
|
+      |                                  |                                =
|
+      |   a =3D atomic_fetch_add(&x, 2);   |   a =3D atomic_fetch_add(&x, =
2); |
+      |   b =3D READ_ONCE(&y);             |   b =3D atomic_read(&y);     =
    |
+      +----------------------------------+--------------------------------=
+
+
+  because the read of ``y`` can be moved (by either the processor or the
+  compiler) before the write of ``x``.
+
+  Fixing this requires an ``smp_mb()`` memory barrier between the write
+  of ``x`` and the read of ``y``.  In the common case where only one threa=
d
+  writes ``x``, it is also possible to write it like this:
+
+      +--------------------------------+
+      | QEMU (correct)                 |
+      +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+      | ::                             |
+      |                                |
+      |   a =3D atomic_read(&x);         |
+      |   atomic_set(&x, a + 2);       |
+      |   smp_mb();                    |
+      |   b =3D atomic_read(&y);         |
+      +--------------------------------+
=20
 Sources
 =3D=3D=3D=3D=3D=3D=3D
=20
 * Documentation/memory-barriers.txt from the Linux kernel
-
-* "The JSR-133 Cookbook for Compiler Writers", available at
-  http://g.oswego.edu/dl/jmm/cookbook.html
--=20
2.18.2



