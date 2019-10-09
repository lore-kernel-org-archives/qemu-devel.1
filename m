Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F181C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088DC20679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltYr2wXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088DC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGTQ-0002GP-7q
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iIAKM-0000iB-G6
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iIAKK-0001MB-AO
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:40:22 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:40186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iIAKK-0001Lm-42
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:40:20 -0400
Received: by mail-io1-xd43.google.com with SMTP id h144so4193940iof.7
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MUHVWGhyuBC1n9S6rYV/LsvWZgGMjW4/odo7lrtct3I=;
 b=ltYr2wXee+wxFHEsvwGrG1DR7/kIQZCUR1LswHa24EqdmPAhLeR0FNJsWs93bJUFla
 +F1zSs4aO4VIfJ6iYqRJZEgfohWN8t91z1xpZPW8MGdhsYZcQWSxpv2Qf26pRNUGWtB1
 JkS0UWMBa0ZGIsVhF2eCoIRCbpF/aWSFOPIM2lzcTy0CpAzMYvY3N37TqAvUvXzjWlbt
 pp7gKi8J0LUyZ0dSDGe1y6jNDH/ooyzVZ6tYgOrlkwOozgSAfVWhatFW6OaMhac0i+1a
 2LttcdJzmWN1YAqwnq5B/BO8szqUV9YXQPgBhzgZlNBgQpaXVJSK/UwpP2SIDDNRcI+8
 SBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MUHVWGhyuBC1n9S6rYV/LsvWZgGMjW4/odo7lrtct3I=;
 b=C4/ytyC7C+M9MWTUP/nqRC0mFNk7dHiOiFAJyioDfcgVieVXEogKmIPj2+epPGqEJF
 FyqmMtfN5M6UriOW8OrBt2fAaUZZvY0LvOOBwlV5uR3NqbDVBbWddQ2TDVGG4OPHLPCU
 mypT+IsFEehofbssL8GYw7sbEf9Kgox6RfMcZTF9S/7Lbxx0hpwR1Z0hKssiPhJ06ifN
 V/At4Bi7r+4aXuHc8fSVd7iEBZibkerT4XWQNRLwn95qGKY9bTvl3gFwGsaDB30X0Ghe
 6QtEX1yiJf48t8gAkasEYZUp3rZQpY7ep/TTQyRdBMUOIPwwGafYIdjtg03zDF6AWcnx
 enBw==
X-Gm-Message-State: APjAAAXZp7euWJj4Nvy6CR/v6ACcDXzpo5QfWPj+kUn8ADqUGtgIpOoG
 9G560OZZevyKlHE+KAsy/lstXk5K65AYMAXqmGKcaA==
X-Google-Smtp-Source: APXvYqw4vHVfDkqilXHeokUulIw6APhojnO1E2BUHPuvfHr30pYcOI1LyuuMR3pAFvR5mF6V983LST9Q2WByuPc98sU=
X-Received: by 2002:a6b:2c02:: with SMTP id s2mr2682557ios.307.1570621217442; 
 Wed, 09 Oct 2019 04:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-3-beata.michalska@linaro.org> <87d0fqbm19.fsf@linaro.org>
In-Reply-To: <87d0fqbm19.fsf@linaro.org>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Wed, 9 Oct 2019 12:40:06 +0100
Message-ID: <CADSWDzum=6OZh5dTCCfSonpemFZQ_RV+dg7HYp3yN8TvpLB2Wg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] Memory: Enable writeback for given
 memory region
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 01:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Beata Michalska <beata.michalska@linaro.org> writes:
>
> > Add an option to trigger memory writeback to sync given memory region
> > with the corresponding backing store, case one is available.
> > This extends the support for persistent memory, allowing syncing on-dem=
and.
> >
> > Also, adding verification for msync support on host.
> >
> > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > ---
> >  configure               | 24 ++++++++++++++++++++++++
> >  exec.c                  | 38 ++++++++++++++++++++++++++++++++++++++
> >  include/exec/memory.h   |  6 ++++++
> >  include/exec/ram_addr.h |  6 ++++++
> >  memory.c                | 12 ++++++++++++
> >  5 files changed, 86 insertions(+)
> >
> > diff --git a/configure b/configure
> > index 95134c0180..bdb7dc47e9 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5081,6 +5081,26 @@ if compile_prog "" "" ; then
> >      fdatasync=3Dyes
> >  fi
> >
> > +##########################################
> > +# verify support for msyc
> > +
> > +msync=3Dno
> > +cat > $TMPC << EOF
> > +#include <unistd.h>
> > +#include <sys/mman.h>
> > +int main(void) {
> > +#if defined(_POSIX_MAPPED_FILES) && _POSIX_MAPPED_FILES > 0 \
> > +&& defined(_POSIX_SYNCHRONIZED_IO) && _POSIX_SYNCHRONIZED_IO > 0
> > +return msync(NULL,0, MS_SYNC);
> > +#else
> > +#error Not supported
> > +#endif
> > +}
> > +EOF
> > +if compile_prog "" "" ; then
> > +    msync=3Dyes
> > +fi
> > +
> >  ##########################################
> >  # check if we have madvise
> >
> > @@ -6413,6 +6433,7 @@ echo "fdt support       $fdt"
> >  echo "membarrier        $membarrier"
> >  echo "preadv support    $preadv"
> >  echo "fdatasync         $fdatasync"
> > +echo "msync             $msync"
> >  echo "madvise           $madvise"
> >  echo "posix_madvise     $posix_madvise"
> >  echo "posix_memalign    $posix_memalign"
> > @@ -6952,6 +6973,9 @@ fi
> >  if test "$fdatasync" =3D "yes" ; then
> >    echo "CONFIG_FDATASYNC=3Dy" >> $config_host_mak
> >  fi
> > +if test "$msync" =3D "yes" ; then
> > +    echo "CONFIG_MSYNC=3Dy" >> $config_host_mak
> > +fi
>
> I think it's best to split this configure check into a new prequel patch =
and...

I might just drop it in favour of CONFIG_POSIX switch ......
>
> >  if test "$madvise" =3D "yes" ; then
> >    echo "CONFIG_MADVISE=3Dy" >> $config_host_mak
> >  fi
> > diff --git a/exec.c b/exec.c
> > index 235d6bc883..5ed6908368 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -65,6 +65,8 @@
> >  #include "exec/ram_addr.h"
> >  #include "exec/log.h"
> >
> > +#include "qemu/pmem.h"
> > +
> >  #include "migration/vmstate.h"
> >
> >  #include "qemu/range.h"
> > @@ -2182,6 +2184,42 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t =
newsize, Error **errp)
> >      return 0;
> >  }
> >
> > +/*
> > + * Trigger sync on the given ram block for range [start, start + lengt=
h]
> > + * with the backing store if available.
> > + * @Note: this is supposed to be a SYNC op.
> > + */
> > +void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t =
length)
> > +{
> > +    void *addr =3D ramblock_ptr(block, start);
> > +
> > +    /*
> > +     * The requested range might spread up to the very end of the bloc=
k
> > +     */
> > +    if ((start + length) > block->used_length) {
> > +        error_report("%s: sync range outside the block boundires: "
> > +                     "start: " RAM_ADDR_FMT " length: " RAM_ADDR_FMT
> > +                     " block length: " RAM_ADDR_FMT " Narrowing down .=
.." ,
> > +                     __func__, start, length, block->used_length);
>
> Is this an error or just logging? error_report should be used for stuff
> that the user needs to know about so it will appear on the HMP console
> (or via stderr). If so what is the user expected to do? Have they
> misconfigured their system?
>

This should be logging  rather than 'error reporting as such. My bad.
Will address that in the next version.

> > +        length =3D block->used_length - start;
> > +    }
> > +
> > +#ifdef CONFIG_LIBPMEM
> > +    /* The lack of support for pmem should not block the sync */
> > +    if (ramblock_is_pmem(block)) {
> > +        pmem_persist(addr, length);
> > +    } else
> > +#endif
> > +    if (block->fd >=3D 0) {
> > +#ifdef CONFIG_MSYNC
> > +        msync((void *)((uintptr_t)addr & qemu_host_page_mask),
> > +               HOST_PAGE_ALIGN(length), MS_SYNC);
> > +#else
> > +        qemu_fdatasync(block->fd);
> > +#endif
>
> ... hide the implementation details in util/cutils.c, maybe as
> qemu_msync()?
>
> > +    }
> > +}
> > +
> >  /* Called with ram_list.mutex held */
> >  static void dirty_memory_extend(ram_addr_t old_ram_size,
> >                                  ram_addr_t new_ram_size)
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 2dd810259d..ff0d7937cf 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -1242,6 +1242,12 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr=
);
> >   */
> >  void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize,
> >                                Error **errp);
> > +/**
> > + * memory_region_do_writeback: Trigger writeback for selected address =
range
> > + * [addr, addr + size]
> > + *
> > + */
> > +void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr =
size);
> >
> >  /**
> >   * memory_region_set_log: Turn dirty logging on or off for a region.
> > diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> > index a327a80cfe..d4bce81a03 100644
> > --- a/include/exec/ram_addr.h
> > +++ b/include/exec/ram_addr.h
> > @@ -180,6 +180,12 @@ void qemu_ram_free(RAMBlock *block);
> >
> >  int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)=
;
> >
> > +void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t =
length);
> > +
> > +/* Clear whole block of mem */
> > +#define qemu_ram_block_writeback(rb)    \
> > +    qemu_ram_writeback(rb, 0, rb->used_length)
> > +
> >  #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
> >  #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY=
_CODE))
> >
> > diff --git a/memory.c b/memory.c
> > index 61a254c3f9..436eb64737 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -2228,6 +2228,18 @@ void memory_region_ram_resize(MemoryRegion *mr, =
ram_addr_t newsize, Error **errp
> >      qemu_ram_resize(mr->ram_block, newsize, errp);
> >  }
> >
> > +
> > +void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr =
size)
> > +{
> > +    /*
> > +     * Might be extended case needed to cover
> > +     * different types of memory regions
> > +     */
> > +    if (mr->ram_block && mr->dirty_log_mask) {
> > +        qemu_ram_writeback(mr->ram_block, addr, size);
> > +    }
> > +}
> > +
> >  /*
> >   * Call proper memory listeners about the change on the newly
> >   * added/removed CoalescedMemoryRange.
>
>
> --
> Alex Benn=C3=A9e

Thank you.

BR
Beata

