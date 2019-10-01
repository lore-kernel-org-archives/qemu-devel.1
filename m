Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CF3ECE587
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C87020815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C87020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFT4T-0008MS-A8
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsW-0001ta-FP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsL-0002PQ-Oy
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52394
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsK-0001uk-6I; Tue, 01 Oct 2019 19:48:13 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlOhv098919; Tue, 1 Oct 2019 19:47:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcfjp9v3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:51 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91Nlpld099899;
 Tue, 1 Oct 2019 19:47:51 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcfjp9v3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:51 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlXK001425;
 Tue, 1 Oct 2019 23:47:50 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03wdc.us.ibm.com with ESMTP id 2v9y56yf8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:50 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NloGF46596384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:50 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 112812805A;
 Tue,  1 Oct 2019 23:47:50 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E99EB28058;
 Tue,  1 Oct 2019 23:47:49 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:49 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 70/97] Revert "ide/ahci: Check for -ECANCELED in aio callbacks"
Date: Tue,  1 Oct 2019 18:45:49 -0500
Message-Id: <20191001234616.7825-71-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

This reverts commit 0d910cfeaf2076b116b4517166d5deb0fea76394.

It's not correct to just ignore an error code in a callback; we need to
handle that error and possible report failure to the guest so that they
don't wait indefinitely for an operation that will now never finish.

This ought to help cases reported by Nutanix where iSCSI returns a
legitimate -ECANCELED for certain operations which should be propagated
normally.

Reported-by: Shaju Abraham <shaju.abraham@nutanix.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20190729223605.7163-1-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 8ec41c4265714255d5a138f8b538faf3583dcff6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ide/ahci.c |  3 ---
 hw/ide/core.c | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index d700ca973b..bda9583c8b 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1022,9 +1022,6 @@ static void ncq_cb(void *opaque, int ret)
     IDEState *ide_state = &ncq_tfs->drive->port.ifs[0];
 
     ncq_tfs->aiocb = NULL;
-    if (ret == -ECANCELED) {
-        return;
-    }
 
     if (ret < 0) {
         bool is_read = ncq_tfs->cmd == READ_FPDMA_QUEUED;
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 6afadf894f..8e1624f7ce 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -722,9 +722,6 @@ static void ide_sector_read_cb(void *opaque, int ret)
     s->pio_aiocb = NULL;
     s->status &= ~BUSY_STAT;
 
-    if (ret == -ECANCELED) {
-        return;
-    }
     if (ret != 0) {
         if (ide_handle_rw_error(s, -ret, IDE_RETRY_PIO |
                                 IDE_RETRY_READ)) {
@@ -840,10 +837,6 @@ static void ide_dma_cb(void *opaque, int ret)
     uint64_t offset;
     bool stay_active = false;
 
-    if (ret == -ECANCELED) {
-        return;
-    }
-
     if (ret == -EINVAL) {
         ide_dma_error(s);
         return;
@@ -975,10 +968,6 @@ static void ide_sector_write_cb(void *opaque, int ret)
     IDEState *s = opaque;
     int n;
 
-    if (ret == -ECANCELED) {
-        return;
-    }
-
     s->pio_aiocb = NULL;
     s->status &= ~BUSY_STAT;
 
@@ -1058,9 +1047,6 @@ static void ide_flush_cb(void *opaque, int ret)
 
     s->pio_aiocb = NULL;
 
-    if (ret == -ECANCELED) {
-        return;
-    }
     if (ret < 0) {
         /* XXX: What sector number to set here? */
         if (ide_handle_rw_error(s, -ret, IDE_RETRY_FLUSH)) {
-- 
2.17.1


