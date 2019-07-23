Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF87C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E70223A0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E70223A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyFZ-0005ZE-G1
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42840)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAe-0005NW-J9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAd-0005Vd-49
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpyAc-0005BB-R4; Tue, 23 Jul 2019 13:01:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NGkhL3053226; Tue, 23 Jul 2019 13:01:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tx60v8mw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 13:01:25 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6NGlvev056531;
 Tue, 23 Jul 2019 13:01:24 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tx60v8mvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 13:01:24 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6NH0K34000806;
 Tue, 23 Jul 2019 17:01:23 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma03dal.us.ibm.com with ESMTP id 2tx61n02ja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 17:01:23 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NH1McP21561630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 17:01:22 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B00CBE056;
 Tue, 23 Jul 2019 17:01:22 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BC03BE053;
 Tue, 23 Jul 2019 17:01:22 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 17:01:22 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:00:54 -0500
Message-Id: <20190723170104.4327-27-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230169
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x6NGkhL3053226
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 26/36] qemu-img: fix error reporting for -object
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Error reporting for user_creatable_add_opts_foreach was changed so that
it no longer called 'error_report_err' in:

  commit 7e1e0c11127bde81cff260fc6859690435c509d6
  Author: Markus Armbruster <armbru@redhat.com>
  Date:   Wed Oct 17 10:26:43 2018 +0200

    qom: Clean up error reporting in user_creatable_add_opts_foreach()

Some callers were updated to pass in "&error_fatal" but all the ones in
qemu-img were left passing NULL. As a result all errors went to
/dev/null instead of being reported to the user.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 334c43e2c342e878311c66b4e62343f0a7c2c6be)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-img.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ad04f59565..8b4a371ed5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -503,7 +503,7 @@ static int img_create(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         goto fail;
     }
=20
@@ -753,7 +753,7 @@ static int img_check(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -966,7 +966,7 @@ static int img_commit(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -1349,7 +1349,7 @@ static int img_compare(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         ret =3D 2;
         goto out4;
     }
@@ -2159,7 +2159,7 @@ static int img_convert(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         goto fail_getopt;
     }
=20
@@ -2713,7 +2713,7 @@ static int img_info(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -2932,7 +2932,7 @@ static int img_map(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -3081,7 +3081,7 @@ static int img_snapshot(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -3241,7 +3241,7 @@ static int img_rebase(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -3621,7 +3621,7 @@ static int img_resize(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         return 1;
     }
=20
@@ -3865,7 +3865,7 @@ static int img_amend(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         ret =3D -1;
         goto out_no_progress;
     }
@@ -4509,7 +4509,7 @@ static int img_dd(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         ret =3D -1;
         goto out;
     }
@@ -4786,7 +4786,7 @@ static int img_measure(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
+                          NULL, &error_fatal)) {
         goto out;
     }
=20
--=20
2.17.1


