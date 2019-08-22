Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD2CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484E82133F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="LBMK2pTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484E82133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ocN-0005X2-FK
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 11:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i0oaq-0004dm-Ck
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i0oap-0003kp-0D
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:01:40 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:1370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i0oaf-00031q-Ox; Thu, 22 Aug 2019 11:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566486089;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xX9kQoky48XNuZMh0VoPELOE33q8lA4AkiTo74IRF2w=;
 b=LBMK2pTUyyFvDRYqFpCKUpRbvzOzs0PMJtngZaPC6JxKhjzcmhi0jk11
 GB2vI7b+HvYgBmqG4ePQ6m6xrxk/I6BOaPuZi5e6yLdwgLN/VAwBFnHh8
 obeVU4uK76SXNV90XJ4vfSIOiNt7ot+Prky/yfaD2e0+sYNLE1dO4Fcin s=;
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
IronPort-SDR: mp0gQo6ZNQp39OKlEYggJbIfleWw9b3rYw5U/8vP+QjE27yAvus078wXYSEzUbFbHkm1i6Hj4p
 RHnKPXejwuW+z03B+dRtNuDX5H9uTsNFO7BsEmQUnhjwKn6j43nnIROBTfnvN5FJh7iys5YkpK
 A8HLIXyZStTDjK8nN07Pz/c60NMezstax4ug8vUib9j8Z+TfMOJetboK1tdGuxtbiGiRaI3n/U
 bJFwYn54WeqFlRTQdlLOho3B34GaOT+hzhCkadvCf2t5Wk5QYg/H+I2BisxJ/CzOLyjvjkMXWe
 +0k=
X-SBRS: 2.7
X-MesageID: 4843618
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,417,1559534400"; 
   d="scan'208";a="4843618"
Date: Thu, 22 Aug 2019 16:01:22 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <Paul.Durrant@citrix.com>
Message-ID: <20190822150122.GM1289@perard.uk.xensource.com>
References: <20190821092020.17952-1-anthony.perard@citrix.com>
 <20190821092020.17952-2-anthony.perard@citrix.com>
 <b3a6a2e0022c4785a4a04a809d948cef@AMSPEX02CL03.citrite.net>
 <20190822095043.GI1289@perard.uk.xensource.com>
 <182b784c76aa42949990fc19619e8748@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <182b784c76aa42949990fc19619e8748@AMSPEX02CL03.citrite.net>
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

On Thu, Aug 22, 2019 at 10:59:38AM +0100, Paul Durrant wrote:
> > -----Original Message-----
> > From: Anthony PERARD <anthony.perard@citrix.com>
> > Sent: 22 August 2019 10:51
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: qemu-devel@nongnu.org; qemu-stable@nongnu.org; Stefano Stabellini <sstabellini@kernel.org>; xen-
> > devel@lists.xenproject.org
> > Subject: Re: [PATCH 1/2] xen-bus: Fix backend state transition on device reset
> > 
> > On Wed, Aug 21, 2019 at 10:36:40AM +0100, Paul Durrant wrote:
> > > > diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> > > > index e40500242d..982eca4533 100644
> > > > --- a/hw/xen/xen-bus.c
> > > > +++ b/hw/xen/xen-bus.c
> > > > @@ -540,9 +540,11 @@ static void xen_device_backend_changed(void *opaque)
> > > >      /*
> > > >       * If the toolstack (or unplug request callback) has set the backend
> > > >       * state to Closing, but there is no active frontend (i.e. the
> > > > -     * state is not Connected) then set the backend state to Closed.
> > > > +     * state is not Connected or Closing) then set the backend state
> > > > +     * to Closed.
> > > >       */
> > > >      if (xendev->backend_state == XenbusStateClosing &&
> > > > +        xendev->frontend_state != XenbusStateClosing &&
> > > >          xendev->frontend_state != XenbusStateConnected) {
> > > >          xen_device_backend_set_state(xendev, XenbusStateClosed);
> > >
> > > Actually, I wonder whether it is better to 'whitelist' here? AFAIK the only valid frontend states
> > whether the backend should set itself 'closed' are 'closed' (i.e. the frontend is finished) and
> > 'initialising' (the frontend was never there).
> > 
> > Let's see, what are the reason backend=Closing?
> >     - frontend changed to Closing (because it wants to disconnect)
> >     - toolstack(libxl) or QEMU(unplug request) set the state to Closing,
> >       but also online to 0.
> > 
> > What should the backend do in both case:
> >     - frontend alive: backend should wait
> >         frontend state might be InitWait, Initialised, Connected,
> >         Closing.
> >     - frontend not existing or disconnected: backend can skip waiting
> >       and go to the next step, Closed.
> >         frontend might be Initialising, Closed.
> >         But there are also Unknown, Reconfiguring and Reconfigured which
> >         are probably errors.
> > 
> > So, the whitelist with Closed and Initialising is a good start, but what
> > about the Unknown state? (QEMU doesn't have backends were the state
> > Reconfigur* is possible, so they can be mapped to Unknown for now).
> 
> I guess we should consider Unknown (basically a missing xenstore state key) to mean either an admin, or the frontend has screwed up or is malicious so I think we just close down the backend straight away. So maybe listing InitWait, Initialised, Connected, and Closing as frontend states that are 'good' (i.e. we wait in anticipation of the frontend eventually getting to Closed) and then say all other states result in immediate close of the backend. Probably worth having a helper function for saying whether a state is good or not.

Sounds good, but I'll use "active" instead of "good" to name the helper
as that feels more accurate to me. Also "active" is already used in the
comment. I'll name the new helper xen_device_state_is_active().

Thanks,

-- 
Anthony PERARD

