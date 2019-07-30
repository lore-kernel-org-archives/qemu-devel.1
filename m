Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B93FC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 01:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDA62070B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 01:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDA62070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsGnX-0000dI-Kk
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 21:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hsGn8-0000E9-Pl
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 21:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hsGn7-0003rm-E5
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 21:19:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hsGn7-0003rE-84
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 21:19:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so28913746pfg.10
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 18:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PItbevyuBtpXPyxo+7j/LVKLL3Kl6ebWcy843w1nRFE=;
 b=quhdYvMq6s53Vupe+/eL5R9fRgbgSxl/8XCo/K5N/XLnUg9/YoLEYi4AUE/9weuLz9
 hvh7MP+iNn3mHaZtWUgonCaSeMlIdC+42TEP9KLHb46s79VdF9q2TPXhjIZHq/81H+C4
 6Q78kCi/VFfGjWkaBNeRQJuo1+wDEoTp6CBQlimJ9Z86mT8YtyuhyMPbbMyP5RkB5XcT
 kFnQ+cmd408e2eIItvJ+2lKoT5MXU1jbfHKR7JNqCn2ArqxOX8vN2jLFb374Zcdg0pE/
 6Fdl1LdF4tsT488UuldJiURYDkslKhaXuFJGhAEJSOP0qP3In1kVTFLxs1I0nHRt8aiL
 mrfQ==
X-Gm-Message-State: APjAAAWl09Hd5iINngj7tHJ7qgkan+ehQWVWruUotUix7Or8EKCuIcx+
 teg6bCjSowMKig7+sqLjivUXEw==
X-Google-Smtp-Source: APXvYqwz4BkeuE24oiXq6S1oq0T9NAfCQMIRI8YwPaqv30W0dBHygitmNT5MW6P1THRBqzHMIbXgvQ==
X-Received: by 2002:a62:7d96:: with SMTP id
 y144mr39437877pfc.156.1564449540148; 
 Mon, 29 Jul 2019 18:19:00 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z24sm110423666pfr.51.2019.07.29.18.18.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 18:18:59 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Tue, 30 Jul 2019 09:18:47 +0800
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190730011847.GB19232@xz-x1>
References: <156418830210.10856.17740359763468342629.stgit@gimli.home>
 <156418895336.10856.4789947058672361928.stgit@gimli.home>
 <20190729082646.GA19232@xz-x1> <20190729130441.5657a535@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190729130441.5657a535@x1.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.194
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
 Peter Xu <zhexu@redhat.com>, eric.auger@redhat.com,
 Suravee.Suthikulpanit@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 29, 2019 at 01:04:41PM -0600, Alex Williamson wrote:
> On Mon, 29 Jul 2019 16:26:46 +0800
> Peter Xu <zhexu@redhat.com> wrote:
> 
> > On Fri, Jul 26, 2019 at 06:55:53PM -0600, Alex Williamson wrote:
> > > When we account for DMA aliases in the PCI address space, we can no
> > > longer use a single IVHD entry in the IVRS covering all devices.  We
> > > instead need to walk the PCI bus and create alias ranges when we find
> > > a conventional bus.  These alias ranges cannot overlap with a "Select
> > > All" range (as currently implemented), so we also need to enumerate
> > > each device with IVHD entries.
> > > 
> > > Importantly, the IVHD entries used here include a Device ID, which is
> > > simply the PCI BDF (Bus/Device/Function).  The guest firmware is
> > > responsible for programming bus numbers, so the final revision of this
> > > table depends on the update mechanism (acpi_build_update) to be called
> > > after guest PCI enumeration.  
> > 
> > Ouch... so the ACPI build procedure is after those guest PCI code!
> > Could I ask how do you find this? :) It seems much easier for sure
> > this way...
> 
> I believe this is what MST was referring to with the MCFG update,
> acpi_build() is called from both acpi_setup() and acpi_build_update(),
> the latter is setup in numerous places to be called via a mechanism
> that re-writes the table on certain guest actions.  For instance
> acpi_add_rom_blob() passes this function as a callback which turns into
> a select_cb in fw_cfg, such that (aiui) the tables are updated before
> the guest reads them.  I added some fprintfs in the PCI config write
> path to confirm that the update callback occurs after PCI enumeration
> for both SeaBIOS and OVMF.  Since we seem to have other dependencies on
> this ordering elsewhere, I don't think that the IVRS update is unique
> in this regard.

Agreed.

[...]

> > We've implmented the similar logic for multiple times:
> > 
> >   - When we want to do DMA (pci_requester_id)
> >   - When we want to fetch the DMA address space (the previous patch)
> >   - When we fill in the AMD ACPI table (this patch)
> > 
> > Do you think we can generalize them somehow?  I'm thinking how about
> > we directly fetch RID in the 2nd/3rd use case using pci_requester_id()
> > (which existed already) and simply use it?
> 
> For this patch, I think we could use pci_requester_id() for dev_id_b
> above, but we still need to walk the buses and devices, so it really
> only simplifies the 'if (pci_is_express...' code block above, and
> barely at that since we're at the point in the topology where such a
> decision is made.  For the previous patch, pci_requester_id() returns a
> BDF and that code is executed before bus numbers are programmed.  We
> might still make use of requester_id_cache, but a different interface
> would be necessary.  Also note how pci_req_id_cache_get() assumes we're
> looking for the requester ID as seen from the root bus while
> pci_device_iommu_address_space() is from the bus hosting iommu_fn.
> While these are generally the same in practice, it's not required.  I'd
> therefore tend to leave that to some future consolidation.  I can
> update the comment to include that justification in the previous patch.

Yes, we can work on top in the future if needed.  I see that Michael
already plan to merge this version, then it may not worth a repost for
the comment (unless there will be a repost, we could mark a TODO).

> 
> > > +    /*
> > > +     * A PCI bus walk, for each PCI host bridge, is necessary to create a
> > > +     * complete set of IVHD entries.  Do this into a separate blob so that we
> > > +     * can calculate the total IVRS table length here and then append the new
> > > +     * blob further below.  Fall back to an entry covering all devices, which
> > > +     * is sufficient when no aliases are present.
> > > +     */
> > > +    object_child_foreach_recursive(object_get_root(),
> > > +                                   ivrs_host_bridges, ivhd_blob);
> > > +
> > > +    if (!ivhd_blob->len) {
> > > +        /*
> > > +         *   Type 1 device entry reporting all devices
> > > +         *   These are 4-byte device entries currently reporting the range of
> > > +         *   Refer to Spec - Table 95:IVHD Device Entry Type Codes(4-byte)
> > > +         */
> > > +        build_append_int_noprefix(ivhd_blob, 0x0000001, 4);
> > > +    }  
> > 
> > Is there a real use case for ivhd_blob->len==0?
> 
> It was mostly paranoia, but I believe it's really only an Intel
> convention that the PCI host bridge appears as a device on the bus.  It
> seems possible that we could have a host bridge with no devices, in
> which case we'd insert this select-all entry to make the IVRS valid.
> Perhaps in combination with AMD exposing their IOMMU as a device on the
> PCI bus this is not really an issue, but it's a trivial safety net.
> Thanks,

That question was only for curiousity.  This code path will only
trigger when AMD vIOMMU is detected so I assume the IOMMU device
should always be there, but of course it won't hurt as a safety net.

Thanks for doing this!

-- 
Peter Xu

