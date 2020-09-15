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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B3EC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80EB021D41
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeAlc+PN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EB021D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEhH-0004NC-Ky
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWz-0000BW-PO; Tue, 15 Sep 2020 13:14:13 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWx-0002kP-Ud; Tue, 15 Sep 2020 13:14:13 -0400
Received: by mail-pl1-x642.google.com with SMTP id x18so1684450pll.6;
 Tue, 15 Sep 2020 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ks2bOk3jYOHrXnI/Shz64S+t7ePZagOpQ3Ju/TypT6Y=;
 b=XeAlc+PNskaW0TsZ6wLSwzkO++M5no96XeJ+BEymzqQbQyRrQjLye3CKjeThyHurM3
 jMSjq7/wSn0j04Fs8ltK/W93arJt3LEx4FXG5xGgEHklDp/fy3OrYG8npnZ+uJAsVEBn
 Bapo8/95FR2Cz2HYlunAVqVwOpGBlOtEWKYr7N/qYenzaRIg8OPzU6KRZLIhyLt7AWZd
 LCq1G16s3xPT2rKngq7rk/OiToDkTPCMzQrqND9Glx/xwwh18oKVUhobsFl83MAye/h9
 N/sEsIH8ONflK4/1FPKWa/O9TKJzLov8JoUQdd1pI3jxQG9OPgPomBBA7GiRd2bw3Ibe
 FEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ks2bOk3jYOHrXnI/Shz64S+t7ePZagOpQ3Ju/TypT6Y=;
 b=i4E+g+tTEFmYRckQsJxJ+S3CmMbwVgs5sjgXPHUV/WQ0ANjDB+dN6LPV4ZlC1K+gil
 /scOOIOvQk9YD3/AYXKP3BFCRGlo/43p8Jiiqo80w+lMPzt6QobraCKu6jxJ15CvLsjk
 SO9LM75rvSGFKsxfpsjI5S6uj0r2HmNZv60TMzyCCH01ZYiyB4HuT61eVWlayN0lb8nA
 6Pg9qYtCL1Fv/bZm3qNB/mScUTJtEBngCwQMKCxYu+3FMOF+SjZFsPiG5LZ+f/L//46B
 mVQ7sZfIPCS7DCN0Hnsw1MXiZRk1V9Ec1B3XZmmzelyQGXqveuVDQrQxVg5q/MOyYcSF
 dUdw==
X-Gm-Message-State: AOAM531Pb3MGiVckCLVf4PVK4RowFjtKaCmuOA/VPSqSx+1a8tKZtR4a
 uL2/XyH+X7BztPsVkPpt7i7elgohoXun9eja+es=
X-Google-Smtp-Source: ABdhPJyQUTmkgKkJ0fvFp+YpueSlTJkES3GO1mJnS623YpWVGo+0LQjZT389u14+Cyo248jBEGgUsQ==
X-Received: by 2002:a17:90b:198:: with SMTP id
 t24mr324950pjs.107.1600190049739; 
 Tue, 15 Sep 2020 10:14:09 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:14:08 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 17/26] tests: Fixes test-io-channel-socket.c tests under
 msys2/mingw
Date: Wed, 16 Sep 2020 01:12:25 +0800
Message-Id: <20200915171234.236-18-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
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


