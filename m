Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044BAC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0592145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0592145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDOL-0004ib-D6
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFDKi-0002NT-SB; Mon, 07 Sep 2020 05:21:04 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:60783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kFDKe-00030t-5G; Mon, 07 Sep 2020 05:21:04 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.west.internal (Postfix) with ESMTP id DD6485E8;
 Mon,  7 Sep 2020 05:20:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 07 Sep 2020 05:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=5s09mr/clJkvZJNs73Xl5XHy6tx
 rVThIZjdFlcaKkQ0=; b=BmBxeqDR6VbG5k7G1F2rxcgUip9kQVYP/B4qMFti9vK
 jkGvetloDg9Jw150+Neb30vCFZtYVVKJkG1FUaYkHZkgMx4/iJJafCKskiomK5gl
 li+s/q/GADcGzi/6MHdKmtVny3YRhnFfMi8lfRNN5DIc2ZdHgDa4cQT4k7xRm6IM
 HYjk9tGh7D4IB1UmM4qMCPLT6USn39ciKmWKB5kDsOhEsZV8HsFbIH40o3cvJboK
 zXW9vq71hFLWL9Xs+L0jQKtcR1pUZ97HqTCzHy/Ghoqx4y6fFVdOuxRRFRrAcZeH
 /7XStalIOQyryRql5mPMm/MNTIYD3tXLkq2PRTwsjcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5s09mr
 /clJkvZJNs73Xl5XHy6txrVThIZjdFlcaKkQ0=; b=SCYyxbH0RwQwgxHADA+zac
 dhSrBoMhaHEh5g9AQKTCm22yHr0Th+W2WR3ePimU1693fVcBfr2H3l2NwrfOPc6H
 FVxEBxaVHIg2irKvzOi7xd4vy0z50ZtbL+dyeNU5EfW8GjlpFX8XN7BsbuOQ53wI
 6cENeQZkdOcfdAbCWUGLnu3fnloDlSCoJWNkP8f9ybtc16xFuX/U2ThRwkHMKIFk
 Ph2vhca3eQCVT6e0WN5tpPXDzzGod3VGnDabql6Lx3tPKDUkNEIzyACxyI5cV7i/
 spIEaOXVb4AnkBB25lwuS3z0lL4obvyAQnvxmmPjLGWYRpSgIKJE2S+PG4LwkHww
 ==
X-ME-Sender: <xms:d_tVX-s_jMGDsNl0nv_cgWZ-qJpisVpyD6ppcTjJiy7DKz8Uc-Wavg>
 <xme:d_tVXzd1vmipm-QfssKqXbqx7Tbra44Daag6fOpjtA0ZASl-hCfXimhSqBCGPiKK1
 9htaUxUtaqbtwx7Pow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehtddgudehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:d_tVX5yqe261mMmxUC2rcHFZpvQIU1HdrbETpnJ2fBvgHeDovMvvZA>
 <xmx:d_tVX5M4o_reZgeMrZ4ECy2tu1832MihXn37ILAtWaA3593EYCZ7qQ>
 <xmx:d_tVX-_sGjpfBgGVoa6gOqKy8gPDTmpASbpDqpFWLHYBFVd-jWbWKg>
 <xmx:ePtVXyRyGgtK2-Ct3jHvilX6wVgmvvafKOAdYE5l-ihRnrt_Gt1joM2yExiT0VD-GBriUg>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id DD9EC3064680;
 Mon,  7 Sep 2020 05:20:53 -0400 (EDT)
Date: Mon, 7 Sep 2020 11:20:52 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 17/17] hw/block/nvme: change controller pci id
Message-ID: <20200907092052.GA706837@apples.localdomain>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-18-its@irrelevant.dk>
 <894711e0-7823-5cf0-5b5a-a84f15b458ce@redhat.com>
 <20200907072332.GA690013@apples.localdomain>
 <8651d3fa-becf-7b86-8c16-bbfb8926cec7@redhat.com>
 <20200907085814.GA698329@apples.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20200907085814.GA698329@apples.localdomain>
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:23:39
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  7 10:58, Klaus Jensen wrote:
> On Sep  7 10:36, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 9/7/20 9:23 AM, Klaus Jensen wrote:
> > > On Sep  7 04:28, Philippe Mathieu-Daud=C3=A9 wrote:
> > >> +David in case
> > >>
> > >> On 9/4/20 4:19 PM, Klaus Jensen wrote:
> > >>> From: Klaus Jensen <k.jensen@samsung.com>
> > >>>
> > >>> There are two reasons for changing this:
> > >>>
> > >>>   1. The nvme device currently uses an internal Intel device id.
> > >>>
> > >>>   2. Since commits "nvme: fix write zeroes offset and count" and "n=
vme:
> > >>>      support multiple namespaces" the controller device no longer h=
as
> > >>>      the quirks that the Linux kernel think it has.
> > >>>
> > >>>      As the quirks are applied based on pci vendor and device id, c=
hange
> > >>>      them to get rid of the quirks.
> > >>>
> > >>> To keep backward compatibility, add a new 'x-use-intel-id' paramete=
r to
> > >>> the nvme device to force use of the Intel vendor and device id. Thi=
s is
> > >>> off by default but add a compat property to set this for 5.1 machin=
es
> > >>> and older.
> > >>
> > >> So now what happens if you start a 5.1 machine with a recent kernel?
> > >> Simply the kernel will use unnecessary quirks, or are there more
> > >> changes in behavior?
> > >>
> > >=20
> > > Yes, the kernel will then just apply unneccesary quirks, these are:
> > >=20
> > >   1. NVME_QUIRK_IDENTIFY_CNS which says that the device does not supp=
ort
> > >      anything else than values 0x0 and 0x1 for CNS (Identify Namespac=
e and
> > >      Identify Namespace). With multiple namespace support, this just
> > >      means that the kernel will "scan" namespaces instead of using
> > >      "Active Namespace ID list" (CNS 0x2).
> > >=20
> > >   2. NVME_QUIRK_DISABLE_WRITE_ZEROES. The nvme device started out wit=
h a
> > >      broken Write Zeroes implementation which has since been fixed in
> > >      commit 9d6459d21a6e ("nvme: fix write zeroes offset and count").
> >=20
> > OK thanks. Can you amend that information in the commit
> > description please?
> >=20
>=20
> Yes, absolutely.

By the way. Is it correct use of an 'x-' parameter here - since it is
something that we might remove in the future? I was unable to find any
documentation on the purpose of the 'x-' prefix, but I was guessing it
was for stuff like this.

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9V+3EACgkQTeGvMW1P
DemZlQf+ORzh6BABnfg8BiayCkHuexD0tv6k5u6cICBaQGS2CDWAQ6L2DgXDpQ8l
giSs4oSqBOnY2dXiyyDC1a2a+Qn3p6ym+2p+aS0umtbmZEgqYnBLldcQKTySfPZd
tH8gqhSi7PNHhhpJLxecc6/BTAh9R7s5NYr4QxkNPOwLquOD68elLLyneG7CMOak
ZAOuxoATH6F2wH758a4SmNd6QWCVC71kWY1rxKT72a1u2VZKQ8EMAZ6lIENaUjZ0
0KTmg083co8KYJI4YIIYRBKhag4fjLjMBt3l40zw+oSNf6K1ZdZOC/J+hnjwmD4h
7Miajcxl+xrpGXdpr+Pi9+avBLhXXA==
=98dv
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

