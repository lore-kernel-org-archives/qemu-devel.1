Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D44C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F63B223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F63B223EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUbdv-0006GG-Pb
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 16:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUba0-0004l2-NI; Mon, 19 Oct 2020 16:16:30 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:57043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUbZx-0002G1-Co; Mon, 19 Oct 2020 16:16:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 0481C6A7;
 Mon, 19 Oct 2020 16:16:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 19 Oct 2020 16:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=H5rdLsmTaY0X6PBC4fqM/mjk40S
 o1OIZ23uHCNZb4zs=; b=v5KPLP5u/nnM2Tr7sFG2rSFlB+MxR7JSXfCwpxf+qrp
 1ZHI8qbo+pKZ0KgnWjzLwq99sTzLcte72B4lx8vtgLv1TWQ5KJKb+CoG4DdOHO+u
 AGBGiXrjnntBXu4DfQ0kUCVwAlNUkBXbRHjc8DV10xc8hwmrEx2inlwmnTEoL12H
 8JkBsb6gbWigw1QSxXcyU89QN2407Wx3QaQNXnn8G9hbUJ42sHbgZ7BQ/DlPsl4c
 U05FBDJi6/vSbBePqTMw/2RcME7LYzYXmmhEJhFQclnKwcJjdtplERuqSq+0tFTH
 i4iz+Jp3lHqJPyrr7/e/Ua26iPbXCLnwxkqdiAHl1tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=H5rdLs
 mTaY0X6PBC4fqM/mjk40So1OIZ23uHCNZb4zs=; b=birT3dDh1QUZRVdjtVPMev
 Zld7W1jjQeW7xlbGOoY8sk0W8nnB6891dd9wY9NLZzNecW7QLK0KDxh/7RW8DLiF
 Pm55MreRDZkv8SrjeWvTYFHtK+ILEi8wx4+tvQ2lQ5eJf5PYrSFN4F2SzkgmLn4G
 237LpiJ2kuuXnkMoB9w8LEWTbK6vvMYqWUsR3jEEwPXfdL7IasVhSvQt8hBAnZYs
 CZIGBT0QAi4pJSz4p87LKpfFB5qoNVh2hrsVhnQRr8Cr9LmuuFUkoP+wjSiJV0pf
 WwdFuXVvoB0QWVGsIaooF5h3UEjUa3vRJ0pAbgGp6gaQ328ujPWiYmEefyLmxr4Q
 ==
X-ME-Sender: <xms:E_SNXyW0sY3VdcYSFhTFZjSdLbkcL0BYZSA6mv7eb7tU1DraWQEJcg>
 <xme:E_SNX-kNlWxBnBpIveRCeZ8u6hpEVIEVeUPwDOVQMdg-nBI_ABdCAuw6eM9kFuK15
 lwhcxpuY2IYNTN_VFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedvgdduvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:E_SNX2aaIv5jQ47bmksTYfh3kH6wJlUP958scgV2GsNjMuq2aUmVvw>
 <xmx:E_SNX5XNXlpYtedQmO0QiIJbmSBxQYfwlSgjixg8SdWGO-m7yC5BDg>
 <xmx:E_SNX8kqsZ7sEDQPV2EdekeKh2H9DgVziB_JUU9KWDXWg8Y_av9lfQ>
 <xmx:FfSNX2fEwoKOqi-NLl6C1cleMbwq20oJc9R0vCpbK-p5ZJ74TRYV1x5xcdGcorzZ>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2765D3280060;
 Mon, 19 Oct 2020 16:16:18 -0400 (EDT)
Date: Mon, 19 Oct 2020 22:16:16 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v7 01/11] hw/block/nvme: Add Commands Supported and
 Effects log
Message-ID: <20201019201616.GH10549@apples.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Content-Disposition: inline
In-Reply-To: <20201019021726.12048-2-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=64.147.123.26; envelope-from=its@irrelevant.dk;
 helo=wnew1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 13:31:09
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


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 11:17, Dmitry Fomichev wrote:
> This log page becomes necessary to implement to allow checking for
> Zone Append command support in Zoned Namespace Command Set.
>=20
> This commit adds the code to report this log page for NVM Command
> Set only. The parts that are specific to zoned operation will be
> added later in the series.
>=20
> All incoming admin and i/o commands are now only processed if their
> corresponding support bits are set in this log. This provides an
> easy way to control what commands to support and what not to
> depending on set CC.CSS.
>=20
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme-ns.h    |  1 +
>  hw/block/nvme.c       | 98 +++++++++++++++++++++++++++++++++++++++----
>  hw/block/trace-events |  2 +
>  include/block/nvme.h  | 19 +++++++++
>  4 files changed, 111 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> index 83734f4606..ea8c2f785d 100644
> --- a/hw/block/nvme-ns.h
> +++ b/hw/block/nvme-ns.h
> @@ -29,6 +29,7 @@ typedef struct NvmeNamespace {
>      int32_t      bootindex;
>      int64_t      size;
>      NvmeIdNs     id_ns;
> +    const uint32_t *iocs;
> =20
>      NvmeNamespaceParams params;
>  } NvmeNamespace;
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 9d30ca69dc..5a9493d89f 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -111,6 +111,28 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX]=
 =3D {
>      [NVME_TIMESTAMP]                =3D NVME_FEAT_CAP_CHANGE,
>  };
> =20
> +static const uint32_t nvme_cse_acs[256] =3D {
> +    [NVME_ADM_CMD_DELETE_SQ]        =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_CREATE_SQ]        =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_DELETE_CQ]        =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_CREATE_CQ]        =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_IDENTIFY]         =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SET_FEATURES]     =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_GET_FEATURES]     =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_GET_LOG_PAGE]     =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_ASYNC_EV_REQ]     =3D NVME_CMD_EFF_CSUPP,
> +};

NVME_ADM_CMD_ABORT is missing. And since you added a (redundant) check
in nvme_admin_cmd that cheks this table, Abort is now an invalid
command.

Also, can you reorder it according to opcode instead of
pseudo-lexicographically?

> +
> +static const uint32_t nvme_cse_iocs_none[256] =3D {
> +};

[-pedantic] no need for the '=3D {}'

> +
> +static const uint32_t nvme_cse_iocs_nvm[256] =3D {
> +    [NVME_CMD_FLUSH]                =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
> +    [NVME_CMD_WRITE_ZEROES]         =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
> +    [NVME_CMD_WRITE]                =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
> +    [NVME_CMD_READ]                 =3D NVME_CMD_EFF_CSUPP,
> +};
> +
>  static void nvme_process_sq(void *opaque);
> =20
>  static uint16_t nvme_cid(NvmeRequest *req)
> @@ -1032,10 +1054,6 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeReque=
st *req)
>      trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
>                            req->cmd.opcode, nvme_io_opc_str(req->cmd.opco=
de));
> =20
> -    if (NVME_CC_CSS(n->bar.cc) =3D=3D NVME_CC_CSS_ADMIN_ONLY) {
> -        return NVME_INVALID_OPCODE | NVME_DNR;
> -    }
> -

I would assume the device to respond with invalid opcode before
validating the nsid if it is an admin only device.

>      if (!nvme_nsid_valid(n, nsid)) {
>          return NVME_INVALID_NSID | NVME_DNR;
>      }
> @@ -1045,6 +1063,11 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeReque=
st *req)
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> +    if (!(req->ns->iocs[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
> +        trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
> +        return NVME_INVALID_OPCODE | NVME_DNR;
> +    }
> +
>      switch (req->cmd.opcode) {
>      case NVME_CMD_FLUSH:
>          return nvme_flush(n, req);
> @@ -1054,8 +1077,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeReques=
t *req)
>      case NVME_CMD_READ:
>          return nvme_rw(n, req);
>      default:
> -        trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
> -        return NVME_INVALID_OPCODE | NVME_DNR;
> +        assert(false);
>      }
>  }
> =20
> @@ -1291,6 +1313,39 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8=
_t rae, uint32_t buf_len,
>                      DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
> +static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32_t buf_len,
> +                                 uint64_t off, NvmeRequest *req)
> +{
> +    NvmeEffectsLog log =3D {};

[-pedantic] and empty initializer list is not allowed, should be '{0}'.

> +    const uint32_t *src_iocs =3D NULL;
> +    uint32_t trans_len;
> +
> +    trace_pci_nvme_cmd_supp_and_effects_log_read();

This has just been traced in nvme_admin_cmd and this doesn't add any
additional info.

> +
> +    if (off >=3D sizeof(log)) {
> +        trace_pci_nvme_err_invalid_effects_log_offset(off);

Can we do `trace_pci_nvme_err_invalid_log_page_offset(off) instead? Then
we can easily reuse it in the other log pages.

> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    switch (NVME_CC_CSS(n->bar.cc)) {
> +    case NVME_CC_CSS_NVM:
> +        src_iocs =3D nvme_cse_iocs_nvm;
> +    case NVME_CC_CSS_ADMIN_ONLY:
> +        break;
> +    }
> +
> +    memcpy(log.acs, nvme_cse_acs, sizeof(nvme_cse_acs));
> +
> +    if (src_iocs) {
> +        memcpy(log.iocs, src_iocs, sizeof(log.iocs));
> +    }
> +
> +    trans_len =3D MIN(sizeof(log) - off, buf_len);
> +
> +    return nvme_dma(n, ((uint8_t *)&log) + off, trans_len,
> +                    DMA_DIRECTION_FROM_DEVICE, req);
> +}
> +
>  static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeCmd *cmd =3D &req->cmd;
> @@ -1334,6 +1389,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeReque=
st *req)
>          return nvme_smart_info(n, rae, len, off, req);
>      case NVME_LOG_FW_SLOT_INFO:
>          return nvme_fw_log_info(n, len, off, req);
> +    case NVME_LOG_CMD_EFFECTS:
> +        return nvme_cmd_effects(n, len, off, req);
>      default:
>          trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1920,6 +1977,11 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRe=
quest *req)
>      trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), req->cmd.opc=
ode,
>                               nvme_adm_opc_str(req->cmd.opcode));
> =20
> +    if (!(nvme_cse_acs[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
> +        trace_pci_nvme_err_invalid_admin_opc(req->cmd.opcode);
> +        return NVME_INVALID_OPCODE | NVME_DNR;
> +    }
> +

This is the (redundant) check that effectively makes Abort an invalid
command.

>      switch (req->cmd.opcode) {
>      case NVME_ADM_CMD_DELETE_SQ:
>          return nvme_del_sq(n, req);
> @@ -1942,8 +2004,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeReq=
uest *req)
>      case NVME_ADM_CMD_ASYNC_EV_REQ:
>          return nvme_aer(n, req);
>      default:
> -        trace_pci_nvme_err_invalid_admin_opc(req->cmd.opcode);
> -        return NVME_INVALID_OPCODE | NVME_DNR;
> +        assert(false);
>      }
>  }
> =20
> @@ -2031,6 +2092,23 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
>      n->bar.cc =3D 0;
>  }
> =20
> +static void nvme_select_ns_iocs(NvmeCtrl *n)
> +{
> +    NvmeNamespace *ns;
> +    int i;
> +
> +    for (i =3D 1; i <=3D n->num_namespaces; i++) {
> +        ns =3D nvme_ns(n, i);
> +        if (!ns) {
> +            continue;
> +        }
> +        ns->iocs =3D nvme_cse_iocs_none;
> +        if (NVME_CC_CSS(n->bar.cc) !=3D NVME_CC_CSS_ADMIN_ONLY) {
> +            ns->iocs =3D nvme_cse_iocs_nvm;
> +        }
> +    }
> +}
> +
>  static int nvme_start_ctrl(NvmeCtrl *n)
>  {
>      uint32_t page_bits =3D NVME_CC_MPS(n->bar.cc) + 12;
> @@ -2129,6 +2207,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
> =20
>      QTAILQ_INIT(&n->aer_queue);
> =20
> +    nvme_select_ns_iocs(n);
> +
>      return 0;
>  }
> =20
> @@ -2737,7 +2817,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *=
pci_dev)
>      id->acl =3D 3;
>      id->aerl =3D n->params.aerl;
>      id->frmw =3D (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
> -    id->lpa =3D NVME_LPA_NS_SMART | NVME_LPA_EXTENDED;
> +    id->lpa =3D NVME_LPA_NS_SMART | NVME_LPA_CSE | NVME_LPA_EXTENDED;
> =20
>      /* recommended default value (~70 C) */
>      id->wctemp =3D cpu_to_le16(NVME_TEMPERATURE_WARNING);
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index fac5995d94..0ae9cb0d35 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -85,6 +85,7 @@ pci_nvme_mmio_start_success(void) "setting controller e=
nable bit succeeded"
>  pci_nvme_mmio_stopped(void) "cleared controller enable bit"
>  pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
>  pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
> +pci_nvme_cmd_supp_and_effects_log_read(void) "commands supported and eff=
ects log read"
> =20
>  # nvme traces for error conditions
>  pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
> @@ -104,6 +105,7 @@ pci_nvme_err_invalid_prp(void) "invalid PRP"
>  pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
>  pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PR=
Ix8""
>  pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t li=
mit) "Invalid LBA start=3D%"PRIu64" len=3D%"PRIu64" limit=3D%"PRIu64""
> +pci_nvme_err_invalid_effects_log_offset(uint64_t ofs) "commands supporte=
d and effects log offset must be 0, got %"PRIu64""
>  pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue dele=
tion, sid=3D%"PRIu16""
>  pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating subm=
ission queue, invalid cqid=3D%"PRIu16""
>  pci_nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating subm=
ission queue, invalid sqid=3D%"PRIu16""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 6de2d5aa75..4779495b7d 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -744,10 +744,27 @@ enum NvmeSmartWarn {
>      NVME_SMART_FAILED_VOLATILE_MEDIA  =3D 1 << 4,
>  };
> =20
> +typedef struct NvmeEffectsLog {
> +    uint32_t    acs[256];
> +    uint32_t    iocs[256];
> +    uint8_t     resv[2048];
> +} NvmeEffectsLog;
> +
> +enum {
> +    NVME_CMD_EFF_CSUPP      =3D 1 << 0,
> +    NVME_CMD_EFF_LBCC       =3D 1 << 1,
> +    NVME_CMD_EFF_NCC        =3D 1 << 2,
> +    NVME_CMD_EFF_NIC        =3D 1 << 3,
> +    NVME_CMD_EFF_CCC        =3D 1 << 4,
> +    NVME_CMD_EFF_CSE_MASK   =3D 3 << 16,
> +    NVME_CMD_EFF_UUID_SEL   =3D 1 << 19,
> +};
> +
>  enum NvmeLogIdentifier {
>      NVME_LOG_ERROR_INFO     =3D 0x01,
>      NVME_LOG_SMART_INFO     =3D 0x02,
>      NVME_LOG_FW_SLOT_INFO   =3D 0x03,
> +    NVME_LOG_CMD_EFFECTS    =3D 0x05,
>  };
> =20
>  typedef struct QEMU_PACKED NvmePSD {
> @@ -860,6 +877,7 @@ enum NvmeIdCtrlFrmw {
> =20
>  enum NvmeIdCtrlLpa {
>      NVME_LPA_NS_SMART =3D 1 << 0,
> +    NVME_LPA_CSE      =3D 1 << 1,
>      NVME_LPA_EXTENDED =3D 1 << 2,
>  };
> =20
> @@ -1059,6 +1077,7 @@ static inline void _nvme_check_size(void)
>      QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) !=3D 64);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) !=3D 512);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) !=3D 512);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) !=3D 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) !=3D 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) !=3D 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) !=3D 16);
> --=20
> 2.21.0
>=20
>=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+N9A4ACgkQTeGvMW1P
DekpKwf/QljlXgNG1NDaPB6PeDMx+2YkyFEB+5Hl65nudYutoVCf3r6etQQ65QOZ
w13pzqNJu9QCOwvjt/zAv4HE1frqUGROr5ZtYQwfFhnQqOG+BnuB4Sap6cwMadvB
egUnEo7Op2JLiZWWm0bl9Z1G6sABdVUc6UWG5K308pHX5UMXhZAhq9mNwn6BneTr
e2aXEsXk187dKF/EG0JXDz6gjhgaOlciGqLurrGztFerRHlOAbDSN3YGrOxodpc5
JwGNudkVkOnPijakCmcRQ2HmSHOa+w5t9evG8g5vzwsVHSlsdF9MdD6nySGACDFS
sA5ioRa9PWOsG6pWgsHQQ7LKx4XzPg==
=+TBo
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--

