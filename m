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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B457BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F66F2559F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7+grCbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F66F2559F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwvQ-00005J-Lb
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqM-0000OX-HA
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:18 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqK-0007vg-Dm
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:18 -0400
Received: by mail-lj1-x242.google.com with SMTP id s9so18719331ljm.11
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FsIVIoOVJboArGXMQrUGGX14JmbZhvk3mjQFE9rsWOk=;
 b=r7+grCbChISoVGXwV5xZDySFFX1gnUCQ4tnl2knM0XJLcubjNSkBZw4rgjoXUU5+rt
 UNsxBosKQEoEesqp9+B+M+jIGSoe5S2I7H/OjqeIBqJ6c+HkV6Nk9RwrXQBPpmRHdyL6
 EZcM31th+12YWOcsQBblwkqivK1KUsN04BFvFKnyeAVhMNpsCDzfSaflETmq8uUcEjeF
 KvUGd78eU5cGni4MiCIWrU+839lWXTi5hhYx7wYou50e72vd/LPinjwistjHqVIi6w9q
 0AB4Ev3KU+zd+eh6BM5rPRhLaeIuvY0MCR+7QNAKcu16yZFf6cQDKacZ6TmpU0K6++BH
 RVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FsIVIoOVJboArGXMQrUGGX14JmbZhvk3mjQFE9rsWOk=;
 b=W/3EKVXOODkeHmESj0FL3D728OJ3aN4kK11Qm+aRBpUnqxivAh/cFAlqMF6Zg3tuE1
 FCP8tRHpV1A6urx+36RxYY+J14/VpJUI6wT9mv8DJoH9V7GpFh//shjMxldl2lTE7teW
 GJ+CP2riylSJMjfH6TmdddhB56F8sW/zWjR1FqjUnZIaR6ydAwKdw8SUmyocnUEn59gl
 jYZ12r127YgXvu+R4PRE2v4Rep81GpMTDABFNHpuYHRVocezbEVGAoNtk4VOvSTauwra
 eiHEWkjUFpEEZiK3DtSAHPIFo8Sen3wHRh401Xl4f3rs3SdEQyKVVXNPCly1fbO58nWN
 Xm5w==
X-Gm-Message-State: AOAM531DYPyNeRrNvXwmWXrdqbQWdRJ25ngkruFzD178Og9kGVTeHquP
 yl8UN2sGNqhZ9lrKTHD2rUm65jn//Q0qzQ==
X-Google-Smtp-Source: ABdhPJyhne7wnwo28CncTAlxYxanOV771jDjbADy+HL1Zc/P92n3nTa+0n8AZuKt3hxTarGX+wKsHw==
X-Received: by 2002:a2e:81d5:: with SMTP id s21mr1201533ljg.362.1593448874624; 
 Mon, 29 Jun 2020 09:41:14 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id o1sm37641lfi.92.2020.06.29.09.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 09:41:14 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/9] qmp: add chardev-resize command
Date: Mon, 29 Jun 2020 18:40:39 +0200
Message-Id: <20200629164041.472528-8-noh4hss@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629164041.472528-1-noh4hss@gmail.com>
References: <20200629164041.472528-1-noh4hss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=noh4hss@gmail.com; helo=mail-lj1-x242.google.com
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

The managment software can use this command to notify QEMU about the
size of the terminal connected to a chardev, QEMU can then forward this
information to the guest if the chardev is connected to a virtio console
device.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char.c | 14 ++++++++++++++
 qapi/char.json | 25 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 1dc22aca95..c1bdfc8b5f 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1182,6 +1182,20 @@ void qmp_chardev_send_break(const char *id, Error **errp)
     qemu_chr_be_event(chr, CHR_EVENT_BREAK);
 }
 
+void qmp_chardev_resize(const char *id, uint16_t cols, uint16_t rows,
+                        Error **errp)
+{
+    Chardev *chr;
+
+    chr = qemu_chr_find(id);
+    if (chr == NULL) {
+        error_setg(errp, "Chardev '%s' not found", id);
+        return;
+    }
+
+    qemu_chr_resize(chr, cols, rows);
+}
+
 /*
  * Add a timeout callback for the chardev (in milliseconds), return
  * the GSource object created. Please use this to add timeout hook for
diff --git a/qapi/char.json b/qapi/char.json
index daceb20f84..dc2d6cab22 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -573,3 +573,28 @@
 { 'event': 'VSERPORT_CHANGE',
   'data': { 'id': 'str',
             'open': 'bool' } }
+
+##
+# @chardev-resize:
+#
+# Notifies a chardev about the current size of the terminal connected
+# to this chardev.
+#
+# @id: the chardev's ID, must exist
+# @cols: the number of columns
+# @rows: the number of rows
+#
+# Returns: Nothing on success
+#
+# Since: 5.1
+#
+# Example:
+#
+# -> { "execute": "chardev-resize", "arguments": { "id": "foo", "cols": 80, "rows": 24 } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'chardev-resize',
+  'data': { 'id': 'str',
+            'cols': 'uint16',
+            'rows': 'uint16' } }
-- 
2.27.0


