Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6028EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 11:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0FA2065C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 11:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="fdun0IE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0FA2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjhR8-0003KF-Bs
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 07:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jjhQ3-0002aU-Gc; Fri, 12 Jun 2020 07:00:19 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:39562 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jjhQ1-0003Aa-Qx; Fri, 12 Jun 2020 07:00:19 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id A645A4C8B7;
 Fri, 12 Jun 2020 11:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1591959614; x=
 1593774015; bh=VnZrnnHp/G0hergrKRdKADdXl6fJ9zRjEpV9JMCBjDU=; b=f
 dun0IE6a/ugjT6a8bWWq4oJH3vVFK2o6a7EdOb0VoYINigvz/T7Usty32SPwc/Yn
 1Ct7HJMu/gcxEdrVm7ASSNRkowQLznZnc33GItE7wUSGxpApnaDRY9WL/aC/3e1x
 xnhIFdGWkjSqgGCdTmYqYJatMS6EvCke2kzxoyOqb0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2meOEhcDzAX5; Fri, 12 Jun 2020 14:00:14 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 4EC674C8A1;
 Fri, 12 Jun 2020 14:00:14 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 12
 Jun 2020 14:00:14 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH] .gitignore: Ignore storage-daemon files
Date: Fri, 12 Jun 2020 13:58:31 +0300
Message-ID: <20200612105830.17082-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 07:00:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The files are generated.

Fixes: 2af282ec51a ("qemu-storage-daemon: Add --monitor option")
Cc: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 .gitignore | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0c5af83aa7..90acb4347d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -34,18 +34,18 @@
 /qapi/qapi-builtin-types.[ch]
 /qapi/qapi-builtin-visit.[ch]
 /qapi/qapi-commands-*.[ch]
-/qapi/qapi-commands.[ch]
-/qapi/qapi-emit-events.[ch]
+**/qapi/qapi-commands.[ch]
+**/qapi/qapi-emit-events.[ch]
 /qapi/qapi-events-*.[ch]
-/qapi/qapi-events.[ch]
-/qapi/qapi-init-commands.[ch]
-/qapi/qapi-introspect.[ch]
+**/qapi/qapi-events.[ch]
+**/qapi/qapi-init-commands.[ch]
+**/qapi/qapi-introspect.[ch]
 /qapi/qapi-types-*.[ch]
-/qapi/qapi-types.[ch]
+**/qapi/qapi-types.[ch]
 /qapi/qapi-visit-*.[ch]
 !/qapi/qapi-visit-core.c
-/qapi/qapi-visit.[ch]
-/qapi/qapi-doc.texi
+**/qapi/qapi-visit.[ch]
+**/qapi/qapi-doc.texi
 /qemu-edid
 /qemu-img
 /qemu-nbd
@@ -59,6 +59,7 @@
 /qemu-keymap
 /qemu-monitor.texi
 /qemu-monitor-info.texi
+/qemu-storage-daemon
 /qemu-version.h
 /qemu-version.h.tmp
 /module_block.h
-- 
2.26.1


