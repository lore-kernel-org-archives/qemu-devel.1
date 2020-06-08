Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E73C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFB5206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOexADa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFB5206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiDjN-0001f3-E0
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfC-0004lA-Cf; Mon, 08 Jun 2020 05:01:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfB-0004Hq-Dn; Mon, 08 Jun 2020 05:01:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so16495531wrc.7;
 Mon, 08 Jun 2020 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nzPqyG1e1Jsl3k+MmlRrYyDt080jPwPTNQkC1AKawm4=;
 b=sOexADa+B84ABTbsr5jctxKfPv/J9Cn++yYlzYQWRZff7gLhDs/AbzL4rdDGOjl8ry
 xvGNAEfcpG8X+LVzQ8I7Yql0hjkVh3whkjcbcnxsW4f0h10Xu+QFEGzLOl2P7QyIVmQO
 1SwoNOunreb0z19ziUQaysV5nyY+TXcjzdOjPKXuZ88jRKma6DxIidx/9iF0AMksaiWn
 eNyH92wM3bWjI3c2HgpnaFlk8oQyHuP2Pz4Bluq7eEkDK+lMd8rvCf1+jaB2Izi75E1m
 DX2M/tp53ZOhHotNP9w78OxtTya+DwGL2MYFNI1WjK2bP1ha2CvCy0a9dPWmjW8te9c0
 TOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nzPqyG1e1Jsl3k+MmlRrYyDt080jPwPTNQkC1AKawm4=;
 b=evCIp9zR7IYUI8rY0mjkLPmDXKbsroM5LGld8s0mCdTLQfWG5hSkKoagXoQtCjhiTS
 MHWYHXfeJwJhkL7michfhUe/yvFfJXcecsJI/VxZSJ9OT0WIRq4P4IrmQ6zg1Ae5ooMw
 gstrr52REhI4PcjdaqaPgS7nipLaJ6BorbGFOYfFXhRh6B6ip8ki90RiqphOMHQfimC/
 veDC3RquKQ62R+FRaIzK/H2ghiOpL5jIvvXHcDVxr/K4VFGSidgcphfNl7whaRTOt/ni
 BHeMAI/KWiUp2AZome9gDsTYolMCCQUAmMidsDCdTVsAtyddIbSSjATi4ZB5b6FJRPjv
 xvqw==
X-Gm-Message-State: AOAM531VvxCChNsmp5FnBtd2ffsqBdonxpSZ9sh7UupMtrFTfqtZhm+M
 X7R4mbGWGtv0zGYKBoOaaVmkOSdr
X-Google-Smtp-Source: ABdhPJyUYNqlDud4XxKo7sB6RD/HUaJraV0MQZcVTVBT5WVaAF1kVi9ecZHSnIWX6nPDU1U8fF9BGQ==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr22115684wrq.222.1591606907550; 
 Mon, 08 Jun 2020 02:01:47 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t8sm22192989wro.56.2020.06.08.02.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 02:01:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/8] MAINTAINERS: Mark SH4 hardware orphan
Date: Mon,  8 Jun 2020 11:01:35 +0200
Message-Id: <20200608090142.6793-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608090142.6793-1-f4bug@amsat.org>
References: <20200608090142.6793-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aurelien Jarno expressed his desire to orphan the SH4 hardware [*]:

  I don't mind being [...] removed from there.
  I do not really have time to work on that.

Mark the SH4 emulated hardware orphan.

Many thanks to Aurelien for his substantial contributions to QEMU,
and for maintaining the SH4 hardware for various years!

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708400.html

Message-Id: <20200601214125.GA1924990@aurel32.net>
Acked-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7890ce82..49d90c70de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -299,9 +299,7 @@ SH4 TCG CPUs
 M: Aurelien Jarno <aurelien@aurel32.net>
 S: Odd Fixes
 F: target/sh4/
-F: hw/sh4/
 F: disas/sh4.c
-F: include/hw/sh4/
 
 SPARC TCG CPUs
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
@@ -1948,6 +1946,14 @@ F: hw/*/*xive*
 F: include/hw/*/*xive*
 F: docs/*/*xive*
 
+SH4 Hardware
+S: Orphan
+F: hw/sh4/
+F: hw/char/sh_serial.c
+F: hw/intc/sh_intc.c
+F: hw/timer/sh_timer.c
+F: include/hw/sh4/
+
 Subsystems
 ----------
 Audio
-- 
2.21.3


