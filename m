Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F303AC2D0F3
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9AE206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="cAfen+OC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9AE206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzrT-0002yG-S7
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1jJzqo-0002H6-GD
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1jJzqm-00033W-TF
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:25:41 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:59418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1jJzqm-00032g-H8
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1585833940;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=A56yjwRlBjvhVKGrpD4MFT8IBSFQXclYsVZgGSVIWdo=;
 b=cAfen+OCVKzIVUJNGnaqKVnsnIQL4k9Sk7NIbH4FdfsOAjRkcQRHSrkh
 7Q+iDmsF6jK5xzdoW+emMh/jYgr4ztU9PaqDlv1wtmohw88xrBIfXRdo9
 w/Qm7WKAXoSfrYYrbzKx3jmNgM8pyT+/CT4IqgcLXCQG98T/2Uv6bBAFS 8=;
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
IronPort-SDR: LXC2ndia4qGvl37hPXgkfr/Y955DDSuW8VeO8VdFS+hQPxagPPNUi/oyXNE5KEitSvyWP6PAMJ
 J23csRc3kiofQidwHMapu/7MSc5TUdukSPDg7e4rqdewxH5Cuu+y/3F1aXfFNWHm5BnHRSNHSb
 3pcYujCmYccvzQ5sM1t5yLt6YNDC9xT3HbGIRHzU4Ge1/TzW6ZRtnSEaGhL7PMyVyAYLSloYA3
 gUNno8MdKZi3g+qyTBvM8jAtNc7R7xhmR8ceVuk7BzAR4h7RF8kXB6wD1fp9/eiyUTOMIz4KIe
 qfA=
X-SBRS: 2.7
X-MesageID: 15078556
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,335,1580792400"; d="scan'208";a="15078556"
Date: Thu, 2 Apr 2020 14:25:30 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH for-5.0] xen: fixup RAM memory region initialization
Message-ID: <20200402132530.GS4088@perard.uk.xensource.com>
References: <20200327104828.12647-1-imammedo@redhat.com>
 <20200330165248.GR4088@perard.uk.xensource.com>
 <20200402142925.75e0c482@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200402142925.75e0c482@redhat.com>
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

On Thu, Apr 02, 2020 at 02:29:25PM +0200, Igor Mammedov wrote:
> On Mon, 30 Mar 2020 17:52:48 +0100
> Anthony PERARD <anthony.perard@citrix.com> wrote:
> 
> > On Fri, Mar 27, 2020 at 06:48:28AM -0400, Igor Mammedov wrote:
> > > Since bd457782b3b0 ("x86/pc: use memdev for RAM") Xen
> > > machine fails to start with:
> > >    qemu-system-i386: xen: failed to populate ram at 0
> > > 
> > > The reason is that xen_ram_alloc() which is called by
> > > memory_region_init_ram(), compares memory region with
> > > statically allocated 'global' ram_memory memory region
> > > that it uses for RAM, and does nothing in case it matches.
> > > 
> > > While it's possible feed machine->ram to xen_ram_alloc()
> > > in the same manner to keep that hack working, I'd prefer
> > > not to keep that circular dependency and try to untangle that.
> > > 
> > > However it doesn't look trivial to fix, so as temporary
> > > fixup opt out Xen machine from memdev based RAM allocation,
> > > and let xen_ram_alloc() do its trick for now.
> > > 
> > > Reported-by: Anthony PERARD <anthony.perard@citrix.com>
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> > 
> > Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> > 
> > That should work on most configs. But we also sometime use the "pc"
> > machine with accel=xen, to run without the "xen-platform" pci device,
> > but that would be less common.
> 
> does following work for you in case of pc machine?
> 
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index 15650d7f6a..f19c0883ae 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -151,6 +151,8 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
>  
>  static int xen_init(MachineState *ms)
>  {
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +
>      xen_xc = xc_interface_open(0, 0, 0);
>      if (xen_xc == NULL) {
>          xen_pv_printf(NULL, 0, "can't open xen interface\n");
> @@ -170,6 +172,10 @@ static int xen_init(MachineState *ms)
>          return -1;
>      }
>      qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
> +    /*
> +     * opt out of system RAM being allocated by generic code
> +     */
> +    m->default_ram_id = NULL;
>      return 0;

After fixing the build issues, it does work, yes. I've tested both "xenfv"
and "pc,accel=xen".

Build issue:
- I've added #include "hw/boards.h"
- and s/m->/mc->/

Thanks!

-- 
Anthony PERARD

