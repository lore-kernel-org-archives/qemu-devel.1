Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3443C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BF82080C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BF82080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIH6l-0005Q9-9T
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 15:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kIH3X-00045g-BX; Tue, 15 Sep 2020 15:55:59 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:55299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kIH3T-0007ZO-Gl; Tue, 15 Sep 2020 15:55:59 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 3DC94580103;
 Tue, 15 Sep 2020 15:55:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 15 Sep 2020 15:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=qMo4dN99YdwSpV4KoHamz8OIjPf
 QjVHVa6X7s8tvk0I=; b=IKbca5b6T/o7PZjeNee96DJ6odvhRooXl11nMFZE5Zk
 M6VYjEdz/0RoIon2dM4OfClP+NedRaT5LclZwG2mNBNaf4aySemipCkmPnzj7yNW
 f4A0YgKxjYsm8zWLbeCrmxSg6pmzI+aEjxXh7YjyXDFIu7rx17sviKAOXjxsLm0f
 F0GjeSLxRqYUsv2wgpDMhrj9Wemyvz8k0gKINYw1sCsN8MOJ6HGcS8R5krVGah1c
 YgRohsUvFSODAGUECy16OT0QXLgUWqukPEGiWMYbuEfCrkm0Hj5vtLmvNiZILQNN
 BXgSk/7Z0IpG9PEs6odSUNFvAwVOkm1wrh4wU0Qhz+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qMo4dN
 99YdwSpV4KoHamz8OIjPfQjVHVa6X7s8tvk0I=; b=I5ynJeiiPt/v8xCcpxkrYt
 VhZM22SnzcTP9cFXxcznaUGy7YNqdswpl5IihPXPaBR71D3erSlX2NNDblBQzNjC
 DJy6izohyWXAvjmBP5x9xLcxBlK+rVADRwF3hdg5WHOu3ByN8kyqVPLxWjfpjwMy
 xB6IkQm7O2ReB6CG9tomwvY+dHfwR+BLW6wehPon5TeO3wQFxXtomSacuw1Ohgz4
 3PkUv5w5xUYD3X+ADPXfIQjt1TKri3G7hkCjJBUox7sUVtL5QIjHVyl/wowJ3DpK
 70o9ZcvstptvthG1hhuvFV0wcwXObkFj1YHAqiWY3asbSzq34n8VsT7QXlcsXyCQ
 ==
X-ME-Sender: <xms:RxxhX7YeW68-Ysfzta0uQjDNMyVZHLbv7eDLkU2SBAEHn0pTWGwFUA>
 <xme:RxxhX6azIfMblHqNqFIZB7KmxUdS63pd3Lvn6bmGMO1Uy3PEoy4eohyuoYv8DK5nA
 PJh3mrNZk-NMl5drNM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtddtgdduuddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:RxxhX9_5KFVu7NEl8-UoWTGOE1wtR7VmraqJgyiT751dJ4jWRAhcQQ>
 <xmx:RxxhXxoqaBP0z7_ynM2qa-WXadD8s05KUFNxqYZc6Gt4Gf0YL8B3xQ>
 <xmx:RxxhX2oNaXGyw2mffn_35qsSAYTQeims2oUAW12wyDwQDBE_bEJfpQ>
 <xmx:SBxhXzjONQK5WILdztvDZM4h9UFBJbRZf1H2btONCVnc2Ox7HFlfEsuVreg>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5F1B93064683;
 Tue, 15 Sep 2020 15:55:49 -0400 (EDT)
Date: Tue, 15 Sep 2020 21:55:46 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
Message-ID: <20200915195546.GA14485@apples.localdomain>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-2-dmitry.fomichev@wdc.com>
 <20200915073720.GB499689@apples.localdomain>
 <MN2PR04MB5951ED0FD5633E8144459A28E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <MN2PR04MB5951ED0FD5633E8144459A28E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
Received-SPF: pass client-ip=66.111.4.230; envelope-from=its@irrelevant.dk;
 helo=new4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 15:09:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 15 18:56, Dmitry Fomichev wrote:
> > -----Original Message-----
> > From: Klaus Jensen <its@irrelevant.dk>
> > Sent: Tuesday, September 15, 2020 3:37 AM
> > To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> > Cc: Keith Busch <kbusch@kernel.org>; Klaus Jensen
> > <k.jensen@samsung.com>; Kevin Wolf <kwolf@redhat.com>; Philippe
> > Mathieu-Daud=C3=A9 <philmd@redhat.com>; Maxim Levitsky
> > <mlevitsk@redhat.com>; Fam Zheng <fam@euphon.net>; Niklas Cassel
> > <Niklas.Cassel@wdc.com>; Damien Le Moal <Damien.LeMoal@wdc.com>;
> > qemu-block@nongnu.org; qemu-devel@nongnu.org; Alistair Francis
> > <Alistair.Francis@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>
> > Subject: Re: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
> >=20
> > On Sep 14 07:14, Dmitry Fomichev wrote:
> > > From: Ajay Joshi <ajay.joshi@wdc.com>
> > >
> > > A new write command, Zone Append, is added as a part of Zoned
> > > Namespace Command Set. Upon successful completion of this command,
> > > the controller returns the start LBA of the performed write operation
> > > in cqe.result field. Therefore, the maximum size of this variable
> > > needs to be changed from 32 to 64 bit, consuming the reserved 32 bit
> > > field that follows the result in CQE struct. Since the existing
> > > commands are expected to return a 32 bit LE value, two separate
> > > variables, result32 and result64, are now kept in a union.
> > >
> > > Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> > > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > > Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > I know that I R-b'ed this, but can this be moved to the namespace types
> > patch, since that is the TP that changes this.
>=20
> You probably meant the ZNS patch since result64 is first used there to re=
turn
> ZA starting data LBA. Sure, I can move this stuff to that patch.
>=20

No, I actually did mean the NST patch since TP 4056 is the TP that
"unreserves" dw1 in the CQE.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9hHD4ACgkQTeGvMW1P
Delo0wgArnVFiwUX/sEcjx5OPesVq+wwzBUUq7xiutsnel9NGQRO5m4vb6B+wGU3
R6czLMJGKo/4c2BoDznv3bXbXF2P6OkWjWDqA4AQRr+6cV0s1V01Eah/D394FWjL
Q1jY4Q7A8E7s+6qJ/PkENKboMJI1kfFtaKU15Gpsv7iZnbLkABnJAcydzp2xKmLe
GGhTWit4jeHwh0+/QQAvm90Fl7A8BzQEza56k/rlYUjNCCf32qeFfjQgN4Boir0+
DHvAc0k8ibO4yy1N3NBZi3L+k4spDCepEX1BCV7I4Pa+Bxd9rlVQmMqF2MJaWJfD
RKLcdnYKEpksA0LBWvBe2OSRctuYbA==
=ENfG
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

