Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F53C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5888208FE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5888208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMowb-0007yS-F9
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 04:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kMoss-0006n2-TD; Mon, 28 Sep 2020 04:51:46 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kMosq-0007um-Qz; Mon, 28 Sep 2020 04:51:46 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 6E4905801D0;
 Mon, 28 Sep 2020 04:51:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 28 Sep 2020 04:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=GtLogJXpt5qbeKKcdtTIItnqTC0
 8h3cxKcCKfEFprSc=; b=q+MKz7YMRajAm1U1gQD5IY4BR+QEC2YK8cicgo3xWlS
 /VT28TIK6nrjXb/MfvXiAeLH/Ak8SSEvHbJm5XvT8KG1QjmJRZdyf1aifl3abn7o
 z50xOYz/POezlLDdJcyQ10BVIww3+Ypx60lMBCJqoafN/l3EjREKMv10f5aQQ2RA
 aBeSSKq9nTHxqp7dRej15XqJSYFBS07RO+H/+77JfcVACQAvtIDf7qgJm5VKDEPJ
 97kvhtqgtSA0NWTG+b4c7dV72PJ4HpHQirQP93LVez/7oG1ki71R3ayMaJ4n40/q
 rn7f348iT2ds6fGmqkT2oHDGD2gM09psGNBL8GT1kCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GtLogJ
 Xpt5qbeKKcdtTIItnqTC08h3cxKcCKfEFprSc=; b=Axd3A0QeJLpORVMbwVsiZp
 Xy5coUDWJm71OIJguY02FZmXno69/hTB0JhvLVtNT7BC/xc+tctRzSek7zJ2hqMD
 bxyW+m/4FSdWnYg4jsgHKko5zXZ+fyzcSmPnVPHsqpDhUWjvCuLWVmFDKreR6X2r
 Xn23l+ukPtt2is7a0dcijMw8QzASTjvyyez70PBGDvhZwlZp91TU0uHXtXqSMXny
 rVHEPnib2IMYrt8vPrgoBPoH9//eKSCAjcW150f+yjx4rCNXuuGV8BuqaXCUaNcR
 KxpizoJ4Kd/jwgrTriyITJyU/kZUNQuKgXn2SNAP1hCf9TUaWGzOj9rumkGLLdiw
 ==
X-ME-Sender: <xms:HaRxX_Wg99Y2vOlEtp0NRKmtg5egVhl9NqTPaGdNwc8RHVqzrvW6_Q>
 <xme:HaRxX3nC3SHrKdFNDm3e_TP_ZPmLiIlwqunn7y3s9dO6kj1Jk9ZPMDbycwTVTzqJH
 YZp76DaXKVkvB2F90M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigddutdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:HaRxX7bbENVKTOayMoZzwnzT28JIJfcTPZdOj1vPdalj19_kCAHLeQ>
 <xmx:HaRxX6V8PoL-1ZTx9hQQM6nHrXxHIEKtP7KR6eEs5_ycOAYfnNStxg>
 <xmx:HaRxX5kU99K5FraX8WLONRChchPwij7jRsprou5cHt6j-ZxZks4bVg>
 <xmx:H6RxX_e1zrWifF2CRcez4bwA7tKgiLYzevuQ46rYWuNFfDg4evpd5FmQld0>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 220383064680;
 Mon, 28 Sep 2020 04:51:40 -0400 (EDT)
Date: Mon, 28 Sep 2020 10:51:37 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v5 01/14] hw/block/nvme: Report actual LBA data shift in
 LBAF
Message-ID: <20200928085137.GA33043@apples.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20200928023528.15260-2-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 02:36:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Niklas Cassel <niklas.cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 28 11:35, Dmitry Fomichev wrote:
> Calculate the data shift value to report based on the set value of
> logical_block_size device property.
>=20
> In the process, use a local variable to calculate the LBA format
> index instead of the hardcoded value 0. This makes the code more
> readable and it will make it easier to add support for multiple LBA
> formats in the future.
>=20
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme-ns.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index 2ba0263dda..bbd7879492 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -47,6 +47,8 @@ static void nvme_ns_init(NvmeNamespace *ns)
> =20
>  static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>  {
> +    int lba_index;
> +
>      if (!blkconf_blocksizes(&ns->blkconf, errp)) {
>          return -1;
>      }
> @@ -67,6 +69,9 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace =
*ns, Error **errp)
>          n->features.vwc =3D 0x1;
>      }
> =20
> +    lba_index =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
> +    ns->id_ns.lbaf[lba_index].ds =3D 31 - clz32(n->conf.logical_block_si=
ze);

You fix this later in the zoned support patch, but this should use
ns->blkconf.conf.logical_block_size.

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9xpBcACgkQTeGvMW1P
DenIaQf/Z/aEZ1YwW9d7YbeWu/VqjYL6gJwGb96im6GSWf26vdgtkjyPXk+5IITg
qsZjkuFw5saxeU/DQ7WPFkakct33O2bgbsEYTnrHST3tCOTDV7NX+NrudaJkRlQR
RimVVF/HieDDAKRHhIrOtXy9hOPeR5qZZee4onWWj1WmP29LG2Ef7eLZ68nXwMQZ
8qnzBQjaCdOkIloML4HXEDYLKjCIOe+gZrtefRYTpzdyb7cJFwJrYTBcBkBg52qu
UGEsCi6NOsVtfIHn/XjtXt65E9gRtAGV5gTO3c3eupDWNuBkNbg7J0wYIjhJ2yVL
G25xj/eNtJWRvQuBy9XhbHUphvTSVw==
=Cuwt
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

