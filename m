Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8CCC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F142082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbzpDs+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F142082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3Lu-0000Sw-C6
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jo34i-0003sK-KW
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:56:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jo34g-0003Cn-Vq
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:56:16 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so585440wmf.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I/6veH21fEB0VGgAC9gELMf7IWLDADLluDbGBdkQYUU=;
 b=CbzpDs+XmvguvXmtEGbskuxRL3uH0hLI3yJGb8j0SYFBiR3iDUkTzfoHqzqwIZq7cY
 l2cij9shkxKx+17FH5Te0FANTm/5G75wARuzdwbp6vc+VMSyLoXPbg2WrCFgZpFoS3+4
 CRr346gLERNH9tDBG+gvs2qDecOuZGLFfSdLmMa9HKEKarYdYG3bnfiottOvUDC5rH8G
 TX9xtbMnAfG/Z94Bdu946G7XQLMr2tWidK6SeN6t8FQyj003b9Ndbdkb/oGVEh9vzaeT
 hFLqOodMw7gZRS5Qriln467UxJCTz5oYRU4CJDP5NK3wMkiY3VEN8NjnTS7gITocyG3X
 AKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=I/6veH21fEB0VGgAC9gELMf7IWLDADLluDbGBdkQYUU=;
 b=J6msnSTgFZV0/tZngGrufqp2S+FXTCKQ1G8eoaHPQTsq8AHcpTXchIXfCWwvGm05T6
 DKO5ofwidhXpN0AykW7FmGCEDEO3Zc4CrkgUG/TxoZOMSiFvMa0R30OKLd4d2d3sbKyS
 W+46ro9Pl6DeZ51T9iYayVGPYkrYn0Q1izcvtjAd45Hn2dMJ3T+HV+dC+zEyQ1zPbmYE
 zHnwl6zDvQ1fNRbBC8jbtsO5OSfQnQuw67vo4H9UxmHVW+mmQ02w9JcipDgRMgwN/XYh
 bsKON+DEZrqcXVCGfoH20VggEKXlyq880B9J8dCn+sK8JGsFa5Qeoyuz9ROzbYcNakCv
 WBLg==
X-Gm-Message-State: AOAM533y9dTHN48ae2x+QsZqsF2cAlcjz0NJPZlH9nVn3rFj564UbW3n
 ggmpHST1vGoKrRj84mi4NMzsKUDK
X-Google-Smtp-Source: ABdhPJyslnDH+5NGs8IKHmQ8nBnKoB8jcYyW2ia59ZoNL/yFWwItkl4vEMDKvxLKEDNJtTttwDnhhA==
X-Received: by 2002:a1c:4343:: with SMTP id q64mr17640772wma.20.1592996173068; 
 Wed, 24 Jun 2020 03:56:13 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z9sm7353934wmi.41.2020.06.24.03.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 03:56:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/core/null-machine: Do not initialize unused chardev
 backends
Date: Wed, 24 Jun 2020 12:56:11 +0200
Message-Id: <20200624105611.1049-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MachineClass uses an inverted logic (inherited from the
PC machines [*]) to create the chardev backends for the default
devices (see commits 998bbd74b9d..aa40fc9c964 and ac33f8fad14).

As the none-machine doesn't have any hardware device, it is
pointless to initialize chardev backends. Fix by setting the
'no_defaults' bits in its MachineClass.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/null-machine.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index cb47d9d4f8..7e693523d7 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -50,6 +50,11 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->max_cpus = 1;
     mc->default_ram_size = 0;
     mc->default_ram_id = "ram";
+    mc->no_serial = 1;
+    mc->no_parallel = 1;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->no_sdcard = 1;
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
-- 
2.21.3


