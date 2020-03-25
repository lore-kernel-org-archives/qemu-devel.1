Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6CEC54FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7659720409
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7659720409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7vJ-00036A-LH
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jH7uW-0001v6-WD
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jH7uV-0006xB-LU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jH7uV-0006uF-CH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:39 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PF4FUL127322
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 11:25:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywbtj3vxw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 11:25:30 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 25 Mar 2020 15:25:27 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 25 Mar 2020 15:25:25 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFPPWm54067208
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:25:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34D4511C058;
 Wed, 25 Mar 2020 15:25:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF2DE11C05C;
 Wed, 25 Mar 2020 15:25:24 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.41.106])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2020 15:25:24 +0000 (GMT)
Subject: [PATCH 0/4] spapr: Get rid of CAS reboot flag
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 25 Mar 2020 16:25:24 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032515-0028-0000-0000-000003EB4A9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032515-0029-0000-0000-000024B0B8F1
Message-Id: <158514992409.478799.6718223069768660390.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_07:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=544 lowpriorityscore=0 clxscore=1034 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250121
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CAS reboot flag was introduced in QEMU 2.10 to allow the guest
to be presented a new boot-time device tree after CAS negotiation.
CAS-generated resets rely on qemu_system_reset_request() which has
the particularity of dropping the main loop lock at some point. This
opens a window where migration can happen, hence promotting the CAS
reboot flag to actual state that we should also migrate. In practice,
this can't happen anymore since we have eliminated the scenario of
the XICS/XIVE switch and the much less frequent scenario of device
plug/unplug before CAS.

We still have much of the CAS reboot bits around though. The full FDT
rendering we do at CAS is enough to get rid of them once and far all.

Some preliminary cleanup is made before going for the full removal,
for easier reviewing. At some point I had the need to move some code
around in CAS, and Alexey's patch from the "spapr: kill SLOF" (v8)
series proved to be helpful so I've reused it in this patchset.

This series applies cleanly on both ppc-for-5.0 and ppc-for-5.1.
Since it doesn't fix any actual bug, I think this can be delayed
to 5.1.

--
Greg

---

Alexey Kardashevskiy (1):
      spapr/cas: Separate CAS handling from rebuilding the FDT

Greg Kurz (3):
      spapr: Don't check capabilities removed between CAS calls
      spapr: Simplify selection of radix/hash during CAS
      spapr: Drop CAS reboot flag


 hw/ppc/spapr.c         |   20 ++-------
 hw/ppc/spapr_hcall.c   |  108 +++++++++++++++++++++++-------------------------
 include/hw/ppc/spapr.h |    8 +++-
 3 files changed, 63 insertions(+), 73 deletions(-)


