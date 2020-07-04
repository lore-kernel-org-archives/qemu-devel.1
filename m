Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A58C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D4921927
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gODFZA0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D4921927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjaO-0004hV-J9
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUX-0001dM-UB; Sat, 04 Jul 2020 10:50:09 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:42047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUW-0003fP-9Q; Sat, 04 Jul 2020 10:50:09 -0400
Received: by mail-wr1-x433.google.com with SMTP id o11so35781109wrv.9;
 Sat, 04 Jul 2020 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6Mlo0AeYRU65Ls2fCVkmevBd3nH8ZXr33Z7OmOj+vXU=;
 b=gODFZA0NwiEg34xoLUZooBEFePqRiHvzOgk7GoIz2n1rFGd4QSl0yPFHs0kMpTwfun
 VxbOHiWGiK7hGkJcR55uhGHJOkSnTOylYJNNNeJNFX5MQ1AJWFLxthC0JxYRXwwA8UD6
 0T4W6OXB8JWENKKs9BjOmQtMx26PqxWLkNEqphVLzbN6BpKPqkGpMh3IysQmS3XaqFCH
 w/AkpcTcynoV0yqxNIqLzGxVmIkT1wEWEZ/2m+7m7ZFEkqqyiCInBV+iToCedjNeVAij
 I8W2Zmy8BwxXfoflWqBcUrD9nDoivwv8OJoVTnLun2Tiql7zQaqUo+6b6+3cW7+Kchj4
 DYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6Mlo0AeYRU65Ls2fCVkmevBd3nH8ZXr33Z7OmOj+vXU=;
 b=OnJyCOpxOezA+oK2xG2fQHPbzVctIj3eOHxobCBvyqqiDQZ8Vkm+y8CY7UzBWMTJ8U
 EGCBhWheA31Yw+aYMoHz3c/Dc4FL9Cmok6TWDsB+Zy19wAxI4FtVgeq+H2/WzCnhPc/L
 sI6l0BnB9Ra7e5t9+UeIhnTwBpDsusFY4QmXwBpk5Sr3ljOwuqgO/d6s66lY8uLH1pzZ
 7ija/d0za5wu2GLHfDW7m+VyH7Cs8XUN11vJhx6BgLnG6Wb5xDaZ/yjH0sFNqd7zRfch
 r8CD3FO4vP/Kv4QsMkVADhd+MFpXY6YZgN2QDPgTvYTWYvQM539LNmSgJvyfB7SnLl7E
 p9jw==
X-Gm-Message-State: AOAM531I7dbAbCTVuwboODU5P0kSPZL/NwmdA/jmV/7CgwNODQo9D/o6
 aFJq4KkUHFd9GXGgGTWXSeysfjw66lA=
X-Google-Smtp-Source: ABdhPJx90xoS99/KVAVNosR0acMctdxAlHMTJW7Yd8LCiWu1nVe8JG8D7h3cg324kUXYXFvYsOB19w==
X-Received: by 2002:adf:f504:: with SMTP id q4mr40505370wro.163.1593874206130; 
 Sat, 04 Jul 2020 07:50:06 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 09/26] hw/usb/hcd-ehci: Remove unnecessary include
Date: Sat,  4 Jul 2020 16:49:26 +0200
Message-Id: <20200704144943.18292-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x433.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Magnus Damm <magnus.damm@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As "qemu/main-loop.h" is not used, remove it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/hcd-ehci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 1495e8f7fa..256fb91e0c 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -34,7 +34,6 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
 #include "sysemu/runstate.h"
 
 #define FRAME_TIMER_FREQ 1000
-- 
2.21.3


