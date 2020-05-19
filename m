Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E528C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF16D20708
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF16D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6Mc-0004DO-5F
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jb6M6-0003oQ-8e
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:48:42 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:17312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jb6M3-0002Jy-RF
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:48:41 -0400
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: Kto5CE9hKXDANA3dv6AV+qfGgge3TBQmrrbG0XmUpjg/89DP+YqxeH4ymio+763qd+feXYZuBG
 sTOzD35a1V2G1ShTHilVH2uX6550WljdJUjg+8qrrpvjk87C17Fuu8zUmuXwGPPywqZcS+hc0e
 mrCi3b5gnyEWE9ED6/y/I6+4OakaLs8rT+TjKZ3ARif/rRGJThwHRc8+CF7yIGUCqu2MoKy5Ik
 g2A/eAiEqU3u6zjIxHyqk/3s8T3EoQgsfPlVJh97lTykBCoOFA0XGWUoAUQgjQRkRRH/gKvKJ0
 nzs=
X-SBRS: 2.7
X-MesageID: 18192776
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,410,1583211600"; d="scan'208";a="18192776"
Date: Tue, 19 May 2020 19:48:30 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH v2] xen: fix build without pci passthrough
Message-ID: <20200519174830.GH54375@Air-de-Roger>
References: <20200519143101.75330-1-roger.pau@citrix.com>
 <20200519155258.GC2105@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200519155258.GC2105@perard.uk.xensource.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Received-SPF: pass client-ip=216.71.145.142; envelope-from=roger.pau@citrix.com;
 helo=esa1.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 10:31:12
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
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-devel@nongnu.org, Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 04:52:58PM +0100, Anthony PERARD wrote:
> On Tue, May 19, 2020 at 04:31:01PM +0200, Roger Pau Monne wrote:
> > has_igd_gfx_passthru is only available when QEMU is built with
> > CONFIG_XEN_PCI_PASSTHROUGH, and hence shouldn't be used in common
> > code without checking if it's available.
> > 
> > Fixes: 46472d82322d0 ('xen: convert "-machine igd-passthru" to an accelerator property')
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: Paul Durrant <paul@xen.org>
> > Cc: xen-devel@lists.xenproject.org
> > ---
> > Changes since v1:
> >  - Do not include osdep in header file.
> >  - Always add the setters/getters of igd-passthru, report an error
> >    when attempting to set igd-passthru without built in
> >    pci-passthrough support.
> > ---
> >  hw/xen/xen-common.c | 4 ++++
> >  hw/xen/xen_pt.h     | 6 ++++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> > index 70564cc952..d758770da0 100644
> > --- a/hw/xen/xen-common.c
> > +++ b/hw/xen/xen-common.c
> > @@ -134,7 +134,11 @@ static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
> >  
> >  static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
> >  {
> > +#ifdef CONFIG_XEN_PCI_PASSTHROUGH
> >      has_igd_gfx_passthru = value;
> > +#else
> > +    error_setg(errp, "Xen PCI passthrough support not built in");
> > +#endif
> >  }
> >  
> 
> There's an issue that I haven't thought about before.
> CONFIG_XEN_PCI_PASSTHROUGH is never defined in xen-common.c. So
> xen_set_igd_gfx_passthru will always return an error.
> 
> I'm not sure what to do about that yet, maybe change the way that
> CONFIG_ is defined, or maybe have have the setter/getter in xen_pt.c
> with a stub in stubs/ which would return an error. or maybe some other
> way.

Hm, I think making it available is OK? Would it make sense to set it
in $config_host_mak instead of $config_target_mak?

It's a host property, not a target one AFAICT, as the support in the
host determines whether PCI passthrough is supported or not.

Thanks, Roger.

