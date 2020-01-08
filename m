Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532FCC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209AA206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctKceCIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209AA206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAo4-0004e1-Or
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWc-00048G-Re
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWZ-0004TE-QI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:39182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWZ-0004SN-KC
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:23 -0500
Received: by mail-wm1-x330.google.com with SMTP id 20so2309943wmj.4
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lO5wl48k6ZDCJruKpNcQHB08wbkpBLoPs4vSZC8J3nY=;
 b=ctKceCIK+FnmoZUYBVJ2doBjzS4WNDc9zuFfDXLTCOq0gwHobqm4/QHSr5/vRvetOo
 2vLJ3TWeWZuhP9AWlojO3aBrD/hRcQuwUcBNIo3pZzug8sh80fwB7O821cyf97w1QKNQ
 O/+Ilqqx3sqrLIYw31+dQD9PrBhx5prrSjJYy44OXJxShYEO6dHFJ7d2gRKt33NsJqgG
 lbcv1WmYTCRElEPaOojT7QJguDA6CHRAMrycQrNOnRGAWPI6zTDaUDk7SyWS90O5vUP2
 aakw4HAwhI8eQuiHVTKupWNxaoOL/acf7/rVGaZRyY8MoHfsTZ3j0vXdcyOA/hy0Zvny
 MD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lO5wl48k6ZDCJruKpNcQHB08wbkpBLoPs4vSZC8J3nY=;
 b=qZa7uvLw4cymWPMCSO3IwUUmHDjLtWLsR23x0v1itW4mfxhaWCKS0jWMspo/P+aSGx
 qAiUE9T4eVR38BgXmILSwzGkRyCo/+JXL0+l0BPTp1w9nWWJUOxhsKWF+J3+x5W5r064
 JBAfXTTRFvVCXf70aR8XSJ8OM0HxHW3thhpOV+bDV/GQhjNrpbCYqg34rEMr+yw5zXsd
 FwKUrpJO1DDzO2Gnn+vSsiLorUj6f/59cbLh/eJFeWOXaRV+yxkXx6FipFrnSeo99HoF
 EwhyqFEIO2s4VMEHJ6KZmV2xzNkuyzF5FH5zmXkWAeOycrkjn4QcERSm8mfVovMaYBN2
 nyWg==
X-Gm-Message-State: APjAAAUQz7RMclc9MS7UqFVTntAc4rWVS3Rgnj9VmQDEwvGfeIecRTBG
 zgDxV7GmnOibUOk9+cWPFkP9UUV8
X-Google-Smtp-Source: APXvYqx9LhkAy8x00lGhJ7J3XbPdeKsCPJ69sNujImKGbltXSetdg9kdAtNy2cvVxCtJywL7mxnTNA==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr3685247wmh.71.1578486802503;
 Wed, 08 Jan 2020 04:33:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/38] hw/ipmi: Remove unnecessary declarations
Date: Wed,  8 Jan 2020 13:32:41 +0100
Message-Id: <1578486775-52247-25-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since we don't use these methods before defining them,
no need to forward-declare them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191218172009.8868-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 87da9ff..450926e 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -87,10 +87,6 @@ typedef struct IPMIBmcExtern {
     bool send_reset;
 } IPMIBmcExtern;
 
-static int can_receive(void *opaque);
-static void receive(void *opaque, const uint8_t *buf, int size);
-static void chr_event(void *opaque, int event);
-
 static unsigned char
 ipmb_checksum(const unsigned char *data, int size, unsigned char start)
 {
-- 
1.8.3.1



