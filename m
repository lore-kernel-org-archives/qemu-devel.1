Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE1FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B72206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4ADJJc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B72206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEib-0008IF-U7
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbI-0003gb-0e
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbH-0004LB-5n
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id p5so10241813wrw.9
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LK/4Qo6f+ZFTpUODCPrnJnwtXwRUNzbilhvZ9R6yVoU=;
 b=W4ADJJc6X3xO/DvyxxtK30S8n9f2uUs5I0jtmImRRBfLw7FrX1MfEZSd/OSDJG7SBP
 Xgtgm9pW4isLrerSZXJgUiCutstvU2pzTC5vqvtrTP/R6j0Fc48C9whGKA4yANIfT7tZ
 j1a+depkvkHAJOKVTpiWPKAQr8/YlVu5GWIV3xGBn6S2HARCjoLHpjzwJCBXlxmodGEp
 CKRjoxtpIooETibHPD9LuGqy0KxS9n6q2gM/6wgfCpBECUC1jcsXMLTQuW75uH96yPCC
 RFO5xNvPKvBZGmpefQmDAWDegY0VKcef306/1iwmXSQf69+JvCnSfaWp4583Vd2aDlnF
 +y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LK/4Qo6f+ZFTpUODCPrnJnwtXwRUNzbilhvZ9R6yVoU=;
 b=LocbOtNylol/jVwEJBhccYimzCNy8WXn26M9osgy9vKB1/doL16OMSPkkr6mhrnTwJ
 eBoT7T9xGE4c/78PJhJyr+gdMBWS2JgGDBP1eMozJNTxjw9T6JSS7Y5hegS6AXsrmlWV
 ecsRGGf7csbA9VVXJI0FDbExy+hP3nSscQbd7af33dDjNYevwDoy2WHonzTWCGBLMoa4
 LQ1fSiHl8FU5pl3Ao7RFipCWiTLRgYMEq4wQHgJkhNYmUYwh2U3RpJworamoSAQDZ9cJ
 oYX+Yi7mKLOjnPZFxPjk5T8fZd+ilYCIFjpEUhN8r/KRuZ+h5Ueg8cLu20Tf3S0C7EOa
 b72g==
X-Gm-Message-State: AOAM532+/eOXbU/FNlZdX0osr5ouZm/bcJ8IC/axtER9PawGaHPbtO69
 iNztfiu8/SgEz3/oVDR9GVweBVD3N7w=
X-Google-Smtp-Source: ABdhPJwUiJOXXwDi8auQozjNS+TnpDKXrDGTFCu5wKbmH/d0s/1ARucN8DWicMkEsWdZYlSjKukhUA==
X-Received: by 2002:adf:ca0e:: with SMTP id o14mr10974316wrh.254.1591372181861; 
 Fri, 05 Jun 2020 08:49:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm11102401wmi.3.2020.06.05.08.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:49:39 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6116D1FF8F;
 Fri,  5 Jun 2020 16:49:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/14] tests/plugin: correctly honour io_count
Date: Fri,  5 Jun 2020 16:49:18 +0100
Message-Id: <20200605154929.26910-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
References: <20200605154929.26910-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/plugin/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index 878abf09d19..4725bd851d8 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -28,7 +28,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
     g_string_printf(out, "mem accesses: %" PRIu64 "\n", mem_count);
     if (do_haddr) {
-        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", mem_count);
+        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", io_count);
     }
     qemu_plugin_outs(out->str);
 }
-- 
2.20.1


