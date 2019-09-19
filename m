Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF6FC4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC6021924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jagi61QT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC6021924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4Yz-00048E-NK
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49s-0001fw-D4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49g-0006Fr-SS
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:09 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49f-0006DA-RG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id c10so4431073otd.9
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PNIkOVUyVGiMnom4futjhqgQ2wG4j2xkwRrNLbLlk8M=;
 b=Jagi61QTNzp6AtNXoD1gkdVjMm6ezElun6mOdTDnHvD6Df28DCd7XroItmwtsQMp32
 KgWnAEiaYP52TvkVdvJ4JNhb+5YNwseOd4uCYLY07cjTvPFjMAEQLns/Yo4viANFcd7X
 9LktLk0sZcoFZUA7FEli09wMDmcSs3GAGkECU3DtSGMC1UeuJZBzBoP6iOXU0uyqTNR2
 xyjA/5LQUrtQvo9Z/CMMbsCri998vzWQ5NNIBY39jV2b+rzI6+gbLHBzGhR3V/QTJYD7
 +mLrKh62dQganRJLTvlsciAYA0lhEsZygwvnUnPZqxliWnJnXqk5u4XFBxVzOMNWA8u6
 iWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=PNIkOVUyVGiMnom4futjhqgQ2wG4j2xkwRrNLbLlk8M=;
 b=Vy0IOhVoIHVDaTLctABfQ9Fa9NJ0UJyvSw+9auXmXMO/3kzAfjoFErUM52+9JqqrRw
 MuXqyq86rmSwl2B30UcGRS4CyTAuYfDRVlmtp26sFfSe6FvKwXFf74WDhsolpQOV1b2Y
 fGZAV3EpAhZ8bEgPnm6L7oLxDqBwyzxQsGXq1N+4mGc6CI0ueQaY71AIKBmvt2qXI7H1
 1Xb2EODDXzYxVX+jxDZ0IzHY7+qyVdbotNw33B81uLfz+R4S35D+QNQ0466V1dPbC2Bz
 PN9wwa2R9+VvaH40i2NTewasThmguRkhywVX4s4nKlaMJi9QlkQig5Mc+ioJ/H6Vl1Aj
 rUbA==
X-Gm-Message-State: APjAAAWkuVGzmNz2kH9RvDQHlzc2anOSvdR80SXmZAqgMcrFsk+yL2nn
 zC8pM0rrhsOqiPy8dl7aFg==
X-Google-Smtp-Source: APXvYqyzQovPBWd2mH6wc0MbRe3R9zXOhIhKBQFhfj86dQCfRn4NmCIX6MahtvAGYx5WCWupb/c1jA==
X-Received: by 2002:a05:6830:4a5:: with SMTP id
 l5mr7778730otd.150.1568929189270; 
 Thu, 19 Sep 2019 14:39:49 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id y30sm33572oix.36.2019.09.19.14.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:47 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id 848071805A5;
 Thu, 19 Sep 2019 21:39:37 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 13/15] acpi: Add i2c serial bus CRS handling
Date: Thu, 19 Sep 2019 16:39:22 -0500
Message-Id: <20190919213924.31852-14-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

This will be required for getting IPMI SSIF (SMBus interface) into
the ACPI tables.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/acpi/aml-build.c         | 40 +++++++++++++++++++++++++++++++++++++
 include/hw/acpi/aml-build.h | 18 +++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 78aee1a2f9..2c3702b882 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1874,3 +1874,43 @@ build_hdr:
     build_header(linker, tbl, (void *)(tbl->data + fadt_start),
                  "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_table_id);
 }
+
+/* ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors */
+static Aml *aml_serial_bus_device(uint8_t serial_bus_type, uint8_t flags,
+                                  uint16_t type_flags,
+                                  uint8_t revid, uint16_t data_length,
+                                  uint16_t resource_source_len)
+{
+    Aml *var = aml_alloc();
+    uint16_t length = data_length + resource_source_len + 9;
+
+    build_append_byte(var->buf, 0x8e); /* Serial Bus Connection Descriptor */
+    build_append_int_noprefix(var->buf, length, sizeof(length));
+    build_append_byte(var->buf, 1);    /* Revision ID */
+    build_append_byte(var->buf, 0);    /* Resource Source Index */
+    build_append_byte(var->buf, serial_bus_type); /* Serial Bus Type */
+    build_append_byte(var->buf, flags); /* General Flags */
+    build_append_int_noprefix(var->buf, type_flags, /* Type Specific Flags */
+                              sizeof(type_flags));
+    build_append_byte(var->buf, revid); /* Type Specification Revision ID */
+    build_append_int_noprefix(var->buf, data_length, sizeof(data_length));
+
+    return var;
+}
+
+/* ACPI 5.0: 6.4.3.8.2.1 I2C Serial Bus Connection Resource Descriptor */
+Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
+{
+    uint16_t resource_source_len = strlen(resource_source) + 1;
+    Aml *var = aml_serial_bus_device(AML_SERIAL_BUS_TYPE_I2C, 0, 0, 1,
+                                     6, resource_source_len);
+
+    /* Connection Speed.  Just set to 100K for now, it doesn't really matter. */
+    build_append_int_noprefix(var->buf, 100000, 4);
+    build_append_int_noprefix(var->buf, address, sizeof(address));
+
+    /* This is a string, not a name, so just copy it directly in. */
+    g_array_append_vals(var->buf, resource_source, resource_source_len);
+
+    return var;
+}
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 991cf05134..de4a406568 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -223,6 +223,23 @@ struct AcpiBuildTables {
     BIOSLinker *linker;
 } AcpiBuildTables;
 
+/*
+ * ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors
+ * Serial Bus Type
+ */
+#define AML_SERIAL_BUS_TYPE_I2C  1
+#define AML_SERIAL_BUS_TYPE_SPI  2
+#define AML_SERIAL_BUS_TYPE_UART 3
+
+/*
+ * ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors
+ * General Flags
+ */
+/* Slave Mode */
+#define AML_SERIAL_BUS_FLAG_MASTER_DEVICE       (1 << 0)
+/* Consumer/Producer */
+#define AML_SERIAL_BUS_FLAG_CONSUME_ONLY        (1 << 1)
+
 /**
  * init_aml_allocator:
  *
@@ -347,6 +364,7 @@ Aml *aml_qword_memory(AmlDecode dec, AmlMinFixed min_fixed,
 Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
              uint8_t channel);
 Aml *aml_sleep(uint64_t msec);
+Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source);
 
 /* Block AML object primitives */
 Aml *aml_scope(const char *name_format, ...) GCC_FMT_ATTR(1, 2);
-- 
2.17.1


