Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC7CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129892053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTp8Cvpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129892053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsRr6-0007Nf-Bg
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 10:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsRqA-0006MT-Mx
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:11:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsRq8-0000Li-B1
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594044682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PM0DQM8BLixH1G8kDnlr536Bh8ddrq0S7QAt5t4Xkek=;
 b=CTp8Cvpgb2zTKJl23v0568n/FDPS3v2xWLsHOVlTq6cQZZ8NJjxDee5+aqVCBIoESaEaEd
 H4km/WcpPdFFo9IVoCjf4OlHaOCX/sK46btJj6lm9H4vNQGwbce+SGHWY76D8JayrjrJTx
 rQKXt0CAAD18Zo0IjKpdUswUCxOqEVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-4yeTkH9RMr6yPiHfG-lx2w-1; Mon, 06 Jul 2020 10:11:15 -0400
X-MC-Unique: 4yeTkH9RMr6yPiHfG-lx2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 116708015CB;
 Mon,  6 Jul 2020 14:11:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B283B512FE;
 Mon,  6 Jul 2020 14:11:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D338B9D71; Mon,  6 Jul 2020 16:11:06 +0200 (CEST)
Date: Mon, 6 Jul 2020 16:11:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 08/21] microvm/acpi: add minimal acpi support
Message-ID: <20200706141106.pxvzb6mnemwj43kl@sirius.home.kraxel.org>
References: <20200702204859.9876-1-kraxel@redhat.com>
 <20200702204859.9876-9-kraxel@redhat.com>
 <20200703084039-mutt-send-email-mst@kernel.org>
 <20200703192510.laaeku6kvudcs4g2@sirius.home.kraxel.org>
 <20200704053018-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200704053018-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 05, 2020 at 07:48:14AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 03, 2020 at 09:25:10PM +0200, Gerd Hoffmann wrote:
> > On Fri, Jul 03, 2020 at 09:09:43AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jul 02, 2020 at 10:48:46PM +0200, Gerd Hoffmann wrote:
> > > > +    /* copy AML table into ACPI tables blob and patch header there */
> > > > +    g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
> > > > +    build_header(linker, table_data,
> > > > +        (void *)(table_data->data + table_data->len - dsdt->buf->len),
> > > > +        "DSDT", dsdt->buf->len, 5, NULL, NULL);
> > > 
> > > Why 5? Just curious ...
> > 
> > IIRC because the hw reduced hardware profile needs acpi 5+ ...
> > 
> > take care,
> >   Gerd
> 
> Well ACPI spec 5 says revision value is 2.

Yep.  Confused that with FACS.rev

> Let's use standard practice in ACPI code, and add comments near each
> value documenting earliest spec revision where this appeared, chapter
> where they came from and some verbatim text that both explains and can
> be searched for in later spec revisions.

Incremental patch with the changes I have so far.
Anything important missing?

Is there a formal spec (other than the code for arm virt)
for the virtio-mmio acpi entries btw?

take care,
  Gerd

From bc82d52a013169b3738a06f33ac7d2289922a683 Mon Sep 17 00:00:00 2001
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 6 Jul 2020 16:04:36 +0200
Subject: [PATCH] [fixup] microvm acpi spec refs

---
 hw/i386/acpi-microvm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index 2f7e50718f70..51916cab42f7 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -131,7 +131,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
     g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
     build_header(linker, table_data,
         (void *)(table_data->data + table_data->len - dsdt->buf->len),
-        "DSDT", dsdt->buf->len, 5, NULL, NULL);
+        "DSDT", dsdt->buf->len, 2, NULL, NULL);
     free_aml_allocator();
 }
 
@@ -144,25 +144,38 @@ static void acpi_build_microvm(AcpiBuildTables *tables,
     GArray *tables_blob = tables->table_data;
     unsigned dsdt, xsdt;
     AcpiFadtData pmfadt = {
+        /*
+         * minimum version for ACPI_FADT_F_HW_REDUCED_ACPI,
+         * see acpi spec "4.1 Hardware-Reduced ACPI"
+         */
         .rev = 5,
         .minor_ver = 1,
+
         .flags = ((1 << ACPI_FADT_F_HW_REDUCED_ACPI) |
                   (1 << ACPI_FADT_F_RESET_REG_SUP)),
+
+        /* Table 5-33 FADT Format -- SLEEP_CONTROL_REG */
         .sleep_ctl = {
             .space_id = AML_AS_SYSTEM_MEMORY,
             .bit_width = 8,
             .address = GED_MMIO_BASE_REGS + ACPI_GED_REG_SLEEP_CTL,
         },
+
+        /* Table 5-33 FADT Format -- SLEEP_STATUS_REG */
         .sleep_sts = {
             .space_id = AML_AS_SYSTEM_MEMORY,
             .bit_width = 8,
             .address = GED_MMIO_BASE_REGS + ACPI_GED_REG_SLEEP_STS,
         },
+
+        /* Table 5-33 FADT Format -- RESET_REG */
         .reset_reg = {
             .space_id = AML_AS_SYSTEM_MEMORY,
             .bit_width = 8,
             .address = GED_MMIO_BASE_REGS + ACPI_GED_REG_RESET,
         },
+
+        /* Table 5-33 FADT Format -- RESET_VALUE */
         .reset_val = ACPI_GED_RESET_VALUE,
     };
 
@@ -191,7 +204,8 @@ static void acpi_build_microvm(AcpiBuildTables *tables,
     /* RSDP is in FSEG memory, so allocate it separately */
     {
         AcpiRsdpData rsdp_data = {
-            .revision = 2,
+            /* Table 5-27 RSDP Structure */
+            .revision = 2, /* rev2 needed for xsdt support */
             .oem_id = ACPI_BUILD_APPNAME6,
             .xsdt_tbl_offset = &xsdt,
             .rsdt_tbl_offset = NULL,
-- 
2.18.4


