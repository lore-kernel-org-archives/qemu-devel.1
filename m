Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923FDC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D76020757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbsVtx2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D76020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7wC-0003HI-GC
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jo-0003Y5-Dx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jl-0000TB-IY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:20 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jl-0000SV-3k
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:17 -0400
Received: by mail-wr1-x429.google.com with SMTP id j1so6547169wrt.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8hi1p3eL3t21N4txt/xDnw2kNSKZMQWnLiLJ53KEUd4=;
 b=tbsVtx2/lE3Z8HBRsS3iPBc/MmKHtGrmQsX4gVkMiBDkAKCUlDfzV0hX+/A1f3Ldc+
 iRiIH52p8FvHmcdKhWscrtj+2cAz4llCWHeE7uD2QIIbRTaCnyWQ47y5k1ud0gDmYg1Z
 QOURsT847VVhN7IY0+LFM33uiVIrUCAWfGbSWsguvcLP/3PQbKizT62ILG3Fy635gI7S
 KrgrtzUiNh25UgaDJnWdekyHlTV7eJsYX5E7pTT6lySgXyRrBnfiy48XCAJFiOPGu/nF
 xjJMq0wKVS/tohxxyjYg6utCy2CVjXf8m82prydmh5As5QKYUsHzR6MgQzKcBL40UXhR
 XXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8hi1p3eL3t21N4txt/xDnw2kNSKZMQWnLiLJ53KEUd4=;
 b=ZUKqdN+YSstWM5nnPkye5oI0K9QCulyPGXCMUvr7DxZOnSAOhVjc+HBdpMA4H8G39V
 441mYimkupE6npZaWVj2//Q9O3dYDyLNDS4WclmZss4IRfitCT72PAtwwuhNfh6Xcz6X
 cJrN4J83KfGYw5ZJBFXGvMmBBuJfmPt/lrCVGQluLYQl8hcl83oiavN/PcJU/VyeVRX4
 jWgsYPoRciP2RmacP4PpeLyJ4T5QpVzdPLAQHFCfQJM2PGCvCE09VZFpNrsrsuAhWFaM
 sRV1VlHtttJEj6Yzn6sRRmnSyexat3vlBK1stuhazdr4UuScJwVim62LDYzbycfsSeZ3
 ROSA==
X-Gm-Message-State: AGi0PubKGJe67LZV9O1fb26h4sqyoj3LNO2/575XLL2GieBkM9zK21cG
 cZzVbQe4DCqOb5plTcwjv/+KG3eFyWtbIw==
X-Google-Smtp-Source: APiQypLIJCwX40C/RA44RlhQBMuXOdL6DxLM2bj7VrhO40yue7APIjS+4EsGk2kRPwlXz5srpO10Qg==
X-Received: by 2002:adf:f704:: with SMTP id r4mr3579382wrp.5.1588247535393;
 Thu, 30 Apr 2020 04:52:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/31] device_tree: Allow name wildcards in qemu_fdt_node_path()
Date: Thu, 30 Apr 2020 12:51:39 +0100
Message-Id: <20200430115142.13430-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::429
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Allow name wildcards in qemu_fdt_node_path(). This is useful
to find all nodes with a given compatibility string.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200423121114.4274-2-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/device_tree.h | 3 +++
 device_tree.c                | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
index c16fd69bc0b..7c53ef76345 100644
--- a/include/sysemu/device_tree.h
+++ b/include/sysemu/device_tree.h
@@ -39,6 +39,9 @@ void *load_device_tree_from_sysfs(void);
  * NULL. If there is no error but no matching node was found, the
  * returned array contains a single element equal to NULL. If an error
  * was encountered when parsing the blob, the function returns NULL
+ *
+ * @name may be NULL to wildcard names and only match compatibility
+ * strings.
  */
 char **qemu_fdt_node_path(void *fdt, const char *name, char *compat,
                           Error **errp);
diff --git a/device_tree.c b/device_tree.c
index bba6cc21641..f5b4699aedb 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -308,7 +308,7 @@ char **qemu_fdt_node_path(void *fdt, const char *name, char *compat,
             offset = len;
             break;
         }
-        if (!strcmp(iter_name, name)) {
+        if (!name || !strcmp(iter_name, name)) {
             char *path;
 
             path = g_malloc(path_len);
-- 
2.20.1


