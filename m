Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDAAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731EA20878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731EA20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfDK-0002ku-4q
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf9H-0000vP-QI; Wed, 14 Oct 2020 07:40:51 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:33959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf9F-0007dY-Ad; Wed, 14 Oct 2020 07:40:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 2195C580352;
 Wed, 14 Oct 2020 07:40:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 07:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=FD7phjCrJiW9KBqvLtjQkWR4wzj
 oTIDJFn74Lv2XTik=; b=BA3JtwkC2edWqol0l7lv8iE2v7/NcPBZcO6LyFzdLr4
 aAa6vimxgcMDwoYO+2iEu/hVHFcW7NxqjTQt3Op9WrCqsrT+tKNQ0azPN4xE+TNB
 ndr6eswtjC5Km+pJ+DsTAeMgWcR6GEr3zpiwK8c3cp6UeAarnmcV/vqC4dpDgJ2G
 4eq5hnyvm/qxhE1yTL5O42n8+CAFPWzAA9yIBMxuDPfBKBN68pq6PWImCh+GBAzy
 KlW9ZEXOnSGHyXILuN8ymy9vhTyHi+llRXXzOjE++yhyPHtEVb5+8/HxFYON59mB
 ojA+p19CXjqrI7Oc8Ptp7ITMRCGNLJKfEM9DsH3UB9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FD7phj
 CrJiW9KBqvLtjQkWR4wzjoTIDJFn74Lv2XTik=; b=nBSuW4gm88rlC6ncSsv20v
 Dr5U9MHkNgidOmeyAldg/XIzxnbs+ud+cwe0STtS1rGojPYvRcGCkFj1xUrzRitn
 1y5ey9y00pEUVsYeJxbIzZar971g/bqPiCC9DHMz7661YXGwPS55Nm6m8zNHjITF
 ZSLIdopqEHBzcOiLTfLR8tIMimG7UvoX9zteGbgqFUauJSzOSomqlP4iPze1iwkM
 f+vhL+FGh2eYckV7OX4pwYYEGhMMp+4hvdcXq/pZz+BS/GaVqLl0DMaFKqJuhJ1o
 Yv4+F2nabKbA6YkFByzCq9kyh4zxq8oxjlfX/QUhKT1A7gbiNYvo0OfvRc5K7Umg
 ==
X-ME-Sender: <xms:vuOGX1aG6JDAukS_J3C9XPEJTnIrwgSv3IU1YOh5_8nOmZX9u02_MQ>
 <xme:vuOGX8aS8E6FX3IvPvSuOTBtwW1RXyecBAx0TodZAeuVf0tsvF3wXJMRTCKX3xoqo
 Ic5mujjJ-M4jcgeMak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugdegvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepfeefgfdvleeitdehhfevffegleduieffgfdujeeuhfeluddthffgjeegkefhkedt
 necuffhomhgrihhnpehuuhhiugdruggrthgrnecukfhppeektddrudeijedrleekrddule
 dtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihht
 shesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:vuOGX3-6NLo8ruGZXyukvnrqldF24NcmAOh3jDOabCoyWveT55YWCA>
 <xmx:vuOGXzru-Pv13NiL_egPLwl785F-rY5j_9D1A1kWFPviQ32-jXddTg>
 <xmx:vuOGXwpPwRR17Kzk31B3Z3EGEj7S-AqXeUzxRUDf2ubPp9QoB0xJbw>
 <xmx:v-OGX1RfpVcOABHF8qXhXpJ-ze4EOQwaZlpxBxkmXSVPwkItzZOqCb7Jn1c>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B34943280064;
 Wed, 14 Oct 2020 07:40:44 -0400 (EDT)
Date: Wed, 14 Oct 2020 13:40:42 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v6 02/11] hw/block/nvme: Generate namespace UUIDs
Message-ID: <20201014114042.GA357831@apples.localdomain>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
 <20201013214212.2152-3-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20201013214212.2152-3-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 07:31:27
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


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 14 06:42, Dmitry Fomichev wrote:
> In NVMe 1.4, a namespace must report an ID descriptor of UUID type
> if it doesn't support EUI64 or NGUID. Add a new namespace property,
> "uuid", that provides the user the option to either specify the UUID
> explicitly or have a UUID generated automatically every time a
> namespace is initialized.
>=20
> Suggested-by: Klaus Jansen <its@irrelevant.dk>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/block/nvme-ns.c | 1 +
>  hw/block/nvme-ns.h | 1 +
>  hw/block/nvme.c    | 9 +++++----
>  3 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index b69cdaf27e..de735eb9f3 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -129,6 +129,7 @@ static void nvme_ns_realize(DeviceState *dev, Error *=
*errp)
>  static Property nvme_ns_props[] =3D {
>      DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
>      DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
> +    DEFINE_PROP_UUID("uuid", NvmeNamespace, params.uuid),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> index ea8c2f785d..a38071884a 100644
> --- a/hw/block/nvme-ns.h
> +++ b/hw/block/nvme-ns.h
> @@ -21,6 +21,7 @@
> =20
>  typedef struct NvmeNamespaceParams {
>      uint32_t nsid;
> +    QemuUUID uuid;
>  } NvmeNamespaceParams;
> =20
>  typedef struct NvmeNamespace {
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index ee0eff98da..89d91926d9 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1571,6 +1571,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, N=
vmeRequest *req)
> =20
>  static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *re=
q)
>  {
> +    NvmeNamespace *ns;
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
>      uint32_t nsid =3D le32_to_cpu(c->nsid);
>      uint8_t list[NVME_IDENTIFY_DATA_SIZE];
> @@ -1590,7 +1591,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtr=
l *n, NvmeRequest *req)
>          return NVME_INVALID_NSID | NVME_DNR;
>      }
> =20
> -    if (unlikely(!nvme_ns(n, nsid))) {
> +    ns =3D nvme_ns(n, nsid);
> +    if (unlikely(!ns)) {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> @@ -1599,12 +1601,11 @@ static uint16_t nvme_identify_ns_descr_list(NvmeC=
trl *n, NvmeRequest *req)
>      /*
>       * Because the NGUID and EUI64 fields are 0 in the Identify Namespac=
e data
>       * structure, a Namespace UUID (nidt =3D 0x3) must be reported in the
> -     * Namespace Identification Descriptor. Add a very basic Namespace U=
UID
> -     * here.
> +     * Namespace Identification Descriptor. Add the namespace UUID here.
>       */
>      ns_descrs->uuid.hdr.nidt =3D NVME_NIDT_UUID;
>      ns_descrs->uuid.hdr.nidl =3D NVME_NIDT_UUID_LEN;
> -    stl_be_p(&ns_descrs->uuid.v, nsid);
> +    memcpy(&ns_descrs->uuid.v, ns->params.uuid.data, NVME_NIDT_UUID_LEN);
> =20
>      return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
>                      DMA_DIRECTION_FROM_DEVICE, req);
> --=20
> 2.21.0
>=20
>=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+G47cACgkQTeGvMW1P
DenmWQgAqWMapDNMkp8FgOk7gf1Zkj3zo8AMJmBPNidBfBgzQtvaP/L/S/WSeo/6
22H4U96o6B8G23LgBxgFZECaUAHrYzM8tE+y0GlUhVypDrC1T20aT3prnUUME8Qk
ma1s71wISovf98pr+3P4Q6y+fna4Vi8iRSOn+XriuWhREZ7EM+KFPMorMA768bu/
OVazwurBSRAU2NjAuYAeZLNXH/RdxvkG3N9WTr4o8ZKTQK+4M88EE5fT/Srs0cNF
Ra1iZAgjDbtydq/U64E81ec5P0RXYgAEafSjC1lGmW9q1jTc1VSHDnclgJTjohR0
kewpjdWH7tuhPcElKZOXghWagHkizA==
=0DON
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

