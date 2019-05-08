Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B35C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 10:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814EA20578
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 10:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814EA20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOJZK-00075t-NZ
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 06:12:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOJVy-0004Qb-GY
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOJVx-0002Oc-BW
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:09:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOJVx-0002OG-3w
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:09:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so1166509wrs.11
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 03:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=OUPTZ9bmYSRVegrs72g5diU7N5st/rOc77kRtE/N3wI=;
	b=WUhc+0yRIJPVkuV6hSi1OCKBOIChXdT0Xf+fDSIjl7qP9guL2PFP+rIt7ZXFQRT/r8
	bPBywKzKZm514wjjraGEAkwZny6+krbkJq8tz3nBoNA6X+mTcozYwyP5FsZus+ChSosI
	FFvTRDQvEWnX9vhS0JMGaMfzHjjVKiE5pOoGbkvyFmre60Wp/o1mpMv4q1hATg5ROQve
	o7QnZ75nZEJtxriQ+bL7Vjozw4LPOzUM9Ysd88gO5O2/MwHla3zIq26zpQrmRw1UsG/r
	lPdLHBmLUKOh9PAvUibVdyCgru5a2V6Fa7E5oQ5Lko8FVAf+oDSfAH3xqUyXv+CjW3Yw
	YG1w==
X-Gm-Message-State: APjAAAX/mAuboomkOzB+lFuE0E88jdo1GbAr82vq7T1kZRXXzZ1tgc3l
	yoNBfwve983cf61PiUIPlhRfdvtTD2d5KQ==
X-Google-Smtp-Source: APXvYqykc0X+IX15YhooVNHQOr5SIdDd3oXqlQkDut2cFc98EcjSIyl2SjMBfGEf8JgBFtAsV7b74Q==
X-Received: by 2002:adf:f68c:: with SMTP id v12mr27268505wrp.40.1557310167854; 
	Wed, 08 May 2019 03:09:27 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id 15sm3822721wmx.23.2019.05.08.03.09.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 03:09:27 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190508061523.17666-1-peterx@redhat.com>
	<20190508061523.17666-3-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c2344db1-1afd-ba7d-f505-c97bd6dfc7ec@redhat.com>
Date: Wed, 8 May 2019 12:09:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508061523.17666-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 02/11] memory: Remove
 memory_region_get_dirty()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/05/19 01:15, Peter Xu wrote:
> It's never used anywhere.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/exec/memory.h | 17 -----------------
>  memory.c              |  8 --------
>  2 files changed, 25 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9144a47f57..e6140e8a04 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1254,23 +1254,6 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize,
>   */
>  void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client);
>  
> -/**
> - * memory_region_get_dirty: Check whether a range of bytes is dirty
> - *                          for a specified client.
> - *
> - * Checks whether a range of bytes has been written to since the last
> - * call to memory_region_reset_dirty() with the same @client.  Dirty logging
> - * must be enabled.
> - *
> - * @mr: the memory region being queried.
> - * @addr: the address (relative to the start of the region) being queried.
> - * @size: the size of the range being queried.
> - * @client: the user of the logging information; %DIRTY_MEMORY_MIGRATION or
> - *          %DIRTY_MEMORY_VGA.
> - */
> -bool memory_region_get_dirty(MemoryRegion *mr, hwaddr addr,
> -                             hwaddr size, unsigned client);
> -
>  /**
>   * memory_region_set_dirty: Mark a range of bytes as dirty in a memory region.
>   *
> diff --git a/memory.c b/memory.c
> index bb2b71ee38..0cce3a6fc5 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2027,14 +2027,6 @@ void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
>      memory_region_transaction_commit();
>  }
>  
> -bool memory_region_get_dirty(MemoryRegion *mr, hwaddr addr,
> -                             hwaddr size, unsigned client)
> -{
> -    assert(mr->ram_block);
> -    return cpu_physical_memory_get_dirty(memory_region_get_ram_addr(mr) + addr,
> -                                         size, client);
> -}
> -
>  void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
>                               hwaddr size)
>  {
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

