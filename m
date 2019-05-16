Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452CEC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB9720848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB9720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53938 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFXf-0002ae-98
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:31:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFMC-0000a6-2f
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFM8-0001xs-1U
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFM6-0001wn-4p
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id j53so3532445qta.9
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=/K1CzhcIoF7fjAc30rHRUsge+GK+glXAnsnZpkxETzA=;
	b=Mrs3Pcx0AhcTjejGHY9HmZyURRAnKmvxWMyuAeTN7lXR1mtvsKTmy/s+GiY+ghn5Jh
	4F6BLzlkz5Qz8k/emthpcDxLSNTI95cGC4j1bwxKgJG1FZbZeXDkHJKbOejyiq43a5lc
	DAY9Hx5iTbGUx6E/aBQeRPeWP1GsoOtHoUKk2xS0VN16T537iiFeNxillkHfwNC3ONHw
	8YwpmrwJ1Xllar8B3bAJ7PCUlJoQYjsZI/u9wh6zKgzmhCjUONIsBrABcsPKRkg/kfkQ
	QdLi2BaVwyV7JgzMWsvl9Tq3Czen+3KuPxIljPGl6cD7+yM+tKw3Dzwscexjs5cGnzqO
	2v0Q==
X-Gm-Message-State: APjAAAUV9SZ390cEMXqU85MPHqbtFifQeeG519oHxN9DsK6jWFLHObwz
	aXCOqk5DhMF2sRhjlqbs3AMD26o/yMQ=
X-Google-Smtp-Source: APXvYqzyj+J/nKrU1mMPrGRqsev8GuPMFqYsT4gyrabi6k8jKIqNyjGdhLrMv9hxB/ukgkxaWUvqGA==
X-Received: by 2002:ac8:3702:: with SMTP id o2mr41500281qtb.119.1558009165340; 
	Thu, 16 May 2019 05:19:25 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	g55sm3308171qtk.76.2019.05.16.05.19.23
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:19:24 -0700 (PDT)
Date: Thu, 16 May 2019 08:19:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190419003053.8260-3-richardw.yang@linux.intel.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
Subject: [Qemu-devel] [PULL 16/37] hw/arm/virt-acpi-build: remove
 unnecessary variable mcfg_start
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190516121921.wxC6QvrrExXgPXvBH0BcDe2XDXmoOVY5kFbxCq_0MrQ@z>

From: Wei Yang <richardw.yang@linux.intel.com>

mcfg_start points to the start of MCFG table and is used in
build_header. While this information could be derived from mcfg.

This patch removes the unnecessary variable mcfg_start.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190419003053.8260-3-richardw.yang@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt-acpi-build.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index bf9c0bc2f4..12dbaf3846 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -552,7 +552,6 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     const MemMapEntry *memmap = vms->memmap;
     int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
     int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
-    int mcfg_start = table_data->len;
 
     mcfg = acpi_data_push(table_data, len);
     mcfg->allocation[0].address = cpu_to_le64(memmap[ecam_id].base);
@@ -563,8 +562,7 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     mcfg->allocation[0].end_bus_number =
         PCIE_MMCFG_BUS(memmap[ecam_id].size - 1);
 
-    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
-                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
+    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
 }
 
 /* GTDT */
-- 
MST


