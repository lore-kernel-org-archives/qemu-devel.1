Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08F7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75EEE20870
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9vBj7SX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EEE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdT0P-0008EN-Mb
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzL-0006QR-02; Tue, 26 May 2020 02:22:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzK-0002Se-9Q; Tue, 26 May 2020 02:22:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id r9so2018508wmh.2;
 Mon, 25 May 2020 23:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SgLfard/QkYYaxVOCOSV6DhAdq/g3xj9+l6N2FqFR44=;
 b=r9vBj7SX91M+JbFbuINmfHYf+CRoECvQsK5TM99jK0b56LpXVtgXMYTPPP4bRHhBlC
 vgvh6TW7/sG65gfJJGGFTRXnkeFbKszcqvGpyESOMZ4R3Xn1mXrRQXjv/PNrFCBjL1ZN
 yfvBlTMSsNBich3WdzYRcQnwPlMq4zd2ZpI5fq7BoNHzWPSadDeznYLGRjEGAO2Il0NV
 Xz9w2QOuDI1XUXLbmiCcQRf8NS64+Sx6wP0otHac5uQ4tm0/iVU3S2BqFai2va6Y9o0s
 hplUpNjPu5LMLZGnWRSrUfz5QgIVsoLzhY6bJEVEOqCOvwMNaE9zlPtLGh7N6hJVQeOs
 SWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SgLfard/QkYYaxVOCOSV6DhAdq/g3xj9+l6N2FqFR44=;
 b=bgZju4zsUSnFdbPRlNr+5K4+L4jUaI/brLiLQ3+OXZTdOL4vLvAWPH9hrM2gGTHsnk
 eZsN1k/0BgL2/dtRXpagMNUd6bLLgHnylSzl0LG/GoBKiXKFWKwEdsNfMtyONEVGBWNw
 z788XxMqTf+UJ0h0Cmpd0LRjxBZ2cG4OCOfXqR0IUpACeB1papboP9oplcK2ZKkvdT4c
 gi6zX6o5BBtjgcBrOSiYrAVftob31JPOmcC/dWkRn0lw5sm5L9rsHzC2kkxDzQ/2n5zR
 hMVT2h/rZwZTl/Y72VmhzDskD7o6Kw1D+8Ub+KJ/qdaF1nTZ/xxBE2LH+Dby/9lidsFA
 1l4w==
X-Gm-Message-State: AOAM532YJ88N2TIk4ApnAafo5emiPsIN5X4Itsg0Pk2J0gQ1tGQEY51L
 CQNyBruy/OJXosiQKleBlCYmkqX5gxI=
X-Google-Smtp-Source: ABdhPJxE8WfAg5pu0frxXboyl3hFsxZi4Kr5KAdXI22fqeOLBpz8OjBJIJBIUDLGmPRuppC9RkXXCA==
X-Received: by 2002:a1c:9cd5:: with SMTP id
 f204mr21021904wme.105.1590474176489; 
 Mon, 25 May 2020 23:22:56 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a16sm5764745wrx.8.2020.05.25.23.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 23:22:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 01/14] hw/display/edid: Add missing 'qdev-properties.h' header
Date: Tue, 26 May 2020 08:22:39 +0200
Message-Id: <20200526062252.19852-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526062252.19852-1-f4bug@amsat.org>
References: <20200526062252.19852-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


