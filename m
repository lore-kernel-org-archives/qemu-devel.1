Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C457C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 02:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E630F20857
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 02:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E630F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPGtz-00009O-3E
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 22:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1jPGq9-0003aX-CO
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 22:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1jPGq8-0002EK-7b
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 22:34:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1jPGq8-0002D5-0o
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 22:34:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03H2XPwt050887
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 22:34:46 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30f37agswq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 22:34:45 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
 Fri, 17 Apr 2020 03:34:06 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 17 Apr 2020 03:34:05 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03H2Yf2p52756646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2020 02:34:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A182A405F;
 Fri, 17 Apr 2020 02:34:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 182DAA405C;
 Fri, 17 Apr 2020 02:34:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 17 Apr 2020 02:34:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 7E7B0E05A7; Fri, 17 Apr 2020 04:34:40 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v3 6/7] s390x/css: Refactor the css_queue_crw() routine
Date: Fri, 17 Apr 2020 04:34:39 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417023440.70514-1-farman@linux.ibm.com>
References: <20200417023440.70514-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20041702-4275-0000-0000-000003C1422A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041702-4276-0000-0000-000038D6BE03
Message-Id: <20200417023440.70514-7-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-16_10:2020-04-14,
 2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170019
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 148.163.156.1
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
 hw/s390x/css.c         | 44 ++++++++++++++++++++++++++++--------------
 include/hw/s390x/css.h |  1 +
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index a44faa3549..a72c09adbe 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2170,30 +2170,23 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
     }
 }
 
-void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
-                   int chain, uint16_t rsid)
+void css_queue_crw_cont(CRW crw)
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
+    css_queue_crw_cont(crw);
+}
+
 void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
                            int hotplugged, int add)
 {
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 7e3a5e7433..1aa7b80f5b 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -205,6 +205,7 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src);
 void css_inject_io_interrupt(SubchDev *sch);
 void css_reset(void);
 void css_reset_sch(SubchDev *sch);
+void css_queue_crw_cont(CRW crw);
 void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
                    int chain, uint16_t rsid);
 void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
-- 
2.17.1


