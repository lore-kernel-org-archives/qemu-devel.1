Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6959AC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287C320775
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHU7eQyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287C320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3Qn-0004o6-Al
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3PQ-0002cF-Gx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3PO-0007yv-Ed
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:37:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3PO-0007yk-Av
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86HIpdkrdgaPExkMrAHMIF5PyLJWVvJlrnkXNlgGwNU=;
 b=GHU7eQyz/e5ekbfkhxjluPiMOtIDA7FTRsEWOMTAV5Wo7BqGDj/GbaPI61ujiVGBnmhmdI
 GrMZ3rc9JxO35uFofaQnguA0td9GmdrgMX3PjsWkob3iR6tNahl3s4RkCIkgMVoML0N9Si
 /YkMVm6e/alsa/fAKwBXkUTLMTVq11c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-uHVjaqJ7OF-xLt8oh0D1SA-1; Wed, 25 Mar 2020 06:37:09 -0400
X-MC-Unique: uHVjaqJ7OF-xLt8oh0D1SA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E89A68017DF;
 Wed, 25 Mar 2020 10:37:07 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B0D95D9C5;
 Wed, 25 Mar 2020 10:37:02 +0000 (UTC)
Message-ID: <edab0548c595bee319de4db4eefec87c1edfa1cd.camel@redhat.com>
Subject: Re: [PATCH v6 04/42] nvme: bump spec data structures to v1.3
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:37:02 +0200
In-Reply-To: <20200316142928.153431-5-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-5-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add missing fields in the Identify Controller and Identify Namespace
> data structures to bring them in line with NVMe v1.3.
> 
> This also adds data structures and defines for SGL support which
> requires a couple of trivial changes to the nvme block driver as well.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Fam Zheng <fam@euphon.net>
> ---
>  block/nvme.c         |  18 ++---
>  hw/block/nvme.c      |  12 ++--
>  include/block/nvme.h | 153 ++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 151 insertions(+), 32 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index d41c4bda6e39..99b9bb3dac96 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -446,7 +446,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>          error_setg(errp, "Cannot map buffer for DMA");
>          goto out;
>      }
> -    cmd.prp1 = cpu_to_le64(iova);
> +    cmd.dptr.prp1 = cpu_to_le64(iova);
>  
>      if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
>          error_setg(errp, "Failed to identify controller");
> @@ -545,7 +545,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>      }
>      cmd = (NvmeCmd) {
>          .opcode = NVME_ADM_CMD_CREATE_CQ,
> -        .prp1 = cpu_to_le64(q->cq.iova),
> +        .dptr.prp1 = cpu_to_le64(q->cq.iova),
>          .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
>          .cdw11 = cpu_to_le32(0x3),
>      };
> @@ -556,7 +556,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>      }
>      cmd = (NvmeCmd) {
>          .opcode = NVME_ADM_CMD_CREATE_SQ,
> -        .prp1 = cpu_to_le64(q->sq.iova),
> +        .dptr.prp1 = cpu_to_le64(q->sq.iova),
>          .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
>          .cdw11 = cpu_to_le32(0x1 | (n << 16)),
>      };
> @@ -906,16 +906,16 @@ try_map:
>      case 0:
>          abort();
>      case 1:
> -        cmd->prp1 = pagelist[0];
> -        cmd->prp2 = 0;
> +        cmd->dptr.prp1 = pagelist[0];
> +        cmd->dptr.prp2 = 0;
>          break;
>      case 2:
> -        cmd->prp1 = pagelist[0];
> -        cmd->prp2 = pagelist[1];
> +        cmd->dptr.prp1 = pagelist[0];
> +        cmd->dptr.prp2 = pagelist[1];
>          break;
>      default:
> -        cmd->prp1 = pagelist[0];
> -        cmd->prp2 = cpu_to_le64(req->prp_list_iova + sizeof(uint64_t));
> +        cmd->dptr.prp1 = pagelist[0];
> +        cmd->dptr.prp2 = cpu_to_le64(req->prp_list_iova + sizeof(uint64_t));
>          break;
>      }
>      trace_nvme_cmd_map_qiov(s, cmd, req, qiov, entries);
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index b532818b4b76..40cb176dea3c 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -372,8 +372,8 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
>      uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
>      uint64_t slba = le64_to_cpu(rw->slba);
> -    uint64_t prp1 = le64_to_cpu(rw->prp1);
> -    uint64_t prp2 = le64_to_cpu(rw->prp2);
> +    uint64_t prp1 = le64_to_cpu(rw->dptr.prp1);
> +    uint64_t prp2 = le64_to_cpu(rw->dptr.prp2);
>  
>      uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
>      uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
> @@ -763,8 +763,8 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
>  
>  static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
>  {
> -    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
>  
>      uint64_t timestamp = nvme_get_timestamp(n);
>  
> @@ -802,8 +802,8 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
>  {
>      uint16_t ret;
>      uint64_t timestamp;
> -    uint64_t prp1 = le64_to_cpu(cmd->prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->prp2);
> +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
>  
>      ret = nvme_dma_write_prp(n, (uint8_t *)&timestamp,
>                                  sizeof(timestamp), prp1, prp2);
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 8fb941c6537c..a083c1b3a613 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -205,15 +205,53 @@ enum NvmeCmbszMask {
>  #define NVME_CMBSZ_GETSIZE(cmbsz) \
>      (NVME_CMBSZ_SZ(cmbsz) * (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz))))
>  
> +enum NvmeSglDescriptorType {
> +    NVME_SGL_DESCR_TYPE_DATA_BLOCK          = 0x0,
> +    NVME_SGL_DESCR_TYPE_BIT_BUCKET          = 0x1,
> +    NVME_SGL_DESCR_TYPE_SEGMENT             = 0x2,
> +    NVME_SGL_DESCR_TYPE_LAST_SEGMENT        = 0x3,
> +    NVME_SGL_DESCR_TYPE_KEYED_DATA_BLOCK    = 0x4,
> +
> +    NVME_SGL_DESCR_TYPE_VENDOR_SPECIFIC     = 0xf,
> +};
OK

> +
> +enum NvmeSglDescriptorSubtype {
> +    NVME_SGL_DESCR_SUBTYPE_ADDRESS = 0x0,
> +};
OK
> +
> +typedef struct NvmeSglDescriptor {
> +    uint64_t addr;
> +    uint32_t len;
> +    uint8_t  rsvd[3];
> +    uint8_t  type;
> +} NvmeSglDescriptor;
> +
> +#define NVME_SGL_TYPE(type)     ((type >> 4) & 0xf)
> +#define NVME_SGL_SUBTYPE(type)  (type & 0xf)
OK

> +
> +typedef union NvmeCmdDptr {
> +    struct {
> +        uint64_t    prp1;
> +        uint64_t    prp2;
> +    };
> +
> +    NvmeSglDescriptor sgl;
> +} NvmeCmdDptr;

> +
> +enum NvmePsdt {
> +    PSDT_PRP                 = 0x0,
> +    PSDT_SGL_MPTR_CONTIGUOUS = 0x1,
> +    PSDT_SGL_MPTR_SGL        = 0x2,
> +};
OK
> +
>  typedef struct NvmeCmd {
>      uint8_t     opcode;
> -    uint8_t     fuse;
> +    uint8_t     flags;
Yep, that makes sense, since this contains
more that fused operation control bits.
>      uint16_t    cid;
>      uint32_t    nsid;
>      uint64_t    res1;
>      uint64_t    mptr;
> -    uint64_t    prp1;
> -    uint64_t    prp2;
> +    NvmeCmdDptr dptr;
>      uint32_t    cdw10;
>      uint32_t    cdw11;
>      uint32_t    cdw12;
> @@ -222,6 +260,9 @@ typedef struct NvmeCmd {
>      uint32_t    cdw15;
>  } NvmeCmd;
>  
> +#define NVME_CMD_FLAGS_FUSE(flags) (flags & 0x3)
> +#define NVME_CMD_FLAGS_PSDT(flags) ((flags >> 6) & 0x3)
OK
> +
>  enum NvmeAdminCommands {
>      NVME_ADM_CMD_DELETE_SQ      = 0x00,
>      NVME_ADM_CMD_CREATE_SQ      = 0x01,
> @@ -321,8 +362,7 @@ typedef struct NvmeRwCmd {
>      uint32_t    nsid;
>      uint64_t    rsvd2;
>      uint64_t    mptr;
> -    uint64_t    prp1;
> -    uint64_t    prp2;
> +    NvmeCmdDptr dptr;
>      uint64_t    slba;
>      uint16_t    nlb;
>      uint16_t    control;
> @@ -362,8 +402,7 @@ typedef struct NvmeDsmCmd {
>      uint16_t    cid;
>      uint32_t    nsid;
>      uint64_t    rsvd2[2];
> -    uint64_t    prp1;
> -    uint64_t    prp2;
> +    NvmeCmdDptr dptr;
>      uint32_t    nr;
>      uint32_t    attributes;
>      uint32_t    rsvd12[4];
> @@ -427,6 +466,12 @@ enum NvmeStatusCodes {
>      NVME_CMD_ABORT_MISSING_FUSE = 0x000a,
>      NVME_INVALID_NSID           = 0x000b,
>      NVME_CMD_SEQ_ERROR          = 0x000c,
> 

> +    NVME_INVALID_SGL_SEG_DESCR  = 0x000d,
> +    NVME_INVALID_NUM_SGL_DESCRS = 0x000e,
> +    NVME_DATA_SGL_LEN_INVALID   = 0x000f,
> +    NVME_MD_SGL_LEN_INVALID     = 0x0010,
> +    NVME_SGL_DESCR_TYPE_INVALID = 0x0011,
> +    NVME_INVALID_USE_OF_CMB     = 0x0012,
OK

>      NVME_LBA_RANGE              = 0x0080,
>      NVME_CAP_EXCEEDED           = 0x0081,
>      NVME_NS_NOT_READY           = 0x0082,
> @@ -515,7 +560,7 @@ enum NvmeSmartWarn {
>      NVME_SMART_FAILED_VOLATILE_MEDIA  = 1 << 4,
>  };
>  
> -enum LogIdentifier {
> +enum NvmeLogIdentifier {
>      NVME_LOG_ERROR_INFO     = 0x01,
>      NVME_LOG_SMART_INFO     = 0x02,
>      NVME_LOG_FW_SLOT_INFO   = 0x03,
> @@ -533,6 +578,15 @@ typedef struct NvmePSD {
>      uint8_t     resv[16];
>  } NvmePSD;
>  
> +#define NVME_IDENTIFY_DATA_SIZE 4096
> +
> +enum {
> +    NVME_ID_CNS_NS             = 0x0,
> +    NVME_ID_CNS_CTRL           = 0x1,
> +    NVME_ID_CNS_NS_ACTIVE_LIST = 0x2,
> +    NVME_ID_CNS_NS_DESCR_LIST  = 0x3,
> +};
OK


> +
>  typedef struct NvmeIdCtrl {
>      uint16_t    vid;
>      uint16_t    ssvid;
> @@ -543,7 +597,15 @@ typedef struct NvmeIdCtrl {
>      uint8_t     ieee[3];
>      uint8_t     cmic;
>      uint8_t     mdts;
> -    uint8_t     rsvd255[178];
> +    uint16_t    cntlid;
> +    uint32_t    ver;
> +    uint32_t    rtd3r;
> +    uint32_t    rtd3e;
> +    uint32_t    oaes;
> +    uint32_t    ctratt;
> +    uint8_t     rsvd100[12];
> +    uint8_t     fguid[16];
> +    uint8_t     rsvd128[128];
>      uint16_t    oacs;
>      uint8_t     acl;
>      uint8_t     aerl;
> @@ -551,10 +613,28 @@ typedef struct NvmeIdCtrl {
>      uint8_t     lpa;
>      uint8_t     elpe;
>      uint8_t     npss;
> -    uint8_t     rsvd511[248];
> +    uint8_t     avscc;
> +    uint8_t     apsta;
> +    uint16_t    wctemp;
> +    uint16_t    cctemp;
> +    uint16_t    mtfa;
> +    uint32_t    hmpre;
> +    uint32_t    hmmin;
> +    uint8_t     tnvmcap[16];
> +    uint8_t     unvmcap[16];
> +    uint32_t    rpmbs;
> +    uint16_t    edstt;
> +    uint8_t     dsto;
> +    uint8_t     fwug;
> +    uint16_t    kas;
> +    uint16_t    hctma;
> +    uint16_t    mntmt;
> +    uint16_t    mxtmt;
> +    uint32_t    sanicap;
> +    uint8_t     rsvd332[180];
>      uint8_t     sqes;
>      uint8_t     cqes;
> -    uint16_t    rsvd515;
> +    uint16_t    maxcmd;
>      uint32_t    nn;
>      uint16_t    oncs;
>      uint16_t    fuses;
> @@ -562,8 +642,14 @@ typedef struct NvmeIdCtrl {
>      uint8_t     vwc;
>      uint16_t    awun;
>      uint16_t    awupf;
> -    uint8_t     rsvd703[174];
> -    uint8_t     rsvd2047[1344];
> +    uint8_t     nvscc;
> +    uint8_t     rsvd531;
> +    uint16_t    acwu;
> +    uint8_t     rsvd534[2];
> +    uint32_t    sgls;
> +    uint8_t     rsvd540[228];
> +    uint8_t     subnqn[256];
> +    uint8_t     rsvd1024[1024];
>      NvmePSD     psd[32];
>      uint8_t     vs[1024];
>  } NvmeIdCtrl;
I checked the diff versus V5, cross referenced the spec and it looks correct now,
plus you documented even more fields which is welcome.


> @@ -589,6 +675,16 @@ enum NvmeIdCtrlOncs {
>  #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)
>  #define NVME_CTRL_CQES_MAX(cqes) (((cqes) >> 4) & 0xf)
>  
> +#define NVME_CTRL_SGLS_SUPPORTED_MASK            (0x3 <<  0)
> +#define NVME_CTRL_SGLS_SUPPORTED_NO_ALIGNMENT    (0x1 <<  0)
> +#define NVME_CTRL_SGLS_SUPPORTED_DWORD_ALIGNMENT (0x1 <<  1)
> +#define NVME_CTRL_SGLS_KEYED                     (0x1 <<  2)
> +#define NVME_CTRL_SGLS_BITBUCKET                 (0x1 << 16)
> +#define NVME_CTRL_SGLS_MPTR_CONTIGUOUS           (0x1 << 17)
> +#define NVME_CTRL_SGLS_EXCESS_LENGTH             (0x1 << 18)
> +#define NVME_CTRL_SGLS_MPTR_SGL                  (0x1 << 19)
> +#define NVME_CTRL_SGLS_ADDR_OFFSET               (0x1 << 20)
OK
> +
>  typedef struct NvmeFeatureVal {
>      uint32_t    arbitration;
>      uint32_t    power_mgmt;
> @@ -611,6 +707,10 @@ typedef struct NvmeFeatureVal {
>  #define NVME_INTC_THR(intc)     (intc & 0xff)
>  #define NVME_INTC_TIME(intc)    ((intc >> 8) & 0xff)
>  
> +#define NVME_TEMP_THSEL(temp)  ((temp >> 20) & 0x3)
Nitpick: If we are adding this, I'll add a #define for the values as well

> +#define NVME_TEMP_TMPSEL(temp) ((temp >> 16) & 0xf)
> +#define NVME_TEMP_TMPTH(temp)  ((temp >>  0) & 0xffff)
> +
>  enum NvmeFeatureIds {
>      NVME_ARBITRATION                = 0x1,
>      NVME_POWER_MANAGEMENT           = 0x2,
> @@ -653,18 +753,37 @@ typedef struct NvmeIdNs {
>      uint8_t     mc;
>      uint8_t     dpc;
>      uint8_t     dps;
> -
>      uint8_t     nmic;
>      uint8_t     rescap;
>      uint8_t     fpi;
>      uint8_t     dlfeat;
> -
> -    uint8_t     res34[94];
> +    uint16_t    nawun;
> +    uint16_t    nawupf;
> +    uint16_t    nacwu;
> +    uint16_t    nabsn;
> +    uint16_t    nabo;
> +    uint16_t    nabspf;
> +    uint16_t    noiob;
> +    uint8_t     nvmcap[16];
> +    uint8_t     rsvd64[40];
> +    uint8_t     nguid[16];
> +    uint64_t    eui64;
>      NvmeLBAF    lbaf[16];
> -    uint8_t     res192[192];
> +    uint8_t     rsvd192[192];
>      uint8_t     vs[3712];
>  } NvmeIdNs;
Also checked this against V5, looks OK now

>  
> +typedef struct NvmeIdNsDescr {
> +    uint8_t nidt;
> +    uint8_t nidl;
> +    uint8_t rsvd2[2];
> +} NvmeIdNsDescr;
OK



> +
> +#define NVME_NIDT_UUID_LEN 16
> +
> +enum {
> +    NVME_NIDT_UUID = 0x3,
Very minor nitpick: I'll would add others as well just for the sake
of better understanding what this is

> +};
>  
>  /*Deallocate Logical Block Features*/
>  #define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)

Looks very good.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




