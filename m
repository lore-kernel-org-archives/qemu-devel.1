Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3021BC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083132171F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083132171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprJy-0005xH-8w
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49728)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hprJn-0005Ym-HU
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hprJm-0004zQ-4T
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:42:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hprJl-0004yc-UB
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:42:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so17350619wrr.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 02:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3DlPkvS6tIin8n6njgEuXenZT5Cy4sNWw1kBNt1gLGI=;
 b=AJuKI/J4iXjZdoURzW6diOZESRJ2RtuGVeiZ15Gmz5Cu6Az3Q21MZDRLYbPB085/7C
 FfLJk11+PQK9CfmlUeq/XWN8qdOdaVjA8BLsbyRw8HzbQzbBXYHzopd4GkvwK3p2UGOw
 BNYE3MZXuiL2vBXaq30tKwOe/hmi8DTxuaLLgwQorMfofohyEfitf1MhaGLpPzBGGqvB
 77mdpxl0ytVqpGTNRKj7yrsEhv2BHENvOvFvUrUuzby4j9HVgf2KvJ8ZtzgpIiFL2ec6
 0RLsEIrmIMP1RhNBxqKc63fgcYlWqmTdFn6+7b2+8qCmRNHqJ78mPXbS+T7+BBPtqDiK
 edYg==
X-Gm-Message-State: APjAAAUFYaZ/hG4s+5WW8BNK+mMJ9vfhW5x3kQw/3fJM+bT9qqsGM8CK
 8bTXzmc3dqGsqWRwTZAjPf2JoA==
X-Google-Smtp-Source: APXvYqx8Ga18z6KsfjT2zcpMhGhCRXXdSlSP4MVRI02lPvKfTDcjUPjwVazGSpXASBj//hAEZ9Gvbw==
X-Received: by 2002:adf:c594:: with SMTP id m20mr52930912wrg.126.1563874964082; 
 Tue, 23 Jul 2019 02:42:44 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id 2sm54621495wrn.29.2019.07.23.02.42.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 02:42:43 -0700 (PDT)
Date: Tue, 23 Jul 2019 11:42:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190723094241.7znxmk3wa6gti6tr@steredhat>
References: <20190723090718.14590-1-sgarzare@redhat.com>
 <20190723090718.14590-2-sgarzare@redhat.com>
 <CAFEAcA_KspUxk75hR4YV444tj8-bQKOJ_4eq+aPD-idZ12Lzwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_KspUxk75hR4YV444tj8-bQKOJ_4eq+aPD-idZ12Lzwg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 1/2] elf-ops.h: Map into memory the ELF to
 load
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 10:32:34AM +0100, Peter Maydell wrote:
> On Tue, 23 Jul 2019 at 10:08, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > In order to reduce the memory footprint we map into memory
> > the ELF to load using g_mapped_file_new_from_fd() instead of
> > reading each sections. In this way we can share the ELF pages
> > between multiple instances of QEMU.
> >
> > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  include/hw/elf_ops.h | 59 ++++++++++++++++++++++----------------------
> >  1 file changed, 30 insertions(+), 29 deletions(-)
> >
> > diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> > index 690f9238c8..69ce8dea74 100644
> > --- a/include/hw/elf_ops.h
> > +++ b/include/hw/elf_ops.h
> > @@ -323,8 +323,9 @@ static int glue(load_elf, SZ)(const char *name, int fd,
> >      struct elfhdr ehdr;
> >      struct elf_phdr *phdr = NULL, *ph;
> >      int size, i, total_size;
> > -    elf_word mem_size, file_size;
> > +    elf_word mem_size, file_size, data_offset;
> >      uint64_t addr, low = (uint64_t)-1, high = 0;
> > +    GMappedFile *gmf = NULL;
> >      uint8_t *data = NULL;
> >      char label[128];
> >      int ret = ELF_LOAD_FAILED;
> > @@ -409,22 +410,26 @@ static int glue(load_elf, SZ)(const char *name, int fd,
> >          }
> >      }
> >
> > +    gmf = g_mapped_file_new_from_fd(fd, false, NULL);
> 
> Hmm. Here we pass 'false' for the writable argument,
> meaning we promise not to modify the mapped buffer...
> 
> > +    if (!gmf) {
> > +        goto fail;
> > +    }
> > +
> >      total_size = 0;
> >      for(i = 0; i < ehdr.e_phnum; i++) {
> >          ph = &phdr[i];
> >          if (ph->p_type == PT_LOAD) {
> >              mem_size = ph->p_memsz; /* Size of the ROM */
> >              file_size = ph->p_filesz; /* Size of the allocated data */
> > -            data = g_malloc0(file_size);
> > -            if (ph->p_filesz > 0) {
> > -                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
> > -                    goto fail;
> > -                }
> > -                if (read(fd, data, file_size) != file_size) {
> > -                    goto fail;
> > -                }
> > +            data_offset = ph->p_offset; /* Offset where the data is located */
> > +
> > +            if (g_mapped_file_get_length(gmf) < file_size + data_offset) {
> > +                goto fail;
> >              }
> >
> > +            data = (uint8_t *)g_mapped_file_get_contents(gmf);
> > +            data += data_offset;
> 
> ...but here we set up the 'data' pointer from the mapped contents,
> and then in following code we will write to it in some situations --
> look at the "if (data_swab)" case or the call to elf_reloc if we
> have a translate_fn, for instance.
> 

Reading the 'g_mapped_file_new_from_fd()' docs [1]:
"If writable is TRUE, the mapped buffer may be modified, otherwise it is an
error to modify the mapped buffer. Modifications to the buffer are not visible
to other processes mapping the same file, and are not written back to the file."

I don't know what "error" means, but reading the second part I thought
the changes in that case were only visible at the current process.

I'll test it to understand better the behavior. If we can't touch it, then we
have to make a copy in these cases.

> (We can't get out of this by just passing writable=true, because
> we definitely don't want to be writing back to the underlying file.)

Yes, I agree.


Thanks,
Stefano

[1] https://developer.gnome.org/glib/stable/glib-File-Utilities.html#g-mapped-file-new-from-fd

