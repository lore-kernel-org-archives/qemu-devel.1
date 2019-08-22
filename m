Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E945AC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 09:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B065E233A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 09:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="PEX9ZPvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B065E233A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0jl7-0001M7-S2
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 05:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i0jkH-0000nM-Oi
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i0jkG-0004P2-Kz
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:51:05 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:52001)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i0jkB-0004ES-6Q; Thu, 22 Aug 2019 05:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566467459;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kb0GU+ttBMqRVpJsDsEvrY2dU+fDlmOn6LXpmrXVq0g=;
 b=PEX9ZPvpqRKbcC87U+1EC9GD94E2e/R84bkxyQIpKQsuIjpNJ0C9bYUb
 eeImD4gCwNeTcYRq8xcafsB5GZiOyoSuNLW6kxY18oVHpdOA/BbyehgOO
 8oFXAkKoSdaGXa6/g9cmDpdOIQl1y0tbhHA+DoFaksx07pPDabcB6G8kg 4=;
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
IronPort-SDR: O9lKIgEh6B6Slbx5Zm/CVt7/QI5+5ITpOd2Z8y6YogdRKcgGkRmzoASFSGOvGW8DP9UsUT/3iB
 yftONNVb6wGJrqkcMMwzEbxojfNQOPZojwx/HAsRpdtrW0hnr6/HG2f/tVMSCG9HpLwSF/WEVu
 cbHUTnVq7EBs4ek9i4i+genesI7ftx1N9LR3umSRsaKXhJ67oJY5aZfA0fxhSEkrNtVvrS588t
 01yrRYs33R5eymDsakQQRSHkWMWOjV3Yr0mPXKO1Y56zjtjKjocqaAEXN4O6dcJTA16nY+Gk73
 IVs=
X-SBRS: 2.7
X-MesageID: 4827446
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,416,1559534400"; 
   d="scan'208";a="4827446"
Date: Thu, 22 Aug 2019 10:50:43 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <Paul.Durrant@citrix.com>
Message-ID: <20190822095043.GI1289@perard.uk.xensource.com>
References: <20190821092020.17952-1-anthony.perard@citrix.com>
 <20190821092020.17952-2-anthony.perard@citrix.com>
 <b3a6a2e0022c4785a4a04a809d948cef@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b3a6a2e0022c4785a4a04a809d948cef@AMSPEX02CL03.citrite.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.144
Subject: Re: [Qemu-devel] [PATCH 1/2] xen-bus: Fix backend state transition
 on device reset
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 10:36:40AM +0100, Paul Durrant wrote:
> > diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> > index e40500242d..982eca4533 100644
> > --- a/hw/xen/xen-bus.c
> > +++ b/hw/xen/xen-bus.c
> > @@ -540,9 +540,11 @@ static void xen_device_backend_changed(void *opaque)
> >      /*
> >       * If the toolstack (or unplug request callback) has set the backend
> >       * state to Closing, but there is no active frontend (i.e. the
> > -     * state is not Connected) then set the backend state to Closed.
> > +     * state is not Connected or Closing) then set the backend state
> > +     * to Closed.
> >       */
> >      if (xendev->backend_state == XenbusStateClosing &&
> > +        xendev->frontend_state != XenbusStateClosing &&
> >          xendev->frontend_state != XenbusStateConnected) {
> >          xen_device_backend_set_state(xendev, XenbusStateClosed);
> 
> Actually, I wonder whether it is better to 'whitelist' here? AFAIK the only valid frontend states whether the backend should set itself 'closed' are 'closed' (i.e. the frontend is finished) and 'initialising' (the frontend was never there).

Let's see, what are the reason backend=Closing?
    - frontend changed to Closing (because it wants to disconnect)
    - toolstack(libxl) or QEMU(unplug request) set the state to Closing,
      but also online to 0.

What should the backend do in both case:
    - frontend alive: backend should wait
        frontend state might be InitWait, Initialised, Connected,
        Closing.
    - frontend not existing or disconnected: backend can skip waiting
      and go to the next step, Closed.
        frontend might be Initialising, Closed.
        But there are also Unknown, Reconfiguring and Reconfigured which
        are probably errors.

So, the whitelist with Closed and Initialising is a good start, but what
about the Unknown state? (QEMU doesn't have backends were the state
Reconfigur* is possible, so they can be mapped to Unknown for now).

Cheers,

-- 
Anthony PERARD

