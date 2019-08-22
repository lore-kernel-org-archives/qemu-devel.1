Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2A0C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220F4233FE
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="R3lC7PkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220F4233FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0jvU-0006CT-Ar
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i0jsf-0004p2-Co
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i0jsd-0002PD-RM
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:59:45 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:24826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i0jsd-0002N3-J9; Thu, 22 Aug 2019 05:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566467983;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fsIi7e1/bpRHfkFyvftR+ITkTlvFYpqgeRVHMgrw7uA=;
 b=R3lC7PkKMggRcF34yiWslz2UaANb2r5sHKp4DVdz7cKq2R4pzOUX5zp0
 YDu89SG+hqbca0pjuSoKt4EDjFSABKMcDIX+BqXY+xb2G+DgHV7oJfqQt
 8B7UaeWPrKN4ikJJiZlqGYfK8ALOd0xIlTaLhs7bEz2tVsrJ27n4XI5w4 c=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: loCDtdyTUefkq2LnXSzqN4QRGdmZRnLt955lHP5jGGTdwvEAKRQCmxNjIONgeyw8cg6z6PUnCo
 YmN+iNAex8JynB+qLBzSXArJt+bQnWZnA+2JZs+3awyjNQQVn6lZXFye/2JNPq8Vqd7uplEa/L
 exjMSAapeoAQsyUJkUZasuOwe//SOr/K3nrV3/omwxMIRbKE02F6lp/fYTV+OWafwsfyJcBcH6
 gGNmk0x6uVxEt9qK0Ao0s8UtuohdhbmYjjELsq1h61wfjLfUaMjmDjevFYW64wztK55glxTUzn
 MRY=
X-SBRS: 2.7
X-MesageID: 4791675
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,416,1559534400"; 
   d="scan'208";a="4791675"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>
Thread-Topic: [PATCH 1/2] xen-bus: Fix backend state transition on device reset
Thread-Index: AQHVWAGpRkr1DBFa80ag1hnV7DDUQKcFVfWwgAF2oICAACIB0A==
Date: Thu, 22 Aug 2019 09:59:38 +0000
Message-ID: <182b784c76aa42949990fc19619e8748@AMSPEX02CL03.citrite.net>
References: <20190821092020.17952-1-anthony.perard@citrix.com>
 <20190821092020.17952-2-anthony.perard@citrix.com>
 <b3a6a2e0022c4785a4a04a809d948cef@AMSPEX02CL03.citrite.net>
 <20190822095043.GI1289@perard.uk.xensource.com>
In-Reply-To: <20190822095043.GI1289@perard.uk.xensource.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.175
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

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 22 August 2019 10:51
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-stable@nongnu.org; Stefano Stabellini <ss=
tabellini@kernel.org>; xen-
> devel@lists.xenproject.org
> Subject: Re: [PATCH 1/2] xen-bus: Fix backend state transition on device =
reset
>=20
> On Wed, Aug 21, 2019 at 10:36:40AM +0100, Paul Durrant wrote:
> > > diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> > > index e40500242d..982eca4533 100644
> > > --- a/hw/xen/xen-bus.c
> > > +++ b/hw/xen/xen-bus.c
> > > @@ -540,9 +540,11 @@ static void xen_device_backend_changed(void *opa=
que)
> > >      /*
> > >       * If the toolstack (or unplug request callback) has set the bac=
kend
> > >       * state to Closing, but there is no active frontend (i.e. the
> > > -     * state is not Connected) then set the backend state to Closed.
> > > +     * state is not Connected or Closing) then set the backend state
> > > +     * to Closed.
> > >       */
> > >      if (xendev->backend_state =3D=3D XenbusStateClosing &&
> > > +        xendev->frontend_state !=3D XenbusStateClosing &&
> > >          xendev->frontend_state !=3D XenbusStateConnected) {
> > >          xen_device_backend_set_state(xendev, XenbusStateClosed);
> >
> > Actually, I wonder whether it is better to 'whitelist' here? AFAIK the =
only valid frontend states
> whether the backend should set itself 'closed' are 'closed' (i.e. the fro=
ntend is finished) and
> 'initialising' (the frontend was never there).
>=20
> Let's see, what are the reason backend=3DClosing?
>     - frontend changed to Closing (because it wants to disconnect)
>     - toolstack(libxl) or QEMU(unplug request) set the state to Closing,
>       but also online to 0.
>=20
> What should the backend do in both case:
>     - frontend alive: backend should wait
>         frontend state might be InitWait, Initialised, Connected,
>         Closing.
>     - frontend not existing or disconnected: backend can skip waiting
>       and go to the next step, Closed.
>         frontend might be Initialising, Closed.
>         But there are also Unknown, Reconfiguring and Reconfigured which
>         are probably errors.
>=20
> So, the whitelist with Closed and Initialising is a good start, but what
> about the Unknown state? (QEMU doesn't have backends were the state
> Reconfigur* is possible, so they can be mapped to Unknown for now).

I guess we should consider Unknown (basically a missing xenstore state key)=
 to mean either an admin, or the frontend has screwed up or is malicious so=
 I think we just close down the backend straight away. So maybe listing Ini=
tWait, Initialised, Connected, and Closing as frontend states that are 'goo=
d' (i.e. we wait in anticipation of the frontend eventually getting to Clos=
ed) and then say all other states result in immediate close of the backend.=
 Probably worth having a helper function for saying whether a state is good=
 or not.

  Cheers,

    Paul

>=20
> Cheers,
>=20
> --
> Anthony PERARD

