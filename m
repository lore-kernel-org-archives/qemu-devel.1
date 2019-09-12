Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA75C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACA62081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Cl2mzgEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACA62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Qeh-0005fJ-NC
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 11:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i8Qdz-0005CX-TD
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i8Qdy-0007gG-Ka
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:04:23 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:45717)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i8Qdy-0007fM-8Z
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568300663;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=P9y4mGUz2FPs+zxXFkR0R4j+FyHZFChLpe8rygzqyCk=;
 b=Cl2mzgEVU2sSPRiNNME1e39/7AMmzMwEjTCvNPy6JHRtpT4NPk8wUefC
 Zn+MZiBGCi9kufUVkOKw/bEuAKJSzS3k0MG8IbF0y6zkUVnYur9S/pe5X
 sSSJN/TIxb+z0fBwd0P197Zz6OBaOWzJJZOIuPAVYD+Pn3vww13Lr0hje M=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: n121mXLNCa+nBuytD9t0P9BVakJ6xOXNJQfKeUBouMQFV+IUljhRp1Df6igfBRQzqZMooT2RfN
 LKA1hSx8cjgZRJEeRD6c252zDntxocuQscGfEkUrT2r4OkGhgD78oLH9VYdoIKCi1MjhpRZYHc
 Nb5/vrsy1qc8q0s/WDVeiPgbWT33hf3MeZ7kiKA7RZ7OLsIJpkCUZx5/mQ0cdN7e9GP6gcLYuZ
 J6oUvSDrlGnKcoRb9TcmmjYBfEQY5pdWJVwKChHMiINzoHhCZgmZWwW73hPQ/ADXHEEuEsnA7q
 /fY=
X-SBRS: 2.7
X-MesageID: 5543206
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,497,1559534400"; 
   d="scan'208";a="5543206"
Date: Thu, 12 Sep 2019 16:04:17 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <paul.durrant@citrix.com>
Message-ID: <20190912150417.GD1308@perard.uk.xensource.com>
References: <20190912121646.29148-1-paul.durrant@citrix.com>
 <20190912121646.29148-4-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190912121646.29148-4-paul.durrant@citrix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.142
Subject: Re: [Qemu-devel] [PATCH v2 3/3] xen: perform XenDevice clean-up in
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

On Thu, Sep 12, 2019 at 01:16:46PM +0100, Paul Durrant wrote:
> Cleaning up offine XenDevice objects directly in
              ^ offline

> xen_device_backend_changed() is dangerous as xen_device_unrealize() will
> modify the watch list that is being walked. Even the QLIST_FOREACH_SAFE()
> used in notifier_list_notify() is insufficient as *two* notifiers (for
> the frontend and backend watches) are removed, thus potentially rendering
> the 'next' pointer unsafe.
> 
> The solution is to use the XenBus backend_watch handler to do the clean-up
> instead, as it is invoked whilst walking a separate watch list.
> 
> This patch therefore adds a new 'offline_devices' list to XenBus, to which
> offline devices are added by xen_device_backend_changed(). The XenBus
> backend_watch registration is also changed to not only invoke
> xen_bus_enumerate() but also a new xen_bus_cleanup() function, which will
> walk 'offline_devices' and perform the necessary actions.
> For safety a an extra 'online' check is also added to
             ^ one 'a' too many?

> xen_bus_type_enumerate() to make sure that no attempt is made to create a
> new XenDevice object for a backend that is offline.
> 
> NOTE: This patch also include some cosmetic changes:
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
> 
> v2:
>  - Make sure we don't try to add a XenDevice to 'offline_devices' more than
>    once
> ---
>  
>      /*
>       * If a backend is still 'online' then we should leave it alone but,
> -     * if a backend is not 'online', then the device should be destroyed
> -     * once the state is Closed.
> +     * if a backend is not 'online', then the device is a candidate
> +     * for destruction. Hence add it to the 'offline' list to be cleaned
> +     * by xen_bus_cleanup().
>       */
> -    if (!xendev->backend_online &&
> -        (xendev->backend_state == XenbusStateClosed ||
> -         xendev->backend_state == XenbusStateInitialising ||
> -         xendev->backend_state == XenbusStateInitWait ||
> -         xendev->backend_state == XenbusStateUnknown)) {
> -        Error *local_err = NULL;
> +    if (!online &&
> +        (state == XenbusStateClosed ||  state == XenbusStateInitialising ||
> +         state == XenbusStateInitWait || state == XenbusStateUnknown) &&
> +        !QLIST_NEXT(xendev, list)) {

Could you add a note about this QLIST_NEXT? I don't think it's going to
be obvious enough why we check that there are no next item. I might only
understand it just because of your reply to the v1 of the patch.
(Well the changelog of the patch also point out what it's for.)

> +        XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
>  
> -        if (!xen_backend_try_device_destroy(xendev, &local_err)) {
> -            object_unparent(OBJECT(xendev));
> -        }
> +        QLIST_INSERT_HEAD(&xenbus->offline_devices, xendev, list);
>  
> -        if (local_err) {
> -            error_report_err(local_err);
> -        }
> +        /*
> +         * Re-write the state to cause a XenBus backend_watch notification,
> +         * resulting in a call to xen_bus_cleanup().
> +         */
> +        xen_device_backend_printf(xendev, "state", "%u", state);

It kind of feels wrong to rely on xenstore to notify QEMU's xenbus
driver that a device needs cleanup. But that does the job.

With a note about the use of QLIST_NEXT and the few typo fixed, the
patch will be good to go.

Thanks,

-- 
Anthony PERARD

