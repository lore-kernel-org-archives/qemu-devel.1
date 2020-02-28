Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08E0C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD9924695
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtSCFbdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD9924695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eJd-0002Tv-SC
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e8b-0002DV-L0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e8Z-0001fH-Ub
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:49:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56528
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e8Z-0001el-Qd
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0EjffDBHi226hzTHZyYKDBY0an4Sy/NVV/eLW24fAuA=;
 b=MtSCFbdATYHb6iDoakdBJ16AWdklLr7PaqR/D2//3Kl8NEtuYv/pTycyUhCESjL3VajwCc
 r78IhveISEnBXJom5CA9W19JJ02fTIBJjXbsEah5hlAHcKwfX6IsqL8sRjW3XyoCm/Ju39
 p9/e9k6OUKRhBdRk5j+crSUwmHN5yBk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-UfNw6tDUPeuSHwUYX0vK8w-1; Fri, 28 Feb 2020 06:48:55 -0500
X-MC-Unique: UfNw6tDUPeuSHwUYX0vK8w-1
Received: by mail-wm1-f70.google.com with SMTP id r19so1060080wmh.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BPdxKBjgOkVXpave73Lu3/06gouy+pZ7PYERljGC+KE=;
 b=ImASRwvT/BpUft/lEOncSF1wCByeFGJHS2cY16k/HPp5UK4iq8Uy1VIZP6ViaYqBv7
 GIYwCgMYn8qTnXxJhd/ADnbyHzw3Q7e9hft51PR1ii1RoBCvHlhHtZCUg+YOlPJUMqmL
 ff4Hr6CEeQ8WwebQ+intUB/A2J7QgsNftmkauyDP/vbla1zqhhi2QX0wRJ18NXx41S8e
 B9mofo1d98ENaLsd4LMioG3e9xo9fvELbH4K0OwrVn1X+OE+q6ri0sMaflD8lLaRB1Xp
 5f3olIwCdO3OLbFge62JR04+aLuFrTD18moDbsqd8lmBdkrK19HEHvSf/2GW3c85QbXe
 M+ww==
X-Gm-Message-State: APjAAAV5mvgnmy6vr2Fk11cydSrdN5Q/FKhWv9JLq2PrzaYzv6g2Ur2q
 scgaM13QL5YThhPa0RnODC80hnPIyHNfoHS9HH5TlcEJCEcuNef0qRwTw9Cbgjk2cqZk7Bs/meR
 /ZTs1vJj6vyu3QUA=
X-Received: by 2002:a05:6000:110b:: with SMTP id
 z11mr4639896wrw.252.1582890534149; 
 Fri, 28 Feb 2020 03:48:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqy//wMIiuctKGtFr41xfgEgf5isK9uuTADKNwt1zPFLxAqJZPIfd7EY0Bb+5FjTtOpyr+fLHg==
X-Received: by 2002:a05:6000:110b:: with SMTP id
 z11mr4639875wrw.252.1582890533948; 
 Fri, 28 Feb 2020 03:48:53 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id 133sm2082799wmd.5.2020.02.28.03.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:48:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/18] hw/i386: Include "hw/mem/nvdimm.h"
Date: Fri, 28 Feb 2020 12:46:47 +0100
Message-Id: <20200228114649.12818-17-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228114649.12818-1-philmd@redhat.com>
References: <20200228114649.12818-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All this files use methods/definitions declared in the NVDIMM
device header. Include it.

This fixes (when modifying unrelated headers):

  hw/i386/acpi-build.c:2733:9: error: implicit declaration of function 'nvd=
imm_build_acpi' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
        ^
  hw/i386/pc.c:1996:61: error: use of undeclared identifier 'TYPE_NVDIMM'
    const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
                                                            ^
  hw/i386/pc.c:2032:55: error: use of undeclared identifier 'TYPE_NVDIMM'
    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
                                                      ^
  hw/i386/pc.c:2040:9: error: implicit declaration of function 'nvdimm_plug=
' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
        nvdimm_plug(ms->nvdimms_state);
        ^
  hw/i386/pc.c:2040:9: error: this function declaration is not a prototype =
[-Werror,-Wstrict-prototypes]
        nvdimm_plug(ms->nvdimms_state);
        ^
  hw/i386/pc.c:2065:42: error: use of undeclared identifier 'TYPE_NVDIMM'
    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
                                         ^
  hw/i386/pc_i440fx.c:307:9: error: implicit declaration of function 'nvdim=
m_init_acpi_state' is invalid in C99 [-Werror,-Wimplicit-function-declarati=
on]
        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
        ^
  hw/i386/pc_q35.c:332:9: error: implicit declaration of function 'nvdimm_i=
nit_acpi_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
        ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/acpi-build.c | 1 +
 hw/i386/pc.c         | 1 +
 hw/i386/pc_piix.c    | 1 +
 hw/i386/pc_q35.c     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9c4e46fa74..9335a82e9f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -47,6 +47,7 @@
 #include "hw/rtc/mc146818rtc_regs.h"
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
+#include "hw/mem/nvdimm.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6ab4acb0c6..362eb2a180 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -76,6 +76,7 @@
 #include "hw/boards.h"
 #include "acpi-build.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fa12203079..82f1693901 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -60,6 +60,7 @@
 #include "migration/global_state.h"
 #include "migration/misc.h"
 #include "sysemu/numa.h"
+#include "hw/mem/nvdimm.h"
=20
 #define MAX_IDE_BUS 2
=20
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 84cf925cf4..d37c425e22 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -53,6 +53,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
+#include "hw/mem/nvdimm.h"
=20
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
--=20
2.21.1


