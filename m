Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFADC4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B7F208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B7F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ggb-0006Xp-I4
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i7gfG-0005Fi-Vd
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i7gfF-0007sw-PR
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:58:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i7gfE-0007px-Jl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:58:37 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 73F65C049D59
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 13:58:32 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id o13so14306907qtr.15
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 06:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uPdPA5bUioiMuZxTUPLlf6cg6hW/+AnYzPAjtcP7SPo=;
 b=Ir0HghXKPUfccaU/vt4pXPtwERrNoVyhdga99RHxoc9p7RTttrdDsJfwDx8C7/edKK
 AVJtI3w10WoYLj46uYJVwcYEntI7ZCX6v9lRfxr9Z3biFfRQl0UQvDISaz48Avux3c3j
 QNkm+yzdCGRQjeQLbBohxUy/Yqj8JKk6O//FGN5VpO3SkPp+LLOVxDbaASl9loSEEWnV
 6ac3KaZqUfzTcTBt0H5xTCf46MEODagITZL1uRJ5xxhPSYwfCNd8r/ZSONiswlHu8DX/
 wxM/wxj1ivNfoh+xQkejAjWH1g55ZpOSGXp+fLLdkeUKPD73OjV40KMrJql0IfGKyuJ2
 m2Xg==
X-Gm-Message-State: APjAAAXmwJ17Z9yxvT4FsDQQYGU006c2Rnpd3ZtzhRe0+DjTrIqJ1pMA
 Sxm7u8P3llkRJ1PPaKXFWl03z1zQXmoMobYNKvdXOAQM0FKZylYnr/vl/5Cl0zHTy4WUB26PgUv
 6K08UavuhfaIIqIs=
X-Received: by 2002:a37:af81:: with SMTP id
 y123mr16096841qke.145.1568123911734; 
 Tue, 10 Sep 2019 06:58:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyldhv3lg1QPNoSUedeHbyMHM+TXHpH05GMGK88q9K6a3MedftBla1dR42YmPI+Kc5sGQedPw==
X-Received: by 2002:a37:af81:: with SMTP id
 y123mr16096825qke.145.1568123911559; 
 Tue, 10 Sep 2019 06:58:31 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
 by smtp.gmail.com with ESMTPSA id 1sm8446090qko.73.2019.09.10.06.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 06:58:30 -0700 (PDT)
Date: Tue, 10 Sep 2019 09:58:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190910095329-mutt-send-email-mst@kernel.org>
References: <1568049517-10261-1-git-send-email-andychiu@synology.com>
 <20190910025404-mutt-send-email-mst@kernel.org>
 <9f402933-7256-75da-af77-2e47b656ab27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f402933-7256-75da-af77-2e47b656ab27@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] ahci: enable pci bus master MemoryRegion
 before loading ahci engines
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 andychiu <andychiu@synology.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 09:50:41AM -0400, John Snow wrote:
> 
> 
> On 9/10/19 3:04 AM, Michael S. Tsirkin wrote:
> > On Tue, Sep 10, 2019 at 01:18:37AM +0800, andychiu wrote:
> >> If Windows 10 guests have enabled 'turn off hard disk after idle'
> >> option in power settings, and the guest has a SATA disk plugged in,
> >> the SATA disk will be turned off after a specified idle time.
> >> If the guest is live migrated or saved/loaded with its SATA disk
> >> turned off, the following error will occur:
> >>
> >> qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
> >> qemu-system-x86_64: Failed to load ich9_ahci:ahci
> >> qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:1a.0/ich9_ahci'
> >> qemu-system-x86_64: load of migration failed: Operation not permitted
> >>
> >> Observation from trace logs shows that a while after Windows 10 turns off
> >> a SATA disk (IDE disks don't have the following behavior),
> >> it will disable the PCI_COMMAND_MASTER flag of the pci device containing
> >> the ahci device. When the the disk is turning back on,
> >> the PCI_COMMAND_MASTER flag will be restored first.
> >> But if the guest is migrated or saved/loaded while the disk is off,
> >> the post_load callback of ahci device, ahci_state_post_load(), will fail
> >> at ahci_cond_start_engines() if the MemoryRegion
> >> pci_dev->bus_master_enable_region is not enabled, with pci_dev pointing
> >> to the PCIDevice struct containing the ahci device.
> >>
> >> This patch enables pci_dev->bus_master_enable_region before calling
> >> ahci_cond_start_engines() in ahci_state_post_load(), and restore the
> >> MemoryRegion to its original state afterwards.
> >>
> >> Signed-off-by: andychiu <andychiu@synology.com>
> > 
> > Poking at PCI device internals like this seems fragile.  And force
> > enabling bus master can lead to unpleasantness like corrupting guest
> > memory, unhandled interrupts, etc.  E.g. it's quite reasonable,
> > spec-wise, for the guest to move thing in memory around while bus
> > mastering is off.
> > 
> > Can you teach ahci that region being disabled
> > during migration is ok, and recover from it?
> 
> That's what I'm wondering.
> 
> I could try to just disable the FIS RX engine if the mapping fails, but
> that will require a change to guest visible state.
> 
> My hunch, though, is that when windows re-enables the device it will
> need to re-program the address registers anyway, so it might cope well
> with the FIS RX bit getting switched off.
> 
> (I'm wondering if it isn't a mistake that QEMU is trying to re-map this
> address in the first place. Is it legal that the PCI device has pci bus
> master disabled but we've held on to a mapping?

If you are poking at guest memory when bus master is off, then most likely yes.

> Should there be some
> callback where AHCI knows to invalidate mappings at that point...?)

ATM the callback is the config write, you check
proxy->pci_dev.config[PCI_COMMAND] & PCI_COMMAND_MASTER
and if disabled invalidate the mapping.

virtio at least has code that pokes at
proxy->pci_dev.config[PCI_COMMAND] too, I'm quite
open to a function along the lines of
pci_is_bus_master_enabled()
that will do this.

-- 
MST

