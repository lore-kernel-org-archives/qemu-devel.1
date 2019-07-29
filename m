Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33817C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09392206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09392206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs10o-0008Bx-9s
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 04:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46440)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hs0zk-0007Hm-KF
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hs0zj-0006Tq-Ba
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:27:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41199)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hs0zj-0006TA-4z
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:26:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so17516301pgg.8
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 01:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uBD8Gqc1+HVwFRh85xt2akmHy8MoXaIde7YZKCvvPUI=;
 b=fXfMJu3TEQ5Pk6HkGEmnWDxYeb+w3iAlhOSz+YsbME6ecrrxj4Y6yN8TvnSqXUVnCE
 2V3scKMQl3qy0hy4fZwCH+PXQuWuMgWQVZz8QJmjiiEjNzaKfrntNJxKU7FsK2yHtYTI
 gaNiRD47hgR7xpiI7CC7nqF6+viGtWUpXcIo2wXQ88SsdUNAjK3d+vql3ThETTcc3Y1r
 M0Be1dwzDiGcgfl9kiYcGesunl4sVpQx8LQRKU5YQiEzI4ZzfRwdW2+Tp6q51eUwH3xq
 24OKSe6XIofoCk7fclhrPMawW/Luzm2NFZkzjJmJcKV5LnX4vIvB+xGM/ilpa6KgabbR
 HyQw==
X-Gm-Message-State: APjAAAWpwY9SkfIpWpJri6fauZLUjzEVfhwgbIr3Bw2YXqYukTkul9YZ
 32weuE/aGN4pkHItFNKutnO89Q==
X-Google-Smtp-Source: APXvYqxOKfBNBJjt1jyhWMoJTKHavYHyYtHmq6WWhjoeGej9vfBoIyQ4PXbEDkOeQQk4C8FNwEyUPw==
X-Received: by 2002:a17:90b:8d8:: with SMTP id
 ds24mr34550144pjb.135.1564388817167; 
 Mon, 29 Jul 2019 01:26:57 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f19sm87958192pfk.180.2019.07.29.01.26.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 01:26:56 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Mon, 29 Jul 2019 16:26:46 +0800
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190729082646.GA19232@xz-x1>
References: <156418830210.10856.17740359763468342629.stgit@gimli.home>
 <156418895336.10856.4789947058672361928.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156418895336.10856.4789947058672361928.stgit@gimli.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
Subject: Re: [Qemu-devel] [for-4.2 PATCH 2/2] hw/i386: AMD-Vi IVRS DMA alias
 support
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
Cc: brijesh.singh@amd.com, mst@redhat.com, qemu-devel@nongnu.org,
 zhexu@redhat.com, eric.auger@redhat.com, Suravee.Suthikulpanit@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 06:55:53PM -0600, Alex Williamson wrote:
> When we account for DMA aliases in the PCI address space, we can no
> longer use a single IVHD entry in the IVRS covering all devices.  We
> instead need to walk the PCI bus and create alias ranges when we find
> a conventional bus.  These alias ranges cannot overlap with a "Select
> All" range (as currently implemented), so we also need to enumerate
> each device with IVHD entries.
> 
> Importantly, the IVHD entries used here include a Device ID, which is
> simply the PCI BDF (Bus/Device/Function).  The guest firmware is
> responsible for programming bus numbers, so the final revision of this
> table depends on the update mechanism (acpi_build_update) to be called
> after guest PCI enumeration.

Ouch... so the ACPI build procedure is after those guest PCI code!
Could I ask how do you find this? :) It seems much easier for sure
this way...

This looks very nice to me already, though I still have got a few
questions, please see below.

[...]

> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
> +        PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
> +        uint8_t sec = pci_bus_num(sec_bus);
> +        uint8_t sub = dev->config[PCI_SUBORDINATE_BUS];
> +
> +        if (pci_bus_is_express(sec_bus)) {
> +            /*
> +             * Walk the bus if there are subordinates, otherwise use a range
> +             * to cover an entire leaf bus.  We could potentially also use a
> +             * range for traversed buses, but we'd need to take care not to
> +             * create both Select and Range entries covering the same device.
> +             * This is easier and potentially more compact.
> +             *
> +             * An example bare metal system seems to use Select entries for
> +             * root ports without a slot (ie. built-ins) and Range entries
> +             * when there is a slot.  The same system also only hard-codes
> +             * the alias range for an onboard PCIe-to-PCI bridge, apparently
> +             * making no effort to support nested bridges.  We attempt to
> +             * be more thorough here.
> +             */
> +            if (sec == sub) { /* leaf bus */
> +                /* "Start of Range" IVHD entry, type 0x3 */
> +                entry = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0)) << 8 | 0x3;
> +                build_append_int_noprefix(table_data, entry, 4);
> +                /* "End of Range" IVHD entry, type 0x4 */
> +                entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
> +                build_append_int_noprefix(table_data, entry, 4);
> +            } else {
> +                pci_for_each_device(sec_bus, sec, insert_ivhd, table_data);
> +            }
> +        } else {
> +            /*
> +             * If the secondary bus is conventional, then we need to create an
> +             * Alias range for everything downstream.  The range covers the
> +             * first devfn on the secondary bus to the last devfn on the
> +             * subordinate bus.  The alias target depends on legacy versus
> +             * express bridges, just as in pci_device_iommu_address_space().
> +             * DeviceIDa vs DeviceIDb as per the AMD IOMMU spec.
> +             */
> +            uint16_t dev_id_a, dev_id_b;
> +
> +            dev_id_a = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
> +
> +            if (pci_is_express(dev) &&
> +                pcie_cap_get_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE) {
> +                dev_id_b = dev_id_a;
> +            } else {
> +                dev_id_b = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn);
> +            }
> +
> +            /* "Alias Start of Range" IVHD entry, type 0x43, 8 bytes */
> +            build_append_int_noprefix(table_data, dev_id_a << 8 | 0x43, 4);
> +            build_append_int_noprefix(table_data, dev_id_b << 8 | 0x0, 4);
> +
> +            /* "End of Range" IVHD entry, type 0x4 */
> +            entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
> +            build_append_int_noprefix(table_data, entry, 4);
> +        }

We've implmented the similar logic for multiple times:

  - When we want to do DMA (pci_requester_id)
  - When we want to fetch the DMA address space (the previous patch)
  - When we fill in the AMD ACPI table (this patch)

Do you think we can generalize them somehow?  I'm thinking how about
we directly fetch RID in the 2nd/3rd use case using pci_requester_id()
(which existed already) and simply use it?

[...]

> +    /*
> +     * A PCI bus walk, for each PCI host bridge, is necessary to create a
> +     * complete set of IVHD entries.  Do this into a separate blob so that we
> +     * can calculate the total IVRS table length here and then append the new
> +     * blob further below.  Fall back to an entry covering all devices, which
> +     * is sufficient when no aliases are present.
> +     */
> +    object_child_foreach_recursive(object_get_root(),
> +                                   ivrs_host_bridges, ivhd_blob);
> +
> +    if (!ivhd_blob->len) {
> +        /*
> +         *   Type 1 device entry reporting all devices
> +         *   These are 4-byte device entries currently reporting the range of
> +         *   Refer to Spec - Table 95:IVHD Device Entry Type Codes(4-byte)
> +         */
> +        build_append_int_noprefix(ivhd_blob, 0x0000001, 4);
> +    }

Is there a real use case for ivhd_blob->len==0?

Thanks,

-- 
Peter Xu

