Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7798AC38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B4B218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kvIchio4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B4B218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LEU-00065K-JZ
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmn-0007pM-BF
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmm-0003wQ-2k
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kml-0003vM-Ps
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrQVM032081;
 Mon, 24 Feb 2020 20:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=kNFIpLb5KqA13nmBN7fGm+89ZBH0qWuchoDbUdd84xU=;
 b=kvIchio4+AHvgs6csXqgac69kxcaowpGanOObtQ5ZKE86G/qqUkw2c6I/pkTD5f2pxKR
 UHYSc9Mf1TN++KV24uSvG12lv1oKLZ2VtEYHiUHeIwniQkizQAXlNWwDPdThLQ2+aU07
 LX/qB9YO2r5sOYLJtRdJoUOJCGiL6QL+FezxfysQwmJYvC6/CjeJQnxyPp7drwxNbgdu
 hEN7OaiqFQo+bX9Nj+EB1qM+H4tcNJ+BtZZg+vNF264my3ovsisA9onjrpB8jk1N5at8
 n8LT+eK846BfHrJuzAppk67PKqoLv5QN4Q7m272SIaq4nH/VHnsOU37sezgsEVyk0bYl bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2yauqua0q5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKufLC073328;
 Mon, 24 Feb 2020 20:56:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2ybduv6dnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:57 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKutDM030075;
 Mon, 24 Feb 2020 20:56:55 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:55 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 38/50] multi-process/mon: Initialize QMP module for remote
 processes
Date: Mon, 24 Feb 2020 15:55:29 -0500
Message-Id: <5dde2ceee2e0867302b411857baaa3b6d99668e6.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 bulkscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 remote/remote-main.c | 11 +++++++++++
 remote/remote-opts.c | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index 23fc0df..58d9905 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -56,6 +56,7 @@
 #include "monitor/monitor.h"
 #include "chardev/char.h"
 #include "sysemu/reset.h"
+#include "vl.h"
 
 static MPQemuLinkState *mpqemu_link;
 
@@ -436,6 +437,8 @@ int main(int argc, char *argv[])
 
     module_call_init(MODULE_INIT_QOM);
 
+    monitor_init_globals();
+
     bdrv_init_with_whitelist();
 
     if (qemu_init_main_loop(&err)) {
@@ -453,6 +456,8 @@ int main(int argc, char *argv[])
 
     qemu_add_opts(&qemu_device_opts);
     qemu_add_opts(&qemu_drive_opts);
+    qemu_add_opts(&qemu_chardev_opts);
+    qemu_add_opts(&qemu_mon_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
     qemu_add_drive_opts(&qemu_common_drive_opts);
     qemu_add_drive_opts(&qemu_drive_opts);
@@ -483,6 +488,12 @@ int main(int argc, char *argv[])
 
     mpqemu_link_set_callback(mpqemu_link, process_msg);
 
+    qemu_opts_foreach(qemu_find_opts("chardev"),
+                      chardev_init_func, NULL, &error_fatal);
+
+    qemu_opts_foreach(qemu_find_opts("mon"),
+                      mon_init_func, NULL, &error_fatal);
+
     mpqemu_start_coms(mpqemu_link);
 
     return 0;
diff --git a/remote/remote-opts.c b/remote/remote-opts.c
index 565e641..e22ad5c 100644
--- a/remote/remote-opts.c
+++ b/remote/remote-opts.c
@@ -82,6 +82,16 @@ void parse_cmdline(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_qmp:
+                monitor_parse(optarg, "control", false);
+                break;
+            case QEMU_OPTION_monitor:
+                if (!strncmp(optarg, "stdio", 5)) {
+                    warn_report("STDIO not supported in remote process");
+                } else if (strncmp(optarg, "none", 4)) {
+                    monitor_parse(optarg, "readline", false);
+                }
+                break;
             default:
                 break;
             }
-- 
1.8.3.1


