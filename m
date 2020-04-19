Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C350BC5321D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92552206D9
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kML072Bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92552206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQCoQ-0008Vk-QD
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 12:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42246 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQCn7-0006rk-3u
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:27:33 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQCn6-0006iQ-LR
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:27:32 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45104)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQCn6-0006es-8k; Sun, 19 Apr 2020 12:27:32 -0400
Received: by mail-lj1-x242.google.com with SMTP id n6so3890449ljg.12;
 Sun, 19 Apr 2020 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3HaUgFQJn75EXnF4xu27e05BkwttmkjB/KLaOVhe5Zc=;
 b=kML072BvLIF/DC/wAPBh3bMx7Vg+4cwbVq3/M9/Emmqc9+lKzLijTccIZO8f21f5mX
 /MpVlUhDyhLGad5Whetnd/jJ6g/Cl8miESQgcGDG3Y8APVj9izcGOLWsj/kXOS2+CSXt
 sRNEtoaan+wwCHDwxsGcOHhsMoyL/cEJqwqWecRybcdXmfppkshlcsUT8E/ZxEbjiie5
 1rhs4ZEupEw1A5CfxbsMm3G12X7A+34piSTxmCF8Z65AAVDIofBPoe68LaektMZSEHLs
 YCKBDovf6oERR+Le1eYBGLLoRA3kfgob4bBU9teC4hbLhHjxmP0svPOsE/Lsj72UPrrk
 4YVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3HaUgFQJn75EXnF4xu27e05BkwttmkjB/KLaOVhe5Zc=;
 b=dMjBZkvV1/0MW95H6PB03rypNZJUmFxpGwG3SU7wSsiWe2qlRYIfDdJRmVHXC0Rqh7
 0rT0tZ4ml7BUh9eyF2W+zSY4u4pRm7ke5VJdo0adrc+BRWdSCgGI3eVX3BPX0oxORufC
 KJZH28oEqnTUNeOCZmihaKnh428atcxAFjEXdWblWkSN4etMAequKBLDa52PWAdtiGXq
 D7U8OtC3Yi9DL/bFjFrUsUyPdFFPUGzug1279R6dsWIHP6DqWSxHmKF3SM+FepNDatAr
 h1mqRWv5kxvy6NkJYr9KhuR7cqlzUtjZkHqeVvh8+T9qbdTZhQI0bLArwHcLQpcsPCT+
 1ndw==
X-Gm-Message-State: AGi0PuaQy+3H8ifxoSApIe5u9Gyb1eWyStZWDz2PhQm7Trv5Rctb2N/h
 mmAWn2kefjtGc1SlWNEgbida8vwSRgI=
X-Google-Smtp-Source: APiQypLdAUV1SOIdla5KjoO1ezJrk0GnJBn0yO7KxR9x3PaWs30jOz+Yr7k/QZBkPUW+YyT5K5Z3uA==
X-Received: by 2002:a2e:9455:: with SMTP id o21mr7735340ljh.245.1587313650037; 
 Sun, 19 Apr 2020 09:27:30 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id m13sm23341469lfk.12.2020.04.19.09.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2020 09:27:29 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/3] device_tree: Allow name wildcards in
 qemu_fdt_node_path()
Date: Sun, 19 Apr 2020 18:27:25 +0200
Message-Id: <20200419162727.19148-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419162727.19148-1-edgar.iglesias@gmail.com>
References: <20200419162727.19148-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs1p.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Allow name wildcards in qemu_fdt_node_path(). This is useful
to find all nodes with a given compatibility string.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 device_tree.c                | 2 +-
 include/sysemu/device_tree.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/device_tree.c b/device_tree.c
index bba6cc2164..f5b4699aed 100644
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
diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
index c16fd69bc0..7c53ef7634 100644
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
-- 
2.20.1


