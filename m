Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F28C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E619722243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJ3dAVxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E619722243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvR9-0002Jt-Kp
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZvQ5-0000qe-20
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:28:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZvQ2-0002Ox-3D
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604406488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+kCFMAsGbUeYIdH9PeX9X7F46vpMFSv/h0MWgrfwkA=;
 b=QJ3dAVxfsw7aCnIdYcCIEqG1PDqWSW1rbEFLzcyvipd983Bubb3sUNFvsGTqF5Jhung+il
 1ZCeqr3QndKoZ0dD+7ctFbIuR86lEHPKN9RYtEmOARkHuZK0EZaaBzz0p1Eb92+3LMTSBY
 XiEgEtVkFORMgEiVmLev4+/pgr2a/0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-zP77GQpnOH6G7Eg-tTZWeQ-1; Tue, 03 Nov 2020 07:28:06 -0500
X-MC-Unique: zP77GQpnOH6G7Eg-tTZWeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92B178030B3;
 Tue,  3 Nov 2020 12:28:05 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA1A25D9CC;
 Tue,  3 Nov 2020 12:27:59 +0000 (UTC)
Date: Tue, 3 Nov 2020 13:27:56 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Xinhao Zhang <zhangxinhao1@huawei.com>
Subject: Re: [PATCH 1/3] hw/acpi : Don't use '#' flag of printf format
Message-ID: <20201103132756.5e9e1bbd@redhat.com>
In-Reply-To: <20201103102634.273021-1-zhangxinhao1@huawei.com>
References: <20201103102634.273021-1-zhangxinhao1@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, alex.chen@huawei.com, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 18:26:32 +0800
Xinhao Zhang <zhangxinhao1@huawei.com> wrote:

> Fix code style. Don't use '#' flag of printf format ('%#') in
> format strings, use '0x' prefix instead
> 
> Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
> Signed-off-by: Kai Deng <dengkai1@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

---
PS: in future please use --cover-letter when sending series of multiple patches.

> ---
>  hw/acpi/nvdimm.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 8f7cc16add..8ad5516142 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -556,7 +556,7 @@ static void nvdimm_dsm_func_read_fit(NVDIMMState *state, NvdimmDsmIn *in,
>  
>      fit = fit_buf->fit;
>  
> -    nvdimm_debug("Read FIT: offset %#x FIT size %#x Dirty %s.\n",
> +    nvdimm_debug("Read FIT: offset 0x%x FIT size 0x%x Dirty %s.\n",
>                   read_fit->offset, fit->len, fit_buf->dirty ? "Yes" : "No");
>  
>      if (read_fit->offset > fit->len) {
> @@ -664,7 +664,7 @@ static void nvdimm_dsm_label_size(NVDIMMDevice *nvdimm, hwaddr dsm_mem_addr)
>      label_size = nvdimm->label_size;
>      mxfer = nvdimm_get_max_xfer_label_size();
>  
> -    nvdimm_debug("label_size %#x, max_xfer %#x.\n", label_size, mxfer);
> +    nvdimm_debug("label_size 0x%x, max_xfer 0x%x.\n", label_size, mxfer);
>  
>      label_size_out.func_ret_status = cpu_to_le32(NVDIMM_DSM_RET_STATUS_SUCCESS);
>      label_size_out.label_size = cpu_to_le32(label_size);
> @@ -680,19 +680,19 @@ static uint32_t nvdimm_rw_label_data_check(NVDIMMDevice *nvdimm,
>      uint32_t ret = NVDIMM_DSM_RET_STATUS_INVALID;
>  
>      if (offset + length < offset) {
> -        nvdimm_debug("offset %#x + length %#x is overflow.\n", offset,
> +        nvdimm_debug("offset 0x%x + length 0x%x is overflow.\n", offset,
>                       length);
>          return ret;
>      }
>  
>      if (nvdimm->label_size < offset + length) {
> -        nvdimm_debug("position %#x is beyond label data (len = %" PRIx64 ").\n",
> +        nvdimm_debug("position 0x%x is beyond label data (len = %" PRIx64 ").\n",
>                       offset + length, nvdimm->label_size);
>          return ret;
>      }
>  
>      if (length > nvdimm_get_max_xfer_label_size()) {
> -        nvdimm_debug("length (%#x) is larger than max_xfer (%#x).\n",
> +        nvdimm_debug("length (0x%x) is larger than max_xfer (0x%x).\n",
>                       length, nvdimm_get_max_xfer_label_size());
>          return ret;
>      }
> @@ -716,7 +716,7 @@ static void nvdimm_dsm_get_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
>      get_label_data->offset = le32_to_cpu(get_label_data->offset);
>      get_label_data->length = le32_to_cpu(get_label_data->length);
>  
> -    nvdimm_debug("Read Label Data: offset %#x length %#x.\n",
> +    nvdimm_debug("Read Label Data: offset 0x%x length 0x%x.\n",
>                   get_label_data->offset, get_label_data->length);
>  
>      status = nvdimm_rw_label_data_check(nvdimm, get_label_data->offset,
> @@ -755,7 +755,7 @@ static void nvdimm_dsm_set_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
>      set_label_data->offset = le32_to_cpu(set_label_data->offset);
>      set_label_data->length = le32_to_cpu(set_label_data->length);
>  
> -    nvdimm_debug("Write Label Data: offset %#x length %#x.\n",
> +    nvdimm_debug("Write Label Data: offset 0x%x length 0x%x.\n",
>                   set_label_data->offset, set_label_data->length);
>  
>      status = nvdimm_rw_label_data_check(nvdimm, set_label_data->offset,
> @@ -838,7 +838,7 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>      NvdimmDsmIn *in;
>      hwaddr dsm_mem_addr = val;
>  
> -    nvdimm_debug("dsm memory address %#" HWADDR_PRIx ".\n", dsm_mem_addr);
> +    nvdimm_debug("dsm memory address 0x%" HWADDR_PRIx ".\n", dsm_mem_addr);
>  
>      /*
>       * The DSM memory is mapped to guest address space so an evil guest
> @@ -852,11 +852,11 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>      in->function = le32_to_cpu(in->function);
>      in->handle = le32_to_cpu(in->handle);
>  
> -    nvdimm_debug("Revision %#x Handler %#x Function %#x.\n", in->revision,
> +    nvdimm_debug("Revision 0x%x Handler 0x%x Function 0x%x.\n", in->revision,
>                   in->handle, in->function);
>  
>      if (in->revision != 0x1 /* Currently we only support DSM Spec Rev1. */) {
> -        nvdimm_debug("Revision %#x is not supported, expect %#x.\n",
> +        nvdimm_debug("Revision 0x%x is not supported, expect 0x%x.\n",
>                       in->revision, 0x1);
>          nvdimm_dsm_no_payload(NVDIMM_DSM_RET_STATUS_UNSUPPORT, dsm_mem_addr);
>          goto exit;


