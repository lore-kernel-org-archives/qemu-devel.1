Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C06C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244BE206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJpoWYTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244BE206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45927 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYie-0008Fw-D1
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:24:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYYhG-0007MP-RL
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYYhF-0008QD-NJ
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hYYhF-0008Ns-EW
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id f9so5392907wre.12
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=IDHocoT/qOpynBO1Yp20nQkSUYa2LGHJNcgaV0GU3E0=;
	b=eJpoWYTQmSpIk8itYd+znr5kZ/6/+hbXiC/N7oj8+8FxHOfPyqA0HsFN/chP/oWj0H
	kJyxxKwYDcCUWhMOSV5cDMgvCq5XoiSuntmwx3K/5HgczsAHWdmPW006KY7309zylZWC
	Z1wP3k/QoZzjnqQ/Zu6fALGm3venVAYuddEmFpLUjPhSciqiok/jdnDiphxSw+PR6F0i
	ii+VkJki3wrTewDCALT8ErI9ov4mOc7T/1BpEOkncxt1Wfq4RlVELF0eAmZpzs0sEIDc
	I4/N0lLONjltcnEqxU/55A9AH8Blo8yMAofA3q28aCkEP2YxzdPOFHrfwkm8TAKMrj1o
	CBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=IDHocoT/qOpynBO1Yp20nQkSUYa2LGHJNcgaV0GU3E0=;
	b=fbtI5OXW8+hnVlAjtDBIu9HnJT4mHfRQJDNPy9EzNt2ezmrv1kpdPWTKwUdAHpHRih
	s5698FDrP5cZ6Zi7WJ1D5sKm4tzDvWgUdUWhNIl+z8oaHgyEKXJcDcgdQTN3tP4eYAVg
	drAWvB8MeTbSuQVbQOtVR83fOHoiD+g7MUCTVwBNg0hV4QhBMlywKvJ0NUOrxvR77y8j
	LQoWDXctiY/serBOj+Nn8zh9LuZZLZMqDXUoObC5xSM5Txe+R1SyH336pqaYgIv0xgCR
	PJ8O8KMI98XTDvSqZf6iC3WSQFu8QGZvs8s8MQnMK+j56CWtgsI4ulNoJV7eqw6IkO33
	J5/w==
X-Gm-Message-State: APjAAAWwi7H2ZAG705i10R0TqTZ+wd7SiZsSbj/a3EoGt1XhwjfVbmg0
	mO0bz60vCn5mq6SL86UXIUmoQw==
X-Google-Smtp-Source: APXvYqwv/GRukQkosxZ7cpaW6GcBU3k62AANwM34GjysyWdny74wMa+dJxalNE63Lk3JYrigCgl7ZQ==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr11221398wri.213.1559751808088;
	Wed, 05 Jun 2019 09:23:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	w14sm5355889wrt.59.2019.06.05.09.23.27
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 09:23:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A51621FF8C;
	Wed,  5 Jun 2019 17:23:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 17:23:23 +0100
Message-Id: <20190605162326.13896-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605162326.13896-1-alex.bennee@linaro.org>
References: <20190605162326.13896-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v1 1/4] cputlb: use uint64_t for interim values
 for unaligned load
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running on 32 bit TCG backends a wide unaligned load ends up
truncating data before returning to the guest. We specifically have
the return type as uint64_t to avoid any premature truncation so we
should use the same for the interim types.

Fixes: https://bugs.launchpad.net/qemu/+bug/1830872
Fixes: eed5664238e

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
---
 accel/tcg/cputlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cdcc377102..b796ab1cbe 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1303,7 +1303,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
                     >= TARGET_PAGE_SIZE)) {
         target_ulong addr1, addr2;
-        tcg_target_ulong r1, r2;
+        uint64_t r1, r2;
         unsigned shift;
     do_unaligned_access:
         addr1 = addr & ~(size - 1);
-- 
2.20.1


