Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5BBC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FA420708
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8ikx+co"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FA420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGK5R-0007nM-3h
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJxz-0002Ze-De; Thu, 10 Sep 2020 06:38:11 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJxw-0003kA-T0; Thu, 10 Sep 2020 06:38:11 -0400
Received: by mail-pl1-x643.google.com with SMTP id bd2so709550plb.7;
 Thu, 10 Sep 2020 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BErOzaIvgNGZoOo8yO9vO+FZKR44ZCkaFrgaQmO82bU=;
 b=K8ikx+coiSbHYV1ZcqqhpM9vbYjQR/Cy5tXF2F/eNVG/2tmszb+K3TZbye9SOZgfCh
 YGNby6K12+osUGBo0zlf0rWYGzQw5jTrO+UM01EoIPz11LTIweU9nY45MS3V1F7JVwAU
 aE5/XOZgg0VLIp5eR12PYgrU7RSG61J+HBbxHT91/+zdz2lMGHP3Hf6JUOOKfy9CBUP6
 B2xh5+BwNFp8Dloh2PnftWogGRlxXdUJlV0+67f0N8xS5Z7DiOuHzgxyTT08KH12O+z0
 foK2XNFw0CvIMKF7tXPBy0URNwjPAry3uOmFw9nrwa703nMHieiuetynS6r2/U4HKY3f
 VeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BErOzaIvgNGZoOo8yO9vO+FZKR44ZCkaFrgaQmO82bU=;
 b=jFFkmUJdIofDM2bwl+Lg4h6kLso78JjRH46cxng0Z7SEwn+S5d0boLWTodtCkuASgQ
 fibCvZbeimumsryYsLdm0k8N/b66Fv/LWe13uYhtrAkTSYUMiiZcNUENUx1Lh6FaVtzO
 jvcb8s1dexzz8q//iIbdPm0PBSPrQayAzBEsx11TofPjoWlfoY+JVXE89yeFJIO/goUY
 NdYx3thgJ0ZGvcprIuOJn84Xqtoe9ks78+tYa7+NJitbVfIOXeZlRxNSw1Tcj8dxyJOV
 Zup+6LJSS2bJfZ+NV3alLPpWoaMGDVvLKItKvmU8N1W0APGelt2STtgu4hwlXqg1AhWC
 CnRg==
X-Gm-Message-State: AOAM531JSxNIF9Kib5MavmEWHWZtSJ1MAh5eeJUmaWZ7hTI/Nhu9PrGX
 TzkrPBAbBtMmEIXuQGdO2Vx7K6HKp57eFRBEGvQ=
X-Google-Smtp-Source: ABdhPJw+jhH+wIL1BRlnr7dVVvD33ZVdi6KYLtyk2C+h5e8dAHqujTiPO5Oo8Gh2khZp+1ySp/4vmw==
X-Received: by 2002:a17:902:ea82:b029:d1:7ed9:5470 with SMTP id
 x2-20020a170902ea82b02900d17ed95470mr5161041plb.26.1599734285391; 
 Thu, 10 Sep 2020 03:38:05 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id 99sm1781191pjo.40.2020.09.10.03.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:38:04 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 22/25] tests: fix test-util-sockets.c
Date: Thu, 10 Sep 2020 18:37:22 +0800
Message-Id: <20200910103725.1439-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200910103725.1439-1-luoyonggang@gmail.com>
References: <20200910103725.1439-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x643.google.com
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
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
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


