Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE88C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6923320656
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1SIrepp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6923320656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlgj-0006Xs-JV
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 19:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJh-0002aa-Sm
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJg-0006Os-Rw
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:43:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJg-0006OL-Lj; Sun, 12 Apr 2020 18:43:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id u13so8062984wrp.3;
 Sun, 12 Apr 2020 15:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uphuvvz4ApyXn5L8QxmzUlAUYfw5x1OrTjF9qcyTuR8=;
 b=r1SIrepp4ZIndmy10MDlDU5phySiTgtf9c0gtQNwpAk/xw3CPOrVYf/1xBtDrkZYQy
 9TA0jqcMU0h8UwVwQOM3UYb7SMoZEKj56UJtAHrTBI5jUscvYvRQ4wmpdMMbS5QO5adG
 xNAsrEH7hPZD7jYIsHsnmfmA/PTqvhn+NZuHnYdwah29QVcxTA1378qNUWCUTUzPG4MH
 NLBPG6YTJDLr7/vZ9ojfvJZF98o29wD/JQBb3FeCn/qqLI4j2G26dbWQ+m0BHVrbZRl3
 qF8uPUS5bDVY3bBGpcu8od+zVJX5AnQ5CREtqnW/eimFtlqAVAJgu8O1VAvmrvzmTDyQ
 NmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uphuvvz4ApyXn5L8QxmzUlAUYfw5x1OrTjF9qcyTuR8=;
 b=qgqNIz+gVsAl23HCaH30Oxi+oWXorxVJDPuYFymLMNsxsgzPce2/KBqzBvr/ItJKxz
 ghC81s0jHWCGcbnIHO24pqio/ik9Mwef9J0HeJxZQHk2UgMK744GBIHZoHdhSv6AXHLX
 bu7G0QFflEOHgU7uM9o6vINwuFYO7XHuX+Nt6x/7wXxfxCEdTtQFWgkep48Qvw2IcV2c
 0tTmI1X4X9SMwWusNwsPZ7o4/71PzWXWW5zvn1gp4Z0CoYuebwiKt94EKDg0MJB1U7Xp
 scBtPHgjP5YrJ7VuM3JaiiOEqU8myS2Coi2OId4CM+Q2sMh/XdgRjD8qq3y6XA19rQnC
 NE7g==
X-Gm-Message-State: AGi0PuZYkf8lzVZWu9y4LROGtScdWrxXIX1ouuPSbAUE6JKWmlJrNkeD
 GWbsr0saAUnTIVNg1aDbTPF+ZS48waVIhg==
X-Google-Smtp-Source: APiQypKzYpkCmAN28QvsJdac9zixjnbGtaWewRosb84akxNmeCSUTUpx4vzaI+1NdLayVbShV4iF9w==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr17218918wrq.25.1586731382542; 
 Sun, 12 Apr 2020 15:43:02 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm12083825wma.47.2020.04.12.15.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:43:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 20/23] hw/misc/macio/macio: Add missing
 error-propagation code
Date: Mon, 13 Apr 2020 00:41:41 +0200
Message-Id: <20200412224144.12205-21-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412224144.12205-1-f4bug@amsat.org>
References: <20200412224144.12205-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/add-missing-error_propagate.cocci \
    --keep-comments --smpl-spacing --dir hw

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/macio/macio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 79222192e8..fffb64a7d5 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -348,6 +348,10 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         memory_region_add_subregion(&s->bar, 0x50,
                                     sysbus_mmio_get_region(sysbus_dev, 0));
         object_property_set_bool(OBJECT(&ns->gpio), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
 
         /* PMU */
         object_initialize_child(OBJECT(s), "pmu", &s->pmu, sizeof(s->pmu),
-- 
2.21.1


