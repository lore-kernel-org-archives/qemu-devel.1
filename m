Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19B8C33CA6
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4D922464
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cV4bn0u5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4D922464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igypo-00071P-9w
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybM-0005HT-QD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybL-0007Lx-SM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:28 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybL-0007KP-Mx
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:27 -0500
Received: by mail-pg1-x543.google.com with SMTP id k25so4491111pgt.7
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cdzUkCGd4j9cyI7GBjpMOiOf+nGUeT9o9Hdz62SsCpo=;
 b=cV4bn0u5eECfrX2GrUnPV61AzcgZZE/VVrp095/QIKfcrYRjOqZ4F3k9+ChlpH9+AR
 nTfk7UfMUXXbGHrOCNgevSgcniQr/zGlGb11u+lbH5rWtYV2YeZc2TliVIr7oX39zZxp
 bRAls1ERUwHtIPdcEBHxgxAoeEKjCNlsv/PgGONfw3mwp422UfQLqH2SKKHeXikR3Ljv
 FV9V1shyK/vi6fKZl0oB3Cn47sI7CzU1MyQSh5dHgh2JeL2ZifdP7l3kNvyYrHFPcN4J
 v4qJ7181ZuDLnD2M4IExRUHq3/eyGub2QohcbMizzv0I2IKsVzyBEgfEEsEEMs8v7iaf
 ANJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cdzUkCGd4j9cyI7GBjpMOiOf+nGUeT9o9Hdz62SsCpo=;
 b=UlhHV1+JuruSHfoyhUe/NuzMmYvbAsa45HMpayLi3//arpSh9S2rcBmVGnSUy9aJ8K
 /XVscYicybG4MaiUTbj3kDoTfAjnVJlc9M5OdOouueyc2XmGpQEoHd47oAUZ/LXoUyuH
 KaMyFmoCwpYUadwdpvgz0ZwuLcHehVRZqj7i51Zo67Nn/nltfaXVahWI4KqXCp7cYzcV
 GnFfYe4L7t9nC8jq3kpYmR17Jm6OrTPLxGVpjJc3a/ywTTgJxqj6tUWueXEcLwdP5UUt
 llN5qzz8cM6I2k0ATk4u0UGkJGlcqU0Zs4cDHdok3z2VEKGpSK0xgd3U8/f/Gv4rwkVy
 5bCg==
X-Gm-Message-State: APjAAAX3IwlyEAVYHPNRqS+KuiSojRzGID1DcxLMMzeB2amE0/2c03o+
 561j+pNBr3VVx6cY+uUMv7grzJZk4ZU=
X-Google-Smtp-Source: APXvYqyoFuTVqBxOuvLXtOZp5GPnvTWzpUUVReyVDZDaLVdWjBZxRm7EVj2zMuVQlDvprttExyFUhw==
X-Received: by 2002:a63:5056:: with SMTP id q22mr20839449pgl.20.1576534346514; 
 Mon, 16 Dec 2019 14:12:26 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/28] target/alpha: Remove MMU_MODE{0,1}_SUFFIX
Date: Mon, 16 Dec 2019 12:11:46 -1000
Message-Id: <20191216221158.29572-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index a530249a5b..3f782c0efe 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -193,8 +193,6 @@ enum {
    PALcode cheats and usees the KSEG mapping for its code+data rather than
    physical addresses.  */
 
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_KERNEL_IDX   0
 #define MMU_USER_IDX     1
 #define MMU_PHYS_IDX     2
-- 
2.20.1


