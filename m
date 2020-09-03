Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B9AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE7620639
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwEX8IKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE7620639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx7V-0005uP-LM
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLw-0004wu-As; Thu, 03 Sep 2020 17:01:04 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:38503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLt-0007ph-Gi; Thu, 03 Sep 2020 17:01:03 -0400
Received: by mail-oi1-x22a.google.com with SMTP id y6so4514799oie.5;
 Thu, 03 Sep 2020 14:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J5mrcebEEpiZtia/WaO3DA7r7OpI7bIX2tDGLHmyEhs=;
 b=nwEX8IKyKQ6TAIjvlR2cfpkbAihlKBEihOhbC/fOnOiMXJ9pUJxOPnSawUZGUABA2p
 bPTHgS5cTadspvYZHFMP4h9I8YM0L0R+co3E30Z7ph4AjeIR7HB1RvRXxEOkwtRTO2dV
 TGmyOwR1WBRElufNieK0Zpk/YPoDaiAogwtvoPDDh3Eq3JyTzlT87evFM0RZPm7QfVvm
 aeJ2SdNEz1ir2uDIhFX7BiZLqa5whvDc5TpzCZyxvZVb21dirxsves9YELD242gRBTG9
 kndy2NuMBc9jNIrYqETHd+z2/MG5lkHiBIJT7IiTJUZCYzcmUbt2d0WYXSZ0QTCDVlxr
 j9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=J5mrcebEEpiZtia/WaO3DA7r7OpI7bIX2tDGLHmyEhs=;
 b=kF2qCqg5474k4bM/CCht0fIwPCuMh3vmC/HlDXhSdBRtcQ6daj9AXsKhVf2B+3nBrR
 TyKWwW9UryMsfk0LQQviRY3QpgMXryrtyMOhNSfk3Nn0DMjtfG6fVpT3g+CDJqJbTIQS
 Nywm50hYHWh6WOL6LClWiFEGcLQJaAGAQOz3NJYcbMHESu4vJxv4vAkR8UyCryeDUW95
 DFozfJT5uVJ3TL1eiEyr/Img+gWJCgZvsAF4GtbH7fyavghypUcxe7LilFZl0mlVgnOt
 h8QvTzdQmqONgJKg312he84uoLrbsV0Nb6BREHx6uQ/Uxr61IaGG+oFjKsbMmX0TbTBF
 Fpbg==
X-Gm-Message-State: AOAM532skcsyw6FRJsz8o/fSv6pgoOpa7A8F00jFLY9kxe2LwvEpBwqa
 5/pl7wxMblVEqSPfkXTVdBHVwLs/6BPr3w==
X-Google-Smtp-Source: ABdhPJypvYo3b+ibutqMHOkUgaTnTNWJsv5Lh1c4Kuv9x3z0NkReaNS8d62fwIhGRyHCuZ8lQdzvEA==
X-Received: by 2002:aca:eb82:: with SMTP id j124mr3356100oih.39.1599166859683; 
 Thu, 03 Sep 2020 14:00:59 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id l3sm842867oom.18.2020.09.03.14.00.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:59 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 59/77] qdev: Fix device_add DRIVER,help to print to monitor
Date: Thu,  3 Sep 2020 15:59:17 -0500
Message-Id: <20200903205935.27832-60-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x22a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Help on device properties gets printed to stdout instead of the
monitor.  If you have the monitor anywhere else, no help for you.
Broken when commit e1043d674d "qdev: use object_property_help()"
accidentally switched from qemu_printf() to printf().  Switch right
back.

Fixes: e1043d674d792ff64aebae1a3eafc08b38a8a085
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200714160202.3121879-2-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
(cherry picked from commit 029afc4e76041e1a320530d97f99122a1b3d5da2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qdev-monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 9833b33549..6bf6339ff5 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -299,7 +299,7 @@ int qdev_device_help(QemuOpts *opts)
     }
     g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
     for (i = 0; i < array->len; i++) {
-        printf("%s\n", (char *)array->pdata[i]);
+        qemu_printf("%s\n", (char *)array->pdata[i]);
     }
     g_ptr_array_set_free_func(array, g_free);
     g_ptr_array_free(array, true);
-- 
2.17.1


