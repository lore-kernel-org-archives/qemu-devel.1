Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACD4C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C758A206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOElpISv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C758A206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWOd-00073w-WF
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWKf-0001t9-EL; Mon, 04 May 2020 04:20:09 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWKe-0004AW-OF; Mon, 04 May 2020 04:20:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id x18so19823662wrq.2;
 Mon, 04 May 2020 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5um2VutMcMyz1W7NMgIn9QCQS94pWMtYeX9COgbWKDo=;
 b=MOElpISvOpWudjsbZ6EQc9rByIhGw5gBNz6FfRSO+g9X39Kfphr7kmY/VwRJBLjXzR
 pOsDeV24hmisC3HBT7af7R5N3XP2azPbj7I1P4aXZPKLogUs7CBoLmYo2emTGdhCHlyw
 /IXKUDaBvPckTka1kSlPuXA7ZG2Wiip0eTb0FwvXMN87qmayO+oyjC++RiWfCVAKepEh
 a891vutvhCNCk2O54s4E8M3OD2jknKe2xudAIb0OCqmJ+VWVQt5IYpt/azcqMwH0tHKT
 a5p+xTugAzN8W8D3q/m4dIxUz0v4kXbhxZh6FaCsdZeZDgupGNyu7QFXkgQIeYri0AhK
 t+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5um2VutMcMyz1W7NMgIn9QCQS94pWMtYeX9COgbWKDo=;
 b=WNeaRh65/4A8vIEVjkwHdhOnWg7G0/3m21338o/Iq+25QXdHlpvquU0v5/suEp1zsB
 mP+TOtwdabu8CftKLwjDE47wg2xPwzqMNMj/oGDBXTcqJ2jaqmmkOIfTAtNpCaZISUqU
 ClUMo5HD/i75Chmo6cKV0NDYntqdw9wLIawbZR/pXwV8iiIe35JAvcALn1ua6mbdsqrB
 bUh+M3nnuGj6IQ3A43IptGFDhdw7GIomatyr8A9oEmWcuMbP8FgTzhy6/hdS2PAA7Hlp
 PbQF42+6StKzEbnacud9EZMUM4Cq6siieRUlLXmoFKHk7YzC0rI8UQypK5d1lM68PP6W
 8poQ==
X-Gm-Message-State: AGi0PuaPRdlsVzRd9NlW5Xu7hZtdWIbo5cjtmnximS8EF995NI5idseu
 BLNsMkrHmikROaZ/O+aUGKdHcLMc
X-Google-Smtp-Source: APiQypK/55zAV7QVHfYcpLQdoLJeC40DL+cVf3sufI9ea/wORq0DZP81LVVKPPgPr6W4s0nZento3w==
X-Received: by 2002:adf:f4d1:: with SMTP id h17mr17146714wrp.69.1588580406893; 
 Mon, 04 May 2020 01:20:06 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id z18sm17018816wrw.41.2020.05.04.01.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:20:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/display: Include local 'framebuffer.h'
Date: Mon,  4 May 2020 10:20:02 +0200
Message-Id: <20200504082003.16298-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504082003.16298-1-f4bug@amsat.org>
References: <20200504082003.16298-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Thomas Huth <huth@tuxfamily.org>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "framebuffer.h" header is not an exported include.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/artist.c  | 2 +-
 hw/display/next-fb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 753dbb9a77..e1d5885fed 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -21,7 +21,7 @@
 #include "migration/vmstate.h"
 #include "ui/console.h"
 #include "trace.h"
-#include "hw/display/framebuffer.h"
+#include "framebuffer.h"
 
 #define TYPE_ARTIST "artist"
 #define ARTIST(obj) OBJECT_CHECK(ARTISTState, (obj), TYPE_ARTIST)
diff --git a/hw/display/next-fb.c b/hw/display/next-fb.c
index 2b726a10f8..b0513a8fba 100644
--- a/hw/display/next-fb.c
+++ b/hw/display/next-fb.c
@@ -27,7 +27,7 @@
 #include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
-#include "hw/display/framebuffer.h"
+#include "framebuffer.h"
 #include "ui/pixel_ops.h"
 #include "hw/m68k/next-cube.h"
 
-- 
2.21.3


