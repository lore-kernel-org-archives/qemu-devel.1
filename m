Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A738C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D67206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D67206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nRc-0007VI-8D
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i9nPj-0005ml-Bq
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i9nPi-0002uN-7M
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:35:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i9nPh-0002pK-Vl
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:35:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8G9XPvr040020
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 05:35:13 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v26vtt76x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 05:35:13 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Mon, 16 Sep 2019 10:35:10 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 16 Sep 2019 10:35:06 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8G9Z5wr56950912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Sep 2019 09:35:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC7B4A405F;
 Mon, 16 Sep 2019 09:35:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5987BA405C;
 Mon, 16 Sep 2019 09:35:03 +0000 (GMT)
Received: from dhcp-9-120-237-81.in.ibm.com (unknown [9.120.237.81])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 16 Sep 2019 09:35:03 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:04:42 +0530
X-Mailer: git-send-email 2.14.5
X-TM-AS-GCONF: 00
x-cbid: 19091609-0016-0000-0000-000002AC8277
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091609-0017-0000-0000-0000330D1FBD
Message-Id: <20190916093445.20507-1-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=61
 priorityscore=1501
 malwarescore=0 suspectscore=6 phishscore=0 bulkscore=0 spamscore=61
 clxscore=1015 lowpriorityscore=0 mlxscore=61 impostorscore=0
 mlxlogscore=-19 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909160102
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel]  [PATCH 0/3] Add acceptance test for migration
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

Add new test for migration that bringup vm with different machine types
and migrate it, introduce new API in avocado_qemu to query all the machine
types supported by qemu.

Test run:

# avocado run migration.py
JOB ID     : ef54f57a073eb267d2347e32225f2adbe27969de
JOB LOG    : 
/home/bala/avocado-fvt-wrapper/results/job-2019-08-05T13.54-ef54f57/job.log
 (1/2) migration.py:Migration.test_migration_with_tcp_localhost: PASS
(0.54 s)
 (2/2) migration.py:Migration.test_migration_with_machine_types: PASS
(5.21 s)
RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
CANCEL 0
JOB TIME   : 5.86 s

Currently acceptance test for migration error out as we check
`query-migrate` in target after migration which is not appropriate.

Balamuruhan S (3):
  tests/acceptance/migration: fix post migration check
  tests/acceptance/avocado_qemu: add method to get supported machine
    types
  tests/acceptance/migration: test to migrate will all machine types

 tests/acceptance/avocado_qemu/__init__.py |  6 ++++++
 tests/acceptance/migration.py             | 27 ++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.14.5


