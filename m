Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5699C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B0F2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B0F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS61a-00077I-IL
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5p6-0000SU-NN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5p4-00020P-VH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5p4-0001zd-M5; Tue, 05 Nov 2019 15:53:06 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpZMD027593; Tue, 5 Nov 2019 15:53:05 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3g6dgk8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:05 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5KpqEP028586;
 Tue, 5 Nov 2019 15:53:04 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3g6dgk7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:04 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnwPe017465;
 Tue, 5 Nov 2019 20:53:03 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma05wdc.us.ibm.com with ESMTP id 2w11e7185s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:03 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5Kr3WN48562638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:03 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF15012405C;
 Tue,  5 Nov 2019 20:53:02 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBC1112405B;
 Tue,  5 Nov 2019 20:53:02 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:02 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/55] curl: Handle success in multi_check_completion
Date: Tue,  5 Nov 2019 14:52:16 -0600
Message-Id: <20191105205243.3766-29-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
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
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Background: As of cURL 7.59.0, it verifies that several functions are
not called from within a callback.  Among these functions is
curl_multi_add_handle().

curl_read_cb() is a callback from cURL and not a coroutine.  Waking up
acb->co will lead to entering it then and there, which means the current
request will settle and the caller (if it runs in the same coroutine)
may then issue the next request.  In such a case, we will enter
curl_setup_preadv() effectively from within curl_read_cb().

Calling curl_multi_add_handle() will then fail and the new request will
not be processed.

Fix this by not letting curl_read_cb() wake up acb->co.  Instead, leave
the whole business of settling the AIOCB objects to
curl_multi_check_completion() (which is called from our timer callback
and our FD handler, so not from any cURL callbacks).

Reported-by: Natalie Gavrielov <ngavrilo@redhat.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1740193
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190910124136.10565-7-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit bfb23b480a49114315877aacf700b49453e0f9d9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/curl.c | 69 ++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index fd70f1ebc4..c343c7ed3d 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -229,7 +229,6 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 {
     CURLState *s = ((CURLState*)opaque);
     size_t realsize = size * nmemb;
-    int i;
 
     trace_curl_read_cb(realsize);
 
@@ -245,32 +244,6 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
     memcpy(s->orig_buf + s->buf_off, ptr, realsize);
     s->buf_off += realsize;
 
-    for(i=0; i<CURL_NUM_ACB; i++) {
-        CURLAIOCB *acb = s->acb[i];
-
-        if (!acb)
-            continue;
-
-        if ((s->buf_off >= acb->end)) {
-            size_t request_length = acb->bytes;
-
-            qemu_iovec_from_buf(acb->qiov, 0, s->orig_buf + acb->start,
-                                acb->end - acb->start);
-
-            if (acb->end - acb->start < request_length) {
-                size_t offset = acb->end - acb->start;
-                qemu_iovec_memset(acb->qiov, offset, 0,
-                                  request_length - offset);
-            }
-
-            acb->ret = 0;
-            s->acb[i] = NULL;
-            qemu_mutex_unlock(&s->s->mutex);
-            aio_co_wake(acb->co);
-            qemu_mutex_lock(&s->s->mutex);
-        }
-    }
-
 read_end:
     /* curl will error out if we do not return this value */
     return size * nmemb;
@@ -351,13 +324,14 @@ static void curl_multi_check_completion(BDRVCURLState *s)
             break;
 
         if (msg->msg == CURLMSG_DONE) {
+            int i;
             CURLState *state = NULL;
+            bool error = msg->data.result != CURLE_OK;
+
             curl_easy_getinfo(msg->easy_handle, CURLINFO_PRIVATE,
                               (char **)&state);
 
-            /* ACBs for successful messages get completed in curl_read_cb */
-            if (msg->data.result != CURLE_OK) {
-                int i;
+            if (error) {
                 static int errcount = 100;
 
                 /* Don't lose the original error message from curl, since
@@ -369,20 +343,35 @@ static void curl_multi_check_completion(BDRVCURLState *s)
                         error_report("curl: further errors suppressed");
                     }
                 }
+            }
 
-                for (i = 0; i < CURL_NUM_ACB; i++) {
-                    CURLAIOCB *acb = state->acb[i];
+            for (i = 0; i < CURL_NUM_ACB; i++) {
+                CURLAIOCB *acb = state->acb[i];
 
-                    if (acb == NULL) {
-                        continue;
-                    }
+                if (acb == NULL) {
+                    continue;
+                }
+
+                if (!error) {
+                    /* Assert that we have read all data */
+                    assert(state->buf_off >= acb->end);
+
+                    qemu_iovec_from_buf(acb->qiov, 0,
+                                        state->orig_buf + acb->start,
+                                        acb->end - acb->start);
 
-                    acb->ret = -EIO;
-                    state->acb[i] = NULL;
-                    qemu_mutex_unlock(&s->mutex);
-                    aio_co_wake(acb->co);
-                    qemu_mutex_lock(&s->mutex);
+                    if (acb->end - acb->start < acb->bytes) {
+                        size_t offset = acb->end - acb->start;
+                        qemu_iovec_memset(acb->qiov, offset, 0,
+                                          acb->bytes - offset);
+                    }
                 }
+
+                acb->ret = error ? -EIO : 0;
+                state->acb[i] = NULL;
+                qemu_mutex_unlock(&s->mutex);
+                aio_co_wake(acb->co);
+                qemu_mutex_lock(&s->mutex);
             }
 
             curl_clean_state(state);
-- 
2.17.1


