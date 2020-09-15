Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B249C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEA020771
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEA020771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIHwV-000404-OJ
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 16:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kIHsl-0001JI-Va; Tue, 15 Sep 2020 16:48:56 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kIHsk-0005wx-6i; Tue, 15 Sep 2020 16:48:55 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 604435803CF;
 Tue, 15 Sep 2020 16:48:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 15 Sep 2020 16:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=w3K7ZpDE328VF7rO7sRSvqFXSJu
 xyQoubQ8Yde+b2ek=; b=qDoHThbQjngcZPm/20MhSYP6qTnDe8dQ22L8TuxNlzZ
 ugDRQ/mx654v2cnxPKJTcpoQGrhTU+t9F1tGOofqmwfULzg7ELiaNz3zgVsPyJM3
 k5CjvLvNm4yHlY1rthkGbyGSf4z/HhfSgnJZ4jyuJ4zO8oSbmsuoigTUoKGA9UJK
 zCYsfowtP+kY0eizBaEIGPuPMKAssovtDORvffuUAOF9XvApriaxvZXtSBeiAhh6
 bFiRUBV0dsAL1cNmQQDqQBHp74KlVVnGfZZe4gKpZ64Z/eqn0ejS+FxAKRvcqdS4
 BejQz+owRv/rVMO47FCtWFnBGlbLpr1TYZK31eUSGyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=w3K7Zp
 DE328VF7rO7sRSvqFXSJuxyQoubQ8Yde+b2ek=; b=FgnFKQ/Wzrj+wvSVFSWjON
 6cfcBvKLEHfADuZzE2jg40riMkfhVff3My6+iEDdOK8vOF3nUOwJDvXDnABt2Qnp
 oCUNjoZYC2juHu4SfRUaQpx39n1OBX2m3W2BkGIfRWsdq6YwKeiAu5BMBN2mCjxJ
 1MG2BpAoQx3cBOtD7DeQLDAZOoCtuTpGsyWq4ADtI+rNSCLGpmxVeQQMlbezY4qo
 MH0ke4KIwmzLtyZDJzB6F2DBmISYBvzSjHPqYqjC07WHL+vu9alLI/KjW6a/zh7I
 mYdGPA6CA16AWKakMAlASgEAe55Ruz9uP0SaxZQR9xp2tGAS+I5aHdyVssjNGESw
 ==
X-ME-Sender: <xms:tChhX6cLwcqnuKGlLDHw5-iK5HGHCVtTkJfJp_vUMRglM9HJgXoZQA>
 <xme:tChhX0MclJw8Das7gMAvZHTUWvzarWFFWVAwOKBE_5hbPX-30Pc8b7nC-M4Jwa2JU
 SdC9eAJ4fWhQOethyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtddtgdduvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedune
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:tChhX7iSmNuIvs1bRq8iRf7T5s4opvUncdQ17St-JAq_tMsDAxM2Cw>
 <xmx:tChhX380S6oB5OrRseXIAfUZI-x289Bpx4fPRWtaoc-KTib_GMJeAw>
 <xmx:tChhX2s4h9ZuY6uTbcCwV3jEOWFpqrGQk2Fuqn2F_Q02SkDYthAnew>
 <xmx:tChhX3m7qMcu9BBUuGYOISVmQeKXAJmaKm9uMiusrZ_AMejP1OE3jTEPeO0>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1A562328005A;
 Tue, 15 Sep 2020 16:48:51 -0400 (EDT)
Date: Tue, 15 Sep 2020 22:48:49 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
Message-ID: <20200915204849.GC14485@apples.localdomain>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-2-dmitry.fomichev@wdc.com>
 <20200915073720.GB499689@apples.localdomain>
 <MN2PR04MB5951ED0FD5633E8144459A28E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200915195546.GA14485@apples.localdomain>
 <MN2PR04MB5951E0BA1D9E217C37B82ED3E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <MN2PR04MB5951E0BA1D9E217C37B82ED3E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 16:46:30
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


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 15 20:44, Dmitry Fomichev wrote:
> > -----Original Message-----
> > From: Klaus Jensen <its@irrelevant.dk>
> > Sent: Tuesday, September 15, 2020 3:56 PM
> > To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> > Cc: Fam Zheng <fam@euphon.net>; Kevin Wolf <kwolf@redhat.com>;
> > Damien Le Moal <Damien.LeMoal@wdc.com>; qemu-block@nongnu.org;
> > Niklas Cassel <Niklas.Cassel@wdc.com>; Klaus Jensen
> > <k.jensen@samsung.com>; qemu-devel@nongnu.org; Alistair Francis
> > <Alistair.Francis@wdc.com>; Keith Busch <kbusch@kernel.org>; Philippe
> > Mathieu-Daud=C3=A9 <philmd@redhat.com>; Matias Bjorling
> > <Matias.Bjorling@wdc.com>
> > Subject: Re: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
> >=20
> > On Sep 15 18:56, Dmitry Fomichev wrote:
> > > > -----Original Message-----
> > > > From: Klaus Jensen <its@irrelevant.dk>
> > > > Sent: Tuesday, September 15, 2020 3:37 AM
> > > > To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> > > > Cc: Keith Busch <kbusch@kernel.org>; Klaus Jensen
> > > > <k.jensen@samsung.com>; Kevin Wolf <kwolf@redhat.com>; Philippe
> > > > Mathieu-Daud=C3=A9 <philmd@redhat.com>; Maxim Levitsky
> > > > <mlevitsk@redhat.com>; Fam Zheng <fam@euphon.net>; Niklas Cassel
> > > > <Niklas.Cassel@wdc.com>; Damien Le Moal
> > <Damien.LeMoal@wdc.com>;
> > > > qemu-block@nongnu.org; qemu-devel@nongnu.org; Alistair Francis
> > > > <Alistair.Francis@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.co=
m>
> > > > Subject: Re: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.resu=
lt
> > > >
> > > > On Sep 14 07:14, Dmitry Fomichev wrote:
> > > > > From: Ajay Joshi <ajay.joshi@wdc.com>
> > > > >
> > > > > A new write command, Zone Append, is added as a part of Zoned
> > > > > Namespace Command Set. Upon successful completion of this
> > command,
> > > > > the controller returns the start LBA of the performed write opera=
tion
> > > > > in cqe.result field. Therefore, the maximum size of this variable
> > > > > needs to be changed from 32 to 64 bit, consuming the reserved 32 =
bit
> > > > > field that follows the result in CQE struct. Since the existing
> > > > > commands are expected to return a 32 bit LE value, two separate
> > > > > variables, result32 and result64, are now kept in a union.
> > > > >
> > > > > Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> > > > > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > > > > Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> > > >
> > > > I know that I R-b'ed this, but can this be moved to the namespace t=
ypes
> > > > patch, since that is the TP that changes this.
> > >
> > > You probably meant the ZNS patch since result64 is first used there to
> > return
> > > ZA starting data LBA. Sure, I can move this stuff to that patch.
> > >
> >=20
> > No, I actually did mean the NST patch since TP 4056 is the TP that
> > "unreserves" dw1 in the CQE.
>=20
> It is not necessary to change it in NST patch since result64 field is not=
 used
> in that patch. But if you insist, I can move it to NST patch :)

You are right of course, but since it is a change to the "spec" related
data structures that go into include/block/nvme.h, I think it belongs in
"hw/block/nvme: Introduce the Namespace Types definitions".

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9hKK0ACgkQTeGvMW1P
Deljwgf/cvxpE622fjcz41x3Axb+OXcB9ac/azepfYlVKhzrctwCcERGPhsrZYuN
PWIbyZQUzs7KZJot2oUEBYgu//4undJ5JweupIvlMQa6CbSKEAnY9lKAsKOkGIWL
xAU3iZqZINi+4n3bs8GuPMPHw1um0fGD/0LirYujWbjxVzT39WdLNRwy4pDUKSRd
rBxG4CEbqp+RBUJtP3NG0ke0m5ZdkWqKeRn5f/9eHH7gyGgmLDI6PwS9kBjvn+RW
NKiXJApA1HY6QdoVEn9QMCmFKazmDu4FQV3RE3P+6yjM8oiOWDZ8UGxEQlgTH8Mv
Beqr+8ApS01WFeUs+YjYvuYIjFzq/Q==
=LYaG
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--

