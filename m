Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73715C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D9D206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKvaDcUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D9D206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcLA-0001hv-8l
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOcKY-0001Ci-GV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOcKX-0008Pz-9H
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:19:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49876
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOcKX-0008PI-61
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586935167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Vf3NY3+IFnyD8lQacXF6q5X98HTLg+E5TvQ3oZfoWo=;
 b=XKvaDcUu8TQAlyu4QFdOk++HnWW0NenUeFTfB1ODZLnHFcvjxYFQLgxWaXH/+r/ylOvAoh
 Wx46GlPf5PxH6A8feF+E+aaXrVcenDfB6AxOzV8MUbQhyab/9oxDPWUOtEy9f6EZdJVoDd
 G0mY5jf9mrsUN+kg47KO2rACKoP16aA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-HKfPRn0oOCSxcgHtgYn1zQ-1; Wed, 15 Apr 2020 03:19:25 -0400
X-MC-Unique: HKfPRn0oOCSxcgHtgYn1zQ-1
Received: by mail-ed1-f71.google.com with SMTP id l25so2195288edt.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Vf3NY3+IFnyD8lQacXF6q5X98HTLg+E5TvQ3oZfoWo=;
 b=da/p1k84EJ31ccOiBLEMk/6bXjfIypNEEqoBNFjEc9m4AxTdz52g4DokU4IM1HeVgZ
 h0uBDkYFeQ30I9CGT/1hlJsdwAHjMic6+uZKVJbHqpuOya5M2uWoeas9B5zLkrNUp3RN
 Reu6mR4q0W+pDdI0XJsmkvKRDz5WSWeI/B72bD4xRjm3bBnN2l8nBUkoqJo+yOKiPPik
 gvBhXmXcejCyIZJCyaN1XXdkha8ejXY58TAhxqOcqv2AoVeZ5jikEzm35g0KHCMYQ7CI
 Zd2tamIWboM/o5aVGKmjas5ByP/7C7ZFegAMOKwZDmSfAtLufZ7BwuOqLwble397OZ/9
 KYWQ==
X-Gm-Message-State: AGi0Pua1/8FLFq8aHIlT9UkXQzb8IdM2QvyKYocODyOg4d65yD/eSI/d
 VMVEntn2TNYsnhVU8eRGUQ7sIx4ywOCg24EES54/RDxAh38WcnvbyDEgYmGTtRn2nmjAze6wNK1
 CUAhWJqU+bogvgzA=
X-Received: by 2002:a17:906:2584:: with SMTP id
 m4mr3739206ejb.200.1586935164632; 
 Wed, 15 Apr 2020 00:19:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypL00t7KM+vQ43tEjZeBXiXZv8ox/gmqbrV3Amjrz0nIRnEMR0np17SkkPgiH4wRy/3RE/cQjQ==
X-Received: by 2002:a17:906:2584:: with SMTP id
 m4mr3739184ejb.200.1586935164389; 
 Wed, 15 Apr 2020 00:19:24 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l91sm2002296ede.64.2020.04.15.00.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 00:19:23 -0700 (PDT)
Subject: Re: [PATCH v7 12/48] nvme: add temperature threshold feature
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-13-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0ab46987-8026-c059-1470-6cac2e6cbcbb@redhat.com>
Date: Wed, 15 Apr 2020 09:19:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415055140.466900-13-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 7:51 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> It might seem wierd to implement this feature for an emulated device,

'weird'

> but it is mandatory to support and the feature is useful for testing
> asynchronous event request support, which will be added in a later
> patch.

Which patch? I can't find how you set the temperature in this series.

> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   hw/block/nvme.c      | 48 ++++++++++++++++++++++++++++++++++++++++++++
>   hw/block/nvme.h      |  1 +
>   include/block/nvme.h |  8 +++++++-
>   3 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index d1c42ee4765c..e777cc9075c1 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -45,6 +45,9 @@
>   #include "nvme.h"
>   
>   #define NVME_CMB_BIR 2
> +#define NVME_TEMPERATURE 0x143
> +#define NVME_TEMPERATURE_WARNING 0x157
> +#define NVME_TEMPERATURE_CRITICAL 0x175
>   
>   #define NVME_GUEST_ERR(trace, fmt, ...) \
>       do { \
> @@ -798,9 +801,31 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
>   static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>   {
>       uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> +    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>       uint32_t result;
>   
>       switch (dw10) {
> +    case NVME_TEMPERATURE_THRESHOLD:
> +        result = 0;
> +
> +        /*
> +         * The controller only implements the Composite Temperature sensor, so
> +         * return 0 for all other sensors.
> +         */
> +        if (NVME_TEMP_TMPSEL(dw11) != NVME_TEMP_TMPSEL_COMPOSITE) {
> +            break;
> +        }
> +
> +        switch (NVME_TEMP_THSEL(dw11)) {
> +        case NVME_TEMP_THSEL_OVER:
> +            result = cpu_to_le16(n->features.temp_thresh_hi);
> +            break;
> +        case NVME_TEMP_THSEL_UNDER:
> +            result = cpu_to_le16(n->features.temp_thresh_low);
> +            break;
> +        }
> +
> +        break;
>       case NVME_VOLATILE_WRITE_CACHE:
>           result = blk_enable_write_cache(n->conf.blk);
>           trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
> @@ -845,6 +870,23 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>       uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>   
>       switch (dw10) {
> +    case NVME_TEMPERATURE_THRESHOLD:
> +        if (NVME_TEMP_TMPSEL(dw11) != NVME_TEMP_TMPSEL_COMPOSITE) {
> +            break;
> +        }
> +
> +        switch (NVME_TEMP_THSEL(dw11)) {
> +        case NVME_TEMP_THSEL_OVER:
> +            n->features.temp_thresh_hi = NVME_TEMP_TMPTH(dw11);
> +            break;
> +        case NVME_TEMP_THSEL_UNDER:
> +            n->features.temp_thresh_low = NVME_TEMP_TMPTH(dw11);
> +            break;
> +        default:
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +
> +        break;
>       case NVME_VOLATILE_WRITE_CACHE:
>           blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
>           break;
> @@ -1373,6 +1415,7 @@ static void nvme_init_state(NvmeCtrl *n)
>       n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
>       n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
>       n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
> +    n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
>   }
>   
>   static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> @@ -1450,6 +1493,11 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>       id->acl = 3;
>       id->frmw = 7 << 1;
>       id->lpa = 1 << 0;
> +
> +    /* recommended default value (~70 C) */
> +    id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
> +    id->cctemp = cpu_to_le16(NVME_TEMPERATURE_CRITICAL);
> +
>       id->sqes = (0x6 << 4) | 0x6;
>       id->cqes = (0x4 << 4) | 0x4;
>       id->nn = cpu_to_le32(n->num_namespaces);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index b7c465560eea..807c4ad19dcc 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -115,6 +115,7 @@ typedef struct NvmeCtrl {
>       NvmeSQueue      admin_sq;
>       NvmeCQueue      admin_cq;
>       NvmeIdCtrl      id_ctrl;
> +    NvmeFeatureVal  features;
>   } NvmeCtrl;
>   
>   static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index b30744068d46..a0519814ecec 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -688,7 +688,13 @@ enum NvmeIdCtrlOncs {
>   typedef struct NvmeFeatureVal {
>       uint32_t    arbitration;
>       uint32_t    power_mgmt;
> -    uint32_t    temp_thresh;
> +    union {
> +        struct {
> +            uint16_t temp_thresh_hi;
> +            uint16_t temp_thresh_low;
> +        };
> +        uint32_t temp_thresh;
> +    };
>       uint32_t    err_rec;
>       uint32_t    volatile_wc;
>       uint32_t    num_queues;
> 


