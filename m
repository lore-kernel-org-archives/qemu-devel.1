Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7C6C49EAB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8C820717
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8C820717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRv2V-00009j-3l
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iRut0-00057E-Ry
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iRusz-0007pY-9j
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2196 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iRusv-0007kO-Do; Tue, 05 Nov 2019 04:12:21 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4C2F3E89D1355151C65C;
 Tue,  5 Nov 2019 17:12:13 +0800 (CST)
Received: from linux-OtBuvb.huawei.com (10.175.104.212) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 17:12:03 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC v2 02/14] standard-headers: import arm_sdei.h
Date: Tue, 5 Nov 2019 17:10:44 +0800
Message-ID: <20191105091056.9541-3-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191105091056.9541-1-guoheyi@huawei.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Cornelia Huck <cohuck@redhat.com>, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Import Linux header file include/uapi/linux/arm_sdei.h from kernel v5.4-r=
c5.

This is to prepare for qemu SDEI emulation.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---

Notes:
    v2:
    - Import arm_sdei.h by running update-linux-headers.sh

 include/standard-headers/linux/arm_sdei.h | 73 +++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 include/standard-headers/linux/arm_sdei.h

diff --git a/include/standard-headers/linux/arm_sdei.h b/include/standard=
-headers/linux/arm_sdei.h
new file mode 100644
index 0000000000..568d971915
--- /dev/null
+++ b/include/standard-headers/linux/arm_sdei.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (C) 2017 Arm Ltd. */
+#ifndef _LINUX_ARM_SDEI_H
+#define _LINUX_ARM_SDEI_H
+
+#define SDEI_1_0_FN_BASE			0xC4000020
+#define SDEI_1_0_MASK				0xFFFFFFE0
+#define SDEI_1_0_FN(n)				(SDEI_1_0_FN_BASE + (n))
+
+#define SDEI_1_0_FN_SDEI_VERSION			SDEI_1_0_FN(0x00)
+#define SDEI_1_0_FN_SDEI_EVENT_REGISTER			SDEI_1_0_FN(0x01)
+#define SDEI_1_0_FN_SDEI_EVENT_ENABLE			SDEI_1_0_FN(0x02)
+#define SDEI_1_0_FN_SDEI_EVENT_DISABLE			SDEI_1_0_FN(0x03)
+#define SDEI_1_0_FN_SDEI_EVENT_CONTEXT			SDEI_1_0_FN(0x04)
+#define SDEI_1_0_FN_SDEI_EVENT_COMPLETE			SDEI_1_0_FN(0x05)
+#define SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME	SDEI_1_0_FN(0x06)
+#define SDEI_1_0_FN_SDEI_EVENT_UNREGISTER		SDEI_1_0_FN(0x07)
+#define SDEI_1_0_FN_SDEI_EVENT_STATUS			SDEI_1_0_FN(0x08)
+#define SDEI_1_0_FN_SDEI_EVENT_GET_INFO			SDEI_1_0_FN(0x09)
+#define SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET		SDEI_1_0_FN(0x0A)
+#define SDEI_1_0_FN_SDEI_PE_MASK			SDEI_1_0_FN(0x0B)
+#define SDEI_1_0_FN_SDEI_PE_UNMASK			SDEI_1_0_FN(0x0C)
+#define SDEI_1_0_FN_SDEI_INTERRUPT_BIND			SDEI_1_0_FN(0x0D)
+#define SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE		SDEI_1_0_FN(0x0E)
+#define SDEI_1_0_FN_SDEI_PRIVATE_RESET			SDEI_1_0_FN(0x11)
+#define SDEI_1_0_FN_SDEI_SHARED_RESET			SDEI_1_0_FN(0x12)
+
+#define SDEI_VERSION_MAJOR_SHIFT			48
+#define SDEI_VERSION_MAJOR_MASK				0x7fff
+#define SDEI_VERSION_MINOR_SHIFT			32
+#define SDEI_VERSION_MINOR_MASK				0xffff
+#define SDEI_VERSION_VENDOR_SHIFT			0
+#define SDEI_VERSION_VENDOR_MASK			0xffffffff
+
+#define SDEI_VERSION_MAJOR(x)	(x>>SDEI_VERSION_MAJOR_SHIFT & SDEI_VERSIO=
N_MAJOR_MASK)
+#define SDEI_VERSION_MINOR(x)	(x>>SDEI_VERSION_MINOR_SHIFT & SDEI_VERSIO=
N_MINOR_MASK)
+#define SDEI_VERSION_VENDOR(x)	(x>>SDEI_VERSION_VENDOR_SHIFT & SDEI_VERS=
ION_VENDOR_MASK)
+
+/* SDEI return values */
+#define SDEI_SUCCESS		0
+#define SDEI_NOT_SUPPORTED	-1
+#define SDEI_INVALID_PARAMETERS	-2
+#define SDEI_DENIED		-3
+#define SDEI_PENDING		-5
+#define SDEI_OUT_OF_RESOURCE	-10
+
+/* EVENT_REGISTER flags */
+#define SDEI_EVENT_REGISTER_RM_ANY	0
+#define SDEI_EVENT_REGISTER_RM_PE	1
+
+/* EVENT_STATUS return value bits */
+#define SDEI_EVENT_STATUS_RUNNING	2
+#define SDEI_EVENT_STATUS_ENABLED	1
+#define SDEI_EVENT_STATUS_REGISTERED	0
+
+/* EVENT_COMPLETE status values */
+#define SDEI_EV_HANDLED	0
+#define SDEI_EV_FAILED	1
+
+/* GET_INFO values */
+#define SDEI_EVENT_INFO_EV_TYPE			0
+#define SDEI_EVENT_INFO_EV_SIGNALED		1
+#define SDEI_EVENT_INFO_EV_PRIORITY		2
+#define SDEI_EVENT_INFO_EV_ROUTING_MODE		3
+#define SDEI_EVENT_INFO_EV_ROUTING_AFF		4
+
+/* and their results */
+#define SDEI_EVENT_TYPE_PRIVATE			0
+#define SDEI_EVENT_TYPE_SHARED			1
+#define SDEI_EVENT_PRIORITY_NORMAL		0
+#define SDEI_EVENT_PRIORITY_CRITICAL		1
+
+#endif /* _LINUX_ARM_SDEI_H */
--=20
2.19.1


