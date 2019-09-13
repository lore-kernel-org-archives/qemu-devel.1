Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71FEC4CEC5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8843020717
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="T/QOwEK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8843020717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ndd-0000uR-LJ
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i8ncq-0000MQ-IF
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i8ncp-00082R-Hx
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:36:44 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:43856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i8ncp-00080T-7H
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568389004;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vK9H2FuAGPOOWGVYgdWyF+mF3vxGa/lNkxsq+rCpvGs=;
 b=T/QOwEK0DvtdC1IO6QYwWC+KMteMPOH+bA9KUiNhiDB6qWQOMJKpuBU7
 d8BrykgNtMpR+QKco1yetsB+N+sXcQTOD11+1KlVBXWRuVpbSJN9skSBx
 x040YEnKqh2AwTNbLSO4wcUoIw5bv/Vx1TKf3xKdXB33IrhqvLpxpbQw+ E=;
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
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: 6E7rUHjIV5jvqumxc2PsIkXctHvkBxP+IWbMBAwNWCckljK93sMYHNdX74CZffodVxrrSXu1eg
 +mVwXfZoBIPAF1lu0q23EA0WYavfx+ivRerXmfDbHt00UZJwlOKbJELRFeecR/XaFuGJv1vvI5
 IBO8XfEeRkoRnmfu0+I1CPaP0oR8o9iSSWwt79Kt85vULicxf5mWsK97IY2AL9XqDaqc2zCR36
 5ovH2RNcEM4tTizwe/5BVQ00/rP98rpSHng4XmXdve7LrgnBtjkMF+oPNzpsIBMj2/RK7a+GhG
 Vio=
X-SBRS: 2.7
X-MesageID: 5544761
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,501,1559534400"; 
   d="scan'208";a="5544761"
Date: Fri, 13 Sep 2019 16:36:37 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <paul.durrant@citrix.com>
Message-ID: <20190913153637.GF1308@perard.uk.xensource.com>
References: <20190913082159.31338-1-paul.durrant@citrix.com>
 <20190913082159.31338-4-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190913082159.31338-4-paul.durrant@citrix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
Subject: Re: [Qemu-devel] [PATCH v3 3/3] xen: perform XenDevice clean-up in
 XenBus watch handler
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
Cc: xen-devel@lists.xenproject.org, Stefano
 Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 13, 2019 at 09:21:58AM +0100, Paul Durrant wrote:
> Cleaning up offline XenDevice objects directly in
> xen_device_backend_changed() is dangerous as xen_device_unrealize() will
> modify the watch list that is being walked. Even the QLIST_FOREACH_SAFE()
> used in notifier_list_notify() is insufficient as *two* notifiers (for
> the frontend and backend watches) are removed, thus potentially rendering
> the 'next' pointer unsafe.
> 
> The solution is to use the XenBus backend_watch handler to do the clean-up
> instead, as it is invoked whilst walking a separate watch list.
> 
> This patch therefore adds a new 'inactive_devices' list to XenBus, to which
> offline devices are added by xen_device_backend_changed(). The XenBus
> backend_watch registration is also changed to not only invoke
> xen_bus_enumerate() but also a new xen_bus_cleanup() function, which will
> walk 'inactive_devices' and perform the necessary actions.
> For safety an extra 'online' check is also added to xen_bus_type_enumerate()
> to make sure that no attempt is made to create a new XenDevice object for a
> backend that is offline.
> 
> NOTE: This patch also includes some cosmetic changes:
>       - substitute the local variable name 'backend_state'
>         in xen_bus_type_enumerate() with 'state', since there
>         is no ambiguity with any other state in that context.
>       - change xen_device_state_is_active() to
>         xen_device_frontend_is_active() (and pass a XenDevice directly)
>         since the state tests contained therein only apply to a frontend.
>       - use 'state' rather then 'xendev->backend_state' in
>         xen_device_backend_changed() to shorten the code.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> 
> v3:
>  - s/offline_devices/inactive_devices/g
>  - Also add an 'inactive' boolean to XenDevice which is set when the
>    device is added to the inactive list so we really can make sure that it
>    doesn't happen more than once

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

