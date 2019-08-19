Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1986C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 08:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919732082C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 08:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919732082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzd2P-0002wN-Ov
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 04:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sathnaga@linux.vnet.ibm.com>) id 1hzd1O-0002Dm-0k
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sathnaga@linux.vnet.ibm.com>) id 1hzd1M-00080D-Ln
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:28:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14358
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sathnaga@linux.vnet.ibm.com>)
 id 1hzd1M-0007yV-GY
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:28:08 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7J8RFtk097009
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 04:28:06 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ufn61ew3x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 04:28:05 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sathnaga@linux.vnet.ibm.com>;
 Mon, 19 Aug 2019 09:28:03 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 19 Aug 2019 09:28:00 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x7J8RxCN40436114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Aug 2019 08:28:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2AD8A405C;
 Mon, 19 Aug 2019 08:27:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25F62A4054;
 Mon, 19 Aug 2019 08:27:58 +0000 (GMT)
Received: from sathnaga86.in.ibm.com (unknown [9.193.110.61])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 19 Aug 2019 08:27:57 +0000 (GMT)
From: sathnaga@linux.vnet.ibm.com
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 13:57:50 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19081908-0012-0000-0000-00000340476C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081908-0013-0000-0000-0000217A6663
Message-Id: <20190819082750.14748-1-sathnaga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-19_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=679 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190098
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH V2 0/2] Add support for powerpc acceptance test
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
Cc: ehabkost@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 crosa@redhat.com, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

This series attempt to add support for avocado acceptance
test for powerpc and adds linux console boot test.

avocado run boot_linux_console.py:BootLinuxConsole.test_ppc64le_pseries version.py vnc.py
JOB ID     : ec1e09d8259bc0c79eacdb4353df6223be369b84
JOB LOG    : /home/sath/tests/results/job-2019-08-19T02.33-ec1e09d/job.log
 (1/6) boot_linux_console.py:BootLinuxConsole.test_ppc64le_pseries: PASS (4.52 s)
 (2/6) version.py:Version.test_qmp_human_info_version: PASS (0.15 s)
 (3/6) vnc.py:Vnc.test_no_vnc: PASS (0.13 s)
 (4/6) vnc.py:Vnc.test_no_vnc_change_password: PASS (0.14 s)
 (5/6) vnc.py:Vnc.test_vnc_change_password_requires_a_password: PASS (0.15 s)
 (6/6) vnc.py:Vnc.test_vnc_change_password: PASS (0.14 s)
RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
JOB TIME   : 6.14 s


Changes since V1:
Review comments incorporated.
patch1: commit msg change, extra space remove suggested by Greg.

Satheesh Rajendran (2):
  tests.acceptance.avocado_qemu: Add support for powerpc
  tests.acceptance.boot_linux_console: Add pseries linux boot console
    test

 tests/acceptance/avocado_qemu/__init__.py |  3 +++
 tests/acceptance/boot_linux_console.py    | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

-- 
2.21.0


