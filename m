Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDF8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D0720867
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bpsZChMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D0720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaF7D-0004uh-BY
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 04:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kaF6d-0004U9-Gp
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:29:27 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kaF6b-00034K-IB
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:29:26 -0500
Received: by mail-pg1-x544.google.com with SMTP id i26so16096182pgl.5
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 01:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=8/HnNQ+Hct9/GYNAHvbQpH4erQfEQzRnohmVV7pNij0=;
 b=bpsZChMz/g/NR7nKDng+HS/pl6Ox0rJ3HheOHoHLPqCCHy3j61vzig5fyKVBWL5Saa
 z0rXN32KbfoTkk0lvmB2NjJBCWIzwHxi4MySqtTH1kinO25Kqa5VAuTogabmg6z4Li3D
 +SPb6c1Q0gUG65f1ikZLAwbsFarSzlDcTJdiiC1b+7sGTZFPMYYVW0slZh/dFyX3G9kl
 hg9SMWDdjVeQ4aIDyeQN8bi3EeMgBxzpmxZUktIiXRSR3+rY9c/fLKJjpA2DrK6+f2N1
 iYEG9GNn0fiX8mX7eBWMLPQqwKC2/Ny7Brl0NodoNLSl6XuQNv7QH0r9D3yLFditY9qV
 gUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8/HnNQ+Hct9/GYNAHvbQpH4erQfEQzRnohmVV7pNij0=;
 b=m37Ajckp7eazcnAfnxTe69YC49HFieQHkMTlTQc5i8CxMEJrdUWwqrc23oaJKleM1j
 aVtOdwk+cKwcGtARsRJitJ2gYutcIKPWTTxsMcvWqaffYrtQTmJffPEF4mNkXrXS/+uV
 nk17CFM8NoySiyte5EfVwZ8Mns/U1hsAwedX+quamIbjAme+O5R3KZmW3MPLwDwSrZUs
 rICCEv5n/HUbk8dnKibcsBoD6boimelCMPeWaVqdCUwGOaUNM9T7tjFkd+uTBHwwSeXF
 Z5p7Fwx0h3Q7qvqEdpiN0GKhsLxi1Hzk10YNqTkC8qO4webQ1zuQLLd78bt7WCF+Iuf3
 39tw==
X-Gm-Message-State: AOAM533t4ni975aG5/V34LHj0AMUu18k4eXOqkhGfFJ5EcEhuun+sGZN
 t6r+RCDfvQqOHh6kTLGMvkWmEZF/mzQsCA==
X-Google-Smtp-Source: ABdhPJx402myKz5GfNcs75lSPCYoeYjRxpWnqPdGuXYxEvRVuLLiXfc1ns+leuUyhCUnmqW2jqaVfg==
X-Received: by 2002:a63:4c45:: with SMTP id m5mr4007206pgl.201.1604482163753; 
 Wed, 04 Nov 2020 01:29:23 -0800 (PST)
Received: from gwan-VirtualBox.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id t74sm1844538pfc.47.2020.11.04.01.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 01:29:23 -0800 (PST)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [PATCH] hw/misc/sifive_u_otp: handling the fails of blk_pread and
 blk_pwrite
Date: Wed,  4 Nov 2020 17:29:00 +0800
Message-Id: <20201104092900.21214-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=green.wan@sifive.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, qemu-devel@nongnu.org,
 green.wan@sifive.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix code coverage issues by checking return value and handling fail case
of blk_pread() and blk_pwrite(). Return default value 0xff if read fails.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 hw/misc/sifive_u_otp.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index 60066375ab..4314727d0d 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -62,8 +62,13 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
             if (s->blk) {
                 int32_t buf;
 
-                blk_pread(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &buf,
-                          SIFIVE_U_OTP_FUSE_WORD);
+                if (blk_pread(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &buf,
+                              SIFIVE_U_OTP_FUSE_WORD) < 0) {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "read error index<%d>\n", s->pa);
+                    return 0xff;
+                }
+
                 return buf;
             }
 
@@ -160,8 +165,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
 
             /* write to backend */
             if (s->blk) {
-                blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD,
-                           &s->fuse[s->pa], SIFIVE_U_OTP_FUSE_WORD, 0);
+                if (blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD,
+                               &s->fuse[s->pa], SIFIVE_U_OTP_FUSE_WORD,
+                               0) < 0) {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "write error index<%d>\n", s->pa);
+                }
             }
 
             /* update written bit */
@@ -248,12 +257,18 @@ static void sifive_u_otp_reset(DeviceState *dev)
         int index = SIFIVE_U_OTP_SERIAL_ADDR;
 
         serial_data = s->serial;
-        blk_pwrite(s->blk, index * SIFIVE_U_OTP_FUSE_WORD,
-                   &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0);
+        if (blk_pwrite(s->blk, index * SIFIVE_U_OTP_FUSE_WORD,
+                       &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0) < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "write error index<%d>\n", index);
+        }
 
         serial_data = ~(s->serial);
-        blk_pwrite(s->blk, (index + 1) * SIFIVE_U_OTP_FUSE_WORD,
-                   &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0);
+        if (blk_pwrite(s->blk, (index + 1) * SIFIVE_U_OTP_FUSE_WORD,
+                       &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0) < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "write error index<%d>\n", index + 1);
+        }
     }
 
     /* Initialize write-once map */
-- 
2.17.1


