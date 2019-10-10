Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F38C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39773208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39773208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYVP-0007j6-9p
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iIYKr-0002Aa-N1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iIYKq-0002xd-KG
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20020
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iIYKq-0002wp-Di
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:28 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9AD7QmD131674
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:18:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vj2pmx0ws-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:18:23 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 10 Oct 2019 14:18:18 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 10 Oct 2019 14:18:15 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9ADIEbs30081054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2019 13:18:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A21AC4C058;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C6854C05A;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from bahia.tls.ibm.com (bahia.tls.ibm.com [9.101.4.41])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 50441220303;
 Thu, 10 Oct 2019 15:18:14 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 3/8] fsdev: Add return value to fsdev_throttle_parse_opts()
Date: Thu, 10 Oct 2019 15:18:04 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010131809.1284004-1-groug@kaod.org>
References: <20191010131809.1284004-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101013-4275-0000-0000-00000370E0E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101013-4276-0000-0000-00003883E899
Message-Id: <20191010131809.1284004-4-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-10_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=748 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910100124
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is more convenient to use the return value of the function to notify
errors, rather than to be tied up setting up the &local_err boilerplate.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/qemu-fsdev-throttle.c | 4 ++--
 fsdev/qemu-fsdev-throttle.h | 2 +-
 hw/9pfs/9p-local.c          | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index fe1d76dc76e7..5c83a1cc09c3 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -31,7 +31,7 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
     qemu_co_enter_next(&fst->throttled_reqs[true], NULL);
 }
 
-void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
+int fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
 {
     throttle_config_init(&fst->cfg);
     fst->cfg.buckets[THROTTLE_BPS_TOTAL].avg =
@@ -75,7 +75,7 @@ void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
     fst->cfg.op_size =
         qemu_opt_get_number(opts, "throttling.iops-size", 0);
 
-    throttle_is_valid(&fst->cfg, errp);
+    return throttle_is_valid(&fst->cfg, errp) ? 0 : -1;
 }
 
 void fsdev_throttle_init(FsThrottle *fst)
diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index c98e2feab553..a21aecddc734 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -26,7 +26,7 @@ typedef struct FsThrottle {
     CoQueue      throttled_reqs[2];
 } FsThrottle;
 
-void fsdev_throttle_parse_opts(QemuOpts *, FsThrottle *, Error **);
+int fsdev_throttle_parse_opts(QemuOpts *, FsThrottle *, Error **);
 
 void fsdev_throttle_init(FsThrottle *);
 
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 6f7309f4e691..5c7f4cd9c7b0 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1511,8 +1511,7 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
         return -1;
     }
 
-    fsdev_throttle_parse_opts(opts, &fse->fst, &local_err);
-    if (local_err) {
+    if (fsdev_throttle_parse_opts(opts, &fse->fst, &local_err)) {
         error_propagate_prepend(errp, local_err,
                                 "invalid throttle configuration: ");
         return -1;
-- 
2.21.0


