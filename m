Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D448DC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A607E2173E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A607E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43471 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSraO-0006if-Ru
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:20:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQo-0007K4-NK
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQn-00085c-OA
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:58 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:33197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrQn-00085R-JJ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:57 -0400
Received: by mail-qk1-f178.google.com with SMTP id p18so9359458qkk.0
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=2QXNj4ZMCJMqbS2LmAum6BddnPhA/twbQo4ma++/UJM=;
	b=cQqUQtTwPK43ofwLIcfT7jFrRCR98obNZPkUZfx2PwTMYyMZhOU8VjpMtQ6v/TIIHy
	fJgm1ZvzVaMjbSu8nySi53Ye5eGtayKqoz5ulS8EpV5Y7kGN+q1DmEDqnkXLoiPFErO6
	EhPofi+o2PjWiHBDs150WCYP7bGSP7pg8THZojg3edA75fRxsvGhOBV9aGoxqOcVTMD6
	hl66jNsnqsjGZwxdcNQapM1jG6zojIf7m7ZTVwu55/2QTljknnAltkJnkPFsitYBaIXQ
	hlO5ZrkaJVpr7IhKNq4BM7KsPFgLUSmqKDvwoMZV1b5qiQHOReJNGHG0bCBQGW32LABX
	PZug==
X-Gm-Message-State: APjAAAXqyGV9iwObZ6N4mgrImjh+i9B0TKyTk2dB1Z31tdBl/rl5FMnx
	BEoK/U2DjH6INNiDAGO3Z8jWC5YUwVI=
X-Google-Smtp-Source: APXvYqzDiL3nA/jyXzzgv0m8emfEkiCTck6jRRacfw7TnwEL9PUbG1nRi+jfdCYj5KMJm0OV4YvGFA==
X-Received: by 2002:a37:4b48:: with SMTP id y69mr55789543qka.77.1558393856889; 
	Mon, 20 May 2019 16:10:56 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	e20sm8723144qkm.42.2019.05.20.16.10.55
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:10:56 -0700 (PDT)
Date: Mon, 20 May 2019 19:10:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.178
Subject: [Qemu-devel] [PULL v2 14/36] q35: acpi: do not create dummy MCFG
 table
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
	Eduardo Habkost <ehabkost@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231054.zICkniZYFP9Qqo_KS3RDFgacbCBc51DVbXAdkYOcPS4@z>

From: Igor Mammedov <imammedo@redhat.com>

Dummy table (with signature "QEMU") creation came from original SeaBIOS
codebase. And QEMU would have to keep it around if there were Q35 machine
that depended on keeping ACPI tables blob constant size. Luckily there
were no versioned Q35 machine types before commit:
  (since 2.3) a1666142db acpi-build: make ROMs RAM blocks resizeable
which obsoleted need to keep ACPI tables blob the same size on source/destination.

Considering the 1st versioned machine is pc-q35-2.4, the dummy table
is not really necessary and it's safe to drop it without breaking
cross version migration in both directions unconditionally.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b4ec14e349..4fb6184cbc 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2413,7 +2413,6 @@ static void
 build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
 {
     AcpiTableMcfg *mcfg;
-    const char *sig;
     int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
 
     mcfg = acpi_data_push(table_data, len);
@@ -2423,19 +2422,7 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
     mcfg->allocation[0].start_bus_number = 0;
     mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
 
-    /* MCFG is used for ECAM which can be enabled or disabled by guest.
-     * To avoid table size changes (which create migration issues),
-     * always create the table even if there are no allocations,
-     * but set the signature to a reserved value in this case.
-     * ACPI spec requires OSPMs to ignore such tables.
-     */
-    if (info->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
-        /* Reserved signature: ignored by OSPM */
-        sig = "QEMU";
-    } else {
-        sig = "MCFG";
-    }
-    build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
+    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
 }
 
 /*
@@ -2604,6 +2591,9 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     }
     mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
     qobject_unref(o);
+    if (mcfg->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
+        return false;
+    }
 
     o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
     assert(o);
-- 
MST


