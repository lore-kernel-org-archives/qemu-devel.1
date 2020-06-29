Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7398CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CE7206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMuL/Mbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CE7206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4Ov-0003Uu-GM
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 20:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dn-0007Yi-Ah; Mon, 29 Jun 2020 17:48:39 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:41281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dl-00086k-0N; Mon, 29 Jun 2020 17:48:38 -0400
Received: by mail-ej1-x62f.google.com with SMTP id dp18so18373358ejc.8;
 Mon, 29 Jun 2020 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=EcjXyZClBQDI6g/qulm6+AdcW0n0dE3vmvE1TCbQQjI=;
 b=pMuL/MbpQ+Cd1vZizVp5J0g4dHKhBqmkdVyON/i0gCUa0SblHR4SbvzM++OWdSeakX
 IgMMP1SH5jPCTbfrNeWXR3q0xdGxPkDk6iiXL5wFrNsaNNeft8RlEF+tpWM1pNXPLvM5
 gwCVFw+suvY2X5u/wjpmopWaL6E3H3ZPfoull1GK7CBFaIVBoD/ZcKNyiKD2pm7iRkmv
 I+kVdEbfX+pXlioRwCngPXOAuREB86WBjmjAZ+fV3MTtVy04cE6oTvFMsgzc5d1bdvFc
 6iNZ8SLI3fos+BaP0BsIZIJOnqIOGQD4w7D8m+F/obKdQ0ztQatWARKbrAtokeiIJUUJ
 aCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=EcjXyZClBQDI6g/qulm6+AdcW0n0dE3vmvE1TCbQQjI=;
 b=YygYuSVkaAzB6HIrvEhEaoCpCb6Na40Ik/Yy7w535Ycmpzi3v+2HK6TwZjGXROq93x
 0eFdQLTM5veyAlmBJ8MYm4jMesmltZso+29RUjQJYSybTV0s79tJ4tL1L9PizRjby1Aq
 wc+Ynt/E/Lqvp3KExkoB7LBLtp21GCwD3h20aUiTeLEJxG7UiebvAo7V2CLF4bZEaChG
 7RgHRNmrtnswH/h/pv647Ynjs95yiDUjwjwH5IHZuF1Xm7d1tcgJu0S52voHQ7utTTFu
 82TxlECV9PQFNBI5n8AWWsM+Uqlsy9J1EQKOPFRKfA2cKKfOU/Zj2h+VpZtBzLP4Gmlw
 kDRw==
X-Gm-Message-State: AOAM533mOKEbmwKcIVhCWR0ul0+tevTt6r5cfvPxybhPdtgPwhVcjE3y
 bgdfROxAmLMtNspdEhje5Q54msuybsTNlqdlEjSO4qKFx150oQ==
X-Google-Smtp-Source: ABdhPJxzO2H3vbcaIqXLJIWTcCW+5OHfFKZdz/R6rvoFa4n92emecD0BR2QtGVwRXvwhNIRBJtZYD6ZcUgnsFNfVJ6Q=
X-Received: by 2002:a17:906:c083:: with SMTP id
 f3mr10083290ejz.530.1593467315100; 
 Mon, 29 Jun 2020 14:48:35 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:48:24 +0100
Message-ID: <CA+XhMqy6B_mtdwCYDAw0ZRAsmKROMw4hbw8pRznj9yPH2TwtPA@mail.gmail.com>
Subject: [PATCH 6/9] Including endian.h for bswap operations
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x62f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Jun 2020 20:42:18 -0400
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

From 2f65cab41a8f4508532b3893815f222bf2293463 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:19:34 +0000
Subject: [PATCH 6/9] Including endian.h for bswap operations.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/qemu/bswap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 2a9f3fe783..1d3e4c24e4 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -8,6 +8,8 @@
 # include <machine/bswap.h>
 #elif defined(__FreeBSD__)
 # include <sys/endian.h>
+#elif defined(__HAIKU__)
+# include <endian.h>
 #elif defined(CONFIG_BYTESWAP_H)
 # include <byteswap.h>

-- 
2.26.0

