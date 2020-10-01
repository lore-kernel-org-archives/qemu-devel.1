Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A70C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71059208B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71059208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNuJy-00060v-2B
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 04:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNuG4-0004TB-HL; Thu, 01 Oct 2020 04:48:12 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:39689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNuG2-0004q9-0p; Thu, 01 Oct 2020 04:48:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id B987B58026D;
 Thu,  1 Oct 2020 04:48:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 01 Oct 2020 04:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=JNc9I2IZbjNLAGqDah6eaWifkSF
 qrCTpCyVeJgFjDQc=; b=lzMnCb1ksSHfRmCgA9oPN3Oil0olxtz4zvVN5vikzpb
 5IiabiaR0ohyEeiagq7Ob2hlwYGWsqhXc01D83hzNS2cNnbYMoqoSBy+Jl5qWC9Y
 9GZwNB98+SUOpTrIK07Kj8+l8MlGmNYbQmmCzrLUsk0zm50ZsvjthvXrhdl4oO5n
 wJQJeCQlMDoowqCAX2Ka87glIZW/d45BSKKq7Hi3l6sAq/GcqJY66cysj8+SxuJj
 p7rltvuo84EFUisRIJ9XywXLuV+2Sdx8KWf5LwMmns3eFKPhkhpmmfCYdmsgm81I
 fXHjggZCa2Am0eG0NeJO87lbzrsYZPfJ87scUPlF7Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JNc9I2
 IZbjNLAGqDah6eaWifkSFqrCTpCyVeJgFjDQc=; b=L9gUtcME92tZKkWdAh4++T
 0xO1vnsD4XOzve31R+ZUuf+0Na30Jr3wcAZ2uLAz1SgxPO/7IFgm3GW8T/0FvyJD
 uk8GkY3YdvXI1FM6xq1vMynSV3qkuIxYjrn/OY4DKlEIxlv/tpzS0RFTOfnf14Hz
 PmCc0bdAt+kCvI+eS0ZFKuYxdFrHhUN/XUfFteSwaT4B3PrP3WiGOKa10mn8Cd31
 vg23vH7oPeQWIWcC+bvty8LyF1iTM3+EOkFC0jhlGYgmFwNKSonnOB5Rp/XNWLBP
 9/wXsGkiYbQdwl5fDZVEYCIdWra2+dpWAULDEV4061CEfkeh7AiG7+vr7BjuccOg
 ==
X-ME-Sender: <xms:xpd1X9_A7IS4073xU6jfMdhF-37Wl6kzxb3s-5l0Oist7uEpuN1wKw>
 <xme:xpd1XxuVoMWWfX24G3aox5yP9f8rRqAmLFSjOs7dab-vxhv6pGSAHjFmrxB0MRfL1
 HA5uLsEHwWyRwCPx-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeduleegrdeivddrvddujedrheejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:xpd1X7AWmkHcgw_ndzcyqzaa97RyzxGiCV2v-rop_bC2y7p2kQzT8w>
 <xmx:xpd1Xxc1IS7RqTtDBfnb8pu5l3EKjvY-BGmDxlUQs7m1XD52o8qkQA>
 <xmx:xpd1XyMJTpnqRq21oZkUgrE12b58wt_CUsRXMuO73Dzr5uqM7WHyew>
 <xmx:x5d1X51KHW5GANaB97pfmi83_7zpaIK3hxR_WOwzXBFvrqazArAcwA>
Received: from apples.localdomain (unknown [194.62.217.57])
 by mail.messagingengine.com (Postfix) with ESMTPA id 81BAB328005E;
 Thu,  1 Oct 2020 04:48:05 -0400 (EDT)
Date: Thu, 1 Oct 2020 10:48:03 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/9] hw/block/nvme: remove pointless rw indirection
Message-ID: <20201001084803.GA688151@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-2-kbusch@kernel.org>
 <20201001040508.GA681387@apples.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20201001040508.GA681387@apples.localdomain>
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:48:07
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct  1 06:05, Klaus Jensen wrote:
> On Sep 30 15:04, Keith Busch wrote:
> > The code switches on the opcode to invoke a function specific to that
> > opcode. There's no point in consolidating back to a common function that
> > just switches on that same opcode without any actual common code.
> > Restore the opcode specific behavior without going back through another
> > level of switches.
> >=20
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
>=20
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> Point taken. I could've sweared I had a better reason for this.
>=20

Can you also remove the nvme_do_aio trace event?

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl91l70ACgkQTeGvMW1P
Delo7Af/UL9WJ4KeBohGIvoNeFz1PaDNIekuB47cgqSv8Icjt5uhxXSRZISrxKHe
ehnI8BtE3miweo1SGOR5X2DSX8X+Mb62dgwKr/v2kMcPlo3mU4kVyGMgdU7NuKU8
goM5Uq/kG/4I1/kMOJ5TXKLMXWBjoZIbH3IIAK0b9ZpH3w+HUbrMn8FVZ/NcS/3Y
duVv6VrtFlkyvOzaY+UjZVOhgIHe1XSRd3zrB+8ZpgSMkGxq/uwdyxQNumKoJ/wq
VtuEjlCv5rSBZ4C0zbrv6sljIF30rwf5/1vqs9V0yURS3vSZ/0IVwE1OfTVmYuH/
aOvF+gbo/0z4QGHJStbn6+RJsm+Sdg==
=gJrF
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

