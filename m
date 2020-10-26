Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19BEC55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C56624640
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C56624640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3Dj-0003Px-40
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangxinhao1@huawei.com>)
 id 1kWz3U-0007Cb-Cr; Mon, 26 Oct 2020 05:44:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangxinhao1@huawei.com>)
 id 1kWz3Q-0006qM-L3; Mon, 26 Oct 2020 05:44:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CKVKx0skczhbRk;
 Mon, 26 Oct 2020 17:44:37 +0800 (CST)
Received: from [10.174.187.250] (10.174.187.250) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 26 Oct 2020 17:44:22 +0800
To: <qemu-devel@nongnu.org>
From: jokenzhang <zhangxinhao1@huawei.com>
Subject: [PATCH] hw/acpi/nvdimm.c : Don't use '#' flag of printf format
Message-ID: <af7fe174-c789-faf6-e067-80f7ebe21f0c@huawei.com>
Date: Mon, 26 Oct 2020 17:44:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.250]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhangxinhao1@huawei.com; helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 05:44:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2020 09:54:52 -0400
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
Cc: qemu-trivial@nongnu.org, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: jokenzhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
Reported-by: Euler Robot <euler.robot@huawei.com>
---
 hw/acpi/nvdimm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8f7cc16add..dab3329890 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -556,7 +556,7 @@ static void nvdimm_dsm_func_read_fit(NVDIMMState *state, NvdimmDsmIn *in,

     fit = fit_buf->fit;

-    nvdimm_debug("Read FIT: offset %#x FIT size %#x Dirty %s.\n",
+    nvdimm_debug("Read FIT: offset 0x%x FIT size 0x%x Dirty %s.\n",
                  read_fit->offset, fit->len, fit_buf->dirty ? "Yes" : "No");

     if (read_fit->offset > fit->len) {
@@ -664,7 +664,7 @@ static void nvdimm_dsm_label_size(NVDIMMDevice *nvdimm, hwaddr dsm_mem_addr)
     label_size = nvdimm->label_size;
     mxfer = nvdimm_get_max_xfer_label_size();

-    nvdimm_debug("label_size %#x, max_xfer %#x.\n", label_size, mxfer);
+    nvdimm_debug("label_size 0x%x, max_xfer 0x%x.\n", label_size, mxfer);

     label_size_out.func_ret_status = cpu_to_le32(NVDIMM_DSM_RET_STATUS_SUCCESS);
     label_size_out.label_size = cpu_to_le32(label_size);
@@ -680,19 +680,19 @@ static uint32_t nvdimm_rw_label_data_check(NVDIMMDevice *nvdimm,
     uint32_t ret = NVDIMM_DSM_RET_STATUS_INVALID;

     if (offset + length < offset) {
-        nvdimm_debug("offset %#x + length %#x is overflow.\n", offset,
+        nvdimm_debug("offset 0x%x + length 0x%x is overflow.\n", offset,
                      length);
         return ret;
     }

     if (nvdimm->label_size < offset + length) {
-        nvdimm_debug("position %#x is beyond label data (len = %" PRIx64 ").\n",
+        nvdimm_debug("position 0x%x is beyond label data (len = %" PRIx64 ").\n",
                      offset + length, nvdimm->label_size);
         return ret;
     }

     if (length > nvdimm_get_max_xfer_label_size()) {
-        nvdimm_debug("length (%#x) is larger than max_xfer (%#x).\n",
+        nvdimm_debug("length (0x%x) is larger than max_xfer (0x%x).\n",
                      length, nvdimm_get_max_xfer_label_size());
         return ret;
     }
@@ -716,7 +716,7 @@ static void nvdimm_dsm_get_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
     get_label_data->offset = le32_to_cpu(get_label_data->offset);
     get_label_data->length = le32_to_cpu(get_label_data->length);

-    nvdimm_debug("Read Label Data: offset %#x length %#x.\n",
+    nvdimm_debug("Read Label Data: offset 0x%x length 0x%x.\n",
                  get_label_data->offset, get_label_data->length);

     status = nvdimm_rw_label_data_check(nvdimm, get_label_data->offset,
@@ -755,7 +755,7 @@ static void nvdimm_dsm_set_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
     set_label_data->offset = le32_to_cpu(set_label_data->offset);
     set_label_data->length = le32_to_cpu(set_label_data->length);

-    nvdimm_debug("Write Label Data: offset %#x length %#x.\n",
+    nvdimm_debug("Write Label Data: offset 0x%x length 0x%x.\n",
                  set_label_data->offset, set_label_data->length);

     status = nvdimm_rw_label_data_check(nvdimm, set_label_data->offset,
@@ -852,11 +852,11 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     in->function = le32_to_cpu(in->function);
     in->handle = le32_to_cpu(in->handle);

-    nvdimm_debug("Revision %#x Handler %#x Function %#x.\n", in->revision,
+    nvdimm_debug("Revision 0x%x Handler 0x%x Function 0x%x.\n", in->revision,
                  in->handle, in->function);

     if (in->revision != 0x1 /* Currently we only support DSM Spec Rev1. */) {
-        nvdimm_debug("Revision %#x is not supported, expect %#x.\n",
+        nvdimm_debug("Revision 0x%x is not supported, expect 0x%x.\n",
                      in->revision, 0x1);
         nvdimm_dsm_no_payload(NVDIMM_DSM_RET_STATUS_UNSUPPORT, dsm_mem_addr);
         goto exit;
-- 
2.29.0-rc1

