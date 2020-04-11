Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E831BC2BBC7
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A435020753
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqXJiN+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A435020753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNFqf-00041r-SB
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 09:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnR-00078P-LC
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnO-0002Zh-Na
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25364
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jNFnO-0002Z9-HG
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586610218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/aM85MbwlpMTbyemQEX5oaGjC5vytczfEPdS/5EmsM0=;
 b=hqXJiN+Qi1W75DZDcaaNhLPqhOk8a32r0dlNsStZEc2SqYNUKfWbEjyfL+JMuOnEmKEYJk
 jgcbF66C0V+Gy/uOpk7twweFrmXavTsRyHCZViNpIrIRWs1maofj2UFZbf3Wv5e5D8pMzA
 JNdjyo0niGhwA2bQSagf0KE+mhXhEdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-ltfvmbn8Phq_TLO_u9uiGQ-1; Sat, 11 Apr 2020 09:03:36 -0400
X-MC-Unique: ltfvmbn8Phq_TLO_u9uiGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46D0C18AB2FB
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 13:03:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F32AC98A2B
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 13:03:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] atomics: update documentation
Date: Sat, 11 Apr 2020 09:03:26 -0400
Message-Id: <20200411130330.1993-5-pbonzini@redhat.com>
In-Reply-To: <20200411130330.1993-1-pbonzini@redhat.com>
References: <20200411130330.1993-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the constraints on operand sizes have been relaxed, so adjust the
documentation.

Deprecate atomic_mb_read and atomic_mb_set; it is not really possible to
use them correctly because they do not interoperate with sequentially-consi=
stent
RMW operations.

Finally, extend the memory barrier pairing section to cover acquire and
release semantics in general, roughly based on the KVM Forum 2016 talk,
"<atomic.h> weapons".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/atomics.rst | 481 +++++++++++++++++++++++------------------
 roms/SLOF              |   2 +-
 2 files changed, 272 insertions(+), 211 deletions(-)

diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
index 83ed3d6981..445c3b3503 100644
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
@@ -24,13 +29,21 @@ Macros defined by ``qemu/atomic.h`` fall in three camps=
:
=20
 - sequentially consistent atomic access: everything else.
=20
+In general, use of ``qemu/atomic.h`` should be wrapped with more easily
+used data structures (e.g. the lock-free singly-linked list operations
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
=20
-``barrier()`` prevents the compiler from moving the memory accesses either
-side of it to the other side.  The compiler barrier has no direct effect
-on the CPU, which may then reorder things however it wishes.
+``barrier()`` prevents the compiler from moving the memory accesses on
+either side of it to the other side.  The compiler barrier has no direct
+effect on the CPU, which may then reorder things however it wishes.
=20
 ``barrier()`` is mostly used within ``qemu/atomic.h`` itself.  On some
 architectures, CPU guarantees are strong enough that blocking compiler
@@ -73,7 +86,8 @@ operations::
     typeof(*ptr) atomic_cmpxchg(ptr, old, new)
=20
 all of which return the old value of ``*ptr``.  These operations are
-polymorphic; they operate on any type that is as wide as a pointer.
+polymorphic; they operate on any type that is as wide as a pointer or
+smaller.
=20
 Similar operations return the new value of ``*ptr``::
=20
@@ -85,36 +99,28 @@ Similar operations return the new value of ``*ptr``::
     typeof(*ptr) atomic_or_fetch(ptr, val)
     typeof(*ptr) atomic_xor_fetch(ptr, val)
=20
-Sequentially consistent loads and stores can be done using::
-
-    atomic_fetch_add(ptr, 0) for loads
-    atomic_xchg(ptr, val) for stores
-
-However, they are quite expensive on some platforms, notably POWER and
-Arm.  Therefore, qemu/atomic.h provides two primitives with slightly
-weaker constraints::
+``qemu/atomic.h`` also provides loads and stores that cannot be reordered
+with each other::
=20
     typeof(*ptr) atomic_mb_read(ptr)
     void         atomic_mb_set(ptr, val)
=20
-The semantics of these primitives map to Java volatile variables,
-and are strongly related to memory barriers as used in the Linux
-kernel (see below).
+However these do not provide sequential consistency and, in particular,
+they do not participate in the total ordering enforced by
+sequentially-consistent operations.  For this reason they are deprecated.
+They should instead be replaced with any of the following (ordered from
+easiest to hardest):
=20
-As long as you use atomic_mb_read and atomic_mb_set, accesses cannot
-be reordered with each other, and it is also not possible to reorder
-"normal" accesses around them.
+- accesses inside a mutex or spinlock
=20
-However, and this is the important difference between
-atomic_mb_read/atomic_mb_set and sequential consistency, it is important
-for both threads to access the same volatile variable.  It is not the
-case that everything visible to thread A when it writes volatile field f
-becomes visible to thread B after it reads volatile field g. The store
-and load have to "match" (i.e., be performed on the same volatile
-field) to achieve the right semantics.
+- lightweight synchronization primitives such as ``QemuEvent``
=20
+- RCU operations (``atomic_rcu_read``, ``atomic_rcu_set``) when publishing
+  or accessing a new version of a data structure
=20
-These operations operate on any type that is as wide as an int or smaller.
+- other atomic accesses: ``atomic_read`` and ``atomic_load_acquire`` for
+  loads, ``atomic_set`` and ``atomic_store_release`` for stores, ``smp_mb`=
`
+  to forbid reordering subsequent loads before a store.
=20
=20
 Weak atomic access and manual memory barriers
@@ -122,9 +128,24 @@ Weak atomic access and manual memory barriers
=20
 Compared to sequentially consistent atomic access, programming with
 weaker consistency models can be considerably more complicated.
-In general, if the algorithm you are writing includes both writes
-and reads on the same side, it is generally simpler to use sequentially
-consistent primitives.
+The only guarantees that you can rely upon in this case are:
+
+- atomic accesses will not cause data races (and hence undefined behavior)=
;
+  ordinary accesses instead cause data races if they are concurrent with
+  other accesses of which at least one is a write.  In order to ensure thi=
s,
+  the compiler will not optimize accesses out of existence, create unsolic=
ited
+  accesses, or perform other similar optimzations.
+
+- acquire operations will appear to happen, with respect to the other
+  components of the system, before all the LOAD or STORE operations
+  specified afterwards.
+
+- release operations will appear to happen, with respect to the other
+  components of the system, after all the LOAD or STORE operations
+  specified before.
+
+- release operations will *synchronize with* acquire operations;
+  see :ref:`acqrel` for a detailed explanation.
=20
 When using this model, variables are accessed with:
=20
@@ -142,9 +163,9 @@ When using this model, variables are accessed with:
=20
 - ``atomic_store_release()``, which guarantees the STORE to appear to
   happen, with respect to the other components of the system,
-  after all the LOAD or STORE operations specified afterwards.
+  after all the LOAD or STORE operations specified before.
   Operations coming after ``atomic_store_release()`` can still be
-  reordered after it.
+  reordered before it.
=20
 Restrictions to the ordering of accesses can also be specified
 using the memory barrier macros: ``smp_rmb()``, ``smp_wmb()``, ``smp_mb()`=
`,
@@ -208,168 +229,188 @@ They come in six kinds:
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
-
-The two tricks can be combined.  In this case, splitting a loop in
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
-
-
-Memory barrier pairing
-----------------------
-
-A useful rule of thumb is that memory barriers should always, or almost
-always, be paired with another barrier.  In the case of QEMU, however,
-note that the other barrier may actually be in a driver that runs in
-the guest!
-
-For the purposes of pairing, ``smp_read_barrier_depends()`` and ``smp_rmb(=
)``
-both count as read barriers.  A read barrier shall pair with a write
-barrier or a full barrier; a write barrier shall pair with a read
-barrier or a full barrier.  A full barrier can pair with anything.
-For example:
-
-      +--------------------+------------------------------+
-      | thread 1           | thread 2                     |
-      +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
-      | ::                 | ::                           |
-      |                    |                              |
-      |   a =3D 1;           |                              |
-      |   smp_wmb();       |                              |
-      |   b =3D 2;           |   x =3D b;                     |
-      |                    |   smp_rmb();                 |
-      |                    |   y =3D a;                     |
-      +--------------------+------------------------------+
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
+    |   atomic_store_release(&a, x);   |   y =3D atomic_load_acquire(&b); =
  |
+    |   atomic_store_release(&b, y);   |   x =3D atomic_load_acquire(&a); =
  |
+    +----------------------------------+----------------------------------=
+
+
+In this case, correctness is easy to check for using the "pairing"
+trick that is explained below.
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
+
+Splitting a loop can also be useful to reduce the number of barriers:
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
+    |   n =3D 0;                                 |     smp_mb_release();  =
          |
+    |   for (i =3D 0; i < 10; i++) {             |     for (i =3D 0; i < 1=
0; i++)     |
+    |     atomic_store_release(&a[i], false);  |       atomic_set(&a[i], f=
alse);  |
+    |     smp_mb();                            |     smb_mb();            =
        |
+    |     n +=3D atomic_read(&b[i]);             |     n =3D 0;           =
            |
+    |   }                                      |     for (i =3D 0; i < 10;=
 i++)     |
+    |                                          |       n +=3D atomic_read(=
&b[i]);   |
+    +------------------------------------------+--------------------------=
--------+
+
+In this case, a ``smp_mb_release()`` is also replaced with a (possibly che=
aper, and clearer
+as well) ``smp_wmb()``:
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
+
+
+.. _acqrel:
+
+Acquire/release pairing and the *synchronizes-with* relation
+------------------------------------------------------------
+
+Atomic operations other than ``atomic_set()`` and ``atomic_read()`` have
+either *acquire* or *release* semantics [#rmw]_.  This has two effects:
+
+.. [#rmw] Read-modify-write operations can have both---acquire applies to =
the
+          read part, and release to the write.
+
+- within a thread, they are ordered either before subsequent operations
+  (for acquire) or after previous operations (for release).
+
+- if a release operation in one thread *synchronizes with* an acquire oper=
ation
+  in another thread, the ordering constraints propagates from the first to=
 the
+  second thread.  That is, everything before the release operation in the
+  first thread is guaranteed to *happen before* everything after the
+  acquire operation in the second thread.
+
+The concept of acquire and release semantics is not exclusive to atomic
+operations; almost all higher-level synchronization primitives also have
+acquire or release semantics.  For example:
+
+- ``pthread_mutex_lock`` has acquire semantics, ``pthread_mutex_unlock`` h=
as
+  release semantics and synchronizes with a ``pthread_mutex_lock`` for the
+  same mutex.
+
+- ``pthread_cond_signal`` and ``pthread_cond_broadcast`` have release sema=
ntics;
+  ``pthread_cond_wait`` has both release semantics (synchronizing with
+  ``pthread_mutex_lock``) and acquire semantics (synchronizing with
+  ``pthread_mutex_unlock`` and signaling of the condition variable).
+
+- ``pthread_create`` has release semantics and synchronizes with the start
+  of the new thread; ``pthread_join`` has acquire semantics and synchroniz=
es
+  with the exiting of the thread.
+
+- ``qemu_event_set`` has release semantics, ``qemu_event_wait`` has
+  acquire semantics.
+
+For example, in the following example there are no atomic accesses, but st=
ill
+thread 2 is relying on the *synchronizes-with* relation between ``pthread_=
exit``
+(release) and ``pthread_join`` (acquire):
+
+      +----------------------+-------------------------------+
+      | thread 1             | thread 2                      |
+      +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+
+      | ::                   | ::                            |
+      |                      |                               |
+      |   *a =3D 1;            |                               |
+      |   pthread_exit(a);   |   pthread_join(thread1, &a);  |
+      |                      |   x =3D *a;                     |
+      +----------------------+-------------------------------+
+
+Synchronization between threads basically descends from this pairing of
+a release operation and an acquire operation.  Therefore, atomic operation=
s
+other than ``atomic_set()`` and ``atomic_read()`` will almost always be
+paired with another operation of the opposite kind: an acquire operation
+will pair with a release operation and vice versa.  This rule of thumb is
+extremely useful; in the case of QEMU, however, note that the other
+operation may actually be in a driver that runs in the guest!
+
+``smp_read_barrier_depends()``, ``smp_rmb()``, ``smp_mb_acquire()``,
+``atomic_load_acquire()`` and ``atomic_rcu_read()`` all count
+as acquire operations.  ``smp_wmb()``, ``smp_mb_release()``,
+``atomic_store_release()`` and ``atomic_rcu_set()`` all count as release
+operations.  ``smp_mb()`` counts as both acquire and release, therefore
+it can pair with any other atomic operation.  Here is an example:
+
+      +----------------------+------------------------------+
+      | thread 1             | thread 2                     |
+      +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
+      | ::                   | ::                           |
+      |                      |                              |
+      |   atomic_set(&a, 1); |                              |
+      |   smp_wmb();         |                              |
+      |   atomic_set(&b, 2); |   x =3D atomic_read(&b);       |
+      |                      |   smp_rmb();                 |
+      |                      |   y =3D atomic_read(&a);       |
+      +----------------------+------------------------------+
+
+Note that a load-store pair only counts if the two operations access the
+same variable: that is, a store-release on a variable ``x`` *synchronizes
+with* a load-acquire on a variable ``x``, while a release barrier
+synchronizes with any acquire operation.  The following example shows
+correct synchronization:
+
+      +--------------------------------+--------------------------------+
+      | thread 1                       | thread 2                       |
+      +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+      | ::                             | ::                             |
+      |                                |                                |
+      |   atomic_set(&a, 1);           |                                |
+      |   atomic_store_release(&b, 2); |   x =3D atomic_load_acquire(&b); =
|
+      |                                |   y =3D atomic_read(&a);         =
|
+      +--------------------------------+--------------------------------+
+
+Acquire and release semantics of higher-level primitives can also be
+relied upon for the purpose of establishing the *synchronizes with*
+relation.
=20
 Note that the "writing" thread is accessing the variables in the
 opposite order as the "reading" thread.  This is expected: stores
-before the write barrier will normally match the loads after the
-read barrier, and vice versa.  The same is true for more than 2
-access and for data dependency barriers:
+before a release operation will normally match the loads after
+the acquire operation, and vice versa.  In fact, this happened already
+in the ``pthread_exit``/``pthread_join`` example above.
+
+Finally, this more complex example has more than two accesses and data
+dependency barriers.  It also does not use atomic accesses whenever there
+cannot be a data race:
=20
       +----------------------+------------------------------+
       | thread 1             | thread 2                     |
@@ -380,19 +421,15 @@ access and for data dependency barriers:
       |   smp_wmb();         |                              |
       |   x->i =3D 2;          |                              |
       |   smp_wmb();         |                              |
-      |   a =3D x;             |  x =3D a;                      |
+      |   atomic_set(&a, x); |  x =3D atomic_read(&a);        |
       |                      |  smp_read_barrier_depends(); |
       |                      |  y =3D x->i;                   |
       |                      |  smp_read_barrier_depends(); |
       |                      |  z =3D b[y];                   |
       +----------------------+------------------------------+
=20
-``smp_wmb()`` also pairs with ``atomic_mb_read()`` and ``smp_mb_acquire()`=
`.
-and ``smp_rmb()`` also pairs with ``atomic_mb_set()`` and ``smp_mb_release=
()``.
-
-
-Comparison with Linux kernel memory barriers
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Comparison with Linux kernel primitives
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Here is a list of differences between Linux kernel atomic operations
 and memory barriers, and the equivalents in QEMU:
@@ -426,19 +463,43 @@ and memory barriers, and the equivalents in QEMU:
          ``atomic_cmpxchg``    returns the old value of the variable
          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-  In QEMU, the second kind does not exist.  Currently Linux has
-  atomic_fetch_or only.  QEMU provides and, or, inc, dec, add, sub.
+  In QEMU, the second kind is named ``atomic_OP_fetch``.
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
diff --git a/roms/SLOF b/roms/SLOF
index ab6984f5a6..9546892a80 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit ab6984f5a6d054e1f634dda855b32e5357111974
+Subproject commit 9546892a80d5a4c73deea6719de46372f007f4a6
--=20
2.18.2



