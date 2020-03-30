Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F0C2D0E5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A92420776
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="bSiesSCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A92420776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxfm-0006lE-8x
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1jIxej-0005Dm-1p
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1jIxei-00077O-0a
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:52:56 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:29728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1jIxeh-00074C-M5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1585587175;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AXeXsNTJMmSF+e5xX73xlrc4D7iLGMTcVw8qDrghgG8=;
 b=bSiesSCiH8oGL2mo3G1u58m1RuSYi/Aeq/7QHwUNvDPEWYG77WuI6sy+
 v1YpYH+GB9x+wKwKjADpigHjgS+fdM64qaKae4fAb6C4H4KrN8Nd+ztUh
 7YvyHK3BR3ZKTuVqI3Z8FMDEWElzQjarIgUdMw1cTUY6Pvxqj7qlJEZ41 0=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: alVgjttp/oTsW9TdYs19l7wdvB+3cs1GznlA+oYXnaT5Q/owL4ou6u0BslnelCDbS3pqC8TXF3
 hFO/H34OuO/D5zY0ZQjGbgYLItqYvDXKpZLUjIR4H933aoyCUVDB3SRzv+aCWcIU3PwLYHV9J/
 vXFA7CLxnemE99TBh2I7yFyK4nEEOtw0vNZ4G0Z8cufyMM3GXcS7DVBNk8EPqdQMViz8Ja1MGj
 cc49yqFxEimdMMBzApz3pHIGjOfQgG5ynMjsSfENeIWZXDnS+EAsXHrnjb9SVaR282h7JOIcXP
 UwA=
X-SBRS: 2.7
X-MesageID: 15201099
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,325,1580792400"; d="scan'208";a="15201099"
Date: Mon, 30 Mar 2020 17:52:48 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH for-5.0] xen: fixup RAM memory region initialization
Message-ID: <20200330165248.GR4088@perard.uk.xensource.com>
References: <20200327104828.12647-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200327104828.12647-1-imammedo@redhat.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.155.168
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
Cc: pbonzini@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, 2020 at 06:48:28AM -0400, Igor Mammedov wrote:
> Since bd457782b3b0 ("x86/pc: use memdev for RAM") Xen
> machine fails to start with:
>    qemu-system-i386: xen: failed to populate ram at 0
> 
> The reason is that xen_ram_alloc() which is called by
> memory_region_init_ram(), compares memory region with
> statically allocated 'global' ram_memory memory region
> that it uses for RAM, and does nothing in case it matches.
> 
> While it's possible feed machine->ram to xen_ram_alloc()
> in the same manner to keep that hack working, I'd prefer
> not to keep that circular dependency and try to untangle that.
> 
> However it doesn't look trivial to fix, so as temporary
> fixup opt out Xen machine from memdev based RAM allocation,
> and let xen_ram_alloc() do its trick for now.
> 
> Reported-by: Anthony PERARD <anthony.perard@citrix.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

That should work on most configs. But we also sometime use the "pc"
machine with accel=xen, to run without the "xen-platform" pci device,
but that would be less common.

Thanks,

-- 
Anthony PERARD

