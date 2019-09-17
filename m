Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A6AC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCBB214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCBB214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAn8-0008Ew-56
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iAAcf-0007lD-4K
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iAAca-00046H-Hb
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:22:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iAAca-00045Q-9J
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:22:08 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8HAHDas178933
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:22:06 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v0uutuqf6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:22:05 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 17 Sep 2019 11:22:02 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 17 Sep 2019 11:21:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x8HALSI233489272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2019 10:21:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C55FAE053;
 Tue, 17 Sep 2019 10:21:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54584AE04D;
 Tue, 17 Sep 2019 10:21:53 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.22.84])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 17 Sep 2019 10:21:53 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 12:21:53 +0200
In-Reply-To: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091710-0020-0000-0000-0000036E12C2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091710-0021-0000-0000-000021C3B66F
Message-Id: <156871571297.196432.545961868971946073.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=781 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170106
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 13/17] nbd: Pass local error object pointer to
 error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P. =?utf-8?q?Berrang=C3=A9=22?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org"@d06av26.portsmouth.uk.ibm.com,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ensure that hints are added even if errp is &error_fatal or &error_abort.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 nbd/client.c |   24 +++++++++++++-----------
 nbd/server.c |    7 +++++--
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index b9dc829175f9..c6e6e4046fd5 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -154,6 +154,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
                                 bool strict, Error **errp)
 {
     g_autofree char *msg = NULL;
+    Error *local_err = NULL;
 
     if (!(reply->type & (1 << 31))) {
         return 1;
@@ -161,14 +162,14 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
 
     if (reply->length) {
         if (reply->length > NBD_MAX_BUFFER_SIZE) {
-            error_setg(errp, "server error %" PRIu32
+            error_setg(&local_err, "server error %" PRIu32
                        " (%s) message is too long",
                        reply->type, nbd_rep_lookup(reply->type));
             goto err;
         }
         msg = g_malloc(reply->length + 1);
         if (nbd_read(ioc, msg, reply->length, NULL, errp) < 0) {
-            error_prepend(errp, "Failed to read option error %" PRIu32
+            error_prepend(&local_err, "Failed to read option error %" PRIu32
                           " (%s) message: ",
                           reply->type, nbd_rep_lookup(reply->type));
             goto err;
@@ -187,50 +188,51 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
 
     switch (reply->type) {
     case NBD_REP_ERR_POLICY:
-        error_setg(errp, "Denied by server for option %" PRIu32 " (%s)",
+        error_setg(&local_err, "Denied by server for option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_INVALID:
-        error_setg(errp, "Invalid parameters for option %" PRIu32 " (%s)",
+        error_setg(&local_err, "Invalid parameters for option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_PLATFORM:
-        error_setg(errp, "Server lacks support for option %" PRIu32 " (%s)",
+        error_setg(&local_err, "Server lacks support for option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_TLS_REQD:
-        error_setg(errp, "TLS negotiation required before option %" PRIu32
+        error_setg(&local_err, "TLS negotiation required before option %" PRIu32
                    " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_UNKNOWN:
-        error_setg(errp, "Requested export not available");
+        error_setg(&local_err, "Requested export not available");
         break;
 
     case NBD_REP_ERR_SHUTDOWN:
-        error_setg(errp, "Server shutting down before option %" PRIu32 " (%s)",
+        error_setg(&local_err, "Server shutting down before option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
         break;
 
     case NBD_REP_ERR_BLOCK_SIZE_REQD:
-        error_setg(errp, "Server requires INFO_BLOCK_SIZE for option %" PRIu32
+        error_setg(&local_err, "Server requires INFO_BLOCK_SIZE for option %" PRIu32
                    " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;
 
     default:
-        error_setg(errp, "Unknown error code when asking for option %" PRIu32
+        error_setg(&local_err, "Unknown error code when asking for option %" PRIu32
                    " (%s)", reply->option, nbd_opt_lookup(reply->option));
         break;
     }
 
     if (msg) {
-        error_append_hint(errp, "server reported: %s\n", msg);
+        error_append_hint(&local_err, "server reported: %s\n", msg);
     }
 
  err:
+    error_propagate(errp, local_err);
     nbd_send_opt_abort(ioc);
     return -1;
 }
diff --git a/nbd/server.c b/nbd/server.c
index 28c3c8be854c..6d9ca2563cce 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1616,6 +1616,8 @@ void nbd_export_close(NBDExport *exp)
 
 void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp)
 {
+    Error *local_err = NULL;
+
     if (mode == NBD_SERVER_REMOVE_MODE_HARD || QTAILQ_EMPTY(&exp->clients)) {
         nbd_export_close(exp);
         return;
@@ -1623,8 +1625,9 @@ void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp)
 
     assert(mode == NBD_SERVER_REMOVE_MODE_SAFE);
 
-    error_setg(errp, "export '%s' still in use", exp->name);
-    error_append_hint(errp, "Use mode='hard' to force client disconnect\n");
+    error_setg(&local_err, "export '%s' still in use", exp->name);
+    error_append_hint(&local_err, "Use mode='hard' to force client disconnect\n");
+    error_propagate(errp, local_err);
 }
 
 void nbd_export_get(NBDExport *exp)


