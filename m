Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD87AC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CCA320707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="IKFY/9YW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCA320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixUEq-00085k-O3
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1ixUE7-0007bW-Nl
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1ixUE6-0006XL-RS
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:12:43 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:14276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1ixUE4-0006Sv-CK; Fri, 31 Jan 2020 06:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1580469161;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qfF8oVOo7ctviCi6mg6F9BGnSJ7daqD7vdkZGyymZFw=;
 b=IKFY/9YWN3vUeqJjjT7MY91M7kzuCItI81+BG0CHCl0JsBvN8d2q/YmV
 YjhmLrfKomgVZSOC5rSzirQ+HDxjkwl+XgmvT8l72UqQlM5myyxWpQ4b+
 h+X8NNyzUNVlnCuWxfxAQBIO5UAi5D0MOEPUnGMbMqWNCRjET4Vsg5hkf M=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: vDZIIl5/+JntewELYHJ9/JSdMe3F98V9bYxcBFBFej6UsoUtpFkt+XGuM9/sFQ5N6YsjSgN/g5
 fuxvZflgXWtiiUuFPyen+4T8WGJMrZjOFHMki16w6fHAwwZ11jPscj53yaC2K7kw6U5qV+kPeM
 rrEaSIHNG0f1LPsCSECmVQpQgEuKlQ1NGZZ1d9eL/U5Ff90C/GOTx2EwnJQBZ8NWkfi/smZtqo
 irVUeS70VZzILi6pxAArbgEAeLw/75owOBfpW4gv6EtQYoaTFqFoUI/TQSpqthjUfG3aoJcf/h
 jho=
X-SBRS: 2.7
X-MesageID: 11734366
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,385,1574139600"; d="scan'208";a="11734366"
Date: Fri, 31 Jan 2020 11:12:22 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
To: Julien Grall <jgrall@amazon.com>
Subject: Re: [PATCH] xen-bus/block: explicitly assign event channels to an
 AioContext
Message-ID: <20200131111222.GT1288@perard.uk.xensource.com>
References: <20191216143451.19024-1-pdurrant@amazon.com>
 <20191219171158.GF1267@perard.uk.xensource.com>
 <b2762e84-1cc4-649c-9b53-8754678525f6@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b2762e84-1cc4-649c-9b53-8754678525f6@amazon.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.155
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <pdurrant@amazon.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 10:22:14PM +0000, Julien Grall wrote:
> Hi Anthony,
> 
> On 19/12/2019 17:11, Anthony PERARD wrote:
> > On Mon, Dec 16, 2019 at 02:34:51PM +0000, Paul Durrant wrote:
> > > It is not safe to close an event channel from the QEMU main thread when
> > > that channel's poller is running in IOThread context.
> > > 
> > > This patch adds a new xen_device_set_event_channel_context() function
> > > to explicitly assign the channel AioContext, and modifies
> > > xen_device_bind_event_channel() to initially assign the channel's poller
> > > to the QEMU main thread context. The code in xen-block's dataplane is
> > > then modified to assign the channel to IOThread context during
> > > xen_block_dataplane_start() and de-assign it during in
> > > xen_block_dataplane_stop(), such that the channel is always assigned
> > > back to main thread context before it is closed. aio_set_fd_handler()
> > > already deals with all the necessary synchronization when moving an fd
> > > between AioContext-s so no extra code is needed to manage this.
> > > 
> > > Reported-by: Julien Grall <jgrall@amazon.com>
> > > Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> > 
> > Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> 
> I can't find the patch in QEMU upstream. Are we missing any ack/review for
> this patch?

No, I just need to prepare a pull request. It's in my list of patch for
upstream, so there will be a pull request at some point before the next
QEMU release.

Cheers,

-- 
Anthony PERARD

