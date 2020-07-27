Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C70C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7088720FC3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uuyb6tjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7088720FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03zI-0004Mh-O3
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03yi-0003w1-3d
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:19:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53807
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03yg-0007su-7Z
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595859581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4KatCUtUi43U46Atl2lq5BZU0nb0mygjLHB1Uv+pzig=;
 b=Uuyb6tjQ/931ufByvRzD9VJ8idSuNPyL5J4dIaH0iyA/U/TYQHcj7cgEik/fxlt7okMuv8
 Ad5gqtEx6m27k2WFMhdLyTWRzXzkH65B8qmzNccMcQqa7UmfyefoQALp5k3HJUxPRvJ+v+
 cMiPSz9YdU2LE2SwD6/5AoBwSH+pAUI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-3NU6qu6tPx25WLR8znuyLg-1; Mon, 27 Jul 2020 10:19:39 -0400
X-MC-Unique: 3NU6qu6tPx25WLR8znuyLg-1
Received: by mail-wr1-f70.google.com with SMTP id w7so1693824wre.11
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4KatCUtUi43U46Atl2lq5BZU0nb0mygjLHB1Uv+pzig=;
 b=kUA40JL9RiYM65iWCdivnBEwLgry6cqSGyk82DUuti86XFaFZpaYOw8IkLltAoenXe
 ChgXya6VjcEzJZgM2ZNoqv/xWvQymXS+ayFoTjLtPGUY6JUcud9EFKciq56vGqJM9FMs
 Q5jFMQiDA5zaACRUH3tS1Zki7q27Zhrw0v5g1r3LcrTbDN2nf8wTciktXmClXOAbcxzo
 T4w7tKMOPVGzo1sw3A1RiHKlz+7LDRAb7m9UsVgMWDQuJIn4N67cotZiusHI5ZNgu3TX
 DXRRdvsIpE2IuWzVFk6atdeLwjUsWUvVuy8Jvb3u2bupaqnFETtK+7KQe6HE+gMEjiQs
 adGw==
X-Gm-Message-State: AOAM533cXfYAtcwyCKc4svw8fJrK5kIrl9BHjzU9WNqhL+EhiG/skEdN
 +FHUf1FDdYG4Qj/21JHGGIDxgLoRFKmPDYheDQDeyljlwko9j/y+GWBddY8YZow8wHXWBCJU3gJ
 AI/hbj+ELX9iu74M=
X-Received: by 2002:adf:cf10:: with SMTP id o16mr18915798wrj.380.1595859578502; 
 Mon, 27 Jul 2020 07:19:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+NGh+OCKYXu6+ZCjwrtqN+xjdJZEIV8Y3biPaczNcj97Ntsz/tivp1u3W1bs7XyF8dE7Fqg==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr18915785wrj.380.1595859578277; 
 Mon, 27 Jul 2020 07:19:38 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id s20sm7334140wmh.21.2020.07.27.07.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 07:19:37 -0700 (PDT)
Date: Mon, 27 Jul 2020 10:19:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [virtio-comment] Re: [RFC] ivshmem v2: Shared memory device
 specification
Message-ID: <20200727101824-mutt-send-email-mst@kernel.org>
References: <f109fe5a-92eb-e5a5-bb83-ada42b3a9b61@siemens.com>
 <20200727091802-mutt-send-email-mst@kernel.org>
 <85f69f31-e4c6-e7af-1fa5-90e5a2c81ae8@siemens.com>
 <20200727095239-mutt-send-email-mst@kernel.org>
 <ac7ceefb-99d8-0662-8863-c90c20b2f31a@siemens.com>
MIME-Version: 1.0
In-Reply-To: <ac7ceefb-99d8-0662-8863-c90c20b2f31a@siemens.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>, liang yan <lyan@suse.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 04:17:06PM +0200, Jan Kiszka wrote:
> On 27.07.20 15:56, Michael S. Tsirkin wrote:
> > On Mon, Jul 27, 2020 at 03:39:32PM +0200, Jan Kiszka wrote:
> > > On 27.07.20 15:20, Michael S. Tsirkin wrote:
> > > > On Mon, May 25, 2020 at 09:58:28AM +0200, Jan Kiszka wrote:
> > > > > #### Vendor Specific Capability (ID 09h)
> > > > > 
> > > > > This capability must always be present.
> > > > > 
> > > > > | Offset | Register            | Content                                        |
> > > > > |-------:|:--------------------|:-----------------------------------------------|
> > > > > |    00h | ID                  | 09h                                            |
> > > > > |    01h | Next Capability     | Pointer to next capability or 00h              |
> > > > > |    02h | Length              | 20h if Base Address is present, 18h otherwise  |
> > > > > |    03h | Privileged Control  | Bit 0 (read/write): one-shot interrupt mode    |
> > > > > |        |                     | Bits 1-7: Reserved (0 on read, writes ignored) |
> > > > > |    04h | State Table Size    | 32-bit size of read-only State Table           |
> > > > > |    08h | R/W Section Size    | 64-bit size of common read/write section       |
> > > > > |    10h | Output Section Size | 64-bit size of output sections                 |
> > > > > |    18h | Base Address        | optional: 64-bit base address of shared memory |
> > > > > 
> > > > > All registers are read-only. Writes are ignored, except to bit 0 of
> > > > > the Privileged Control register.
> > > > 
> > > > 
> > > > Is there value in making this follow the virtio vendor-specific
> > > > capability format? That will cost several extra bytes - do you envision
> > > > having many of these in the config space?
> > > 
> > > Of course, this could be modeled with via virtio_pci_cap as well. Would add
> > > 12 unused by bytes and one type byte. If it helps to make the device look
> > > more virtio'ish, but I'm afraid there are more differences at PCI level.
> > 
> > I guess it will be useful if we ever find it handy to make an ivshmem
> > device also be a virtio device. Can't say why yet but if we don't care
> > it vaguely seems kind of like a good idea. I guess it will also be handy
> > if you ever need another vendor specific cap: you already get a way to
> > identify it without breaking drivers.
> > 
> 
> I can look into that. Those 12 wasted bytes are a bit ugly, but so far we
> are not short on config space, even in the non-extended range.
> 
> More problematic is that the existing specification of virtio_pci_cap
> assumes that this describes a structure in a PCI resource, rather than even
> being that data itself, and even a register (privileged control).
> 
> Would it be possible to split the types into two ranges, one for the
> existing structure, one for others - like ivshmem - that will only share the
> cfg_type field?

Sure.

> > 
> > > I do not see a use case for having multiple of those caps above per device.
> > > If someone comes around with a valid use case for having multiple,
> > > non-consequitive shared memory regions for one device, we would need to add
> > > registers for them. But that would also only work for non-BAR regions due to
> > > limited BARs.
> > 
> > 
> > OK, I guess this answers the below too.
> > 
> > > > Also, do we want to define an extended capability format in case this
> > > > is a pci extended capability?
> > > > 
> > > 
> > > What would be the practical benefit? Do you see PCIe caps that could become
> > > useful in virtual setups?
> > 
> > So if we ever have a huge number of these caps, PCIe allows many more
> > caps.
> > 
> > > We don't do that for regular virtio devices
> > > either, do we?
> > 
> > We don't, there's a small number of these so we don't run out of config
> > space.
> 
> Right. But then it would not a be a problem to add PCIe (right before adding
> it becomes impossible) and push new caps into the extended space. And all
> that without breaking existing drivers. It's just a cap, and the spec so far
> does not state that there must be no other cap, neither in current virtio
> nor this ivshmem device.
> 
> Jan

Right.


> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux


