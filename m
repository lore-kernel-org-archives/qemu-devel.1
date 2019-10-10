Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7E3C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4222053B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4222053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWjq-00050S-Rn
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWhn-00035c-Uj
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWhm-0005Y9-LR
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:34:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWhm-0005Xs-Dc; Thu, 10 Oct 2019 07:34:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7216718C8902;
 Thu, 10 Oct 2019 11:34:01 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A5145C1B5;
 Thu, 10 Oct 2019 11:33:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 00/31] s390x/tcg update
Date: Thu, 10 Oct 2019 13:33:25 +0200
Message-Id: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 10 Oct 2019 11:34:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e7=
2d:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-10-08 16:08:35 +0100)

are available in the Git repository at:

  https://github.com/davidhildenbrand/qemu.git tags/s390x-tcg-2019-10-10

for you to fetch changes up to 1f6493be088da969efeeee0100ea4330fb804cdf:

  s390x/tcg: MVCL: Exit to main loop if requested (2019-10-10 12:27:15 +0=
200)

----------------------------------------------------------------
- MMU DAT translation rewrite and cleanup
- Implement more TCG CPU features related to the MMU (e.g., IEP)
- Add the current instruction length to unwind data and clean up
- Resolve one TODO for the MVCL instruction

----------------------------------------------------------------
David Hildenbrand (13):
  s390x/mmu: Drop debug logging from MMU code
  s390x/mmu: Move DAT protection handling out of mmu_translate_asce()
  s390x/mmu: Inject DAT exceptions from a single place
  s390x/mmu: Inject PGM_ADDRESSING on bogus table addresses
  s390x/mmu: Use TARGET_PAGE_MASK in mmu_translate_pte()
  s390x/mmu: DAT table definition overhaul
  s390x/mmu: Convert to non-recursive page table walk
  s390x/mmu: Add EDAT2 translation support
  s390x/mmu: Implement ESOP-2 and
    access-exception-fetch/store-indication facility
  s390x/mmu: Implement Instruction-Execution-Protection Facility
  s390x/cpumodel: Prepare for changes of QEMU model
  s390x/cpumodel: Add new TCG features to QEMU cpu model
  s390x/tcg: MVCL: Exit to main loop if requested

Richard Henderson (18):
  target/s390x: Add ilen to unwind data
  target/s390x: Remove ilen parameter from tcg_s390_program_interrupt
  target/s390x: Remove ilen parameter from s390_program_interrupt
  target/s390x: Use tcg_s390_program_interrupt in TCG helpers
  target/s390x: Push trigger_pgm_exception lower in s390_cpu_tlb_fill
  target/s390x: Handle tec in s390_cpu_tlb_fill
  target/s390x: Return exception from mmu_translate_real
  target/s390x: Remove exc argument to mmu_translate_asce
  target/s390x: Return exception from mmu_translate
  target/s390x: Return exception from translate_pages
  target/s390x: Remove fail variable from s390_cpu_tlb_fill
  target/s390x: Simplify helper_lra
  target/s390x: Rely on unwinding in s390_cpu_tlb_fill
  target/s390x: Rely on unwinding in s390_cpu_virt_mem_rw
  target/s390x: Remove ILEN_AUTO
  target/s390x: Remove ilen argument from trigger_access_exception
  target/s390x: Remove ilen argument from trigger_pgm_exception
  target/s390x: Remove ILEN_UNWIND

 hw/s390x/s390-pci-inst.c     |  58 ++---
 hw/s390x/s390-virtio-ccw.c   |   2 +
 include/exec/exec-all.h      |  17 ++
 target/s390x/cc_helper.c     |   4 +-
 target/s390x/cpu.h           |  86 +++++--
 target/s390x/crypto_helper.c |   7 +-
 target/s390x/diag.c          |  14 +-
 target/s390x/excp_helper.c   |  58 +++--
 target/s390x/fpu_helper.c    |   6 +-
 target/s390x/gen-features.c  |  11 +-
 target/s390x/helper.c        |   7 +-
 target/s390x/int_helper.c    |  15 +-
 target/s390x/internal.h      |   6 +-
 target/s390x/interrupt.c     |   9 +-
 target/s390x/ioinst.c        |  40 ++--
 target/s390x/mem_helper.c    |  84 +++----
 target/s390x/misc_helper.c   |  27 +--
 target/s390x/mmu_helper.c    | 429 ++++++++++++++++-------------------
 target/s390x/tcg-stub.c      |   4 +-
 target/s390x/tcg_s390x.h     |   4 +-
 target/s390x/translate.c     |  20 +-
 21 files changed, 475 insertions(+), 433 deletions(-)

--=20
2.21.0


