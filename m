Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6FFC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CED21741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CED21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaHrr-0005V5-O6
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 06:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1iaHjd-0001Hj-3z
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:13:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1iaHXZ-00049i-7k
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:00:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1iaHXW-00042X-1s
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:00:51 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xASAtFDr105851
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 06:00:46 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wjc849ck7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 06:00:46 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Thu, 28 Nov 2019 11:00:44 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Nov 2019 11:00:40 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xASB0dO552559928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2019 11:00:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27D1A4C05A;
 Thu, 28 Nov 2019 11:00:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B64434C059;
 Thu, 28 Nov 2019 11:00:38 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.185.119])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 28 Nov 2019 11:00:38 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: qemu-s390x@nongnu.org
Subject: [PATCH v2 0/1] s390x: css: pong, channel subsystem test device
Date: Thu, 28 Nov 2019 12:00:36 +0100
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19112811-0016-0000-0000-000002CD5AE5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112811-0017-0000-0000-0000332F3F53
Message-Id: <1574938837-21078-1-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=1 mlxlogscore=982 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280095
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series presents a device to test the channel subsystem.

Currently it only does the following:
- answer to WRITE requests by incrementing an integer stored as
  string in the data of a PONG_WRITE CCW command.
- send back the same buffer, with the incremented integer when
  receiving a PONG_READ CCW command.
- defines a Control Unit property.


Pierre Morel (1):
  s390x: css: pong, channel subsystem test device

 default-configs/s390x-softmmu.mak |   1 +
 hw/s390x/Kconfig                  |   3 +
 hw/s390x/Makefile.objs            |   1 +
 hw/s390x/ccw-pong.c               | 134 ++++++++++++++++++++++++++++++
 include/hw/s390x/pong.h           |  48 +++++++++++
 5 files changed, 187 insertions(+)
 create mode 100644 hw/s390x/ccw-pong.c
 create mode 100644 include/hw/s390x/pong.h

-- 
2.17.0

Changelog:
- use ccw_dstream_xxx_buf (Connie)
- adding a cu_type property
- testing the ccw.count
- conditional compiling for TEST_DEVICES (Connie, Thomas)
- suppress the device categorie (Connie ?)
- adding write callback and some funny protocol


