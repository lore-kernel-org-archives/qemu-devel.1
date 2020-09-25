Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A70C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B200C238E2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B200C238E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrf4-0005Rf-MH
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLrVJ-0003ty-Q7; Fri, 25 Sep 2020 13:27:29 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:44025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLrVD-0007Gs-DF; Fri, 25 Sep 2020 13:27:29 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id C80EB58025D;
 Fri, 25 Sep 2020 13:27:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 25 Sep 2020 13:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=52B2XR8jUhZrvYyeAJcQPbs/GtC
 uwHJ/Jfwk3neNGM4=; b=EI3+zQ3hPzVKHZJir1A9w1c42Tz7wjEjJA5H1yovi7I
 hXzKZLgfFGgefn5T+ikA160sH/98Jjc9Lf0z2BUAYH4nnm60WDMi7qdLgvihIdkH
 bF4yXPvCqRDb/1pWE4AnH+z/vXtYmmVyDPFEcqyA51RxiIVrc9O4TU4aBt0cObM2
 lqEgJx0S4MyTQodx6LaQ8tdG246sCcW3CDbWH6UTknLUXjKNEfbdm9ecVsrQE38R
 ONnabxmedLQfHElwTJmb3CeqNKWWmLingXZ7dBpWrzczfKUtmtlOIXmVJsOKDy0j
 pR/jYG6l6PGhoinFkNPCOt5IVj1ME3gaq5g6T4Y0D/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=52B2XR
 8jUhZrvYyeAJcQPbs/GtCuwHJ/Jfwk3neNGM4=; b=JsYqROPeHCTuAEOVs5h9KU
 BVAe1dm93YjZZuufAbXIZvWMRoqcpHbxeYC1nA/6KtnZCYV9BsVVxRHcvZQBE7Sg
 MquLoJg2vinXBrc0nOiLvoyQRKGFEJGgpri0zDQYadiTMgy5DL8hTlu4h8sXlosO
 yHQGb85Qy67uqdb3Ao5jWHG83ML9Yk3hGHjOsxb8/Tj/F4bUOwByIHkPmBPofhsv
 I/Q73kO0LCxj7iKAssTJaPpCm83EsNgmc9DARSPGaVm+wiH6Jcd3S6BjEKOYUJyX
 vbl14tBv/uIO9e4im+q2DTK5JYcG0NLTp7YWQntPvLrcG15zXOTX3ggIh7xySN0A
 ==
X-ME-Sender: <xms:dyhuX8Gwq5jbp7oSXgZcMk2sgTS1fWg_dKCqk4BII2GLszJWHoquvQ>
 <xme:dyhuX1XEydl2rR2yDeyCsXFNRWg-pYPYLfrhGAvGUOAWlvCV2MvxMBmb9mSmUzkme
 tkKOfe8sPNSYYe80Z8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtgdduuddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:dyhuX2JOCa362jOnlDeU-S8VAXDQy31djfZCFLjafvilTijgDhYptQ>
 <xmx:dyhuX-HXnYzHL5jdV3-7r60jvRfp5vPOYBbLAKqDHpFlZkT_bgYb0Q>
 <xmx:dyhuXyXV2AzVQf4Xpvl4QzuF07Tf21Mo8PmCZazjGLT_hRWdaEqIfg>
 <xmx:eShuX0LI2j1Umq95Mjt1Qfcdqd6Y6vOfOQxDd0utHWVRRd_ylRstcg>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id C483D306467E;
 Fri, 25 Sep 2020 13:27:17 -0400 (EDT)
Date: Fri, 25 Sep 2020 19:27:15 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH 00/16] hw/block/nvme: zoned namespace command set
Message-ID: <20200925172715.GA1931129@apples.localdomain>
References: <20200924204516.1881843-1-its@irrelevant.dk>
 <MN2PR04MB5951D128DA6A5C9F6101C707E1360@MN2PR04MB5951.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <MN2PR04MB5951D128DA6A5C9F6101C707E1360@MN2PR04MB5951.namprd04.prod.outlook.com>
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 13:27:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 25 17:06, Dmitry Fomichev wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> >   * Standard blockdev-based approach to persistent state. The
> >=20
> >     implementation uses a plain blockdev associated with the nvme-ns
> >=20
> >     device for storing state persistently. This same 'pstate' blockdev
> >=20
> >     is also used for logical block allocation tracking.
> >=20
>=20
> Is persistent state mandatory or optional? Sorry for asking, but I am
> still catching up with your other patches. I think having it optional is
> a big benefit for performance testing.
>=20

Yes, the 'pstate' blockdev is optional.

> >=20
> >=20
> >   * Relies on automatic configuration of DLFEAT according to what the
> >=20
> >     underlying blockdev provides (i.e. BDRV_O_UNMAP for guaranteeing
> >=20
> >     zeroes on discarded blocks) for handling reads in the gaps between
> >=20
> >     write pointer, ZCAP and ZSZE. Issues discards for zone resets. This
> >=20
> >     removes the zero filling.
> >=20
>=20
> Doesn't this make non-zero fill patterns impossible? In many storage
> environments, vendors and admins are adamant about having varying
> fill patterns to see who caused the data corruption if there is one.
> Not sure how important this for the particular application, but WDC
> series provides the functionality to specify the fill pattern.
>=20

That *is* a good point.

By default I think it should default to either the 0x00 fill pattern (if
supported by the underlying blockdev), or "no fill pattern reported"
when 0x00's cannot be guaranteed. But, an option to enable filling with,
say 0xff, like you do in your series, would be nice.

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9uKHEACgkQTeGvMW1P
DelOEwgAw2/ppNuQrf/N8aCfykPSXnVNpT+irEf970SV0Z4LNXE6+hq2RHgka9x2
xskPC29qJjUn0SL7VYFIIzle+tggS+sg4AvLGYs9NsCyhOw+3rAeCjHp4W1qeco7
fC9UCXrnhncSUrjcLwuotHlHTPdE/Z23r2KMqHSr3MF0gth/SAupCLNAwKLyNt0Q
nPZYVNWzTCO994+3H2LwXSolGtv8UPGfHu/ooSF1jbSy3RGEp9EMbRWkijmDCnr1
2GpU7EL7myRamZczZC7rZ4thQnmQw2OCG+o2ZITdqD0W5kDAnU8tzgMVrafTzHqr
2XQHJIn33dtRaErSbBACqxojJr0ATA==
=Q3wL
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

