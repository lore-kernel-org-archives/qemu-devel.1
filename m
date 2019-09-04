Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24692C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C3021670
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C3021670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5RN0-0005zt-H9
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 05:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i5RKH-0003wy-3W
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i5RKF-0004mi-Aq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:11:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:47466)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i5RKE-0004kw-Ul; Wed, 04 Sep 2019 05:11:39 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i5RKB-000708-5B; Wed, 04 Sep 2019 12:11:35 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed,  4 Sep 2019 12:11:18 +0300
Message-Id: <1567588284-975381-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v8 0/6] Allow Valgrind checking all QEMU
 processes
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the current implementation of the QEMU bash iotests, only qemu-io
processes may be run under the Valgrind with the switch '-valgrind'.
Let's allow the common.rc bash script running all other QEMU processes,
such as qemu-kvm, qemu-img, qemu-ndb and qemu-vxhs, under the Valgrind.

v8:
  01: Fix for the optimization made in v7 where the iotests 039 and 051
      did not pass being run under the Valgrind. NO_VALGRIND variable
      has been introduced to complete the optimization logic (patch 2/6).

  Discussed in the email threads with the message IDs:
  <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
  <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
  <1566834628-485525-1-git-send-email-andrey.shinkevich@virtuozzo.com>

Andrey Shinkevich (6):
  iotests: allow Valgrind checking all QEMU processes
  iotests: exclude killed processes from running under Valgrind
  iotests: Add casenotrun report to bash tests
  iotests: Valgrind fails with nonexistent directory
  iotests: extended timeout under Valgrind
  iotests: extend sleeping time under Valgrind

 tests/qemu-iotests/028       |   6 ++-
 tests/qemu-iotests/039       |   5 +++
 tests/qemu-iotests/039.out   |  30 +++----------
 tests/qemu-iotests/051       |   4 ++
 tests/qemu-iotests/061       |   2 +
 tests/qemu-iotests/061.out   |  12 +----
 tests/qemu-iotests/137       |   1 +
 tests/qemu-iotests/137.out   |   6 +--
 tests/qemu-iotests/183       |   9 +++-
 tests/qemu-iotests/192       |   6 ++-
 tests/qemu-iotests/247       |   6 ++-
 tests/qemu-iotests/common.rc | 105 +++++++++++++++++++++++++++++++++++--------
 12 files changed, 130 insertions(+), 62 deletions(-)

-- 
1.8.3.1


