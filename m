Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2224C3F2D7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D00620848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZJAZ4vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D00620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tjc-0004gu-Vp
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPL-0003mu-Rz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPK-0002kY-BJ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:35 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPK-0002jx-5J
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:34 -0500
Received: by mail-wm1-x32e.google.com with SMTP id p9so7065739wmc.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+/QONm9mCjYrTI58R499ADlTKWCo0qILa5h+DSFHsjY=;
 b=wZJAZ4vqdfbQhPQG6XzKi/ENSFRlc15CuB3vgz+eO999AlEUyvARG79aNATz3044Z8
 /MJYe8vXUi8ZxyUdRvpuFbW5mcVwDRuMuw/4NDrpgwVPowCHRfzPWrnXEkDDAVJX558I
 w0YPFCLnHpAhlsow9uBXIZi4wlOcejCOBGv5i+ZdyxaRWkDNz5vvNys6CQFBSpowLaKQ
 0fGUkt4buzYgZbNOxwgzmBYbemwh7uVHWzyfFuZpiKvsMuKe0twTYJGtsE5DcjemJdQW
 gGuHP7vrKX0PAwel8950WJYnd+zmBKWaHlwIXZ3GnSCU+P09ZyQkyn3R2nwybEOkXXWj
 ZNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+/QONm9mCjYrTI58R499ADlTKWCo0qILa5h+DSFHsjY=;
 b=dSVn/ODNtA6fo1N7SiesUuDC8+d7ir20kIkz3VjQE43NqE2tqEsY259+pCh+X7b6pJ
 aLin5LnIaLEsGQ5yE3gUvngbN9C1Fqajsklrr8R93x9sySrm4leMXCddIi5jJASf8oe6
 pepx9owCnP1Q6yrVe8Tf5BPTF2ZrXFI8Pcpt0mTyzpbhwvQWgThU4fM2NYVn9Ld0fC2q
 MRrWaz5wu9FxOoVFID0UZlGmHMkR6MI2ordiWNq6Tyo1myZJwxCwm439D0uTEfUwNBcV
 N2FHYpNgwfnGyuG2Scg7FTItPKG+ZLgq+ImLs2WWGt633IAHmDyXxqMjHrEbgOJ8iLyy
 fH1A==
X-Gm-Message-State: ANhLgQ1oVBtphM6U2Rjoq/18zZr8fEuTfiA1F9lqJmvdiFokPuqgxILT
 Goj2sWzc+meNRvb0Eq0Ue8plyrQRgUJB5Q==
X-Google-Smtp-Source: ADFU+vvU61SHWOjAXsG3W+q9wvScGyUTkOTbjEoxYZgZfxZ7Om+Aw+i6zH6xLIUzMaHQwuQNhVg1Yg==
X-Received: by 2002:a1c:9a45:: with SMTP id c66mr6240139wme.115.1583425892951; 
 Thu, 05 Mar 2020 08:31:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/37] hw/arm/cubieboard: restrict allowed CPU type to ARM
 Cortex-A8
Date: Thu,  5 Mar 2020 16:30:51 +0000
Message-Id: <20200305163100.22912-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

From: Niek Linnenbank <nieklinnenbank@gmail.com>

The Cubieboard has an ARM Cortex-A8.  Instead of simply ignoring a
bogus -cpu option provided by the user, give them an error message so
they know their command line is wrong.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200227220149.6845-3-nieklinnenbank@gmail.com
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/cubieboard.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 0195925c73d..010375f0a8d 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -30,9 +30,17 @@ static struct arm_boot_info cubieboard_binfo = {
 
 static void cubieboard_init(MachineState *machine)
 {
-    AwA10State *a10 = AW_A10(object_new(TYPE_AW_A10));
+    AwA10State *a10;
     Error *err = NULL;
 
+    /* Only allow Cortex-A8 for this board */
+    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a8")) != 0) {
+        error_report("This board can only be used with cortex-a8 CPU");
+        exit(1);
+    }
+
+    a10 = AW_A10(object_new(TYPE_AW_A10));
+
     object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err);
     if (err != NULL) {
         error_reportf_err(err, "Couldn't set phy address: ");
-- 
2.20.1


