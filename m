Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D04C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DA62070C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oe96UZf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DA62070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjXd-00081e-P0
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUP-0001In-GA; Sat, 04 Jul 2020 10:50:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUO-0003eM-0B; Sat, 04 Jul 2020 10:50:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id q5so35745407wru.6;
 Sat, 04 Jul 2020 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7pFkSbRRQbCuRBQa/wHlCeQOONUZFK/RPfYxuVN6mNY=;
 b=oe96UZf2PvTeWCGOzNPdJjjjwq8e7uWWti9W08FMinN7P58qMXJzwG4jf7BQqAlIXy
 6nHLswC2ubCB3a5BJuyeZJgNcIKrAIDo4ARzHOGDOs8dG3JjWPLZh+xe/GSdKhL1zZpq
 8BYgKvBkBIAl/g+8RWgLQjeAv3/zhyETI0aJxVBr/gw0rUcBfnedTHwEViIUPNIXNva6
 03JOGnSszEoF4cvdF3lLiUVfjtrvuQh3LEc873Fecq0vjBpXttzot5/ZB9ZEJEQG430J
 9YLB5PV5soEOhpr3WG8RhSY1eKgOIEVX6mRUL3RwbaUehHrdq/CwhlxSp1fhDKJcCsc/
 pq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7pFkSbRRQbCuRBQa/wHlCeQOONUZFK/RPfYxuVN6mNY=;
 b=LwjcBQHqcL36/14OMkw4yd/Tm4Zy7DMMxl+fU7SDTOLir/xMOFzFCkNl/MFSrRrAGN
 wH5h79uAPVEceaRQMTVvWNDjFKkA6Sb6fRd4S1GrLSMJtdTunHnUcpiZ3uUcGRTD+TFN
 91EIpyqYHkOgwUVMR2q1SyzUfJhLj9lwrJAsIEDuRXctlyy3h4k9LtfxTxv2kiJOKEmH
 4URm6l6qFdrWPM8SQAyLYtlxSloiZurWr978daJTJ68W3oDqm+OpgxkhU9S7EHmHQ7l8
 fF41bpX17Pw52y4MVQcZtZfEPC35uj3cDM+e/SdrRnqyP9FdukstnfKswu2juZOjNGHu
 Digg==
X-Gm-Message-State: AOAM531mP1hjMDlfupBnz5COMf/sou4K/vZgVW0U9sr4xkJhumNfa4aA
 KAIrmiJyEdR8NZjGJwJ0oc8d4wFuYuk=
X-Google-Smtp-Source: ABdhPJyIsvEkdmFv/CEzZPKYJCez2abF31l4aHFgnR6C3Ee2RRBQ8QQm9RtLdC3SuJbJy3WxELYEqQ==
X-Received: by 2002:adf:f08b:: with SMTP id n11mr40029476wro.312.1593874197889; 
 Sat, 04 Jul 2020 07:49:57 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:49:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 05/26] hw/usb/desc: Add missing header
Date: Sat,  4 Jul 2020 16:49:22 +0200
Message-Id: <20200704144943.18292-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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

This header uses the USBPacket and USBDevice types which are
forward declared in "hw/usb.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/desc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/desc.h b/hw/usb/desc.h
index 4d81c68e0e..92594fbe29 100644
--- a/hw/usb/desc.h
+++ b/hw/usb/desc.h
@@ -2,6 +2,7 @@
 #define QEMU_HW_USB_DESC_H
 
 #include <wchar.h>
+#include "hw/usb.h"
 
 /* binary representation */
 typedef struct USBDescriptor {
-- 
2.21.3


