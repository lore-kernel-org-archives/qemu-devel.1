Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B3EC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79721214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8qXDfuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79721214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSj06-00050A-I7
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iSiym-0003cD-6l
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iSiyk-00014w-Ku
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:41:43 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:34298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iSiyk-00014R-C0
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:41:42 -0500
Received: by mail-il1-x143.google.com with SMTP id p6so2026006ilp.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=beurS30dVz2/YuV7ui9xnfzvdQ87X84xaIMxSAmPcls=;
 b=O8qXDfuKMgswevczNlpe51sEmIimUjl7BTsjfkRsxNNIujN4GCigmcBfF/Zln7XhWs
 IaYhPCk310t7WAjYEXq8E6Jy1z+HzDHowzJIHV/T1BKL/cLzfvV8Pfz+Iib8PaduxdkD
 on6eDttUwYXejGL7z6H0YkWsW6Vgh0gcVzxrq09+fFhMcGqj0sxsoKWinLJpBL5i4fMG
 aedz7P0qSZpmtAyGBFVY1MFycViFf5nGWSwyJdDiurzto0bJ/hRp3cAvQWsO3YYZFtdq
 qaxlV7H7oYakMUMCWrUeWnndbjB18GeZUVPsjlV89IFAfBkJPP5qKIOGIetlayWueLzB
 +oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=beurS30dVz2/YuV7ui9xnfzvdQ87X84xaIMxSAmPcls=;
 b=JjvfdLgk7WFvBu2yIwRGJ72KyAJkWGeNDElBzteRlCHVQE6pseppGem+bLanRM6uwz
 XfqfbfPu+hFl3w4ugW6Cij9HikO9EBWSlgrLiYQ08L0OOFLEXnUEGi0LI4+GgB6UiMwI
 XFCyRCc4dsWwNLys+EcZ1qfr3pyrENGMBlHNL5PatNeOr90bSDeFPFUykJYmDjJ74ys0
 pxhBj9DxWpBVK4wWJz9cxmomeNVS+Jl+Z7Csalt7f6Ub1k5PftfLIxnCEsG6gSh217y/
 PiWLITTdDFRairc42ahVk//xFLcbaMKk0SXbMH8FJiguOy9GLwUPDuC9ewz766tvVHCS
 /8Tg==
X-Gm-Message-State: APjAAAUbGCshkYvGsWJVyzIWdKEtfX6S5YlrxjoeJhRu7VSjwBQ34eNH
 WSYlW+vq+aqE8lWiONIiSeUlgl8WRPbOnKgo44bLYQ==
X-Google-Smtp-Source: APXvYqzK3KJBelcRjH/eBhtaIbfS9XsunYhYvVDHKr84kv7NYPNjEPj49Mp2C7wf/YnNe3dEV485cFDsT6E5JmMeCFQ=
X-Received: by 2002:a92:60b:: with SMTP id x11mr3091170ilg.69.1573137701158;
 Thu, 07 Nov 2019 06:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20191105234100.22052-1-beata.michalska@linaro.org>
 <20191105234100.22052-3-beata.michalska@linaro.org>
 <5c75bd31-213f-88a4-2eee-0046f99f65fe@linaro.org>
In-Reply-To: <5c75bd31-213f-88a4-2eee-0046f99f65fe@linaro.org>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Thu, 7 Nov 2019 14:41:29 +0000
Message-ID: <CADSWDztHetgmbUOp4WyRAkR0daAG6kkwhUTcyKWiCTWHQ1XB=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Memory: Enable writeback for given memory region
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>, quintela@redhat.com,
 qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 Nov 2019 at 12:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/6/19 12:40 AM, Beata Michalska wrote:
> > +void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length)
> > +{
> > +    void *addr = ramblock_ptr(block, start);
> > +
> > +    /*
> > +     * The requested range might spread up to the very end of the block
> > +     */
> > +    if ((start + length) > block->used_length) {
> > +        qemu_log("%s: sync range outside the block boundaries: "
> > +                     "start: " RAM_ADDR_FMT " length: " RAM_ADDR_FMT
> > +                     " block length: " RAM_ADDR_FMT " Narrowing down ..." ,
> > +                     __func__, start, length, block->used_length);
> > +        length = block->used_length - start;
> > +    }
>
> qemu_log_mask w/ GUEST_ERROR?  How do we expect the length to overflow?

In theory it shouldn't, at least with current usage.
I guess the probe_access will make sure of that.
This was more of a precaution to enable catching potential/future misuses
aka debugging purpose. I can get rid of that it that's playing too safe.

>
> > +#ifdef CONFIG_LIBPMEM
> > +    /* The lack of support for pmem should not block the sync */
> > +    if (ramblock_is_pmem(block)) {
> > +        pmem_persist(addr, length);
> > +    } else
> > +#endif
>
> Perhaps better to return out of that if block than have the dangling else.

Good idea
>
> > +/**
> > + * Sync changes made to the memory mapped file back to the backing
> > + * storage. For POSIX compliant systems this will simply fallback
> > + * to regular msync call (thus the required alignment). Otherwise
> > + * it will trigger whole file sync (including the metadata case
> > + * there is no support to skip that otherwise)
> > + *
> > + * @addr   - start of the memory area to be synced
> > + * @length - length of the are to be synced
> > + * @align  - alignment (expected to be PAGE_SIZE)
> > + * @fd     - file descriptor for the file to be synced
> > + *           (mandatory only for POSIX non-compliant systems)
> > + */
> > +int qemu_msync(void *addr, size_t length, size_t align, int fd)
> > +{
> > +#ifdef CONFIG_POSIX
> > +    size_t align_mask;
> > +
> > +    /* Bare minimum of sanity checks on the alignment */
> > +    /* The start address needs to be a multiple of PAGE_SIZE */
> > +    align = MAX(align, qemu_real_host_page_size);
> > +    align_mask = ~(qemu_real_host_page_size - 1);
> > +    align = (align + ~align_mask) & align_mask;
> > +
> > +    align_mask = ~(align - 1);
>
> I don't understand what you're trying to do with align.
>
> You pass in qemu_host_page_size from the one caller, and then adjust it for
> qemu_real_host_page_size?
>
> Why pass in anything at all, and just use qemu_real_host_page_mask?

The qemu_msync was supposed to be generic and not tied to current use case
without any assumptions on the alignment and whether that would  be an actual
host page size. So that was just to make sure it will be a multiple of that.
I can get rid of that with assumption all will be using the same alignment.

BR
Beata
>
> > +    /**
> > +     * There are no strict reqs as per the length of mapping
> > +     * to be synced. Still the length needs to follow the address
> > +     * alignment changes. Additionally - round the size to the multiple
> > +     * of requested alignment (expected as PAGE_SIZE)
> > +     */
> > +    length += ((uintptr_t)addr & (align - 1));
> > +    length = (length + ~align_mask) & align_mask;
> > +
> > +    addr = (void *)((uintptr_t)addr & align_mask);
> > +
> > +    return msync(addr, length, MS_SYNC);
> > +#else /* CONFIG_POSIX */
> > +    /**
> > +     * Perform the sync based on the file descriptor
> > +     * The sync range will most probably be wider than the one
> > +     * requested - but it will still get the job done
> > +     */
> > +    return qemu_fdatasync(fd);
> > +#endif /* CONFIG_POSIX */
> > +}
>
>
> r~
>

