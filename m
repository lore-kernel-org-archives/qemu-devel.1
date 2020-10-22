Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C038FC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4F12417D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4F12417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVaQ3-0000JL-NC
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kVaG7-00052v-It; Thu, 22 Oct 2020 09:03:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5715 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kVaFx-0000gn-Rm; Thu, 22 Oct 2020 09:03:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1F3A5716043171552079;
 Thu, 22 Oct 2020 21:03:43 +0800 (CST)
Received: from localhost (10.174.184.155) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 22 Oct 2020
 21:03:34 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: <qemu-devel@nongnu.org>, <kwolf@redhat.com>, <mreitz@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH v3 9/9] docs: add a doc about I/O hang
Date: Thu, 22 Oct 2020 21:03:03 +0800
Message-ID: <20201022130303.1092-10-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022130303.1092-1-cenjiahui@huawei.com>
References: <20201022130303.1092-1-cenjiahui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=cenjiahui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 09:03:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cenjiahui@huawei.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 stefanha@redhat.com, fangying1@huawei.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Give some details about the I/O hang and how to use it.

Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 docs/io-hang.rst | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 docs/io-hang.rst

diff --git a/docs/io-hang.rst b/docs/io-hang.rst
new file mode 100644
index 0000000000..53356ceed2
--- /dev/null
+++ b/docs/io-hang.rst
@@ -0,0 +1,45 @@
+========
+I/O hang
+========
+
+Introduction
+============
+
+I/O hang is a mechanism to automatically rehandle AIOs when an error occurs on
+the backend block device, which is unperceivable for Guest. If the error on the
+backend device is temporary, like NFS returns EIO due to network fluctuations,
+once the device is recovered, the AIOs will be resent automatically and done
+successfully. If the error on the device is unrecoverable, the failed AIOs will
+be returned to Guest after rehandle timeout.
+
+This mechanism can provide self-recovery and high availability to VM. From the
+view of Guest, AIOs sent to the device are hung for a time and the finished, and
+any other unrelated service in Guest can work as usual.
+
+Implementation
+==============
+
+Each BlockBackend will have a list to store AIOs which need be rehandled and a
+timer to monitor the timeout.
+
+If I/O hang is enabled, all returned AIOs will be checked and the failed ones
+will be inserted into BlockBackend's list. The timer will be started and the
+AIOs in the list will be resent to the backend device. Once the result of AIOs
+relevant to this backend device is success, the AIOs will be returned back to
+Guest. Otherwise, those AIOs will be rehandled periodically until timeout.
+
+I/O hang provides interfaces to drain all the AIOs in BlockBackend's list. There
+are some situations to drain the rehandling AIOs, eg. resetting virtio-blk.
+
+I/O hang also provides qapi events, which can be used for manager tools like
+libvirt to monitor.
+
+Examples
+========
+
+Enable I/O hang when launching QEMU::
+
+      $ qemu-system-x86_64                                      \
+          -machine pc,accel=kvm -smp 1 -m 2048                  \
+          -drive file=shared.img,format=raw,cache=none,aio=native,iohang-timeout=60
+
-- 
2.19.1


