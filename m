Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B2AC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C431D217D7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C431D217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEEz6-0004aA-0v
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 11:17:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEEwg-0002Pz-JM
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEEjd-0004Gx-87
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hEEjc-0004GX-UI
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:01:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB5F83002F84;
	Wed, 10 Apr 2019 15:01:55 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BAB45608A7;
	Wed, 10 Apr 2019 15:01:54 +0000 (UTC)
Date: Wed, 10 Apr 2019 17:01:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190410170150.1c447b12@redhat.com>
In-Reply-To: <20190410142756.GA3136@richard>
References: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
	<20190410142756.GA3136@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 10 Apr 2019 15:01:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410150150.fZFCHLrV8LND3PVDnIwc0nxvD9gbHIWxDD4MjPZ79Y0@z>

On Wed, 10 Apr 2019 22:27:56 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

[...]
> >@@ -2411,19 +2410,7 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
> >     mcfg->allocation[0].start_bus_number = 0;
> >     mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
> > 
> >-    /* MCFG is used for ECAM which can be enabled or disabled by guest.  
> 
> I want to cnfirm what is "enabled or disabled by guest" here.

Firmware theoretically during PCI initialization may disable ECAM support
and that's when we do no need MCFG. In practice that's not happening
(SeaBIOS or UEFI) but we in case there is out there a firmware that does
disable ECAM we do not generate MCFG.

Note:
ACPI tables generated twice, 1st when QEMU starts and the second time
when firmware accesses fwcfg to read blobs for the 1st time.
The later happens after PCI subsystem was initialized by firmware.
At that time we know if ECAM was enabled or not.

> If we don't reserve mcfg and "guest" enable mcfg during running, the ACPI
> table size changed. But the destination still has the original table size,
> since destination "guest" keep sleep during this period.
> 
> Now the migration would face table size difference

with commit a1666142db we do not care as all the tables created on
source will be migrated to destination as is overwriting whatever blobs
destination created on startup.

> and break migration?
nope,

to help you figure out why it works
look at what following git commits did:
  git log c8d6f66ae7..a1666142db
and pay attention to 'used_length'

> 
> >-     * To avoid table size changes (which create migration issues),
> >-     * always create the table even if there are no allocations,
> >-     * but set the signature to a reserved value in this case.
> >-     * ACPI spec requires OSPMs to ignore such tables.
> >-     */
> >-    if (info->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
> >-        /* Reserved signature: ignored by OSPM */
> >-        sig = "QEMU";
> >-    } else {
> >-        sig = "MCFG";
> >-    }
> >-    build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
> >+    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
> > }
> > 
> > /*
> >@@ -2592,6 +2579,9 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
> >     }
> >     mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
> >     qobject_unref(o);
> >+    if (mcfg->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
> >+        return false;
> >+    }
> > 
> >     o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
> >     assert(o);
> >-- 
> >2.7.4  
> 


