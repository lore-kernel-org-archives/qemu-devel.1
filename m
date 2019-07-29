Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C690C76186
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 19:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D149F206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 19:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D149F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsAxm-0001xB-0w
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 15:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60543)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hsAx8-0001OP-M2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 15:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hsAx3-0003gm-FW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 15:04:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55965)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hsAx3-0003et-34
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 15:04:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 901553082E69;
 Mon, 29 Jul 2019 19:04:50 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16E8319695;
 Mon, 29 Jul 2019 19:04:42 +0000 (UTC)
Date: Mon, 29 Jul 2019 13:04:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <zhexu@redhat.com>
Message-ID: <20190729130441.5657a535@x1.home>
In-Reply-To: <20190729082646.GA19232@xz-x1>
References: <156418830210.10856.17740359763468342629.stgit@gimli.home>
 <156418895336.10856.4789947058672361928.stgit@gimli.home>
 <20190729082646.GA19232@xz-x1>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 29 Jul 2019 19:04:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 eric.auger@redhat.com, Suravee.Suthikulpanit@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 16:26:46 +0800
Peter Xu <zhexu@redhat.com> wrote:

> On Fri, Jul 26, 2019 at 06:55:53PM -0600, Alex Williamson wrote:
> > When we account for DMA aliases in the PCI address space, we can no
> > longer use a single IVHD entry in the IVRS covering all devices.  We
> > instead need to walk the PCI bus and create alias ranges when we find
> > a conventional bus.  These alias ranges cannot overlap with a "Select
> > All" range (as currently implemented), so we also need to enumerate
> > each device with IVHD entries.
> > 
> > Importantly, the IVHD entries used here include a Device ID, which is
> > simply the PCI BDF (Bus/Device/Function).  The guest firmware is
> > responsible for programming bus numbers, so the final revision of this
> > table depends on the update mechanism (acpi_build_update) to be called
> > after guest PCI enumeration.  
> 
> Ouch... so the ACPI build procedure is after those guest PCI code!
> Could I ask how do you find this? :) It seems much easier for sure
> this way...

I believe this is what MST was referring to with the MCFG update,
acpi_build() is called from both acpi_setup() and acpi_build_update(),
the latter is setup in numerous places to be called via a mechanism
that re-writes the table on certain guest actions.  For instance
acpi_add_rom_blob() passes this function as a callback which turns into
a select_cb in fw_cfg, such that (aiui) the tables are updated before
the guest reads them.  I added some fprintfs in the PCI config write
path to confirm that the update callback occurs after PCI enumeration
for both SeaBIOS and OVMF.  Since we seem to have other dependencies on
this ordering elsewhere, I don't think that the IVRS update is unique
in this regard.
 
> This looks very nice to me already, though I still have got a few
> questions, please see below.
> 
> [...]
> 
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
> > +        PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
> > +        uint8_t sec = pci_bus_num(sec_bus);
> > +        uint8_t sub = dev->config[PCI_SUBORDINATE_BUS];
> > +
> > +        if (pci_bus_is_express(sec_bus)) {
> > +            /*
> > +             * Walk the bus if there are subordinates, otherwise use a range
> > +             * to cover an entire leaf bus.  We could potentially also use a
> > +             * range for traversed buses, but we'd need to take care not to
> > +             * create both Select and Range entries covering the same device.
> > +             * This is easier and potentially more compact.
> > +             *
> > +             * An example bare metal system seems to use Select entries for
> > +             * root ports without a slot (ie. built-ins) and Range entries
> > +             * when there is a slot.  The same system also only hard-codes
> > +             * the alias range for an onboard PCIe-to-PCI bridge, apparently
> > +             * making no effort to support nested bridges.  We attempt to
> > +             * be more thorough here.
> > +             */
> > +            if (sec == sub) { /* leaf bus */
> > +                /* "Start of Range" IVHD entry, type 0x3 */
> > +                entry = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0)) << 8 | 0x3;
> > +                build_append_int_noprefix(table_data, entry, 4);
> > +                /* "End of Range" IVHD entry, type 0x4 */
> > +                entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
> > +                build_append_int_noprefix(table_data, entry, 4);
> > +            } else {
> > +                pci_for_each_device(sec_bus, sec, insert_ivhd, table_data);
> > +            }
> > +        } else {
> > +            /*
> > +             * If the secondary bus is conventional, then we need to create an
> > +             * Alias range for everything downstream.  The range covers the
> > +             * first devfn on the secondary bus to the last devfn on the
> > +             * subordinate bus.  The alias target depends on legacy versus
> > +             * express bridges, just as in pci_device_iommu_address_space().
> > +             * DeviceIDa vs DeviceIDb as per the AMD IOMMU spec.
> > +             */
> > +            uint16_t dev_id_a, dev_id_b;
> > +
> > +            dev_id_a = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
> > +
> > +            if (pci_is_express(dev) &&
> > +                pcie_cap_get_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE) {
> > +                dev_id_b = dev_id_a;
> > +            } else {
> > +                dev_id_b = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn);
> > +            }
> > +
> > +            /* "Alias Start of Range" IVHD entry, type 0x43, 8 bytes */
> > +            build_append_int_noprefix(table_data, dev_id_a << 8 | 0x43, 4);
> > +            build_append_int_noprefix(table_data, dev_id_b << 8 | 0x0, 4);
> > +
> > +            /* "End of Range" IVHD entry, type 0x4 */
> > +            entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
> > +            build_append_int_noprefix(table_data, entry, 4);
> > +        }  
> 
> We've implmented the similar logic for multiple times:
> 
>   - When we want to do DMA (pci_requester_id)
>   - When we want to fetch the DMA address space (the previous patch)
>   - When we fill in the AMD ACPI table (this patch)
> 
> Do you think we can generalize them somehow?  I'm thinking how about
> we directly fetch RID in the 2nd/3rd use case using pci_requester_id()
> (which existed already) and simply use it?

For this patch, I think we could use pci_requester_id() for dev_id_b
above, but we still need to walk the buses and devices, so it really
only simplifies the 'if (pci_is_express...' code block above, and
barely at that since we're at the point in the topology where such a
decision is made.  For the previous patch, pci_requester_id() returns a
BDF and that code is executed before bus numbers are programmed.  We
might still make use of requester_id_cache, but a different interface
would be necessary.  Also note how pci_req_id_cache_get() assumes we're
looking for the requester ID as seen from the root bus while
pci_device_iommu_address_space() is from the bus hosting iommu_fn.
While these are generally the same in practice, it's not required.  I'd
therefore tend to leave that to some future consolidation.  I can
update the comment to include that justification in the previous patch.

> > +    /*
> > +     * A PCI bus walk, for each PCI host bridge, is necessary to create a
> > +     * complete set of IVHD entries.  Do this into a separate blob so that we
> > +     * can calculate the total IVRS table length here and then append the new
> > +     * blob further below.  Fall back to an entry covering all devices, which
> > +     * is sufficient when no aliases are present.
> > +     */
> > +    object_child_foreach_recursive(object_get_root(),
> > +                                   ivrs_host_bridges, ivhd_blob);
> > +
> > +    if (!ivhd_blob->len) {
> > +        /*
> > +         *   Type 1 device entry reporting all devices
> > +         *   These are 4-byte device entries currently reporting the range of
> > +         *   Refer to Spec - Table 95:IVHD Device Entry Type Codes(4-byte)
> > +         */
> > +        build_append_int_noprefix(ivhd_blob, 0x0000001, 4);
> > +    }  
> 
> Is there a real use case for ivhd_blob->len==0?

It was mostly paranoia, but I believe it's really only an Intel
convention that the PCI host bridge appears as a device on the bus.  It
seems possible that we could have a host bridge with no devices, in
which case we'd insert this select-all entry to make the IVRS valid.
Perhaps in combination with AMD exposing their IOMMU as a device on the
PCI bus this is not really an issue, but it's a trivial safety net.
Thanks,

Alex

