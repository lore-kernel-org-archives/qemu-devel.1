Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FE0C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 11:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D52C208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 11:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D52C208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbkK9-0000n3-I9
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 07:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35833)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hbkCc-0002RE-4v
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hbk4n-0002hy-Q8
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:08:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hbk4n-0002fq-Eg
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:08:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5EB75rM116721
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 07:08:49 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t48mamnse-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 07:08:49 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 14 Jun 2019 12:08:47 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Jun 2019 12:08:45 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5EB8iV650200754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2019 11:08:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC1F352051;
 Fri, 14 Jun 2019 11:08:44 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.152.28])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 94C975204F;
 Fri, 14 Jun 2019 11:08:44 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Jun 2019 13:08:44 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061411-4275-0000-0000-000003424A0E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061411-4276-0000-0000-000038526738
Message-Id: <156051052402.224162.13664250996245267046.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-14_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=663 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140093
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 0/7] ppc: Get rid of some CONFIG_KVM guards
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are several places where CONFIG_KVM is used to guard code that
should only be built when KVM is supported. It is generally preferable
to avoid that and leave such guards in header files for improved
readability.

In many cases, the execution of the code is also conditionned by
kvm_enabled() which expands to (0) when CONFIG_KVM is not defined.
This is likely to cause the compiler to optimize the code out,
and if it doesn't, the right way to address compiling issues is
to add stubs.

Successfuly compile tested on x86_64 and ppc64le linux. Travis shows
this builds fine on OSX as well.

--
Greg

---

Greg Kurz (7):
      spapr_pci: Drop useless CONFIG_KVM ifdefery
      hw/ppc/mac_oldworld: Drop useless CONFIG_KVM ifdefery
      hw/ppc/mac_newworld: Drop useless CONFIG_KVM ifdefery
      hw/ppc/prep: Drop useless CONFIG_KVM ifdefery
      hw/ppc: Drop useless CONFIG_KVM ifdefery
      ppc: Introduce kvmppc_set_reg_tb_offset() helper
      target/ppc/machine: Add kvmppc_pvr_workaround_required() stub


 hw/ppc/mac_newworld.c |    4 ----
 hw/ppc/mac_oldworld.c |    2 --
 hw/ppc/ppc.c          |    7 +------
 hw/ppc/prep.c         |    2 --
 hw/ppc/spapr_pci.c    |    2 --
 target/ppc/kvm.c      |    9 +++++++++
 target/ppc/kvm_ppc.h  |   10 ++++++++++
 target/ppc/machine.c  |    2 --
 8 files changed, 20 insertions(+), 18 deletions(-)


