Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BBAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69FAE20708
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FAE20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb0Qc-0005rF-Ln
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 07:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jb0Px-0005OV-PQ
 for qemu-devel@nongnu.org; Tue, 19 May 2020 07:28:17 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:36186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jb0Pw-0006bU-MH
 for qemu-devel@nongnu.org; Tue, 19 May 2020 07:28:17 -0400
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: k6mOXDwddi60MIyYZcBbG8tvY6FOBiR4VhvoqthRBXYw89Fhix1g0DEwfOdhPT7wYNOYJOvhtN
 Ykg5I65aTj3h8ZPg7nQ7mVVIKUxXyyNElYI39ObkSEtXvRx3/GC6+KwhA+oqilF96belJVDR73
 kA3irFZVw5jVu5VQC2ZwouRLrEEAz+VZuSb6WkrHMT42YDPaapJNVSurGxKiBeE/cR6SOwL7RT
 dEPOmnIvl+MnKjyre7BRycvqDawR+ImknLHOOqOJY3iX1WN8uEaQzJEkYMD/miAHBgV1HWYVju
 8rA=
X-SBRS: 2.7
X-MesageID: 17899145
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,410,1583211600"; d="scan'208";a="17899145"
Date: Tue, 19 May 2020 13:28:06 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH] xen: fix build without pci passthrough
Message-ID: <20200519112806.GF54375@Air-de-Roger>
References: <20200504101443.3165-1-roger.pau@citrix.com>
 <20200511134043.GH2116@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200511134043.GH2116@perard.uk.xensource.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Received-SPF: pass client-ip=216.71.145.153; envelope-from=roger.pau@citrix.com;
 helo=esa2.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 07:28:12
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, FROM_EXCESS_BASE64=0.979,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-devel@nongnu.org, Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 02:40:43PM +0100, Anthony PERARD wrote:
> On Mon, May 04, 2020 at 12:14:43PM +0200, Roger Pau Monne wrote:
> > diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
> > index 179775db7b..660dd8a008 100644
> > --- a/hw/xen/xen_pt.h
> > +++ b/hw/xen/xen_pt.h
> > @@ -1,6 +1,7 @@
> >  #ifndef XEN_PT_H
> >  #define XEN_PT_H
> >  
> > +#include "qemu/osdep.h"
> 
> Why do you need osdep?

For CONFIG_XEN_PCI_PASSTHROUGH IIRC.

> 
> >  #include "hw/xen/xen_common.h"
> >  #include "hw/pci/pci.h"
> >  #include "xen-host-pci-device.h"
> > @@ -322,7 +323,13 @@ extern void *pci_assign_dev_load_option_rom(PCIDevice *dev,
> >                                              unsigned int domain,
> >                                              unsigned int bus, unsigned int slot,
> >                                              unsigned int function);
> > +
> > +#ifdef CONFIG_XEN_PCI_PASSTHROUGH
> >  extern bool has_igd_gfx_passthru;
> > +#else
> > +# define has_igd_gfx_passthru false
> > +#endif
> 
> I don't quite like the use of define here. Could you introduce a
> function that return a bool instead? And defining that function in
> hw/xen/xen.h like xen_enabled() would be fine I think.

But has_igd_gfx_passthru is defined in xen_pt.c which is only compiled
if CONFIG_XEN_PCI_PASSTHROUGH is defined, yet the variable is set from
xen-common.c. I think the former is fine, an any attempt to set
has_igd_gfx_passthru without CONFIG_XEN_PCI_PASSTHROUGH will result in
a compile error which is easier to catch?

Thanks, Roger.

