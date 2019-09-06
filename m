Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8478C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856DE20693
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="JMu8IQ7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856DE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6BUh-00088Y-NO
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <roger.pau@citrix.com>) id 1i6BTo-0007P7-My
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <roger.pau@citrix.com>) id 1i6BTn-0000rn-D2
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:28:36 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:24669)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <roger.pau@citrix.com>)
 id 1i6BTn-0000qd-0C
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1567765714;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=JWp75kInJ0N8E6CPbm9tPaYidl0RCw8ATxINV/r8qqY=;
 b=JMu8IQ7itjD/OXNTTVI7KrnyWU+3m3+kHKgSi+DjzxxHaS/a+vEczUsh
 P491TwGYJET4NLriaq8rP40PvDQl9MKpx6b5negvaDzXgUCmGcyV6adEU
 KhdRRw9kzSSsI+396VrrbKHI0BeWENxdCNmfHzCLsJvYsEnn+mSmjUkv3 8=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=roger.pau@citrix.com;
 spf=Pass smtp.mailfrom=roger.pau@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
 receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
 roger.pau@citrix.com designates 162.221.158.21 as permitted
 sender) identity=mailfrom; client-ip=162.221.158.21;
 receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: VY/F1RiZt7z/H/EgxemdCyMkrKsJOAfBzE0ojXmCuJ/oOBIp4IqEWEPql++l60d85dl27zkgJH
 pqqZLOF91ZiHbMuUmlE0cU+qRp75ZdwIjRuAs/sqxJY2yiJ7M0T37dFX2AMzTlMmSiX8Nh4iNW
 LoGorJlQ4h42bFOHWutTVkuHSxOVBk8gFolckUhsbWjUjv6ti1hpJQBQpgwutFPkoG/2LbuGjz
 PNMITsOgVaublABciIS63IWnPIy5IRCHvXboE90sxo6nNxnJxCJnoJZWjo+iPz3xDrU0TWU2Js
 cSE=
X-SBRS: 2.7
X-MesageID: 5458512
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,472,1559534400"; 
   d="scan'208";a="5458512"
Date: Fri, 6 Sep 2019 12:28:25 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Chao Gao <chao.gao@intel.com>
Message-ID: <20190906102825.mmaphgw7hvoavmv4@Air-de-Roger>
References: <1567069347-22841-1-git-send-email-chao.gao@intel.com>
 <20190829102059.bk4l7itydj73d3ua@Air-de-Roger>
 <20190906090107.GA25703@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190906090107.GA25703@gao-cwp>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.175
Subject: Re: [Qemu-devel] [RFC Patch] xen/pt: Emulate FLR capability
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 Paul Durrant <paul.durrant@citrix.com>, Jan
 Beulich <jbeulich@suse.com>, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 05:01:09PM +0800, Chao Gao wrote:
> On Thu, Aug 29, 2019 at 12:21:11PM +0200, Roger Pau Monné wrote:
> >On Thu, Aug 29, 2019 at 05:02:27PM +0800, Chao Gao wrote:
> >> Currently, for a HVM on Xen, no reset method is virtualized. So in a VM's
> >> perspective, assigned devices cannot be reset. But some devices rely on PCI
> >> reset to recover from hardware hangs. When being assigned to a VM, those
> >> devices cannot be reset and won't work any longer if a hardware hang occurs.
> >> We have to reboot VM to trigger PCI reset on host to recover the device.
> >>
> >> This patch exposes FLR capability to VMs if the assigned device can be reset on
> >> host. When VM initiates an FLR to a device, qemu cleans up the device state,
> >> (including disabling of intx and/or MSI and unmapping BARs from guest, deleting
> >> emulated registers), then initiate PCI reset through 'reset' knob under the
> >> device's sysfs, finally initialize the device again.
> >
> >I think you likely need to deassign the device from the VM, perform
> >the reset, and then assign the device again, so that there's no Xen
> >internal state carried over prior to the reset?
> 
> Yes. It is the safest way. But here I want to present the feature as FLR
> (such that the device driver in guest can issue PCI reset whenever
> needed and no change is needed to device driver).  Current device
> deassignment notifies guest that the device is going to be removed

In which way does a guest get notified?

AFAICT XEN_DOMCTL_deassign_device doesn't do any kind of guest
notification, it just tears down the device.

> It is not the standard PCI reset. Is it possible to make guest unaware
> of the device deassignment to emulate a standard PCI reset?

That would be my expectation. Such deassignment/assignment should be
completely transparent from a guest PoV. My suggestion for doing
the reassignment is to ensure there's no device state carried over.

> In my mind,
> we can expose do_pci_remove/add to qemu or rewrite them in qemu (but
> don't remove the device from guest's PCI hierarchy). Do you think it is
> the right direction?

Doing all this cleanup without reassigning the device seems more
complicated and likely to miss stuff to cleanup IMO, but as long as
you can guarantee there's no state carried over from before the reset
it should be fine.

I think you also need some dom0 cooperation for this, so that for
example the BARs are correctly re-positioned after the reset?

Thanks, Roger.

