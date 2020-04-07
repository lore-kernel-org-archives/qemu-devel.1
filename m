Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CDEC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F832063A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Vf6Xt6MD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F832063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmY6-0008LZ-53
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1jLmXJ-0007XD-3m
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1jLmXH-0001ua-Rs
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:36:57 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:57755)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1jLmXH-0001q4-Hh
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1586259416;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SsT9Oamj5OxkPofHKhqRAG6YWFiTyrPsDiTXFS8P8dI=;
 b=Vf6Xt6MDWHjpygaa4EXCRjQ4jEXLHz2d54OYUFDXdvNFMWlHfB6eCdr4
 T7WP9oAplnXPz4IL7OOzZnoN4CCRfSaSc8Kh7YtfHO4+C/MdWJO6aLYvi
 1Z1c+q25I7iYS6GF5XzFjpdk/HT/Lbpf7tVJicAtlbQns1sySvo/dKeKu E=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: CX4Ax/5XjbHe8LgKLKbtJcs+9a5cNoxD4z3MFeS2nn4M6QRYm/NrbD44xZ93/ojCtDpHof4ASR
 mD+6fv/wZJXYX4l2r1g8tYsczE4vsxJ4R2TyO/Z9TwVfCJJo5uGK3oLnGGoVpiAbo0FfJ7nbvn
 DTWcMWE6+0Qo3aco83TMOFZJ2UtzxXpZpRLOQPaLeEb/Vntq2B/qy8XMt+QVJEE3VXeQ0uYPcP
 ZRPehZqU2/ZuJn+YpHQFd8A70MSoS38oJOvsgpdIKhG2CCzKLLbJVtCz2R9gsNu6PQgf6gWOzB
 gZ4=
X-SBRS: 2.7
X-MesageID: 15303930
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,353,1580792400"; d="scan'208";a="15303930"
Date: Tue, 7 Apr 2020 12:36:34 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH for-5.0] xen: fixup RAM memory region initialization
Message-ID: <20200407113634.GW4088@perard.uk.xensource.com>
References: <20200327104828.12647-1-imammedo@redhat.com>
 <20200330165248.GR4088@perard.uk.xensource.com>
 <20200402142925.75e0c482@redhat.com>
 <20200402132530.GS4088@perard.uk.xensource.com>
 <20200402163033.45585e70@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200402163033.45585e70@redhat.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.153
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
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org,
 ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 04:30:33PM +0200, Igor Mammedov wrote:
> 1. why xen uses memory_region_init_ram() which does not allocate anything

This seems to be due to history.

>    can it use plain memory_region_init() instead?

I can give it a try. And it doesn't work, I had to call qemu_ram_alloc() as
well, to set ram_memory.ram_block.

On the other and, I think memory_region_init_ram_nomigrate() would be
enough. QEMU didn't complain when I migrated the guest.

> 2. how main ram is allocated?

It's done by the toolstack, libxl. It creates a new domain in the
hypervisor, memory allocation is part of this, then QEMU is started, for
emulation of some devices.

There is one thing that QEMU does in regards to memory, it's the call
xc_domain_populate_physmap_exact() in xen_ram_alloc(). This is for when
an emulated PCI device needs some memory, like for the VGA region.

> 3. code has
>            /*                                                                       
>          * Xen does not allocate the memory continuously, it keeps a             
>          * hole of the size computed above or passed in.                         
>          */                                                                      
>         block_len = (1ULL << 32) + x86ms->above_4g_mem_size; 
>    which fixes up size ram memory region
>    can we allocate 1 memory region of ram_size and then
>    alias lower and upper memory instead of that?

I don't know, I don't think I know enough about how memory_region are
used to be able to answer that.

> 4. how RAM migration works in case of xen?

From QEMU, we only migrate devices states, we call the
"xen-save-devices-state" QMP command. Memory migration is done by the
toolstack. In QEMU, there is a bodge in xen_ram_alloc() to avoid having
QEMU doing some "allocation" during migration.

I hope that help.
Cheers,

-- 
Anthony PERARD

