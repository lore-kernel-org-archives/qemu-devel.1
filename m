Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BEEFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15CD2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15CD2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1Mv-0008BQ-JG
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT1KK-00069R-0n
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT1KH-0004xv-Vl
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:17:11 -0500
Received: from relay.sw.ru ([185.231.240.75]:56110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iT1K8-0004ub-Ua; Fri, 08 Nov 2019 05:17:01 -0500
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iT1K3-0002Yp-Dr; Fri, 08 Nov 2019 13:16:55 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/2] Deprecate implicit filters
Date: Fri,  8 Nov 2019 13:16:53 +0300
Message-Id: <20191108101655.10611-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, libvir-list@redhat.com,
 armbru@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 jsnow@redhat.com, vsementsov@virtuozzo.com, dinechin@redhat.com,
 den@openvz.org, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
Don't deprecate drive-backup, it is unrelated thing and will be resent
in separate.
Don't deprecate drive-mirror. Instead add filter-node-name to
drive-mirror to behave like blockdev-mirror
Fix all broken iotests.

Vladimir Sementsov-Ogievskiy (2):
  qapi: add filter-node-name option to drive-mirror
  qapi: deprecate implicit filters

 qemu-deprecated.texi       |  6 ++++++
 qapi/block-core.json       | 14 ++++++++++++--
 include/block/block_int.h  | 10 +++++++++-
 blockdev.c                 | 12 +++++++++++-
 tests/qemu-iotests/094     |  1 +
 tests/qemu-iotests/095     |  6 ++++--
 tests/qemu-iotests/109     |  1 +
 tests/qemu-iotests/127     |  1 +
 tests/qemu-iotests/141     |  5 ++++-
 tests/qemu-iotests/144     |  3 ++-
 tests/qemu-iotests/156     |  1 +
 tests/qemu-iotests/161     |  7 +++++++
 tests/qemu-iotests/161.out |  1 +
 tests/qemu-iotests/185     |  3 +++
 tests/qemu-iotests/191     |  2 ++
 tests/qemu-iotests/229     |  1 +
 tests/qemu-iotests/247     |  8 +++++---
 tests/qemu-iotests/249     |  5 +++--
 tests/qemu-iotests/249.out |  2 +-
 19 files changed, 75 insertions(+), 14 deletions(-)

-- 
2.21.0


