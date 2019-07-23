Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74214C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1CF2184E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1CF2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyG2-0007VL-5s
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42713)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAX-0004wW-3W
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAU-0005Mx-1P
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpyAS-0005BX-SK
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NGkgvk127106
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:01:25 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tx60rgmv9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:01:25 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Tue, 23 Jul 2019 18:01:25 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Jul 2019 18:01:22 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NH1LvS49480174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 17:01:22 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E01BBBE05D;
 Tue, 23 Jul 2019 17:01:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7BE1BE05B;
 Tue, 23 Jul 2019 17:01:21 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 17:01:21 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:00:53 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19072317-8235-0000-0000-00000EBD2AA5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011482; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01236375; UDB=6.00651638; IPR=6.01017731; 
 MB=3.00027856; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-23 17:01:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072317-8236-0000-0000-0000468424BA
Message-Id: <20190723170104.4327-26-mdroth@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=734 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230169
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 25/36] usb-mtp: use O_NOFOLLOW and O_CLOEXEC.
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
Cc: Bandan Das <bsd@redhat.com>, Prasad J Pandit <ppandit@redhat.com>,
 qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Open files and directories with O_NOFOLLOW to avoid symlinks attacks.
While being at it also add O_CLOEXEC.

usb-mtp only handles regular files and directories and ignores
everything else, so users should not see a difference.

Because qemu ignores symlinks, carrying out a successful symlink attack
requires swapping an existing file or directory below rootdir for a
symlink and winning the race against the inotify notification to qemu.

Fixes: CVE-2018-16872
Cc: Prasad J Pandit <ppandit@redhat.com>
Cc: Bandan Das <bsd@redhat.com>
Reported-by: Michael Hanselmann <public@hansmi.ch>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael Hanselmann <public@hansmi.ch>
Message-id: 20181213122511.13853-1-kraxel@redhat.com
(cherry picked from commit bab9df35ce73d1c8e19a37e2737717ea1c984dc1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/usb/dev-mtp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 100b7171f4..36c43b8c20 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -653,13 +653,18 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
 {
     struct dirent *entry;
     DIR *dir;
+    int fd;
 
     if (o->have_children) {
         return;
     }
     o->have_children = true;
 
-    dir = opendir(o->path);
+    fd = open(o->path, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW);
+    if (fd < 0) {
+        return;
+    }
+    dir = fdopendir(fd);
     if (!dir) {
         return;
     }
@@ -1007,7 +1012,7 @@ static MTPData *usb_mtp_get_object(MTPState *s, MTPControl *c,
 
     trace_usb_mtp_op_get_object(s->dev.addr, o->handle, o->path);
 
-    d->fd = open(o->path, O_RDONLY);
+    d->fd = open(o->path, O_RDONLY | O_CLOEXEC | O_NOFOLLOW);
     if (d->fd == -1) {
         usb_mtp_data_free(d);
         return NULL;
@@ -1031,7 +1036,7 @@ static MTPData *usb_mtp_get_partial_object(MTPState *s, MTPControl *c,
                                         c->argv[1], c->argv[2]);
 
     d = usb_mtp_data_alloc(c);
-    d->fd = open(o->path, O_RDONLY);
+    d->fd = open(o->path, O_RDONLY | O_CLOEXEC | O_NOFOLLOW);
     if (d->fd == -1) {
         usb_mtp_data_free(d);
         return NULL;
@@ -1658,7 +1663,7 @@ static void usb_mtp_write_data(MTPState *s)
                                  0, 0, 0, 0);
             goto done;
         }
-        d->fd = open(path, O_CREAT | O_WRONLY, mask);
+        d->fd = open(path, O_CREAT | O_WRONLY | O_CLOEXEC | O_NOFOLLOW, mask);
         if (d->fd == -1) {
             usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                  0, 0, 0, 0);
-- 
2.17.1


