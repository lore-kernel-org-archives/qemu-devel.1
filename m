Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E7BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97159221F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97159221F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaDaq-00019a-9h
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 02:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaDWg-00080m-SO; Wed, 04 Nov 2020 02:48:15 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:47745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaDWd-0006ti-Cb; Wed, 04 Nov 2020 02:48:14 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 48B8BF9B;
 Wed,  4 Nov 2020 02:48:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 04 Nov 2020 02:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=cD7ew9Z2oWVguXir6a9RoEy+1p+
 teQS1+jQtvq7lpCk=; b=swFUAEYtXAGA/YWHpHJM6lisIbc4QoGL/awPhfjPSED
 fuCoMom1KEHZXfpHQ7p9xJgsicvJkwlDe3G/xARslITmdyCqgGlzMzStZz4+qMPJ
 k3a9F/z1UXt5VRv2Vcgx/dpzSz0Sj7Fkq5qiEsZS5zKqG0VYG8V8yEmSAWmFKhP3
 NB14+dsftapThv+XqmZPFKB6ymqvB+48Fv3VTQUWJGndkIOtVTTmYNfVkSRhVQNJ
 VUC4Dqki9DlmTWDtY9H7aLZgNeTE31jbzkywD6mH2DnekXyRK0g+G4KyhRKi+P7A
 rVe1l+vdFd8axs0BfSe9j21pBUMVvhudQIIRIV5yVdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cD7ew9
 Z2oWVguXir6a9RoEy+1p+teQS1+jQtvq7lpCk=; b=W70BnG+rxJugvkg3bjolCF
 Dm/OhpRlNxCaRzSroYpPAW3r2eyds9qWhBqhB0XM8+HE8GD8ATLPReNsyrUav/ox
 4OfKyikBKdnH1i9BwURYLyIQ2QmE21VVl1NDIYPU0sttAYADg3nk2i3hBEnUf9SB
 TDWHYmUjG3r17i6HrxciqShBOJMbahQ6sujmRgEoj92GlTPnt/lSwZQh2MsB4xrH
 oGXb/RpoJnLSmOBUGyI9XRRAu/Iy4Nv10Dn7z51MZ3yHUmMOHUia4orAlQ7JUzo9
 7NQVQvgJai9KXE895hABh2Mc4LF2HH3kOfhiUGXIIZGI8zkZfLaBdBNocOcq8XDg
 ==
X-ME-Sender: <xms:tlyiXwQXYF4VSE5bwH2-xldGtSbWYFOImUJO3vBINrdWush-QfJM_w>
 <xme:tlyiX9yAPXujQEXCV2Eb68TLpTx6pK3YAUsRtM-I3ByDcXBXiD260_Hs_nUB4OxbG
 hofHMYyQx_pjBdjjb4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtgedguddtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvddu
 ffeknecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:tlyiX93dJUW_6BphhchMwyT_5JaVyogJbSS6wJZ5DJmex5pTK2YhFA>
 <xmx:tlyiX0BxE-kRfB7da2vEBhcF3oa90PUCpZVSVhfx3XVoc7Scf7tTiQ>
 <xmx:tlyiX5h8Sth3qkf-Yzmr1YekR49xxIimbwFz1gRCrxkRhv9lQTN-Fw>
 <xmx:t1yiX0qizI-7bpB-z7F3kSm7bAHXCBx2FvRCDI5wLFPcnyiFHynIPSCeDXs>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id F156D3280390;
 Wed,  4 Nov 2020 02:48:04 -0500 (EST)
Date: Wed, 4 Nov 2020 08:48:03 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v8 06/11] hw/block/nvme: Support allocated CNS command
 variants
Message-ID: <20201104074803.GB177281@apples.localdomain>
References: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
 <20201030023242.5204-7-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <20201030023242.5204-7-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 02:21:52
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


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 30 11:32, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Many CNS commands have "allocated" command variants. These include
> a namespace as long as it is allocated, that is a namespace is
> included regardless if it is active (attached) or not.
>=20
> While these commands are optional (they are mandatory for controllers
> supporting the namespace attachment command), our QEMU implementation
> is more complete by actually providing support for these CNS values.
>=20
> However, since our QEMU model currently does not support the namespace
> attachment command, these new allocated CNS commands will return the
> same result as the active CNS command variants.
>=20
> In NVMe, a namespace is active if it exists and is attached to the
> controller.
>=20
> Add a new Boolean namespace flag, "attached", to provide the most
> basic namespace attachment support. The default value for this new
> flag is true. Also, implement the logic in the new CNS values to
> include/exclude namespaces based on this new property. The only thing
> missing is hooking up the actual Namespace Attachment command opcode,
> which will allow a user to toggle the "attached" flag per namespace.
>=20
> The reason for not hooking up this command completely is because the
> NVMe specification requires the namespace management command to be
> supported if the namespace attachment command is supported.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---

Please rip out all the ns->attached conditionals (it's dead code).

Just add the new CNS values in the switch and let them fall through.

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+iXLEACgkQTeGvMW1P
Dele2Af/c/tilRZnurZ1QQF+xtCScVMT/E+pnwNo7n61MEqLMGokQVjRRCd7/28V
18hDByiRJSuvDm7mGTzmPtruP+CXZyT3tlJHyXnUhGeZHz86A3CSpp5u4Ny2Dalw
7g0E9j5Gfh/QogcETJs3/Gv71kDUE6hoRTNShvAMywFwpIuydZTIAVsFTRse80JC
yTbZanzPTJq+XORMCOXiWcN8vY02EVGB9tSEHedI5rlOX6+GmK/WVZF+E6CuBoLT
8hoxoh9Py6dLKljwradM6k8bchwv6hXE/xCajngJwYq+/c9I99Jx0tQk/+cAG+Go
KS1uVgpecew2GWRIZsFkmfz/8eo++g==
=r3oG
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

