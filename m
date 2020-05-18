Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810C3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5242E20715
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXMhyZvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5242E20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajqM-0005oO-Hm
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jajpQ-0005DN-KG; Mon, 18 May 2020 13:45:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:43330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jajpP-0005vW-Nb; Mon, 18 May 2020 13:45:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id i15so12832155wrx.10;
 Mon, 18 May 2020 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KcHC4TGOyn67sXBgQOlG94ry2lcg1ivHtGfLFBgEwsw=;
 b=dXMhyZvGPMXX/wvsjvPG+AeThYtMsyyf2cgQMqrwQeAo1fH/BjVTK0DbwyFZ9REZsA
 5vczL3EqXzsH50epnVhgitCbPSq1quDCiBKw3KeksjKg3xJhqMQObY94JuHDO+jnvzzd
 kjbZqOe9+fonoNCzsWNWsP1AKn1rryikfWb+3+zHMHjwiAOlJrpuAunKlnBpQwAathgZ
 OEtP7ULnIBBlH3grmagfoQF3PRsLW6Az6uHmX62dlBhQgI+fAsRkcsEaRR/wHRCALl7l
 sKVcIAggrXLnkWY6uny3NtViQS6/O2ZcQo/UlRmb5e5gjp4S9z3qSJ9UPFwhpXKItWq7
 7wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=KcHC4TGOyn67sXBgQOlG94ry2lcg1ivHtGfLFBgEwsw=;
 b=F7oMKObQvFK6d32NmiZGXhblwrnuQyFeJ5dPqX06HTSmI5Lfm/YqnaI+VFkXcMFgnT
 ch4u4HrIeIu4YDY2KLckKJozxwy3GviHtW31XbD108e4eP21ls2WaMVJqvDymTyeIstQ
 hrs9On1ADurv/TIJ17i2YaMr/gE5uCKwtOzc7cRCMkbHAIJXNtRCmkf1xtJL+Hv/QC0V
 SBQzZJIeq/iz36kVufXWg8ZPb5qoG6lb+IBsHIE+gMkjEvkKQiXT6UMs8xE45KKkuw1t
 +Uc2WX70pLU0H/jNeW8Yl5oo888RESnZpu/wz+HEJ9T6Lz9paOXzB9B25G0Oz5YvIkHJ
 WdRg==
X-Gm-Message-State: AOAM530pzEa6Y6eom3rZ0Zf2ue2PkODSr0a7OdLDSC0wOSRFt9EpTN81
 k5EQn8+rsLEpZY79JkdU2eY4i0EXdxM=
X-Google-Smtp-Source: ABdhPJwMUOugnIkuzsAUUfJHrUVbmlxTW7bNta0O8b4OwBSmJC1zb3JoFk/Be0Os9ObYi1tm5drtWA==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr18803568wrt.216.1589823925569; 
 Mon, 18 May 2020 10:45:25 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id x24sm18465304wrd.51.2020.05.18.10.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 10:45:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/display/edid: Add missing 'qdev-properties.h' header
Date: Mon, 18 May 2020 19:45:23 +0200
Message-Id: <20200518174523.18076-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When trying to consume the DEFINE_EDID_PROPERTIES() macro
by including "hw/display/edid.h", we get this build failure:

  include/hw/display/edid.h:24:5: error: implicit declaration of
  function ‘DEFINE_PROP_UINT32’ [-Werror=implicit-function-declaration]
     24 |     DEFINE_PROP_UINT32("xres", _state, _edid_info.prefx, 0),    \
        |     ^~~~~~~~~~~~~~~~~~

Headers should be self-contained, and one shouldn't have to
dig to find the missing headers.
In this case "hw/qdev-properties.h" is missing. Add it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1: reworded description (rth)

Supersedes: <20200504082003.16298-1-f4bug@amsat.org>
---
 include/hw/display/edid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
index ff99dc0a05..23371ee82c 100644
--- a/include/hw/display/edid.h
+++ b/include/hw/display/edid.h
@@ -2,6 +2,7 @@
 #define EDID_H
 
 #include "qom/object.h"
+#include "hw/qdev-properties.h"
 
 typedef struct qemu_edid_info {
     const char *vendor; /* http://www.uefi.org/pnp_id_list */
-- 
2.21.3


