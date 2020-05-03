Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23903C4724C
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 11:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AF4205ED
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 11:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McQR5EJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AF4205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVCsI-0003IK-52
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 07:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVCrH-0001su-BI; Sun, 03 May 2020 07:32:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVCrG-0008NQ-Nw; Sun, 03 May 2020 07:32:31 -0400
Received: by mail-wm1-x344.google.com with SMTP id k12so5114526wmj.3;
 Sun, 03 May 2020 04:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WLfI9+SN8h6AKCdaEGa7tKEIhwA7T3hWgI6qxjQ5RDA=;
 b=McQR5EJJhLs6dxRaQZtaEfrlhrcc+HjPo43l9QAVD+sXBhDu3U0/+belCcYvYWh0ny
 nL65dirh2HbimhNqPp4X8vJeMwInYai+QJwpVPSoVtSBE2l+cLTloxM89GrGCBY/oJEP
 gr3nKjn2ZhxusgTu3GTUyzQdaP2J3wlbhozXsxSC4sE1mN+xHq/YTqgIax/m0eRtAM5U
 ciV8365QH6gWJZZAK1OSffLejLjFYkI2H8WQw8cDFMF+RkuOm2sIJ0VdtSi/xTXzp6Tt
 Y56032eRuYhn1ITTpwPiY0ubl9i5ZsPZYJi0QaMIybmcYeBUR+jv2bdsOnU5vu5KHAec
 AgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WLfI9+SN8h6AKCdaEGa7tKEIhwA7T3hWgI6qxjQ5RDA=;
 b=UrxLSQAmdFUR9a0OY7Sk58pVXSszRwB94kZblwGCw8w9hhis9zSWqX1MKjnU6X9ejG
 ZI1358mvfY5I1EgpFQ6akSn1fFxEFB/QKTSoLCpOTueK73symLX1rwxvfIIdJOy1v0o1
 cgxFG5ltmtexWj8cfE1zkRnVcDNGxGg71t9y9IgX4irvba3mw71A7DzbhYpvGUVyn682
 yg+0rDtAbbAzCXiH+ibHqu4VxUcpdRrTBPpGP5btyDGuJgPeghl4MPFrQP74sdIzW2VM
 RCph04Rjrf48wn74vlfnaHGM7dArnS2DiTD8Rxaqqg/4WJmRvv9EipdThjC2/DyxSjvv
 GBTQ==
X-Gm-Message-State: AGi0PubL2hQWISwktJ+CnjV3sICAuCvIzVnDdgWnnbOYeP4psz7GX17v
 3N8B7G17VIe0yJ/4AiRtEM7p5Hfv
X-Google-Smtp-Source: APiQypJLfevv73ldiVHjt+PV/tOH6+rVLBn9XfaUk2FQvemoegC/3Qf15uI6K0ERfn5TcqmC+iJ++g==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr8933078wmh.134.1588505549067; 
 Sun, 03 May 2020 04:32:29 -0700 (PDT)
Received: from localhost.localdomain (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n9sm13485904wrx.61.2020.05.03.04.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2020 04:32:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/2] audio/mixeng: Fix Clang 'int-conversion' warning
Date: Sun,  3 May 2020 13:32:19 +0200
Message-Id: <20200503113220.30808-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200503113220.30808-1-f4bug@amsat.org>
References: <20200503113220.30808-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When building with Clang 10 on Fedora 32, we get:

    CC      audio/mixeng.o
  audio/mixeng.c:274:34: error: implicit conversion from 'unsigned int' to 'float' changes value from 4294967295 to 4294967296 [-Werror,-Wimplicit-int-float-conversion]
  static const float float_scale = UINT_MAX / 2.f;
                                   ^~~~~~~~ ~
  /usr/lib64/clang/10.0.0/include/limits.h:56:37: note: expanded from macro 'UINT_MAX'
  #define UINT_MAX  (__INT_MAX__  *2U +1U)
                     ~~~~~~~~~~~~~~~~~^~~

Fix by using a 64-bit float for the conversion, before casting
back to 32-bit float.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 audio/mixeng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/mixeng.c b/audio/mixeng.c
index 739a500449..9946bfeaec 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -271,7 +271,7 @@ f_sample *mixeng_clip[2][2][2][3] = {
 #define CONV_NATURAL_FLOAT(x) (x)
 #define CLIP_NATURAL_FLOAT(x) (x)
 #else
-static const float float_scale = UINT_MAX / 2.f;
+static const float float_scale = UINT_MAX / 2.;
 #define CONV_NATURAL_FLOAT(x) ((x) * float_scale)
 
 #ifdef RECIPROCAL
-- 
2.21.3


