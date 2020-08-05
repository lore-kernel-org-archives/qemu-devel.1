Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C242C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA354206D7
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXOAbnpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA354206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Ihq-0000L5-3a
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 08:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1k3IhE-0008Lp-Up
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 08:39:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1k3IhD-0005Kr-Aj
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 08:39:04 -0400
Received: by mail-pf1-x442.google.com with SMTP id f193so12226851pfa.12
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 05:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cxcvgLm+lnHPGX4ndQP5s/GFqjS1uxDp4QAUTw3M/VI=;
 b=GXOAbnpWLG+U3KVQp9zJY94CxRXdJDz7YLYtgXyI3dVySoTLNS6ewNlc5le4QgKukh
 bqotmRLj8Tijaubym0cuTfJ2vNHXhE4KLvp3lHBihPb5E7Y+XGyakxgYLLHZpH/Qchbu
 9TRn9OeyLyb5n9SfvCcm2IuIuDL5n9aDTSC0UBO+WZET+EANupZIugY5s4DbSXVyxkI0
 qzTpBcePsEKMamoUqX29H4Wj8pPpkA20cNkXS3/k+UUWiX9uM5bU5/hPHlhEmRdn3l3x
 dLvdfFSNHis2Ca60gXXwVxGyy5prxlT98UB9o1ac98BvnMgcuSxVLTVgke58l2c8jCcT
 htbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cxcvgLm+lnHPGX4ndQP5s/GFqjS1uxDp4QAUTw3M/VI=;
 b=Cpt8chseNFM5f8DYL5BMbVsdeH23JwLHD+dNNbtibUs0c0Wa3odLyaqRqcsf4yqOOd
 x5KoozOIwuXEEaAGsuH5pTp0BE2fac6KshLxaasS3SbbVaMewiJJ7+k8Vw0s/2Ts6JGn
 /KsApfYyAhDFVZLGVndUROWCMELwLEIHPIhwUWYJCdKQESU5ILYMc3i8fi8wIdF1pNie
 ZjUtKOFGdgy8iuFHpJqWZUZCToQS0+v5ivK8Q2RfKm4TJ1OK3GfZ7ogixgmAjSU2rME9
 JatFzdjj8ALlHoo2BWmpHJ3t9+INXpj476p1trM+/l6czStRBQjODiXSj/SWzW4US19L
 a4vw==
X-Gm-Message-State: AOAM531mWgP0ui+JTSmS3TvTnyiSU2dhJwaQB19pw9g6CUlpxDIDHxZM
 1rw8eeWZW/be80JANB0VYf79fZjeVyE=
X-Google-Smtp-Source: ABdhPJy7LXZomLlQa5mj0k2YWJfF+oCGBkvX3fdJL/HRV3e0ZVsx1ftOJ6Y6SiJP35AoIoHOY4ov1A==
X-Received: by 2002:a63:ab4f:: with SMTP id k15mr2888063pgp.247.1596631140701; 
 Wed, 05 Aug 2020 05:39:00 -0700 (PDT)
Received: from localhost.localdomain ([59.46.16.2])
 by smtp.googlemail.com with ESMTPSA id b12sm3113550pga.87.2020.08.05.05.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 05:38:59 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH] Following SHA-1: b8d89ba83bf42be1f7b1d7d45236eaf6960d1c4e *
 crypto: move common bits for all emulators to libqemuutil
Date: Wed,  5 Aug 2020 20:38:34 +0800
Message-Id: <20200805123834.139-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

qcrypto_random_*, AES and qcrypto_init do not need to be linked as a whole
and are the only parts that are used by user-mode emulation.  Place them
in libqemuutil, so that whatever needs them will pick them up automatically.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 crypto/Makefile.objs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index f1965b1a68..789a9890e3 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -1,5 +1,4 @@
-crypto-obj-y = init.o
-crypto-obj-y += hash.o
+crypto-obj-y = hash.o
 crypto-obj-$(CONFIG_NETTLE) += hash-nettle.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += hash-gcrypt.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += hash-glib.o
@@ -7,7 +6,6 @@ crypto-obj-y += hmac.o
 crypto-obj-$(CONFIG_NETTLE) += hmac-nettle.o
 crypto-obj-$(CONFIG_GCRYPT_HMAC) += hmac-gcrypt.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT_HMAC),n,y)) += hmac-glib.o
-crypto-obj-y += aes.o
 crypto-obj-y += desrfb.o
 crypto-obj-y += cipher.o
 crypto-obj-$(CONFIG_AF_ALG) += afalg.o
-- 
2.27.0.windows.1


