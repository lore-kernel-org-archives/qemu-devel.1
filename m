Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22141C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDA920773
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDA920773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joVIf-0006pL-62
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 13:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1joVEo-00015X-Ek; Thu, 25 Jun 2020 13:00:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1joVEm-0007QO-NQ; Thu, 25 Jun 2020 13:00:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05PGWf4k160158; Thu, 25 Jun 2020 13:00:28 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31uwyj8mtq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 13:00:28 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PH06G0001509;
 Thu, 25 Jun 2020 17:00:27 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03dal.us.ibm.com with ESMTP id 31uurw100q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 17:00:27 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05PH0OlP6422816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 17:00:24 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F02E136059;
 Thu, 25 Jun 2020 17:00:26 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A49813604F;
 Thu, 25 Jun 2020 17:00:25 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.160.117.167])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jun 2020 17:00:25 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 6/8] fix the prototype of muls64/mulu64
Date: Thu, 25 Jun 2020 12:00:16 -0500
Message-Id: <20200625170018.64265-7-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200625170018.64265-1-ljp@linux.ibm.com>
References: <20200625170018.64265-1-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-25_11:2020-06-25,
 2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=807 lowpriorityscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250102
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ljp@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 13:00:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Lijun Pan <ljp@linux.ibm.com>, richard.henderson@linaro.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The prototypes of muls64/mulu64 in host-utils.h should match the
definitions in host-utils.c

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
 include/qemu/host-utils.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 4cd170e6cd..cdca2991d8 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -77,8 +77,8 @@ static inline int divs128(int64_t *plow, int64_t *phigh, int64_t divisor)
     }
 }
 #else
-void muls64(uint64_t *phigh, uint64_t *plow, int64_t a, int64_t b);
-void mulu64(uint64_t *phigh, uint64_t *plow, uint64_t a, uint64_t b);
+void muls64(uint64_t *plow, uint64_t *phigh, int64_t a, int64_t b);
+void mulu64(uint64_t *plow, uint64_t *phigh, uint64_t a, uint64_t b);
 int divu128(uint64_t *plow, uint64_t *phigh, uint64_t divisor);
 int divs128(int64_t *plow, int64_t *phigh, int64_t divisor);
 
-- 
2.23.0


