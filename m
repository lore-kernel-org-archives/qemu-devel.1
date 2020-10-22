Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BC0C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DF82417D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DF82417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVaXJ-0005M3-SO
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVaT0-0002Sl-81; Thu, 22 Oct 2020 09:17:18 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVaSx-0002YK-Bi; Thu, 22 Oct 2020 09:17:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 133D25C0108;
 Thu, 22 Oct 2020 09:17:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 22 Oct 2020 09:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=CoBZMOgpLA5jgvUzZ8PriJE97ay
 fSZXAHhnXEBsRyiE=; b=fjT/rvC6QwfrGPfHf2GsU6SaPzOv9MnjFWxxXhLoOtn
 46lT+KYD/cOE6Qa/w+fDCkGToNNCGm0pqx80J9+PpEHv6IYXf95MiHaBOUnvkbH9
 73hGLR01aMpGKBec3RZjXI3ItKirDugBhhUjxsOAyEwN9TPu2lbAWF3eNyOk4xPD
 BGLXSiQHWKkoTbqetDgQ743JCsXHSIUfxcYUGefEA9UBP86GcDUpiW3ElQ9M4jav
 XJ6l5NQHDB4xndlMEcPLUexHdX96u4cI8+YEt3/nU5fbn+dfVSFyjQmiMncpv8qJ
 qo2dm9ZnrtATNj5338BUs2j1Vpp1hVUxrlWitsmmyOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=CoBZMO
 gpLA5jgvUzZ8PriJE97ayfSZXAHhnXEBsRyiE=; b=ACROONp+ACd7O2ee1gY80T
 lcLM6NiC+J+wra6i6g89t5+A7iEQuXwazbxdHeZ0mI7WxXNMYBSbgVgYbBGwAS2F
 nAOSK3V/IUcNZkshgvS5ycqcJh5ZfG1PQI6vLPXYREUvWR5P7+QOZWOlPCjSncWV
 QPwJmAgPNi1JodWCm7OEZH2aLsTS8tMyFxFv6xyr7A8tfIBLOeE66bIO68AQb0eB
 NdS0eyTDT2XxgJeslEgmxNN1gM/hFCF6I1cIo0xtsG+qJaUDLyKGSb4QdfJFRQr4
 b0cAFqRP/oLzgCbznMDMnEh2Vwrkfb/m8MubftOGzG2DfaSiZ42c+jW6nZx2/l2w
 ==
X-ME-Sender: <xms:VIaRX375Edk5A1wkVFpebVBDMyf_CTTjTjefhxQ4htT_1dIRintMkg>
 <xme:VIaRX86K7B4DP4RKJeotVdd6fbkrhzfcTwz2djsGEBJ-yg2mgwI9bi7-_yXH6Z2N-
 EOgrv2osY8JwRpLfhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgdeiudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:VIaRX-eFtEA4Zwx7drcgHP4Q2VYJgZHxCh2oOZkvPrNsG9wSICViLg>
 <xmx:VIaRX4L5AcVcLLvCwL4aGPi4BFcYCfkQzGDmpaoqgCuOevDnPa9T7w>
 <xmx:VIaRX7LMHaRidipVH4_D34TaZXdNHojF7J_SNBt6VDRf4uOI44TpGA>
 <xmx:VYaRXxjTIU5HnROc3SwroJugZ7YX10id_aPSnWQwIhhXcuXlciKMww>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2B0C93280060;
 Thu, 22 Oct 2020 09:17:07 -0400 (EDT)
Date: Thu, 22 Oct 2020 15:17:05 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] hw/block/nvme: fix prp mapping status codes
Message-ID: <20201022131705.GB148638@apples.localdomain>
References: <20201019173538.129854-1-its@irrelevant.dk>
 <20201019182045.GC1435260@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <20201019182045.GC1435260@dhcp-10-100-145-180.wdc.com>
Received-SPF: pass client-ip=66.111.4.28; envelope-from=its@irrelevant.dk;
 helo=out4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 09:17:09
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>,
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 11:20, Keith Busch wrote:
> On Mon, Oct 19, 2020 at 07:35:38PM +0200, Klaus Jensen wrote:
> > From: Gollu Appalanaidu <anaidu.gollu@samsung.com>
> >=20
> > Address 0 is not an invalid address. Remove those invalikd checks.
> >=20
> > Unaligned PRP2 and PRP list entries should result in Invalid PRP Offset
> > status code and not Invalid Field. Fix that.
> >=20
> > See NVMe Express v1.3d, Section 4.3 ("Physical Region Page Entry and
> > List").
>=20
> Looks good to me.
>=20
> Reviewed-by: Keith Busch <kbusch@kernel.org>
>=20

Thanks, added to nvme-next.

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+Rhk8ACgkQTeGvMW1P
DemXZAf9GITDu2CNPn9USmlBXTeWYjZb6TRNwgdF74JdKp5D8X/FAvhjefV/no5f
QFutHN13UQtJtjB78KOlK67OFkzx5NjS/YYd78fqXWfWTZnH6ZuWpvh3dniEP+Wd
YWz0QfubVfD+ZE6fIzNPrl3G9ToZFuCOIEqOHWdzjxH69oSlkGtdc+FMDDRmiIw0
s6ArAOzy4e5pOJnEQ+EkOHKT8ueqA6rJLy7qKKWGOuc8tzSRPd+XRa6P6MNsb+9C
pZk5merqeghD30aL+ex25cXTGSEWKaqkveQUPSqLdHmiT6UbcTqu/0BUfE0xVhpx
tpntkXw0waiQz9WsEVC815ZyQijGNA==
=y5Ri
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

