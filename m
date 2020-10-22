Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8DBC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D7E223FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D7E223FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWZG-0005sC-Sh
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 05:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1kVWWO-0004ir-6t
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:04:32 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1kVWWM-0003Dn-7Q
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:04:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 79614643;
 Thu, 22 Oct 2020 05:04:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 22 Oct 2020 05:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=kVTXhzi0NZVfbMOxEhA9iQ0TSXH
 Ui0H4H53qrYS1k+M=; b=jtoI8MlfGSpQTTH553gidNy3TpGojumfyfoLVNmLx2K
 AS/gQZe1gYZ92cVhrK4Ed5vZWHyjfOkElJMaNs7Rwr+60Djr13EwrxkZX/BljiZf
 FvFvwGo9mdVk4EXE/8CiwZlQ4om6F7K6Kz/hqQ2HqA94hjQaW1V049da3cv5d6qk
 ENM6vlGaBHkjBMa2gQ2mtmi6gqLmqq6/W2rl6bU5pVwG/ldm1DL+Bbh5uHjUeXMw
 WWkzDZQZOVkQ9IALT4qV3M/M/uxRUCDWsntAxdLmna2wudMwUE6+t2Thtkxc2kZC
 yaG/PB8CBhIH2db1Lw2YWZBUgKuGqIYGm48Z6pcQP/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kVTXhz
 i0NZVfbMOxEhA9iQ0TSXHUi0H4H53qrYS1k+M=; b=liqOnw6WynqYbXWNRzc2sN
 1MdiVkYa6Xrj2UONWczeygRBArHgZegIaahNWP2jmWLuDb3mVJZvKZ+sUlRaOrB1
 QEzCOI9MG644Ueu8X31fwZ97wlrEoyafcryn1R/URyWDZ3W7I0/qORXYjEsXmMeQ
 bjthQx9EBWM4TeuYKflGVk2erjhpbrVgRcrs47zUBugs+HnNpuoGQLSd3zZgLeW2
 cGK+4ln3pO+XfN9lWOZI8I0aHzqTFdreLcc9jo8B0CzaBO/WMj/5IQmuihvusgx5
 VCDxPFA9DrKXgJIojkyeuq7Sp+kd6ielT37QIchqtU56RBrMBIgxNfbiFiVMHqJw
 ==
X-ME-Sender: <xms:G0uRX9vE9fdOkS95vhzXFRcFIIdNiAWMu58ex-hFQKgRLr6JETCJ5w>
 <xme:G0uRX2evWw77_7VIP89J6FKQYQ2M-IhYXW5-Ce2bjT4CPTZY1I_Nya7q_KHTl9ScN
 Cu4HGx-NMQpp_y8_k8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgdduudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepgffhhfejveeuvdeuffegtddvtdekffetgfffiefgleelhfduheevfefhtdduffet
 necuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgpdhgihhthhhusgdrtghomhdpkh
 gvrhhnvghlrdhorhhgnecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgv
 rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvh
 grnhhtrdgukh
X-ME-Proxy: <xmx:G0uRXwyR9Hicr88WbFpfQCGvC4eQfmRTbOozxlng00By5AqPStMh2g>
 <xmx:G0uRX0P2ZZ6mpfP9RFuFCIUWB86pi4xNTExDcxap8JfdveY2EAWvVw>
 <xmx:G0uRX9_QsWjNsk4011HnnvW5X3wA3sx5bWQroCvKHKmcgquTtJM5Iw>
 <xmx:HEuRX5bySw90nGCM0a8Vjb8Kt7Bf-eqpz4ilpg6TrBpwFhMgjICpdA>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0B33C328005D;
 Thu, 22 Oct 2020 05:04:25 -0400 (EDT)
Date: Thu, 22 Oct 2020 11:04:24 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Update nvme entries
Message-ID: <20201022090424.GA148638@apples.localdomain>
References: <20201022090045.158261-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20201022090045.158261-1-its@irrelevant.dk>
Received-SPF: pass client-ip=64.147.123.20; envelope-from=its@irrelevant.dk;
 helo=wout4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:37:21
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
Cc: Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 Klaus Jensen <k.jensen@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 22 11:00, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Make sure that maintainers of both the nvme block driver and the
> emulated nvme device is notified about changes to the shared nvme.h.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6a197bd358d6..f546ac6840f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1876,6 +1876,7 @@ M: Klaus Jensen <its@irrelevant.dk>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: hw/block/nvme*
> +F: include/block/nvme.h
>  F: tests/qtest/nvme-test.c
>  T: git git://git.infradead.org/qemu-nvme.git nvme-next
> =20
> @@ -2953,6 +2954,7 @@ R: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: block/nvme*
> +F: include/block/nvme.h
>  T: git https://github.com/stefanha/qemu.git block
> =20
>  Bootdevice
> --=20
> 2.28.0
>=20

Please diregard. Just realized that Philippe already posted this[1].

So consider this a gentle bump for Philippe's patch to be merged ;)


  [1]: https://lore.kernel.org/qemu-devel/20200701140634.25994-1-philmd@red=
hat.com/


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+RSxYACgkQTeGvMW1P
DekGtQf+IiIpD5JT7Mi9mFKhmIJ8x2jaV0XnC1rWa10MgN5Ll50BSmBRapDdgdZX
6CBerVxTwyRSMLTlGsESROzu408eZsdcVud6ITgxhdTZ8iB+IDihhFM6jAVlMorC
kBEx4MXWU5pySGQCtoai+jKeRlVMRSuf+qkw9vyhm343oTwrFI3IitJ1s9gdi8AQ
m5WX19x+RhcFkb5kFlFgV3mtyB1WC/gUb3OOKksS0qV7BKNt7MtXMscce9KInIEj
S2lPBeLpvQRT4+ghxU+oEd4Mi8WNKSFlFnC6wBpH9wSG65xI2Qb7uXhcekHO3JVY
Jz+TjU20Jm+iI0RfGzYE7B6Xo6fNqg==
=3Co0
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

