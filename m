Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3750BC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 22:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747CE20738
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 22:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747CE20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO6vz-00024A-Tj
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 18:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kO6rS-0001M5-GF; Thu, 01 Oct 2020 18:15:38 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kO6rL-0006DB-3i; Thu, 01 Oct 2020 18:15:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 88DB258037F;
 Thu,  1 Oct 2020 18:15:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 01 Oct 2020 18:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=VLz1KqoNzlvjJUj3Qlz2TyBtgjb
 FurZ8RBsakM0WISA=; b=KEyBb2zBwIFx8HSj+G6eZHsD2CrGQ4+PvnHtxSnaFYm
 lJyH6pIMKdQG58D7Q36K6aYeBZIpvyMw2/EUW7XjklSGQSEcHfc1E82JpGn3j+Nu
 UQ/07JWCbPNijvymv6T46lZPdAcnIB2BihX1r+FDl5WUUmFQ9Qp/pBaz5rEjDa2A
 LIr3mde7Orr1oOH1Mfuv7AiQsRoRLq/ncCTMTLUqeQOe63hLHiQFEHIrG9ojD3ZE
 pWPzmjOTQGwbakOmFb3Tk0MxFiHN/IlslVuKty7sdlAwin+SV2WvtNjZ6XHpEW7v
 znSMNhfq/kkLY8hD51WIPR5rAr6GJ8HyQPAtooOfmGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=VLz1Kq
 oNzlvjJUj3Qlz2TyBtgjbFurZ8RBsakM0WISA=; b=BM93O6jxeExQiOnurop7jP
 HWJvMuh7ymVKBMaFN16As7c0BGC2MDiOKvlE93fClawJcxTDehNTBYqhzAkMrxZa
 IaGFFbXKOlyB/YeAecsFlAtNXnqrEbuEctw4yBvUkO0KWO7uiANrK31BGgxmJsQX
 tTlixPm3E+gve1IKKXlgiYHjMPQh/0O2a1Eu/GvV1fS4OJcmZWxV6gU1iBR7PFI0
 KDpsF9GL8rdFmJBmouBFdR1QZd2gs2FUW5vPiKIgP5CMdfopytWm/zqELtL38mGy
 xtOncsJcYkf6ozM52rwnN7BKLnug2ZSvFvevLJ5R/570tMjhh/dWgUTKNFm9ZQag
 ==
X-ME-Sender: <xms:_1R2X8KSHQF2Sq2XG5fLEipXEJTxKU-x2TSMRJHvxl51hZwxhqcDpQ>
 <xme:_1R2X8LkP9rNKMZV-2eox6EezHzgxT6YcRKoRo_NGBWAfysxFeY0vEhuTDouncWIe
 vygniSBUW4mgLPtKJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeehgddtfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepfeefgfdvleeitdehhfevffegleduieffgfdujeeuhfeluddthffgjeegkefhkedt
 necuffhomhgrihhnpehuuhhiugdruggrthgrnecukfhppeektddrudeijedrleekrddule
 dtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihht
 shesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:_1R2X8sK82rloFZlH9id2a3tV3bT6bAfr5tISZMKz4aWXLnWOXOHCQ>
 <xmx:_1R2X5ZmNSehKCJYde6VkZsXLtaaAiM4EiDHrkzjuRVwnQF1efj2sA>
 <xmx:_1R2XzY2c45XFcXS1Iqs-rcgyWXhsOyZVHH8MLSZxVIqmNOjDVK_vQ>
 <xmx:AFV2XxA8_92KxF1dbOjuN53r9C3r3ajmr5AJBmKT36xs3dyPcrgsw0rYHa8>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4BF8B3064674;
 Thu,  1 Oct 2020 18:15:23 -0400 (EDT)
Date: Fri, 2 Oct 2020 00:15:20 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Message-ID: <20201001221520.GA841624@apples.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-6-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20200928023528.15260-6-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 17:51:05
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


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 28 11:35, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Namespace Types introduce a new command set, "I/O Command Sets",
> that allows the host to retrieve the command sets associated with
> a namespace. Introduce support for the command set and enable
> detection for the NVM Command Set.
>=20
> The new workflows for identify commands rely heavily on zero-filled
> identify structs. E.g., certain CNS commands are defined to return
> a zero-filled identify struct when an inactive namespace NSID
> is supplied.
>=20
> Add a helper function in order to avoid code duplication when
> reporting zero-filled identify structures.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme-ns.c |   3 +
>  hw/block/nvme.c    | 210 +++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 175 insertions(+), 38 deletions(-)
>=20
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index bbd7879492..31b7f986c3 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c

The following looks like a rebase gone wrong.

There are some redundant checks and wrong return values.

>  static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *re=
q)
>  {
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> +    NvmeNamespace *ns;
>      uint32_t nsid =3D le32_to_cpu(c->nsid);
> -    uint8_t list[NVME_IDENTIFY_DATA_SIZE];
> -
> -    struct data {
> -        struct {
> -            NvmeIdNsDescr hdr;
> -            uint8_t v[16];
> -        } uuid;
> -    };
> -
> -    struct data *ns_descrs =3D (struct data *)list;
> +    NvmeIdNsDescr *desc;
> +    uint8_t list[NVME_IDENTIFY_DATA_SIZE] =3D {};
> +    static const int data_len =3D sizeof(list);
> +    void *list_ptr =3D list;

Oh maaan, please do not replace my nicely cleaned up code with pointer
arithmetics :(

> =20
>      trace_pci_nvme_identify_ns_descr_list(nsid);
> =20
> -    if (!nvme_nsid_valid(n, nsid) || nsid =3D=3D NVME_NSID_BROADCAST) {
> -        return NVME_INVALID_NSID | NVME_DNR;
> -    }
> -

This removal looks wrong.

>      if (unlikely(!nvme_ns(n, nsid))) {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> -    memset(list, 0x0, sizeof(list));
> +    ns =3D nvme_ns(n, nsid);
> +    if (unlikely(!ns)) {
> +        return nvme_rpt_empty_id_struct(n, req);
> +    }
> =20

And this doesnt look like it belongs (its checked just a few lines
before, and it returns an error status as it should).

>      /*
>       * Because the NGUID and EUI64 fields are 0 in the Identify Namespac=
e data
> @@ -1597,12 +1667,31 @@ static uint16_t nvme_identify_ns_descr_list(NvmeC=
trl *n, NvmeRequest *req)
>       * Namespace Identification Descriptor. Add a very basic Namespace U=
UID
>       * here.
>       */
> -    ns_descrs->uuid.hdr.nidt =3D NVME_NIDT_UUID;
> -    ns_descrs->uuid.hdr.nidl =3D NVME_NIDL_UUID;
> -    stl_be_p(&ns_descrs->uuid.v, nsid);
> +    desc =3D list_ptr;
> +    desc->nidt =3D NVME_NIDT_UUID;
> +    desc->nidl =3D NVME_NIDL_UUID;
> +    list_ptr +=3D sizeof(*desc);
> +    memcpy(list_ptr, ns->params.uuid.data, NVME_NIDL_UUID);
> +    list_ptr +=3D NVME_NIDL_UUID;
> =20
> -    return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
> -                    DMA_DIRECTION_FROM_DEVICE, req);
> +    desc =3D list_ptr;
> +    desc->nidt =3D NVME_NIDT_CSI;
> +    desc->nidl =3D NVME_NIDL_CSI;
> +    list_ptr +=3D sizeof(*desc);
> +    *(uint8_t *)list_ptr =3D NVME_CSI_NVM;
> +
> +    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
> +}
> +


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl92VPYACgkQTeGvMW1P
DeksFAf8Co61TeUCBEFv/M+IZyBAu22zArHxUNscJ7sytzAzSMaQM2XklCiHu5HF
FChz+qH8u6owipxAXBWKv6D4QLa4+laRKb8Ek/7mKcHGqFIbqgbBKxX6U0D55/ix
EdwrUwxj7gnaNzrDg6nu0Mc83GmyOgoKbzi0mImWa+gfzeF8dVqfkpWqOCbGp7YE
5r49UpXSRYOplBwb0SRl077sMYmqzPLsKRgNF8e8RNuj9EFFk0WNA41HBm+VPbGL
kmqAN0qBdwkLoMygzwPOWeVqKcthQJcLb1Pa5mv0Vq84ESZQlAXOkc9yUUzjkeWT
4Hu2i4dwp/zCq2vKRPUt3NnGcC0Qkg==
=h6e0
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

