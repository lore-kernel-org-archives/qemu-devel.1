Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25B9C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE61206E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE61206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48442 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZGFR-0003iq-Lq
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53400)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZFhi-0004Nu-PB
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZFhh-00047y-H4
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZFhh-00046m-95; Fri, 07 Jun 2019 10:18:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 872F430F1BC5;
 Fri,  7 Jun 2019 14:18:48 +0000 (UTC)
Received: from gondolin (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75B1378566;
 Fri,  7 Jun 2019 14:18:47 +0000 (UTC)
Date: Fri, 7 Jun 2019 16:18:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190607161844.134e7842.cohuck@redhat.com>
In-Reply-To: <20190607130233.2200-1-david@redhat.com>
References: <20190607130233.2200-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 07 Jun 2019 14:18:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL SUBSYSTEM s390x v2 00/33] s390x/tcg: Final
 Vector Instruction Support
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  7 Jun 2019 15:02:33 +0200
David Hildenbrand <david@redhat.com> wrote:

> This pull request is not for master.
> 
> Hi Cornelia,
> 
> second attempt :)
> 
> The following changes since commit 33556237f652d8a712d0b6d29ecb442e6b65fe42:
> 
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-7-2019' into staging (2019-06-07 11:17:28 +0100)
> 
> are available in the Git repository at:
> 
>   https://github.com/davidhildenbrand/qemu.git tags/s390x-tcg-2019-06-07
> 
> for you to fetch changes up to 6d88baf18653ff8826db3dd840a6b372d3477280:
> 
>   linux-user: elf: ELF_HWCAP for s390x (2019-06-07 14:53:26 +0200)
> 
> ----------------------------------------------------------------
> Finalize implementation of the "Vector Facility" for s390x TCG. Add it
> to the QEMU CPU model, so it is enabled as default.
> Also:
> - One fix (and one workaround) for the STFLE instruction
> - Fix the alignment of vector registers (and change the data type)
> - Properly generate ELF_HWCAP for s390x for linux-user
> - Use a gvec helper for VECTOR SELECT
> 
> ----------------------------------------------------------------
> David Hildenbrand (32):
>   s390x/tcg: Implement VECTOR FIND ANY ELEMENT EQUAL
>   s390x/tcg: Implement VECTOR FIND ELEMENT EQUAL
>   s390x/tcg: Implement VECTOR FIND ELEMENT NOT EQUAL
>   s390x/tcg: Implement VECTOR ISOLATE STRING
>   s390x/tcg: Implement VECTOR STRING RANGE COMPARE
>   s390x: Align vector registers to 16 bytes
>   s390x: Use uint64_t for vector registers
>   s390x/tcg: Fix max_byte detection for stfle
>   s390x/tcg: Store only the necessary amount of doublewords for STFLE
>   s390x/tcg: Introduce tcg_s390_vector_exception()
>   s390x/tcg: Export float_comp_to_cc() and float(32|64|128)_dcmask()
>   s390x/tcg: Implement VECTOR FP ADD
>   s390x/tcg: Implement VECTOR FP COMPARE (AND SIGNAL) SCALAR
>   s390x/tcg: Implement VECTOR FP COMPARE (EQUAL|HIGH|HIGH OR EQUAL)
>   s390x/tcg: Implement VECTOR FP CONVERT FROM FIXED 64-BIT
>   s390x/tcg: Implement VECTOR FP CONVERT FROM LOGICAL 64-BIT
>   s390x/tcg: Implement VECTOR FP CONVERT TO FIXED 64-BIT
>   s390x/tcg: Implement VECTOR FP CONVERT TO LOGICAL 64-BIT
>   s390x/tcg: Implement VECTOR FP DIVIDE
>   s390x/tcg: Implement VECTOR LOAD FP INTEGER
>   s390x/tcg: Implement VECTOR LOAD LENGTHENED
>   s390x/tcg: Implement VECTOR LOAD ROUNDED
>   s390x/tcg: Implement VECTOR FP MULTIPLY
>   s390x/tcg: Implement VECTOR FP MULTIPLY AND (ADD|SUBTRACT)
>   s390x/tcg: Implement VECTOR FP PERFORM SIGN OPERATION
>   s390x/tcg: Implement VECTOR FP SQUARE ROOT
>   s390x/tcg: Implement VECTOR FP SUBTRACT
>   s390x/tcg: Implement VECTOR FP TEST DATA CLASS IMMEDIATE
>   s390x/tcg: Allow linux-user to use vector instructions
>   s390x/tcg: We support the Vector Facility
>   s390x: Bump the "qemu" CPU model up to a stripped-down z13
>   linux-user: elf: ELF_HWCAP for s390x
> 
> Richard Henderson (1):
>   s390x/tcg: Use tcg_gen_gvec_bitsel for VECTOR SELECT
> 
>  hw/s390x/s390-virtio-ccw.c       |   2 +
>  include/elf.h                    |   1 +
>  linux-user/elfload.c             |  28 ++
>  linux-user/s390x/signal.c        |   4 +-
>  target/s390x/Makefile.objs       |   3 +-
>  target/s390x/arch_dump.c         |   8 +-
>  target/s390x/cpu.c               |   3 +
>  target/s390x/cpu.h               |   5 +-
>  target/s390x/cpu_models.c        |   4 +-
>  target/s390x/excp_helper.c       |  21 +-
>  target/s390x/fpu_helper.c        |   4 +-
>  target/s390x/gdbstub.c           |  16 +-
>  target/s390x/gen-features.c      |  10 +-
>  target/s390x/helper.c            |  10 +-
>  target/s390x/helper.h            |  84 +++++
>  target/s390x/insn-data.def       |  58 +++
>  target/s390x/internal.h          |   4 +
>  target/s390x/kvm.c               |  16 +-
>  target/s390x/machine.c           | 128 +++----
>  target/s390x/misc_helper.c       |  11 +-
>  target/s390x/tcg_s390x.h         |   2 +
>  target/s390x/translate.c         |   2 +-
>  target/s390x/translate_vx.inc.c  | 507 +++++++++++++++++++++++--
>  target/s390x/vec.h               |  40 ++
>  target/s390x/vec_fpu_helper.c    | 625 +++++++++++++++++++++++++++++++
>  target/s390x/vec_string_helper.c | 473 +++++++++++++++++++++++
>  26 files changed, 1930 insertions(+), 139 deletions(-)
>  create mode 100644 target/s390x/vec_fpu_helper.c
>  create mode 100644 target/s390x/vec_string_helper.c
> 

Thanks, pulled again :)

