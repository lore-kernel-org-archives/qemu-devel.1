Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528ECC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B08E20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="cZXKDygO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B08E20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCMdD-0000zA-7r
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 07:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1iCMbo-0000Wx-Jq
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1iCMbn-0000tc-4b
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:34:24 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:22013)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1iCMbm-0000sx-RB; Mon, 23 Sep 2019 07:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1569238462;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=C9V1XNGNGp3lxusvYzURNgPlcqbaOJdj/BFIgjmuZUc=;
 b=cZXKDygOqyej0WrObkL3qgxWWG0TcSgrPNFQmSbsFhtW2yhKsv6kODSS
 6PhovfTN07ucIDJQZjwcwyXPkuWkYmrAu0lobt8zS4XCxcYdLNPKe8Ue6
 IHuINLgz/nrzhJ3bYl55Ijd6QFFrCcTkm75+BBuRw1Q+u1kBv7VgzB+3e E=;
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
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: YNDaxjBmlHXItYbIOHbykDFk3488MaibJbPtF6Tu+ihPIn5yiVf3iFFF4keHUus5fGaMJPbk/g
 /3UAVqG3i0DnZeuiYUUkZtCjp3iDmnlscv6C/XteCsR0OG2t9auA+BGMnhImG2oIWyn2pD8uBY
 L7emd/ojXGANxJEZcRe2KYu6o+7DVxc/+aII2WboEcB06py8at6E8bEWodfvlYvnJH8na+lT8w
 YlotNOew9oYuIKuopqhpmPX+fzlO/pk1yzh5w7h6i8XXJUUri8yRMyUHwfFShUqZU/cnhQq49x
 ORw=
X-SBRS: 2.7
X-MesageID: 6137737
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,539,1559534400"; 
   d="scan'208";a="6137737"
Date: Mon, 23 Sep 2019 12:34:15 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <paul.durrant@citrix.com>
Subject: Re: [PATCH] xen-block: treat XenbusStateUnknown the same as
 XenbusStateClosed
Message-ID: <20190923113415.GA1163@perard.uk.xensource.com>
References: <20190918115702.38959-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190918115702.38959-1-paul.durrant@citrix.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 xen-devel@lists.xenproject.org, Mark Syms <mark.syms@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 18, 2019 at 12:57:02PM +0100, Paul Durrant wrote:
> When a frontend gracefully disconnects from an offline backend, it will
> set its own state to XenbusStateClosed. The code in xen-block.c correctly
> deals with this and sets the backend into XenbusStateClosed. Unfortunately
> it is possible for toolstack to actually delete the frontend area
> before the state key has been read, leading to an apparent frontend state
> of XenbusStateUnknown. This prevents the backend state from transitioning
> to XenbusStateClosed and hence leaves it limbo.
> 
> This patch simply treats a frontend state of XenbusStateUnknown the same
> as XenbusStateClosed, which will unblock the backend in these circumstances.
> 
> Reported-by: Mark Syms <mark.syms@citrix.com>
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

