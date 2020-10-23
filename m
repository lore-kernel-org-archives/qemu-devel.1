Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E31C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5CA2192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5CA2192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVqYz-0000xb-7f
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 02:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVqUv-0000Dx-L1; Fri, 23 Oct 2020 02:24:21 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVqUt-0004Zs-PA; Fri, 23 Oct 2020 02:24:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 452745C00FE;
 Fri, 23 Oct 2020 02:24:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 23 Oct 2020 02:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=dmEPFgjWvZxhwXnsdWxO2Er6ecl
 mDB2Jf3m785ZL6Ac=; b=GdkVgb7APw7lZ8Yct7urORc/2XIb5SilTnUVCjv9izI
 9QSee81EvIHRtTh7icrchLInlOdHgmjFhoxl+rKNiFDFKVVDMFQZdA9QOf7XKyL0
 G0q7EXwhCvAsON1mfB0wMlAyyiIBvVL0XFnEPvgQJKLWdrFrlDKOn8bHFd593yDF
 HAJSnVa1ywreibWPVJxQLmR+YRQsunDDPa5cEg+9jANWPsNee2qEvZke7LYbb9kk
 MRpRbJa0fICcyK56vrC4lGToKOJ3+Lz+HxfuUxu8EdnOj7qZNYARVYH69nlxangh
 fy9WRdYFqnKQRRWGXlNBby9w784QXwsVaf/PjWVUuww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dmEPFg
 jWvZxhwXnsdWxO2Er6eclmDB2Jf3m785ZL6Ac=; b=oc/nVAeQCzkDK4WZ7VUDmK
 pyiaCSu6LVY5k/UYlGjjSgtkkofNNz9QVXdIKTscEUjfg2A+2q/YeaAEhgqlLgAO
 crct2vdIMZ2ctJ2GaJbrqHCfsBjhvBcgpBuj/7wo6o0AECcaGbWCxE83BlG60MwM
 LrphX3zZ8KTv8u8g/wkLac9Y3Vdm/ZsiC1TnWPvYI2svUsi5Ob3esLW4stHFYpR5
 6iUWtVL0gTguDoB5TzC5OhQ8oaRvbhAM3yVC+Wb2AnM0e9oZFBPJTf22GbqwNIaL
 SYrnC8N7eu4y76az6gz8tybx0mz9jKgnHwVpsOSzXKSkfwpB7g6hoHXg2fcvDyTA
 ==
X-ME-Sender: <xms:EXeSX1FQABAPhpmXzY7XO4jUf-tpAqCpD6q3xLLFePn_w8ZeNyGVSQ>
 <xme:EXeSX6UU7ajiqxsmU9tCl3dPrB5dAgvQUZzWbMD2zeWVgMr7KOHs5UeMeLLXhqrrt
 Fg69YxeJhTlPCL950o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeelgddutdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:EXeSX3Jg-gIIxp2vqEsOKJp_ZD0xXVm1tqwtG0EkhPQ92p4snJH9BQ>
 <xmx:EXeSX7HoPEFKUIjp4-u_YEtCYBjy45KEpd4xFh3Kdc5g3reU0u5PoA>
 <xmx:EXeSX7Xdbb2LcxYmjAepSPNir62N81JhhNPOcU5RZhmnEU_sMM9y-g>
 <xmx:EneSXxfLB5IB_BIHNjazf3hTy45bfVocEKDfGXXxxsO5fC435WDKoQ>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id D6DCC328005D;
 Fri, 23 Oct 2020 02:24:15 -0400 (EDT)
Date: Fri, 23 Oct 2020 08:24:14 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 2/2] hw/block/nvme: add the dataset management command
Message-ID: <20201023062414.GB244769@apples.localdomain>
References: <20201022184959.240505-1-its@irrelevant.dk>
 <20201022184959.240505-3-its@irrelevant.dk>
 <05c41ab7-039f-f327-c6a0-5864430f5ba6@redhat.com>
 <20201023052512.GA244769@apples.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20201023052512.GA244769@apples.localdomain>
Received-SPF: pass client-ip=66.111.4.28; envelope-from=its@irrelevant.dk;
 helo=out4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:25:16
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 23 07:25, Klaus Jensen wrote:
> On Oct 22 23:02, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 10/22/20 8:49 PM, Klaus Jensen wrote:
> > > -    /* support DULBE */
> > > -    id_ns->nsfeat |=3D 0x4;
> > > +    /* support DULBE and I/O optimization fields */
> > > +    id_ns->nsfeat |=3D (0x4 | 0x10);
> >=20
> > The comment helps, but isn't needed if you use explicit definitions
> > for these flags. You already introduced the NVME_ID_NS_NSFEAT_DULBE
> > and NVME_ID_NS_FLBAS_EXTENDED but they are restricted to extract bits.
> > This is why I personally prefer the registerfields API (see
> > "hw/registerfields.h").
> >=20
>=20
> I've been wanting to fix those constants - but the convention that they
> only extract bits pre-dates the nvme device and is from when the nvme
> block driver was introduced - I have just been following the precedence
> by defining them like that.
>=20

I did not know about the hw/registerfields.h API. Looks promising!

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+SdwsACgkQTeGvMW1P
Delpswf+KYL3bZzBdoW8LfNhCn/yOE+YnrzphIEbCfSD/l9U096XHjNt52oSiGgG
rfQMAOZ9x7eo8xKfMljWxT+Itx3+WhqXMUS7+GR6AK+qT7HsQdBLjILx/iEQN/+F
1igWF3XPiCiAJZKaDYtEadVIi9IiRaJWoeN9cCwgiyPwZzVzXy8KJWIN0HVRLLrt
5CAsuzyb4BAbIy7t46aF2FStW6HP8L+fQWDg5Kkbyt1vGWgF1zKLt16hj4EXpY0o
eOz7fMHBdIsgle20urRZ7nvFSzCkxUgAug6cu4mHUq20lFZ++kRVPQO5dF2ANlDX
geZvg/Pdb7daMWnsqAQWCEA3RgcOBw==
=qbzu
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--

