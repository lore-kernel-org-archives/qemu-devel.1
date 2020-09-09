Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AC8C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC38E21973
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzw57DVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC38E21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwtt-0004ZB-ON
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 06:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwht-0007yY-Og; Wed, 09 Sep 2020 05:48:01 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhs-0007oE-08; Wed, 09 Sep 2020 05:48:01 -0400
Received: by mail-pf1-x443.google.com with SMTP id c196so1820776pfc.0;
 Wed, 09 Sep 2020 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QpJB9KhDFroEY186G+IS1GoMDL1LgPmHhWlmX/8IYNM=;
 b=hzw57DVRB+AmY9PbkSSNOSXzrrAWKSRDCtsa9BblQc/JhPUIUzrziaXWmEb2WontrF
 mosQVaQLyhm0Ht+MQuyzz9xe+hszBSLkaOMES/9FnLsHityBR/w2M3805yseGLt/r71m
 anS3/i1l5WPkjIcQa+j3N5HQo6Pt2ZOLsyyb6zPgsPLKZlYBI9DRJOvI/QfTtUge0m/3
 jiy8QlYl2QVbOXxQBug7MCVaS6TGU7dylkBq+dAs8XvMgZtq0gqT2DDg6sBpCH9eHb+j
 VLTGkAx2JiNuhkhACJ5oXPE/doIyoVAPaxmtH64OHcONvdaSo4gBdRk/gmLCaMOY9v3L
 HyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QpJB9KhDFroEY186G+IS1GoMDL1LgPmHhWlmX/8IYNM=;
 b=DRntxiZb1f7Y/EFHNDZHt3LQqNkatN3c2umjhk/srJYVc7m43eGDkT/MDKtv0+3h4k
 MkKP+H1wa9UO+NTcI4+0CZS192Nev8bE52G+jDIupqQ8yOLFtHS6l3gytspb7tXoF0OY
 iOZKVaPm0Za34pbfnaJPywjZRfuKNdbk3zr0GmddL1enSinGMYyrCZFFVr/P/VivA8qO
 8mG+VcA3iq19sUbYIzlJkHm2/d0RZRM3am5h1x9lAuf0YwHvuow/epkmPoPt5iqtbnJx
 mHBoArfeMZWKkOYz9LiEYZEYwCH/DEJTsQszB2zDYRLnCF84S5/s/BSX9+KXizwGCrSf
 MZIA==
X-Gm-Message-State: AOAM530QIhPN76Bb7aW2jgsBfHwF1R1lENIlUDhkiJvTtkjzqVaTYBZY
 kDzrNHt0ROrIduNKQunxe+XR5EEMoVABeoZ1
X-Google-Smtp-Source: ABdhPJwT5fhpwxd69ydVPWxAMyqhgPNeIt9J9OXZoGgwmas+I7QqELIPKML0wpdpUvoA5qnJVI6gSw==
X-Received: by 2002:a17:902:7886:: with SMTP id q6mr22435pll.7.1599644877928; 
 Wed, 09 Sep 2020 02:47:57 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:47:57 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 20/21] tests: fix test-util-sockets.c
Date: Wed,  9 Sep 2020 17:46:16 +0800
Message-Id: <20200909094617.1582-21-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x443.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
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


