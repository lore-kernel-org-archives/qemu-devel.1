Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FD0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03AC20809
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03AC20809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIHv6-0002gz-J2
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 16:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kIHqU-0007AI-53; Tue, 15 Sep 2020 16:46:35 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kIHqR-0005jf-J6; Tue, 15 Sep 2020 16:46:33 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 1FFDA5803CF;
 Tue, 15 Sep 2020 16:46:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 15 Sep 2020 16:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=vCkhGcQlFAmTI2qMBXMg3d+qaez
 CL/kbOU8m+zS3kFc=; b=VoEjPvPbeuJlU14vbrzwFvwDuYOnA06h3gyFGnt7HQa
 /HRgFyVhjI8ZOib3X49qcCeVewLI0aDBYoB8hv9eYLrL5gKBMubXtkk9Cyas+m1g
 ba66uxXy1aHrTqsLoc6qLDZvRNR5xqAfFj3puiooxcvqtt2m2tJe1EFaPPqHLFv+
 wCfpIfppoFIVb5HVFvnkVAlibQeqU6dCno+XqBS/4zMVpy2G5d7Iy2gkXx4fCT6N
 Mb+WcSM4x4682J10W538sDqf26UMa8NT1XnjIRYYfuii1o2CmjmgM+ZmH9B3ZriO
 JbDq/6VByNShlRzh1jemNWYpYr7qftechNoT0u8CHfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=vCkhGc
 QlFAmTI2qMBXMg3d+qaezCL/kbOU8m+zS3kFc=; b=WsDlEtq/r7ljPTTDpHjj58
 V72AxEi0ZA+esZmVjFyUIBCgXweLqdhfHfXLoY+Om5NZ6ObczoDr+P5s/41pZ/aq
 fqpGWQPcrPY9cZp6TMFPkxc4P/FC6l7dbgba330Xe4NQS2fsXldse/ZUmZ28Pp7B
 iCdVX94xw6XmdnVDzkt12M8sIZyDgU8RfMLnfzwT9kNWnhoKmkKvVCTnu4ypQi9b
 R9ZtCHAZGUgFHEw7HIykEAlka8WJVsabIOB7sc8wHQr/l5NktUaO39RNeiBjIDhi
 O1/DLyrvq2omFkin81pbPbAdgIaYx4Xt3Moq/TT00BJG+TZOovC05GL8g3Y6PoGg
 ==
X-ME-Sender: <xms:JChhX0kOKrvvkG_ZZ04uq4GLZ6FWLvxmuNV7iSBr6wpOZbt-mOaGZw>
 <xme:JChhXz3H_zoV9yZ_IBJoZ4NeSRlfVxtlD_v4vjlRJeRc_6xcwdbbqVOUJuGrIzeXG
 FcfXnzyPp21jmaA_WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtddtgdduvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:JChhXyr7hHVtD4YDj2HLOGUpdyj4N9a2qdrmdjZnsYwgdkOS20hhgQ>
 <xmx:JChhXwkZ4r7kaS5j6BKw3h6k8_wvH2O42zmBCxaa_YLkKjQctTd2Ow>
 <xmx:JChhXy2DUoewGlZH0gUGY4Ms8AbexcA_RANPT42uhkFQ8bQ9f6D8lw>
 <xmx:JShhX7s6xOHme9nVExWnK8GsL5a3xkF7xBPQ8jja5vymmnmecAdGVnXT5Uo>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 63B753064683;
 Tue, 15 Sep 2020 16:46:26 -0400 (EDT)
Date: Tue, 15 Sep 2020 22:46:24 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v3 14/15] hw/block/nvme: Use zone metadata file for
 persistence
Message-ID: <20200915204624.GB14485@apples.localdomain>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-15-dmitry.fomichev@wdc.com>
 <20200915190935.GD499689@apples.localdomain>
 <MN2PR04MB5951BE02EAFDCDEF2DEF9AFBE1200@MN2PR04MB5951.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <MN2PR04MB5951BE02EAFDCDEF2DEF9AFBE1200@MN2PR04MB5951.namprd04.prod.outlook.com>
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


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 15 20:44, Dmitry Fomichev wrote:
> > -----Original Message-----
> > From: Klaus Jensen <its@irrelevant.dk>
> > Sent: Tuesday, September 15, 2020 3:10 PM
> > To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> > Cc: Keith Busch <kbusch@kernel.org>; Klaus Jensen
> > <k.jensen@samsung.com>; Kevin Wolf <kwolf@redhat.com>; Philippe
> > Mathieu-Daud=C3=A9 <philmd@redhat.com>; Maxim Levitsky
> > <mlevitsk@redhat.com>; Fam Zheng <fam@euphon.net>; Niklas Cassel
> > <Niklas.Cassel@wdc.com>; Damien Le Moal <Damien.LeMoal@wdc.com>;
> > qemu-block@nongnu.org; qemu-devel@nongnu.org; Alistair Francis
> > <Alistair.Francis@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>
> > Subject: Re: [PATCH v3 14/15] hw/block/nvme: Use zone metadata file for
> > persistence
> >=20
> > On Sep 14 07:14, Dmitry Fomichev wrote:
> > > A ZNS drive that is emulated by this module is currently initialized
> > > with all zones Empty upon startup. However, actual ZNS SSDs save the
> > > state and condition of all zones in their internal NVRAM in the event
> > > of power loss. When such a drive is powered up again, it closes or
> > > finishes all zones that were open at the moment of shutdown. Besides
> > > that, the write pointer position as well as the state and condition
> > > of all zones is preserved across power-downs.
> > >
> > > This commit adds the capability to have a persistent zone metadata
> > > to the device. The new optional module property, "zone_file",
> > > is introduced. If added to the command line, this property specifies
> > > the name of the file that stores the zone metadata. If "zone_file" is
> > > omitted, the device will be initialized with all zones empty, the same
> > > as before.
> > >
> > > If zone metadata is configured to be persistent, then zone descriptor
> > > extensions also persist across controller shutdowns.
> > >
> > > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> >=20
> > This doesn't build on mingw.
>=20
> Thanks for letting me know. I'll try to look into this. Do you cross-comp=
ile
> with mingw64?

Yup,

make docker-test-mingw@fedora


--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9hKBkACgkQTeGvMW1P
DekJYwf/bfPKuyqSbE1Ir71fGH2lFmDbroMwj0TOtvSrn+7UdjUtE45QgLVLGbY7
7FC4Dnm5aKfF7uPr3TQdolR+wlCOzblTPSt3jiGdYLXhmOuWJdTa4ITXmWhuOlXg
LLc7TjcOb0Yqi0YWBRD3FgNErhEDGMHeIa5l/p0bof8UuL5+XEOI0AcPPiHmvx/K
FxJtpqAWKaj4wUHzwVddZ3KgBSTLx5w7/RpWt5pnNZR7alLXQqZKcX7MeVO0L3Ig
ZsEBfw3nI3kgZaBCW4UsfFPa/izj5E0F/KBODpwBHzHSLJKX/V/hn/CbfQQ129vc
ynG1/tES4zy42Hyk1u5oDMzmjroDUQ==
=mGoJ
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--

