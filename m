Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB00AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4794F2087C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxOlS3rS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4794F2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6wV-0004Ym-Aa
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX6ky-0006dM-SA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX6kw-0005Ip-Ot
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603735084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJfa0jC7Y3CUJJwA5JXbskXx8iclBV45WcZAZscCLGM=;
 b=gxOlS3rSE7bc75OVQrkgYCkb0GhRkb0689kW6nByoHrWWi+opM1VEdCxU7g43JLQzfkC/W
 i64Bi7bJ7oIMj0V0syHyZUM4CqR84DrMqMWG7pe0cqarSFgLRSB4DsFfbpXoTSCLTZGH03
 GrcuQ5LuHnkLeyNCac0MoAop5zkt1sQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-vbsQkWoaNVGpX8KevQ4_Uw-1; Mon, 26 Oct 2020 13:58:02 -0400
X-MC-Unique: vbsQkWoaNVGpX8KevQ4_Uw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0678804B61;
 Mon, 26 Oct 2020 17:58:00 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBF735D9E8;
 Mon, 26 Oct 2020 17:57:51 +0000 (UTC)
Subject: Re: [PATCH v2 04/19] block/nvme: Trace controller capabilities
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-5-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <791d70ed-667f-c979-a7b7-f6fc5ffcc2af@redhat.com>
Date: Mon, 26 Oct 2020 18:57:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-5-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 10/26/20 11:54 AM, Philippe Mathieu-Daudé wrote:
> Controllers have different capabilities and report them in the
> CAP register. We are particularly interested by the page size
> limits.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c       | 10 ++++++++++
>  block/trace-events |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 5abd7257cac..3b6d3972ec2 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -720,6 +720,16 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>       * Initialization". */
>  
>      cap = le64_to_cpu(regs->cap);
> +    trace_nvme_controller_capability("Maximum Queue Entries Supported",
> +                                     NVME_CAP_MQES(cap));
> +    trace_nvme_controller_capability("Contiguous Queues Required",
> +                                     NVME_CAP_CQR(cap));
> +    trace_nvme_controller_capability("Subsystem  Reset Supported",
nit extra space
> +                                     NVME_CAP_NSSRS(cap));
> +    trace_nvme_controller_capability("Memory Page Size Minimum",
> +                                     NVME_CAP_MPSMIN(cap));
> +    trace_nvme_controller_capability("Memory Page Size Maximum",
> +                                     NVME_CAP_MPSMAX(cap));
Don't you want to trace the true MPSMIN/MAX (I mean with the shift)?

I would personally group those traces into a single one and avoid this
generic trace format but well ...

Thanks

Eric
>      if (!NVME_CAP_CSS(cap)) {
>          error_setg(errp, "Device doesn't support NVMe command set");
>          ret = -EINVAL;
> diff --git a/block/trace-events b/block/trace-events
> index 0e351c3fa3d..3f141dc6801 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -134,6 +134,7 @@ qed_aio_write_postfill(void *s, void *acb, uint64_t start, size_t len, uint64_t
>  qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, size_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
>  
>  # nvme.c
> +nvme_controller_capability(const char *desc, uint64_t value) "%s: %"PRIu64
>  nvme_kick(void *s, int queue) "s %p queue %d"
>  nvme_dma_flush_queue_wait(void *s) "s %p"
>  nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
> 


