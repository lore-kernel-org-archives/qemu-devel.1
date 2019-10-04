Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4788C4CED1
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 03:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3F820862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 03:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3F820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGEYU-0005Hj-Uo
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 23:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGEVv-0003mt-08
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGEVt-0001k9-I8
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:44:18 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2631)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGEVs-0001dC-PZ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:44:17 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by
 rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85d96c000b64-b287d;
 Fri, 04 Oct 2019 11:44:00 +0800 (CST)
X-RM-TRANSID: 2ee85d96c000b64-b287d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from maozy-host.lan (unknown[180.108.8.156])
 by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15d96bff81ac-a1ae6;
 Fri, 04 Oct 2019 11:44:00 +0800 (CST)
X-RM-TRANSID: 2ee15d96bff81ac-a1ae6
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] some fix in tests/migration
Date: Fri,  4 Oct 2019 11:43:45 +0800
Message-Id: <cover.1570159624.git.maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.80
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
Cc: tony.nguyen@bt.com, alex.bennee@linaro.org, armbru@redhat.com,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset mainly fixes memory leak, typo and return
value of stress function in stress test.

v3->v2:
p1: 
- replace malloc with g_malloc   [Laurent Vivier]
p3:
- change stressone type to void and stree return value
  to -1 to make the path of 'if (stress(ramsizeGB, ncpus) < 0)'
  can be reached.                [Laurent Vivier]
- update the commit message.

v2->v1:
- use g_autofree to release memory automatically instead
  of free().                     [Alex Bennée]
                      
Cc: armbru@redhat.com 
Cc: laurent@vivier.eu 
Cc: tony.nguyen@bt.com
Cc: alex.bennee@linaro.org

Mao Zhongyi (3):
  tests/migration: mem leak fix
  tests/migration: fix a typo in comment
  tests/migration：fix unreachable path in stress test

 tests/migration/stress.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

-- 
2.17.1




