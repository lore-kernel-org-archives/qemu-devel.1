Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D84BC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DAB214C6
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DAB214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nRi-0007fH-An
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i9nPn-0005o3-0D
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i9nPl-0002vw-RS
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:35:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i9nPl-0002vd-IS
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:35:21 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8G9XNpL072005
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 05:35:20 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v27p2rfpj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 05:35:20 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Mon, 16 Sep 2019 10:35:18 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 16 Sep 2019 10:35:14 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8G9ZDKA58458216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Sep 2019 09:35:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 476B9A4060;
 Mon, 16 Sep 2019 09:35:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEDFDA405F;
 Mon, 16 Sep 2019 09:35:10 +0000 (GMT)
Received: from dhcp-9-120-237-81.in.ibm.com (unknown [9.120.237.81])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 16 Sep 2019 09:35:10 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:04:44 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190916093445.20507-1-bala24@linux.ibm.com>
References: <20190916093445.20507-1-bala24@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19091609-0028-0000-0000-0000039D7E0B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091609-0029-0000-0000-0000245FF237
Message-Id: <20190916093445.20507-3-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=6 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=439 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909160102
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 2/3] tests/acceptance/avocado_qemu: add method
 to get supported machine types
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

add `get_machine_types()` to return list of supported machine types
by the qemu binary.

Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index bd41e0443c..42a1b572bd 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -85,6 +85,12 @@ class Test(avocado.Test):
             self._vms[name] = self._new_vm(*args)
         return self._vms[name]
 
+    def get_machine_types(self):
+        cmd = "%s -machine ?" % self.qemu_bin
+        output = avocado.utils.process.getoutput(cmd).split("\n")
+        output.remove("Supported machines are:")
+        return [each.split()[0] for each in output]
+
     def tearDown(self):
         for vm in self._vms.values():
             vm.shutdown()
-- 
2.14.5


