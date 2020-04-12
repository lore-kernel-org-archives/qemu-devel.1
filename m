Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FD0C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA582051A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI4YldUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA582051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlbF-0004EZ-0K
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 19:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJW-00025O-Ck
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJV-0006Il-BC
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJV-0006IN-4Y; Sun, 12 Apr 2020 18:42:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id u13so8062644wrp.3;
 Sun, 12 Apr 2020 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OYo+DiZzzLgW1PaTXhyjVreJaHIcZ6V7XrzkquBideQ=;
 b=GI4YldUwnQ704AWWqLC9v1W6ug4JBCEmqei3nREJiJWQFTAuZtn+IkWHENUq5cnnkb
 TRJvpDbWu1asJyi4fYLXTIC/SoOdRuWbC1ITdduIT3Vv9eD0PGnl8jqzy9vfVhzbva20
 xj4A1iqGn+w4/UNoKWYZves5hRotQAJ0uYJ9YnpiCF60+A48YBcrj/1xwsZ33/m6aZJ/
 0IyP8rGn6UCjqHk7VHsp7pG0Ywj/XG2g4JS1yg6ssJAmj+b3SJL6uXxGWktAc8rYcJyi
 G71VeXgKvpU9bIRro+Ja+Q2u90gzSDcV+UQK8c7xrxa3J2XbpPG62xxGaZ0cDjN2jVcA
 MSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OYo+DiZzzLgW1PaTXhyjVreJaHIcZ6V7XrzkquBideQ=;
 b=BDwm6gqpOP5Nby9zd3J1Xk2ufF4iWyDIHFxZ8w9HItsy120CjRAFeFzSMC4c88LH/c
 VwRFS+O9cvmb54gRw1aDpFpL+x9igM7q0IuTIF+78D1uP4PBswf2ztDW8yqlnuSNHXJ5
 NN0uqS821fRXkTTWhaIgqVT8Uuz08MolbwwTpLyt5K2VKlq/oIqPTecjlo1H/RbU2ZtH
 UGj3CLAL6hvql3NRX+WELTgsqEH1YxEcrUGmD42Gdw+x3zyH02QL5JySpMF5uESCAMSC
 DEarj71hS38kOfdkIIlti3D9duYdlRgaCTyUaD3lnSbp155R7WEiOl2B6l/GDNPL5cHJ
 t5hQ==
X-Gm-Message-State: AGi0PuZ7cUQq+nwsfmBbUauTMvGffVHrb1wwSm/OcgnP8Y1//5xprq/l
 X1FAF0WUub4h8sG9MWSCt3UmpxoRiFNOlw==
X-Google-Smtp-Source: APiQypJPoOZoE9FNKAfDmnD/xyoPHxcGMt3UTbnXWqLJmdgRxlLRExdb/doJkwuGG5lB+c4ILaHuug==
X-Received: by 2002:a5d:6204:: with SMTP id y4mr16890187wru.410.1586731371946; 
 Sun, 12 Apr 2020 15:42:51 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm12083825wma.47.2020.04.12.15.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:42:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 17/23] hw/dma/xilinx_axidma: Add missing
 error-propagation code
Date: Mon, 13 Apr 2020 00:41:38 +0200
Message-Id: <20200412224144.12205-18-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412224144.12205-1-f4bug@amsat.org>
References: <20200412224144.12205-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 Alistair Francis <alistair.francis@wdc.com>,
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

Then review showed this file has a 'xilinx_axidma_realize_fail'
label that calls error_propagate().  Updated the patch to use
the label.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: New cocci patch generated both transformations
    (Peter noticed v1 only catched one)
---
 hw/dma/xilinx_axidma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 018f36991b..2d36346319 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -531,6 +531,9 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG,
                              &local_err);
+    if (local_err) {
+        goto xilinx_axidma_realize_fail;
+    }
     object_property_add_link(OBJECT(cs), "dma", TYPE_XILINX_AXI_DMA,
                              (Object **)&cs->dma,
                              object_property_allow_set_link,
@@ -540,6 +543,9 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
         goto xilinx_axidma_realize_fail;
     }
     object_property_set_link(OBJECT(ds), OBJECT(s), "dma", &local_err);
+    if (local_err) {
+        goto xilinx_axidma_realize_fail;
+    }
     object_property_set_link(OBJECT(cs), OBJECT(s), "dma", &local_err);
     if (local_err) {
         goto xilinx_axidma_realize_fail;
-- 
2.21.1


