Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82BCC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB41522370
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9Vu1FYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB41522370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxJ0-0005ZC-Pi
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZxGp-0004Sr-SX
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:26:47 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZxGi-0003jh-Px
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:26:47 -0500
Received: by mail-wr1-x442.google.com with SMTP id n18so18773038wrs.5
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ehb4eb1aLZYFa7m4upl4i1sttuC1RAgb1Up0JUUrLu0=;
 b=y9Vu1FYBr05CNAThFBfuYIxlfyl2p3H6cX5hIlw1WiurumdGPvCwSz8s04cjhI7Pn9
 NFIQUk4yEdN+/R1s9jYeUsj2bDTl2bmdMNdjfY4TxMHh9j3kekq8w8C1EvVdP73IoiID
 SCuw18k4PiQe1L+8GY0zkKq/zBZcL4kNJN+/aonVrjwlLoZEYbq9BWCDWFn0g4W92BWe
 cGDYJvk0S1JttmxaHvlZUZuZWpz/WW0HIB/K5pK8SingUmFhH+KzLzzuS4jM275IKFjr
 GpjRY87wqOha6u0FIsqC9WJwB6ciSenF9qDplVh+cSCZe6LYEoNklx5cRQV4+mH8Vd18
 K3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ehb4eb1aLZYFa7m4upl4i1sttuC1RAgb1Up0JUUrLu0=;
 b=Ni1O5FFI+4ATo9yaP70wy1W7RmrgIfh/CK7uwUj9lHpuFGd5CazMx2UO7eowLDoK2R
 bDatqt8pl3iCZxtQrznRHT6vxnkn4ALOpc1ZKSgHCMXSVcN/SkJ21nW7tBIccv7SKuo6
 +ob281c3z7h7fP/PjIzZORTfkvjw12pQH2i5CjkHN789nOwrFstqo+7WLU25r/rIA1qG
 3Nz0CSLfvjZ7yAVdNtDjGjlfJiJW9sXh9EcAgwPYm0FF1tRf11qHIG45DxfcnWzpI5o1
 Qj/y4S1hCiz+SGHkkVlbD6ywY97clJHqAlFFtVvbZ+BM7HVRP9axz5jDC1qRSAQAj31B
 rl0Q==
X-Gm-Message-State: AOAM530qewrsr0jqV//XaWi9n+CDWDVek6pJGIUfHXh5fSIVWFZ/Jyjl
 iUhIWhW6EKhix1H5G1z4E/TOnjJ94SV7uw==
X-Google-Smtp-Source: ABdhPJxehxhuK3NNpWMJCEKL/rLWAf5VJRhrv2Vsl/7XnAsbTLxiiFbE2E1tzzWK5V7QYpVQAE/ewA==
X-Received: by 2002:adf:f643:: with SMTP id x3mr27820750wrp.180.1604413598781; 
 Tue, 03 Nov 2020 06:26:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l3sm3470838wmf.0.2020.11.03.06.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:26:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Use "!= 0" when checking if MAP_FIXED_NOREPLACE
 is non-zero
Date: Tue,  3 Nov 2020 14:26:36 +0000
Message-Id: <20201103142636.21125-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In pgd_find_hole_fallback(), Coverity doesn't like the use
of "if (MAP_FIXED_NOREPLACE || ...)" because it's using a
logical operator on a constant other than 0 or 1 and its
heuristic thinks we might have intended a bitwise operator
instead.

The logic is correct (we are checking whether the host really
has a MAP_FIXED_NOREPLACE or whether we fell back to the
"#define as 0 to ignore" from osdep.h); make Coverity
happier by explicitly writing out the comparison with zero.

Fixes: Coverity CID 1431059
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e19d0b5cb05..0b02a926025 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2188,7 +2188,8 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk,
                                      PROT_NONE, flags, -1, 0);
             if (mmap_start != MAP_FAILED) {
                 munmap((void *) align_start, guest_size);
-                if (MAP_FIXED_NOREPLACE || mmap_start == (void *) align_start) {
+                if (MAP_FIXED_NOREPLACE != 0 ||
+                    mmap_start == (void *) align_start) {
                     return (uintptr_t) mmap_start + offset;
                 }
             }
-- 
2.20.1


