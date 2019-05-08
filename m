Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30211C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 10:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D3920578
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 10:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D3920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34209 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOJWb-0004dm-21
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 06:10:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOJVc-0004GO-1Y
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOJVa-0002Gz-GZ
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:09:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOJVa-0002F5-Aa
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:09:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id j187so2486890wmj.1
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 03:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=0hnsObrnE+yAqmrYPin9nzrZ/lplUfXQpq+5wKVmnSc=;
	b=sFg9Y6wKG0hJF5D01n9FUNJrC1DHfvzxnHLR3RhsE41Gc7hNnvvcB00Ud0RcyY/EKl
	4n4wOmMVcan5mCqWF05AiYE4ivxCxzbRshlDqvLLVWlr6pj432KU95/YJacSxXuxaQ3/
	weroNgahydR+9YI85PN/RwTYX8VGX4ECjlznrSmBFveatoy9D+rQNwIdbm8J78rycLbY
	Q5tBKKVOUULXAE89g/H8nDDlaoJASCFsXbYBMlFCbm2ecnBE/lVYmnnlj8WcDs2HoDS+
	pq9fyqbhEbyUKnSgZbovILt+ArwRUAWHmz8oQN3mXMOBQeVlfbKTZIXiuF3VFcdFmWV3
	g0MA==
X-Gm-Message-State: APjAAAXY3iaGZectNzLTZ1jg1PhHJf446R9Pn2740Vi2wp4KpMcyomfZ
	EdTMVB+X492Xyz7rW76jHMAebw==
X-Google-Smtp-Source: APXvYqx2CnJxtUfDQyq14LPpvR8iFnkcCrFV4KtYM+IIp3677BBpAwRcs84n5Y+uB3692vZDzn/oUA==
X-Received: by 2002:a05:600c:3d1:: with SMTP id
	z17mr2411613wmd.27.1557310142719; 
	Wed, 08 May 2019 03:09:02 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id z74sm3111762wmc.2.2019.05.08.03.09.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 03:09:02 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190508061523.17666-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4df1963e-5b76-4990-6c2f-a66ecd172869@redhat.com>
Date: Wed, 8 May 2019 12:09:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508061523.17666-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 00/11] kvm/migration: support
 KVM_CLEAR_DIRTY_LOG
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
> Design
> ===================
> 
> I started with a naive/stupid design that I always pass all 1's to the
> KVM for a memory range to clear all the dirty bits within that memory
> range, but then I encountered guest oops - it's simply because we
> can't clear any dirty bit from QEMU if we are not _sure_ that the bit
> is dirty in the kernel.  Otherwise we might accidentally clear a bit
> that we don't even know of (e.g., the bit was clear in migration's
> dirty bitmap in QEMU) but actually that page was just being written so
> QEMU will never remember to migrate that new page again.
> 
> The new design is focused on a dirty bitmap cache within the QEMU kvm
> layer (which is per kvm memory slot).  With that we know what's dirty
> in the kernel previously (note! the kernel bitmap is still growing all
> the time so the cache will only be a subset of the realtime kernel
> bitmap but that's far enough for us) and with that we'll be sure to
> not accidentally clear unknown dirty pages.
> 
> With this method, we can also avoid race when multiple users (e.g.,
> DIRTY_MEMORY_VGA and DIRTY_MEMORY_MIGRATION) want to clear the bit for
> multiple time.  If without the kvm memory slot cached dirty bitmap we
> won't be able to know which bit has been cleared and then if we send
> the CLEAR operation upon the same bit twice (or more) we can still
> face the same issue to clear something accidentally while we
> shouldn't.
> 
> Summary: we really need to be careful on what bit to clear otherwise
> we can face anything after the migration completes.  And I hope this
> series has considered all about this.

The disadvantage of this is that you won't clear in the kernel those
dirty bits that come from other sources (e.g. vhost or
address_space_map).  This can lead to double-copying of pages.

Migration already makes a local copy in rb->bmap, and
memory_region_snapshot_and_clear_dirty can also do the clear.  Would it
be possible to invoke the clear using rb->bmap instead of the KVMSlot's
new bitmap?

Thanks,

Paolo

> Besides the new KVM cache layer and the new ioctl support, this series
> introduced the memory_region_clear_dirty_bitmap() in the memory API
> layer to allow clearing dirty bits of a specific memory range within
> the memory region.


