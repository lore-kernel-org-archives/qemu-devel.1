Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14C0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A50206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A50206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jusv9-00042h-Vd
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 03:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jussf-0007fh-Or; Mon, 13 Jul 2020 03:28:05 -0400
Received: from relay.sw.ru ([185.231.240.75]:35076 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jussc-0007TE-CC; Mon, 13 Jul 2020 03:28:05 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jussP-0001Vx-IK; Mon, 13 Jul 2020 10:27:49 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v9 00/10] iotests: Dump QCOW2 dirty bitmaps metadata
Date: Mon, 13 Jul 2020 10:27:46 +0300
Message-Id: <1594625276-134500-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:27:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add dirty bitmap information to QCOW2 metadata dump in the qcow2_format.py.

v9:
  01: In patch 0003, removed explicit constructor in the class Qcow2BitmapExt.
  02: In patch 0004, the format string was changed.
 

Andrey Shinkevich (10):
  qcow2: Fix capitalization of header extension constant.
  qcow2_format.py: make printable data an extension class member
  qcow2_format.py: change Qcow2BitmapExt initialization method
  qcow2_format.py: dump bitmap flags in human readable way.
  qcow2_format.py: Dump bitmap directory information
  qcow2_format.py: pass cluster size to substructures
  qcow2_format.py: Dump bitmap table serialized entries
  qcow2.py: Introduce '-j' key to dump in JSON format
  qcow2_format.py: collect fields to dump in JSON format
  qcow2_format.py: support dumping metadata in JSON format

 block/qcow2.c                      |   2 +-
 docs/interop/qcow2.txt             |   2 +-
 tests/qemu-iotests/291.out         |  90 ++++++++++++++++
 tests/qemu-iotests/qcow2.py        |  19 +++-
 tests/qemu-iotests/qcow2_format.py | 213 ++++++++++++++++++++++++++++++++++---
 5 files changed, 304 insertions(+), 22 deletions(-)

-- 
1.8.3.1


