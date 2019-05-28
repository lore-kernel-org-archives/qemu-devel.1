Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E3FC072B1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6821208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEt3BDV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6821208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60035 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYrS-00040H-SP
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:57:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk4-0006EO-Qi
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk3-0008V8-IS
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:00 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:47030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYk3-0008Ts-C7
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:49:59 -0400
Received: by mail-wr1-x42f.google.com with SMTP id r7so19444951wrr.13
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=pFgHz7Tht5qTVpx15EDKkUknXmNVbUsIScAUSfYzoag=;
	b=vEt3BDV4pVGNjDaQXTX598ft1XJRMAqvzxi0C6qvMjpHXBDahFdDF6/NATFVedpJtx
	Our/AVZWQmH1H5LelhWbuqAXamaKNkaMO9b5CDbbS/UEiScSp9X4+OCLm75sNgBY+ZxN
	uaLmiOP4GWh26W298e1/RM5K201pZZBBqA65AEDXvspaJpgyNQ9UnWqJVN/cxLTY8RYT
	I1L73NgGtlJK7MYNnkjWHDIm8SjOlNlMHQzqET/q8aIbvsTD/2sWzziY227F0sXkkKIQ
	q/6te+MZc2VYmGKLkppx1psXOqG+/sG8L5hvG59NJkxYsbKpDszCNEy31fmBakEb3QPd
	0E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=pFgHz7Tht5qTVpx15EDKkUknXmNVbUsIScAUSfYzoag=;
	b=F1zDQ3JwiXg1Omi4Z5MvnURUa7e4hsDMlB5EfwJaqc2ppiA07qDY0LgQbY35VkYYRF
	abd0BjvmyltKHJ1E1J04S8CZ8wloJIz7dAePWvguwzIL38zQLctRQL8fOxJw2e9F/bgk
	Vy/gXpx9AqaTbsZXqcNMPAUCHY98Xh9QoHjze9+bYeA3axjGwN4W+okIgHnTUTH8M3Rq
	A/I/Rmj10CdPG42/42s8D9StT3I9HICC52R2wKq0WRxCADJcswkEwRxbuP99CWfgO9cd
	cOSttYye51/eXGamzo8dYlDmnnMFOL8DKJfZ8HCE4jlDfZWTdMEYfuc/ssdBlxu/ERDv
	5/fA==
X-Gm-Message-State: APjAAAUxaD/aw8Y4a/Omij34dlFxEAFdJPvZH3BqdDr+C+sqDCEegZxi
	3iVn5GnMnZw0xNk9Puw88czH6g==
X-Google-Smtp-Source: APXvYqz7JHFowFTfkeWJs2ZsN9EchE/t4CT9Dd6IlfMTrddCXiPwJKhM2TBOK/SCG1QjMy0LZ0230g==
X-Received: by 2002:adf:e742:: with SMTP id c2mr25057764wrn.249.1559036998364; 
	Tue, 28 May 2019 02:49:58 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 95sm7704397wrk.70.2019.05.28.02.49.55
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:49:56 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 2C1C71FF98;
	Tue, 28 May 2019 10:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:33 +0100
Message-Id: <20190528094953.14898-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 08/28] target/arm: correct return values for
 WRITE/READ in arm-semi
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	"open list:ARM" <qemu-arm@nongnu.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The documentation says the write should return the number of bytes not
written on an error (0 means everything was written). Read provides a
buffer length and the return value should be the buffer length - bytes
actually read. Remove the incorrect FIXME's and return the correct
values.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 86e6ec48c2f..53e807ab721 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -331,13 +331,15 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         } else {
             s = lock_user(VERIFY_READ, arg1, len, 1);
             if (!s) {
-                /* FIXME - should this error code be -TARGET_EFAULT ? */
-                return (uint32_t)-1;
+                /* Return bytes not written on error */
+                return len;
             }
             ret = set_swi_errno(ts, write(arg0, s, len));
             unlock_user(s, arg1, 0);
-            if (ret == (uint32_t)-1)
-                return -1;
+            if (ret == (uint32_t)-1) {
+                ret = 0;
+            }
+            /* Return bytes not written */
             return len - ret;
         }
     case TARGET_SYS_READ:
@@ -352,15 +354,17 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         } else {
             s = lock_user(VERIFY_WRITE, arg1, len, 0);
             if (!s) {
-                /* FIXME - should this error code be -TARGET_EFAULT ? */
-                return (uint32_t)-1;
+                /* return bytes not read */
+                return len;
             }
             do {
                 ret = set_swi_errno(ts, read(arg0, s, len));
             } while (ret == -1 && errno == EINTR);
             unlock_user(s, arg1, len);
-            if (ret == (uint32_t)-1)
-                return -1;
+            if (ret == (uint32_t)-1) {
+                ret = 0;
+            }
+            /* Return bytes not read */
             return len - ret;
         }
     case TARGET_SYS_READC:
-- 
2.20.1


