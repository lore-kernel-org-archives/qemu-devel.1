Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32A1C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 19:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B32C22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 19:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMgSHTE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B32C22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Vsq-0007GV-CV
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 15:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i0Vrv-0006e8-NA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i0Vrt-0006z0-VF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:02:03 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:37885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i0Vrt-0006wb-NQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:02:01 -0400
Received: by mail-qk1-x744.google.com with SMTP id s14so2823577qkm.4
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 12:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XA2W0OzQzp0i046Henqd7QOvxI6NCbJEwAV6iIBzyD8=;
 b=IMgSHTE9CkSWN2Gh2eM91ZiUpTO0d+LzsSVXxQDgAsK6ONH0pEK2+OAk7KoU+l7xY+
 zTQ05Zz2RwtchCQvR4hSUyrZ5G/u0ZSpZfD3GpH1nf64eNgzQKLZqWAxAghttLlcKi8R
 mbAZ9Y5wfzTMrlW9lwRdIkC3WywwtyqJSdXSh14LPvfvSD7qE1CymwhPdaK2OXQDP+bk
 X+jOrZqJcxhYsLwuDzeXh236NXf/yo/CQgdiA/eZqis9lzj0u/24t++P3EDAS5Fo5xLS
 xfv9/Nb26k50LJqj4+1/nqzlK9cfNSp4uJ+BFJh9G8+qg0vtIAsrHZJvgkN9l5MKoue3
 FyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XA2W0OzQzp0i046Henqd7QOvxI6NCbJEwAV6iIBzyD8=;
 b=XhbNUF2ootfr+Po6gcjo3hdni3rh+38ZAXi2/qvbQE7rcnRCMwLtz1zQ5pHYXlhiAb
 pWz1JNKwhi/Vk9OwGK5M/kAiNPEpg03DoLGmydr/TKeEyJnJZ6JcVB1qk/grrx4d1WD0
 Yh1YerWIo1dqmcmb8blvM+oURzhUaJXCyv8nAwfOeveWi0bZvWMb2MaviX2MmiIvbTRn
 wXHgkiysNRR+dc/I/UZ4tpZo4kUh9rcY1L1sE3btrfSlpI5a9Gk3lEXHUDI99KEhnNdT
 /Uf5V/GgW/YuoG/NYDXUB/QTPixk/SlLdM5NwaboFH7kWoewygjcxKt43zGWdgCkhTac
 bk1A==
X-Gm-Message-State: APjAAAUvAdXY6kzYZ+msaQGXF7hnKHOW6HOXNMu7dSR9aoj9qrDio1aR
 kkWtItEs8QSdLjz4onlGPo6W8izZ+4xdx7U2tGo=
X-Google-Smtp-Source: APXvYqyx3BgRPST+51BMoZuXqGGQbg5TFKXrlBTHP6k9t9U25bX2hsoeFqY7soDpHT/48EgiDi4NFG4Piz57fBGDjDM=
X-Received: by 2002:ae9:df84:: with SMTP id
 t126mr32633773qkf.328.1566414120504; 
 Wed, 21 Aug 2019 12:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190815023725.2659-1-vandersonmr2@gmail.com>
 <20190815023725.2659-2-vandersonmr2@gmail.com>
 <20190815144036.GG10996@stefanha-x1.localdomain>
In-Reply-To: <20190815144036.GG10996@stefanha-x1.localdomain>
From: Vanderson Martins do Rosario <vandersonmr2@gmail.com>
Date: Wed, 21 Aug 2019 16:01:48 -0300
Message-ID: <CAMzYVD2pqphWChXPXCCuC9R3NcOHGz5yojLkT_+CMYbNdc4F=Q@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v1 1/2] accel/tcg: adding integration with
 linux perf
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 11:40 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Aug 14, 2019 at 11:37:24PM -0300, vandersonmr wrote:
> > This commit adds support to Linux Perf in order
> > to be able to analyze qemu jitted code and
> > also to able to see the TBs PC in it.
>
> Is there any reference to the file format?  Please include it in a code
> comment, if such a thing exists.
>
> > diff --git a/accel/tcg/perf/jitdump.c b/accel/tcg/perf/jitdump.c
> > new file mode 100644
> > index 0000000000..6f4c0911c2
> > --- /dev/null
> > +++ b/accel/tcg/perf/jitdump.c
> > @@ -0,0 +1,180 @@
>
> License header?
>
> > +#ifdef __linux__
>
> If the entire source file is #ifdef __linux__ then Makefile.objs should
> probably contain obj-$(CONFIG_LINUX) += jitdump.o instead.  Letting the
> build system decide what to compile is cleaner than ifdeffing large
> amounts of code.
>
> > +
> > +#include <stdint.h>
> > +
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <time.h>
> > +#include <sys/syscall.h>
> > +#include <elf.h>
> > +
> > +#include "jitdump.h"
> > +#include "qemu-common.h"
>
> Please follow QEMU's header ordering conventions.  See ./HACKING "1.2.
> Include directives".
>
> > +void start_jitdump_file(void)
> > +{
> > +    GString *dumpfile_name = g_string_new(NULL);;
> > +    g_string_printf(dumpfile_name, "./jit-%d.dump", getpid());
>
> Simpler:
>
>   gchar *dumpfile_name = g_strdup_printf("./jit-%d.dump", getpid());
>   ...
>   g_free(dumpfile_name);
>
> > +    dumpfile = fopen(dumpfile_name->str, "w+");
>
> getpid() and the global dumpfile variable make me wonder what happens
> with multi-threaded TCG?
>

I did some tests and it appears to be working fine with multi-threaded TCG.
tcg_exec_init should execute only once even in multi-threaded TCG, right?
If so, we are going to create only one jitdump file. Also, both in Windows
and Linux/POSIX fwrites is thread-safe, thus we would be safely updating
the jitdump file. Does it make sense?


>
> > +
> > +    perf_marker = mmap(NULL, sysconf(_SC_PAGESIZE),
>
> Please mention the point of this mmap in a comment.  My best guess is
> that perf stores the /proc/$PID/maps and this is how it finds the
> jitdump file?
>
> > +                          PROT_READ | PROT_EXEC,
> > +                          MAP_PRIVATE,
> > +                          fileno(dumpfile), 0);
> > +
> > +    if (perf_marker == MAP_FAILED) {
> > +        printf("Failed to create mmap marker file for perf %d\n",
> fileno(dumpfile));
> > +        fclose(dumpfile);
> > +        return;
> > +    }
> > +
> > +    g_string_free(dumpfile_name, TRUE);
> > +
> > +    struct jitheader *header = g_new0(struct jitheader, 1);
>
> Why g_new this struct?  It's small and can be declared on the stack.
>
> Please use g_free() with g_malloc/new/etc().  It's not safe to mismatch
> glib and libc memory allocation functions.
>
> > +    header->magic = 0x4A695444;
> > +    header->version = 1;
> > +    header->elf_mach = get_e_machine();
> > +    header->total_size = sizeof(struct jitheader);
> > +    header->pid = getpid();
> > +    header->timestamp = get_timestamp();
> > +
> > +    fwrite(header, header->total_size, 1, dumpfile);
> > +
> > +    free(header);
> > +    fflush(dumpfile);
> > +}
> > +
> > +void append_load_in_jitdump_file(TranslationBlock *tb)
> > +{
> > +    GString *func_name = g_string_new(NULL);
> > +    g_string_printf(func_name, "TB virt:0x"TARGET_FMT_lx"%c", tb->pc,
> '\0');
>
> The explicit NUL character looks strange to me.  I think the idea is to
> avoid func_name->len + 1?  Adding NUL characters to C strings can be a
> source of bugs, I would stick to convention and do len + 1 instead of
> putting NUL characters into the GString.  This is a question of style
> though.
>
> > +
> > +    struct jr_code_load *load_event = g_new0(struct jr_code_load, 1);
>
> No need to allocate load_event on the heap.
>
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 9621e934c0..1c26eeeb9c 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4147,6 +4147,18 @@ STEXI
> >  Enable FIPS 140-2 compliance mode.
> >  ETEXI
> >
> > +#ifdef __linux__
> > +DEF("perf", 0, QEMU_OPTION_perf,
> > +    "-perf    dump jitdump files to help linux perf JIT code
> visualization\n",
> > +    QEMU_ARCH_ALL)
> > +#endif
> > +STEXI
> > +@item -perf
> > +@findex -perf
> > +Dumps jitdump files to help linux perf JIT code visualization
>
> Suggestions on expanding the documentation:
>
> Where are the jitdump files dumped?  The current working directory?
>
> Anything to say about the naming scheme for these files?
>
> Can you include an example of how to load them into perf(1)?
>
