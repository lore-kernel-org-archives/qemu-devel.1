Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC1DC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B47222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sffq4gBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B47222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CA8-0007Yx-AJ
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j5C8h-0005xO-UI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j5C8g-0007vY-Q8
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:30:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58562
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j5C8g-0007vO-MD
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582306258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iIJbNClAaopu3XcwBy22eUj/Xx5fmW+fWgqNqWuWF1g=;
 b=Sffq4gBrZ+JNB+inQ1AYwN55jSQPAkPhekUIKE14hcIPvsbIai2D1pvz3QpHfCcrFgKhf+
 D6iVLyK+kdtQn1G4gXML41J649mDhQyTaFtG81Cc4viBCP+1EL4lBFvAo1OlyxT5YFCGXk
 B6R0S1cC4tS3XDNJg5uHJZHb6alguRQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-m5mghC3kNru59UMm_LYnfQ-1; Fri, 21 Feb 2020 12:30:56 -0500
X-MC-Unique: m5mghC3kNru59UMm_LYnfQ-1
Received: by mail-wr1-f72.google.com with SMTP id n23so1305023wra.20
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 09:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WhcONAkiFDeuSeZsi9vQPsSpTSVQ47zvNIPLgZ1YRDk=;
 b=oB6HhJChAjfzDIGSMRlkDO/rKGryodUv3JTmmcEXvKAJEk/UmclYPOPc+LNLLGZ3ax
 UI+dxmToC13LR14isg688irjVGAVs2XQio3rv5kSJhz5qzo9NvoLDCRmYVZyhT62NGIT
 VuClHQLn+ADbbHfVZLfHZGAmeVDR7ojGmcmcg/I3ZvTeBKvlbbS+QggUqT+P4AseDWRv
 0IX5ywMzsvr+9lYqoDAg2s0y0Nes6EzdxO0f6sD5qF+MCIDrUOuO/tswymAvYdUzknAo
 7QnULfkAY/d0twM+9QYX0pmdwUOu1vpVU+TURXCYK7KqPD2AzEi8iHzfmdl2sPTRTn4o
 eRRA==
X-Gm-Message-State: APjAAAWFVnH2MIwjlAQL95J55cuVes77eG82gvYWh291Rd7CxNpaOqBZ
 8ZSMBidMlXwirY1idW/sgRo4qrmXUQ6RXLPp96yQfLnr/lDvgovfOnLQOWSjHG2W+eJ2J3jesft
 nI+GWxg21WNCJZSw=
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr50053537wrq.155.1582306254965; 
 Fri, 21 Feb 2020 09:30:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0eeMUTxcT7eJ1BFPV35jFa5u7G1EKn9bk9D2WAVnrHFmnGoyOcBdg2D1PUH07W7NO+HPBBQ==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr50053522wrq.155.1582306254743; 
 Fri, 21 Feb 2020 09:30:54 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h18sm5000871wrv.78.2020.02.21.09.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 09:30:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] scripts/coccinelle: Add a script to let devices own their
 MemoryRegions
Date: Fri, 21 Feb 2020 18:30:43 +0100
Message-Id: <20200221173049.18134-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221173049.18134-1-philmd@redhat.com>
References: <20200221173049.18134-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a device creates a MemoryRegion without setting its ownership,
the MemoryRegion is added to the machine "/unattached" container in
the QOM tree.

Example with the Samsung SMDKC210 board:

  $ arm-softmmu/qemu-system-arm -M smdkc210 -S -monitor stdio
  (qemu) info qom-tree
  /machine (smdkc210-machine)
    /unattached (container)
      /io[0] (qemu:memory-region)
      /exynos4210.dram0[0] (qemu:memory-region)
      /exynos4210.irom[0] (qemu:memory-region)
      /exynos4210.iram[0] (qemu:memory-region)
      /exynos4210.chipid[0] (qemu:memory-region)
      ...
      /device[26] (exynos4210.uart)
        /exynos4210.uart[0] (qemu:memory-region)
    /soc (exynos4210)
      ^
       \__ [*]

The irom/iram/chipid regions should go under 'soc' at [*].

Add a coccinelle script to do automatic semantic patching.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .../memory_region_owner_nonnull.cocci         | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 scripts/coccinelle/memory_region_owner_nonnull.cocci

diff --git a/scripts/coccinelle/memory_region_owner_nonnull.cocci b/scripts=
/coccinelle/memory_region_owner_nonnull.cocci
new file mode 100644
index 0000000000..6748a200b2
--- /dev/null
+++ b/scripts/coccinelle/memory_region_owner_nonnull.cocci
@@ -0,0 +1,80 @@
+/*
+  Usage:
+
+    spatch \
+        --macro-file scripts/cocci-macro-file.h \
+        --sp-file scripts/coccinelle/memory_region_owner_nonnull.cocci \
+        --keep-comments \
+        --in-place \
+        --dir .
+
+*/
+
+// Device is owner
+@@
+typedef DeviceState;
+identifier device_fn, dev, obj;
+expression E1, E2, E3, E4, E5;
+@@
+static void device_fn(DeviceState *dev, ...)
+{
+  ...
+  Object *obj =3D OBJECT(dev);
+  <+...
+(
+- memory_region_init(E1, NULL, E2, E3);
++ memory_region_init(E1, obj, E2, E3);
+|
+- memory_region_init_io(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_io(E1, obj, E2, E3, E4, E5);
+|
+- memory_region_init_alias(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_alias(E1, obj, E2, E3, E4, E5);
+|
+- memory_region_init_rom(E1, NULL, E2, E3, E4);
++ memory_region_init_rom(E1, obj, E2, E3, E4);
+|
+- memory_region_init_ram(E1, NULL, E2, E3, E4);
++ memory_region_init_ram(E1, obj, E2, E3, E4);
+|
+- memory_region_init_ram_ptr(E1, NULL, E2, E3, E4);
++ memory_region_init_ram_ptr(E1, obj, E2, E3, E4);
+|
+- memory_region_init_ram_shared_nomigrate(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_ram_shared_nomigrate(E1, obj, E2, E3, E4, E5);
+)
+  ...+>
+}
+
+// Device is owner
+@@
+identifier device_fn, dev;
+expression E1, E2, E3, E4, E5;
+@@
+static void device_fn(DeviceState *dev, ...)
+{
+  <+...
+(
+- memory_region_init(E1, NULL, E2, E3);
++ memory_region_init(E1, OBJECT(dev), E2, E3);
+|
+- memory_region_init_io(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_io(E1, OBJECT(dev), E2, E3, E4, E5);
+|
+- memory_region_init_alias(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_alias(E1, OBJECT(dev), E2, E3, E4, E5);
+|
+- memory_region_init_rom(E1, NULL, E2, E3, E4);
++ memory_region_init_rom(E1, OBJECT(dev), E2, E3, E4);
+|
+- memory_region_init_ram(E1, NULL, E2, E3, E4);
++ memory_region_init_ram(E1, OBJECT(dev), E2, E3, E4);
+|
+- memory_region_init_ram_ptr(E1, NULL, E2, E3, E4);
++ memory_region_init_ram_ptr(E1, OBJECT(dev), E2, E3, E4);
+|
+- memory_region_init_ram_shared_nomigrate(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_ram_shared_nomigrate(E1, OBJECT(dev), E2, E3, E4, E5)=
;
+)
+  ...+>
+}
--=20
2.21.1


