Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F25FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F30C25598
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+cLLAI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F30C25598
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwrL-000288-Hv
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqI-0000I8-TG
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:14 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:46934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqG-0007uu-QD
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:14 -0400
Received: by mail-lf1-x144.google.com with SMTP id m26so9431708lfo.13
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3sFtKalod1/786Y897d8w6b5nlz6uSa8s0Q6IXgOPjU=;
 b=K+cLLAI9ckD4KaKCQtho1A/a193zgTp0LDfrdTqXkGkjtRc564CFTo92cL4LmjqqOy
 D20FqwazQzKTkqPuBOuVYWwwBx3ECmLaMr74ipU+8vIm43e5zlu/Bl/yR6r1wyy3AV9c
 kUR/d7+nb4HXYFqqyZvFB7jsQEIkKpUNW7lHlqCIG3vSz6m7DajsHyKeQJiogcaOAPfC
 40VsOZDA4hxwRn9A3NUyXeKVF44f9pD/4QzCnID9zSflvg9yVnpoy1x6ykZg5Ev9HN8E
 XHLhnlM+sVfJY2nByfsID6GXgQNbj49s6QNsUqr6qsu9gmg4zgtUhMAOmMTC1AzRFWn8
 0L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3sFtKalod1/786Y897d8w6b5nlz6uSa8s0Q6IXgOPjU=;
 b=ByXiwUUtV2l1nh9MJexb2iQ/aBtBjEFMvRaF8U/h48lTGGPMDQDgruoz82alf7HFsj
 ckZF+i3G39r0RBeLUnjQ9bRsdNMDJJvgQmVo18GMTtZwYFHoqWuVheob37PdQLey74yA
 x7aGB/efs8zak+KsbFATrb9wtm5UsSMm622LK77LLX2tBllQY58/9y+YH3XEvBmtZ8+k
 BrelnTZ9cvVipSwMC8QIosFL4mEHhxI0NgMzrdOnI+WwIsLqcT0RIdWgeAjXd0TYGvVk
 XwPCmJS4JMXnnQ5vspEHE81BqnrEN9DtRiB+fFvuLaKPVE0Su6gB337GkqKjbF8kUDNt
 eA8Q==
X-Gm-Message-State: AOAM5327RWTTXbURtyQLWzA+G8f60GoerddDGt+1Cjom9DBo4d72Ze5K
 ++KauCcaUuiwmw6uQiEskAySRRYT/yKJZA==
X-Google-Smtp-Source: ABdhPJyOPBIHvEb/6X5armsEmWQP8YeD+LChofIXaJ4Yoo7bJpe1DoFYWChXR1+3MAhfBR6EcYDU3g==
X-Received: by 2002:a19:2209:: with SMTP id i9mr9660299lfi.46.1593448870982;
 Mon, 29 Jun 2020 09:41:10 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id o1sm37641lfi.92.2020.06.29.09.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 09:41:10 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/9] chardev: add qemu_chr_resize()
Date: Mon, 29 Jun 2020 18:40:35 +0200
Message-Id: <20200629164041.472528-4-noh4hss@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629164041.472528-1-noh4hss@gmail.com>
References: <20200629164041.472528-1-noh4hss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=noh4hss@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: lvivier@redhat.com, berrange@redhat.com, amit@kernel.org, mst@redhat.com,
 Szymon Lukasz <noh4hss@gmail.com>, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function should be called whenever we learn about a new size of
the terminal connected to a chardev.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
---
 chardev/char.c         | 11 +++++++++++
 include/chardev/char.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 904f8bf6e3..1dc22aca95 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -354,6 +354,17 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp)
     return 0;
 }
 
+void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows)
+{
+    if (cols != chr->cols || rows != chr->rows) {
+        chr->cols = cols;
+        chr->rows = rows;
+        if (chr->be_open) {
+            qemu_chr_be_event(chr, CHR_EVENT_RESIZE);
+        }
+    }
+}
+
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
                                 bool permit_mux_mon)
 {
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 42203e9fa4..01099121f1 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -230,6 +230,8 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 
+void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows);
+
 #define TYPE_CHARDEV "chardev"
 #define CHARDEV(obj) OBJECT_CHECK(Chardev, (obj), TYPE_CHARDEV)
 #define CHARDEV_CLASS(klass) \
-- 
2.27.0


