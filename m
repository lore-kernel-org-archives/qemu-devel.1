Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BFBC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE72D2073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE72D2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1xBX-0001se-2v
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 13:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j1x9D-0007Fa-Pi
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j1x9C-0001Hc-Rv
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:54:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58074
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j1x9C-0001HT-N5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:54:06 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01CInWSV139346
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 13:54:06 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y4bp9kn9y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 13:54:06 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 12 Feb 2020 18:54:04 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 12 Feb 2020 18:54:01 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01CIs1o438863314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2020 18:54:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DF6FA4055;
 Wed, 12 Feb 2020 18:54:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D375BA404D;
 Wed, 12 Feb 2020 18:54:00 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.71.236])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 12 Feb 2020 18:54:00 +0000 (GMT)
Subject: [PATCH 1/3] pnv/phb3: Convert 1u to 1ull
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 12 Feb 2020 19:54:00 +0100
In-Reply-To: <158153363409.3229002.13469293798150754920.stgit@bahia.lan>
References: <158153363409.3229002.13469293798150754920.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021218-0028-0000-0000-000003D9F3A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021218-0029-0000-0000-0000249E6802
Message-Id: <158153364010.3229002.8004283672455615950.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-12_08:2020-02-12,
 2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1034
 mlxscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=876 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120134
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As reported by Coverity defect CID 1419397, the 'j' variable goes up to
63 and shouldn't be used to left shift a 32-bit integer.

The result of the operation goes to a 64-bit integer : use a 64-bit
constant.

Reported-by: Coverity CID 1419397 Bad bit shift operation
Fixes: 9ae1329ee2fe "ppc/pnv: Add models for POWER8 PHB3 PCIe Host bridge"
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/pci-host/pnv_phb3_msi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index ecfc1b2c4e3d..d645468f4a6f 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -220,7 +220,7 @@ static void phb3_msi_resend(ICSState *ics)
             if ((msi->rba[i] & (1ull << j)) == 0) {
                 continue;
             }
-            msi->rba[i] &= ~(1u << j);
+            msi->rba[i] &= ~(1ull << j);
             phb3_msi_try_send(msi, i * 64 + j, true);
         }
     }


