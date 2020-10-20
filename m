Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7335FC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC172225F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC172225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUn4K-0000e5-4m
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUn0T-0006v1-U1; Tue, 20 Oct 2020 04:28:33 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:35175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUn0Q-00071l-RF; Tue, 20 Oct 2020 04:28:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 0EEC8B84;
 Tue, 20 Oct 2020 04:28:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 20 Oct 2020 04:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=ezmvz5MNb9lQvTXKWG862UU6UbI
 Ogy6zNppizjjbM24=; b=0+zv7TmtT/dQOG0zF38eubG3Hu6YRKmcTN9gk29uW65
 QZKt4D5gbUs734zHYuk5aM/OKkJEhOFDOMl/wqogeDI7Nwsym6Febq2h9CgVAk2C
 A7PXh6EH/4sISA22V7bZ7I1YO8AInmmMy9t4Cf4kfsXBS3ulOZm9crIDdoTp2mKL
 V70rEEcgRXgcPtBrn2d78H79dlHI+/W+0k+7hvIvlQteodeaidNDmDiNSVxB4yT7
 kcWunRwiKcD+HbliTuePTMO+mW+2kkIhGV/m+/wsipDL/MUjd7pAcouGeifBlXDk
 ldSKjZlISniPCU0/nXR3nDVNjWwWCW/+/ydkiiDzs6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ezmvz5
 MNb9lQvTXKWG862UU6UbIOgy6zNppizjjbM24=; b=Dn4AXenK7NB9hfkurp+MgK
 AiNFjs5zDANvp+a5RYdiq10VgFQbEaujI70TqVNPnEQVJDkSz6xHYkgDLtWDuJ80
 7fqfMQYo0ybSNTJP/C8U0OpRsnYoGv3Ek9dahhzN0hgWvk0BySWoXV7x2XsRVZ+v
 FhGtZ/78Lonk7IjE6a8hzyELcKxY1qsHxTdST/ORd0ouZuqoBE11kiffANVWlQUl
 fOyVtVWw8To7HyGFJsIR8BVf1WojJnmKI49dd7OX6QM7fDB9HsvcUBArp4ydTXhv
 1bhOjKTcRo18fWRXTS7VFdM6GKAL4xcacZ5lobWzbSRh6F70qlZ9pHaBDs5220Wg
 ==
X-ME-Sender: <xms:qp-OX3eTqUrKORZyye8FZoBwzUX-0NPd7Buu4AVlxAC0eX_pYxP-GQ>
 <xme:qp-OX9PPWpB9SYfePd2jnoRsnVm2l20dojYdzRsUt_TFGBlJD5DUslxwMOi-ZJO-m
 BYQ_3pHp6vdc4oZHw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgddtfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:qp-OXwhnRpV92BU5cbQVNjk4uKNqtS-e1Pr3qXchiPbIW7eIdw_MVQ>
 <xmx:qp-OX496zv___6OK0kTjpSKQsKswwZDQ-4mnxCuMbPdwwy33R4iRwA>
 <xmx:qp-OXzttHqe7-nnABiar_0ZEia_NH9fdV0k7Ox4ULA0aGjcEqsORmw>
 <xmx:q5-OX3Ex9cnS2CSkjymCDB3w5ajZsg4n5YnlgPzP3CleCYpwYuqtYWtiO6w>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id C1C413280064;
 Tue, 20 Oct 2020 04:28:24 -0400 (EDT)
Date: Tue, 20 Oct 2020 10:28:22 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v7 10/11] hw/block/nvme: Separate read and write handlers
Message-ID: <20201020082822.GB178548@apples.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-11-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20201019021726.12048-11-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.26; envelope-from=its@irrelevant.dk;
 helo=wnew1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 04:21:24
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
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Niklas Cassel <niklas.cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 11:17, Dmitry Fomichev wrote:
> With ZNS support in place, the majority of code in nvme_rw() has
> become read- or write-specific. Move these parts to two separate
> handlers, nvme_read() and nvme_write() to make the code more
> readable and to remove multiple is_write checks that so far existed
> in the i/o path.
>=20
> This is a refactoring patch, no change in functionality.
>=20

This makes a lot of sense, totally Acked, but it might be better to move
it ahead as a preparation patch? It would make the zoned patch easier on
the eye.

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+On6UACgkQTeGvMW1P
DenKOggAtT//AShfjpkaqV0QqsefKh2KVleI1gxsKlt8zAFnL1f/aI7IKw3wgMY1
QlCAofMQh8Ves413Cg2wErXqo/N/83QVOhSmQ9Rtug57FxR1BvLD59DXhJrzSc7y
Ykewxz7lpCjaMfI387Dria4HncIRW3QsOdq5h1vz2z8eacwaMioEJeo/8HittwkY
DfiBHxhf55o71MdAhJQwaPSBsm6jx2uBKZ3w8znSEQHjac9FtwiP370R9jxKvhc/
Tu1v1iPQp+Gd1t8gNcdxuQpxEnd7ecQpJg2liWdzktoaOIfgjicCmCtFHJQMNeaC
L59xj/qTF25ZHT63QGY7NYOZ+cKQjg==
=Uzfs
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--

