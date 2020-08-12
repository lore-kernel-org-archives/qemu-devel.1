Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10DCC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BDE920838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9W9WpFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDE920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5w2o-00051m-QJ
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5w0s-0002Vc-5g; Wed, 12 Aug 2020 15:02:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5w0q-0006Ee-OE; Wed, 12 Aug 2020 15:02:13 -0400
Received: by mail-wr1-x442.google.com with SMTP id f1so3055615wro.2;
 Wed, 12 Aug 2020 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uc6ONUoxoWg8xYm//tb9mML/JLxliOTk/GE+b+dOnas=;
 b=c9W9WpFZ14ZVaiiG7/rHyW4DOZkgwnYdtaquSFi086j6rADMzsT/BIYYoHzUdr+n2H
 G3QWTVU5/A2ODpn1R48Q+7MjOpkH24zMI5Ng8NCn/WRPPedUQo+Tgq1uZMBzIW2DHYMe
 McxbRpFb4NoOCODIMtf2P0Dxu1GES8NU94bK6vAnSdDimft8Odk/voxTSq+VpPXzmuql
 AwC/Xy42rWqjXUPeIWlnBDzYKhcDNhwyqAg9vFIy+H0dVpXtXG4NgoHc1DR2MRbXTSrN
 +WIF8IpIxeDdAatDkqiD7sGc6XEz/zoBubsJEZi4OwVYmTmwlLxH8sEFYdeZRV0stVeM
 5Kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uc6ONUoxoWg8xYm//tb9mML/JLxliOTk/GE+b+dOnas=;
 b=nQevCQVu/GFn5+uwtDWVDN5aUbd5WRCnID3/WVZIcImRy87hghgUmGHPBMq02UUOZg
 DaLbHfceqXyedIYC0NMiHfr0NvfKA1496Q/TTQU+UiWDiA/rSmL1yeXByYn34VIfVzzR
 G/GJP9aiQ84Qbbr0r7Yp8ybCcELJq9mJsWl/W2f2u/pAw57wAK9XSezEg3Kfe5lTIYim
 pl4uozKmhs63g0kcpDM88f9xwXcDlecn69TsDeDbRZM0PZhMUeqq0anMDYKiKxwWObGa
 FEOfUliWYFqrhvq4NK8QiH1pxyQQl/AojHfc984la9CAZp++4wYkz0LTMhl8HCNe86Xp
 If5w==
X-Gm-Message-State: AOAM532snlGNkyHuZRrzsN3YtQ/eKLHd2FndCO4O60Kg0kvH4iYpZ7Fc
 iOjtopey55JFdovi0P06/CedwacO
X-Google-Smtp-Source: ABdhPJzYJbCg3ZMdEYVaVcwEcoDDOETH/LjovL4W33ppbFiwQtwwSBFW1XqXNLtfFAdNtCaYsxOzeA==
X-Received: by 2002:adf:f341:: with SMTP id e1mr576615wrp.207.1597258930812;
 Wed, 12 Aug 2020 12:02:10 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z12sm5689441wrp.20.2020.08.12.12.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 12:02:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] hw/misc/unimp: Display the value with width of the
 access size
Date: Wed, 12 Aug 2020 21:02:05 +0200
Message-Id: <20200812190206.31595-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812190206.31595-1-f4bug@amsat.org>
References: <20200812190206.31595-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To quickly notice the access size, display the value with the
width of the access (i.e. 16-bit access is displayed 0x0000,
while 8-bit access 0x00).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/unimp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index ee2e536c8b..b4b318db1c 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -35,8 +35,8 @@ static void unimp_write(void *opaque, hwaddr offset,
 
     qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
                   "(size %d, offset 0x%" HWADDR_PRIx
-                  ", value 0x%" PRIx64 ")\n",
-                  s->name, size, offset, value);
+                  ", value 0x%0*" PRIx64 ")\n",
+                  s->name, size, offset, size << 1, value);
 }
 
 static const MemoryRegionOps unimp_ops = {
-- 
2.21.3


