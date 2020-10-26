Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A99C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23EB223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyjWmiyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23EB223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyC0-0005Ox-OT
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWyB4-0004w2-U1
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWyB1-0002d1-Kn
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603702105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Blnxy4gxss8QwI3enUZ0w5JCBe7LoEYdQukUEvDisMk=;
 b=eyjWmiyoz6f5kCgdea/OwQ/Sa41LbkCWo5t3lLGVDG6iqOLdWbgFooMXa83KvFlRG0fTzb
 Vvc+W8buQpfOApZOlaFRciyGGy/RKmxqEv/dnKA0PQMHuCUWoN8Uv7OxID9tchNdRG6M5T
 MiVfL0t3govfQQX0nhjNEJemobi8bv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-6nqbeNEZPxCq3cXVOerWpg-1; Mon, 26 Oct 2020 04:48:22 -0400
X-MC-Unique: 6nqbeNEZPxCq3cXVOerWpg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC90C804B74;
 Mon, 26 Oct 2020 08:48:20 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DFC662A14;
 Mon, 26 Oct 2020 08:48:12 +0000 (UTC)
Subject: Re: [PATCH v7 04/17] fuzz: Add DMA support to the generic-fuzzer
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20201023150746.107063-1-alxndr@bu.edu>
 <20201023150746.107063-5-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6766ee92-c6b4-6b3f-459e-ed3a93baf1c9@redhat.com>
Date: Mon, 26 Oct 2020 09:48:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201023150746.107063-5-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/2020 17.07, Alexander Bulekov wrote:
> When a virtual-device tries to access some buffer in memory over DMA, we
> add call-backs into the fuzzer(next commit). The fuzzer checks verifies
> that the DMA request maps to a physical RAM address and fills the memory
> with fuzzer-provided data. The patterns that we use to fill this memory
> are specified using add_dma_pattern and clear_dma_patterns operations.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> ---
>  include/exec/memory.h           |   7 +
>  tests/qtest/fuzz/generic_fuzz.c | 228 ++++++++++++++++++++++++++++++++
>  2 files changed, 235 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 042918dd16..93d27bff26 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -42,6 +42,13 @@ typedef struct IOMMUMemoryRegionClass IOMMUMemoryRegionClass;
>  DECLARE_OBJ_CHECKERS(IOMMUMemoryRegion, IOMMUMemoryRegionClass,
>                       IOMMU_MEMORY_REGION, TYPE_IOMMU_MEMORY_REGION)
>  
> +#ifdef CONFIG_FUZZ
> +void fuzz_dma_read_cb(size_t addr,
> +                      size_t len,
> +                      MemoryRegion *mr,
> +                      bool is_write);
> +#endif
> +
>  extern bool global_dirty_log;
>  
>  typedef struct MemoryRegionOps MemoryRegionOps;
> diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
> index 483d41fb2c..e6b18e4276 100644
> --- a/tests/qtest/fuzz/generic_fuzz.c
> +++ b/tests/qtest/fuzz/generic_fuzz.c
[...]
> +static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
> +{
> +    unsigned access_size_max = mr->ops->valid.max_access_size;
> +
> +    /* Regions are assumed to support 1-4 byte accesses unless
> +       otherwise specified.  */

Just FYI, I'll change this to use the QEMU multi-line comment style to avoid
a warning from checkpatch.pl.

> +    if (access_size_max == 0) {
> +        access_size_max = 4;
> +    }
> +
> +    /* Bound the maximum access by the alignment of the address.  */
> +    if (!mr->ops->impl.unaligned) {
> +        unsigned align_size_max = addr & -addr;
> +        if (align_size_max != 0 && align_size_max < access_size_max) {
> +            access_size_max = align_size_max;
> +        }
> +    }

 Thomas


