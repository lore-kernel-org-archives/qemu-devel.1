Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3B9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E843920720
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E843920720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIgZ-0005Rw-6G
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jrIe3-0001T4-Ij; Fri, 03 Jul 2020 06:10:11 -0400
Received: from charlie.dont.surf ([128.199.63.193]:53536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jrIe1-0006be-8q; Fri, 03 Jul 2020 06:10:11 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 5D064BF465;
 Fri,  3 Jul 2020 10:10:06 +0000 (UTC)
Date: Fri, 3 Jul 2020 12:10:03 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 11/18] hw/block/nvme: add remaining mandatory
 controller parameters
Message-ID: <20200703101003.iirx66jjnauvk7a3@apples.localdomain>
References: <20200703063420.2241014-1-its@irrelevant.dk>
 <20200703063420.2241014-12-its@irrelevant.dk>
 <e2cbec3f-896e-fa17-2aac-2c82e0d6df60@redhat.com>
 <20200703084626.xib465ie3vvladip@apples.localdomain>
 <05eda6c8-b6fc-b034-a76d-dc563427ed35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05eda6c8-b6fc-b034-a76d-dc563427ed35@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:42:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul  3 11:21, Philippe Mathieu-Daudé wrote:
> On 7/3/20 10:46 AM, Klaus Jensen wrote:
> > On Jul  3 10:31, Philippe Mathieu-Daudé wrote:
> >> On 7/3/20 8:34 AM, Klaus Jensen wrote:
> >>> From: Klaus Jensen <k.jensen@samsung.com>
> >>>
> >>> Add support for any remaining mandatory controller operating parameters
> >>> (features).
> >>>
> >>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> >>> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> >>> ---
> >>>  hw/block/nvme.c       | 39 +++++++++++++++++++++++++++++++++------
> >>>  hw/block/nvme.h       | 18 ++++++++++++++++++
> >>>  hw/block/trace-events |  2 ++
> >>>  include/block/nvme.h  |  7 +++++++
> >>>  4 files changed, 60 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> >>> index ba523f6768bf..affb9a967534 100644
> >>> --- a/hw/block/nvme.c
> >>> +++ b/hw/block/nvme.c
> >>> @@ -1056,8 +1056,16 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >>>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> >>>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> >>>      uint32_t result;
> >>> +    uint8_t fid = NVME_GETSETFEAT_FID(dw10);
> >>> +    uint16_t iv;
> >>>  
> >>> -    switch (dw10) {
> >>> +    trace_pci_nvme_getfeat(nvme_cid(req), fid, dw11);
> >>> +
> >>> +    if (!nvme_feature_support[fid]) {
> >>> +        return NVME_INVALID_FIELD | NVME_DNR;
> >>> +    }
> >>> +
> >>> +    switch (fid) {
> >>>      case NVME_TEMPERATURE_THRESHOLD:
> >>>          result = 0;
> >>>  
> >>> @@ -1088,14 +1096,27 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >>>                               ((n->params.max_ioqpairs - 1) << 16));
> >>>          trace_pci_nvme_getfeat_numq(result);
> >>>          break;
> >>> +    case NVME_INTERRUPT_VECTOR_CONF:
> >>> +        iv = dw11 & 0xffff;
> >>> +        if (iv >= n->params.max_ioqpairs + 1) {
> >>> +            return NVME_INVALID_FIELD | NVME_DNR;
> >>> +        }
> >>> +
> >>> +        result = iv;
> >>> +        if (iv == n->admin_cq.vector) {
> >>> +            result |= NVME_INTVC_NOCOALESCING;
> >>> +        }
> >>> +
> >>> +        result = cpu_to_le32(result);
> >>> +        break;
> >>>      case NVME_ASYNCHRONOUS_EVENT_CONF:
> >>>          result = cpu_to_le32(n->features.async_config);
> >>>          break;
> >>>      case NVME_TIMESTAMP:
> >>>          return nvme_get_feature_timestamp(n, cmd);
> >>>      default:
> >>> -        trace_pci_nvme_err_invalid_getfeat(dw10);
> >>> -        return NVME_INVALID_FIELD | NVME_DNR;
> >>> +        result = cpu_to_le32(nvme_feature_default[fid]);
> >>
> >> So here we expect uninitialized fid entries to return 0, right?
> >>
> > 
> > Yes, if defaults are not 0 (like NVME_ARBITRATION), it is explicitly set.
> > 
> >>> +        break;
> >>>      }
> >>>  
> >>>      req->cqe.result = result;
> >>> @@ -1124,8 +1145,15 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >>>  {
> >>>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> >>>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> >>> +    uint8_t fid = NVME_GETSETFEAT_FID(dw10);
> >>>  
> >>> -    switch (dw10) {
> >>> +    trace_pci_nvme_setfeat(nvme_cid(req), fid, dw11);
> >>> +
> >>> +    if (!nvme_feature_support[fid]) {
> >>> +        return NVME_INVALID_FIELD | NVME_DNR;
> >>> +    }
> >>> +
> >>> +    switch (fid) {
> >>>      case NVME_TEMPERATURE_THRESHOLD:
> >>>          if (NVME_TEMP_TMPSEL(dw11) != NVME_TEMP_TMPSEL_COMPOSITE) {
> >>>              break;
> >>> @@ -1172,8 +1200,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >>>      case NVME_TIMESTAMP:
> >>>          return nvme_set_feature_timestamp(n, cmd);
> >>>      default:
> >>> -        trace_pci_nvme_err_invalid_setfeat(dw10);
> >>> -        return NVME_INVALID_FIELD | NVME_DNR;
> >>> +        return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
> >>>      }
> >>>      return NVME_SUCCESS;
> >>>  }
> >>> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> >>> index f8940435f9ef..8ad1e3c89cee 100644
> >>> --- a/hw/block/nvme.h
> >>> +++ b/hw/block/nvme.h
> >>> @@ -87,6 +87,24 @@ typedef struct NvmeFeatureVal {
> >>>      uint32_t    async_config;
> >>>  } NvmeFeatureVal;
> 
> What do you think about adding:
> 
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -804,7 +804,8 @@ enum NvmeFeatureIds {
>      NVME_WRITE_ATOMICITY            = 0xa,
>      NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
>      NVME_TIMESTAMP                  = 0xe,
> -    NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
> +    NVME_SOFTWARE_PROGRESS_MARKER   = 0x80,
> +    NVME_FEATURE_ID_COUNT           = 0x100
>  };
> 

I can definitely go with that. I added it as NVME_FID_MAX.

> >>>  
> >>> +static const uint32_t nvme_feature_default[0x100] = {
> 
> Why uint32_t and not uint16_t?
> 

The feature values are by definition 32 bits wide, so even though the
defaults here do not require it, I think uin32_t should be used.

> With the previously suggested enum you can now replace 0x100
> by NVME_FEATURE_ID_COUNT.
> 
> >>> +    [NVME_ARBITRATION]           = NVME_ARB_AB_NOLIMIT,
> >>> +};
> >>> +
> >>> +static const bool nvme_feature_support[0x100] = {
> 
> Ditto NVME_FEATURE_ID_COUNT.
> 

Fixed!

