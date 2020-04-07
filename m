Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4773DC2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F2120719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtBoW1oB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F2120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLoua-0002t6-Nw
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLotZ-0000lt-50
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLotU-00016p-Q8
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:08:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLotU-00016a-JE
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586268480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DQ3hIkcyi14yXey+VNW+FKPZly8Pt2h1rVqJaCYpxY=;
 b=MtBoW1oBbyMuoqDsr9jYdEom63Uv2PXWGOq2mxa7v0albBtQl8R71QcybWT9+NJ3jP4dZ2
 M9lS4bXXYHe3QUgvZ6mXY95BuHZpmMtXHV7npkDM9GQs/JCyJuxtaq/B+UtCJ4075F/Y3z
 ELFADKUZfdcXWvxCE+BDiSlDtdi54cc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-TV9Ti-V1PpKYRcHOXDS4kg-1; Tue, 07 Apr 2020 10:07:52 -0400
X-MC-Unique: TV9Ti-V1PpKYRcHOXDS4kg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CE9D107ACC4;
 Tue,  7 Apr 2020 14:07:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E6DA5C553;
 Tue,  7 Apr 2020 14:07:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] atomics: convert to reStructuredText
Date: Tue,  7 Apr 2020 10:07:42 -0400
Message-Id: <20200407140746.8041-2-pbonzini@redhat.com>
In-Reply-To: <20200407140746.8041-1-pbonzini@redhat.com>
References: <20200407140746.8041-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: fangying1@huawei.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No attempts to fix or update the text; these are left for the next
patch in the series.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/atomics.rst | 446 +++++++++++++++++++++++++++++++++++++++++
 docs/devel/atomics.txt | 403 -------------------------------------
 docs/devel/index.rst   |   1 +
 3 files changed, 447 insertions(+), 403 deletions(-)
 create mode 100644 docs/devel/atomics.rst
 delete mode 100644 docs/devel/atomics.txt

diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
new file mode 100644
index 0000000000..83ed3d6981
--- /dev/null
+++ b/docs/devel/atomics.rst
@@ -0,0 +1,446 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+Atomic operations in QEMU
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+CPUs perform independent memory operations effectively in random order.
+but this can be a problem for CPU-CPU interaction (including interactions
+between QEMU and the guest).  Multi-threaded programs use various tools
+to instruct the compiler and the CPU to restrict the order to something
+that is consistent with the expectations of the programmer.
+
+The most basic tool is locking.  Mutexes, condition variables and
+semaphores are used in QEMU, and should be the default approach to
+synchronization.  Anything else is considerably harder, but it's
+also justified more often than one would like.  The two tools that
+are provided by ``qemu/atomic.h`` are memory barriers and atomic operation=
s.
+
+Macros defined by ``qemu/atomic.h`` fall in three camps:
+
+- compiler barriers: ``barrier()``;
+
+- weak atomic access and manual memory barriers: ``atomic_read()``,
+  ``atomic_set()``, ``smp_rmb()``, ``smp_wmb()``, ``smp_mb()``, ``smp_mb_a=
cquire()``,
+  ``smp_mb_release()``, ``smp_read_barrier_depends()``;
+
+- sequentially consistent atomic access: everything else.
+
+
+Compiler memory barrier
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+``barrier()`` prevents the compiler from moving the memory accesses either
+side of it to the other side.  The compiler barrier has no direct effect
+on the CPU, which may then reorder things however it wishes.
+
+``barrier()`` is mostly used within ``qemu/atomic.h`` itself.  On some
+architectures, CPU guarantees are strong enough that blocking compiler
+optimizations already ensures the correct order of execution.  In this
+case, ``qemu/atomic.h`` will reduce stronger memory barriers to simple
+compiler barriers.
+
+Still, ``barrier()`` can be useful when writing code that can be interrupt=
ed
+by signal handlers.
+
+
+Sequentially consistent atomic access
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Most of the operations in the ``qemu/atomic.h`` header ensure *sequential
+consistency*, where "the result of any execution is the same as if the
+operations of all the processors were executed in some sequential order,
+and the operations of each individual processor appear in this sequence
+in the order specified by its program".
+
+``qemu/atomic.h`` provides the following set of atomic read-modify-write
+operations::
+
+    void atomic_inc(ptr)
+    void atomic_dec(ptr)
+    void atomic_add(ptr, val)
+    void atomic_sub(ptr, val)
+    void atomic_and(ptr, val)
+    void atomic_or(ptr, val)
+
+    typeof(*ptr) atomic_fetch_inc(ptr)
+    typeof(*ptr) atomic_fetch_dec(ptr)
+    typeof(*ptr) atomic_fetch_add(ptr, val)
+    typeof(*ptr) atomic_fetch_sub(ptr, val)
+    typeof(*ptr) atomic_fetch_and(ptr, val)
+    typeof(*ptr) atomic_fetch_or(ptr, val)
+    typeof(*ptr) atomic_fetch_xor(ptr, val)
+    typeof(*ptr) atomic_fetch_inc_nonzero(ptr)
+    typeof(*ptr) atomic_xchg(ptr, val)
+    typeof(*ptr) atomic_cmpxchg(ptr, old, new)
+
+all of which return the old value of ``*ptr``.  These operations are
+polymorphic; they operate on any type that is as wide as a pointer.
+
+Similar operations return the new value of ``*ptr``::
+
+    typeof(*ptr) atomic_inc_fetch(ptr)
+    typeof(*ptr) atomic_dec_fetch(ptr)
+    typeof(*ptr) atomic_add_fetch(ptr, val)
+    typeof(*ptr) atomic_sub_fetch(ptr, val)
+    typeof(*ptr) atomic_and_fetch(ptr, val)
+    typeof(*ptr) atomic_or_fetch(ptr, val)
+    typeof(*ptr) atomic_xor_fetch(ptr, val)
+
+Sequentially consistent loads and stores can be done using::
+
+    atomic_fetch_add(ptr, 0) for loads
+    atomic_xchg(ptr, val) for stores
+
+However, they are quite expensive on some platforms, notably POWER and
+Arm.  Therefore, qemu/atomic.h provides two primitives with slightly
+weaker constraints::
+
+    typeof(*ptr) atomic_mb_read(ptr)
+    void         atomic_mb_set(ptr, val)
+
+The semantics of these primitives map to Java volatile variables,
+and are strongly related to memory barriers as used in the Linux
+kernel (see below).
+
+As long as you use atomic_mb_read and atomic_mb_set, accesses cannot
+be reordered with each other, and it is also not possible to reorder
+"normal" accesses around them.
+
+However, and this is the important difference between
+atomic_mb_read/atomic_mb_set and sequential consistency, it is important
+for both threads to access the same volatile variable.  It is not the
+case that everything visible to thread A when it writes volatile field f
+becomes visible to thread B after it reads volatile field g. The store
+and load have to "match" (i.e., be performed on the same volatile
+field) to achieve the right semantics.
+
+
+These operations operate on any type that is as wide as an int or smaller.
+
+
+Weak atomic access and manual memory barriers
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Compared to sequentially consistent atomic access, programming with
+weaker consistency models can be considerably more complicated.
+In general, if the algorithm you are writing includes both writes
+and reads on the same side, it is generally simpler to use sequentially
+consistent primitives.
+
+When using this model, variables are accessed with:
+
+- ``atomic_read()`` and ``atomic_set()``; these prevent the compiler from
+  optimizing accesses out of existence and creating unsolicited
+  accesses, but do not otherwise impose any ordering on loads and
+  stores: both the compiler and the processor are free to reorder
+  them.
+
+- ``atomic_load_acquire()``, which guarantees the LOAD to appear to
+  happen, with respect to the other components of the system,
+  before all the LOAD or STORE operations specified afterwards.
+  Operations coming before ``atomic_load_acquire()`` can still be
+  reordered after it.
+
+- ``atomic_store_release()``, which guarantees the STORE to appear to
+  happen, with respect to the other components of the system,
+  after all the LOAD or STORE operations specified afterwards.
+  Operations coming after ``atomic_store_release()`` can still be
+  reordered after it.
+
+Restrictions to the ordering of accesses can also be specified
+using the memory barrier macros: ``smp_rmb()``, ``smp_wmb()``, ``smp_mb()`=
`,
+``smp_mb_acquire()``, ``smp_mb_release()``, ``smp_read_barrier_depends()``=
.
+
+Memory barriers control the order of references to shared memory.
+They come in six kinds:
+
+- ``smp_rmb()`` guarantees that all the LOAD operations specified before
+  the barrier will appear to happen before all the LOAD operations
+  specified after the barrier with respect to the other components of
+  the system.
+
+  In other words, ``smp_rmb()`` puts a partial ordering on loads, but is n=
ot
+  required to have any effect on stores.
+
+- ``smp_wmb()`` guarantees that all the STORE operations specified before
+  the barrier will appear to happen before all the STORE operations
+  specified after the barrier with respect to the other components of
+  the system.
+
+  In other words, ``smp_wmb()`` puts a partial ordering on stores, but is =
not
+  required to have any effect on loads.
+
+- ``smp_mb_acquire()`` guarantees that all the LOAD operations specified b=
efore
+  the barrier will appear to happen before all the LOAD or STORE operation=
s
+  specified after the barrier with respect to the other components of
+  the system.
+
+- ``smp_mb_release()`` guarantees that all the STORE operations specified =
*after*
+  the barrier will appear to happen after all the LOAD or STORE operations
+  specified *before* the barrier with respect to the other components of
+  the system.
+
+- ``smp_mb()`` guarantees that all the LOAD and STORE operations specified
+  before the barrier will appear to happen before all the LOAD and
+  STORE operations specified after the barrier with respect to the other
+  components of the system.
+
+  ``smp_mb()`` puts a partial ordering on both loads and stores.  It is
+  stronger than both a read and a write memory barrier; it implies both
+  ``smp_mb_acquire()`` and ``smp_mb_release()``, but it also prevents STOR=
Es
+  coming before the barrier from overtaking LOADs coming after the
+  barrier and vice versa.
+
+- ``smp_read_barrier_depends()`` is a weaker kind of read barrier.  On
+  most processors, whenever two loads are performed such that the
+  second depends on the result of the first (e.g., the first load
+  retrieves the address to which the second load will be directed),
+  the processor will guarantee that the first LOAD will appear to happen
+  before the second with respect to the other components of the system.
+  However, this is not always true---for example, it was not true on
+  Alpha processors.  Whenever this kind of access happens to shared
+  memory (that is not protected by a lock), a read barrier is needed,
+  and ``smp_read_barrier_depends()`` can be used instead of ``smp_rmb()``.
+
+  Note that the first load really has to have a _data_ dependency and not
+  a control dependency.  If the address for the second load is dependent
+  on the first load, but the dependency is through a conditional rather
+  than actually loading the address itself, then it's a _control_
+  dependency and a full read barrier or better is required.
+
+
+This is the set of barriers that is required *between* two ``atomic_read()=
``
+and ``atomic_set()`` operations to achieve sequential consistency:
+
+   +----------------+-----------------------------------------------------=
--+
+   |                |                 2nd operation                       =
  |
+   |                +------------------+-----------------+----------------=
--+
+   | 1st operation  | (after last)     | atomic_read     | atomic_set     =
  |
+   +----------------+------------------+-----------------+----------------=
--+
+   | (before first) | ..               | none            | smp_mb_release(=
) |
+   +----------------+------------------+-----------------+----------------=
--+
+   | atomic_read    | smp_mb_acquire() | smp_rmb() [1]_  | [2]_           =
  |
+   +----------------+------------------+-----------------+----------------=
--+
+   | atomic_set     | none             | smp_mb() [3]_   | smp_wmb()      =
  |
+   +----------------+------------------+-----------------+----------------=
--+
+
+   .. [1] Or smp_read_barrier_depends().
+
+   .. [2] This requires a load-store barrier.  This is achieved by
+          either smp_mb_acquire() or smp_mb_release().
+
+   .. [3] This requires a store-load barrier.  On most machines, the only
+          way to achieve this is a full barrier.
+
+
+You can see that the two possible definitions of ``atomic_mb_read()``
+and ``atomic_mb_set()`` are the following:
+
+  1) | atomic_mb_read(p)   =3D atomic_read(p); smp_mb_acquire()
+     | atomic_mb_set(p, v) =3D smp_mb_release(); atomic_set(p, v); smp_mb(=
)
+
+  2) | atomic_mb_read(p)   =3D smp_mb() atomic_read(p); smp_mb_acquire()
+     | atomic_mb_set(p, v) =3D smp_mb_release(); atomic_set(p, v);
+
+Usually the former is used, because ``smp_mb()`` is expensive and a progra=
m
+normally has more reads than writes.  Therefore it makes more sense to
+make ``atomic_mb_set()`` the more expensive operation.
+
+There are two common cases in which atomic_mb_read and atomic_mb_set
+generate too many memory barriers, and thus it can be useful to manually
+place barriers, or use atomic_load_acquire/atomic_store_release instead:
+
+- when a data structure has one thread that is always a writer
+  and one thread that is always a reader, manual placement of
+  memory barriers makes the write side faster.  Furthermore,
+  correctness is easy to check for in this case using the "pairing"
+  trick that is explained below:
+
+    +---------------------------------------------------------------------=
-+
+    | thread 1                                                            =
 |
+    +-----------------------------------+---------------------------------=
-+
+    | before                            | after                           =
 |
+    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+    | ::                                | ::                              =
 |
+    |                                   |                                 =
 |
+    |   (other writes)                  |                                 =
 |
+    |   atomic_mb_set(&a, x)            |   atomic_store_release(&a, x)   =
 |
+    |   atomic_mb_set(&b, y)            |   atomic_store_release(&b, y)   =
 |
+    +-----------------------------------+---------------------------------=
-+
+
+    +---------------------------------------------------------------------=
-+
+    | thread 2                                                            =
 |
+    +-----------------------------------+---------------------------------=
-+
+    | before                            | after                           =
 |
+    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+    | ::                                | ::                              =
 |
+    |                                   |                                 =
 |
+    |   y =3D atomic_mb_read(&b)          |   y =3D atomic_load_acquire(&b=
)    |
+    |   x =3D atomic_mb_read(&a)          |   x =3D atomic_load_acquire(&a=
)    |
+    |   (other reads)                   |                                 =
 |
+    +-----------------------------------+---------------------------------=
-+
+
+  Note that the barrier between the stores in thread 1, and between
+  the loads in thread 2, has been optimized here to a write or a
+  read memory barrier respectively.  On some architectures, notably
+  ARMv7, smp_mb_acquire and smp_mb_release are just as expensive as
+  smp_mb, but smp_rmb and/or smp_wmb are more efficient.
+
+- sometimes, a thread is accessing many variables that are otherwise
+  unrelated to each other (for example because, apart from the current
+  thread, exactly one other thread will read or write each of these
+  variables).  In this case, it is possible to "hoist" the implicit
+  barriers provided by ``atomic_mb_read()`` and ``atomic_mb_set()`` outsid=
e
+  a loop.  For example, the above definition ``atomic_mb_read()`` gives
+  the following transformation:
+
+    +-----------------------------------+---------------------------------=
-+
+    | before                            | after                           =
 |
+    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+    | ::                                | ::                              =
 |
+    |                                   |                                 =
 |
+    |   n =3D 0;                          |   n =3D 0;                    =
     |
+    |   for (i =3D 0; i < 10; i++)        |   for (i =3D 0; i < 10; i++)  =
     |
+    |     n +=3D atomic_mb_read(&a[i]);   |     n +=3D atomic_read(&a[i]);=
     |
+    |                                   |   smp_mb_acquire();             =
 |
+    +-----------------------------------+---------------------------------=
-+
+
+  Similarly, atomic_mb_set() can be transformed as follows:
+
+    +-----------------------------------+---------------------------------=
-+
+    | before                            | after                           =
 |
+    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+    | ::                                | ::                              =
 |
+    |                                   |                                 =
 |
+    |                                   |   smp_mb_release();             =
 |
+    |   for (i =3D 0; i < 10; i++)        |   for (i =3D 0; i < 10; i++)  =
     |
+    |     atomic_mb_set(&a[i], false);  |     atomic_set(&a[i], false);   =
 |
+    |                                   |   smp_mb();                     =
 |
+    +-----------------------------------+---------------------------------=
-+
+
+
+  The other thread can still use ``atomic_mb_read()``/``atomic_mb_set()``.
+
+The two tricks can be combined.  In this case, splitting a loop in
+two lets you hoist the barriers out of the loops _and_ eliminate the
+expensive ``smp_mb()``:
+
+    +-----------------------------------+---------------------------------=
-+
+    | before                            | after                           =
 |
+    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+    | ::                                | ::                              =
 |
+    |                                   |                                 =
 |
+    |                                   |     smp_mb_release();           =
 |
+    |   for (i =3D 0; i < 10; i++) {      |     for (i =3D 0; i < 10; i++)=
     |
+    |     atomic_mb_set(&a[i], false);  |       atomic_set(&a[i], false); =
 |
+    |     atomic_mb_set(&b[i], false);  |     smb_wmb();                  =
 |
+    |   }                               |     for (i =3D 0; i < 10; i++)  =
   |
+    |                                   |       atomic_set(&a[i], false); =
 |
+    |                                   |     smp_mb();                   =
 |
+    +-----------------------------------+---------------------------------=
-+
+
+
+Memory barrier pairing
+----------------------
+
+A useful rule of thumb is that memory barriers should always, or almost
+always, be paired with another barrier.  In the case of QEMU, however,
+note that the other barrier may actually be in a driver that runs in
+the guest!
+
+For the purposes of pairing, ``smp_read_barrier_depends()`` and ``smp_rmb(=
)``
+both count as read barriers.  A read barrier shall pair with a write
+barrier or a full barrier; a write barrier shall pair with a read
+barrier or a full barrier.  A full barrier can pair with anything.
+For example:
+
+      +--------------------+------------------------------+
+      | thread 1           | thread 2                     |
+      +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
+      | ::                 | ::                           |
+      |                    |                              |
+      |   a =3D 1;           |                              |
+      |   smp_wmb();       |                              |
+      |   b =3D 2;           |   x =3D b;                     |
+      |                    |   smp_rmb();                 |
+      |                    |   y =3D a;                     |
+      +--------------------+------------------------------+
+
+Note that the "writing" thread is accessing the variables in the
+opposite order as the "reading" thread.  This is expected: stores
+before the write barrier will normally match the loads after the
+read barrier, and vice versa.  The same is true for more than 2
+access and for data dependency barriers:
+
+      +----------------------+------------------------------+
+      | thread 1             | thread 2                     |
+      +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
+      | ::                   | ::                           |
+      |                      |                              |
+      |   b[2] =3D 1;          |                              |
+      |   smp_wmb();         |                              |
+      |   x->i =3D 2;          |                              |
+      |   smp_wmb();         |                              |
+      |   a =3D x;             |  x =3D a;                      |
+      |                      |  smp_read_barrier_depends(); |
+      |                      |  y =3D x->i;                   |
+      |                      |  smp_read_barrier_depends(); |
+      |                      |  z =3D b[y];                   |
+      +----------------------+------------------------------+
+
+``smp_wmb()`` also pairs with ``atomic_mb_read()`` and ``smp_mb_acquire()`=
`.
+and ``smp_rmb()`` also pairs with ``atomic_mb_set()`` and ``smp_mb_release=
()``.
+
+
+Comparison with Linux kernel memory barriers
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Here is a list of differences between Linux kernel atomic operations
+and memory barriers, and the equivalents in QEMU:
+
+- atomic operations in Linux are always on a 32-bit int type and
+  use a boxed ``atomic_t`` type; atomic operations in QEMU are polymorphic
+  and use normal C types.
+
+- Originally, ``atomic_read`` and ``atomic_set`` in Linux gave no guarante=
e
+  at all. Linux 4.1 updated them to implement volatile
+  semantics via ``ACCESS_ONCE`` (or the more recent ``READ``/``WRITE_ONCE`=
`).
+
+  QEMU's ``atomic_read`` and ``atomic_set`` implement C11 atomic relaxed
+  semantics if the compiler supports it, and volatile semantics otherwise.
+  Both semantics prevent the compiler from doing certain transformations;
+  the difference is that atomic accesses are guaranteed to be atomic,
+  while volatile accesses aren't. Thus, in the volatile case we just cross
+  our fingers hoping that the compiler will generate atomic accesses,
+  since we assume the variables passed are machine-word sized and
+  properly aligned.
+
+  No barriers are implied by ``atomic_read`` and ``atomic_set`` in either =
Linux
+  or QEMU.
+
+- atomic read-modify-write operations in Linux are of three kinds:
+
+         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+         ``atomic_OP``         returns void
+         ``atomic_OP_return``  returns new value of the variable
+         ``atomic_fetch_OP``   returns the old value of the variable
+         ``atomic_cmpxchg``    returns the old value of the variable
+         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+  In QEMU, the second kind does not exist.  Currently Linux has
+  atomic_fetch_or only.  QEMU provides and, or, inc, dec, add, sub.
+
+- different atomic read-modify-write operations in Linux imply
+  a different set of memory barriers; in QEMU, all of them enforce
+  sequential consistency, which means they imply full memory barriers
+  before and after the operation.
+
+- Linux does not have an equivalent of ``atomic_mb_set()``.  In particular=
,
+  note that ``smp_store_mb()`` is a little weaker than ``atomic_mb_set()``=
.
+  ``atomic_mb_read()`` compiles to the same instructions as Linux's
+  ``smp_load_acquire()``, but this should be treated as an implementation
+  detail.
+
+Sources
+=3D=3D=3D=3D=3D=3D=3D
+
+- ``Documentation/memory-barriers.txt`` from the Linux kernel
diff --git a/docs/devel/atomics.txt b/docs/devel/atomics.txt
deleted file mode 100644
index 67bdf82628..0000000000
--- a/docs/devel/atomics.txt
+++ /dev/null
@@ -1,403 +0,0 @@
-CPUs perform independent memory operations effectively in random order.
-but this can be a problem for CPU-CPU interaction (including interactions
-between QEMU and the guest).  Multi-threaded programs use various tools
-to instruct the compiler and the CPU to restrict the order to something
-that is consistent with the expectations of the programmer.
-
-The most basic tool is locking.  Mutexes, condition variables and
-semaphores are used in QEMU, and should be the default approach to
-synchronization.  Anything else is considerably harder, but it's
-also justified more often than one would like.  The two tools that
-are provided by qemu/atomic.h are memory barriers and atomic operations.
-
-Macros defined by qemu/atomic.h fall in three camps:
-
-- compiler barriers: barrier();
-
-- weak atomic access and manual memory barriers: atomic_read(),
-  atomic_set(), smp_rmb(), smp_wmb(), smp_mb(), smp_mb_acquire(),
-  smp_mb_release(), smp_read_barrier_depends();
-
-- sequentially consistent atomic access: everything else.
-
-
-COMPILER MEMORY BARRIER
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-barrier() prevents the compiler from moving the memory accesses either
-side of it to the other side.  The compiler barrier has no direct effect
-on the CPU, which may then reorder things however it wishes.
-
-barrier() is mostly used within qemu/atomic.h itself.  On some
-architectures, CPU guarantees are strong enough that blocking compiler
-optimizations already ensures the correct order of execution.  In this
-case, qemu/atomic.h will reduce stronger memory barriers to simple
-compiler barriers.
-
-Still, barrier() can be useful when writing code that can be interrupted
-by signal handlers.
-
-
-SEQUENTIALLY CONSISTENT ATOMIC ACCESS
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Most of the operations in the qemu/atomic.h header ensure *sequential
-consistency*, where "the result of any execution is the same as if the
-operations of all the processors were executed in some sequential order,
-and the operations of each individual processor appear in this sequence
-in the order specified by its program".
-
-qemu/atomic.h provides the following set of atomic read-modify-write
-operations:
-
-    void atomic_inc(ptr)
-    void atomic_dec(ptr)
-    void atomic_add(ptr, val)
-    void atomic_sub(ptr, val)
-    void atomic_and(ptr, val)
-    void atomic_or(ptr, val)
-
-    typeof(*ptr) atomic_fetch_inc(ptr)
-    typeof(*ptr) atomic_fetch_dec(ptr)
-    typeof(*ptr) atomic_fetch_add(ptr, val)
-    typeof(*ptr) atomic_fetch_sub(ptr, val)
-    typeof(*ptr) atomic_fetch_and(ptr, val)
-    typeof(*ptr) atomic_fetch_or(ptr, val)
-    typeof(*ptr) atomic_fetch_xor(ptr, val)
-    typeof(*ptr) atomic_fetch_inc_nonzero(ptr)
-    typeof(*ptr) atomic_xchg(ptr, val)
-    typeof(*ptr) atomic_cmpxchg(ptr, old, new)
-
-all of which return the old value of *ptr.  These operations are
-polymorphic; they operate on any type that is as wide as a pointer.
-
-Similar operations return the new value of *ptr:
-
-    typeof(*ptr) atomic_inc_fetch(ptr)
-    typeof(*ptr) atomic_dec_fetch(ptr)
-    typeof(*ptr) atomic_add_fetch(ptr, val)
-    typeof(*ptr) atomic_sub_fetch(ptr, val)
-    typeof(*ptr) atomic_and_fetch(ptr, val)
-    typeof(*ptr) atomic_or_fetch(ptr, val)
-    typeof(*ptr) atomic_xor_fetch(ptr, val)
-
-Sequentially consistent loads and stores can be done using:
-
-    atomic_fetch_add(ptr, 0) for loads
-    atomic_xchg(ptr, val) for stores
-
-However, they are quite expensive on some platforms, notably POWER and
-Arm.  Therefore, qemu/atomic.h provides two primitives with slightly
-weaker constraints:
-
-    typeof(*ptr) atomic_mb_read(ptr)
-    void         atomic_mb_set(ptr, val)
-
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
-
-
-WEAK ATOMIC ACCESS AND MANUAL MEMORY BARRIERS
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Compared to sequentially consistent atomic access, programming with
-weaker consistency models can be considerably more complicated.
-In general, if the algorithm you are writing includes both writes
-and reads on the same side, it is generally simpler to use sequentially
-consistent primitives.
-
-When using this model, variables are accessed with:
-
-- atomic_read() and atomic_set(); these prevent the compiler from
-  optimizing accesses out of existence and creating unsolicited
-  accesses, but do not otherwise impose any ordering on loads and
-  stores: both the compiler and the processor are free to reorder
-  them.
-
-- atomic_load_acquire(), which guarantees the LOAD to appear to
-  happen, with respect to the other components of the system,
-  before all the LOAD or STORE operations specified afterwards.
-  Operations coming before atomic_load_acquire() can still be
-  reordered after it.
-
-- atomic_store_release(), which guarantees the STORE to appear to
-  happen, with respect to the other components of the system,
-  after all the LOAD or STORE operations specified afterwards.
-  Operations coming after atomic_store_release() can still be
-  reordered after it.
-
-Restrictions to the ordering of accesses can also be specified
-using the memory barrier macros: smp_rmb(), smp_wmb(), smp_mb(),
-smp_mb_acquire(), smp_mb_release(), smp_read_barrier_depends().
-
-Memory barriers control the order of references to shared memory.
-They come in six kinds:
-
-- smp_rmb() guarantees that all the LOAD operations specified before
-  the barrier will appear to happen before all the LOAD operations
-  specified after the barrier with respect to the other components of
-  the system.
-
-  In other words, smp_rmb() puts a partial ordering on loads, but is not
-  required to have any effect on stores.
-
-- smp_wmb() guarantees that all the STORE operations specified before
-  the barrier will appear to happen before all the STORE operations
-  specified after the barrier with respect to the other components of
-  the system.
-
-  In other words, smp_wmb() puts a partial ordering on stores, but is not
-  required to have any effect on loads.
-
-- smp_mb_acquire() guarantees that all the LOAD operations specified befor=
e
-  the barrier will appear to happen before all the LOAD or STORE operation=
s
-  specified after the barrier with respect to the other components of
-  the system.
-
-- smp_mb_release() guarantees that all the STORE operations specified *aft=
er*
-  the barrier will appear to happen after all the LOAD or STORE operations
-  specified *before* the barrier with respect to the other components of
-  the system.
-
-- smp_mb() guarantees that all the LOAD and STORE operations specified
-  before the barrier will appear to happen before all the LOAD and
-  STORE operations specified after the barrier with respect to the other
-  components of the system.
-
-  smp_mb() puts a partial ordering on both loads and stores.  It is
-  stronger than both a read and a write memory barrier; it implies both
-  smp_mb_acquire() and smp_mb_release(), but it also prevents STOREs
-  coming before the barrier from overtaking LOADs coming after the
-  barrier and vice versa.
-
-- smp_read_barrier_depends() is a weaker kind of read barrier.  On
-  most processors, whenever two loads are performed such that the
-  second depends on the result of the first (e.g., the first load
-  retrieves the address to which the second load will be directed),
-  the processor will guarantee that the first LOAD will appear to happen
-  before the second with respect to the other components of the system.
-  However, this is not always true---for example, it was not true on
-  Alpha processors.  Whenever this kind of access happens to shared
-  memory (that is not protected by a lock), a read barrier is needed,
-  and smp_read_barrier_depends() can be used instead of smp_rmb().
-
-  Note that the first load really has to have a _data_ dependency and not
-  a control dependency.  If the address for the second load is dependent
-  on the first load, but the dependency is through a conditional rather
-  than actually loading the address itself, then it's a _control_
-  dependency and a full read barrier or better is required.
-
-
-This is the set of barriers that is required *between* two atomic_read()
-and atomic_set() operations to achieve sequential consistency:
-
-                    |               2nd operation                   |
-                    |-----------------------------------------------|
-     1st operation  | (after last)   | atomic_read | atomic_set     |
-     ---------------+----------------+-------------+----------------|
-     (before first) |                | none        | smp_mb_release |
-     ---------------+----------------+-------------+----------------|
-     atomic_read    | smp_mb_acquire | smp_rmb     | **             |
-     ---------------+----------------+-------------+----------------|
-     atomic_set     | none           | smp_mb()*** | smp_wmb()      |
-     ---------------+----------------+-------------+----------------|
-
-       * Or smp_read_barrier_depends().
-
-      ** This requires a load-store barrier.  This is achieved by
-         either smp_mb_acquire() or smp_mb_release().
-
-     *** This requires a store-load barrier.  On most machines, the only
-         way to achieve this is a full barrier.
-
-
-You can see that the two possible definitions of atomic_mb_read()
-and atomic_mb_set() are the following:
-
-    1) atomic_mb_read(p)   =3D atomic_read(p); smp_mb_acquire()
-       atomic_mb_set(p, v) =3D smp_mb_release(); atomic_set(p, v); smp_mb(=
)
-
-    2) atomic_mb_read(p)   =3D smp_mb() atomic_read(p); smp_mb_acquire()
-       atomic_mb_set(p, v) =3D smp_mb_release(); atomic_set(p, v);
-
-Usually the former is used, because smp_mb() is expensive and a program
-normally has more reads than writes.  Therefore it makes more sense to
-make atomic_mb_set() the more expensive operation.
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
-     thread 1                                thread 1
-     -------------------------               ------------------------
-     (other writes)
-     atomic_mb_set(&a, x)                    atomic_store_release(&a, x)
-     atomic_mb_set(&b, y)                    atomic_store_release(&b, y)
-
-                                       =3D>
-     thread 2                                thread 2
-     -------------------------               ------------------------
-     y =3D atomic_mb_read(&b)                  y =3D atomic_load_acquire(&=
b)
-     x =3D atomic_mb_read(&a)                  x =3D atomic_load_acquire(&=
a)
-     (other reads)
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
-  barriers provided by atomic_mb_read() and atomic_mb_set() outside
-  a loop.  For example, the above definition atomic_mb_read() gives
-  the following transformation:
-
-     n =3D 0;                                  n =3D 0;
-     for (i =3D 0; i < 10; i++)          =3D>    for (i =3D 0; i < 10; i++=
)
-       n +=3D atomic_mb_read(&a[i]);             n +=3D atomic_read(&a[i])=
;
-                                             smp_mb_acquire();
-
-  Similarly, atomic_mb_set() can be transformed as follows:
-
-                                             smp_mb_release();
-     for (i =3D 0; i < 10; i++)          =3D>    for (i =3D 0; i < 10; i++=
)
-       atomic_mb_set(&a[i], false);            atomic_set(&a[i], false);
-                                             smp_mb();
-
-
-  The other thread can still use atomic_mb_read()/atomic_mb_set().
-
-The two tricks can be combined.  In this case, splitting a loop in
-two lets you hoist the barriers out of the loops _and_ eliminate the
-expensive smp_mb():
-
-                                             smp_mb_release();
-     for (i =3D 0; i < 10; i++) {        =3D>    for (i =3D 0; i < 10; i++=
)
-       atomic_mb_set(&a[i], false);            atomic_set(&a[i], false);
-       atomic_mb_set(&b[i], false);          smb_wmb();
-     }                                       for (i =3D 0; i < 10; i++)
-                                               atomic_set(&a[i], false);
-                                             smp_mb();
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
-For the purposes of pairing, smp_read_barrier_depends() and smp_rmb()
-both count as read barriers.  A read barrier shall pair with a write
-barrier or a full barrier; a write barrier shall pair with a read
-barrier or a full barrier.  A full barrier can pair with anything.
-For example:
-
-        thread 1             thread 2
-        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-        a =3D 1;
-        smp_wmb();
-        b =3D 2;               x =3D b;
-                             smp_rmb();
-                             y =3D a;
-
-Note that the "writing" thread is accessing the variables in the
-opposite order as the "reading" thread.  This is expected: stores
-before the write barrier will normally match the loads after the
-read barrier, and vice versa.  The same is true for more than 2
-access and for data dependency barriers:
-
-        thread 1             thread 2
-        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-        b[2] =3D 1;
-        smp_wmb();
-        x->i =3D 2;
-        smp_wmb();
-        a =3D x;               x =3D a;
-                             smp_read_barrier_depends();
-                             y =3D x->i;
-                             smp_read_barrier_depends();
-                             z =3D b[y];
-
-smp_wmb() also pairs with atomic_mb_read() and smp_mb_acquire().
-and smp_rmb() also pairs with atomic_mb_set() and smp_mb_release().
-
-
-COMPARISON WITH LINUX KERNEL MEMORY BARRIERS
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Here is a list of differences between Linux kernel atomic operations
-and memory barriers, and the equivalents in QEMU:
-
-- atomic operations in Linux are always on a 32-bit int type and
-  use a boxed atomic_t type; atomic operations in QEMU are polymorphic
-  and use normal C types.
-
-- Originally, atomic_read and atomic_set in Linux gave no guarantee
-  at all. Linux 4.1 updated them to implement volatile
-  semantics via ACCESS_ONCE (or the more recent READ/WRITE_ONCE).
-
-  QEMU's atomic_read/set implement, if the compiler supports it, C11
-  atomic relaxed semantics, and volatile semantics otherwise.
-  Both semantics prevent the compiler from doing certain transformations;
-  the difference is that atomic accesses are guaranteed to be atomic,
-  while volatile accesses aren't. Thus, in the volatile case we just cross
-  our fingers hoping that the compiler will generate atomic accesses,
-  since we assume the variables passed are machine-word sized and
-  properly aligned.
-  No barriers are implied by atomic_read/set in either Linux or QEMU.
-
-- atomic read-modify-write operations in Linux are of three kinds:
-
-         atomic_OP          returns void
-         atomic_OP_return   returns new value of the variable
-         atomic_fetch_OP    returns the old value of the variable
-         atomic_cmpxchg     returns the old value of the variable
-
-  In QEMU, the second kind does not exist.  Currently Linux has
-  atomic_fetch_or only.  QEMU provides and, or, inc, dec, add, sub.
-
-- different atomic read-modify-write operations in Linux imply
-  a different set of memory barriers; in QEMU, all of them enforce
-  sequential consistency, which means they imply full memory barriers
-  before and after the operation.
-
-- Linux does not have an equivalent of atomic_mb_set().  In particular,
-  note that smp_store_mb() is a little weaker than atomic_mb_set().
-  atomic_mb_read() compiles to the same instructions as Linux's
-  smp_load_acquire(), but this should be treated as an implementation
-  detail.
-
-SOURCES
-=3D=3D=3D=3D=3D=3D=3D
-
-* Documentation/memory-barriers.txt from the Linux kernel
-
-* "The JSR-133 Cookbook for Compiler Writers", available at
-  http://g.oswego.edu/dl/jmm/cookbook.html
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index b734ba4655..a9e1200dff 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -17,6 +17,7 @@ Contents:
    loads-stores
    memory
    migration
+   atomics
    stable-process
    testing
    decodetree
--=20
2.18.2



