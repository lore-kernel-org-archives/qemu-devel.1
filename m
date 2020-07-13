Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D418C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2897F2075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsgVvH6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2897F2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzuR-0000xh-B8
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1juztN-00082r-Bo
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:57:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56798
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1juztL-0006wW-Ii
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594652234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MGf5zK1eJqK9CxGDyrfBY/PulcYs01nTjng6qcipBI=;
 b=ZsgVvH6Vm2FJBjZDiqDeKocQddDbo1gcCVWt5DdCXC5zYGpDY/8CaLpfChBeCQncT/tCyP
 1Eem5csbk7cyNa4CYPsU5z7GWP44/Eiy81dEJe8BvCX52kM/0W5brgjnhMeGtnWyk5Nnxp
 sjJFTkdT9kJ1HC1Vl0lzxZtJjTc8pDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-xrHM4m0RMaWEvFBp21Cb8A-1; Mon, 13 Jul 2020 10:57:12 -0400
X-MC-Unique: xrHM4m0RMaWEvFBp21Cb8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7099B8027FE;
 Mon, 13 Jul 2020 14:57:10 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57A9C5C1BB;
 Mon, 13 Jul 2020 14:56:57 +0000 (UTC)
Date: Mon, 13 Jul 2020 16:56:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH 4/5] hw/i386/acpi-build: Turn off support of PCIe
 native hot-plug and SHPC in _OSC
Message-ID: <20200713165654.1f78af8f@redhat.com>
In-Reply-To: <20200708224615.114077-5-jusual@redhat.com>
References: <20200708224615.114077-1-jusual@redhat.com>
 <20200708224615.114077-5-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  9 Jul 2020 00:46:14 +0200
Julia Suvorova <jusual@redhat.com> wrote:

> Other methods may be used if the system is capable of this and the _OSC bit
> is set. Disable them explicitly to force ACPI PCI hot-plug use. The older
> versions will still use PCIe native.
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  hw/i386/acpi-build.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 5c5ad88ad6..0e2891c3ea 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1599,6 +1599,7 @@ static Aml *build_q35_osc_method(AcpiPmInfo *pm)
>      Aml *method;
>      Aml *a_cwd1 = aml_name("CDW1");
>      Aml *a_ctrl = aml_local(0);
> +    unsigned osc_ctrl;
>  
>      method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
>      aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> @@ -1612,9 +1613,12 @@ static Aml *build_q35_osc_method(AcpiPmInfo *pm)
>  
>      /*
>       * Always allow native PME, AER (no dependencies)
> -     * Allow SHPC (PCI bridges can have SHPC controller)
> +     * Need to disable native and SHPC hot-plug to use acpihp
> +     *
> +     * PCI Firmware Specification, Revision 3.2
seems incomplete, were you going to point to a concrete chapter that requires this change?

>       */
> -    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
> +    osc_ctrl = pm->pcihp_bridge_en ? 0x1C : 0x1F;
Since you are touching this, how about converting this magic number to
something more readable?
i.e.
            set_bit(ACPI_OSC_SHPC_EN,  osc_ctrl)
          or
            osc_ctrl |= BIT(SOME_FEATURE)

> +    aml_append(if_ctx, aml_and(a_ctrl, aml_int(osc_ctrl), a_ctrl));
>  
>      if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
>      /* Unknown revision */
> @@ -1696,7 +1700,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> -        aml_append(dev, build_q35_osc_method());
> +        aml_append(dev, build_q35_osc_method(pm));
>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);
>  
> @@ -1771,7 +1775,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              if (pci_bus_is_express(bus)) {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>                  aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> -                aml_append(dev, build_q35_osc_method());
> +                aml_append(dev, build_q35_osc_method(pm));
>              } else {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>              }


