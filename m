Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795D0C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513B1206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513B1206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8oaG-0005Qs-C3
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 12:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i8oYq-0003qE-43
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i8oYo-0002gY-Jp
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:36:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57988
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i8oYo-0002b6-FB
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:36:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8DGWTKQ095104
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 12:36:27 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2v0cjewcnu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 12:36:27 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 13 Sep 2019 17:36:25 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Sep 2019 17:36:24 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8DGaNHc58589188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2019 16:36:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B572AE04D;
 Fri, 13 Sep 2019 16:36:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B17CAE045;
 Fri, 13 Sep 2019 16:36:23 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.1.250])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2019 16:36:23 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: Greg Kurz <groug@kaod.org>
Date: Fri, 13 Sep 2019 18:36:23 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091316-0012-0000-0000-0000034AEBE3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091316-0013-0000-0000-000021855CA8
Message-Id: <156839258306.2228854.8411024885973295628.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-13_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=850 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909130167
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] 9p: Print error hints if option parsing fails
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Option parsing fonctions are called with &error_fatal, which
causes error_setg() to call exit() and the hints are never
printed.

Use an intermediate error object so that exit() happens in
error_propagate() after error_append_hint() could be called.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   11 +++++++----
 hw/9pfs/9p-proxy.c |   11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 6f7309f4e691..2c80d2ac30f5 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1486,8 +1486,9 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
     Error *local_err = NULL;
 
     if (!sec_model) {
-        error_setg(errp, "security_model property not set");
-        error_append_security_model_hint(errp);
+        error_setg(&local_err, "security_model property not set");
+        error_append_security_model_hint(&local_err);
+        error_propagate(errp, local_err);
         return -1;
     }
 
@@ -1501,8 +1502,10 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
     } else if (!strcmp(sec_model, "mapped-file")) {
         fse->export_flags |= V9FS_SM_MAPPED_FILE;
     } else {
-        error_setg(errp, "invalid security_model property '%s'", sec_model);
-        error_append_security_model_hint(errp);
+        error_setg(&local_err, "invalid security_model property '%s'",
+                   sec_model);
+        error_append_security_model_hint(&local_err);
+        error_propagate(errp, local_err);
         return -1;
     }
 
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 97ab9c58a573..5de5e53702f7 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -1126,15 +1126,18 @@ static int proxy_parse_opts(QemuOpts *opts, FsDriverEntry *fs, Error **errp)
 {
     const char *socket = qemu_opt_get(opts, "socket");
     const char *sock_fd = qemu_opt_get(opts, "sock_fd");
+    Error *local_err = NULL;
 
     if (!socket && !sock_fd) {
-        error_setg(errp, "both socket and sock_fd properties are missing");
-        error_append_socket_sockfd_hint(errp);
+        error_setg(&local_err, "both socket and sock_fd properties are missing");
+        error_append_socket_sockfd_hint(&local_err);
+        error_propagate(errp, local_err);
         return -1;
     }
     if (socket && sock_fd) {
-        error_setg(errp, "both socket and sock_fd properties are set");
-        error_append_socket_sockfd_hint(errp);
+        error_setg(&local_err, "both socket and sock_fd properties are set");
+        error_append_socket_sockfd_hint(&local_err);
+        error_propagate(errp, local_err);
         return -1;
     }
     if (socket) {


