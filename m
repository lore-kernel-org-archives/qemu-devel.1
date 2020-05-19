Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE100C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD0F207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD0F207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb32t-0000Gk-AF
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 10:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jb31a-0007N4-6t
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:15:18 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:1903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jb31Y-0002nF-Cw
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:15:17 -0400
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: co/52IONfVfY3pD0MBtpGnSbgSNqPj6wROJ39RkFZOsMWttiRHMLfFhEoh2VKpSiTQwBXDMnd0
 fViTxHl1iFXQE8bseAtq4QAmQbDffPEW60yj5pvjfCIR3Wg73tPi17muqUYWCDv8QA3+0ceaCZ
 fvkSMY6GpGcMq1oQvMdgOjPVGwAQ12fy2JOtunh0yf04e+JzFnNczo8lkp/Flo9WDBJhJ3Owt7
 FG5g+6p44b/DokCsHgO+dUOF+d0foZVx7i64X47mJGANiWMegq1YnUpGJ4zBhGNi6ArEZxwkYP
 1vQ=
X-SBRS: 2.7
X-MesageID: 18250272
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,410,1583211600"; d="scan'208";a="18250272"
Date: Tue, 19 May 2020 16:15:00 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] xen: fix build without pci passthrough
Message-ID: <20200519141500.GG54375@Air-de-Roger>
References: <20200504101443.3165-1-roger.pau@citrix.com>
 <20200511134043.GH2116@perard.uk.xensource.com>
 <20200519112806.GF54375@Air-de-Roger>
 <CAFEAcA-RWR_6OQV1EgeYj0WmE89FDKqcywTpgfrMyr8FrELN+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-RWR_6OQV1EgeYj0WmE89FDKqcywTpgfrMyr8FrELN+Q@mail.gmail.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Received-SPF: pass client-ip=216.71.155.175; envelope-from=roger.pau@citrix.com;
 helo=esa6.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 10:15:13
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, FROM_EXCESS_BASE64=0.979,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 01:20:51PM +0100, Peter Maydell wrote:
> On Tue, 19 May 2020 at 12:28, Roger Pau Monné <roger.pau@citrix.com> wrote:
> >
> > On Mon, May 11, 2020 at 02:40:43PM +0100, Anthony PERARD wrote:
> > > On Mon, May 04, 2020 at 12:14:43PM +0200, Roger Pau Monne wrote:
> > > > diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
> > > > index 179775db7b..660dd8a008 100644
> > > > --- a/hw/xen/xen_pt.h
> > > > +++ b/hw/xen/xen_pt.h
> > > > @@ -1,6 +1,7 @@
> > > >  #ifndef XEN_PT_H
> > > >  #define XEN_PT_H
> > > >
> > > > +#include "qemu/osdep.h"
> > >
> > > Why do you need osdep?
> >
> > For CONFIG_XEN_PCI_PASSTHROUGH IIRC.
> 
> All .c files should always include osdep as the first include
> in the file, and .h files should never include osdep (we note
> this in CODING_STYLE.rst).
> 
> If you added this #include to fix a compile issue that would
> suggest that there's a .c file somewhere that's missing the
> mandatory osdep include. I did a quick eyeball of all the files
> that include xen_pt.h, though, and none of them are missing the
> osdep include. So I think you should be able to simply drop the
> osdep include here. If that produces an error, let us know what
> fails and we can work out what's gone wrong.

My bad, didn't know about this rule and just looked up where
CONFIG_XEN_PCI_PASSTHROUGH was defined in order to include it. Will
remove in v2.

Thanks, Roger.

