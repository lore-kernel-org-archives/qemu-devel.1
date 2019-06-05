Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF0C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187572075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187572075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49475 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcdQ-0003R2-9f
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:35:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYcbs-0002TZ-Ez
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYcbo-0005Jp-K2
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:34:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hYcbo-0005Hg-4L; Wed, 05 Jun 2019 16:34:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2BB3307D86F;
	Wed,  5 Jun 2019 20:34:06 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-124.ams2.redhat.com [10.36.116.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 77E13619E0;
	Wed,  5 Jun 2019 20:34:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 22:33:30 +0200
Message-Id: <20190605203403.29461-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 05 Jun 2019 20:34:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 00/33] s390x/tcg: Final Vector
 Instruction Support
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This pull request is not for master.

Hi Cornelia,

The following changes since commit dd5382ad6deb5a07ec3c72b2c3cce36ce1307a=
57:

  vfio-ccw: support async command subregion (2019-06-05 07:55:18 +0200)

are available in the Git repository at:

  https://github.com/davidhildenbrand/qemu.git tags/s390x-tcg-2019-06-05

for you to fetch changes up to cebb5e9c211764f9b7d0ad205cc81632f2609667:

  linux-user: elf: ELF_HWCAP for s390x (2019-06-05 16:48:29 +0200)

----------------------------------------------------------------
Finalize implementation of the "Vector Facility" for s390x TCG. Add it
to the QEMU CPU model, so it is enabled as default.
Also:
- One fix (and one workaround) for the STFLE instruction
- Fix the alignment of vector registers (and change the data type)
- Properly generate ELF_HWCAP for s390x for linux-user
- Use a gvec helper for VECTOR SELECT

----------------------------------------------------------------
David Hildenbrand (32):
  s390x/tcg: Implement VECTOR FIND ANY ELEMENT EQUAL
  s390x/tcg: Implement VECTOR FIND ELEMENT EQUAL
  s390x/tcg: Implement VECTOR FIND ELEMENT NOT EQUAL
  s390x/tcg: Implement VECTOR ISOLATE STRING
  s390x/tcg: Implement VECTOR STRING RANGE COMPARE
  s390x: Align vector registers to 16 bytes
  s390x: Use uint64_t for vector registers
  s390x/tcg: Fix max_byte detection for stfle
  s390x/tcg: Store only the necessary amount of doublewords for STFLE
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
  linux-user: elf: ELF_HWCAP for s390x

Richard Henderson (1):
  s390x/tcg: Use tcg_gen_gvec_bitsel for VECTOR SELECT

 hw/s390x/s390-virtio-ccw.c       |   2 +
 include/elf.h                    |   1 +
 linux-user/elfload.c             |  28 ++
 linux-user/s390x/signal.c        |   4 +-
 target/s390x/Makefile.objs       |   3 +-
 target/s390x/arch_dump.c         |   8 +-
 target/s390x/cpu.c               |   3 +
 target/s390x/cpu.h               |   5 +-
 target/s390x/cpu_models.c        |   4 +-
 target/s390x/excp_helper.c       |  21 +-
 target/s390x/fpu_helper.c        |   4 +-
 target/s390x/gdbstub.c           |  16 +-
 target/s390x/gen-features.c      |  10 +-
 target/s390x/helper.c            |  10 +-
 target/s390x/helper.h            |  84 +++++
 target/s390x/insn-data.def       |  58 +++
 target/s390x/internal.h          |   4 +
 target/s390x/kvm.c               |  16 +-
 target/s390x/machine.c           | 128 +++----
 target/s390x/misc_helper.c       |  11 +-
 target/s390x/tcg_s390x.h         |   2 +
 target/s390x/translate.c         |   2 +-
 target/s390x/translate_vx.inc.c  | 507 +++++++++++++++++++++++--
 target/s390x/vec.h               |  40 ++
 target/s390x/vec_fpu_helper.c    | 625 +++++++++++++++++++++++++++++++
 target/s390x/vec_string_helper.c | 473 +++++++++++++++++++++++
 26 files changed, 1930 insertions(+), 139 deletions(-)
 create mode 100644 target/s390x/vec_fpu_helper.c
 create mode 100644 target/s390x/vec_string_helper.c

--=20
2.21.0


