Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508CFC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279EA208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279EA208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvLN-0001mW-Ev
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hcvI2-0006he-Rq
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hcvI1-00015o-Ti
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:19:30 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:2973)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hcvHv-0000qu-SP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:19:26 -0400
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: pdHl06SAmh40e4I4kyBj3BraFvL7Tdl2QadbR3LDgbxR9gMZ6HHuKt7YBEHje8h76QnhRzVIch
 jqB5vZ+CHHra0ZZFh/o55KaEyn0v/ZDzWbcXCvjpkFR2wUfRZ1qTCJkTDhd0NzsCNpcSWJvc5Q
 OZ3inPbSoX5gEKVoUXLMLnWSVl+9hTRUsPP5PgQSCl22azgPAF7liH0EdD7Xl45aTJCHgAYat3
 4tbWBQ5CcoqEdLa8d/w5slsn+no973lp8JFvc3HoAYoOkJgxfVqT5HXd6i5524x9aGKv/MvCku
 LVM=
X-SBRS: 2.7
X-MesageID: 1852643
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,386,1557201600"; 
   d="scan'208";a="1852643"
Date: Mon, 17 Jun 2019 18:19:13 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <Paul.Durrant@citrix.com>
Message-ID: <20190617171913.GA15926@perard.uk.xensource.com>
References: <20190617154105.32323-1-anthony.perard@citrix.com>
 <20190617154105.32323-4-anthony.perard@citrix.com>
 <21258fd1788f418bb1a0007a43bf0250@AMSPEX02CL03.citrite.net>
 <20190617164544.GA13449@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190617164544.GA13449@perard.uk.xensource.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.144
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 3/4] xen: Import Xen public
 headers used by xen-hvm.c
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
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 05:45:44PM +0100, Anthony PERARD wrote:
> On Mon, Jun 17, 2019 at 05:15:51PM +0100, Paul Durrant wrote:
> > AFAICT the only place (apart from legacy code in xen_common.h) that
> > params.h is necessary is in xen_suspend_notifier(). I wonder whether
> > that would be better moved into xen_common.h too (since it's just a
> > wrapper round xc_set_hvm_param() and then the inclusion of params.h
> > can be moved there as well.
> 
> :(, I didn't realised that xen_common.h needed params.h too. That patch
> series might not build on older version of Xen. I'll move the inclusion
> of params.h to xen_common.h, and fix params.h to have all the needed
> #defines.

Actually, it works fine without including hvm/params.h in xen_common.h
because xen_common.h includes xenctrl.h which includes hvm/params.h.

So I think instead I'll remove all includes of params.h, because
HVM_PARAM_* are parameters for xc_hvm_param_{get,set}, which is in a
library and not an interface with a guest. Including xenctrl.h should be
enough.

-- 
Anthony PERARD

