Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBC0C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECC321882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECC321882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS697-0001h5-3Y
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5p7-0000TT-7L
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5p5-000219-R3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5p5-00020H-ID; Tue, 05 Nov 2019 15:53:07 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpWJB144499; Tue, 5 Nov 2019 15:53:06 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3fuuha8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:06 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5KqOdN146630;
 Tue, 5 Nov 2019 15:53:06 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3fuuha82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:06 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnwpQ017684;
 Tue, 5 Nov 2019 20:53:05 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03wdc.us.ibm.com with ESMTP id 2w11e7h8tn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:04 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5Kr4R453871016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:04 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78BFE124058;
 Tue,  5 Nov 2019 20:53:04 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65FC2124052;
 Tue,  5 Nov 2019 20:53:04 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:04 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/55] Revert "ide/ahci: Check for -ECANCELED in aio callbacks"
Date: Tue,  5 Nov 2019 14:51:50 -0600
Message-Id: <20191105205243.3766-3-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
index 00ba422a48..6aaf66534a 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1023,9 +1023,6 @@ static void ncq_cb(void *opaque, int ret)
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


