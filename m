Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76376C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACBC206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQJe1JlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACBC206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAPa-0003M8-R0
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rb-0001tP-Qi; Tue, 15 Sep 2020 08:15:11 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rZ-0008LR-JM; Tue, 15 Sep 2020 08:15:11 -0400
Received: by mail-pg1-x541.google.com with SMTP id y1so1880489pgk.8;
 Tue, 15 Sep 2020 05:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BErOzaIvgNGZoOo8yO9vO+FZKR44ZCkaFrgaQmO82bU=;
 b=QQJe1JlCqlwTYES5U3ztYVuTFygN0q3ELhe7/4SyL4Gjhd/venDnNAqrCTEwsriNsN
 5jgDIJ8yjgQRq5XYfM2vUzut3BuBqb6AFCtpOnTpL1rs8wVAxK2OQilNejW0G8quG5zG
 Z4I6YE5folluvVCCmD20gMt22mvyoyul8n6c/1P8y7HZDcjuosRpTAU7Ka5tXiaFWOT2
 RKRQ84QiyEDITAz15ogVt6+qrG5lQUMM6Tv00GXVA3R4PyEZyH+3BD4T6umEjimBmWsB
 tcS/2/or+j87Mtsv1Xc8qEo5ZWMYccBAJkYURbx9+KepO/0NZQXaT6c3Qyg4hLHrtiXc
 5f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BErOzaIvgNGZoOo8yO9vO+FZKR44ZCkaFrgaQmO82bU=;
 b=SrqOrNKRPsDQqkM92j9+9K7RNsH3ctmuuGa+2ENb6QgN9rHk4XNUf/NGOptkUkNUue
 9oae0WZHy7rc17KaW7O3rq0249af97h0U8kGGevF8yum8dMO6li6R8h0yNp4Dmj1KmgY
 tBt8tKndwnb6BIpNPUz/ZuhMo45HBgOzzKM8FbsBvhI/I7IxmdgDJZkQ3KPW0b0kAJcB
 1pSk9sMov0y/uzZCCHrF9ha18JW7fWHv8LIBvhGbTruUAYiFgpWcdyxSHqURJVrT3DJD
 Boi1Zjethm9nf1OGE4rwngAtUXfuV6PBqYX8OjQqb1oy9NGNQvK8qfxDuv17UhXKENNx
 QYng==
X-Gm-Message-State: AOAM531sfunPI4OPyXtLPlKpjYmBBowm4HvV/XK1J24C+0+8MwV9vSZ7
 sXlT3R6P9rmiqtwg1yhdfIQ66PjcsbZNAEdVjJA=
X-Google-Smtp-Source: ABdhPJxeZuhLBPz4WQtc9uumKcnVAgveodmD0fwT0Hj5kgERHz2uCnQXnHGjnpE56xG6H95O36FPig==
X-Received: by 2002:aa7:869a:0:b029:142:2501:34d1 with SMTP id
 d26-20020aa7869a0000b0290142250134d1mr1665456pfo.42.1600172107393; 
 Tue, 15 Sep 2020 05:15:07 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:15:06 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 20/26] tests: fix test-util-sockets.c
Date: Tue, 15 Sep 2020 20:13:12 +0800
Message-Id: <20200915121318.247-21-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
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


