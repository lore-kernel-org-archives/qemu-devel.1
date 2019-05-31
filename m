Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A43EC28CC2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166E3267B5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166E3267B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40854 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWf6y-0002Uc-AH
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 06:50:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWf1n-0006qE-Rt
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWf1m-0001Lq-4v
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hWf1l-00014S-Rg
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C95C8C058CBD;
	Fri, 31 May 2019 10:44:36 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-233.ams2.redhat.com [10.36.116.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97EFF271AE;
	Fri, 31 May 2019 10:44:33 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 12:44:09 +0200
Message-Id: <20190531104432.29379-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 31 May 2019 10:44:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 00/23] s390x/tcg: Vector Instruction Support
 Part 4
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the final part of vector instruction support for s390x. It is bas=
ed
on part 2, which is will send a pull-request for to Conny soon.

Part 1: Vector Support Instructions
Part 2: Vector Integer Instructions
Part 3: Vector String Instructions
Part 4: Vector Floating-Point Instructions

The current state can be found at (kept updated):
    https://github.com/davidhildenbrand/qemu/tree/vx

It is based on:
- [PATCH v2 0/5] s390x/tcg: Vector Instruction Support Part 3
- [PATCH v1 0/2] s390x: Fix vector register alignment

With the current state I can boot Linux kernel + user space compiled with
SIMD support. This allows to boot distributions compiled exclusively for
z13, requiring SIMD support. Also, it is now possible to build a complete
kernel using rpmbuild as quite some issues have been sorted out.

While the current state works fine for me with RHEL 8, I am experiencing
some issues with newer userspace versions (I suspect glibc). I'll have
to look into the details first - could be a BUG in !vector
instruction or a BUG in a vector instruction that was until now unused.

In this part, all Vector Floating-Point Instructions introduced with the
"Vector Facility" are added. Also, the "qemu" model is changed to a
z13 machine.

David Hildenbrand (23):
  s390x: Use uint64_t for vector registers
  s390x/tcg: Introduce tcg_s390_vector_exception()
  s390x/tcg: Export float_comp_to_cc() and float(32|64|128)_dcmask()
  s390x/tcg: Implement VECTOR FP ADD
  s390x/tcg: Implement VECTOR FP COMPARE (AND SIGNAL) SCALAR
  s390x/tcg: Implement VECTOR FP COMPARE (EQUAL|HIGH|HIGH OR EQUAL)
  s390x/tcg: Implement VECTOR FP CONVERT FROM FIXED 64-BIT
  s390x/tcg: Implement VECTOR FP CONVERT FROM LOGICAL 64-BIT
  s390x/tcg: Implement VECTOR FP CONVERT TO FIXED 64-BIT
  s390x/tcg: Implement VECTOR FP CONVERT TO LOGICAL 64-BIT
  s390x/tcg: Implement VECTOR FP DIVIDE
  s390x/tcg: Implement VECTOR LOAD FP INTEGER
  s390x/tcg: Implement VECTOR LOAD LENGTHENED
  s390x/tcg: Implement VECTOR LOAD ROUNDED
  s390x/tcg: Implement VECTOR FP MULTIPLY
  s390x/tcg: Implement VECTOR FP MULTIPLY AND (ADD|SUBTRACT)
  s390x/tcg: Implement VECTOR FP PERFORM SIGN OPERATION
  s390x/tcg: Implement VECTOR FP SQUARE ROOT
  s390x/tcg: Implement VECTOR FP SUBTRACT
  s390x/tcg: Implement VECTOR FP TEST DATA CLASS IMMEDIATE
  s390x/tcg: Allow linux-user to use vector instructions
  s390x/tcg: We support the Vector Facility
  s390x: Bump the "qemu" CPU model up to a stripped-down z13

 hw/s390x/s390-virtio-ccw.c      |   2 +
 linux-user/s390x/signal.c       |   4 +-
 target/s390x/Makefile.objs      |   1 +
 target/s390x/arch_dump.c        |   8 +-
 target/s390x/cpu.c              |   3 +
 target/s390x/cpu.h              |   5 +-
 target/s390x/cpu_models.c       |   4 +-
 target/s390x/excp_helper.c      |  21 +-
 target/s390x/fpu_helper.c       |   4 +-
 target/s390x/gdbstub.c          |  16 +-
 target/s390x/gen-features.c     |  10 +-
 target/s390x/helper.c           |  10 +-
 target/s390x/helper.h           |  46 +++
 target/s390x/insn-data.def      |  45 +++
 target/s390x/internal.h         |   4 +
 target/s390x/kvm.c              |  16 +-
 target/s390x/machine.c          | 128 +++----
 target/s390x/tcg_s390x.h        |   2 +
 target/s390x/translate.c        |   2 +-
 target/s390x/translate_vx.inc.c | 274 ++++++++++++++
 target/s390x/vec_fpu_helper.c   | 644 ++++++++++++++++++++++++++++++++
 21 files changed, 1145 insertions(+), 104 deletions(-)
 create mode 100644 target/s390x/vec_fpu_helper.c

--=20
2.20.1


