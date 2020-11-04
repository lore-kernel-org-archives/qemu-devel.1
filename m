Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8381DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321FB22206
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321FB22206
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFXd-0000gP-1e
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 04:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaFTN-0008Af-Le; Wed, 04 Nov 2020 04:52:57 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaFTI-0006BN-83; Wed, 04 Nov 2020 04:52:57 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 9EC9D10C7;
 Wed,  4 Nov 2020 04:52:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 04 Nov 2020 04:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=X8atgD/uMb+jgMSqV5vGtBM4mGz
 x6MXR+57P1ud1c+Q=; b=KM19eSFPQaN08SB7z69WVmI9oIw/Ra2lYmcAsAkwtLw
 TotjH5XDrkuQlX82ONBB7peGRInj7I/iurBhGgQ37tlcM/XK9CMrwQ2xpIVBroOr
 1gzTxaSi+YMmqFQkJjk3WVtUyG8AUGZ4GQWxJUWrL6TuaSoPgXrWe+BioUMCixBJ
 OZgWaHifaTKZdH2RpGKLkM4QVtTzXbeTgkrtxhL8JI59Oh/SfthsufPhYxz5gx0h
 vdYTNajPsFWffC6B9UL/7k9jePq0K8JhjxHZ7CFehdxxUmpHefd0+QD0hYNaHDUE
 JvtGXKpCiCy847VFrqZACvijknnPSksmoPIR2rTBhDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=X8atgD
 /uMb+jgMSqV5vGtBM4mGzx6MXR+57P1ud1c+Q=; b=hDeP2RnFMyKoDgBhlG9nIx
 19gtkNW1ocPiajQup5GaZLNvNTtMscoSOMj7KOVkP3D+9t23GAizfqbrYHcX9SF/
 wTuVmM2asJLMs/HkgDVj/BMUjJXRBm0yfFS+E/+xspuWGyitxZftCzJfFjVLzLT4
 gKhJzi2Xk5/p1huoFcTgebF2dE0Pf3qE/dn6fvfZmWbCAekkF+qsv1ahAPD93ry7
 +UMPEfTZfgbH8aLHHlTL58q08LGxCJ+XS2LKsCTitWFB41eyteJya3ZKDWF5wZ3t
 UIKY6lWyqosx2hVcMgDoQGLc4vhnhoZP/xhf2IzVberI4jB/hcQ8rlrtl4Bo8ldQ
 ==
X-ME-Sender: <xms:73miX8XzUTuQH9Gi6s8w8uHTVQuo_hk2ALcz7nzvCDwDsncnASM0IA>
 <xme:73miXwnlebpjn_Bhtoo9sYVNuDo-R-ZAQ3B69Clu4fxULDUJDX40BkLRMVp5kxGNF
 WyVrzD7gDONKgOO1Oo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedguddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:73miXwbzWNP6EDzb5olVmY98YjlHQU1G5Dhgf-amdeGQofE00eMUJQ>
 <xmx:73miX7VJoml88ZRavTqUzyJX7CSQ7QRVGKD1HZUVV5czlhoCBOgqcQ>
 <xmx:73miX2nEce3mQSqe7zoxoAX56MPEXTio3PvST-sC7osFnqQbrkY2pA>
 <xmx:8HmiX9ucIsWflJHjcgDiP5L0P7M0X472LaQ516Bk5JH__fX9RW-M-A>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 392373064686;
 Wed,  4 Nov 2020 04:52:46 -0500 (EST)
Date: Wed, 4 Nov 2020 10:52:44 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PULL 18/30] hw/block/nvme: update nsid when registered
Message-ID: <20201104095244.GA13336@apples.localdomain>
References: <20201027104932.558087-1-its@irrelevant.dk>
 <20201027104932.558087-19-its@irrelevant.dk>
 <eb0b8a08-d5c4-1bde-f278-58f0c3d0ef05@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <eb0b8a08-d5c4-1bde-f278-58f0c3d0ef05@redhat.com>
Received-SPF: pass client-ip=64.147.123.20; envelope-from=its@irrelevant.dk;
 helo=wout4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 04:52:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov  4 10:32, Max Reitz wrote:
> On 27.10.20 11:49, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > If the user does not specify an nsid parameter on the nvme-ns device,
> > nvme_register_namespace will find the first free namespace id and assign
> > that.
> >=20
> > This fix makes sure the assigned id is saved.
> >=20
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > ---
> >  hw/block/nvme.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 5768a6804f41..2225b944f935 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -2578,7 +2578,7 @@ int nvme_register_namespace(NvmeCtrl *n, NvmeName=
space *ns, Error **errp)
> >          for (int i =3D 1; i <=3D n->num_namespaces; i++) {
> >              NvmeNamespace *ns =3D nvme_ns(n, i);
> >              if (!ns) {
> > -                nsid =3D i;
> > +                nsid =3D ns->params.nsid =3D i;
>=20
> Coverity reports that @ns is NULL here.  I think the problem is that we
> want to access the *ns given to nvme_register_namespace() here, but it=E2=
=80=99s
> shadowed by another @ns in this for () loop.
>=20

Sure enough. Thanks!

I'll send a fix.

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+ieecACgkQTeGvMW1P
Dem89Qf/RE3fzy5ZXTWB2I/Po9toqQ6SwRPDocKZ7BiWgmEtvj562vyqMxByY+UE
oXVcpU08p17ZubwuznHPUFA+rRa+8fbCH2YImcNTbXRItBlcjpCI7svoMvZDZfx5
QD4cyat71T9UhirEAIggFTaisegm6ky625oAe37GZNsCZ8/vJ0goit/ddCVWjwSb
1ZYCRYcVL5wUhc+usOVdJAu47MibPWB5tMyBq77uZHkGtJlSVzuzCE2e/FmZIz2g
jz40P5KjXgFups6m210gPuHL7Y0XtbSf76mHkd1Q1epdkq6l4H+CkeAjFmeRJ9YE
XNId3NIrypOqN+Oj+XbmkQ5iJyENIA==
=C1PD
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

