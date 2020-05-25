Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D06C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E5520723
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu1LLg0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E5520723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBFu-0005Bg-5s
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBD7-0000lY-3Z; Mon, 25 May 2020 07:24:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBD6-0000pJ-CA; Mon, 25 May 2020 07:24:00 -0400
Received: by mail-wm1-x342.google.com with SMTP id j198so2777857wmj.0;
 Mon, 25 May 2020 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BQFbmyT7pL5wAyilWhYCYPO6t2SCt7Rg549UrO0JLKQ=;
 b=Qu1LLg0zwbfQTztCtVZ093pynpUtbqdTRI+OUdCu8fDIe6QyW/BoeI2hi52B3uZ0rZ
 QSrhxQIVzOLVi3AYIahCVYNi89OZqb2YRQtqc4QJb/+eZ1zbp1Ncp9WwH4G90n9VQwNn
 Zwo2MxLYyaT0MoLClAkiLb0z5XSOd9UEx8SjIOwG5fRWmrEP8ZmGGXo0TgXOCUVSncl1
 2vIE0FIsZDWraABsb+KlgBPFBrNUj9XD9Z5vym/6ZrWaaa4qgW6KVnHMI5ClJI6y+STg
 ndBjajKfcvtQ//VU2x3Y0OE79LaUCUJ7zNv+iB46BzWee/578pMXOoY5jWm7poKG9iez
 WxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BQFbmyT7pL5wAyilWhYCYPO6t2SCt7Rg549UrO0JLKQ=;
 b=PTSPxcsE49Sq3iLxRLSKk/v8VW4gUozp/72dEFNFYaFAlA/GfgqCW1PN4TaDssizX9
 SSxq6Zh7mv+lBQLWeLILsBN7BT9OGU+1kKER9SMO8yPQ6BfctRhMfUA15FLAjDZgdyL6
 KUXIQqPzXrMa5l1UHubd4eZ+JWKYFtbrkNP8yeEE6eHxWRd0gFu0DeNA1+rgUlccffc4
 /KcCx/OQvvf7L4BebgtoZZT6XNcV3cFPkxvWrlKZzX0m/Nn5tYyAHRkiD+h3wdSgomGc
 1q1z58XB5auxr8ZMWA2fGOS9J6wsLiS9daisPwhGiS6B4xOPhX6B4XX+QxShs9QzyFOq
 Uy5g==
X-Gm-Message-State: AOAM530aHsALZQEqifZ6y0U5XQPwkD7QuC1zQRCvoLfhf1tt5KtBO1vJ
 jgkYwOgZO/2y5XV6DqzaD0Wt1phHO3Y=
X-Google-Smtp-Source: ABdhPJxOj/dPQBiRKnXN/RrL5mOqFDr5LjUIyezdTrSbrB1ikQ8mraX1bX2xCDh6oUc9lJODWY1PcQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr25951955wmi.41.1590405838376; 
 Mon, 25 May 2020 04:23:58 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id h196sm10715635wme.22.2020.05.25.04.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 04:23:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] MAINTAINERS: Cover vmware_vga related files in VMware
 section
Date: Mon, 25 May 2020 13:23:52 +0200
Message-Id: <20200525112354.10445-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525112354.10445-1-f4bug@amsat.org>
References: <20200525112354.10445-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the VMware VGA display and its ROM files to the VMware section.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3690f313c3..2da00ce798 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1776,9 +1776,12 @@ F: hw/net/net_tx_pkt*
 Vmware
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
+F: hw/display/vmware_vga.c
 F: hw/net/vmxnet*
 F: hw/scsi/vmw_pvscsi*
 F: tests/qtest/vmxnet3-test.c
+F: pc-bios/vgabios-vmware.bin
+F: roms/config.vga-vmware
 
 Rocker
 M: Jiri Pirko <jiri@resnulli.us>
-- 
2.21.3


