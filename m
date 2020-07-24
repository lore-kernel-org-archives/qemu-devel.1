Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896DCC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53517206E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCH0omo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53517206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jylHR-00046L-JF
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 20:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jylGP-0003aC-3F
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:08:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39459
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jylGM-0005ut-5P
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595549312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k2wc/jfutHFLWUeufSljfA9/E36Diy1TqGfedFouW44=;
 b=HCH0omo9Et7aTkFnUCh7OtCucnEBb35uC2XDYTEi4Fyv2XonsDNyO031KdGxGyYlSwt9HZ
 41Hi+Vz1tvrM0HLi/CS0xYyM/zw3xJ6sWh/cU4fqOO8mK483npOoRzictGgj2kS1Yad3/w
 L8C4swmyQVrjI66HsEBAFKaSC36Yqhk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-d8Z3ut6AP0GbH6adNbqrlA-1; Thu, 23 Jul 2020 20:08:30 -0400
X-MC-Unique: d8Z3ut6AP0GbH6adNbqrlA-1
Received: by mail-qk1-f200.google.com with SMTP id x20so5143199qki.20
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 17:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=k2wc/jfutHFLWUeufSljfA9/E36Diy1TqGfedFouW44=;
 b=KRt0ldOhGUQpT0dm6oyhXJoI8dZSzo17xSPeKXL95E+xhrVAwDZHKIx7wsf15+9YFO
 gD/Qq7rfS+BEDcgMrkS6AhXzG4bR9BH2T+z9T0MWu+37QbXNacyYT2ewWzcAp8Te7lQt
 EjK0Gagb8MEeTHLEno7wZy7x7hlzApXlk3KykT2p5CSwzc9uCk2csRrN1TOu3oXSaP6C
 QROUedIxWs8qrKxUrAqf9/vj8jYKFn5UomfEP6U/4w/CfrJNaQ4GeLT2IWtK9I/tsFAk
 0YfO5fO2m0mBuK9EXVGA7DCSASa1mJakxuh+r67hOiOz5dN+gp1BTmnrTwhYRV+ezq3o
 cq2g==
X-Gm-Message-State: AOAM530sg7FjuuaZ1ZDr5Abh++6R2cdu2vzKFai0tOtlBdcsF+dQzq6k
 YO39E0SIw9zqVdPucCgRkodM0QnQwMKtokeaYtNZZ/ITam6xM4k06chWRxdXkZwruXJPXfRmxkT
 TZTxnp3oX98nAHjg=
X-Received: by 2002:a37:995:: with SMTP id 143mr8091888qkj.266.1595549309579; 
 Thu, 23 Jul 2020 17:08:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx52B46t67u1FdXPMxwN9Q0iqPxH9qLQyfYpKluwL/lXUqBqjx3DPea/Gaa0b/eQZDwvuNFIg==
X-Received: by 2002:a37:995:: with SMTP id 143mr8091861qkj.266.1595549309153; 
 Thu, 23 Jul 2020 17:08:29 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id o39sm4466762qtj.0.2020.07.23.17.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 17:08:28 -0700 (PDT)
Date: Thu, 23 Jul 2020 20:08:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 3/4] migration: add background snapshot
Message-ID: <20200724000826.GA865413@xz-x1>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722081133.29926-4-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200722081133.29926-4-dplotnikov@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, den@openvz.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 11:11:32AM +0300, Denis Plotnikov wrote:
> +/**
> + * ram_copy_page: make a page copy
> + *
> + * Used in the background snapshot to make a copy of a memeory page.
> + * Ensures that the memeory page is copied only once.
> + * When a page copy is done, restores read/write access to the memory
> + * page.
> + * If a page is being copied by another thread, wait until the copying
> + * ends and exit.
> + *
> + * Returns:
> + *   -1 - on error
> + *    0 - the page wasn't copied by the function call
> + *    1 - the page has been copied
> + *
> + * @block:     RAM block to use
> + * @page_nr:   the page number to copy
> + * @page_copy: the pointer to return a page copy
> + *
> + */
> +int ram_copy_page(RAMBlock *block, unsigned long page_nr,
> +                          void **page_copy)
> +{
> +    void *host_page;
> +    int res = 0;
> +
> +    atomic_inc(&ram_state->page_copier_cnt);
> +
> +    if (test_and_set_bit_atomic(page_nr, block->touched_map)) {
> +        while (!test_bit_atomic(page_nr, block->copied_map)) {
> +            /* the page is being copied -- wait for the end of the copying */
> +            qemu_event_wait(&ram_state->page_copying_done);
> +        }
> +        goto out;
> +    }
> +
> +    *page_copy = ram_page_buffer_get();
> +    if (!*page_copy) {
> +        res = -1;
> +        goto out;
> +    }
> +
> +    host_page = block->host + (page_nr << TARGET_PAGE_BITS);
> +    memcpy(*page_copy, host_page, TARGET_PAGE_SIZE);
> +
> +    if (ram_set_rw(host_page, TARGET_PAGE_SIZE)) {
> +        ram_page_buffer_free(*page_copy);
> +        *page_copy = NULL;
> +        res = -1;
> +        goto out;
> +    }
> +
> +    set_bit_atomic(page_nr, block->copied_map);
> +    qemu_event_set(&ram_state->page_copying_done);
> +    qemu_event_reset(&ram_state->page_copying_done);
> +
> +    res = 1;
> +out:
> +    atomic_dec(&ram_state->page_copier_cnt);
> +    return res;
> +}

Is ram_set_rw() be called on the page only if a page fault triggered?
Shouldn't we also do that even in the background thread when we proactively
copying the pages?

Besides current solution, do you think we can make it simpler by only deliver
the fault request to the background thread?  We can let the background thread
to do all the rests and IIUC we can drop all the complicated sync bitmaps and
so on by doing so.  The process can look like:

  - background thread runs the general precopy migration, and,

    - it only does the ram_bulk_stage, which is the first loop, because for
      snapshot no reason to send a page twice..

    - After copy one page, do ram_set_rw() always, so accessing of this page
      will never trigger write-protect page fault again,

    - take requests from the unqueue_page() just like what's done in this
      series, but instead of copying the page, the page request should look
      exactly like the postcopy one.  We don't need copy_page because the page
      won't be changed before we unprotect it, so it shiould be safe.  These
      pages will still be with high priority because when queued it means vcpu
      writed to this protected page and fault in userfaultfd.  We need to
      migrate these pages first to unblock them.

  - the fault handler thread only needs to do:

    - when get a uffd-wp message, translate into a postcopy-like request
      (calculate ramblock and offset), then queue it.  That's all.

I believe we can avoid the copy_page parameter that was passed around, and we
can also save the two extra bitmaps and the complicated synchronizations.

Do you think this would work?

Besides, have we disabled dirty tracking of memslots?  IIUC that's not needed
for background snapshot too, so neither do we need dirty tracking nor do we
need to sync the dirty bitmap from outside us (kvm/vhost/...).

-- 
Peter Xu


