Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EA7C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 04:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97F12224E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 04:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97F12224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZneY-0004KV-Kq
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 23:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaihaoyu1@huawei.com>)
 id 1kZndm-0003rQ-Ed
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 23:09:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaihaoyu1@huawei.com>)
 id 1kZndk-0007rS-A8
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 23:09:50 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQGWl2pF1zkdxK;
 Tue,  3 Nov 2020 12:09:39 +0800 (CST)
Received: from [10.108.235.54] (10.108.235.54) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 12:09:36 +0800
Subject: [PATCH v2 2/3] softmmu: Don't use '#' flag of printf format
References: <edcc3e56-2419-8645-8639-d9e50d710a1d@huawei.com>
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>
From: chaihaoyu <chaihaoyu1@huawei.com>
X-Forwarded-Message-Id: <edcc3e56-2419-8645-8639-d9e50d710a1d@huawei.com>
Message-ID: <ef0192da-8046-6c0f-0bfd-2cd228fd093e@huawei.com>
Date: Tue, 3 Nov 2020 12:09:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <edcc3e56-2419-8645-8639-d9e50d710a1d@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.235.54]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=chaihaoyu1@huawei.com; helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: alex.chen@huawei.com, hunongda@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, recently I found some code style problems while using checkpatch.pl tool,please review.

Date: Tue, 3 Nov 2020 11:01:40 +0800
Subject: [PATCH] Don't use '#' flag of printf format
signed-off-by: Haoyu Chai<chaihaoyu1@huawei.com>
---
 softmmu/device_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/softmmu/device_tree.c b/softmmu/device_tree.c
index b335dae707..c70215ba6a 100644
--- a/softmmu/device_tree.c
+++ b/softmmu/device_tree.c
@@ -367,7 +367,7 @@ int qemu_fdt_setprop_cell(void *fdt, const char *node_path,

     r = fdt_setprop_cell(fdt, findnode_nofail(fdt, node_path), property, val);
     if (r < 0) {
-        error_report("%s: Couldn't set %s/%s = %#08x: %s", __func__,
+        error_report("%s: Couldn't set %s/%s = 0x%08x: %s", __func__,
                      node_path, property, val, fdt_strerror(r));
         exit(1);
     }
-- 
2.29.1.59.gf9b6481aed


