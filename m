Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90924C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEB021897
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UvG69/V9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEB021897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFW6Q-0003IQ-C7
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3B-0005ic-5r; Tue, 08 Sep 2020 01:20:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW37-0005rB-75; Tue, 08 Sep 2020 01:20:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltkj5rc8z9sTg; Tue,  8 Sep 2020 15:19:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542397;
 bh=PGXTjEP4QoRFOn/jGOws1ISctNffp+geWnV5qJ570xc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UvG69/V9zKCVWtf3/3WKlchn98On+3TOi849MeyZHf8DdZqXwJlKSNeOp098tS8si
 97YZVbbIs6jwJUServS8OBJ5A5UlxXgaAW8AzlujLLHarFx6ffqeyJBn8FKuc2hA60
 OgKhH0AXUJG8VVlNsW50S8QjpgOxFNd+8CgBRV0w=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 03/33] spapr: Remove unnecessary DRC type-checker macros
Date: Tue,  8 Sep 2020 15:19:23 +1000
Message-Id: <20200908051953.1616885-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, bauerman@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

spapr_drc.h includes typechecker macro boilerplate for the many different
DRC subclasses.  However, most of these types don't actually have different
data in their class and/or instance, making these unneeded, unused, and in
fact a bad idea.  Remove them.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 include/hw/ppc/spapr_drc.h | 43 +-------------------------------------
 1 file changed, 1 insertion(+), 42 deletions(-)

diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 21af8deac1..f270860769 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -29,62 +29,21 @@
                                              TYPE_SPAPR_DR_CONNECTOR)
 
 #define TYPE_SPAPR_DRC_PHYSICAL "spapr-drc-physical"
-#define SPAPR_DRC_PHYSICAL_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PHYSICAL)
-#define SPAPR_DRC_PHYSICAL_CLASS(klass) \
-        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, \
-                           TYPE_SPAPR_DRC_PHYSICAL)
 #define SPAPR_DRC_PHYSICAL(obj) OBJECT_CHECK(SpaprDrcPhysical, (obj), \
                                              TYPE_SPAPR_DRC_PHYSICAL)
 
 #define TYPE_SPAPR_DRC_LOGICAL "spapr-drc-logical"
-#define SPAPR_DRC_LOGICAL_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_LOGICAL)
-#define SPAPR_DRC_LOGICAL_CLASS(klass) \
-        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, \
-                           TYPE_SPAPR_DRC_LOGICAL)
-#define SPAPR_DRC_LOGICAL(obj) OBJECT_CHECK(SpaprDrc, (obj), \
-                                             TYPE_SPAPR_DRC_LOGICAL)
 
 #define TYPE_SPAPR_DRC_CPU "spapr-drc-cpu"
-#define SPAPR_DRC_CPU_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_CPU)
-#define SPAPR_DRC_CPU_CLASS(klass) \
-        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_CPU)
-#define SPAPR_DRC_CPU(obj) OBJECT_CHECK(SpaprDrc, (obj), \
-                                        TYPE_SPAPR_DRC_CPU)
 
 #define TYPE_SPAPR_DRC_PCI "spapr-drc-pci"
-#define SPAPR_DRC_PCI_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PCI)
-#define SPAPR_DRC_PCI_CLASS(klass) \
-        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PCI)
-#define SPAPR_DRC_PCI(obj) OBJECT_CHECK(SpaprDrc, (obj), \
-                                        TYPE_SPAPR_DRC_PCI)
 
 #define TYPE_SPAPR_DRC_LMB "spapr-drc-lmb"
-#define SPAPR_DRC_LMB_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_LMB)
-#define SPAPR_DRC_LMB_CLASS(klass) \
-        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_LMB)
-#define SPAPR_DRC_LMB(obj) OBJECT_CHECK(SpaprDrc, (obj), \
-                                        TYPE_SPAPR_DRC_LMB)
 
 #define TYPE_SPAPR_DRC_PHB "spapr-drc-phb"
-#define SPAPR_DRC_PHB_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PHB)
-#define SPAPR_DRC_PHB_CLASS(klass) \
-        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PHB)
-#define SPAPR_DRC_PHB(obj) OBJECT_CHECK(SpaprDrc, (obj), \
-                                        TYPE_SPAPR_DRC_PHB)
 
 #define TYPE_SPAPR_DRC_PMEM "spapr-drc-pmem"
-#define SPAPR_DRC_PMEM_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PMEM)
-#define SPAPR_DRC_PMEM_CLASS(klass) \
-        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PMEM)
-#define SPAPR_DRC_PMEM(obj) OBJECT_CHECK(SpaprDrc, (obj), \
-                                         TYPE_SPAPR_DRC_PMEM)
+
 /*
  * Various hotplug types managed by SpaprDrc
  *
-- 
2.26.2


