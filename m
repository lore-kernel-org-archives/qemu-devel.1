Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC03C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30B72080C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9DYnnec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30B72080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVhbV-0003Km-A0
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 16:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVhZB-0001u0-IG
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 16:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVhZ7-0004bL-Pl
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 16:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603399923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xA+l4ZhLyQH/hWow+i05VsnuqqwxPPGIYrhWBBxAJ3o=;
 b=c9DYnnecfFhkjJYzHHfYYIb5tc9PK0ZNy+TvShdno8QGVS4rPSsezspps/29AtQmuBZ5xn
 mk+dt5NQoggWjnMkQCzHW0zlTSymMY+5trXWvDXyf1fa6fS22On4fUp1a278CRGari3f3K
 5f/cesOomIh7IvzytxkKuIfuiaF/Nn8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-1QcJcUIZNnyvg__U9Ajzng-1; Thu, 22 Oct 2020 16:52:02 -0400
X-MC-Unique: 1QcJcUIZNnyvg__U9Ajzng-1
Received: by mail-wr1-f69.google.com with SMTP id h8so1164258wrt.9
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 13:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xA+l4ZhLyQH/hWow+i05VsnuqqwxPPGIYrhWBBxAJ3o=;
 b=XmU4zBxGwqtDhppusHd8gJuABbDNd/R1WR+zzgPsZuMpjR7xGNh3Ij6Sd52Za1QBeI
 lXZaUiYvyzJVmmWb7Flw0CoAMjGNHcyo40je8krHRqxK0EvrxKUtrsSV2gwZr1H7n7id
 TNlyM6ywpDy9PAgSN4wtzCT12wMpxm0JcE6h/j3mPMQiOhDGSEytuK4bum0sK9pkELsO
 hOvZAo7o+B+E8fkuHwTqGQhITkeUUonhOtnl+Yaut05Gu5yU8euvsdyEca/34deKBFxW
 wVEvpIcsdMpGw9Lb8tOX+qzXsLq+xCegxSjuZFWpy6kKab3HKH2Zv5l0hQGPVp1wG0OS
 tbOg==
X-Gm-Message-State: AOAM533K9shSOCsQNrD0cBdhUDr9n2Eod6U+eWmg0nenbyly47SSivgl
 7Dn8pQISSJpzt6paVASNqfBcmElafmO1wRjwLDdVv/w7R6GtyBL9OsVuSS6devm4qz7YMvD7H/J
 EPb6ryTR0/uCWPMA=
X-Received: by 2002:a5d:490a:: with SMTP id x10mr4356150wrq.289.1603399920858; 
 Thu, 22 Oct 2020 13:52:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEPiMNu2CeMMjTzqteJQONTeu9I/XXThB8UcWNeBpc8Zn3ez0mVxlZsvwc5Lc4tDB9IRItLQ==
X-Received: by 2002:a5d:490a:: with SMTP id x10mr4356120wrq.289.1603399920460; 
 Thu, 22 Oct 2020 13:52:00 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e5sm5589378wrw.93.2020.10.22.13.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 13:51:59 -0700 (PDT)
Subject: Re: [PATCH v3 12/17] hw/block/nvme: add support for scatter gather
 lists
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
References: <20200922084533.1273962-1-its@irrelevant.dk>
 <20200922084533.1273962-13-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <473d4fd5-62d9-3856-5bbe-edba1ac5040f@redhat.com>
Date: Thu, 22 Oct 2020 22:51:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200922084533.1273962-13-its@irrelevant.dk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 10:45 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> For now, support the Data Block, Segment and Last Segment descriptor
> types.
> 
> See NVM Express 1.3d, Section 4.4 ("Scatter Gather List (SGL)").
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---
>   include/block/nvme.h  |   6 +-
>   hw/block/nvme.c       | 329 ++++++++++++++++++++++++++++++++++--------
>   hw/block/trace-events |   4 +
>   3 files changed, 279 insertions(+), 60 deletions(-)
> 
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 65e68a82c897..58647bcdad0b 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -412,9 +412,9 @@ typedef union NvmeCmdDptr {
>   } NvmeCmdDptr;
>   
>   enum NvmePsdt {
> -    PSDT_PRP                 = 0x0,
> -    PSDT_SGL_MPTR_CONTIGUOUS = 0x1,
> -    PSDT_SGL_MPTR_SGL        = 0x2,
> +    NVME_PSDT_PRP                 = 0x0,
> +    NVME_PSDT_SGL_MPTR_CONTIGUOUS = 0x1,
> +    NVME_PSDT_SGL_MPTR_SGL        = 0x2,
>   };
>   
>   typedef struct QEMU_PACKED NvmeCmd {
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 3b901efd1ec0..c5d09ff1edf5 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -413,13 +413,262 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
>       return NVME_SUCCESS;
>   }
>   
> -static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> -                             uint64_t prp1, uint64_t prp2, DMADirection dir,
> +/*
> + * Map 'nsgld' data descriptors from 'segment'. The function will subtract the
> + * number of bytes mapped in len.
> + */
> +static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
> +                                  QEMUIOVector *iov,
> +                                  NvmeSglDescriptor *segment, uint64_t nsgld,
> +                                  size_t *len, NvmeRequest *req)
> +{
> +    dma_addr_t addr, trans_len;
> +    uint32_t dlen;
> +    uint16_t status;
> +
> +    for (int i = 0; i < nsgld; i++) {
> +        uint8_t type = NVME_SGL_TYPE(segment[i].type);
> +
> +        switch (type) {
> +        case NVME_SGL_DESCR_TYPE_DATA_BLOCK:
> +            break;
> +        case NVME_SGL_DESCR_TYPE_SEGMENT:
> +        case NVME_SGL_DESCR_TYPE_LAST_SEGMENT:
> +            return NVME_INVALID_NUM_SGL_DESCRS | NVME_DNR;
> +        default:
> +            return NVME_SGL_DESCR_TYPE_INVALID | NVME_DNR;
> +        }
> +
> +        dlen = le32_to_cpu(segment[i].len);
> +        if (!dlen) {
> +            continue;
> +        }
> +
> +        if (*len == 0) {
> +            /*
> +             * All data has been mapped, but the SGL contains additional
> +             * segments and/or descriptors. The controller might accept
> +             * ignoring the rest of the SGL.
> +             */
> +            uint16_t sgls = le16_to_cpu(n->id_ctrl.sgls);
> +            if (sgls & NVME_CTRL_SGLS_EXCESS_LENGTH) {
> +                break;
> +            }
> +
> +            trace_pci_nvme_err_invalid_sgl_excess_length(nvme_cid(req));
> +            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
> +        }
> +
> +        trans_len = MIN(*len, dlen);
> +        addr = le64_to_cpu(segment[i].addr);
> +
> +        if (UINT64_MAX - addr < dlen) {
> +            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
> +        }
> +
> +        status = nvme_map_addr(n, qsg, iov, addr, trans_len);
> +        if (status) {
> +            return status;
> +        }
> +
> +        *len -= trans_len;
> +    }
> +
> +    return NVME_SUCCESS;
> +}
> +
> +static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> +                             NvmeSglDescriptor sgl, size_t len,
>                                NvmeRequest *req)
> +{
> +    /*
> +     * Read the segment in chunks of 256 descriptors (one 4k page) to avoid
> +     * dynamically allocating a potentially huge SGL. The spec allows the SGL
> +     * to be larger (as in number of bytes required to describe the SGL
> +     * descriptors and segment chain) than the command transfer size, so it is
> +     * not bounded by MDTS.
> +     */
> +    const int SEG_CHUNK_SIZE = 256;
> +
> +    NvmeSglDescriptor segment[SEG_CHUNK_SIZE], *sgld, *last_sgld;
> +    uint64_t nsgld;
> +    uint32_t seg_len;
> +    uint16_t status;
> +    bool sgl_in_cmb = false;
> +    hwaddr addr;
> +    int ret;
> +
> +    sgld = &sgl;
> +    addr = le64_to_cpu(sgl.addr);
> +
> +    trace_pci_nvme_map_sgl(nvme_cid(req), NVME_SGL_TYPE(sgl.type), len);
> +
> +    /*
> +     * If the entire transfer can be described with a single data block it can
> +     * be mapped directly.
> +     */
> +    if (NVME_SGL_TYPE(sgl.type) == NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
> +        status = nvme_map_sgl_data(n, qsg, iov, sgld, 1, &len, req);
> +        if (status) {
> +            goto unmap;
> +        }
> +
> +        goto out;
> +    }
> +
> +    /*
> +     * If the segment is located in the CMB, the submission queue of the
> +     * request must also reside there.
> +     */
> +    if (nvme_addr_is_cmb(n, addr)) {
> +        if (!nvme_addr_is_cmb(n, req->sq->dma_addr)) {
> +            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +        }
> +
> +        sgl_in_cmb = true;
> +    }
> +
> +    for (;;) {
> +        switch (NVME_SGL_TYPE(sgld->type)) {
> +        case NVME_SGL_DESCR_TYPE_SEGMENT:
> +        case NVME_SGL_DESCR_TYPE_LAST_SEGMENT:
> +            break;
> +        default:
> +            return NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
> +        }
> +
> +        seg_len = le32_to_cpu(sgld->len);
> +
> +        /* check the length of the (Last) Segment descriptor */
> +        if (!seg_len || seg_len & 0xf) {
> +            return NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
> +        }
> +
> +        if (UINT64_MAX - addr < seg_len) {
> +            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
> +        }
> +
> +        nsgld = seg_len / sizeof(NvmeSglDescriptor);
> +
> +        while (nsgld > SEG_CHUNK_SIZE) {
> +            if (nvme_addr_read(n, addr, segment, sizeof(segment))) {
> +                trace_pci_nvme_err_addr_read(addr);
> +                status = NVME_DATA_TRAS_ERROR;
> +                goto unmap;
> +            }
> +
> +            status = nvme_map_sgl_data(n, qsg, iov, segment, SEG_CHUNK_SIZE,
> +                                       &len, req);
> +            if (status) {
> +                goto unmap;
> +            }
> +
> +            nsgld -= SEG_CHUNK_SIZE;
> +            addr += SEG_CHUNK_SIZE * sizeof(NvmeSglDescriptor);
> +        }
> +
> +        ret = nvme_addr_read(n, addr, segment, nsgld *
> +                             sizeof(NvmeSglDescriptor));
> +        if (ret) {
> +            trace_pci_nvme_err_addr_read(addr);
> +            status = NVME_DATA_TRAS_ERROR;
> +            goto unmap;
> +        }
> +
> +        last_sgld = &segment[nsgld - 1];
> +
> +        /* if the segment ends with a Data Block, then we are done */
> +        if (NVME_SGL_TYPE(last_sgld->type) == NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
> +            status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld, &len, req);
> +            if (status) {
> +                goto unmap;
> +            }
> +
> +            goto out;
> +        }
> +
> +        /*
> +         * If the last descriptor was not a Data Block, then the current
> +         * segment must not be a Last Segment.
> +         */
> +        if (NVME_SGL_TYPE(sgld->type) == NVME_SGL_DESCR_TYPE_LAST_SEGMENT) {
> +            status = NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
> +            goto unmap;
> +        }
> +
> +        sgld = last_sgld;
> +        addr = le64_to_cpu(sgld->addr);
> +
> +        /*
> +         * Do not map the last descriptor; it will be a Segment or Last Segment
> +         * descriptor and is handled by the next iteration.
> +         */
> +        status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld - 1, &len, req);
> +        if (status) {
> +            goto unmap;
> +        }
> +
> +        /*
> +         * If the next segment is in the CMB, make sure that the sgl was
> +         * already located there.
> +         */
> +        if (sgl_in_cmb != nvme_addr_is_cmb(n, addr)) {
> +            status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> +            goto unmap;
> +        }
> +    }
> +
> +out:
> +    /* if there is any residual left in len, the SGL was too short */
> +    if (len) {
> +        status = NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
> +        goto unmap;
> +    }
> +
> +    return NVME_SUCCESS;
> +
> +unmap:
> +    if (iov->iov) {
> +        qemu_iovec_destroy(iov);
> +    }
> +
> +    if (qsg->sg) {
> +        qemu_sglist_destroy(qsg);
> +    }
> +
> +    return status;
> +}
> +
> +static uint16_t nvme_map_dptr(NvmeCtrl *n, size_t len, NvmeRequest *req)
> +{
> +    uint64_t prp1, prp2;
> +
> +    switch (NVME_CMD_FLAGS_PSDT(req->cmd.flags)) {
> +    case NVME_PSDT_PRP:
> +        prp1 = le64_to_cpu(req->cmd.dptr.prp1);
> +        prp2 = le64_to_cpu(req->cmd.dptr.prp2);
> +
> +        return nvme_map_prp(n, prp1, prp2, len, req);
> +    case NVME_PSDT_SGL_MPTR_CONTIGUOUS:
> +    case NVME_PSDT_SGL_MPTR_SGL:
> +        /* SGLs shall not be used for Admin commands in NVMe over PCIe */
> +        if (!req->sq->sqid) {
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +
> +        return nvme_map_sgl(n, &req->qsg, &req->iov, req->cmd.dptr.sgl, len,
> +                            req);
> +    default:
> +        return NVME_INVALID_FIELD;
> +    }
> +}
> +
> +static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,

Using a 'void *ptr' would simplify your API, avoiding the callers
to cast.

> +                         DMADirection dir, NvmeRequest *req)
>   {
>       uint16_t status = NVME_SUCCESS;
>   
> -    status = nvme_map_prp(n, prp1, prp2, len, req);
> +    status = nvme_map_dptr(n, len, req);
>       if (status) {
>           return status;
>       }
> @@ -458,15 +707,6 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>       return status;
>   }
>   
> -static uint16_t nvme_map_dptr(NvmeCtrl *n, size_t len, NvmeRequest *req)
> -{
> -    NvmeCmd *cmd = &req->cmd;
> -    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> -    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> -
> -    return nvme_map_prp(n, prp1, prp2, len, req);
> -}


