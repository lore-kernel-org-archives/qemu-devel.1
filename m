Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547C1C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9296921D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7+qtFh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9296921D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdZt-00031r-L7
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLx-00014B-8v
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:45 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLs-0006bw-VL
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:44 -0500
Received: by mail-wm1-x341.google.com with SMTP id e2so10222737wme.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rwxRQ2VGsaY/8EHSjzxMZ0dJGo8ROLSJrdHaZKDxSh4=;
 b=I7+qtFh4PXoSMdPKlefZ0gBI0QuK0+Yli7RHv1nbiPdtmvaF63ewIEDLE5DZ+wZb5p
 7rzTSkbZ3QzHhb64ECIyDaN2wEOKMzs4vw5g8CAY8ifqvtkuwPlfvVj3Htzbx9dPgCDo
 Ckg8T0zpAe+8v09uEmE7MNXaK7FE2enihFxAyQ8/dVA6vNwIBQpZINxSjIQbZQxK6RUt
 EONRn/9RM/wSt/SeJdXlu6+gf+cSXR8rEiZu5t8JlL6wKhLvkKI5iZbjSH9rbABcwxOK
 2LuddmtKUPinVIKT6aq9V0VdWw7tGNsUapZCSUnWhtK5qMG9BCIqQrOg7f8zKz9aJYAf
 XDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rwxRQ2VGsaY/8EHSjzxMZ0dJGo8ROLSJrdHaZKDxSh4=;
 b=oW/mwskpuD1wPKEMGJNALVfyrMaP3SNX2pdVid9DqQ0L5vF1447v6sMOtjxM+NTPDa
 +0b0mf8L/ZRk4mwR8ehiWd/tCiCdEkR9LRM7cQL40MU39ucTIuxhsrpJ1tG+fvMmBerR
 WRg+zFSYbntPVmCy7Ye0A+n/srmLkpvyePPQrLWdDYXeCQ7pM5/qHb8fTRUTD8BBAUV9
 xL7/Bb4JAlfQiDGLs+YgbG2jnVudVMYHJV5CJkcCcDwS/1NER8q4412EA1cLEj/IYaGd
 eJJp2z7pNaHhqNPThmHOlpaPGZYqRVGXA9piQsIqhj8J6zw82CZuzwu2K82vDfl+am9F
 5Jiw==
X-Gm-Message-State: AOAM532QwZCWkzLyAZmzQPEBH0YKAokroBp812cwnb/MnQqwNWCcI1Ow
 3/UB4GS6AaB286A2Ms8LMhSRt6aaFZuBBA==
X-Google-Smtp-Source: ABdhPJxpGYP9dRK2J8pZp7wI3fv+wcctz0bh2qCH9OJt6UgU/UjGT8wVN/FJknbHr+lKf5Bj8qB6AQ==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr18316543wmh.46.1604337038708; 
 Mon, 02 Nov 2020 09:10:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/26] hw/arm/boot: fix SVE for EL3 direct kernel boot
Date: Mon,  2 Nov 2020 17:09:57 +0000
Message-Id: <20201102171005.30690-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>

When booting a CPU with EL3 using the -kernel flag, set up CPTR_EL3 so
that SVE will not trap to EL3.

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201030151541.11976-1-remi@remlab.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 3e9816af803..cf97600a915 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -742,6 +742,9 @@ static void do_cpu_reset(void *opaque)
                     if (cpu_isar_feature(aa64_mte, cpu)) {
                         env->cp15.scr_el3 |= SCR_ATA;
                     }
+                    if (cpu_isar_feature(aa64_sve, cpu)) {
+                        env->cp15.cptr_el[3] |= CPTR_EZ;
+                    }
                     /* AArch64 kernels never boot in secure mode */
                     assert(!info->secure_boot);
                     /* This hook is only supported for AArch32 currently:
-- 
2.20.1


