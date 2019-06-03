Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF90C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1A325A49
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DynfSc7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1A325A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36250 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXoU9-0008Tl-Kv
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:02:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hXoSt-0007iN-Eu
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hXoSp-0003sg-20
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:01:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hXoSn-0003lP-K5
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:01:30 -0400
Received: by mail-wm1-x341.google.com with SMTP id z23so11446187wma.4
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=VyhF5x0WzFov9r43y8si0eLCX0eXOqkE4ayiLm7MPMI=;
	b=DynfSc7EL7hZN/zwitvwwfWkq09dOSgZxOTnsDW9VQ/Up2lRvd580+rvR+fYmAr4L/
	K5BRNZkA/r+Q81tk7ohVY8yGz3BN/OrJlfvAlFdTD61dru560s52yJh/ushATBYZaiBD
	bP01b9LAdxR5r8Q4SJOuZEtN/luvUaI5ZLGR1esH4liaOkvvTgwRLDTfUjX4Jv0d1lSE
	NbqfQPTTkBOuShRIOOPfy+9vTrXHY6nR5Glj4J1OeMBsw39wJlI2jjWWXksfBEFBrv1w
	q3WNE8X8m6+I2PIT/tDrIVyhKCvP/kMkJRN41q37kSa+e1thUH/LQ/lArHh/c83g+WDx
	eOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=VyhF5x0WzFov9r43y8si0eLCX0eXOqkE4ayiLm7MPMI=;
	b=e0Zz16MPnxwNcLje7hx7RXX+K7ut4pfY9w2yuJ4yoZoxXtQcGFCcnGCySYgRLdAwhO
	jBqZW3MNj2neLriJYUKiEB7kE8DTk6uXwx1q5orjVvmvQW8z0HlCR5zAmTNk6rLu7Yda
	TcCWjjDmlRp439Ub2XmnP6gXx0yvLPmfgGfZ+smObM5nCDNElHcbczlyFcj6hVY+iY9E
	yTCgbnVQmdRC8cHST7Hh1MmDCHhJahaTGW+PN/tApdGmZ2nMWQJNI8R9FFu0pf3XJGNT
	2h5HEyuDSKUoZzkrObyomRcR/qtJnPoAFiGh2e0GyRcq0E5GeLaprIxuMmwQjlfT9Huk
	UNDg==
X-Gm-Message-State: APjAAAWuXQpUv+pZXzv6tP/jtRcusHAYJomIHA5bWirm3CZnnRQ3gq+2
	V/sCg60+EJ6FQI/gjBxY76Z/FQ==
X-Google-Smtp-Source: APXvYqxmeE+L9QrX6MYixllSnParujoSQRrE27rvx0DbgPCPaomHFBoWHywjGLAGISapLgNp2apTWQ==
X-Received: by 2002:a1c:5687:: with SMTP id
	k129mr14050053wmb.133.1559574086490; 
	Mon, 03 Jun 2019 08:01:26 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id p2sm5412769wrx.90.2019.06.03.08.01.25
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 08:01:25 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5EEDC1FF87;
	Mon,  3 Jun 2019 16:01:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 16:01:20 +0100
Message-Id: <20190603150120.29255-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [RFC PATCH] cputlb: use uint64_t for interim values
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
Cc: 1830872@bugs.launchpad.net, qemu-arm@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	randrianasulu@gmail.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running on 32 bit TCG backends a wide unaligned load ends up
truncating data before returning to the guest. We specifically have
the return type as uint64_t to avoid any premature truncation so we
should use the same for the interim types.

Hopefully fixes #1830872

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cdcc3771020..b796ab1cbea 100644
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


