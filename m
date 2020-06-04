Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBA8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF68206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QR2zh33q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF68206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjay-0006Lv-Bs
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaD-0004yG-K8
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:33 -0400
Received: from ozlabs.org ([203.11.71.1]:38327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaB-0000mq-GR
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cx6C1TGJz9sSy; Thu,  4 Jun 2020 16:42:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591252947;
 bh=xkT1FQ1tlWIodI9BBRKL+4b/EXFmxDrPZ0u1FPIW7HI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QR2zh33qP7gj/TB0dA7oLnQ+vEpmbGqoA2wfiM0EiCBp41eF/iMONXw5vFsneh6sc
 zYMWKWeBmbwk/ptAnuv+EfARjbItYcsmSUa15zgF7t+2HHmt8g/AAOVEpTWTKzGGU/
 9AXFAXt0P9pgskrcR63dWABn7OXHjD2eUB8Tx92A=
From: David Gibson <david@gibson.dropbear.id.au>
To: rth@twiddle.net, pbonzini@redhat.com, ekabkost@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 1/9] target/i386: sev: Remove unused QSevGuestInfoClass
Date: Thu,  4 Jun 2020 16:42:11 +1000
Message-Id: <20200604064219.436242-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604064219.436242-1-david@gibson.dropbear.id.au>
References: <20200604064219.436242-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 02:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: brijesh.singh@amd.com, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, dgilbert@redhat.com,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This structure is nothing but an empty wrapper around the parent class,
which by QOM conventions means we don't need it at all.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/sev.c      | 1 -
 target/i386/sev_i386.h | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 51cdbe5496..2312510cf2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -287,7 +287,6 @@ static const TypeInfo qsev_guest_info = {
     .name = TYPE_QSEV_GUEST_INFO,
     .instance_size = sizeof(QSevGuestInfo),
     .instance_finalize = qsev_guest_finalize,
-    .class_size = sizeof(QSevGuestInfoClass),
     .class_init = qsev_guest_class_init,
     .instance_init = qsev_guest_init,
     .interfaces = (InterfaceInfo[]) {
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index 8ada9d385d..4f193642ac 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -41,7 +41,6 @@ extern char *sev_get_launch_measurement(void);
 extern SevCapability *sev_get_capabilities(void);
 
 typedef struct QSevGuestInfo QSevGuestInfo;
-typedef struct QSevGuestInfoClass QSevGuestInfoClass;
 
 /**
  * QSevGuestInfo:
@@ -64,10 +63,6 @@ struct QSevGuestInfo {
     uint32_t reduced_phys_bits;
 };
 
-struct QSevGuestInfoClass {
-    ObjectClass parent_class;
-};
-
 struct SEVState {
     QSevGuestInfo *sev_info;
     uint8_t api_major;
-- 
2.26.2


