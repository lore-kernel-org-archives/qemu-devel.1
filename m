Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAEDC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F6420651
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F6420651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hziaU-0003Hg-PV
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hziZt-0002ou-PY
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hziZs-0005ID-IY
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:24:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hziZs-0005HW-An
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:24:08 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32D8A3CA20
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:24:07 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id m25so588843wml.6
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 07:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UYoP4ap75BgV9gHM83kDJAvxCFDShHi9YtrlpePx6xk=;
 b=Py/xwviCkFbnazQOtLw6Q0NwI0Nz5wii0NM64sDjjua60ZfPnBJnXENfJuulkMGs+k
 8Tk7FaE/mezmgadLIxrNDdFPR3XE4m9tJNpbAztCOhomH/NAIHFX7JSgcMDtLsxqWB1R
 Nap5mQAvJL9ClLlFDMHg3F4dpGW1+rkVdQ5sjDsoSGTwPrW0Aa9F9uA+V+U2iI0M7TsN
 QLNP7iduDOzFV43E32IHxcgZoWY6+ygXcFvnS/zx8v4y6s/T5C6XUsPUPXJs3lKn7nzc
 Y2MCMCwIkphqMr8lQRqfsvPew72QxBHQqh3mwPD5dsVjF192i2xjHfoitvvLmEy3yX0c
 pEww==
X-Gm-Message-State: APjAAAXLFUdsxdw26fIGNbVrEG4YF1/A5FMl6QGztooanGA3hQ9H5bkT
 wIcnz2j4gsVUWFRbJZSgIr9pIyiNA06POkJDK7SHNjcDiqaevg6xRT9RpnWR6DqG/cgjceqaJ3L
 TFt9amh7FVmSe8rc=
X-Received: by 2002:a7b:c928:: with SMTP id h8mr21494305wml.93.1566224645643; 
 Mon, 19 Aug 2019 07:24:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRE/emwS3anUAetRuK4cBHwbQG3EhReoIwljN4oyvpa28hFSPgGJc8VCunAUPi75hZ26rLPw==
X-Received: by 2002:a7b:c928:: with SMTP id h8mr21494272wml.93.1566224645347; 
 Mon, 19 Aug 2019 07:24:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f?
 ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
 by smtp.gmail.com with ESMTPSA id z8sm15150440wru.13.2019.08.19.07.24.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 07:24:04 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190817093237.27967-1-peterx@redhat.com>
 <20190817093237.27967-3-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6469f348-b523-5a6f-f51f-d6a2ffd4c367@redhat.com>
Date: Mon, 19 Aug 2019 16:24:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817093237.27967-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] memory: Split zones when do
 coalesced_io_del()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/08/19 11:32, Peter Xu wrote:
> It is a workaround of current KVM's KVM_UNREGISTER_COALESCED_MMIO
> interface.  The kernel interface only allows to unregister an mmio
> device with exactly the zone size when registered, or any smaller zone
> that is included in the device mmio zone.  It does not support the
> userspace to specify a very large zone to remove all the small mmio
> devices within the zone covered.
> 
> Logically speaking it would be nicer to fix this from KVM side, though
> in all cases we still need to coop with old kernels so let's do this.
> 
> This patch has nothing to do with 3ac7d43a6fbb5d4a3 because this is
> probably broken from the very beginning when the
> KVM_UNREGISTER_COALESCED_MMIO interface is introduced in kernel.
> However to make the backport to stables easier, I'm still using the
> commit 3ac7d43a6fbb5d4a3 to track this problem because this will
> depend on that otherwise even additions of mmio devices won't work.
> 
> Fixes: 3ac7d43a6fbb5d4a3
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  memory.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)

This is still messy because memory_region_add_coalescing and
memory_region_clear_coalescing modify fr->mr->colesced.

It's not hard to fix it, but not trivial either.  Probably it is
sufficient to replace memory_region_update_coalesced_range and
memory_region_update_coalesced_range_as with two pairs:

- memory_region_add_coalesced_range and
memory_region_add_coalesced_range_as, which call a new function
flat_range_coalesced_io_add_one to call the listener only on the
newly-added range (and set coalesced_mmio_add_done).
memory_region_add_coalescing then can call
memory_region_add_coalesced_range_as

- memory_region_clear_coalesced_ranges and
memory_region_clear_coalesced_ranges_as, which call
flat_range_coalesced_io_del.  Now memory_region_clear_coalescing can
call memory_region_clear_coalesced_ranges *before* emptying the list, or
exit immediately if it is empty.

Thanks,

Paolo

> diff --git a/memory.c b/memory.c
> index 1a2b465a96..b24cdd13cf 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -864,6 +864,9 @@ static void address_space_update_ioeventfds(AddressSpace *as)
>  
>  static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
>  {
> +    CoalescedMemoryRange *cmr;
> +    AddrRange tmp;
> +
>      if (QTAILQ_EMPTY(&fr->mr->coalesced)) {
>          return;
>      }
> @@ -874,9 +877,30 @@ static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
>  
>      fr->coalesced_mmio_del_done = true;
>  
> -    MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
> -                                  int128_get64(fr->addr.start),
> -                                  int128_get64(fr->addr.size));
> +    /*
> +     * We split the big region into smaller ones to satisfy KVM's
> +     * KVM_UNREGISTER_COALESCED_MMIO interface, where it does not
> +     * allow to specify a large region to unregister all the devices
> +     * under that zone instead it only accepts exact zones or even a
> +     * smaller zone of previously registered mmio device.  Logically
> +     * speaking we should better fix KVM to allow the userspace to
> +     * unregister multiple mmio devices within a large requested zone,
> +     * but in all cases we'll still need to live with old kernels.  So
> +     * let's simply break the zones into exactly the small pieces when
> +     * we do coalesced_io_add().
> +     */
> +    QTAILQ_FOREACH(cmr, &fr->mr->coalesced, link) {
> +        tmp = addrrange_shift(cmr->addr,
> +                              int128_sub(fr->addr.start,
> +                                         int128_make64(fr->offset_in_region)));
> +        if (!addrrange_intersects(tmp, fr->addr)) {
> +            continue;
> +        }
> +        tmp = addrrange_intersection(tmp, fr->addr);
> +        MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
> +                                      int128_get64(tmp.start),
> +                                      int128_get64(tmp.size));
> +    }
>  }
>  
>  static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
> 


