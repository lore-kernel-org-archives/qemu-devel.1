Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D62CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F363E218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F363E218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwX0-00008g-SV
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iAvsu-0006Ji-MW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iAvkO-0007Zl-Gk
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:41:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iAvkO-0007Yq-Br; Thu, 19 Sep 2019 08:41:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A804481DE0;
 Thu, 19 Sep 2019 12:41:19 +0000 (UTC)
Received: from localhost (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5701B1001938;
 Thu, 19 Sep 2019 12:41:19 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 14:40:41 +0200
Message-Id: <20190919124115.11510-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 19 Sep 2019 12:41:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/34] s390x update
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f8c3db33a5e863291182f8862ddf81618a7c61=
94:

  target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:=
00 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20190919

for you to fetch changes up to 37105adebeb28e60da3cb1ef82231d7ed8d23589:

  Merge tag 'tags/s390-ccw-bios-2019-09-18' into s390-next-staging (2019-=
09-19 12:04:01 +0200)

----------------------------------------------------------------
- bugfixes in tcg and the ccw bios
- gen15a is called z15
- officially require a 3.15 kernel or later for kvm

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x/cpumodel: Add the z15 name to the description of gen15a

David Hildenbrand (29):
  s390x/tcg: Reset exception_index to -1 instead of 0
  s390x/tcg: MVCL: Zero out unused bits of address
  s390x/tcg: MVCL: Detect destructive overlaps
  s390x/tcg: MVCL: Process max 4k bytes at a time
  s390x/tcg: MVC: Increment the length once
  s390x/tcg: MVC: Use is_destructive_overlap()
  s390x/tcg: MVPG: Check for specification exceptions
  s390x/tcg: MVPG: Properly wrap the addresses
  s390x/tcg: MVCLU/MVCLE: Process max 4k bytes at a time
  s390x/tcg: MVCS/MVCP: Check for special operation exceptions
  s390x/tcg: MVCOS: Lengths are 32 bit in 24/31-bit mode
  s390x/tcg: MVCS/MVCP: Properly wrap the length
  s390x/tcg: MVST: Check for specification exceptions
  s390x/tcg: MVST: Fix storing back the addresses to registers
  s390x/tcg: Always use MMU_USER_IDX for CONFIG_USER_ONLY
  s390x/tcg: Fault-safe memset
  s390x/tcg: Fault-safe memmove
  s390x/tcg: MVCS/MVCP: Use access_memmove()
  s390x/tcg: MVC: Fault-safe handling on destructive overlaps
  s390x/tcg: MVCLU: Fault-safe handling
  s390x/tcg: OC: Fault-safe handling
  s390x/tcg: XC: Fault-safe handling
  s390x/tcg: NC: Fault-safe handling
  s390x/tcg: MVCIN: Fault-safe handling
  s390x/tcg: MVN: Fault-safe handling
  s390x/tcg: MVZ: Fault-safe handling
  s390x/tcg: MVST: Fault-safe handling
  s390x/tcg: MVO: Fault-safe handling
  tests/tcg: target/s390x: Test MVO

Thomas Huth (3):
  pc-bios/s390-ccw: Do not pre-initialize empty array
  pc-bios/s390-ccw: Rebuild the s390-netboot.img firmware image
  s390x/kvm: Officially require at least kernel 3.15

Yifan Luo (1):
  pc-bios/s390-ccw/net: fix a possible memory leak in get_uuid()

 hw/intc/s390_flic_kvm.c   | 6 ------
 hw/intc/trace-events      | 1 -
 target/s390x/cpu_models.c | 2 +-
 target/s390x/kvm.c        | 7 +++++++
 4 files changed, 8 insertions(+), 8 deletions(-)

--=20
2.20.1


