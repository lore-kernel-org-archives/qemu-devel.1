Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F72C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 02:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA61206DB
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 02:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLkqbht8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA61206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0FhI-0003uC-Rr
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 21:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <athurh@gmail.com>) id 1j0EGV-0002co-Vd
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 19:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <athurh@gmail.com>) id 1j0EGV-00045m-2S
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 19:46:31 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <athurh@gmail.com>) id 1j0EGU-00044M-S0
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 19:46:31 -0500
Received: by mail-wm1-x341.google.com with SMTP id m10so4218803wmc.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 16:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JzhGsmnzN+TbRllv6JuSR4DxNLmIZWZ421HSjPV5spc=;
 b=cLkqbht8ZNQd5aVS0rFubMIbS0kh/sOMR1qKdcQz5bZqgwAUzkxbOAVKUAk/FDGexk
 tSWl4QlsvdArLM55boPooWvl5ddyasNBbplEmYfCAeaAMJqKwbBFJ4hfMbtoIoB4VKdj
 GuYC1Xjpk89Vok7MLMdMqPrLHbBwx4ihANpCrdQddRbErqVy61X0at6EFGdX+feXZ7CC
 pmSRJ2vUkFzVFw04gT8bU8/y5lsN70mGgOIXaF7GxFtC6L9Ndcw9whhR9Dd8YeJlZgKK
 AmfMWYLZLkWrrwCa4BQ/uegL04AQ/ogufWYUKwtUgk3P3I9g1bpJws8zZfCn/gQd4XyW
 7FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JzhGsmnzN+TbRllv6JuSR4DxNLmIZWZ421HSjPV5spc=;
 b=Q0glYHDnDXPGtXZl9+CJZXU8q7ULbnXn9ZLOBi5btt5VqRS0BkQ1d6lCazNAxirBqZ
 Cuc+OKCf/XYU5CO22E6NSxM7ZJu2/Uc3zrM1lfcexz74FEINTpDCbjgSsNk8c0cTBvsG
 8stsDYqmb46ETpZ3tm+VI4SX1iu6RyEBa1o7IywNAAN0IliR+xWtRE1oPKqm5Y9WRyCe
 j7U5hq3KCPdOEuDGbc+X1lmb8WlUTSmhaIz5dgFIyLcahr7ndIKaKDi/QJDVO2eQ5XM5
 C3ufk0wrQAG6HWtZ/2WS+L4DM1djtTkk1L+TS4l8CeiRX8wUJUckiwWeEs1TP3TADC4y
 JBcA==
X-Gm-Message-State: APjAAAWAuu4DeJ4XeKo81z6mWouT8f+VRr3xRinBUXhBFTPMUB+a87k1
 RpyZd8GVsCWYm6uYmK4GZUIkVVMk1LA=
X-Google-Smtp-Source: APXvYqyx1wwd2emwfmbnCjI0iDs+TXcJt0kylRf293k7ojZXcoXoaDfAyroCoOz/sVC52xnhe3MODg==
X-Received: by 2002:a1c:4c8:: with SMTP id 191mr977308wme.148.1581122780928;
 Fri, 07 Feb 2020 16:46:20 -0800 (PST)
Received: from debian.omicrom (229.red-80-26-237.dynamicip.rima-tde.net.
 [80.26.237.229])
 by smtp.gmail.com with ESMTPSA id t1sm5558720wma.43.2020.02.07.16.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 16:46:20 -0800 (PST)
Received: from debian.omicrom (localhost [127.0.0.1])
 by debian.omicrom (8.15.2/8.15.2/Debian-17) with ESMTP id 0180kJOR340480;
 Sat, 8 Feb 2020 01:46:19 +0100
Received: (from athurh@localhost)
 by debian.omicrom (8.15.2/8.15.2/Submit) id 0180kJaW340479;
 Sat, 8 Feb 2020 01:46:19 +0100
From: athurh <athurh@gmail.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH] Force background color
Date: Sat,  8 Feb 2020 01:46:17 +0100
Message-Id: <20200208004617.340419-1-athurh@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
X-Mailman-Approved-At: Fri, 07 Feb 2020 21:17:40 -0500
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
Cc: athurh <athurh@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Browsers can have a different default background color defined.
Setting the background image overwrites other background definitions.
---
 assets/css/style-desktop.css | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/assets/css/style-desktop.css b/assets/css/style-desktop.css
index 44ea0c7..b6c5aa1 100644
--- a/assets/css/style-desktop.css
+++ b/assets/css/style-desktop.css
@@ -33,12 +33,14 @@
 	{=0D
 		/* 90% transparent */=0D
 		background: url(../images/qemu_head_200.png) no-repeat fixed 2em 80px;=0D
+		background-color: #FFF;
 	}=0D
 =0D
 	body.homepage=0D
 	{=0D
 		/* 90% transparent */=0D
 		background: url(../images/qemu_head_400_faint.png) no-repeat fixed cente=
r 60%;=0D
+		background-color: #FFF;
 	}=0D
 =0D
 	body,input,textarea,select=0D
--=20
2.25.0


