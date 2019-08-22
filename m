Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586BBC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F39222CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F39222CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ndr-0001UQ-IQ
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1i0nbx-0008KE-Ie
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1i0nbw-00047R-6X
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:58:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1i0nbw-00047E-1Q; Thu, 22 Aug 2019 09:58:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 291BD18C4266;
 Thu, 22 Aug 2019 13:58:43 +0000 (UTC)
Received: from localhost (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B02798D64;
 Thu, 22 Aug 2019 13:58:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 15:58:31 +0200
Message-Id: <20190822135839.32340-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 22 Aug 2019 13:58:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/7] First batch of s390x changes for 4.2
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

The following changes since commit f3b8f18ebf344ab359e8f79f6ed777e740dae7=
7c:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2019-08-=
21' into staging (2019-08-22 10:31:21 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20190822

for you to fetch changes up to 065fe80fe03ff0f36a0cbebbd2d4b3c05110d96d:

  s390x/mmu: Factor out storage key handling (2019-08-22 14:53:49 +0200)

----------------------------------------------------------------
s390x updates:
- fix a bug in tcg vector handling
- improved skey handling

----------------------------------------------------------------

David Hildenbrand (7):
  s390x/tcg: Fix VERIM with 32/64 bit elements
  s390x/mmu: Trace the right value if setting/getting the storage key
    fails
  s390x/mmu: ASC selection in s390_cpu_get_phys_page_debug()
  s390x/tcg: Rework MMU selection for instruction fetches
  s390x/tcg: Flush the TLB of all CPUs on SSKE and RRBE
  s390x/mmu: Better storage key reference and change bit handling
  s390x/mmu: Factor out storage key handling

 target/s390x/cpu.h              |   7 ++
 target/s390x/helper.c           |   5 ++
 target/s390x/mem_helper.c       |  10 +++
 target/s390x/mmu_helper.c       | 135 ++++++++++++++++++++------------
 target/s390x/translate_vx.inc.c |   2 +-
 5 files changed, 108 insertions(+), 51 deletions(-)

--=20
2.20.1


