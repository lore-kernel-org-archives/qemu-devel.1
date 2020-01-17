Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DE2C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C352F2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KpoKCehB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C352F2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSQB-0007gg-PP
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david.edmondson@oracle.com>) id 1isOyw-0005SY-0q
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.edmondson@oracle.com>) id 1isOyr-0006W0-MG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:36:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.edmondson@oracle.com>)
 id 1isOyr-0006UG-F2
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:35:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HAY3iO161391
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=549lWEneC6AQVgxJMNmbCEU/IPhzDWcy3LOeI993BkU=;
 b=KpoKCehBCSIPdGMfKU+L5gfv8Fh13Qn3o8WaXxRnc428wf/fosmLz9tX3ozyBSpgAYd/
 nhHyzcvjKnJTvyqCX1uJroJZpBLg1QUR+N4cxmO0oqUDBtR54CPESTlTz+0p6CjjAmv0
 j3eksxl/XJLXK/BMS4jPX0OF9A0V1ez8o+qZ3BSlsXsWLivKoWwn2CQPCRleP2POvPyK
 Ycs0zQggOfkLOTnkh2d/Cnaak5HJzpzW1hulaKpN+9jhRGALbu+f2gqDQdLEK/NNpeOO
 R2NJND1ou09WEFL/kaLmDvyAxdSJO7F/L/ZD2kshkZI3Nwm9Z7ubGOitrqk5H+EptJ7r Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2xf73u7vev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:35:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HAXRgr042775
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:35:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2xjxm8nkgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:35:54 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00HAZrjS005660
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:35:53 GMT
Received: from disaster-area.hh.sledj.net (/81.149.164.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 17 Jan 2020 02:35:53 -0800
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 9f9f2f3a;
 Fri, 17 Jan 2020 10:35:51 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-img: Add --target-is-zero to convert
Date: Fri, 17 Jan 2020 10:34:35 +0000
Message-Id: <20200117103434.1363985-1-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <id:m21rryz8al.fsf@dme.org>
References: <id:m21rryz8al.fsf@dme.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=877
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=922 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170082
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
X-Mailman-Approved-At: Fri, 17 Jan 2020 09:15:33 -0500
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
Cc: David Edmondson <david.edmondson@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In many cases the target of a convert operation is a newly provisioned
target that the user knows is blank (filled with zeroes). In this
situation there is no requirement for qemu-img to wastefully zero out
the entire device.

Add a new option, --target-is-zero, allowing the user to indicate that
an existing target device is already zero filled.
---
 qemu-img.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 95a24b9762..56ca727e8c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -70,6 +70,7 @@ enum {
     OPTION_PREALLOCATION = 265,
     OPTION_SHRINK = 266,
     OPTION_SALVAGE = 267,
+    OPTION_TARGET_IS_ZERO = 268,
 };
 
 typedef enum OutputFormat {
@@ -1593,6 +1594,7 @@ typedef struct ImgConvertState {
     bool copy_range;
     bool salvage;
     bool quiet;
+    bool target_is_zero;
     int min_sparse;
     int alignment;
     size_t cluster_sectors;
@@ -1984,10 +1986,11 @@ static int convert_do_copy(ImgConvertState *s)
     int64_t sector_num = 0;
 
     /* Check whether we have zero initialisation or can get it efficiently */
-    if (s->target_is_new && s->min_sparse && !s->target_has_backing) {
+    s->has_zero_init = s->target_is_zero;
+
+    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
+        !s->target_has_backing) {
         s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
-    } else {
-        s->has_zero_init = false;
     }
 
     if (!s->has_zero_init && !s->target_has_backing &&
@@ -2076,6 +2079,7 @@ static int img_convert(int argc, char **argv)
         .buf_sectors        = IO_BUF_SIZE / BDRV_SECTOR_SIZE,
         .wr_in_order        = true,
         .num_coroutines     = 8,
+        .target_is_zero     = false,
     };
 
     for(;;) {
@@ -2086,6 +2090,7 @@ static int img_convert(int argc, char **argv)
             {"force-share", no_argument, 0, 'U'},
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {"salvage", no_argument, 0, OPTION_SALVAGE},
+            {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
@@ -2209,6 +2214,9 @@ static int img_convert(int argc, char **argv)
         case OPTION_TARGET_IMAGE_OPTS:
             tgt_image_opts = true;
             break;
+        case OPTION_TARGET_IS_ZERO:
+            s.target_is_zero = true;
+            break;
         }
     }
 
@@ -2247,6 +2255,11 @@ static int img_convert(int argc, char **argv)
         warn_report("This will become an error in future QEMU versions.");
     }
 
+    if (s.target_is_zero && !skip_create) {
+        error_report("--target-is-zero requires use of -n flag");
+        goto fail_getopt;
+    }
+
     s.src_num = argc - optind - 1;
     out_filename = s.src_num >= 1 ? argv[argc - 1] : NULL;
 
-- 
2.24.1


