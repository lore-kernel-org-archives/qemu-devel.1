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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECCCC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF57206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJPbOWQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF57206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGK0I-0006p0-MX
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJxk-00021d-4X; Thu, 10 Sep 2020 06:37:56 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJxi-0003jI-Ci; Thu, 10 Sep 2020 06:37:55 -0400
Received: by mail-pl1-x642.google.com with SMTP id bd2so709322plb.7;
 Thu, 10 Sep 2020 03:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ks2bOk3jYOHrXnI/Shz64S+t7ePZagOpQ3Ju/TypT6Y=;
 b=LJPbOWQ043DRYO4+6XyaJPyTFtk8trgg+ARlNxF4WtlnN359+uvOonmLeb+xgd28I6
 gNzyMTyyGlPb9q7iL6ALqfaCfZ3fLYtAHIUwRjO+AJf7EuvO8KpdljyAf2vYVfPR9DPB
 DaHtp+jyOAgill0K5gginlX3eR2Qex78IBwot6T1a/wwJO/l/FZBnmTSmx9O8EOZybPr
 ZI+e7CcbSQRZkpcBarghxky05QWQOjLCiYHq0H/ZphHK5POTTR6Q/y9Tj1ScHbSdh2I0
 1viUchcUzY/qu0nAUEZxigS6qfEkmNZin65NDL1YFEXw/pE122RRUSr20/a2UAk/842O
 psnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ks2bOk3jYOHrXnI/Shz64S+t7ePZagOpQ3Ju/TypT6Y=;
 b=Iu7DpTUS/VnjovRfIoHLIUiPUhDqM4OcGNm7mQhod29Kj+nRVD3tc04wkWlQTsbw+1
 jMo3XsWzTbN3pOVsNz85D3H6tDUXlPBeRTBrrP+ynmprDGU6fxbB6tLYk7f7sccNp+yF
 2jsKJjzkCEuXS7TiGj5atYgGhVV7b6H3De29p+LVORA48iQk5+/NvHkeyr4Awr6Xxi8Y
 tKWALGZ3TzhaiBfufTHp7kpJ37srSyQXP963jawxvzQIEKZ2jbAfWDlaYXtEMJwhuPBX
 Cs38AiGPF2Ro+2kBz6t1dVkGvuvw+x9dfzO2pxEDlU27u2q8ThzlDbT059LfAi+i4gDy
 huTw==
X-Gm-Message-State: AOAM531IFSCxNroaMcasfJGU/8ho7bF0uJfMgxZgTngwwWoGL7txVW1T
 DcrmPQ1qoqScxDmZ7tywo5XyO/KtdOPSizSFSJ8=
X-Google-Smtp-Source: ABdhPJzQkjvSzf9QVwlJbM7jyclFjK7keCBkixm4txYCAugJmvfVMemRz7C1bh8LHbQtZO5kYlqsxQ==
X-Received: by 2002:a17:90a:ead8:: with SMTP id
 ev24mr4752491pjb.89.1599734272490; 
 Thu, 10 Sep 2020 03:37:52 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id 99sm1781191pjo.40.2020.09.10.03.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:37:51 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 19/25] tests: Fixes test-io-channel-socket.c tests under
 msys2/mingw
Date: Thu, 10 Sep 2020 18:37:19 +0800
Message-Id: <20200910103725.1439-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200910103725.1439-1-luoyonggang@gmail.com>
References: <20200910103725.1439-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x642.google.com
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


