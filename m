Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD89C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 05:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC5420880
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 05:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC5420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDjiA-0001Wk-AV
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 01:54:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hDjgu-0000o0-Hl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hDjgt-0007ng-8m
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:53:04 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:43046
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>)
	id 1hDjgs-0007nK-TT; Tue, 09 Apr 2019 01:53:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by v2201612906741603.powersrv.de (Postfix) with ESMTP id EC62EDA062F;
	Tue,  9 Apr 2019 07:43:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
	by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id Osi-OF68DGjv; Tue,  9 Apr 2019 07:43:31 +0200 (CEST)
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
	by v2201612906741603.powersrv.de (Postfix) with ESMTP id 17CD3DA0606;
	Tue,  9 Apr 2019 07:43:31 +0200 (CEST)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
	id DBE5F46000F; Tue,  9 Apr 2019 07:43:30 +0200 (CEST)
From: Stefan Weil <sw@weilnetz.de>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Apr 2019 07:43:25 +0200
Message-Id: <20190409054325.22427-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 37.120.169.71
Subject: [Qemu-devel] [PATCH] Fix type of cluster_index
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefan Weil <stweil@ub-cluster-01.bib.uni-mannheim.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409054325.TqCA7QQZGCbNnKfm9_x_JXhH5uuU3WB7iHdsCfTQPAw@z>

From: Stefan Weil <stweil@ub-cluster-01.bib.uni-mannheim.de>

The type should be the same as the type of cluster_id.

This fixed a runtime error reported by sanitizers:

    /qemu/include/exec/tb-lookup.h:33:35: runtime error: left shift of negative value -1
    /qemu/accel/tcg/translate-all.c:1692:34: runtime error: left shift of negative value -1

Signed-off-by: Stefan Weil <stweil@ub-cluster-01.bib.uni-mannheim.de>
---
 include/qom/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 1d6099e5d4..6a753caed7 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -422,7 +422,7 @@ struct CPUState {
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
-    int cluster_index;
+    uint32_t cluster_index;
     uint32_t halted;
     uint32_t can_do_io;
     int32_t exception_index;
@@ -1129,6 +1129,6 @@ extern const struct VMStateDescription vmstate_cpu_common;
 #endif /* NEED_CPU_H */
 
 #define UNASSIGNED_CPU_INDEX -1
-#define UNASSIGNED_CLUSTER_INDEX -1
+#define UNASSIGNED_CLUSTER_INDEX UINT32_MAX
 
 #endif
-- 
2.11.0


