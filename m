Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE53C47258
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 12:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43810206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 12:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43810206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxAB-0001EB-6h
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 08:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1jVx9F-0007zN-FG; Tue, 05 May 2020 08:58:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1jVx9E-0000bm-A8; Tue, 05 May 2020 08:58:09 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 045CZkwO018224; Tue, 5 May 2020 08:58:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30s45tu07m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 08:58:04 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 045CaDCI021149;
 Tue, 5 May 2020 08:58:03 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30s45tu06a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 08:58:03 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 045Cu1Fc011489;
 Tue, 5 May 2020 12:58:01 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04ams.nl.ibm.com with ESMTP id 30s0g5pya8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 12:58:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 045Cum0q64487910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2020 12:56:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD4FA11C066;
 Tue,  5 May 2020 12:57:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B930211C052;
 Tue,  5 May 2020 12:57:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue,  5 May 2020 12:57:57 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 20AA7E0897; Tue,  5 May 2020 14:57:57 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v4 5/6] s390x/css: Refactor the css_queue_crw() routine
Date: Tue,  5 May 2020 14:57:56 +0200
Message-Id: <20200505125757.98209-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505125757.98209-1-farman@linux.ibm.com>
References: <20200505125757.98209-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-05-05_08:2020-05-04,
 2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050100
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 08:42:20
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a use case (vfio-ccw) where a CRW is already built and
ready to use.  Rather than teasing out the components just to
reassemble it later, let's rework this code so we can queue a
fully-qualified CRW directly.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v3->v4:
     - s/css_queue_crw_cont/css_crw_add_to_queue/ [CH]

 hw/s390x/css.c         | 44 ++++++++++++++++++++++++++++--------------
 include/hw/s390x/css.h |  1 +
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index a44faa3549..d1e365e3e6 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2170,30 +2170,23 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
     }
 }
 
-void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
-                   int chain, uint16_t rsid)
+void css_crw_add_to_queue(CRW crw)
 {
     CrwContainer *crw_cont;
 
-    trace_css_crw(rsc, erc, rsid, chain ? "(chained)" : "");
+    trace_css_crw((crw.flags & CRW_FLAGS_MASK_RSC) >> 8,
+                  crw.flags & CRW_FLAGS_MASK_ERC,
+                  crw.rsid,
+                  (crw.flags & CRW_FLAGS_MASK_C) ? "(chained)" : "");
+
     /* TODO: Maybe use a static crw pool? */
     crw_cont = g_try_new0(CrwContainer, 1);
     if (!crw_cont) {
         channel_subsys.crws_lost = true;
         return;
     }
-    crw_cont->crw.flags = (rsc << 8) | erc;
-    if (solicited) {
-        crw_cont->crw.flags |= CRW_FLAGS_MASK_S;
-    }
-    if (chain) {
-        crw_cont->crw.flags |= CRW_FLAGS_MASK_C;
-    }
-    crw_cont->crw.rsid = rsid;
-    if (channel_subsys.crws_lost) {
-        crw_cont->crw.flags |= CRW_FLAGS_MASK_R;
-        channel_subsys.crws_lost = false;
-    }
+
+    crw_cont->crw = crw;
 
     QTAILQ_INSERT_TAIL(&channel_subsys.pending_crws, crw_cont, sibling);
 
@@ -2204,6 +2197,27 @@ void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
     }
 }
 
+void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
+                   int chain, uint16_t rsid)
+{
+    CRW crw;
+
+    crw.flags = (rsc << 8) | erc;
+    if (solicited) {
+        crw.flags |= CRW_FLAGS_MASK_S;
+    }
+    if (chain) {
+        crw.flags |= CRW_FLAGS_MASK_C;
+    }
+    crw.rsid = rsid;
+    if (channel_subsys.crws_lost) {
+        crw.flags |= CRW_FLAGS_MASK_R;
+        channel_subsys.crws_lost = false;
+    }
+
+    css_crw_add_to_queue(crw);
+}
+
 void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
                            int hotplugged, int add)
 {
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 7e3a5e7433..08c869ab0a 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -205,6 +205,7 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src);
 void css_inject_io_interrupt(SubchDev *sch);
 void css_reset(void);
 void css_reset_sch(SubchDev *sch);
+void css_crw_add_to_queue(CRW crw);
 void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
                    int chain, uint16_t rsid);
 void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
-- 
2.17.1


