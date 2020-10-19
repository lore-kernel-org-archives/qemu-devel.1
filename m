Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FFAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9596921741
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9596921741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUcEK-0005mn-7k
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 16:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUcAD-0004Cw-FH; Mon, 19 Oct 2020 16:53:53 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:41543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUcAA-0006oq-FD; Mon, 19 Oct 2020 16:53:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id CA3E9CF6;
 Mon, 19 Oct 2020 16:53:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 19 Oct 2020 16:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=Tl8dmI7tbDqzhqrcdUalUBXTWzj
 sKMw0ohyaBwZfSBc=; b=IBqO4ifg2o4JyWQREzfhyFIc4PBv9ZwMgyBELhvu9GR
 TANCdvFxBKqJb/bYhGlcFgsnTeKzPTmCE+S4ueuarVprUF4pPI90nCjABPEpgu4+
 MkIEOCZaRMpz7D7iOZ83xq5cbrQbbZnOObIaDvMJphXkW6oRw3WXytfWOIpAHi5O
 lhiF37lbHQc+b8BoGTk+ktdEYuo3SYEeqKUlJaQ26BXxtrifRGU+YZfZzotfKFUj
 /5eWhL7ddfnvVD5Hx4989U7fCzoaj5vgo+GqFhuqReXD2Nc223VBpY4jn7d93rW4
 9kFWGoVkdJ27/emhJ8fx8XLriyKMTkacFGFqu6XAZjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Tl8dmI
 7tbDqzhqrcdUalUBXTWzjsKMw0ohyaBwZfSBc=; b=CoHilR+8CySbMKL2JDSmN9
 SLRHwjUZkJhqIQW8kMR37hdUvVa6rf8PytVFJwXZtlzoWh3LZ4BDEAiEmThNqKsB
 vBmcj8IsXuDwK8DQjLoNtkGZSUvHyZYzN8y4gndBoaRp09yYUqg43CbTaBljnx+P
 J+eR4mS68czkiibiwUTl0ctmXL4l/0M3SyEtquf0ltY51rTe/VKU+4idEQl7xLZc
 fRLCm53Zw7D7hw1clby8FyTRYxBbXmvZk41nc0f/gVPifqthp2Scwfrg377xibCl
 m6k6Jf2nWzQHghd1QXZJuK/ZFkJJ5YIrzQ8+xknDITcD3Z8ZbECvsZLjmYoUKC0A
 ==
X-ME-Sender: <xms:1fyNX3O5K8h_cl4xD7gOF2uaPIKix_mz3p8I8nHkoE4VD5TP5c40RA>
 <xme:1fyNXx9kNXvrilKPAZcDxiO7HtDtqJk4kZLW1ckxx6RxwQ_t7X-l6RC2CYBT7VSfn
 0pKJeWx-Eiw5WJ4J6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedvgddulecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepfeefgfdvleeitdehhfevffegleduieffgfdujeeuhfeluddthffgjeegkefhkedt
 necuffhomhgrihhnpehuuhhiugdruggrthgrnecukfhppeektddrudeijedrleekrddule
 dtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihht
 shesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:1fyNX2TTo5MxUoNWNLXWEH5cxcCE3LvUaLmunIIi5S_2gzcnDACgDQ>
 <xmx:1fyNX7tFwOltQV6VccZ0NOwOP0kqnhVpNup1ELlUvwRFqK8t3tlOsg>
 <xmx:1fyNX_d2K_Thi-mMkf0LrYZnfyWYak8IOFHh4UuAncNLzMNQgPKZUA>
 <xmx:1_yNX32ZHpnfJvJMglarydSa_7r_ooK2MtkwCoJKJn5aQP1CnLySO6EO8LiHu1JQ>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 003F7306467D;
 Mon, 19 Oct 2020 16:53:39 -0400 (EDT)
Date: Mon, 19 Oct 2020 22:53:38 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v7 03/11] hw/block/nvme: Add support for Namespace Types
Message-ID: <20201019205338.GI10549@apples.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-4-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Content-Disposition: inline
In-Reply-To: <20201019021726.12048-4-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 16:53:44
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


--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 11:17, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Define the structures and constants required to implement
> Namespace Types support.
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
>  hw/block/nvme-ns.c    |   2 +
>  hw/block/nvme-ns.h    |   1 +
>  hw/block/nvme.c       | 169 +++++++++++++++++++++++++++++++++++-------
>  hw/block/trace-events |   7 ++
>  include/block/nvme.h  |  65 ++++++++++++----
>  5 files changed, 202 insertions(+), 42 deletions(-)
>=20
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index de735eb9f3..c0362426cc 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -41,6 +41,8 @@ static void nvme_ns_init(NvmeNamespace *ns)
> =20
>      id_ns->nsze =3D cpu_to_le64(nvme_ns_nlbas(ns));
> =20
> +    ns->csi =3D NVME_CSI_NVM;
> +
>      /* no thin provisioning */
>      id_ns->ncap =3D id_ns->nsze;
>      id_ns->nuse =3D id_ns->ncap;
> diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> index a38071884a..d795e44bab 100644
> --- a/hw/block/nvme-ns.h
> +++ b/hw/block/nvme-ns.h
> @@ -31,6 +31,7 @@ typedef struct NvmeNamespace {
>      int64_t      size;
>      NvmeIdNs     id_ns;
>      const uint32_t *iocs;
> +    uint8_t      csi;
> =20
>      NvmeNamespaceParams params;
>  } NvmeNamespace;
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 29139d8a17..ca0d0abf5c 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1503,6 +1503,13 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRe=
quest *req)
>      return NVME_SUCCESS;
>  }
> =20
> +static uint16_t nvme_rpt_empty_id_struct(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint8_t id[NVME_IDENTIFY_DATA_SIZE] =3D {};

[-pedantic] empty initializer list

> +
> +    return nvme_dma(n, id, sizeof(id), DMA_DIRECTION_FROM_DEVICE, req);
> +}
> +
>  static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
>  {
>      trace_pci_nvme_identify_ctrl();
> @@ -1511,11 +1518,23 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, N=
vmeRequest *req)
>                      DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
> +static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> +
> +    trace_pci_nvme_identify_ctrl_csi(c->csi);
> +
> +    if (c->csi =3D=3D NVME_CSI_NVM) {
> +        return nvme_rpt_empty_id_struct(n, req);
> +    }
> +
> +    return NVME_INVALID_FIELD | NVME_DNR;
> +}
> +
>  static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeNamespace *ns;
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> -    NvmeIdNs *id_ns, inactive =3D { 0 };
>      uint32_t nsid =3D le32_to_cpu(c->nsid);
> =20
>      trace_pci_nvme_identify_ns(nsid);
> @@ -1526,23 +1545,46 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, Nvm=
eRequest *req)
> =20
>      ns =3D nvme_ns(n, nsid);
>      if (unlikely(!ns)) {
> -        id_ns =3D &inactive;
> -    } else {
> -        id_ns =3D &ns->id_ns;
> +        return nvme_rpt_empty_id_struct(n, req);
>      }
> =20
> -    return nvme_dma(n, (uint8_t *)id_ns, sizeof(NvmeIdNs),
> +    return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
>                      DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
> +static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeNamespace *ns;
> +    NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> +    uint32_t nsid =3D le32_to_cpu(c->nsid);
> +
> +    trace_pci_nvme_identify_ns_csi(nsid, c->csi);
> +
> +    if (!nvme_nsid_valid(n, nsid) || nsid =3D=3D NVME_NSID_BROADCAST) {
> +        return NVME_INVALID_NSID | NVME_DNR;
> +    }
> +
> +    ns =3D nvme_ns(n, nsid);
> +    if (unlikely(!ns)) {
> +        return nvme_rpt_empty_id_struct(n, req);
> +    }
> +
> +    if (c->csi =3D=3D NVME_CSI_NVM) {
> +        return nvme_rpt_empty_id_struct(n, req);
> +    }
> +
> +    return NVME_INVALID_FIELD | NVME_DNR;
> +}
> +
>  static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
>  {
> +    NvmeNamespace *ns;
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> -    static const int data_len =3D NVME_IDENTIFY_DATA_SIZE;
>      uint32_t min_nsid =3D le32_to_cpu(c->nsid);
> -    uint32_t *list;
> -    uint16_t ret;
> -    int j =3D 0;
> +    uint8_t list[NVME_IDENTIFY_DATA_SIZE] =3D {};

[-pedantic] empty initializer list

> +    static const int data_len =3D sizeof(list);
> +    uint32_t *list_ptr =3D (uint32_t *)list;
> +    int i, j =3D 0;
> =20
>      trace_pci_nvme_identify_nslist(min_nsid);
> =20
> @@ -1556,20 +1598,54 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n,=
 NvmeRequest *req)
>          return NVME_INVALID_NSID | NVME_DNR;
>      }
> =20
> -    list =3D g_malloc0(data_len);
> -    for (int i =3D 1; i <=3D n->num_namespaces; i++) {
> -        if (i <=3D min_nsid || !nvme_ns(n, i)) {
> +    for (i =3D 1; i <=3D n->num_namespaces; i++) {
> +        ns =3D nvme_ns(n, i);
> +        if (!ns) {
>              continue;
>          }
> -        list[j++] =3D cpu_to_le32(i);
> +        if (ns->params.nsid < min_nsid) {

Since i =3D=3D ns->params.nsid, this should be '<=3D' like the code you
removed. It really shouldn't be called min_nsid, but oh well.

> +            continue;
> +        }
> +        list_ptr[j++] =3D cpu_to_le32(ns->params.nsid);
>          if (j =3D=3D data_len / sizeof(uint32_t)) {
>              break;
>          }
>      }
> -    ret =3D nvme_dma(n, (uint8_t *)list, data_len, DMA_DIRECTION_FROM_DE=
VICE,
> -                   req);
> -    g_free(list);
> -    return ret;
> +
> +    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
> +}
> +
> +static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeNamespace *ns;
> +    NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> +    uint32_t min_nsid =3D le32_to_cpu(c->nsid);
> +    uint8_t list[NVME_IDENTIFY_DATA_SIZE] =3D {};
> +    static const int data_len =3D sizeof(list);
> +    uint32_t *list_ptr =3D (uint32_t *)list;
> +    int i, j =3D 0;
> +
> +    trace_pci_nvme_identify_nslist_csi(min_nsid, c->csi);
> +
> +    if (c->csi !=3D NVME_CSI_NVM) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +

This is missing the check for 0xffffffff and 0xfffffffe like above.

> +    for (i =3D 1; i <=3D n->num_namespaces; i++) {
> +        ns =3D nvme_ns(n, i);
> +        if (!ns) {
> +            continue;
> +        }
> +        if (ns->params.nsid < min_nsid) {

Should be '<=3D'.

> +            continue;
> +        }
> +        list_ptr[j++] =3D cpu_to_le32(ns->params.nsid);
> +        if (j =3D=3D data_len / sizeof(uint32_t)) {
> +            break;
> +        }
> +    }
> +
> +    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
>  static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *re=
q)
> @@ -1577,13 +1653,17 @@ static uint16_t nvme_identify_ns_descr_list(NvmeC=
trl *n, NvmeRequest *req)
>      NvmeNamespace *ns;
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
>      uint32_t nsid =3D le32_to_cpu(c->nsid);
> -    uint8_t list[NVME_IDENTIFY_DATA_SIZE];
> +    uint8_t list[NVME_IDENTIFY_DATA_SIZE] =3D {};

[-pedantic] empty initializer list

> =20
>      struct data {
>          struct {
>              NvmeIdNsDescr hdr;
> -            uint8_t v[16];
> +            uint8_t v[NVME_NIDL_UUID];
>          } uuid;
> +        struct {
> +            NvmeIdNsDescr hdr;
> +            uint8_t v;
> +        } csi;
>      };
> =20
>      struct data *ns_descrs =3D (struct data *)list;
> @@ -1599,19 +1679,31 @@ static uint16_t nvme_identify_ns_descr_list(NvmeC=
trl *n, NvmeRequest *req)
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> -    memset(list, 0x0, sizeof(list));
> -
>      /*
>       * Because the NGUID and EUI64 fields are 0 in the Identify Namespac=
e data
>       * structure, a Namespace UUID (nidt =3D 0x3) must be reported in the
>       * Namespace Identification Descriptor. Add the namespace UUID here.
>       */
>      ns_descrs->uuid.hdr.nidt =3D NVME_NIDT_UUID;
> -    ns_descrs->uuid.hdr.nidl =3D NVME_NIDT_UUID_LEN;
> -    memcpy(&ns_descrs->uuid.v, ns->params.uuid.data, NVME_NIDT_UUID_LEN);
> +    ns_descrs->uuid.hdr.nidl =3D NVME_NIDL_UUID;
> +    memcpy(&ns_descrs->uuid.v, ns->params.uuid.data, NVME_NIDL_UUID);
> =20
> -    return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
> -                    DMA_DIRECTION_FROM_DEVICE, req);
> +    ns_descrs->csi.hdr.nidt =3D NVME_NIDT_CSI;
> +    ns_descrs->csi.hdr.nidl =3D NVME_NIDL_CSI;
> +    ns_descrs->csi.v =3D ns->csi;
> +
> +    return nvme_dma(n, list, sizeof(list), DMA_DIRECTION_FROM_DEVICE, re=
q);
> +}
> +
> +static uint16_t nvme_identify_cmd_set(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint8_t list[NVME_IDENTIFY_DATA_SIZE] =3D {};

[-pedantic] empty initializer list

> +    static const int data_len =3D sizeof(list);
> +
> +    trace_pci_nvme_identify_cmd_set();
> +
> +    NVME_SET_CSI(*list, NVME_CSI_NVM);
> +    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+N/NAACgkQTeGvMW1P
Dekmxwf/VPz/E0daSJywwPedvbHFvw8kxa/RzyRaybDWMYYEGOd4ycINpoX7bHSy
Z9BxI5GgPE75vPLSIo87U61hiMi99R8nfpScYNbCpDMS7epoUTGcnXTk4rjZn/gl
PhtUs+xUKLdzkjgxMMPfLMARL0TxacnziMEnoseLqEA9Dr/g0cVpERszS82U09/E
SLOkmBxP8v94Ip7QxToKLlvevTiQBkZRBIKGvKeT7VorR3rk1k0qtanZtmTf5f1q
W+pWYA0kEoNkMi0kSkho4cf8pj+u7C0VRRkE1HH/AOEdaRzdKEHFjwduDzinz8ZU
PxpDPd55ppsJg81PkE35zLM9Yh6X7Q==
=/NB+
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--

