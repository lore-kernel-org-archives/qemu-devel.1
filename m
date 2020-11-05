Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D415C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58368206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aJa/NDFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58368206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kankp-0001Zd-D1
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 17:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kand6-0000sG-TL
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:21:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5796
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kand3-0004IK-Jg
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:21:16 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A5M2G3A152546
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2020 17:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RVgVX22wUUBmoZ3wdqFVy3xBom1l+qRdXCb7k8nqonw=;
 b=aJa/NDFh8M+EstfHjdIlo1vV/YswYbYg/cg/ajkWQGvGBs9MKyq8ueRO2yawd6/5acn/
 VUJayxFIf4lGcAUeI+B4UwpJUSylnUWMgMpYwuqhmoxnyhptEuhEVERgJbcJgrX959fb
 hg8oZ4nZ9jfDfH8LqPzTYRh7LeZD0CLftRLFuZkr/iKt8druGI3OkOAJ7lxzJtsYo0Z/
 blEFQIzV6LFdzjcH0BIW5Hjnx8lvqVV8STIvLCHpmEdTqRYwgQdon9bABwmSYue9nSZ1
 uWcKHMrUC353HYmuAgYyq1Rk11PeNLrpgFGIv8DMLaLQuQra2eQG6RCjfwP+YAwDLSR4 kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34mnyhq4f5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 17:21:08 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A5MJpKK021946
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2020 17:19:51 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34mnyhq4ae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 17:19:51 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MFOm6000664;
 Thu, 5 Nov 2020 22:19:19 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01wdc.us.ibm.com with ESMTP id 34h0253hva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 22:19:19 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A5MJIiv24379668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2020 22:19:18 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 909DA6A04F;
 Thu,  5 Nov 2020 22:19:18 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 103C36A047;
 Thu,  5 Nov 2020 22:19:18 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.222.173])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  5 Nov 2020 22:19:17 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: dbuono@linux.vnet.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH v3 3/9] hw/usb: reorder fields in UASStatus
Date: Thu,  5 Nov 2020 17:18:59 -0500
Message-Id: <20201105221905.1350-4-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-05_15:2020-11-05,
 2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050139
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 17:19:18
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The UASStatus data structure has a variable sized field inside of type uas_iu,
that however is not placed at the end of the data structure.

This placement triggers a warning with clang 11, and while not a bug right now,
(the status is never a uas_iu_command, which is the variable-sized case),
it could become one in the future.

../qemu-base/hw/usb/dev-uas.c:157:31: error: field 'status' with variable sized type 'uas_iu' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
    uas_iu                    status;
                              ^
1 error generated.

Fix this by moving uas_iu at the end of the struct

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 hw/usb/dev-uas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index cec071d96c..5ef3f4fec9 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -154,9 +154,9 @@ struct UASRequest {
 
 struct UASStatus {
     uint32_t                  stream;
-    uas_iu                    status;
     uint32_t                  length;
     QTAILQ_ENTRY(UASStatus)   next;
+    uas_iu                    status;
 };
 
 /* --------------------------------------------------------------------- */
-- 
2.17.1


