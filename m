Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7423C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC5B2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC5B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48628 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyMj-0006zf-2M
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 10:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hdyJ6-0004tA-Hs
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hdyJ5-0004Z0-Dm
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:44:56 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:4538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hdyJ3-0004SK-Cn
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:44:55 -0400
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: 1sCmiKCYkoe89KWYsURXFs9tBSqHb1xjM95LYeqbwYSY7AhHT6qPPUQNls9YvgrS09Fu9aPyM3
 4qLNsqZiZk0+UKY/5xMd7R61wZ5ox5hiiQm0g58xGELo7oxA1bEzAStndEWztgyG5cvugyrWsS
 ho7DVdNZMWWMnECA1Fn9piuvhGR7ec9jec1SxfJjPocjBweFzlwxND6Q/DvA/ekLGn90VT1VqS
 YG+Gz/J1/Sn6zQyoZpIax7gZa6+TjkpMFkx5vrRE1Vq6XG/u8fU/NXKzSbXvEE4+J5U/qHCJAq
 S70=
X-SBRS: 2.7
X-MesageID: 2019550
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,397,1557201600"; 
   d="scan'208";a="2019550"
Date: Thu, 20 Jun 2019 15:44:46 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190620144446.GD13449@perard.uk.xensource.com>
References: <20190618112341.513-1-anthony.perard@citrix.com>
 <20190618112341.513-2-anthony.perard@citrix.com>
 <20190618121408.GM28525@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190618121408.GM28525@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.142
Subject: Re: [Qemu-devel] [PATCH v2 1/4] xen: Fix build with public headers
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
Cc: xen-devel@lists.xenproject.org, Paul Durrant <paul.durrant@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 01:14:08PM +0100, Daniel P. Berrangé wrote:
> On Tue, Jun 18, 2019 at 12:23:38PM +0100, Anthony PERARD wrote:
> > Following 37677d7db3 "Clean up a few header guard symbols", QEMU start
> > to fail to build:
> > 
> > In file included from ~/xen/tools/../tools/include/xen/io/blkif.h:31:0,
> >                  from ~/xen/tools/qemu-xen-dir/hw/block/xen_blkif.h:5,
> >                  from ~/xen/tools/qemu-xen-dir/hw/block/xen-block.c:22:
> > ~/xen/tools/../tools/include/xen/io/ring.h:68:0: error: "__CONST_RING_SIZE" redefined [-Werror]
> >  #define __CONST_RING_SIZE(_s, _sz) \
> > 
> > In file included from ~/xen/tools/qemu-xen-dir/hw/block/xen_blkif.h:4:0,
> >                  from ~/xen/tools/qemu-xen-dir/hw/block/xen-block.c:22:
> > ~/xen/tools/qemu-xen-dir/include/hw/xen/io/ring.h:66:0: note: this is the location of the previous definition
> >  #define __CONST_RING_SIZE(_s, _sz) \
> > 
> > The issue is that some public xen headers have been imported (by
> > f65eadb639 "xen: import ring.h from xen") but not all. With the change
> > in the guards symbole, the ring.h header start to be imported twice.
> 
> Ah, so the include/hw/xen/io/ring.h file in tree is a copy of
> /usr/include/xen/io/ring.h from xen-devel.  Previously both
> these used "#ifndef __XEN_PUBLIC_IO_RING_H__". After
> the header guard cleanup in 37677d7db3, our local copy used a
> different header guard from the installed copy & thus we're
> not protected from dual inclusion.
> 
> IMHO the right solutions here are either
> 
>  - Don't copy public Xen headers into our tree
>  - Keep our Xen header copies identical to the originals
> 
> Importing public headers and then changing them locally is the worst
> thing to do. With that in mind I think we should revert the part of
> commit 37677d7db3 that touched the imported Xen headers.

Yes, it's propably a better thing to do. So, I'm going to update the
series and do:
- revert part of 37677d7db3
- import the public headers that depends on ring.h. Or in other words,
  the one that describe an interface with a guest.
  I'll do some modification on the headers but only to remove the stuff
  that QEMU doesn't need (like how to make an hypercall).

Thanks,

-- 
Anthony PERARD

