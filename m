Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F589C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8EF20789
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqDxctZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8EF20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWqK-00062s-IP
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1joWmw-00024b-SX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:39:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27780
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1joWmu-0006rF-PK
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHXZAcPLyGO6RwqDeW2mO0R9wZpTLXIsv0lSSnrTa+4=;
 b=TqDxctZ6ktVHMPqhNu8xVW6fQ9zWTdOgVhsQ+lVyRIqCxa07qF4IRWHgHkysYHVybd9RpS
 bmr5YDU6KNT80Iwt7wTVIguFUOjbzp0FtqvKbjXTb3FJCMqtO4Sh7Gdm4xb9RdlDZ04+ey
 CANLT5jqSp9ZXWiKfQX9iXIjLFb38E4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-RMpWnEZsOcC1ZvfqwkvLVQ-1; Thu, 25 Jun 2020 14:39:47 -0400
X-MC-Unique: RMpWnEZsOcC1ZvfqwkvLVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A12518585A2;
 Thu, 25 Jun 2020 18:39:46 +0000 (UTC)
Received: from localhost (unknown [10.40.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9BBD7CADB;
 Thu, 25 Jun 2020 18:39:43 +0000 (UTC)
Date: Thu, 25 Jun 2020 20:39:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v3 3/3] acpi: i386: Move VMBus DSDT entry to SB
Message-ID: <20200625203940.1075ce5a@redhat.com>
In-Reply-To: <20200625022526.GB5487@jondnuc>
References: <20200618030027.759594-1-arilou@gmail.com>
 <20200618030027.759594-4-arilou@gmail.com>
 <20200623170955.0a4f3ae7@redhat.com>
 <20200625022526.GB5487@jondnuc>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: rvkagan@yandex-team.ru, pbonzini@redhat.com, mail@maciej.szmigiero.name,
 qemu-devel@nongnu.org, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jun 2020 05:25:26 +0300
Jon Doron <arilou@gmail.com> wrote:

> On 23/06/2020, Igor Mammedov wrote:
> >On Thu, 18 Jun 2020 06:00:27 +0300
> >Jon Doron <arilou@gmail.com> wrote:
> >  
> >> Signed-off-by: Jon Doron <arilou@gmail.com>
> >> ---
> >>  hw/i386/acpi-build.c | 12 +++++++-----
> >>  1 file changed, 7 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index 6d9df38e31..38be9e5a58 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -1092,7 +1092,6 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
> >>  static void build_isa_devices_aml(Aml *table)
> >>  {
> >>      ISADevice *fdc = pc_find_fdc0();
> >> -    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
> >>      bool ambiguous;
> >>
> >>      Aml *scope = aml_scope("_SB.PCI0.ISA");
> >> @@ -1113,10 +1112,6 @@ static void build_isa_devices_aml(Aml *table)
> >>          isa_build_aml(ISA_BUS(obj), scope);
> >>      }
> >>
> >> -    if (vmbus_bridge) {
> >> -        aml_append(scope, build_vmbus_device_aml(vmbus_bridge));
> >> -    }
> >> -
> >>      aml_append(table, scope);
> >>  }
> >>
> >> @@ -1661,6 +1656,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >>      PCIBus *bus = NULL;
> >>      TPMIf *tpm = tpm_find();
> >>      int i;
> >> +    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
> >>
> >>      dsdt = init_aml_allocator();
> >>
> >> @@ -1675,6 +1671,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> >>          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> >>          aml_append(sb_scope, dev);
> >> +        if (vmbus_bridge) {
> >> +            aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
> >> +        }
> >>          aml_append(dsdt, sb_scope);
> >>
> >>          build_hpet_aml(dsdt);
> >> @@ -1692,6 +1691,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >>          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> >>          aml_append(dev, build_q35_osc_method());
> >>          aml_append(sb_scope, dev);
> >> +        if (vmbus_bridge) {
> >> +            aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
> >> +        }
> >>          aml_append(dsdt, sb_scope);
> >>
> >>          build_hpet_aml(dsdt);  
> >why are you duplicating instead of putting one if () block after
> >
> >if (misc->is_piix4) {
> >} else {
> >}
> >
> >?
> >  
> 
> Well it seems like Windows is very "picky" about where you declare the 
> VMBS not sure why if i had moved it to the suggested location as such
> 
> if (misc->is_piix4) {
> } else {
> }
> 
> if (vmbus_bridge) {
>      aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
>      aml_append(dsdt, sb_scope);
> }
> 
> Windows would BSOD right away with ACPI error.
> 
> Same goes for declaring it before PCI0 device...

just FYI, Windows has ACPI debugger, so if you attach wingdb at early boot
you can set acpi breakpoint and after that enable all kind of debug info (see MSDN)
that usually say why exactly it doesn't like something in AML.

It used to require checked build and it is tricky to enable but once
you figured how, it works like charm.

> 
> -- Jon.
> 


