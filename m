Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47996C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1317220829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXiVtf70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1317220829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1RVV-0008PC-Af
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k1RNY-0002NV-3L
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 05:31:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51340
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k1RNU-0003m3-Nw
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 05:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596187858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avUZqf5McAGRwwNjwfZVhZ7w0CW8QQ239W1kTOGToNE=;
 b=KXiVtf70Rq84lCJJTjxX0wf0AbQSdvQDaiBAzZQK4uZ+bJ3+MX7IpfBQvklvn3naveq8H4
 8eK3Ol/WXOR+0cH90kU5p3sPv+A1vQh9YUHz5OV7hB5azyfyCQHOznQecZ7UrLb4KfqUj2
 Q5ALac99JGH3DaTobWvIJfTtbglox+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-MSu-KIxsOuGQlJl-Uhj86A-1; Fri, 31 Jul 2020 05:30:54 -0400
X-MC-Unique: MSu-KIxsOuGQlJl-Uhj86A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30832193F584;
 Fri, 31 Jul 2020 09:30:52 +0000 (UTC)
Received: from localhost (unknown [10.40.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2538E261A1;
 Fri, 31 Jul 2020 09:30:45 +0000 (UTC)
Date: Fri, 31 Jul 2020 11:30:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] i386/acpi: fix inconsistent QEMU/OVMF device paths
Message-ID: <20200731113044.12b5f6ef@redhat.com>
In-Reply-To: <20200730155755.188845-1-mst@redhat.com>
References: <20200730155755.188845-1-mst@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 03:06:50
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, vit9696 <vit9696@protonmail.com>,
 Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 11:58:38 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> macOS uses ACPI UIDs to build the DevicePath for NVRAM boot options,
> while OVMF firmware gets them via an internal channel through QEMU.
> Due to a bug in QEMU ACPI currently UEFI firmware and ACPI have
> different values, and this makes the underlying operating system
> unable to report its boot option.
> 
> The particular node in question is the primary PciRoot (PCI0 in ACPI),
> which for some reason gets assigned 1 in ACPI UID and 0 in the
> DevicePath. This is due to the _UID assigned to it by build_dsdt in
> hw/i386/acpi-build.c Which does not correspond to the primary PCI
> identifier given by pcibus_num in hw/pci/pci.c
> 
> Reference with the device paths, OVMF startup logs, and ACPI table
> dumps (SysReport):
> https://github.com/acidanthera/bugtracker/issues/1050
> 
> In UEFI v2.8, section "10.4.2 Rules with ACPI _HID and _UID" ends with
> the paragraph,
> 
>     Root PCI bridges will use the plug and play ID of PNP0A03, This will
>     be stored in the ACPI Device Path _HID field, or in the Expanded
>     ACPI Device Path _CID field to match the ACPI name space. The _UID
>     in the ACPI Device Path structure must match the _UID in the ACPI
>     name space.
> 
> (See especially the last sentence.)
> 
> Considering *extra* root bridges / root buses (with bus number > 0),
> QEMU's ACPI generator actually does the right thing; since QEMU commit
> c96d9286a6d7 ("i386/acpi-build: more traditional _UID and _HID for PXB
> root buses", 2015-06-11).
> 
> However, the _UID values for root bridge zero (on both i440fx and q35)
> have always been "wrong" (from UEFI perspective), going back in QEMU to
> commit 74523b850189 ("i386: add ACPI table files from seabios",
> 2013-10-14).
> 
> Even in SeaBIOS, these _UID values have always been 1; see commit
> a4d357638c57 ("Port rombios32 code from bochs-bios.", 2008-03-08) for
> i440fx, and commit ecbe3fd61511 ("seabios: q35: add dsdt", 2012-12-01)
> for q35.
> 
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Tested-by: vit9696 <vit9696@protonmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a..7a5a8b3521 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1497,7 +1497,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          dev = aml_device("PCI0");
>          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);
>  
> @@ -1512,7 +1512,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>          aml_append(dev, build_q35_osc_method());
>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);


