Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FAEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED1220838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah7JfWJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED1220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1Ra-0002w1-1y
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1L4-0003Mj-Ky
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:10:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1L3-0002pr-6Z
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:10:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id e2so18255099wme.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T1VyM6vO+/UgLy3YgWrY448pDVaigr36dSzmUkhUC2A=;
 b=ah7JfWJuVEfIlML4YkqazrwbS7sEXPVCIhdOxoNBXgZsX1PlXbFVgZntXipr8W2lpb
 9OQymwbhvVjmyjpF4Ez0RdjTxIhfhK8uR9KqVNMWooaRANbRQMYlpGgllxDBadNRlL0s
 EP1iD+tjx+c1kD3HQCB8XUf85OwlYxldW4IfW7HFUZEQDq2LNJgjLHAwBGUQWfw0Llaq
 DPF7QkRHDx6Saqycyvg7E3iJlrwVvf6iMw+Hws1IRLxU3Q9loZ+jbWXh9vsfWiy0PYqc
 F93b9zOuO0vzW9Pu68qsVRVXWmKpQe36sjVrNr7Jg6nvq0vpgmvl7ZYkBEonj9X6OMyM
 hvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=T1VyM6vO+/UgLy3YgWrY448pDVaigr36dSzmUkhUC2A=;
 b=YURxUqr+GP4M7LCZog2wyue2yEp6hp67ZLAxvVQPO0SotRPnlwmvPod4Bn8L/1Dl2D
 58OaNamuzwBxnOmkcTNTqfT/d9pZILmx0oConKB++mXcwkMgyambKSnd4l9uDRUgm6yz
 Wa3U970qIvTO7iKpa5DwSDqhuf5czGAnBcnZDM/jF+hBSKv78YkGbo71g/RIaDNTEhkw
 oWoNjANCLg/bMXtlCDRaqi0qpjRltzD7Lhr638QENFmKjTHUm/3w1nLuqEDH1pnX6Ieb
 ctgktxe//w2xBl66kMZGQIgvU6Us00uzD3K0tTpTT8mIvqfq7vzYPRbAxK4SU2O9G4/p
 +bCQ==
X-Gm-Message-State: AOAM533DZm3GqYXlHfhPc5SNmHpxhgV8GfToIap9Ft8Cavfs3S4FSCXs
 hTwheBVTLFNpl7ObcXy5X5dRtJ44JCg=
X-Google-Smtp-Source: ABdhPJyxdsO9bDHuwTDwO7Z1fZXKTy3M2wfpNQrZ30oneOOWCHxnG40nAkdEInVoXWjVmeAJZFtjfA==
X-Received: by 2002:a1c:9ecb:: with SMTP id
 h194mr11383273wme.140.1602522618940; 
 Mon, 12 Oct 2020 10:10:18 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u15sm23106397wml.21.2020.10.12.10.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 10:10:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] hw/pci-host/sabre: Log reserved address accesses as
 GUEST_ERROR
Date: Mon, 12 Oct 2020 19:09:50 +0200
Message-Id: <20201012170950.3491912-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012170950.3491912-1-f4bug@amsat.org>
References: <20201012170950.3491912-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Report accesses to reserved registers using qemu_log_mask(GUEST_ERROR).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/sabre.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 67699ac9058..cc97c266a57 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -189,7 +189,11 @@ static void sabre_config_write(void *opaque, hwaddr addr,
     case 0xa800 ... 0xa80f: /* Interrupt diagnostics */
     case 0xf000 ... 0xf01f: /* FFB config, memory control */
         /* we don't care */
+        break;
     default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Register 0x%04" HWADDR_PRIX " is reserved\n",
+                      __func__, addr);
         break;
     }
 }
@@ -235,7 +239,11 @@ static uint64_t sabre_config_read(void *opaque,
     case 0xa800 ... 0xa80f: /* Interrupt diagnostics */
     case 0xf000 ... 0xf01f: /* FFB config, memory control */
         /* we don't care */
+        break;
     default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Register 0x%04" HWADDR_PRIX " is reserved\n",
+                      __func__, addr);
         break;
     }
     trace_sabre_config_read(addr, val);
-- 
2.26.2


