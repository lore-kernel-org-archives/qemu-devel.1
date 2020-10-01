Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74EFC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 04:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FA921D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 04:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FA921D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNpuf-0003QP-38
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 00:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNpqn-0002Gz-Cb; Thu, 01 Oct 2020 00:05:52 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:41225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNpqi-0004hw-6n; Thu, 01 Oct 2020 00:05:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 232269F2;
 Thu,  1 Oct 2020 00:05:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 01 Oct 2020 00:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=kQHSp7MRqyN1atbGzWyvMzb6oVL
 z+Lmq7yQxRRlip+o=; b=EHaOlNmWYr5UZK+uTFKSlcq8MouJrWY6yKw177V9FZP
 E7CGyf7oxZjTilNpgkbk0Cs1XuKEnfHHwMw4o723sIAuobclO4PBBl7RdvXr85RF
 Giwny3IQsFP+O8wGGQtSkA5o7/7W9xPViUBf6swe0/+He4YK7FTe1uuttPL3XVeV
 01oH4NrkflboFmjhYviWhrcrvQlHNm9qmFgVvGEUcORMjLvBkk7hSXh3PEEteomV
 yEgYzSvTx+nwxttnBOVUQ5kaFA3jJk0GVtVX111JAhcQ0YQV0o7HoOGOwvx39QYf
 PtcdyMp1IX9OgEE88AwIDjzmQUKdTl8YFtO6JQqLMsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=kQHSp7
 MRqyN1atbGzWyvMzb6oVLz+Lmq7yQxRRlip+o=; b=KfhurCfHmKrLIe7HuO0TIb
 fn4u5mIwCnrrZ3TTDIOC3GgtO0phv778NFckTILwNpFNj3RiSA9TgptIiQ8W5V5w
 6QERAUfTJyup/PWvIdNWOCQaifYUl/q+ZNW8AHiL9W41YlDPfCqbat14FygE3Alg
 y2ai9k4coV1zb8D7/3F5xHZP9C3r5nKvAIhzvEViLvKifiubGa2mrwsvPPKHOc/B
 yM0F6m+OltVkdB5B5Mzhz22LEhFUOzZNJ8ysmILWevKpEjIOITA/3Ok0HPkhDNeg
 DkbwldEliIXC2r01hT5axfH0VNM04j1UMqbNe18i/zKZts294kaNUKyvauWnwWtA
 ==
X-ME-Sender: <xms:lFV1X8qf3jh-S2iqdmbBSYaLzB8DqCWidJ167dKgDagK-EK0mh6jXg>
 <xme:lFV1Xyqhh_z23ymVwWzREgfUZQOAbzaYE3wK8fDrBIKKgGPzCPAFsICMQBDL6f3I7
 9UkLpz-W97KNMxRugU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdekudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepudenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:lFV1XxOzo1bzM01yOMRmPuphxEwHOIXeH8pLr2AIU1Qg6BJaZREWGg>
 <xmx:lFV1Xz69_coJTUu7s0HqnfBiBkC3GiGo0fvzZGtndJ-BOSu07rMTOA>
 <xmx:lFV1X74Le9vKgkQni3AXp-5bZ6GJ8h8OGqzZplnJYBKRrJgzR5bIhQ>
 <xmx:lFV1XxQKe_PR2nXmPARYntWbI3UZDOVaxBNxPlZsFbat6dFHZzApdQ1Z85w>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6A80C306467E;
 Thu,  1 Oct 2020 00:05:39 -0400 (EDT)
Date: Thu, 1 Oct 2020 06:05:37 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/9] hw/block/nvme: fix log page offset check
Message-ID: <20201001040537.GB681387@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <20200930220414.562527-3-kbusch@kernel.org>
Received-SPF: pass client-ip=64.147.123.17; envelope-from=its@irrelevant.dk;
 helo=wnew3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 00:05:15
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


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 30 15:04, Keith Busch wrote:
> Return error if the requested offset starts after the size of the log
> being returned. Also, move the check for earlier in the function so
> we're not doing unnecessary calculations.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/block/nvme.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index db52ea0db9..8d2b5be567 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1179,6 +1179,10 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8=
_t rae, uint32_t buf_len,
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> +    if (off >=3D sizeof(smart)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
>      for (int i =3D 1; i <=3D n->num_namespaces; i++) {
>          NvmeNamespace *ns =3D nvme_ns(n, i);
>          if (!ns) {
> @@ -1193,10 +1197,6 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8=
_t rae, uint32_t buf_len,
>          write_commands +=3D s->nr_ops[BLOCK_ACCT_WRITE];
>      }
> =20
> -    if (off > sizeof(smart)) {
> -        return NVME_INVALID_FIELD | NVME_DNR;
> -    }
> -
>      trans_len =3D MIN(sizeof(smart) - off, buf_len);
> =20
>      memset(&smart, 0x0, sizeof(smart));
> @@ -1234,12 +1234,11 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, uin=
t32_t buf_len, uint64_t off,
>          .afi =3D 0x1,
>      };
> =20
> -    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' ');
> -
> -    if (off > sizeof(fw_log)) {
> +    if (off >=3D sizeof(fw_log)) {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> +    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' ');
>      trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
> =20
>      return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len,
> @@ -1252,16 +1251,15 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint=
8_t rae, uint32_t buf_len,
>      uint32_t trans_len;
>      NvmeErrorLog errlog;
> =20
> -    if (!rae) {
> -        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
> +    if (off >=3D sizeof(errlog)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> -    if (off > sizeof(errlog)) {
> -        return NVME_INVALID_FIELD | NVME_DNR;
> +    if (!rae) {
> +        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
>      }
> =20
>      memset(&errlog, 0x0, sizeof(errlog));
> -
>      trans_len =3D MIN(sizeof(errlog) - off, buf_len);
> =20
>      return nvme_dma(n, (uint8_t *)&errlog, trans_len,
> --=20
> 2.24.1
>=20
>=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl91VY8ACgkQTeGvMW1P
DenAdQf/Rbcy43fanSyMBXRZxOaqoe4C1eUpq52RTJ+rCLzUDadc6OoVajk8hl0N
n9tP43/tnUraHFy0gj8JsS0okWZkgy9DFV+iFd/ABT75ySsjjJKq5sWUy0bWhtXY
4QD4EzSURJGQUnHWHWtNJkImpkIDJmtJuunUyNKzoiq7cCNd8rj9xjkk2YLMYNJI
YchGrW2wcTReck6K6hD1dSO4vbRtiKW9Mwk+Kc+xgVTHC9nPtxgPsVM2/YbREhIJ
Q1rKUBIHVXUjNN4wAhDrr4Wf4w4z3R5K9ob+9cJA+HRbW+6dn8v+ieyqKqRSzPvx
7ZOvqAUeqcDfY4EiNLDc4Ol+q0lm5w==
=kOLF
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--

