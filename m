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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F2EC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829D621531
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge4TkZtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829D621531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHERi-0006xF-M1
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 18:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEHc-00044U-3A; Sat, 12 Sep 2020 18:46:12 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEHa-0004Ud-6m; Sat, 12 Sep 2020 18:46:11 -0400
Received: by mail-pf1-x442.google.com with SMTP id d6so9678985pfn.9;
 Sat, 12 Sep 2020 15:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ks2bOk3jYOHrXnI/Shz64S+t7ePZagOpQ3Ju/TypT6Y=;
 b=ge4TkZtAR+zIBsnkngBC+8ZPnxcHkgF3tpb21HevxpcyElI8T0+bcXfNHFBD790vdN
 vn5bBi/SwqmzvTuMn6aoee+eUyJ/wAiPYj68dNWDy4C+ol6cUQ5Sns+0hbgxm7vuis+H
 wzwS487vrvT9WB1A+0xU9xk65FeppXvFgjPlPwX3eQmo4xXs6U9hEH0MQA+AXlP0bhvQ
 Ciu7j1inLi+iNJu41KhFW9ZtBwkcsJZ53MnKta5NlqHmYI8UEwdF6K7Lk5c5dM7dPdKt
 ezRdZyZSQoxH176tR6xe2BDSFYPYE31kojjsq8IvPANvb/RhTqWtVMYSqLMfXss+5PSV
 YESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ks2bOk3jYOHrXnI/Shz64S+t7ePZagOpQ3Ju/TypT6Y=;
 b=P85Pwk156NvUpJ9XYCinLd5FtCPU8941kX2rVDxUcx16gEaz5WYQsXZJf0Zd5CmJkk
 15oxddJxkkkSUQFn+00MHzX7NZPXjDHDtSJ6q1UoQvaRAX/4+oxgeAw8ukVKMTIMkUy4
 /y6EeWK8uraYwYi3UrxSzwQ9wIXJaqAuQpfqo7SKG/fU4/3+4JkR+Q/bRpBdfL4xaMjN
 /7Zg8iIbcMotyaleNFziGCmsjtlqTScrgfZTa/A+dXOrUU2sr2fFZdF7G6UqbpIrzo3Q
 s54vah6xqMH7v5lv1ESBZVtvqE0TK9olMAJN4xcCnej1vG5SvlcC2H9r/vc3ztKxafTa
 Q2kQ==
X-Gm-Message-State: AOAM533ZWg5N+PpRX5cQTBjfTxPTCC+xugOOrrasQm29q9ka4664KzYe
 ml/z8R4YmiYs1emqTP3sBo796SLSnwYFGQO5tjo=
X-Google-Smtp-Source: ABdhPJxdeCUDjO6Slik77TTdsHiyBxXngb3Tt6JHgNCO83BjGZIHL277mJbn5yaWbbxAw3yEP368nw==
X-Received: by 2002:aa7:9730:0:b029:13e:d13d:a091 with SMTP id
 k16-20020aa797300000b029013ed13da091mr7796971pfg.40.1599950768210; 
 Sat, 12 Sep 2020 15:46:08 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t10sm4639266pgp.15.2020.09.12.15.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 15:46:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 18/27] tests: Fixes test-io-channel-socket.c tests under
 msys2/mingw
Date: Sun, 13 Sep 2020 06:44:22 +0800
Message-Id: <20200912224431.1428-19-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200912224431.1428-1-luoyonggang@gmail.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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

Currently test-io-channel-socket doesn't init with
qemu_init_main_loop
and that's cause the qemu_aio_context not inited,
and the following is the stack when null pointer accessed:

qemu_fd_register (c:\work\xemu\qemu\util\main-loop.c:336)
qemu_try_set_nonblock (c:\work\xemu\qemu\util\oslib-win32.c:224)
qemu_set_nonblock (c:\work\xemu\qemu\util\oslib-win32.c:230)
socket_can_bind_connect (c:\work\xemu\qemu\tests\socket-helpers.c:93)
socket_check_protocol_support (c:\work\xemu\qemu\tests\socket-helpers.c:141)
main (c:\work\xemu\qemu\tests\test-io-channel-socket.c:568)
__tmainCRTStartup (@__tmainCRTStartup:142)
mainCRTStartup (@1400014f6..140001539:3)
BaseThreadInitThunk (@BaseThreadInitThunk:9)
RtlUserThreadStart (@RtlUserThreadStart:12)

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-io-channel-socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
index d43083a766..743577d744 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -25,6 +25,7 @@
 #include "socket-helpers.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/main-loop.h"
 
 
 static void test_io_channel_set_socket_bufs(QIOChannel *src,
@@ -556,6 +557,7 @@ int main(int argc, char **argv)
     bool has_ipv4, has_ipv6;
 
     module_call_init(MODULE_INIT_QOM);
+    qemu_init_main_loop(&error_abort);
     socket_init();
 
     g_test_init(&argc, &argv, NULL);
-- 
2.28.0.windows.1


