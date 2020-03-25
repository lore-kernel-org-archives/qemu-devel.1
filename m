Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB3FC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDCB206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zeuhgz70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDCB206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3XI-0007R8-RW
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Vc-0005dC-7f
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3VQ-0003YX-LX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:43:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52401)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3VQ-0003YA-Hc
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ab3ZxjSrpD3d/jRxdm/wZgkuCerlnBPqPu/oyZL+h8=;
 b=Zeuhgz70FtbapFCmuwJI9GX0uZUKNcS8q/mcUuP/1ZwP62cHeW9gaNgQSbnibQFOiuZO4M
 W/hGqM88sDjO9dgo/d3iRF31Kx2ykB/Z7a7xbdetkZr18EVH5DLKekwa0FfjYxxJrgIZgK
 dHT5mxXC5V5COKXAMfpC5CujyQHvL5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-bUkOBvxvPPeZsx3aYk57LA-1; Wed, 25 Mar 2020 06:43:26 -0400
X-MC-Unique: bUkOBvxvPPeZsx3aYk57LA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 898C218FF662;
 Wed, 25 Mar 2020 10:43:25 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7091794B5B;
 Wed, 25 Mar 2020 10:43:23 +0000 (UTC)
Message-ID: <e51f7634bc99cabb616801431a72f339df7d5541.camel@redhat.com>
Subject: Re: [PATCH v6 18/42] nvme: support identify namespace descriptor list
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:43:22 +0200
In-Reply-To: <20200316142928.153431-19-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-19-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Since we are not providing the NGUID or EUI64 fields, we must support
> the Namespace UUID. We do not have any way of storing a persistent
> unique identifier, so conjure up a UUID that is just the namespace id.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  hw/block/trace-events |  1 +
>  2 files changed, 39 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 16de3ca1c5d5..007f8817f101 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -942,6 +942,42 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>      return ret;
>  }
>  
> +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c)
> +{
> +    uint32_t nsid = le32_to_cpu(c->nsid);
> +    uint64_t prp1 = le64_to_cpu(c->prp1);
> +    uint64_t prp2 = le64_to_cpu(c->prp2);
> +
> +    void *list;
> +    uint16_t ret;
> +    NvmeIdNsDescr *ns_descr;
> +
> +    trace_nvme_dev_identify_ns_descr_list(nsid);
> +
> +    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> +        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
> +        return NVME_INVALID_NSID | NVME_DNR;
> +    }
> +
> +    list = g_malloc0(NVME_IDENTIFY_DATA_SIZE);
> +    ns_descr = list;
> +
> +    /*
> +     * Because the NGUID and EUI64 fields are 0 in the Identify Namespace data
> +     * structure, a Namespace UUID (nidt = 0x3) must be reported in the
> +     * Namespace Identification Descriptor. Add a very basic Namespace UUID
> +     * here.
> +     */
> +    ns_descr->nidt = NVME_NIDT_UUID;
> +    ns_descr->nidl = NVME_NIDT_UUID_LEN;
> +    stl_be_p(ns_descr + sizeof(*ns_descr), nsid);
> +
> +    ret = nvme_dma_read_prp(n, (uint8_t *) list, NVME_IDENTIFY_DATA_SIZE, prp1,
> +                            prp2);
> +    g_free(list);
> +    return ret;
> +}
> +
>  static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>  {
>      NvmeIdentify *c = (NvmeIdentify *)cmd;
> @@ -953,6 +989,8 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>          return nvme_identify_ctrl(n, c);
>      case NVME_ID_CNS_NS_ACTIVE_LIST:
>          return nvme_identify_nslist(n, c);
> +    case NVME_ID_CNS_NS_DESCR_LIST:
> +        return nvme_identify_ns_descr_list(n, c);
>      default:
>          trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
>          return NVME_INVALID_FIELD | NVME_DNR;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 13e2c71664f6..4cde0844ef64 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -41,6 +41,7 @@ nvme_dev_del_cq(uint16_t cqid) "deleted completion queue, sqid=%"PRIu16""
>  nvme_dev_identify_ctrl(void) "identify controller"
>  nvme_dev_identify_ns(uint32_t ns) "nsid %"PRIu32""
>  nvme_dev_identify_nslist(uint32_t ns) "nsid %"PRIu32""
> +nvme_dev_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
>  nvme_dev_getfeat(uint16_t cid, uint32_t fid) "cid %"PRIu16" fid 0x%"PRIx32""
>  nvme_dev_setfeat(uint16_t cid, uint32_t fid, uint32_t val) "cid %"PRIu16" fid 0x%"PRIx32" val 0x%"PRIx32""
>  nvme_dev_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"

I think that we should add namespace uuid as a device parameter,
but its OK to do this in follow up patch.


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




