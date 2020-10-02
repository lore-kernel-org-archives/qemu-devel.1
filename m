Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EE6C47423
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F822064B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F822064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOGmp-0000ts-8Q
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kOGjd-0007uF-0N; Fri, 02 Oct 2020 04:48:14 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kOGja-0004a3-Eu; Fri, 02 Oct 2020 04:48:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 841725803F7;
 Fri,  2 Oct 2020 04:48:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 02 Oct 2020 04:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=NleZoGEpq+9ky9YfmCELoSGaqjp
 tlF4a2o9ZrgakjfA=; b=dz3k9TAoCOnPj/mipsCQZtxDcdD6QRdnTg66zVlRVEy
 9SED3/GEHXHVso7+ek4DBnd6bAt2tAztS/u8y8o6IOF5A/HVHTZRJdya7W1EZmIG
 9T7H2aPH6zBNpKit3krJq9p+oAfgMq3Qdk4tVsVk/2GDEAbdQmolCkyVE9uZGFue
 nW3lN17l8TRDjWAX40uR6l+EIpi2UFUmXvBdWTPaYF/vWr/zGcQSrEJyVJbsFZxI
 NDhzLXbVv8kfqvO/8pVLQcSxR4xcQcmcsCjkrY5zgf7hOtw2zGzmrERtIhHKt9C6
 sMbx8+g6aIQjIM4ey6k25GBixIE17mK8kE+g6YuFRcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NleZoG
 Epq+9ky9YfmCELoSGaqjptlF4a2o9ZrgakjfA=; b=tghya2SJLRknvsEpaiKhj6
 75kyNrQVjDhU9XGyoY+GOPggOzL7cEqc1OsCUrqRXhVVJiT4lpzJ/S5gw5YUmn3L
 Wo7zwAJK1Z/KEHUIjfsxYlR/qLQEyBD6BT9FWIHN2ozB1Tk8b70LS2PdigTQsmQm
 6jDKe0IEgKTf4MBM/RXJwvw6loHxWhAW+PKKSQnZsW0DC6zQrTLcBg2t6a47eM6F
 8BWUCrrDFe9LR0cw8AN5wcu2morNVQ/dBtGni9pOLVNPNRPYJ6SoR7XTnWLGoP2p
 sJbRxoCMXxjpD7OYz/Kf0Jg4jb/kv6fX89FpQI2LKPoiix9lA4+mINRclZMqQSOw
 ==
X-ME-Sender: <xms:Rul2X8QfYCNZULF9J2kEC3KTNdC86kP5s2bGZXiGiSEND_Q1bdzWng>
 <xme:Rul2X5y6HfV1jM1ikWLe9ZjltV_2UMTOx2b9FU7aAey5msEMGkfhawB_vRjJS3Zqy
 rLLlvnPxyXI9NlI4JU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigddtlecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Rul2X530gFrayj_z8XtCq_xWiQ7PsMcmYlyaBco2bfspU-E8RudOpQ>
 <xmx:Rul2XwChTFA_mKu_ZjVX0qUJhwQnSpaisNtkV97SESzEyBg1paE4QA>
 <xmx:Rul2X1hRirHyCPiKGhgAnvraoZkngf1-E9gk2Ir6lndpy3ZxeMfngw>
 <xmx:R-l2XzZCEtMY2yukw-Bclq_-6m0PctkW-QWwpDOTCntidUKUaFLmFA>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 706EA306468B;
 Fri,  2 Oct 2020 04:48:05 -0400 (EDT)
Date: Fri, 2 Oct 2020 10:48:03 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/9] hw/block/nvme: support per-namespace smart log
Message-ID: <20201002084803.GB877411@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <20200930220414.562527-4-kbusch@kernel.org>
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 04:01:34
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


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 30 15:04, Keith Busch wrote:
> Let the user specify a specific namespace if they want to get access
> stats for a specific namespace.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c      | 66 +++++++++++++++++++++++++++-----------------
>  include/block/nvme.h |  1 +
>  2 files changed, 41 insertions(+), 26 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 8d2b5be567..41389b2b09 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
>  static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_l=
en,
>                                  uint64_t off, NvmeRequest *req)
>  {
>      uint32_t nsid =3D le32_to_cpu(req->cmd.nsid);
> -
> +    struct nvme_stats stats =3D { 0 };
> +    NvmeSmartLog smart =3D { 0 };
>      uint32_t trans_len;
> +    NvmeNamespace *ns;
>      time_t current_ms;
> -    uint64_t units_read =3D 0, units_written =3D 0;
> -    uint64_t read_commands =3D 0, write_commands =3D 0;
> -    NvmeSmartLog smart;
> -
> -    if (nsid && nsid !=3D 0xffffffff) {
> -        return NVME_INVALID_FIELD | NVME_DNR;
> -    }
> =20
>      if (off >=3D sizeof(smart)) {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> -    for (int i =3D 1; i <=3D n->num_namespaces; i++) {
> -        NvmeNamespace *ns =3D nvme_ns(n, i);
> -        if (!ns) {
> -            continue;
> -        }
> -
> -        BlockAcctStats *s =3D blk_get_stats(ns->blkconf.blk);
> +    if (nsid !=3D 0xffffffff) {
> +        ns =3D nvme_ns(n, nsid);
> +        if (!ns)
> +            return NVME_INVALID_NSID | NVME_DNR;

Btw, this is failing style check (missing braces).

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl926UEACgkQTeGvMW1P
DekAeAf1FVoybPx077ScM+ggh1f8lgbaSNLU29uLaswE2G18zqVDYMzjoZ+sqkAn
aG4h+R6erXe1BDhMkZXcNk+VrrJb3SbBw9HPdFmDgRFLQHmSxtywm/KWqp/CN6+y
3yLfMoPXJD7TU4L6KWaSitGMlEYhxK1j4zyHyeYshxIj4befmGS2aoc6jWmDsm44
UrZ/1+XMVewLXNsYTfs/gqQBS3U1TDUK2gGGOpAlrV//5DoRMbvJhmygGPyfoPQr
pZRNAvOkKvXRF0AErn/rs5Q2ouerv5qYNIMsxZhmcwtOt7q0y/HaHDZTXKw6YBXm
B7zJWmpfLMI9v0ulIe90HCSDTq0s
=5nmX
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--

