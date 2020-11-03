Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0556DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51ECB216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VilcuFdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51ECB216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZutd-0007vL-4s
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZus3-0006hx-Hv
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:53:03 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZus1-0007Ft-9X
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:53:03 -0500
Received: by mail-wm1-x341.google.com with SMTP id v5so12428043wmh.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ngJheC9QZOVPanmRgme/165PV51CnDzzeIFAgC08HO0=;
 b=VilcuFdls26gLVgsa91KRKORdtXWWIpogLXNC2OYGmOLyz3H3G4gQLlsDWF0lDsBab
 aXMRduQD2xWW+U9EDESQRXq3Tm+ZQmwOjWSipZJTNxGFPxig//MCJcPwBMDx9m2IJ3nl
 DliepYV8Z6+pjt47ciGaBYxQ6hKpm/E5+H0rS+7JnzRAWjSPHToviyuBqTfZg8IYa8m/
 NHRMk0L1y4U4fVvsFSlYtIuNLyHcwZwlrve8ykfiek2t4fbh/pzL+MRArVinEkWwhozn
 0Lzn+SooZP6/F7B1wMFy10JXYV/EpzZISNjXUPbuhd2NgExcSTf0+E+8TW6yGjA0M6PC
 UQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ngJheC9QZOVPanmRgme/165PV51CnDzzeIFAgC08HO0=;
 b=aL38Jl90knHMz9JpRtd0wCxaDkTHeE4T1fRI1LqRrgsDNWbP0UUUgnJIDgk891FH32
 k62mvKc/Yp0299W+JYt2O9/LVUYJS2otzWhuDnWlPOGeY0FGIpRRoluOAH0pW/iYmg1h
 xJFMzwA6cr1oN8hE/+blHbcd14QyRtqbvEYt31mt/ULRA3FFNohe/JPm+urfHgtHxn8F
 VytF5fcrJO9llTBiX48lOFp1L0caeMps9ob56ViE2YFhKS/1xGBj+CYHRgDKSlgxruwu
 mNidY8Zbn7GtmhJKtYsbfGVrJFP5h6CDiu5TwEM2p+BATByBbLg7PMvV8QmmIyAwDZ6x
 ykhw==
X-Gm-Message-State: AOAM533M36jWwdy0dh7sgAqyirReHA0Wp2xoqHhuyv1I6e0hPTwMtdO3
 ll3sYY0RoXOk+mFKyyW4tePuadqekthayA==
X-Google-Smtp-Source: ABdhPJz5UhJkBt0isXuGzCsNnRv7KPfpamfvvZb0Vdy13vZV0wRy7IN4ICwYuy0nx90PWB+SxJjeBg==
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr3360224wmf.133.1604404379539; 
 Tue, 03 Nov 2020 03:52:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g138sm2621092wme.39.2020.11.03.03.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 03:52:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/libqos/ahci.c: Avoid NULL dereference in
 ahci_exec()
Date: Tue,  3 Nov 2020 11:52:57 +0000
Message-Id: <20201103115257.23623-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In ahci_exec() we attempt to permit the caller to pass a NULL pointer
for opts_in (in which case we use a default set of options).  However
although we check for NULL when setting up the opts variable at the
top of the function, we unconditionally dereference opts_in at the
end of the function as part of freeing the opts->buffer.

Switch to checking whether the final buffer is the same as the
buffer we started with, instead of assuming the value we started
with is always opts_in->buffer.

At the moment all the callers pass a non-NULL opts argument, so
we never saw any crashes in practice.

Fixes: Coverity CID 1432302
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/libqos/ahci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 2946abc15ae..fba3e7a954e 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -637,10 +637,13 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
     AHCICommand *cmd;
     int rc;
     AHCIOpts *opts;
+    uint64_t buffer_in;
 
     opts = g_memdup((opts_in == NULL ? &default_opts : opts_in),
                     sizeof(AHCIOpts));
 
+    buffer_in = opts->buffer;
+
     /* No guest buffer provided, create one. */
     if (opts->size && !opts->buffer) {
         opts->buffer = ahci_alloc(ahci, opts->size);
@@ -686,7 +689,7 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
         g_assert_cmpint(rc, ==, 0);
     }
     ahci_command_free(cmd);
-    if (opts->buffer != opts_in->buffer) {
+    if (opts->buffer != buffer_in) {
         ahci_free(ahci, opts->buffer);
     }
     g_free(opts);
-- 
2.20.1


