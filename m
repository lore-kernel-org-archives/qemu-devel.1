Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9062C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35F122DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="OJRKGPET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35F122DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46499 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0N3n-00028B-Ty
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i0N2t-0000z0-Ia
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i0N2s-0000kr-1U
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:36:47 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:32502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i0N2r-0000jh-NF; Wed, 21 Aug 2019 05:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566380205;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3Za6ueqMEMQTxZh0sc8rkXJ3d1mePjvqKfEBaHh/BYI=;
 b=OJRKGPETjijdm9hCbc+niGQ1xwm/5x73IPMSpq01HBDxirov3sgnkPkO
 itYF4PAh6RGNHT71C2B25WUH0FhmEYVCqsqcExtNSWiGSi5902si18Ije
 JVHwgksQVMzcN6yluuKlPup5gppWTdhCBL1LkJHZSE6ORTNpRLcb5UYZj w=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: H4woLz1aaVwkUFz3ySjTVybCT/MF1ugMwBpbyhDR8GWccbm3UjbGVa6vw2aU22bP0l8ORL29wC
 imKHNnqwblbsG1WTbopwGBhv94Kh9OjjjAcU2BC+nXUCTvXQnlcfTXLfSEOZJfB24Zcxmio6OB
 WP3dZP5p9m27xgjIlfeBgXLtruLt/JdM2DkYu1lmkY0aXrSCYoPnOjzU0c9EDICAZkAKpZtBqG
 vxxRQ25800iTQpB5vUZr/l8FXzE/Jr0SgwMlDiqP/HE2ZHTLTk0LNu2cr8Gcb2kx6TyLq9+hVG
 52k=
X-SBRS: 2.7
X-MesageID: 4765255
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,412,1559534400"; 
   d="scan'208";a="4765255"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 1/2] xen-bus: Fix backend state transition on device reset
Thread-Index: AQHVWAGpRkr1DBFa80ag1hnV7DDUQKcFVfWw
Date: Wed, 21 Aug 2019 09:36:40 +0000
Message-ID: <b3a6a2e0022c4785a4a04a809d948cef@AMSPEX02CL03.citrite.net>
References: <20190821092020.17952-1-anthony.perard@citrix.com>
 <20190821092020.17952-2-anthony.perard@citrix.com>
In-Reply-To: <20190821092020.17952-2-anthony.perard@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 21 August 2019 10:20
> To: qemu-devel@nongnu.org
> Cc: Anthony Perard <anthony.perard@citrix.com>; qemu-stable@nongnu.org; S=
tefano Stabellini
> <sstabellini@kernel.org>; Paul Durrant <Paul.Durrant@citrix.com>; xen-dev=
el@lists.xenproject.org
> Subject: [PATCH 1/2] xen-bus: Fix backend state transition on device rese=
t
>=20
> When a frontend want to reset its state and the backend one, it start
> with setting "Closing", then wait for the backend (QEMU) to do the same.
>=20
> But when QEMU is setting "Closing" to its state, it trigger an event
> (xenstore watch) that re-execute xen_device_backend_changed() and set
> the backend state to "Closed". QEMU should wait for the frontend to
> set "Closed" before doing the same.
>=20
> Before setting "Closed" to the backend_state, we are also going to
> check if the frontend was responsible for the transition to "Closing".
>=20
> Fixes: b6af8926fb858c4f1426e5acb2cfc1f0580ec98a
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
> Cc: qemu-stable@nongnu.org
> ---
>  hw/xen/xen-bus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index e40500242d..982eca4533 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -540,9 +540,11 @@ static void xen_device_backend_changed(void *opaque)
>      /*
>       * If the toolstack (or unplug request callback) has set the backend
>       * state to Closing, but there is no active frontend (i.e. the
> -     * state is not Connected) then set the backend state to Closed.
> +     * state is not Connected or Closing) then set the backend state
> +     * to Closed.
>       */
>      if (xendev->backend_state =3D=3D XenbusStateClosing &&
> +        xendev->frontend_state !=3D XenbusStateClosing &&
>          xendev->frontend_state !=3D XenbusStateConnected) {
>          xen_device_backend_set_state(xendev, XenbusStateClosed);

Actually, I wonder whether it is better to 'whitelist' here? AFAIK the only=
 valid frontend states whether the backend should set itself 'closed' are '=
closed' (i.e. the frontend is finished) and 'initialising' (the frontend wa=
s never there).

  Paul

>      }
> --
> Anthony PERARD


