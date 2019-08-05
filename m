Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8A9C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 20:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99C22086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 20:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99C22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56911 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hujoM-0000M2-7a
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 16:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57958)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1huhbW-0000zJ-VU
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1huhbV-0008Mj-Pd
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:21:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64436
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1huhbV-0008MK-LF
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:21:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x75I3UIh084859
 for <qemu-devel@nongnu.org>; Mon, 5 Aug 2019 14:21:03 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u6rh2jtxy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 14:21:03 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Mon, 5 Aug 2019 19:21:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 5 Aug 2019 19:21:00 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x75IKxoc50725070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Aug 2019 18:20:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 406BD4C044;
 Mon,  5 Aug 2019 18:20:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 274594C059;
 Mon,  5 Aug 2019 18:20:58 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.74.191])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  5 Aug 2019 18:20:57 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 23:50:30 +0530
X-Mailer: git-send-email 2.14.5
X-TM-AS-GCONF: 00
x-cbid: 19080518-0028-0000-0000-0000038BEB8A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080518-0029-0000-0000-0000244C49F5
Message-Id: <20190805182033.27578-1-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-05_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=278 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050188
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-Mailman-Approved-At: Mon, 05 Aug 2019 16:41:38 -0400
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
Cc: Balamuruhan S <bala24@linux.ibm.com>, clg@kaod.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new test for migration that bringup vm with different machine types and
migrate it, introduce new API in avocado_qemu to query all the machine
types supported by qemu.

Test run:

# avocado run migration.py
JOB ID     : ef54f57a073eb267d2347e32225f2adbe27969de
JOB LOG    : /home/bala/avocado-fvt-wrapper/results/job-2019-08-05T13.54-ef54f57/job.log
 (1/2) migration.py:Migration.test_migration_with_tcp_localhost: PASS (0.54 s)
 (2/2) migration.py:Migration.test_migration_with_machine_types: PASS (5.21 s)
RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
JOB TIME   : 5.86 s

Currently acceptance test for migration error out as we check `query-migrate`
in target after migration which is not appropriate.

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


