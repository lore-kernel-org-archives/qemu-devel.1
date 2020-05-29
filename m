Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB43C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92AC2075A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seTKob3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92AC2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeiIA-000403-3t
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 12:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeiHK-0003HM-0N; Fri, 29 May 2020 12:54:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeiHJ-0002D4-An; Fri, 29 May 2020 12:54:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id u13so4222329wml.1;
 Fri, 29 May 2020 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+ivlxg/9+L3ywVTltPTiy1/JEXPqEKb3PlIN18vRHq8=;
 b=seTKob3dpRodmMIR8pF5r7fR55PaCsnfR2UfBwUaQqusJNxyD9cUutEK9517Wt5O1y
 7O32EH+miwAYBICRroX2krEf06uOtvMlsv8PVg0SIHtFEEzQMcivMnqU3PmMgsx3gkev
 OoSfZLxVkDRCpHfNUjwzmfWqfmXABh6+sGbM06TIiEwI9rl1tuGNftCZBSNlAbWI8vPa
 ORHce+damNatZiafN2ajdc7U7IArRWst4VMws3VWHmbHvZ1fK8njx1LltxcdMXk3To1k
 +cmXHERzb8XRat4aF/QUypfotBn/F/bA5Yx4znx2OHnedl+CjJlkTuEduIFQo3c3LcjQ
 Mu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=+ivlxg/9+L3ywVTltPTiy1/JEXPqEKb3PlIN18vRHq8=;
 b=pc2S7ybi6zqI9VYbptzuGh0hLaNcn6TQPRJP+uqyMtOI8VYrqST5sUnaLPPV3hxyr0
 EdUjdUdylEnX3B5odci4NPmdukzi6ZvIoFvamDmmhM3fWhHhl1bT2QT9HSnjgIsT71Ll
 HUH7s8Ak5pN8H3I0utOFI4Y40KL2tWnpbRSSmgiIq+c8OgcJeJVa2Fcqrk5K7ShewMUz
 f4ThEbfJEHSklO2TE9bx/3fhWyOsyUtkhp5OY1kUepAnmzYsixdiO+0BOzB/iPPqSpKA
 MkSYIVS85gFs6qhjhafvh5Abv6Tfz/UjcYleC0EpfJZqDiWAwL6gAH4lxf/94by02Lan
 ODxg==
X-Gm-Message-State: AOAM532xaUIzN4GFW3eQ6GJPAwsSFUxc9i1O+rR0tksEAxPXV7+EUgg7
 qscYWq//CWNnVwUrLcO0icpUkIiT
X-Google-Smtp-Source: ABdhPJyzoIVwp5JOk8FKRwu6YqT+11VeQwRGo7C7BmSMNVIK8Mh5KuNZOZlDXxC6sPQ9Wz0b9shQKw==
X-Received: by 2002:a1c:3905:: with SMTP id g5mr9322502wma.75.1590771278262;
 Fri, 29 May 2020 09:54:38 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id v24sm13801wmh.45.2020.05.29.09.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 09:54:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/display/cirrus_vga: Fix code mis-indentation
Date: Fri, 29 May 2020 18:54:36 +0200
Message-Id: <20200529165436.23573-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While replacing fprintf() by qemu_log_mask() in commit
2b55f4d3504, we incorrectly used a 'tab = 4 spaces'
alignment, leading to misindented new code. Fix now.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/cirrus_vga.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 92c197cdde..212d6f5e61 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -1032,9 +1032,9 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
         } else {
 	    if (s->cirrus_blt_mode & CIRRUS_BLTMODE_TRANSPARENTCOMP) {
 		if (s->cirrus_blt_pixelwidth > 2) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "cirrus: src transparent without colorexpand "
-                          "must be 8bpp or 16bpp\n");
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "cirrus: src transparent without colorexpand "
+                                  "must be 8bpp or 16bpp\n");
 		    goto bitblt_ignore;
 		}
 		if (s->cirrus_blt_mode & CIRRUS_BLTMODE_BACKWARDS) {
-- 
2.21.3


