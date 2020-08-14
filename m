Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E016C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 04:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE1120715
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 04:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="U1PrdEc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE1120715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6QvA-0003IZ-Dz
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 00:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6Qtj-0002Iv-EA; Fri, 14 Aug 2020 00:00:55 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37967 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6Qte-0001Q3-F3; Fri, 14 Aug 2020 00:00:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BSV8k6FJRz9sTM; Fri, 14 Aug 2020 14:00:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597377638;
 bh=w2a3RFaM9lxNUEeSiyViZU2OxGfGgLhhsTqAUEXwRFE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U1PrdEc/PzZwwIBkhsjNGgDTxdyVV3x7i3mARymp5WT6bEkolHJ7DCi99lTm1IW+4
 ZlEgpsHUBm7iJ0dLljYm80F8LdIsMLvXv3c98PvLf9HtR5f6SZRu2PgfKH44NOfq6G
 slT4BlSYYRnvE0Bq94mq/fP0A6p05f7Dzt/lC8hA=
Date: Fri, 14 Aug 2020 13:32:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 01/14] spapr: Simplify error handling in
 spapr_phb_realize()
Message-ID: <20200814033216.GB12805@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707843851.1489912.6108405733810934642.stgit@bahia.lan>
 <2c8847d7-0f87-4fb1-8551-2e4fdb8f2708@gmail.com>
 <20200813233927.52e38400@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <20200813233927.52e38400@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2020 at 11:39:27PM +0200, Greg Kurz wrote:
> On Thu, 13 Aug 2020 16:57:04 -0300
> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
>=20
> > Greg,
> >=20
> > This patch is breaking guest startup in ppc-for-5.2 for me. The process
> > gives an almost instant segfault. Here's what I'm doing:
> >=20
>=20
> Ok, this is because this patch should have been applied after
> the "spapr: Cleanups for XIVE" series:
>=20
> http://patchwork.ozlabs.org/project/qemu-devel/cover/159679991916.876294.=
8967140647442842745.stgit@bahia.lan/
>=20
> specifically this patch:
>=20
> http://patchwork.ozlabs.org/project/qemu-devel/patch/159679993438.876294.=
7285654331498605426.stgit@bahia.lan/
>=20
> which prevents of a bogus error path in kvmppc_xive_source_reset_one() to
> be taken:

Oops, yeah,  I realized this halfway through and fixed it up, but
forgot to push out the updated version.

>=20
> /* The KVM XIVE device is not in use */
> if (xive->fd =3D=3D -1) {
>     return -ENODEV; <=3D=3D this should return 0 to avoid the segfault, b=
ut
>                         the real issue is that kvmppc_xive_*() calls
>                         shouldn't be called at all when we don't have
>                         a KVM XIVE device. This is the purpose of the
>                         "spapr: Cleanups for XIVE" series.
> }
>=20
> I should maybe have added some Based-on: tag to make it clearer...

That would have helped, yes.

>=20
> David,
>=20
> Can you apply the series the other way around ?
>=20
> First :
>=20
> "spapr: Cleanups for XIVE"
>=20
> http://patchwork.ozlabs.org/project/qemu-devel/cover/159679991916.876294.=
8967140647442842745.stgit@bahia.lan/
>=20
> Then :
>=20
> "ppc/spapr: Error handling fixes and cleanups"
>=20
> http://patchwork.ozlabs.org/project/qemu-devel/cover/159707843034.1489912=
=2E1082061742626355958.stgit@bahia.lan/
>=20
> Sorry everyone for the inconvenience.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl82Bb4ACgkQbDjKyiDZ
s5IZeA/+Pg5YZbYS7ec3L0uSnDDMMQ/d49+fPiit5VMWxmaLOiPYXvYYmJzXnGXE
XjFXDcV7WV+JGDF1J5PSoo1Wf7I/I1O4vrVm4raKwmV6ELL0zVp1rzpjaUHPwc6+
PPA31BRe3Q5T+mjUYEG2lA6cQNZwffec/YFveAkmNS0RDpt4E4y9xcp0lq2h5wGW
8bdfcZ2f1p1+Db9nfRIMNWqpIsR1aRcnVR6ClescnUA2CKzVSKaf5oNMHUgSi0QQ
sbPlb2TDSrXza8duWEVACsF99vj5qNNrmOmUWBVhFwnhiLlshlI1xydZhLcTRsFp
UTNJKa/2ol9gDhhwb2/52k8TlRHJjcnPlaAr5BgK9A8xhT9j5j8fKlDmpB266BJh
o/01KBLmjBs8YzfjdboSdw/z4Vvxb/zHRWtFpoQLXOMgnm8jWHs8qVaXlITU556o
AdL/EMHJ//yrYlt/GuDyHbrQF5wte3lw3jPOpBlSt0NNsHRIfk+RfF0kZAhM5Kgo
RHdWWGpTpLVXZ58dbfhSbP+abvZ11a6YNq+SGx5k2ObdHhdfpnB+a1OxqGXU3Rkm
QB7QZv4+y/S8T4FWNE0J57YH5AKrgIE4ifhVc8NZKTdJ/DCGPsbOe+3xOZytWgoF
SfCOBqhEvtH9T8djj5OtHCK49LJdGlcuLvjXJuI+WkIH/NBzN6I=
=eU61
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--

