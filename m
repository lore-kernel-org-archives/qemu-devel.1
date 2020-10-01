Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E12C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1204820872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1204820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2Jf-0000pY-0r
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kO2EB-0006SN-RT; Thu, 01 Oct 2020 13:18:48 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kO2E9-0003FJ-Ko; Thu, 01 Oct 2020 13:18:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 7415B58035A;
 Thu,  1 Oct 2020 13:18:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 01 Oct 2020 13:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=Jp2+vLCWmnAla+aG26WiCiLnIOr
 tfypV9ShhOvjEb0c=; b=C2qAuqEVobZ8Rkd5xmUoSCz9/e3rEYtzHQXLtN079od
 c4mKN+n5KPMzEjDEaYlEytj7T6uyVNXiTM1fxSgi2fItimuM9XAO3FckyL5Zk73T
 1W5WL/qk+qGqiDl+yoTPP6fptXwxYg7kEyyAZJu3o/9tKEwJ/6tJQXob6+/GxWvE
 iHRLHm0Arg6JPfXysyvCsBtotrObMUrmVu4jaguXOAumVY6A/EDEzqhZ3wErgyFR
 ASfCOFLuqOkppLJ+7PU5eUs/V9YlHBR9iTjzBu3Zm6pEcvn2BxQLjQ41MRrrQ6nB
 8nTxfd1NnmJhJe+KRWzslQSmZhj5Bz2SXFpK2vJREDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Jp2+vL
 CWmnAla+aG26WiCiLnIOrtfypV9ShhOvjEb0c=; b=HIOW4T+jpJ8ABea9kXu7/w
 wiihTmEe4L4ESGjvWUqAMShTdb1nUyWkhQdGKw2ErDEQ5P7leqE4XA9mmpiyWvGY
 /O303iAX9dJ0B328bOhbdJe7Tl8wrGFXGyu2WWUsTBdP/tc/lhSJaYwsXanCf0Zk
 ysehrfXm12NxRvqb4PvisLB/t9mgN9xsZ5DRYgX6P+swV2e7BvG5T6JMREGeP+9t
 ntt9CqyHRLt/DcPszUxu2NxPAvZGSe/Bm6et5OdkyPW7FYI3kCZT0P0OTvrkl9Nm
 AFfWsGRAS9EHPEnVT0wf2XRN1WGNS+BQJbRjfVldw6KzcQItVKEdFwzQvmmDVyyw
 ==
X-ME-Sender: <xms:cg92XxARQ4penD3w5vhGp1UUnL2TwalA5SMIDio-rQ2d4g-pOVPHAw>
 <xme:cg92X_i_mAJsMfboOFU6qP_6RtyShC3ak1TBNLAn_1dfsEQv1VtY4xwDHmeYVLGBc
 tJ75D3ze84ZIJemeI8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggdduudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:cg92X8nkgleEyWu-7roJsKGxFWimnsR7r9Ozuna48bDKZ3rmvD-gBw>
 <xmx:cg92X7xrd1gno87sI1HRZFQc5jAFo1ioGzl-RFXY-Cw7B_W6baanUg>
 <xmx:cg92X2SLN4vLKfzxVtwMlCNlLd7FOcB9SVt8x05mzkk3BJQlIvzcvQ>
 <xmx:cw92XzLQG6GhwLLC9dfVM-A5N3yzqxJXvZrhQzzBOfc4VaXijYnBqA>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2642B3064688;
 Thu,  1 Oct 2020 13:18:39 -0400 (EDT)
Date: Thu, 1 Oct 2020 19:18:37 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/9] hw/block/nvme: support per-namespace smart log
Message-ID: <20201001171837.GA792691@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-4-kbusch@kernel.org>
 <20201001041057.GC681387@apples.localdomain>
 <20201001152055.GA3343@C02WT3WMHTD6>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20201001152055.GA3343@C02WT3WMHTD6>
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 13:18:43
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct  1 09:20, Keith Busch wrote:
> On Thu, Oct 01, 2020 at 06:10:57AM +0200, Klaus Jensen wrote:
> > On Sep 30 15:04, Keith Busch wrote:
> > > Let the user specify a specific namespace if they want to get access
> > > stats for a specific namespace.
> > >=20
> >=20
> > I don't think this makes sense for v1.3+.
> >=20
> > NVM Express v1.3d, Section 5.14.1.2: "There is no namespace specific
> > information defined in the SMART / Health log page in this revision of
> > the specification.  therefore the controller log page and namespace
> > specific log page contain identical information".
> >=20
> > I have no idea why the TWG decided this, but that's the way it is ;)
>=20
> I don't think they did that. The behavior you're referring to is specific=
 to
> controllers that operate a particular way: "If the log page is not suppor=
ted on
> a per namespace basis ...". They were trying to provide a spec compliant =
way
> for controllers to return a success status if you supplied a valid NSID w=
hen
> the controller doesn't support per-namespace smart data..
>=20
> The previous paragraph is more clear on this: "The controller may also su=
pport
> requesting the log page on a per namespace basis, as indicated by bit 0 o=
f the
> LPA field in the Identify Controller data structure".

OK, so I agree that it makes sense for it to be supported on a per
namespace basis, but I think the spec is just keeping the door open for
future namespace specific stuff in the log page - currently there is
none.

Figure 94 (the actual SMART log page) says that the Data Units
Read/Written are controller wide, so there really is no namespace
specific information. Maybe this could be in the context of shared
namespaces? How would a controller know how much data has been
read/written from it without asking the other controllers? What if a
controller is detached from the namespace - you'd lose those numbers.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl92D2kACgkQTeGvMW1P
DenZaAgAjAlzBcWB7GuDkZSWqAU6gSowqwJzV2Zr46L+2zRP+7L2qA7o4mPWRB/3
cLcDoBpbUcwLG9djZlBYu9t0MiVDNHs6rvboc4qeOdlWNtvvSYwZc6kyM34C43dS
zGpxOmJWGKSa/C5svk3GVGar4jQxEJMoIdwLbEV/MahoboYhDIRzS+N0y9C7Jk//
yYskd+1SaaaN5l73AnZGX9CoryK+BGKFvplAoX9wjzvJJ9hHrNUOPXENKYUsdJG1
RKgTsT/7ytajscpFuZ3G+7LpSxJ8hkqcYvIiXko0f6b3YWgiNU0wOQ4bkec4pGC1
4PgRXvpzGxFGdJbqWyoNmOSKdzEmMQ==
=xDdb
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

