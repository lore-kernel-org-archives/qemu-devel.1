Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B92C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 15:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC4A20874
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 15:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtHzzb1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC4A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK1fu-0003gd-SZ
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 11:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK1et-0002uD-MZ; Sun, 20 Sep 2020 11:53:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK1es-0004sz-3H; Sun, 20 Sep 2020 11:53:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id x14so10235632wrl.12;
 Sun, 20 Sep 2020 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NpNKL2s2eFl4dsz+xs9FYknazCQiYfioYg8R6EyiOVA=;
 b=jtHzzb1BDOKKKsMbLlzQTU6FIZqPekXYgq1Af5SfIgEWvaQtAG2Bio6V05oDD8+dB7
 rVBFAeSl59TY0KI0FYUhUA6cDlOHR2EShT4qjyBh1US4QDXZUuV6wssaOG+XlOwyi1yS
 BShbEOu2U8f/P3x/uTCO8xgb6QdfktB+FQN3uT0DSQxQ/+dod3YawpqAL6Bztoh82o2D
 RhGg45P0gVZn3s4nq1cU9NRltolIjhphG8GXRvpUP+81cOXncTu7xe7kqzTr1WdGBVQe
 dkFkxhqcAQF80ZBrovdLiuYjpIjPXY5VDYAWOvGRrTh8pWbFh9f4aBk64apcFYkkPZXE
 +Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=NpNKL2s2eFl4dsz+xs9FYknazCQiYfioYg8R6EyiOVA=;
 b=l0VImVKrRHZ1lXX9b5koG57hmeiKPkAgbfbsBg7ngBYtIUeaa9QpmexfDP5pAVBzVO
 DdzY71JrGQrCRG+D4MgwCuyAaiUYI87o7KbgR758U20S8kuPMvVg/0LcFNigFF5qPqtu
 iSRkouvJ4IMS2rueMNMn5TkL9S3/qJR2BK/vydRgJhEmCYywGbbphT01YKsG0D6IdIug
 rAEcjIp5h2ppW5Fb05yido5lR1hz9N/0vzaJUp/TG+jNHttkGtCRrrFRh0pJSYepTahX
 wfgsPVnahW75MdMnh9D7VKZaEODGPcINMCQ3sQWT1YA45WvtKnqiTeLtFQDv532SdrEr
 BCpw==
X-Gm-Message-State: AOAM5338epPcgUq1oP4D7qlat9cv0K9y7tN/hN0ls+Zx3KjNrbEEgN24
 AvwgREn7HxiR27/EPRX0/AUjlB+DZi0=
X-Google-Smtp-Source: ABdhPJyk4TPdjyUfSnhaqd5M22ij/B/DvIhR505DWBCmmT5jKFAaqJF/P6iTocDxsYaeGSIlBTLURg==
X-Received: by 2002:a5d:6547:: with SMTP id z7mr47814087wrv.322.1600617223133; 
 Sun, 20 Sep 2020 08:53:43 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n2sm16846253wma.29.2020.09.20.08.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 08:53:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] qom: Improve error message displayed with missing object
 properties
Date: Sun, 20 Sep 2020 17:53:40 +0200
Message-Id: <20200920155340.401482-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of only displaying the property missing, also display
the object name. This help developer to quickly figure out the
mistake without opening a debugger.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qom/object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 387efb25ebe..257914b1fe3 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1259,7 +1259,8 @@ ObjectProperty *object_property_find(Object *obj, const char *name,
         return prop;
     }
 
-    error_setg(errp, "Property '.%s' not found", name);
+    error_setg(errp, "Property '%s.%s' not found",
+               object_get_typename(obj), name);
     return NULL;
 }
 
-- 
2.26.2


