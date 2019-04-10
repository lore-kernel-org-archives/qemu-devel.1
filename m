Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8DBC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE71720850
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE71720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60633 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEEEE-0003d6-Mv
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 10:29:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEED7-00031U-15
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEED6-0004FX-1r
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:28:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:11947)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hEED5-0004De-NI
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:28:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Apr 2019 07:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; d="scan'208";a="222240458"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga001.jf.intel.com with ESMTP; 10 Apr 2019 07:28:16 -0700
Date: Wed, 10 Apr 2019 22:27:56 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190410142756.GA3136@richard>
References: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [PATCH for-4.1] q35: acpi: do not create dummy
 MCFG table
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: ehabkost@redhat.com, richardw.yang@linux.intel.com, qemu-devel@nongnu.org,
	mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410142756.3nKugQRUFXjEj8voF4_16RBaAWA6li83G27Ys2mSbjc@z>

On Tue, Apr 09, 2019 at 05:00:37PM +0200, Igor Mammedov wrote:
>Dummy table (with signature "QEMU") creation came from original SeaBIOS
>codebase. And QEMU would have to keep it around if there were Q35 machine
>that depended on keeping ACPI tables blob constant size. Luckily there
>were no versioned Q35 machine types before commit:
>  (since 2.3) a1666142db acpi-build: make ROMs RAM blocks resizeable
>which obsoleted need to keep ACPI tables blob the same size on source/destination.

I think we should keep table blob the same size on source/destination.

But with resizable MemoryRegion, we don't need to reserve some dummy space.
Because we can expand it later.

>
>Considering the 1st versioned machine is pc-q35-2.4, the dummy table
>is not really necessary and it's safe to drop it without breaking
>cross version migration in both directions unconditionally.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>---
> hw/i386/acpi-build.c | 18 ++++--------------
> 1 file changed, 4 insertions(+), 14 deletions(-)
>
>diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>index 416da31..8671e25 100644
>--- a/hw/i386/acpi-build.c
>+++ b/hw/i386/acpi-build.c
>@@ -2401,7 +2401,6 @@ static void
> build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
> {
>     AcpiTableMcfg *mcfg;
>-    const char *sig;
>     int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
> 
>     mcfg = acpi_data_push(table_data, len);
>@@ -2411,19 +2410,7 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>     mcfg->allocation[0].start_bus_number = 0;
>     mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
> 
>-    /* MCFG is used for ECAM which can be enabled or disabled by guest.

I want to cnfirm what is "enabled or disabled by guest" here.

If we don't reserve mcfg and "guest" enable mcfg during running, the ACPI
table size changed. But the destination still has the original table size,
since destination "guest" keep sleep during this period.

Now the migration would face table size difference and break migration?

>-     * To avoid table size changes (which create migration issues),
>-     * always create the table even if there are no allocations,
>-     * but set the signature to a reserved value in this case.
>-     * ACPI spec requires OSPMs to ignore such tables.
>-     */
>-    if (info->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
>-        /* Reserved signature: ignored by OSPM */
>-        sig = "QEMU";
>-    } else {
>-        sig = "MCFG";
>-    }
>-    build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
>+    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
> }
> 
> /*
>@@ -2592,6 +2579,9 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>     }
>     mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
>     qobject_unref(o);
>+    if (mcfg->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
>+        return false;
>+    }
> 
>     o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
>     assert(o);
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me

