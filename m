Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5675BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8032A20897
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRTcLLmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8032A20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcA0m-0006IE-8G
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 11:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc9zv-0005qB-BI
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:26:27 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc9zt-00013m-D9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:26:26 -0500
Received: by mail-wr1-x432.google.com with SMTP id r17so5417615wrw.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 08:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2Kp5G6NAl/4Ozn39Fuzw1TyeEONDPWC9AzDa/Y76zzs=;
 b=QRTcLLmOWTaORQ5GaVmNXspbSP5lxiAUNlETusbxcfF+m1xiFkZljiQq/SKui9BQrg
 wR9E8R4Oot8ijhhhC4Tc8ZNFmVg2TiYNZPNVFkrHTRDXSmh/c3LyUPIm0amnG1xIGdD4
 ZLmftP0Pczz7jYZea2gMM/WvQ8RxJrsPbaG3uDrthezFcTFQOkpdxmDkOGno2xgb3yNB
 4iUot0d/dZnYmXwCjVZlskKNc9PD1mOe09A+lAENKtElekCsoBjICQ5+Gukh+b4bL6AJ
 1i6f0EXXSRldZm+ADU25RvyP1Lmjn3PInEfUt1lolqAmm6pmbunmaX5vjVIy7jzCwMt1
 xacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2Kp5G6NAl/4Ozn39Fuzw1TyeEONDPWC9AzDa/Y76zzs=;
 b=qzTDd3x/ypcUNvh8yNoAAAi8QU7vzP6ZuPNaJj4METYWCUmjLA9ew5psHtBY5VpdCB
 UIPnLPJ6iQhtHOMtxNW1+1eYYsplYM+15DK0LYyiLyRxYiRmiySvXYEZJ/1wTSuoGMHC
 ns8BuKUCwwMWHKfET4yCCkeCiU2ff+AtpIlzecZN2fdF9g5wHRNrRzUOWfp1YdlI32wo
 yVYTQciDI0a13eojqEW9UEG6cgCq3aeu1fBlSAPvHaEu+sZbMr8z7sWyWkxW+eU2LR3B
 6N1Yo/aHHP16nulZzL56qbdImhVocfFJiLcuGclAh6FlGaRwIDgyFNtU/OIDu0NSfoCO
 9vHA==
X-Gm-Message-State: AOAM532NIxyLSyzPlx7+DBZhY1VXfMeLHoYKJS+TXpdWXDXU1HFtc17v
 kIUhTBoJqGh56Ha9Xa2u9/16CNKnyHAzSw==
X-Google-Smtp-Source: ABdhPJw3xp8EgAP+2O+P2qlivMoY6H97SrKAEgGTUo57ZMV7zw4ly/GN642OUUVS6Z7cOBNOiAdVlQ==
X-Received: by 2002:adf:f24b:: with SMTP id b11mr4316680wrp.342.1604939183496; 
 Mon, 09 Nov 2020 08:26:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j127sm14168976wma.31.2020.11.09.08.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 08:26:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] qtest: Update references to parse_escape() in comments
Date: Mon,  9 Nov 2020 16:26:21 +0000
Message-Id: <20201109162621.18885-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 61030280ca2d67bd in 2018 we renamed the parse_escape()
function to parse_interpolation(), but we didn't catch the references
to this function in doc comments in libqtest.h. Update them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Side note: ideally we would document somewhere the accepted
%-escapes rather than requiring people to read the source code
to parse_interpolation to determine them... "The argument to %p
is qobject_unref()ed" is particularly non-obvious.
---
 tests/qtest/libqos/libqtest.h | 18 +++++++++---------
 tests/qtest/libqtest-single.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/libqos/libqtest.h b/tests/qtest/libqos/libqtest.h
index 5c959f18535..724f65aa947 100644
--- a/tests/qtest/libqos/libqtest.h
+++ b/tests/qtest/libqos/libqtest.h
@@ -88,7 +88,7 @@ void qtest_quit(QTestState *s);
  * @fds: array of file descriptors
  * @fds_num: number of elements in @fds
  * @fmt: QMP message to send to qemu, formatted like
- * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
  * supported after '%'.
  *
  * Sends a QMP message to QEMU with fds and returns the response.
@@ -101,7 +101,7 @@ QDict *qtest_qmp_fds(QTestState *s, int *fds, size_t fds_num,
  * qtest_qmp:
  * @s: #QTestState instance to operate on.
  * @fmt: QMP message to send to qemu, formatted like
- * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
  * supported after '%'.
  *
  * Sends a QMP message to QEMU and returns the response.
@@ -113,7 +113,7 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
  * qtest_qmp_send:
  * @s: #QTestState instance to operate on.
  * @fmt: QMP message to send to qemu, formatted like
- * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
  * supported after '%'.
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
@@ -138,7 +138,7 @@ void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
  * @fds: array of file descriptors
  * @fds_num: number of elements in @fds
  * @fmt: QMP message to send to QEMU, formatted like
- * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
  * supported after '%'.
  * @ap: QMP message arguments
  *
@@ -152,7 +152,7 @@ QDict *qtest_vqmp_fds(QTestState *s, int *fds, size_t fds_num,
  * qtest_vqmp:
  * @s: #QTestState instance to operate on.
  * @fmt: QMP message to send to QEMU, formatted like
- * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
  * supported after '%'.
  * @ap: QMP message arguments
  *
@@ -167,7 +167,7 @@ QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
  * @fds: array of file descriptors
  * @fds_num: number of elements in @fds
  * @fmt: QMP message to send to QEMU, formatted like
- * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
  * supported after '%'.
  * @ap: QMP message arguments
  *
@@ -181,7 +181,7 @@ void qtest_qmp_vsend_fds(QTestState *s, int *fds, size_t fds_num,
  * qtest_qmp_vsend:
  * @s: #QTestState instance to operate on.
  * @fmt: QMP message to send to QEMU, formatted like
- * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
  * supported after '%'.
  * @ap: QMP message arguments
  *
@@ -636,7 +636,7 @@ void qtest_add_abrt_handler(GHookFunc fn, const void *data);
  * qtest_qmp_assert_success:
  * @qts: QTestState instance to operate on
  * @fmt: QMP message to send to qemu, formatted like
- * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
  * supported after '%'.
  *
  * Sends a QMP message to QEMU and asserts that a 'return' key is present in
@@ -683,7 +683,7 @@ void qtest_qmp_device_add_qdict(QTestState *qts, const char *drv,
  * @driver: Name of the device that should be added
  * @id: Identification string
  * @fmt: QMP message to send to qemu, formatted like
- * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
  * supported after '%'.
  *
  * Generic hot-plugging test via the device_add QMP command.
diff --git a/tests/qtest/libqtest-single.h b/tests/qtest/libqtest-single.h
index 176979a2ce9..0d7f568678e 100644
--- a/tests/qtest/libqtest-single.h
+++ b/tests/qtest/libqtest-single.h
@@ -47,7 +47,7 @@ static inline void qtest_end(void)
 /**
  * qmp:
  * @fmt...: QMP message to send to qemu, formatted like
- * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
  * supported after '%'.
  *
  * Sends a QMP message to QEMU and returns the response.
-- 
2.20.1


