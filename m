Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44A6C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8669E20850
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8669E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmiC-0006gh-Q7
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46336)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbmRh-0001dy-H9
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbmRg-0005sk-2n
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbmRW-0005jF-IK; Fri, 14 Jun 2019 09:40:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E9782F8BD2;
 Fri, 14 Jun 2019 13:40:29 +0000 (UTC)
Received: from localhost (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B25439C3;
 Fri, 14 Jun 2019 13:40:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 14 Jun 2019 15:40:03 +0200
Message-Id: <20190614134021.32486-3-mreitz@redhat.com>
In-Reply-To: <20190614134021.32486-1-mreitz@redhat.com>
References: <20190614134021.32486-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 14 Jun 2019 13:40:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/20] iotests.py: do not use infinite waits
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Cap waits to 60 seconds so that iotests can fail gracefully if something
goes wrong.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20190523170643.20794-3-jsnow@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index f11482f3dc..6a3703e6ee 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -524,7 +524,7 @@ class VM(qtest.QEMUQtestMachine):
             output_list +=3D [key + '=3D' + obj[key]]
         return ','.join(output_list)
=20
-    def get_qmp_events_filtered(self, wait=3DTrue):
+    def get_qmp_events_filtered(self, wait=3D60.0):
         result =3D []
         for ev in self.get_qmp_events(wait=3Dwait):
             result.append(filter_qmp_event(ev))
@@ -542,10 +542,10 @@ class VM(qtest.QEMUQtestMachine):
=20
     # Returns None on success, and an error string on failure
     def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse,
-                pre_finalize=3DNone):
+                pre_finalize=3DNone, wait=3D60.0):
         error =3D None
         while True:
-            for ev in self.get_qmp_events_filtered(wait=3DTrue):
+            for ev in self.get_qmp_events_filtered(wait=3Dwait):
                 if ev['event'] =3D=3D 'JOB_STATUS_CHANGE':
                     status =3D ev['data']['status']
                     if status =3D=3D 'aborting':
@@ -650,7 +650,7 @@ class QMPTestCase(unittest.TestCase):
         self.assertEqual(self.vm.flatten_qmp_object(json.loads(json_file=
name[5:])),
                          self.vm.flatten_qmp_object(reference))
=20
-    def cancel_and_wait(self, drive=3D'drive0', force=3DFalse, resume=3D=
False):
+    def cancel_and_wait(self, drive=3D'drive0', force=3DFalse, resume=3D=
False, wait=3D60.0):
         '''Cancel a block job and wait for it to finish, returning the e=
vent'''
         result =3D self.vm.qmp('block-job-cancel', device=3Ddrive, force=
=3Dforce)
         self.assert_qmp(result, 'return', {})
@@ -661,7 +661,7 @@ class QMPTestCase(unittest.TestCase):
         cancelled =3D False
         result =3D None
         while not cancelled:
-            for event in self.vm.get_qmp_events(wait=3DTrue):
+            for event in self.vm.get_qmp_events(wait=3Dwait):
                 if event['event'] =3D=3D 'BLOCK_JOB_COMPLETED' or \
                    event['event'] =3D=3D 'BLOCK_JOB_CANCELLED':
                     self.assert_qmp(event, 'data/device', drive)
@@ -674,10 +674,10 @@ class QMPTestCase(unittest.TestCase):
         self.assert_no_active_block_jobs()
         return result
=20
-    def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue=
):
+    def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue=
, wait=3D60.0):
         '''Wait for a block job to finish, returning the event'''
         while True:
-            for event in self.vm.get_qmp_events(wait=3DTrue):
+            for event in self.vm.get_qmp_events(wait=3Dwait):
                 if event['event'] =3D=3D 'BLOCK_JOB_COMPLETED':
                     self.assert_qmp(event, 'data/device', drive)
                     self.assert_qmp_absent(event, 'data/error')
--=20
2.21.0


