Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C070C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B37207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B37207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZ0b-000658-CT
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jlYyC-0001eG-LB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:23:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51796
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jlYy9-0005Kt-Hi
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:23:16 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05HE24nd120503
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:23:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31q6hbs10y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:23:12 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05HE528p131368
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:23:12 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31q6hbs10h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2020 10:23:12 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05HEF0QL029914;
 Wed, 17 Jun 2020 14:23:11 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma03dal.us.ibm.com with ESMTP id 31q6c5kdnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2020 14:23:11 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05HENAEw34865638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2020 14:23:10 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CC2B7805E;
 Wed, 17 Jun 2020 14:23:10 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A93397805C;
 Wed, 17 Jun 2020 14:23:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2020 14:23:09 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/8] tests: Temporarily ignore DSDT table differences
Date: Wed, 17 Jun 2020 10:23:00 -0400
Message-Id: <20200617142305.1198672-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
References: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-17_04:2020-06-17,
 2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 clxscore=1015 suspectscore=1 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170105
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 10:23:10
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, eric.auger@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, philmd@redhat.com,
 mkedzier@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ignore DSDT table differences before enabling IRQ support for TPM.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20200616205721.1191408-4-stefanb@linux.vnet.ibm.com
CC: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..bb4ce8967b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT.tis",
-- 
2.24.1


