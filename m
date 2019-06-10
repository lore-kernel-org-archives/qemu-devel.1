Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF619C28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5B020679
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7cLKGch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5B020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46854 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKta-0005Iw-Dv
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 10:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51551)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKhY-0001EH-29
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKhU-0002TB-21
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:51:06 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1haKhP-0002PS-1w; Mon, 10 Jun 2019 09:51:00 -0400
Received: by mail-pf1-x442.google.com with SMTP id t16so5343325pfe.11;
 Mon, 10 Jun 2019 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WDYxGcU6qJa4559VsDh1i70v5FrPaZIfqXHtJVDOpyg=;
 b=d7cLKGchJ6d7HaiTt/UdMn/z0RUwSV2YYvf2v0HYmzGbKBuWg+9FKPmqoeE3T9rGtJ
 Yp5IWtbjGiE87ZX5RB2HNKaAv3FuWROjMxjlh0WE9IGIOpB28EtLU5S+dy+1fqWezRmr
 ghry2Is8aUiz7T04MSCO2xLQ2bsaeBnpXOLqPe7MlANBLnRb9V+yvxst59ratpwIFs2E
 IFJh4XPr06/fF3nz9IC8byonY80wpXcbYCLjfVRZD0ONOOlcphM3y+0c7aoWd7FWUZ7j
 dlH35GXuRc+4U706UUZQOvjIsWbUjbZ/M4ojVe5zL/lBLS6ExuGKkriyqeqKmoZwhR65
 3Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WDYxGcU6qJa4559VsDh1i70v5FrPaZIfqXHtJVDOpyg=;
 b=Xyj5P0/el9jkQHd8GHgKu+2xeIL5n1Is7ykFEN/axQM8t3s4vknvHy3wmkfZeFqL4i
 MeiVG2ftE38bYZxdc+rQrMk4qf1p8gqOvleoF0f1iEUYFWwFzWKum6QPoLsmpw5Cbzir
 C+fqVvmI3gmnXL/QhhCvLrhGVnd8XV9er52mg05d+zN72puIByzO86AcWL8oohC6rCMg
 NBWoaj0VrFMt8Hv4sfsN3c82+sdAcaWBpiN5FWuQUNZnNadEape6+/4k2xmtlGhFqxbf
 EI+WqtUsxvZosTYYYA/e8TiI9iB8AED5zAaHtTE8omg1bpVRTYK1o8cuqCAhXaJwiJj6
 hJ1Q==
X-Gm-Message-State: APjAAAXWOrHJ9XjSRMGWAr8JbUYUZlOK1aFMEJ+SUl742b4wygO5fJ+L
 O9fFrHR9jpdPxdWq8cRZNYfNaiqTcLonWA==
X-Google-Smtp-Source: APXvYqyyBv0imAtGgNX/o3wcnGVAO9K6Ot2bLp6jyY6DR6Y85djOmwlwR7L7OliNK1M5N9Nx2OwEGQ==
X-Received: by 2002:a17:90a:9b08:: with SMTP id
 f8mr21604314pjp.103.1560174654294; 
 Mon, 10 Jun 2019 06:50:54 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
 by smtp.gmail.com with ESMTPSA id d4sm13969837pfc.149.2019.06.10.06.50.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 06:50:53 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 19:19:05 +0530
Message-Id: <20190610134905.22294-13-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610134905.22294-1-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v5 12/12] qemu-iotests/087: checks for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 tests/qemu-iotests/087     | 26 ++++++++++++++++++++++++++
 tests/qemu-iotests/087.out | 10 ++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index d6c8613419..0cc7283ad8 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -124,6 +124,32 @@ run_qemu_filter_aio <<EOF
 { "execute": "quit" }
 EOF
 
+echo
+echo === aio=io_uring without O_DIRECT ===
+echo
+
+# Skip this test if io_uring is not enabled in this build
+run_qemu_filter_io_uring()
+{
+    run_qemu "$@"
+}
+
+run_qemu_filter_io_uring <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "node-name": "disk",
+      "file": {
+          "driver": "file",
+          "filename": "$TEST_IMG",
+          "aio": "io_uring"
+      }
+    }
+  }
+{ "execute": "quit" }
+EOF
+
 echo
 echo === Encrypted image QCow ===
 echo
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index 2d92ea847b..f0557d425f 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -32,6 +32,16 @@ QMP_VERSION
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
+=== aio=io_uring without O_DIRECT ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+
 === Encrypted image QCow ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
-- 
2.17.1


