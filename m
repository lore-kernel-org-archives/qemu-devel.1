Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20EBC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 04:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C3221D80
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 04:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C3221D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNq0a-0006mL-OZ
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 00:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNpvu-0004Bh-Cp; Thu, 01 Oct 2020 00:11:06 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:56265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNpvs-0005cf-9O; Thu, 01 Oct 2020 00:11:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 0F9AE9F4;
 Thu,  1 Oct 2020 00:11:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 01 Oct 2020 00:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=V5qn81fy5hcqW5b6aWQxaDF9pGX
 mcDYrzOMFp+RQbRI=; b=n0YQw0/eT0ZjZVBYXUm3Ji0nt7dwHTOWoekYFZiEzPX
 LozY4NRz73YVoNZGOeIyJkRZifxv2e8Mwvd4JKo20+vfSQJ5w9n8HJD+bDv56jLl
 z6s4VOhl20me1W0F33udz5/Aoman/EkOWmcJrsQSEM7mdk/OD+3zWEkmt8w9jv0S
 ROZjPsMMbdTzbT6lJhg29EiSJFwWad41+1Ld5kqSz1Lts3h/pVJ4VEwB29OQyOdn
 W0fuLTvDdleohZFhfWE6S/CcKUrgaRf8kpZ/LcYsqW9O/G8EyhbhsbznHf1xz0SG
 jJ3jLodt+OrSQdZ3Lr8LVnHXWlTRMiJANKTChEkZntw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=V5qn81
 fy5hcqW5b6aWQxaDF9pGXmcDYrzOMFp+RQbRI=; b=sn8V1ZrOgfLRNjuvftmv/8
 kHTrdLLag57PG8qRNQ7G4fc3uOi1rffMtsalwBICUiW/zGQ/ZzNj1g054uXegNn5
 0DKZDq7PRFLToTngAuq/lo+wYpjMljTJhDpG7318QUpnFJrM2TcYortlObBQvMyC
 ozjCiFeA7/GlFf7TjOOKSJbVcCqnhiYu40aCUiCpWZ2d8XO113OdWMTJQmDZVg+y
 pRnngHQqJ1RVc5e2g3VippP6d0bLfM3siW5QA3q2d56CwQ6kT81nmMSwQ2OJQTO1
 lVHhav1BUAWGu5/WZPsLG069z2KNCiT6Xx7vWRgmbw8BcZ6Lp/9T4Sgvdl6OhOfQ
 ==
X-ME-Sender: <xms:1FZ1X0oiEa8c6j6uqyWqflMZzYdIuQAvfzAIbVznxc6RYQlpB-BnFw>
 <xme:1FZ1X6oxSP8oL-xKeVJq680FbyYxe-mEwcjS6l2w6vgh8uOUyrKgjLc5G6CUVFVuP
 zmahd4zbgVcXh2DkQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdekvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:1FZ1X5M5dLoqeVnFQoyZEfLTj62S9sOPI_iViE9ymEwU5AUL-_jovA>
 <xmx:1FZ1X74BnqE-sY7VYekSb_f8_dlq70ULTV3MTJcRCY5qBdb-AMeCrw>
 <xmx:1FZ1Xz42Q2Hv2M4jSrJB8Ddn64ZpqHoRNLTXgAzK_0-pdfUAgyKmWw>
 <xmx:1VZ1X5Qm0DsYaZU40Jh0PIM7bLUnip4_ejMJniTwiLGcptxkZnS80D6QoyY>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7F030328005A;
 Thu,  1 Oct 2020 00:10:59 -0400 (EDT)
Date: Thu, 1 Oct 2020 06:10:57 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/9] hw/block/nvme: support per-namespace smart log
Message-ID: <20201001041057.GC681387@apples.localdomain>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <20200930220414.562527-4-kbusch@kernel.org>
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


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 30 15:04, Keith Busch wrote:
> Let the user specify a specific namespace if they want to get access
> stats for a specific namespace.
>=20

I don't think this makes sense for v1.3+.

NVM Express v1.3d, Section 5.14.1.2: "There is no namespace specific
information defined in the SMART / Health log page in this revision of
the specification.  therefore the controller log page and namespace
specific log page contain identical information".

I have no idea why the TWG decided this, but that's the way it is ;)

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
> @@ -1164,48 +1164,62 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeR=
equest *req)
>      return NVME_SUCCESS;
>  }
> =20
> +struct nvme_stats {
> +    uint64_t units_read;
> +    uint64_t units_written;
> +    uint64_t read_commands;
> +    uint64_t write_commands;
> +};
> +
> +static void nvme_set_blk_stats(NvmeNamespace *ns, struct nvme_stats *sta=
ts)
> +{
> +    BlockAcctStats *s =3D blk_get_stats(ns->blkconf.blk);
> +
> +    stats->units_read +=3D s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_B=
ITS;
> +    stats->units_written +=3D s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECT=
OR_BITS;
> +    stats->read_commands +=3D s->nr_ops[BLOCK_ACCT_READ];
> +    stats->write_commands +=3D s->nr_ops[BLOCK_ACCT_WRITE];
> +}
> +
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
> +        nvme_set_blk_stats(ns, &stats);
> +    } else {
> +        int i;
> =20
> -        units_read +=3D s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
> -        units_written +=3D s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_=
BITS;
> -        read_commands +=3D s->nr_ops[BLOCK_ACCT_READ];
> -        write_commands +=3D s->nr_ops[BLOCK_ACCT_WRITE];
> +        for (i =3D 1; i <=3D n->num_namespaces; i++) {
> +            ns =3D nvme_ns(n, i);
> +            if (!ns) {
> +                continue;
> +            }
> +            nvme_set_blk_stats(ns, &stats);
> +        }
>      }
> =20
>      trans_len =3D MIN(sizeof(smart) - off, buf_len);
> =20
> -    memset(&smart, 0x0, sizeof(smart));
> -
> -    smart.data_units_read[0] =3D cpu_to_le64(DIV_ROUND_UP(units_read, 10=
00));
> -    smart.data_units_written[0] =3D cpu_to_le64(DIV_ROUND_UP(units_writt=
en,
> +    smart.data_units_read[0] =3D cpu_to_le64(DIV_ROUND_UP(stats.units_re=
ad,
> +                                                        1000));
> +    smart.data_units_written[0] =3D cpu_to_le64(DIV_ROUND_UP(stats.units=
_written,
>                                                             1000));
> -    smart.host_read_commands[0] =3D cpu_to_le64(read_commands);
> -    smart.host_write_commands[0] =3D cpu_to_le64(write_commands);
> +    smart.host_read_commands[0] =3D cpu_to_le64(stats.read_commands);
> +    smart.host_write_commands[0] =3D cpu_to_le64(stats.write_commands);
> =20
>      smart.temperature =3D cpu_to_le16(n->temperature);
> =20
> @@ -2708,7 +2722,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *=
pci_dev)
>      id->acl =3D 3;
>      id->aerl =3D n->params.aerl;
>      id->frmw =3D (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
> -    id->lpa =3D NVME_LPA_EXTENDED;
> +    id->lpa =3D NVME_LPA_NS_SMART | NVME_LPA_EXTENDED;
> =20
>      /* recommended default value (~70 C) */
>      id->wctemp =3D cpu_to_le16(NVME_TEMPERATURE_WARNING);
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 58647bcdad..868cf53f0b 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -849,6 +849,7 @@ enum NvmeIdCtrlFrmw {
>  };
> =20
>  enum NvmeIdCtrlLpa {
> +    NVME_LPA_NS_SMART =3D 1 << 0,
>      NVME_LPA_EXTENDED =3D 1 << 2,
>  };
> =20
> --=20
> 2.24.1
>=20
>=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl91VtAACgkQTeGvMW1P
DenkAggAsKWLVOl3GWF0KxejR/XxNtknFyOVsoKNsAdbJ7C5sLSfqDfhCFLXPsPt
P7yMIbYK9dXMvdhoEx1wi1bRcXPIYP64pbubrX9AvhlhR5kWFbGqUcg8q566j1dB
WqMktrx8WPalij2nhD5ObPaSO3+mqIkOw7cIP2thb+Ra5FGM6qIbpAjLQYzGoGQm
acuXRpWPUQnB0Z8po7dZoh0Civn+LPucvI1WRJFtSLlVWQPjfT8GxoIiygKZtGfR
IbhlET/OhBpn04s0N9Q2sAiINoRXZ6qfV2X+ib3BP7D8XcV8DxqYxmkwp3Soq5k+
j0Z85f5TYuXiYuuoWT4mNvk5xnEwkg==
=xh/D
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--

