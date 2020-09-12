Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FD3C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EB221531
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJTx9X/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EB221531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHER5-0005R7-Ov
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 18:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEHo-0004Y2-L0; Sat, 12 Sep 2020 18:46:26 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEHm-0004WY-TS; Sat, 12 Sep 2020 18:46:24 -0400
Received: by mail-pg1-x541.google.com with SMTP id u13so8788835pgh.1;
 Sat, 12 Sep 2020 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BErOzaIvgNGZoOo8yO9vO+FZKR44ZCkaFrgaQmO82bU=;
 b=BJTx9X/EsEwNVXeS9wKeAF24ehMS/BR2EWzSS3AUHwK/V1wltUVUp7T381A1vwhHlL
 zJpPwh5ShMdvr8Au6nuw2/5vZRRKrQy2hOFzWS7xCgCS5E5oz9O5ZZ/QU5UqLa5ZWOU3
 Ugf2TKz/9eYGmWx9+kXgPX43SSxdbgpDklEXGC/RlRIBwWyuchYxwQ4uFfq6jLeNW8ek
 eAaPYlGeJ/vFZ+gDQfj+RQeLKXc/HmBZotr2zn0ZMCuzRTnTPu0DfueiyNANUQ3iIrJI
 IZj3fvbUUbA/Y/9cnfeqFOlThOY+cYOwdspg9PyrRZWNSCWQDE1qCDCmiUl2BvwwzG0z
 2blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BErOzaIvgNGZoOo8yO9vO+FZKR44ZCkaFrgaQmO82bU=;
 b=KlG79sWAsxz8UeovSVAD/3BkTjw/vRIVwNgmMzMIIKxbEeZ1BAZad4bRcJlZouAlkX
 kF2/xFMKWNu8ob8hTUvVH/ud7+nKkeovFpjpGwzmAtjfOw/9onbgEZbQF2KvtVZO6S8x
 dWv5alUYczJl2TWa9QY38rAmZHGydaaY6Lfs67zcix5pxld7w4xXYWQ9QXA3LcL/DEXS
 xJ5yhUsrFgfNpDTittv762Nod7KPuY+GDWUSMP2BckZcok3wQ0ZEhGrw4Otz3/3vp2Xs
 uXvk1+X7XSbf5rQpd75iIZay9cIHGVyC1FKYxiCWVmT7kjBIbUtIpXjekADJYkLEpiuM
 Z+zQ==
X-Gm-Message-State: AOAM5304nctuQd0X/0tv/mZskjWG2zumB70I4G0skJkDkzky0ewWDi3b
 sD+GEEcsae92u5ixP9Nd+O3DWNu3W2+gHee5wis=
X-Google-Smtp-Source: ABdhPJyMqDAXOfgFl2eXg+PeLEHEbkT9jivK1UN6yP8FOKgvSVIdAPF/I+wlUPsLVXmBQybV7XiffQ==
X-Received: by 2002:a63:fc18:: with SMTP id j24mr5915096pgi.452.1599950780824; 
 Sat, 12 Sep 2020 15:46:20 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t10sm4639266pgp.15.2020.09.12.15.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 15:46:20 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 21/27] tests: fix test-util-sockets.c
Date: Sun, 13 Sep 2020 06:44:25 +0800
Message-Id: <20200912224431.1428-22-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200912224431.1428-1-luoyonggang@gmail.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes following errors:
Running test test-util-sockets
ERROR test-util-sockets - missing test plan

# Start of name tests
**
ERROR:../tests/test-util-sockets.c:93:test_socket_fd_pass_name_good: assertion failed (fd != -1): (-1 != -1)
Bail out! ERROR:../tests/test-util-sockets.c:93:test_socket_fd_pass_name_good: assertion failed (fd != -1): (-1 != -1)

First should call to qemu_init_main_loop before socket_init,
then on win32 doesn't support for SOCKET_ADDRESS_TYPE_FD socket type

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-util-sockets.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index af9f5c0c70..1bbb16d9b1 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -75,7 +75,7 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
 void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp) {}
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp) {}
 
-
+#ifndef _WIN32
 static void test_socket_fd_pass_name_good(void)
 {
     SocketAddress addr;
@@ -227,6 +227,7 @@ static void test_socket_fd_pass_num_nocli(void)
 
     g_free(addr.u.fd.str);
 }
+#endif
 
 #ifdef __linux__
 static gchar *abstract_sock_name;
@@ -321,6 +322,7 @@ int main(int argc, char **argv)
 {
     bool has_ipv4, has_ipv6;
 
+    qemu_init_main_loop(&error_abort);
     socket_init();
 
     g_test_init(&argc, &argv, NULL);
@@ -340,6 +342,7 @@ int main(int argc, char **argv)
                         test_fd_is_socket_bad);
         g_test_add_func("/util/socket/is-socket/good",
                         test_fd_is_socket_good);
+#ifndef _WIN32
         g_test_add_func("/socket/fd-pass/name/good",
                         test_socket_fd_pass_name_good);
         g_test_add_func("/socket/fd-pass/name/bad",
@@ -352,6 +355,7 @@ int main(int argc, char **argv)
                         test_socket_fd_pass_num_bad);
         g_test_add_func("/socket/fd-pass/num/nocli",
                         test_socket_fd_pass_num_nocli);
+#endif
     }
 
 #ifdef __linux__
-- 
2.28.0.windows.1


