Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2225C2BA1E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A69020672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r89KObgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A69020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWHH-00013J-Lt
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrf-0002tl-MK
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVre-0003Xn-Jf
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:51 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:34537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVre-0003Wk-DE; Mon, 06 Apr 2020 13:48:50 -0400
Received: by mail-wm1-x333.google.com with SMTP id c195so140971wme.1;
 Mon, 06 Apr 2020 10:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mm7jSNJYavXwShirpz8lvWCMuX2O3KFlVxqJX30Lcf4=;
 b=r89KObgF91dUfddq+QxBROOTtATdLWm2Oc9daU3GVz4jwkgYpQNqeA4Q88mY4YM9V+
 OsN5UPL9fb8IE9iqJxJPM410q5OmOmXJcj/627TVa6V4P17Ao80pM4pwMXzNCWuZKIQj
 Z5V25edX9PrwU6mhDY/fQB3YynTMdDWVmJ43GkYOl2ND6haLD2WgtkdH0RNRDeWBehNa
 aubuhtFyVmwPUMq55F76AdmhnfAIv10CSCb/rXISb0kS1HVHTgdIby+yn20fNygGHheB
 624S4TE9VV76BORUsQBZ+51JQrr5bsNPYy8Kk6FnIbtaGQZddJukRMkyG8acblBSJKW+
 QSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mm7jSNJYavXwShirpz8lvWCMuX2O3KFlVxqJX30Lcf4=;
 b=LnjWaRtJLcK3FC1jn37ZGSKFzDJVkQN/oDGokLYAw5dRpdXvQHSwUA0OIRqMx981Y+
 sbGJ2YWQUlf4C2E7pf6ojQWStux7DkSvAyHDg3cq6Gt97SFPQj9iwvZvje/nRqkaQtMz
 8QuTWUmTK98fXF7DFSudKwOVsq293ZbJewGz0vtpM0sMn+tJ8J0vi8ARUpLSpgcrcgwn
 eRjATPrciu0r6mBJ5Cnsia4btyPa0GwUgQMvc+jJhpptkcUyI/bKdHBkNFQ3M4g4jeg2
 dBFOBoN0DmNUcKu6viU+5lEPGIhjSxU1fZOj0ew4pWSXEAAP/k3ZpDeslcoyMGJDoCLS
 ySsA==
X-Gm-Message-State: AGi0PuYo4Nw3eeiU4bFAENL7qUvk/U0EIHey6IqTos5JRNJrc4XedQhk
 1RIyURhYXbCdYxAzBDi/ihsHqgMu30M=
X-Google-Smtp-Source: APiQypKdOTW6Xx2hPMGBVycsB/B2TsQSxecWbRdYy33VYXS2XqH6z4cKaDBE+7RJr8ytWDwn8UBkoQ==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr167006wmj.3.1586195328223;
 Mon, 06 Apr 2020 10:48:48 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 44/54] hw/misc/macio/macio: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:33 +0200
Message-Id: <20200406174743.16956-45-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:Old World g3beige" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
    --keep-comments --smpl-spacing --dir hw

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/macio/macio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 79222192e8..fffb64a7d5 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -348,6 +348,10 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         memory_region_add_subregion(&s->bar, 0x50,
                                     sysbus_mmio_get_region(sysbus_dev, 0));
         object_property_set_bool(OBJECT(&ns->gpio), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
 
         /* PMU */
         object_initialize_child(OBJECT(s), "pmu", &s->pmu, sizeof(s->pmu),
-- 
2.21.1


