Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BC7C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D96A208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdS1ItS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D96A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqIF-0004Zd-8B
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iopIL-0000Ai-94
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iopIJ-0002GN-Tb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:17 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:45169)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iopIJ-0002Fu-Nm
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:15 -0500
Received: by mail-wr1-x42d.google.com with SMTP id j42so53981423wrj.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9H00ugr2z7lQibvS6yBfMQWroquDH6aQ+KBI0wlakTg=;
 b=GdS1ItS3Y3F3nWR+I3jyzcKEvLvKQRt3wB0NGqt4RlJp1bVIHYVwDkHp5lxQhga3DU
 gUMq9C8fGql2rdfzSDOftv1zjaHbtDShdKQP3JZdO4fDwoOelPaywhb0Vsu0vgQvwA+P
 ODmCx+UZDfnV4wlKqMTgV/nTdr/vN+KgJee+F16OYNrblO/lNcu/h1NGk+FubzRKoC4d
 GTX9hs1zyZsghDJ4fewAzyZ5z1FrBBTw5OUGdZyjAciBHtFP2IsDzAuPQVyrqrN+UkIj
 i523hJ9WI/aE3RYxX8i1qEHe0G8edPesll+h9vZb3NWnYZhRpc83QtE+PNpb1mSWG3Ma
 HCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9H00ugr2z7lQibvS6yBfMQWroquDH6aQ+KBI0wlakTg=;
 b=UsXEtRAOwXz/MqDJaKX2gJMZPj94DNRmWSbEy54bxM397sZtQkKQdun5wqbq1gXq4X
 FzdkcN4HvaxWQmhJZqVCFtaNqSvglH0f4+iODVKDZKiSqqX3VuNhMA5qzKdlsLV5eCsU
 GeKc9558o5kMzqoeGADwb5+qH1w2NmdSQ3fJ121iN3pJicGVmrvToZ/TYK0Im1Un9eGB
 S92nDkSyTwT8VukV9TjETEg6YyfCfhJvrYyUb1j/f20Ia6ROZG9McPZcGd8TNUJ20Hq8
 gV++KaCs6ExEBFNfTiRPM/2HP/qPvcuNvxJaTUacPwX/JixTx70+Pdr4u5LXgRpWhm2l
 CwiQ==
X-Gm-Message-State: APjAAAWUPJLP2H9V/NTP1j350S/WLImEawO1lIUwSb6FztN6wn/blVfB
 yRpoUU85YbVsFj+5bjctAd68wA==
X-Google-Smtp-Source: APXvYqxN5x0XlgnAmPY4sUv38n1Jj+qmWlB2UjGNfBZsfF5YpsEvvJ8l1jqIv96ezhrtJjTM9yL0dg==
X-Received: by 2002:a05:6000:1044:: with SMTP id
 c4mr112361643wrx.204.1578405194768; 
 Tue, 07 Jan 2020 05:53:14 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l15sm77356505wrv.39.2020.01.07.05.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 05:53:11 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 452C31FF8F;
 Tue,  7 Jan 2020 13:53:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/6] tests/vm: update openbsd to release 6.6
Date: Tue,  7 Jan 2020 13:53:07 +0000
Message-Id: <20200107135311.5215-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107135311.5215-1-alex.bennee@linaro.org>
References: <20200107135311.5215-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191018102443.26469-1-kraxel@redhat.com>
---
 tests/vm/openbsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 6df5162dbf4..d6173506f78 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
 
-    link = "https://cdn.openbsd.org/pub/OpenBSD/6.5/amd64/install65.iso"
-    csum = "38d1f8cadd502f1c27bf05c5abde6cc505dd28f3f34f8a941048ff9a54f9f608"
+    link = "https://cdn.openbsd.org/pub/OpenBSD/6.6/amd64/install66.iso"
+    csum = "b22e63df56e6266de6bbeed8e9be0fbe9ee2291551c5bc03f3cc2e4ab9436ee3"
     size = "20G"
     pkgs = [
         # tools
-- 
2.20.1


