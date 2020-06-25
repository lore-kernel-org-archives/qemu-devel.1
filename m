Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 04:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D16620773
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 04:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icQETx9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D16620773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joJnV-0005vP-EG
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 00:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1joJmX-0005PT-HI
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 00:46:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1joJmV-0004N3-7w
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 00:46:37 -0400
Received: by mail-wm1-x342.google.com with SMTP id 22so4223902wmg.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 21:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=t0qzPfuJfKGRpfvWHCuE1AalMzrR+pU/RZFuqYjsKBM=;
 b=icQETx9XS/TRy7np0p757GGTicLdxutgYLxyFH92poMXPVzxad2l1IxjiXJHWC28bE
 ZaD/8O+b/n906ywJTvbkS0N7JOeEBXwasnK6Vck7d76aYoYhH51tHqust6JtrpZMWdtR
 jguWur7uF+hV2gTU8LHN8kgKW2CCQ/QUTLHs9SKTg1Cnq1hV7O8vZM2vbyrt+mff+KpJ
 NZHByd8o1IRyZsDkJ/i1BA6MaDYmBq/QNY5Jc1rnvipC9AF+xHDzMDYwJY2t7rUZb54y
 0cE1WR/ES8snwHLHuDiEn0R7LcVfsg/d1+soyElVJZRkSxmyY9HZihif/5wJSAmpqEhs
 AsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t0qzPfuJfKGRpfvWHCuE1AalMzrR+pU/RZFuqYjsKBM=;
 b=h4warl+MTn240o8bJ0ePdfCdTOiobzdPYdFVj4+x2hF0tCtHv9eChv4hlxH8hM1dZ/
 9A5gYQtJ26So67OobINbGEeQ8BTEZLuubX4RLs1jcANUd3LJI41DO7v0cfKqzFe22fua
 /EcNYoiT54CrrEzplEn/z8bNJKPl8t8DjjYrHRYfAaZQ4mIc1+kuQvUwzi/GqwbjV1/l
 Krzm6fTU4/Bwte3coew8HkptMrjTHGCvgQzN1o9uUQ1BoKfLwHUKtZooh5hIbKOVjTaJ
 H3qsaKgV0y1V1h983tdkJxQkEfGrWXTchu8tftOIpolduHF2uU6L5vUxyVoJOdAJbS63
 CPoA==
X-Gm-Message-State: AOAM532TkIPQwy9otjHF6aaWcaTRt5CUSqv1tZiLW7Vc2WTGqzGqs1jg
 p6OIvzRpB5+fO9M/4fVfNpc=
X-Google-Smtp-Source: ABdhPJzUJmWkA/rblwzUYKDiMjYq1+DCGDJ0yKj6TF617nZqyupNkcsxmFFWwPg7ZcqmyisVSzTIMQ==
X-Received: by 2002:a1c:cc07:: with SMTP id h7mr1221995wmb.179.1593060393573; 
 Wed, 24 Jun 2020 21:46:33 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-155-64.inter.net.il. [84.229.155.64])
 by smtp.gmail.com with ESMTPSA id d9sm29485111wre.28.2020.06.24.21.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 21:46:32 -0700 (PDT)
Date: Thu, 25 Jun 2020 07:46:31 +0300
From: Jon Doron <arilou@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v3 3/3] acpi: i386: Move VMBus DSDT entry to SB
Message-ID: <20200625044631.GC5487@jondnuc>
References: <20200618030027.759594-1-arilou@gmail.com>
 <20200618030027.759594-4-arilou@gmail.com>
 <20200623170955.0a4f3ae7@redhat.com>
 <20200625022526.GB5487@jondnuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200625022526.GB5487@jondnuc>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=arilou@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 25/06/2020, Jon Doron wrote:
>On 23/06/2020, Igor Mammedov wrote:
>>On Thu, 18 Jun 2020 06:00:27 +0300
>>Jon Doron <arilou@gmail.com> wrote:
>>
>>>Signed-off-by: Jon Doron <arilou@gmail.com>
>>>---
>>> hw/i386/acpi-build.c | 12 +++++++-----
>>> 1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>>diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>index 6d9df38e31..38be9e5a58 100644
>>>--- a/hw/i386/acpi-build.c
>>>+++ b/hw/i386/acpi-build.c
>>>@@ -1092,7 +1092,6 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
>>> static void build_isa_devices_aml(Aml *table)
>>> {
>>>     ISADevice *fdc = pc_find_fdc0();
>>>-    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
>>>     bool ambiguous;
>>>
>>>     Aml *scope = aml_scope("_SB.PCI0.ISA");
>>>@@ -1113,10 +1112,6 @@ static void build_isa_devices_aml(Aml *table)
>>>         isa_build_aml(ISA_BUS(obj), scope);
>>>     }
>>>
>>>-    if (vmbus_bridge) {
>>>-        aml_append(scope, build_vmbus_device_aml(vmbus_bridge));
>>>-    }
>>>-
>>>     aml_append(table, scope);
>>> }
>>>
>>>@@ -1661,6 +1656,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>>     PCIBus *bus = NULL;
>>>     TPMIf *tpm = tpm_find();
>>>     int i;
>>>+    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
>>>
>>>     dsdt = init_aml_allocator();
>>>
>>>@@ -1675,6 +1671,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>>         aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>>>         aml_append(dev, aml_name_decl("_UID", aml_int(1)));
>>>         aml_append(sb_scope, dev);
>>>+        if (vmbus_bridge) {
>>>+            aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
>>>+        }
>>>         aml_append(dsdt, sb_scope);
>>>
>>>         build_hpet_aml(dsdt);
>>>@@ -1692,6 +1691,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>>         aml_append(dev, aml_name_decl("_UID", aml_int(1)));
>>>         aml_append(dev, build_q35_osc_method());
>>>         aml_append(sb_scope, dev);
>>>+        if (vmbus_bridge) {
>>>+            aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
>>>+        }
>>>         aml_append(dsdt, sb_scope);
>>>
>>>         build_hpet_aml(dsdt);
>>why are you duplicating instead of putting one if () block after
>>
>>if (misc->is_piix4) {
>>} else {
>>}
>>
>>?
>>
>
>Well it seems like Windows is very "picky" about where you declare the 
>VMBS not sure why if i had moved it to the suggested location as such
>
>if (misc->is_piix4) {
>} else {
>}
>
>if (vmbus_bridge) {
>    aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
>    aml_append(dsdt, sb_scope);
>}
>
>Windows would BSOD right away with ACPI error.
>
>Same goes for declaring it before PCI0 device...
>
>-- Jon.

Never mind did a silly mistake ill send a new set shortly

