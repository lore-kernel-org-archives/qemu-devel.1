Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338DAC76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030D52239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030D52239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyEy-0003Ul-IC
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAI-00044M-GH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAF-00059V-UV
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40358
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpyAF-00058m-Nz; Tue, 23 Jul 2019 13:01:23 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NGkiM9009118; Tue, 23 Jul 2019 13:01:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tx61fgh5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 13:01:22 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6NGl1k1009931;
 Tue, 23 Jul 2019 13:01:22 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tx61fgh4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 13:01:22 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6NH0KS7012875;
 Tue, 23 Jul 2019 17:01:20 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 2tx61n02fw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 17:01:20 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NH1J7f45810162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 17:01:19 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E3FCBE069;
 Tue, 23 Jul 2019 17:01:19 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0ECEBBE053;
 Tue, 23 Jul 2019 17:01:19 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 17:01:19 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:00:47 -0500
Message-Id: <20190723170104.4327-20-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230169
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 19/36] json: Fix % handling when not
 interpolating
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
Cc: qemu-stable@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christophe Fergeau <cfergeau@redhat.com>

Commit 8bca4613 added support for %% in json strings when interpolating,
but in doing so broke handling of % when not interpolating.

When parse_string() is fed a string token containing '%', it skips the
'%' regardless of ctxt->ap, i.e. even it's not interpolating.  If the
'%' is the string's last character, it fails an assertion.  Else, it
"merely" swallows the '%'.

Fix parse_string() to handle '%' specially only when interpolating.

To gauge the bug's impact, let's review non-interpolating users of this
parser, i.e. code passing NULL context to json_message_parser_init():

* tests/check-qjson.c, tests/test-qobject-input-visitor.c,
  tests/test-visitor-serialization.c

  Plenty of tests, but we still failed to cover the buggy case.

* monitor.c: QMP input

* qga/main.c: QGA input

* qobject_from_json():

  - qobject-input-visitor.c: JSON command line option arguments of
    -display and -blockdev

    Reproducer: -blockdev '{"%"}'

  - block.c: JSON pseudo-filenames starting with "json:"

    Reproducer: https://bugzilla.redhat.com/show_bug.cgi?id=1668244#c3

  - block/rbd.c: JSON key pairs

    Pseudo-filenames starting with "rbd:".

Command line, QMP and QGA input are trusted.

Filenames are trusted when they come from command line, QMP or HMP.
They are untrusted when they come from from image file headers.
Example: QCOW2 backing file name.  Note that this is *not* the security
boundary between host and guest.  It's the boundary between host and an
image file from an untrusted source.

Neither failing an assertion nor skipping a character in a filename of
your choice looks exploitable.  Note that we don't support compiling
with NDEBUG.

Fixes: 8bca4613e6cddd948895b8db3def05950463495b
Cc: qemu-stable@nongnu.org
Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
Message-Id: <20190102140535.11512-1-cfergeau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
[Commit message extended to discuss impact]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
(cherry picked from commit bbc0586ced6e9ffdfd29d89fcc917b3d90ac3938)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qobject/json-parser.c | 10 ++++++----
 tests/check-qjson.c   |  5 +++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 5a840dfd86..53e91cb16b 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -208,11 +208,13 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
             }
             break;
         case '%':
-            if (ctxt->ap && ptr[1] != '%') {
-                parse_error(ctxt, token, "can't interpolate into string");
-                goto out;
+            if (ctxt->ap) {
+                if (ptr[1] != '%') {
+                    parse_error(ctxt, token, "can't interpolate into string");
+                    goto out;
+                }
+                ptr++;
             }
-            ptr++;
             /* fall through */
         default:
             cp = mod_utf8_codepoint(ptr, 6, &end);
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index d876a7a96e..fa2afccb0a 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -175,6 +175,11 @@ static void utf8_string(void)
             "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5",
             "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5",
             "\\u03BA\\u1F79\\u03C3\\u03BC\\u03B5",
+        },
+            /* '%' character when not interpolating */
+        {
+            "100%",
+            "100%",
         },
         /* 2  Boundary condition test cases */
         /* 2.1  First possible sequence of a certain length */
-- 
2.17.1


