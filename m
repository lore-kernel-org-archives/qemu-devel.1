Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D1C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 20:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E76F20729
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 20:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRWsXhWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E76F20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kalZp-0000iA-9e
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 15:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waynli329@gmail.com>)
 id 1kalYz-0000FR-04
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 15:08:53 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:46992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waynli329@gmail.com>)
 id 1kalYx-00055G-7x
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 15:08:52 -0500
Received: by mail-io1-xd42.google.com with SMTP id s24so3059059ioj.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 12:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Uav1qfF4vwn4Mc7nA+c6c/bniBOR0INDtwn8rFKB9Qg=;
 b=PRWsXhWlI/ltuH/yDZn2y6L/sZmYbPE/EDTarJUhGkVaJQC1fdrSacL3em9scRGJgG
 OqDR+9WuUASF8V5rvIZm4NdxZ9/bYPDCnrUcWM8JyDXV8VCm/SQkxrMfZjjHyEXAaW7G
 m9LG7WbB9gY+kiIa695ks4rBic57sJyNQCycXR/r42j5fxkd7MmRkkxYH5Q1kWZr6huC
 7iFAlF/i5sxqnUB5xlyjTZasDY3nGb6TTE07M6hC6c4ppSXC9tH3FCQ09vF0uPPNsxP8
 l2/EoncLw4yZ36AWeXCTCQSQE1Oop+K9PZs8rDz1zjXdz4STXjwn8wIV25CMsIX9aE1j
 PJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Uav1qfF4vwn4Mc7nA+c6c/bniBOR0INDtwn8rFKB9Qg=;
 b=P775zneWDxqiqOyTS3Ah928Gc/cnO33Ab0HozgIkzwzEJJEI+6RhZgaxs1cJ/UL4XG
 Y6naRxgoOvUnegYzNqCit8IGvGNzmJuBYJ0EasC1podzZ/GjYlsVurpr0hi22+m43AZU
 6GunzR6p3KxBfu1kuVjaWK2FDX5zkPZPQ2hK3IcMD6A7/ifTE8Plc/QIjdGl2EqJzavD
 UQ52NjHp3JW3LfFtsSFQu3sGrRxFMZ3grhOydjpqwSc5fJLumDVjBN4DQQiKU1kWXQPy
 8S8+lo1KchFiSJPGfUwYgIpo00jumEZxVcgAG9yBwZ35TeJPYbcUyP9gd7CpTVoyq8Mg
 ekyA==
X-Gm-Message-State: AOAM533OztFRKk8DlBWD4ObPok1eDycshYvx3jH5czCN5wOPYb5S8TUy
 zYzUTzyakNM7U80eYDh1sHj5ZFFzB7FjlPetdrs=
X-Google-Smtp-Source: ABdhPJxsUY9BM4xElhMxIDm+/wLO7G+6IlBHmdg+fx5l3k/D4I7pcWXlZFVA9n8ojinUjpVFasg1SaB/RapKTh+Yfl4=
X-Received: by 2002:a02:ce83:: with SMTP id y3mr3572807jaq.31.1604606928171;
 Thu, 05 Nov 2020 12:08:48 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0npECL3MpdkXH99htxGdTUTyC47PtnGAT4nkazpV6_rUPA@mail.gmail.com>
 <20201105195851.GC3187@work-vm>
In-Reply-To: <20201105195851.GC3187@work-vm>
From: Wayne Li <waynli329@gmail.com>
Date: Thu, 5 Nov 2020 14:08:37 -0600
Message-ID: <CAM2K0nqaeGjGh++YNoPJ+4_LrnMsgk_B7L-V-gsPGap7=_1GMQ@mail.gmail.com>
Subject: Re: QEMU RAM allocation function fails
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=waynli329@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The RAM region was just too big.  I made it smaller and the VM didn't
crash and moved past that point.

On Thu, Nov 5, 2020 at 1:58 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Wayne Li (waynli329@gmail.com) wrote:
> > Dear QEMU list members,
> >
> > We developed a virtual machine that runs on QEMU.  This virtual
> > machine is pretty much an emulated P4080 processor with some
> > peripherals attached.  Initializing one of these peripherals, i.e. the
> > RAM, seems to be having problems.  I use the function
> > "memory_region_init_ram" to initialize the RAM and farther down the
> > call stack I see that the "qemu_ram_alloc" function returns an address
> > of 0 proving the RAM allocation wasn't successful.  Here is the block
> > of code in question copied from the file memory.c:
> >
> > void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
> >                                              Object *owner,
> >                                              const char *name,
> >                                              uint64_t size,
> >                                              bool share,
> >                                              Error **errp)
> > {
> >     memory_region_init(mr, owner, name, size);
> >     mr->ram = true;
> >     mr->terminates = true;
> >     mr->destructor = memory_region_destructor_ram;
> >     mr->ram_block = qemu_ram_alloc(size, share, mr, errp);
> >     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
> > }
> >
> > Tracing farther into the "qemu_ram_alloc" function reveals that the
> > function fails because inside the "qemu_ram_alloc_internal" function
> > in file exec.c, the function "ram_block_add" fails.  Interestingly, a
> > local_err object is populated here and the msg field in this object is
> > populated with the String "cannot set up guest memory 'ram0': Invalid
> > argument".  Here is the block of code in question copied from the file
> > exec.c:
>
> I'm surprised something didn't print that message out for you - most
> callers pass something like &error_fatal at the end and it should print
> it I think.
>
> >
> > RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
> >                                   void (*resized)(const char*,
> >                                                   uint64_t length,
> >                                                   void *host),
> >                                   void *host, bool resizeable, bool share,
> >                                   MemoryRegion *mr, Error **errp)
> > {
> >     RAMBlock *new_block;
> >     Error *local_err = NULL;
> >
> >     size = HOST_PAGE_ALIGN(size);
> >     max_size = HOST_PAGE_ALIGN(max_size);
> >     new_block = g_malloc0(sizeof(*new_block));
> >     new_block->mr = mr;
> >     new_block->resized = resized;
> >     new_block->used_length = size;
> >     new_block->max_length = max_size;
> >     assert(max_size >= size);
> >     new_block->fd = -1;
> >     new_block->page_size = getpagesize();
> >     new_block->host = host;
> >     if (host) {
> >         new_block->flags |= RAM_PREALLOC;
> >     }
> >     if (resizeable) {
> >         new_block->flags |= RAM_RESIZEABLE;
> >     }
> >     ram_block_add(new_block, &local_err, share);
> >     if (local_err) {
> >         g_free(new_block);
> >         error_propagate(errp, local_err);
> >         return NULL;
> >     }
> >     return new_block;
> > }
> >
> > Anyway, our VM runs fine until it tries to access the RAM region so
> > this is a pretty critical problem for us to solve.  Does anyone know
> > much about these QEMU functions?  What could be causing these RAM
> > initialzation functions to fail in this way?
>
> You're going the right way - keep following it; that 'cannot set up
> guest memory' string is only in one place; softmmu/physmem.c - so
> the phys_mem_alloc must have failed.  That suggests either your
> max_length or your align requirements are wrong; but keep following
> it along.
>
> Dave
>
> > -Thanks, Wayne Li
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

