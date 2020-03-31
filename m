Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D9CC2D0EF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC5F20787
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC5F20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCBs-0005R5-AS
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jJCAb-0003hv-PY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jJCAa-0001JY-DF
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:22:49 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:7351)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jJCAQ-000190-Tq
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:22:48 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by
 rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25e82fdbbc50-25d4b;
 Tue, 31 Mar 2020 16:22:19 +0800 (CST)
X-RM-TRANSID: 2ee25e82fdbbc50-25d4b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55e82fdb5ba9-2769d;
 Tue, 31 Mar 2020 16:22:19 +0800 (CST)
X-RM-TRANSID: 2ee55e82fdb5ba9-2769d
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] Improved reporting for migrate parameters
Date: Tue, 31 Mar 2020 16:22:04 +0800
Message-Id: <cover.1585641083.git.maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 221.176.66.79
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
Cc: dgilbert@redhat.com, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series mainly improve the report message of migrate parameters
to make it easier to read.

v2->v1
-p1: avoid using constants, replace it with stringify().

Cc: quintela@redhat.com
Cc: dgilbert@redhat.com

Mao Zhongyi (3):
  migration/migration: improve error reporting for migrate parameters
  monitor/hmp-cmds: add hmp_handle_error() for hmp_migrate_set_speed()
  migration: move the units of migrate parameters from milliseconds to
    ms

 migration/migration.c | 20 ++++++++++++--------
 monitor/hmp-cmds.c    | 13 ++++++++-----
 2 files changed, 20 insertions(+), 13 deletions(-)

-- 
2.17.1




