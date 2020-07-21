Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AB1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 18:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF76F20717
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 18:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/hA7gIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF76F20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxwdR-00040h-1r
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 14:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxwaG-0000ZC-Qi
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 14:01:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:51570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxwaF-0003ud-4H
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 14:01:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id 22so3702435wmg.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=50qt2zTom3S53FxupA2rwsdYUf4JqXZBFYgRiKx/yAU=;
 b=u/hA7gIQkxp8PQdha8T2vV1yc/Jnp8n6LK3DON/TR+TjAFWM+dSV/8T55b0qK5S7f+
 fmZZrWii6+nfzWPc2DToMGD7fflYaT50X5JgZp8OhuUk3EjGSDk57pp9XBPCcK3XNbeV
 aJYX9y4OynjHb/ZjHQTViUtYNbuWnM+0d2UGq7ZfMBwyC39P0fCTZmhgrHpVs66DHtVX
 K0OQL+WI2Q7ojrB847EgB8Ix9jZSTG3PV1sbfg/EJTfKia7L2MezWBVwobDF6LbHa7G3
 EJrADoZmLbBVIBatNdIUkL3pDtpdCOeR5q3gQD35ilAWG+26m7AnMV5mWSd8s2IBW9GO
 l/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=50qt2zTom3S53FxupA2rwsdYUf4JqXZBFYgRiKx/yAU=;
 b=rNhnCAZKE/h+WeaHXmlni3bPWJHWD3FSyeldScE/hvsIPspgcmuszwKgq2EJ+qquIF
 MaqmmaeIazkUD1as+J+4S57pnfcefSTqIm30OThlWBIfLc4kxsoS1nLFEJ3t+kPBBL+w
 7pZ684wycZn9fZpc/06x8ehIWsJsas6Q+YqzUyYJIvLqQDzKVypm5VRXNjbGaYP5Qn1D
 5Nk3qCEmCmE7SK2XNVd8lyPsZ9d5/Y8rbZdR60Jnsg59CqXopr8rbzdcWpbDzxCFgStO
 AVtuaMXTt1eL3ojrmtxAj0d3igzA2ooOgiUXDqvHoPPO3t5KYVw5FOI9i1IICM9oROol
 zr3A==
X-Gm-Message-State: AOAM531gg0oBimuwu9teRww1Gjk90hOugP7yJdWdjguwx45S3jVZft+2
 krhrLD77elD3u4w4M9rvdPAWb975JF0=
X-Google-Smtp-Source: ABdhPJwd/1u+8HtcU+z4Aon9EB+f7/cQIu+B2hgkMXvztEmjJ8/l13kuevGip3E9O7LqMfm1aB3vHw==
X-Received: by 2002:a05:600c:2219:: with SMTP id
 z25mr5494805wml.154.1595354501494; 
 Tue, 21 Jul 2020 11:01:41 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t2sm3557249wmb.25.2020.07.21.11.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 11:01:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] qemu/osdep: Reword qemu_get_exec_dir() documentation
Date: Tue, 21 Jul 2020 20:01:35 +0200
Message-Id: <20200721180137.11136-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200721180137.11136-1-f4bug@amsat.org>
References: <20200721180137.11136-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x335.google.com
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This comment is confuse, reword it a bit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200714164257.23330-3-f4bug@amsat.org>
---
 include/qemu/osdep.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4841b5c6b5..45c217aa28 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -588,7 +588,10 @@ char *qemu_get_local_state_pathname(const char *relative_pathname);
 void qemu_init_exec_dir(const char *argv0);
 
 /* Get the saved exec dir.
- * Caller needs to release the returned string by g_free() */
+ *
+ * The caller is responsible for releasing the value returned with g_free()
+ * after use.
+ */
 char *qemu_get_exec_dir(void);
 
 /**
-- 
2.21.3


