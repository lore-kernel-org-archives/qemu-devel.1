Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EDDC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87203216B7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxX5HRgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87203216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr21L-0002aw-Bz
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37523)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hr20l-0000lk-4e
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hr20k-0006xA-0S
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:19:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hr20j-0006u6-Oi
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:19:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id f9so54799355wre.12
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Za/0QQNRcEYp14wTAGlfMqArIpeP/+fVrLhYpi/aXKo=;
 b=sxX5HRgdTWO/NTfywZMnJHz76vwBHIMqrxWN2WKCseCjmRK1ILIrP3W2Gmtd2Ii1O1
 F+hytU+j9wDlHaumWML1uKbyT3n6aKu565k5zFJv+BsTXTWusJUQbtfsfAInnPVeWdBl
 RsUy/0yDlZwgyLPMohKXK53HlARzzRUthpM3p44/ITJ0CKHPHpZcfEpQA9RDvsM+a25T
 I744GIdL8oG0px7l1Quuh2aKBSg1hPkS9FzD7POHj/Rx8990QJjUkpVNPMCn6j20POb4
 Q8bWSMZOmtBLcbt3bfesGxQ1cXCC2P6IS8Q5PPMZ3SerqR8s5/VR2Rek+7kRLrjoS//j
 vJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Za/0QQNRcEYp14wTAGlfMqArIpeP/+fVrLhYpi/aXKo=;
 b=c+YCm8AHL4Yavhm3/Jlf7GxmJpdAsZfQcDY6alutLD/kaeMgHd3oI7RXIKD9i5tiD5
 rLChV5QgSlU2G0xtrLQMMWFKZ1q18jEDJspqaX3QiX4CeylcvwuQ0JJvI/RfXGK0agy9
 vOZ5J8unzlk9BOXKFE9aYa4fZbIzUWgtFcYiRxFzw+jXr0JOtx0vSWvE68qhFuKy6daR
 7iM4dQe3CZKymhSZYiD9sasDNYB5bzBQdTJrVSRvoGxNG0ksSa1R1ukhPX6pgj9otvYU
 h9GbDCqODcw8pMFFJ992v2IDgm80iYV9tmn67fSwYPJ8IW2fLPftzB00MXFyIeHCYNWV
 VorA==
X-Gm-Message-State: APjAAAVjCrbo7q2m0wAeyXPNtMfgGUpRroib3WDjJP9UlKpbmfb50/Hk
 EJOMa7iYR3vVYJ0IYyV8cXu8Q57sRJC5Lg==
X-Google-Smtp-Source: APXvYqztAKgud2AK8jEVn/uM0V+/Er70pDUmafpVpB04i0kbrgbfD+zIERwauAY+wyDcOKJo5bt7DA==
X-Received: by 2002:adf:f348:: with SMTP id e8mr997139wrp.76.1564154396609;
 Fri, 26 Jul 2019 08:19:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v16sm32746844wrn.28.2019.07.26.08.19.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 08:19:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 16:19:49 +0100
Message-Id: <20190726151952.1932-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726151952.1932-1-peter.maydell@linaro.org>
References: <20190726151952.1932-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 2/5] stellaris_input: Fix vmstate description of
 buttons field
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

gamepad_state::buttons is a pointer to an array of structs,
not an array of structs, so should be declared in the vmstate
with VMSTATE_STRUCT_VARRAY_POINTER_INT32; otherwise we
corrupt memory on incoming migration.

We bump the vmstate version field as the easiest way to
deal with the migration break, since migration wouldn't have
worked reliably before anyway.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Message-id: 20190725163710.11703-2-peter.maydell@linaro.org
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


