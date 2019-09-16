Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFC3C4CEC7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25209206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25209206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nRj-0007hV-TQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i9nPr-0005xc-60
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i9nPp-0002xe-P8
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:35:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i9nPp-0002xF-GT
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:35:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8G9XQwh041612
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 05:35:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v27j1rqpu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 05:35:24 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Mon, 16 Sep 2019 10:35:21 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 16 Sep 2019 10:35:18 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x8G9ZHTR36569350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Sep 2019 09:35:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FD3EA405F;
 Mon, 16 Sep 2019 09:35:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 845ABA405B;
 Mon, 16 Sep 2019 09:35:14 +0000 (GMT)
Received: from dhcp-9-120-237-81.in.ibm.com (unknown [9.120.237.81])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 16 Sep 2019 09:35:14 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:04:45 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190916093445.20507-1-bala24@linux.ibm.com>
References: <20190916093445.20507-1-bala24@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19091609-4275-0000-0000-00000366F7EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091609-4276-0000-0000-000038795955
Message-Id: <20190916093445.20507-4-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=21 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=627 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909160102
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 3/3] tests/acceptance/migration: test to
 migrate will all machine types
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
Cc: ehabkost@redhat.com, ccarrara@redhat.com, groug@kaod.org,
 Balamuruhan S <bala24@linux.ibm.com>, sathnaga@linux.vnet.ibm.com,
 clg@kaod.org, crosa@redhat.com, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

add migration test to query machine types supported by qemu binary
and migrate vm will all supported type.

Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 tests/acceptance/migration.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index 0f3553c8f0..74416ccc21 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -49,3 +49,29 @@ class Migration(Test):
         self.assertEqual(dest_vm.command('query-status')['status'], 'running')
         self.assertEqual(source_vm.command('query-status')['status'],
                          'postmigrate')
+
+
+    def test_migration_with_machine_types(self):
+        migration_port = self._get_free_port()
+        for machine in self.get_machine_types():
+            if 'pseries' in machine:
+                print("migrating with machine type - {}".format(machine))
+                source_vm = self.get_vm('-M', '{},cap-htm=off'.format(machine))
+                dest_uri = 'tcp:localhost:%u' % migration_port
+                dest_vm = self.get_vm('-M', '{},cap-htm=off'.format(machine),
+                                      '-incoming', dest_uri)
+                dest_vm.launch()
+                source_vm.launch()
+                source_vm.qmp('migrate', uri=dest_uri)
+                wait.wait_for(
+                    self.migration_finished,
+                    timeout=self.timeout,
+                    step=0.1,
+                    args=(source_vm,)
+                )
+                self.assertEqual(source_vm.command('query-migrate')['status'],
+                                                   'completed')
+                self.assertEqual(dest_vm.command('query-status')['status'],
+                                                 'running')
+                self.assertEqual(source_vm.command('query-status')['status'],
+                                                   'postmigrate')
-- 
2.14.5


