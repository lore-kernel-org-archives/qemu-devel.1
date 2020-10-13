Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB164C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 18:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81809208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 18:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81809208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSPEK-00072q-Ra
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 14:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSPA7-0005wx-Lu; Tue, 13 Oct 2020 14:36:39 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:47717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSPA4-0001nF-Vy; Tue, 13 Oct 2020 14:36:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id EEADD866;
 Tue, 13 Oct 2020 14:36:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 13 Oct 2020 14:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=T1qSasKgCj06jDZ9OW937SJ8QVT
 qWeKUSpbr0iYnz2I=; b=siiOsgfcuB2z+WwWloa92W41XIUFuC820pfiQPB+LX5
 kKNjNF/1P5tX0p8EGJLXyWSTDhxXfpYG/2nGGl0GDSmTXWKKckTwXACwQKsD8reP
 19qEy7CgQ4v6ry5YMTUU+bN0iKohQ1Dc3lkHcFl5q11HwwfmqUd0jg3K6/wr9Mjz
 q58CUdMgJEFVNIF75vMfROSBbfR0PgMpEbzQsZC6BugZWrAiWKuT7VB4BCoYvOuS
 rnb6CVkw7fDM4x/ZhF10H/m1i+1zt6TXm1XAdtC62SQXdNOO/t5C8rkTo6Bu4/nt
 2oUzh72+y84TzJoRDATvwiT/Ly4BNwvFgvhHLnhOv2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=T1qSas
 KgCj06jDZ9OW937SJ8QVTqWeKUSpbr0iYnz2I=; b=XRao58v7wusffsQfCy2cF+
 4CnQXm1d0ckW0sFdQJj9+HiAypUqW30x3KapiHVC7xzR6DqAPDUYx5iHhnQMh0lb
 pxN2k+ru599XUS+JZ3hm5nfh/EEhY7wTkPL8sSqGX4Z8LLDW1MjrGflAFZo7RWHO
 DurKnmhk/MEuY0KHNv5JuoOh6brQRJ28147FEDk6D5NmUVCGTH/ZDpGxZoS3AhGc
 FGomlkVCw+3KAD88FTdkBic2khKD5S+k9TqLcuD2zcbGwOKkheQDaAi0PNttb0QV
 cYz3/1NeEu5/RKgfnAwphMsFIzK0SlVIMQdcxYIGaG75iFIv480Wh+Axm9ICgEIQ
 ==
X-ME-Sender: <xms:r_OFX1lRSDQq_3TN4Dm1qPBzVJzBFfsEngID0PLD1cwTk7Gg7dPrfg>
 <xme:r_OFXw214q83AUu8a3AMwURhdrgx7XKr2Ub02cxLtSAPoOuCAGlvOT7V2M2AVa-du
 P1YFICCs4jj1JuHIvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheelgdduvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpedutdehleelvdetvdefueehgeevhfejueeliefhudfhiefffffhuddtkeekieek
 feenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucfkphepkedtrdduieejrd
 elkedrudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:r_OFX7ocjbf14I5kADIRyer45JXlwdP18Av6uNzpCsfzIuWhj8R2tg>
 <xmx:r_OFX1nDP_ujd8SA90dc-0WWcsmkXNcJm-_8hynct7WBjw7ctXaU7g>
 <xmx:r_OFXz3n98MyTm2CIsbcqmHmmPcEvrsY4HYlY0mxeECDiCS1BauAJA>
 <xmx:sPOFXz8l_BKh9dmG1xGciz9V6HYEnhmT-TszU1i9N1Rl-iiMAWf7sQOeQ1c>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B2CC63064684;
 Tue, 13 Oct 2020 14:36:30 -0400 (EDT)
Date: Tue, 13 Oct 2020 20:36:28 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/9] nvme qemu cleanups and fixes
Message-ID: <20201013183628.GA204217@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20201013090401.GC168093@apples.localdomain>
 <20201013174826.GA1049145@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20201013174826.GA1049145@dhcp-10-100-145-180.wdl.wdc.com>
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 14:36:35
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 13 10:48, Keith Busch wrote:
> On Tue, Oct 13, 2020 at 11:04:01AM +0200, Klaus Jensen wrote:
> > On Sep 30 15:04, Keith Busch wrote:
> > > After going through the zns enabling, I notice the controller enabling
> > > is not correct. Then I just continued maked more stuff. The series, I
> > > think, contains some of the less controversial patches from the two
> > > conflicting zns series, preceeded by some cleanups and fixes from me.
> > >=20
> > > If this is all fine, I took the liberty of porting the zns enabling to
> > > it and made a public branch for consideration here:
> > >=20
> > >  http://git.infradead.org/qemu-nvme.git/shortlog/refs/heads/kb-zns=20
> > >=20
> > > Dmitry Fomichev (1):
> > >   hw/block/nvme: report actual LBA data shift in LBAF
> > >=20
> > > Keith Busch (5):
> > >   hw/block/nvme: remove pointless rw indirection
> > >   hw/block/nvme: fix log page offset check
> > >   hw/block/nvme: support per-namespace smart log
> > >   hw/block/nvme: validate command set selected
> > >   hw/block/nvme: support for admin-only command set
> > >=20
> > > Klaus Jensen (3):
> > >   hw/block/nvme: reject io commands if only admin command set selected
> > >   hw/block/nvme: add nsid to get/setfeat trace events
> > >   hw/block/nvme: add trace event for requests with non-zero status co=
de
> > >=20
> > >  hw/block/nvme-ns.c    |   5 ++
> > >  hw/block/nvme.c       | 194 ++++++++++++++++++++--------------------=
--
> > >  hw/block/trace-events |   6 +-
> > >  include/block/nvme.h  |  11 +++
> > >  4 files changed, 114 insertions(+), 102 deletions(-)
> > >=20
> > > --=20
> > > 2.24.1
> > >=20
> > >=20
> >=20
> > These fixes all look good to me apart from the odd fixes that has been
> > mentioned in the reviews. Since soft freeze is only two weeks away (Oct
> > 27th), it would be nice to get this staged on nvme-next so we can get a
> > pull sent off to Peter.
>=20
> I've fixed up the comments mentioned and added the received reviews.
> Since it was pretty trivial fixups and passes my basic santify tests, I
> went ahead and pushed to nvme-next.
>=20

Looks good, thanks!

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+F86oACgkQTeGvMW1P
DemCUwgAkMGgxVkmkdJ3aMJkorzaXsWHvoIg6De/nt/0zO+wqKT+NGfJg2C4o7b5
TkJBLcCHTYcxnDJiN4nsVia5ZrA1dHgv+4SS4mWJ0orhNPKGevW0lAE9qgrNfT3J
Hz81IIbeT8eOrdusXQhyOROujlToIcG20JgX/2G1sAL26H47g2RrpFx8/OrJDVr0
fK0vAAW80kPcTLNdQKC4Dutgt3fuqenAYiUA0QIcW+mvlxsNnfJ4rXzvkrLBbGa6
K8PwZO0uBMEieRMtevHwhJmWWhldzQ2B5FfEEi6tMt8ti1w13AGN2hDMctJj2f7O
AH8UgWrSzMVM+0OkjDBiFRwMDzTuuA==
=zwSt
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

