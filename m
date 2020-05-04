Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01117C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07A4206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeRG7598"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07A4206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWLf-0003FK-0B
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWKg-0001vY-JP; Mon, 04 May 2020 04:20:10 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWKf-0004B1-SJ; Mon, 04 May 2020 04:20:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id s8so9492532wrt.9;
 Mon, 04 May 2020 01:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PbbgXN7TpEdPnmNI8ovAiJVme5Qx6T/o+UVD9KpDWbk=;
 b=aeRG7598TJ2ra2fjS0qi+ETvM44DVEbgrXXbwV6OoFqpDw2gXy3Xu4FMzo/ue1aa7m
 SR/Wb4DRo69vnELWcua1fVAUTt35Q5GMdc6ayzzNj2CDInMuyR5pNdAFHJuKczqtPN4L
 jTlLxzChpsjp3vNuFJ2d7qOsp+rJHzlHXHb0r3yAHdrnxIdgkC2iXYWLrjNSbPUW54rQ
 M6z3thjfhIszZ+8RdaGaWzLJlpzsVXiC3LO0GTK3sjH/C1o7pHXE86ZxOXdnoPp+7rxb
 qjRvkAbeHQQQnsVUW72Pugw7zedciUkJ/QRXngRlCZ/S6dzu4pOoc4bA4+NGY+8hEepT
 hHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PbbgXN7TpEdPnmNI8ovAiJVme5Qx6T/o+UVD9KpDWbk=;
 b=V7TnvtToh02n16YdfXHXmcLKfgeYKToBSVNjb+13cfSpsmUCCFXUb+vTBciGcYus1x
 oBAOxXgIoSjCwT0tz928vz+DYZ/xpmtkksnsTdG6x1EwM2nZQ+WeGduC3ZD9H9N9lvmW
 tDFcEgTFKO8ZhAyGaSPOSOubsvCdea4M/PkEea3jHG9JTGMsZJy0j+SHW00FVyuhjysP
 7pripz7+8UrO1UWebaQxOqjLQpUOQvFUf58p550z0sOtTrP0y/DeRVS3U9Pa0UYCTVZS
 4lw0pTnjaapiK0/ax2Y8+TyCFMVjokVuD18RmhYScUtt4otEBHpu28aaMCMlIuz7Q3jQ
 UiFw==
X-Gm-Message-State: AGi0PuZOFmhGK8AtFmyNYxMK9Sxmz3aFxhaIvEmWlZHcxQbeGj1xJi3x
 saF2DLy3QOPqUD1p3m1/JoKTpHAH
X-Google-Smtp-Source: APiQypKqHcFjRXDoNCtUXAF9e1hFG9jAiaG02ZNw/5YfoqfQc5ww4/p+E22vPZPN4uEJnBjl8EqXbg==
X-Received: by 2002:adf:9482:: with SMTP id 2mr16925484wrr.328.1588580407967; 
 Mon, 04 May 2020 01:20:07 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id z18sm17018816wrw.41.2020.05.04.01.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:20:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/display/edid: Add missing 'qdev-properties.h' header
Date: Mon,  4 May 2020 10:20:03 +0200
Message-Id: <20200504082003.16298-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504082003.16298-1-f4bug@amsat.org>
References: <20200504082003.16298-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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

To use the DEFINE_EDID_PROPERTIES() macro we need the
definitions from "hw/qdev-properties.h".

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


