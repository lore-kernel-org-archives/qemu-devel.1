Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5942C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8363A218F0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjFVat4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8363A218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgkO-0005nU-Cy
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48366)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqgk0-0004bY-H9
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqgjz-0007EZ-CJ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:37:16 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqgjz-0007DE-68
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:37:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id a15so45582588wmj.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yM6cVpuxn4Ke92kaJ4AKkVK8RWiK/GxhKcUyMJM8z1M=;
 b=DjFVat4FH98pFLbbLk+slSWzmsHNOwovfvZGBlQivOkRG7faTKI4L17ghY1gr0OT8e
 dEyxzQp+sEZb3zmxy7p4NEuXHEF7dcSOCLREPlVQlAj4jq2CTp1s8Z7uawZ5Y70Ri3Pt
 FAJhHPaygvT7rEL4jNOQhJOjPqvDTSIo30Le3qdEd+D1Vkona5/NouCdJx7jMD4A/l9F
 iVLcDOn56kRqGdAVpTDhCTP7hQBJgih1aaeC011DEupvIoEerSecl/hO2aNq2+/HFQFP
 FDbau2qt4aMqfbZl/VGXpo/Zfh+LzDy01qmuQ7L+Bo8wrBo+rgFpZ7IWU8Kuz02NG5CZ
 W4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yM6cVpuxn4Ke92kaJ4AKkVK8RWiK/GxhKcUyMJM8z1M=;
 b=F3PUCcFM2EDAF1DzV+SpxO5J1c/9vVuTeqOWWvA1CIJiUPspjSyrIJ7MZWUobffbzA
 9QhaOfZwqf3+mbzE/WHSpwULg7LdvJsQduVryuH8nN6c3sTFKdDKhKCfk9miKmMyvVnz
 CXyZeHh7G10KULCZH+0ZcBQtECuvMLOpEsh/LUk+6tuTcq2GGuv3/KBtpGruSjijvxaw
 2vSmczx6lLsGmLjgwccs82fneKWoUA0ppjZKwFCQJUJb3RI20vu99fosNImtE59/r9Gm
 3jjWLGKJ4nHxdDa5uD89LcJsUye8QDXFwdVMgWv0nujDzlIrHZSm35g9A0Hag42GhovB
 zxBw==
X-Gm-Message-State: APjAAAUrpVpee70+0Yv08a30J2PfiTAFTwPjGk+XYTELA2NpB0Xz2Mjv
 znDZXosFX1VTemQUi0Ovsxs9ZRwROtD1NQ==
X-Google-Smtp-Source: APXvYqzjRObidkUUfzdjentlnvHNZgkWCtmlb67xi5wGU1sjg4idDDa2EPCiD3rTMRScFiWPS8NO5w==
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr82974403wmc.95.1564072634239; 
 Thu, 25 Jul 2019 09:37:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c7sm44125140wro.70.2019.07.25.09.37.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 09:37:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 17:37:09 +0100
Message-Id: <20190725163710.11703-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725163710.11703-1-peter.maydell@linaro.org>
References: <20190725163710.11703-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH for-4.1? 1/2] stellaris_input: Fix vmstate
 description of buttons field
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gamepad_state::buttons is a pointer to an array of structs,
not an array of structs, so should be declared in the vmstate
with VMSTATE_STRUCT_VARRAY_POINTER_INT32; otherwise we
corrupt memory on incoming migration.

We bump the vmstate version field as the easiest way to
deal with the migration break, since migration wouldn't have
worked reliably before anyway.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/input/stellaris_input.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
index 20c87d86f40..3a666d61d47 100644
--- a/hw/input/stellaris_input.c
+++ b/hw/input/stellaris_input.c
@@ -60,12 +60,14 @@ static const VMStateDescription vmstate_stellaris_button = {
 
 static const VMStateDescription vmstate_stellaris_gamepad = {
     .name = "stellaris_gamepad",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_INT32(extension, gamepad_state),
-        VMSTATE_STRUCT_VARRAY_INT32(buttons, gamepad_state, num_buttons, 0,
-                              vmstate_stellaris_button, gamepad_button),
+        VMSTATE_STRUCT_VARRAY_POINTER_INT32(buttons, gamepad_state,
+                                            num_buttons,
+                                            vmstate_stellaris_button,
+                                            gamepad_button),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.20.1


