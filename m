Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B56BC5517A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E549421534
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E549421534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVhGJ-0002RM-Sw
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 16:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kVhDt-000101-3g
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 16:30:09 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kVhDr-0001rb-4c
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 16:30:08 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N64JK-1kKSqB163k-016LIv; Thu, 22 Oct 2020 22:30:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/m68k: remove useless qregs array
Date: Thu, 22 Oct 2020 22:29:59 +0200
Message-Id: <20201022203000.1922749-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201022203000.1922749-1-laurent@vivier.eu>
References: <20201022203000.1922749-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:I+dL1+NxbKynMIHzKotWQ9ec/7vUKvbwELbMWgjtV1YIsVTUONl
 x1YgtCaav4hx4r0kO8GRsz3bNPX3yBVHQt3s66UAie5xEQMnc5WIDBXhRROdHZNDOlgAhx7
 e8rBp9Tl7kYnTvTqz1ijyFtl0opX6S/68d98wW5CaBKYUUfMfxD2I7f2th7RJnSGR2+jxj0
 vHaSIIaemRZSc5QvApHRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bHcCzZQc2sE=:+bzvXoJpGNY6YjHTlvRN54
 yblw/tO61JzBs61RB9dtjOgoP7sHpaDRhymxRgX/xpqmNMibY3F/lYtjvYWThdO9UqdajtYcv
 aq/mWe4Sa0XIBWTXVlVZywnV1FEm5h5f70FIxS5OTctWKQ9ft9X9LIaCryffLMJ9EaKE+b02o
 pULIEoY82u6DqCyYhTFSEdgB9SoXFUULRJglmi3awfn85WjswByKpb/zipW+5hs5jL7qrN24v
 fy7rDW4Frtwm0UGZjRt89AJGEphXWTQhgES1qQFkHYYMk/RLIE+SNO8dFxmVy8M6JzXj3/xpe
 /xqboYSg5/H2/f44wZlCSv9GqCg1azmbBH4xrHS5d4Q+GzQMBhhbLnJVi2sgsPzmEJl2bG5D0
 aRmZrca08RSdEoqot+jiIV4u9H4u1Zlyu8OojLxQlRTm5V52/8kghkUCUUpZw
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 16:30:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They are unused since the target has been converted to TCG.

Fixes: e1f3808e03f7 ("Convert m68k target to TCG.")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 521ac67cdd04..9a6f0400fcfe 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -33,8 +33,6 @@
 #define OS_PACKED   6
 #define OS_UNSIZED  7
 
-#define MAX_QREGS 32
-
 #define EXCP_ACCESS         2   /* Access (MMU) error.  */
 #define EXCP_ADDRESS        3   /* Address error.  */
 #define EXCP_ILLEGAL        4   /* Illegal instruction.  */
@@ -139,8 +137,6 @@ typedef struct CPUM68KState {
     int pending_vector;
     int pending_level;
 
-    uint32_t qregs[MAX_QREGS];
-
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-- 
2.26.2


