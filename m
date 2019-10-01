Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBF2C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D402520818
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D402520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSkh-0005uJ-El
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsB-0001Zn-I0
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRs9-00024Q-DV
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38002
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRs7-0001TS-2O; Tue, 01 Oct 2019 19:48:00 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlPAx179362; Tue, 1 Oct 2019 19:47:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpnctr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:35 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlZpg179670;
 Tue, 1 Oct 2019 19:47:35 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpnctf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:35 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlTB023573;
 Tue, 1 Oct 2019 23:47:34 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma05wdc.us.ibm.com with ESMTP id 2v9y577gya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:34 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlYtw5767716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:34 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52E142805E;
 Tue,  1 Oct 2019 23:47:34 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DCDA28058;
 Tue,  1 Oct 2019 23:47:34 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:34 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 41/97] docs/bitmaps: use QMP lexer instead of json
Date: Tue,  1 Oct 2019 18:45:20 -0500
Message-Id: <20191001234616.7825-42-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
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
Cc: John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

The annotated style json we use in QMP documentation is not strict json
and depending on the version of Sphinx (2.0+) or Pygments installed,
might cause the build to fail.

Use the new QMP lexer.

Further, some versions of Sphinx can not apply custom lexers to "code"
directives and require the use of "code-block" directives instead, so
make that change at this time as well.

Tested under:
- Sphinx 1.3.6 and Pygments 2.4
- Sphinx 1.7.6 and Pygments 2.2 (Fedora 29 packages)
- Sphinx 2.0.1 and Pygments 2.4
- Sphinx 3.0.0+/f396b3a783 and Pygments 2.4 (From Sphinx git c4f44bdd)

Reported-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-id: 20190603214653.29369-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit a7786bfb0effe0b4b0fc61d8a8cd307c0b739ed7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 docs/interop/bitmaps.rst | 54 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/docs/interop/bitmaps.rst b/docs/interop/bitmaps.rst
index c29ac4a854..c20bd37a79 100644
--- a/docs/interop/bitmaps.rst
+++ b/docs/interop/bitmaps.rst
@@ -199,7 +199,7 @@ persistence, and recording state can be adjusted at creation time.
 
  to create a new, actively recording persistent bitmap:
 
- .. code:: json
+ .. code-block:: QMP
 
   -> { "execute": "block-dirty-bitmap-add",
        "arguments": {
@@ -220,7 +220,7 @@ persistence, and recording state can be adjusted at creation time.
  To create a new, disabled (``-recording``), transient bitmap that tracks
  changes in 32KiB segments:
 
- .. code:: json
+ .. code-block:: QMP
 
   -> { "execute": "block-dirty-bitmap-add",
        "arguments": {
@@ -254,7 +254,7 @@ Deletes a bitmap. Bitmaps that are ``+busy`` cannot be removed.
 
  Remove a bitmap named ``bitmap0`` from node ``drive0``:
 
- .. code:: json
+ .. code-block:: QMP
 
   -> { "execute": "block-dirty-bitmap-remove",
        "arguments": {
@@ -280,7 +280,7 @@ Clears all dirty bits from a bitmap. ``+busy`` bitmaps cannot be cleared.
 
  Clear all dirty bits from bitmap ``bitmap0`` on node ``drive0``:
 
- .. code:: json
+ .. code-block:: QMP
 
   -> { "execute": "block-dirty-bitmap-clear",
        "arguments": {
@@ -309,7 +309,7 @@ begin being recorded. ``+busy`` bitmaps cannot be enabled.
 
  To set ``+recording`` on bitmap ``bitmap0`` on node ``drive0``:
 
- .. code:: json
+ .. code-block:: QMP
 
   -> { "execute": "block-dirty-bitmap-enable",
        "arguments": {
@@ -347,7 +347,7 @@ writes to begin being ignored. ``+busy`` bitmaps cannot be disabled.
 
  To set ``-recording`` on bitmap ``bitmap0`` on node ``drive0``:
 
- .. code:: json
+ .. code-block:: QMP
 
   -> { "execute": "block-dirty-bitmap-disable",
        "arguments": {
@@ -393,7 +393,7 @@ in any one source bitmap, the target bitmap will mark that segment dirty.
  ``drive0``. If ``new_bitmap`` was empty prior to this command, this achieves
  a copy.
 
- .. code:: json
+ .. code-block:: QMP
 
   -> { "execute": "block-dirty-bitmap-merge",
        "arguments": {
@@ -424,7 +424,7 @@ attached to nodes serving as the root for guest devices.
  API. This result highlights a bitmap ``bitmap0`` attached to the root node of
  device ``drive0``.
 
- .. code:: json
+ .. code-block:: QMP
 
   -> {
        "execute": "query-block",
@@ -562,7 +562,7 @@ new, empty bitmap that records writes from this point in time forward.
           destination. These writes will be recorded in the bitmap
           accordingly.
 
-.. code:: json
+.. code-block:: QMP
 
   -> {
        "execute": "transaction",
@@ -650,7 +650,7 @@ Example: Resetting an Incremental Backup Anchor Point
 If we want to start a new backup chain with an existing bitmap, we can also
 use a transaction to reset the bitmap while making a new full backup:
 
-.. code:: json
+.. code-block:: QMP
 
   -> {
        "execute": "transaction",
@@ -730,7 +730,7 @@ Example: First Incremental Backup
 
 #. Issue an incremental backup command:
 
-   .. code:: json
+   .. code-block:: QMP
 
     -> {
          "execute": "drive-backup",
@@ -788,7 +788,7 @@ Example: Second Incremental Backup
 #. Issue a new incremental backup command. The only difference here is that we
    have changed the target image below.
 
-   .. code:: json
+   .. code-block:: QMP
 
     -> {
          "execute": "drive-backup",
@@ -869,7 +869,7 @@ image:
 #. Issue a new incremental backup command. Apart from the new destination
    image, there is no difference from the last two examples.
 
-   .. code:: json
+   .. code-block:: QMP
 
     -> {
          "execute": "drive-backup",
@@ -932,7 +932,7 @@ point in time.
 
 #. Create a full (anchor) backup for each drive, with accompanying bitmaps:
 
-   .. code:: json
+   .. code-block:: QMP
 
     -> {
          "execute": "transaction",
@@ -1018,7 +1018,7 @@ point in time.
 
 #. Issue a multi-drive incremental push backup transaction:
 
-   .. code:: json
+   .. code-block:: QMP
 
     -> {
          "execute": "transaction",
@@ -1121,7 +1121,7 @@ described above. This example demonstrates the single-job failure case:
 
 #. Attempt to create an incremental backup via QMP:
 
-   .. code:: json
+   .. code-block:: QMP
 
     -> {
          "execute": "drive-backup",
@@ -1139,7 +1139,7 @@ described above. This example demonstrates the single-job failure case:
 
 #. Receive a pair of events indicating failure:
 
-   .. code:: json
+   .. code-block:: QMP
 
     <- {
          "timestamp": {...},
@@ -1175,7 +1175,7 @@ described above. This example demonstrates the single-job failure case:
 #. Retry the command after fixing the underlying problem, such as
    freeing up space on the backup volume:
 
-   .. code:: json
+   .. code-block:: QMP
 
     -> {
          "execute": "drive-backup",
@@ -1193,7 +1193,7 @@ described above. This example demonstrates the single-job failure case:
 
 #. Receive confirmation that the job completed successfully:
 
-   .. code:: json
+   .. code-block:: QMP
 
     <- {
          "timestamp": {...},
@@ -1233,7 +1233,7 @@ and one succeeds:
 
 #. Issue the transaction to start a backup of both drives.
 
-   .. code:: json
+   .. code-block:: QMP
 
     -> {
          "execute": "transaction",
@@ -1267,13 +1267,13 @@ and one succeeds:
 #. Receive notice that the Transaction was accepted, and jobs were
    launched:
 
-   .. code:: json
+   .. code-block:: QMP
 
     <- { "return": {} }
 
 #. Receive notice that the first job has completed:
 
-   .. code:: json
+   .. code-block:: QMP
 
     <- {
          "timestamp": {...},
@@ -1289,7 +1289,7 @@ and one succeeds:
 
 #. Receive notice that the second job has failed:
 
-   .. code:: json
+   .. code-block:: QMP
 
     <- {
          "timestamp": {...},
@@ -1365,7 +1365,7 @@ applied:
 
 #. Issue the multi-drive incremental backup transaction:
 
-   .. code:: json
+   .. code-block:: QMP
 
     -> {
          "execute": "transaction",
@@ -1401,13 +1401,13 @@ applied:
 
 #. Receive notice that the Transaction was accepted, and jobs were launched:
 
-   .. code:: json
+   .. code-block:: QMP
 
     <- { "return": {} }
 
 #. Receive notification that the backup job for ``drive1`` has failed:
 
-   .. code:: json
+   .. code-block:: QMP
 
     <- {
          "timestamp": {...},
@@ -1434,7 +1434,7 @@ applied:
 
 #. Receive notification that the job for ``drive0`` has been cancelled:
 
-   .. code:: json
+   .. code-block:: QMP
 
     <- {
          "timestamp": {...},
-- 
2.17.1


