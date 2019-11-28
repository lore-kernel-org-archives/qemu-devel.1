Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2118C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4753208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqdMGUVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4753208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaQZl-0001ID-QZ
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 15:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iaQSJ-0007EK-NC
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iaQSB-0007eK-UR
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:31:59 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iaQSB-0007GF-Lf
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:31:55 -0500
Received: by mail-wm1-x344.google.com with SMTP id g206so12137939wme.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 12:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zE0C0IsD9LmsT26Oe6u2QKEovUbljlDRPboRQHgjn24=;
 b=jqdMGUViXkVZYB3PHSIfPih7N6K9RfaNev51ng2dvvYfCdJU5OPwV2LPeCiQSmB5ei
 bDXdKcOS/noJ9p3MTEu5ucHskXXVqlCaRY20DLetShWuhijVFn3Qf1+0rftbgLDQ45J3
 qes3sB7Nm5hIe4crqs+4BO5jGgNcRxnQDVnQwEQerEzpELzW6ZQvqL5UaWUvntQgXxpI
 7vDr2ipjZcCXyB7fuViDfudft7TGoTWxGFAnhuW95QyzTQuzFCLlNk4dt2upjzQYnEGp
 zjWOiiCfeOfVfuys/41sES1oWMdUTuzf/VcSPqDONyqoqDhah4LaT5LyYDWNU4bc5CM8
 YjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zE0C0IsD9LmsT26Oe6u2QKEovUbljlDRPboRQHgjn24=;
 b=KYxGR6JNSn6U2AIviaZPIEKs5OGnJTPKs9UexVTy3B2qCjbk2cJw1+gT7W1OIg77Hp
 /X5+IqWT+5UWP7ryTbD31VQvdyYQrIfDa/GuOLQ1RX5y17QRNgUvz4UNQzTAMxPUIfdU
 brmG+uA/RrGsBN2y9o0/8RM4wYVT6s/C2WKG//45xxgTX9QlKk/R8Ao3h3bFua5GNwc9
 Ng5RIRAXbJ31ISpm5zRkR3XOxN9wXC5kJypKN8PzsY3/isXSK1P8/I0QN6qvUN+1b8hn
 zdlb4ErkmSzR4MJC1K3rMLYS/ZzWFONB7it2F6Q6N3/sim+oGaH7WKxSOD2zhwxisR6L
 0h0w==
X-Gm-Message-State: APjAAAXwRZ1b/6AaUgoZnq9Kj+IQpX5NGOcyFnQ1LKnTNEKrgAORd0Dq
 l1RNr3uGMKeSZ7LYa0mVj6riE2d+kMB70UCCOtc=
X-Google-Smtp-Source: APXvYqxDE4ioT23H9xtO/NDFjvx7NGV73GLgxDB431ZMeX5bG14Yx97IqDKNUHd2wWUF/VFQHL5zLf9mbY61m1U+h10=
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr11235297wmh.5.1574973110429; 
 Thu, 28 Nov 2019 12:31:50 -0800 (PST)
MIME-Version: 1.0
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128141518.628245-3-marcandre.lureau@redhat.com>
 <20191128172807.788e6aeb@redhat.com>
In-Reply-To: <20191128172807.788e6aeb@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 29 Nov 2019 00:31:32 +0400
Message-ID: <CAJ+F1CLZxhMf-bOAB4sVfuB1yaUMqiO70-ogpKVS3CqfC7y5KA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add -mem-shared option
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Nov 28, 2019 at 9:25 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 28 Nov 2019 18:15:18 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
> > Add an option to simplify shared memory / vhost-user setup.
> >
> > Currently, using vhost-user requires NUMA setup such as:
> > -m 4G -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/sh=
m,share=3Don -numa node,memdev=3Dmem
> >
> > As there is no other way to allocate shareable RAM, afaik.
> >
> > -mem-shared aims to have a simple way instead: -m 4G -mem-shared
> User always can write a wrapper script if verbose CLI is too much,
> and we won't have to deal with myriad permutations to maintain.

Sure, but that's not exactly making it easier for the user,
documentation etc (or machine that do not support numa as David
mentionned).

>
> Also current -mem-path/prealloc in combination with memdevs is
> the source of problems (as ram allocation uses 2 different paths).
> It's possible to fix with a kludge but I'd rather fix it properly.

I agree, however I think it's a separate problems. We don't have to
fix both simultaneously. The semantic of a new CLI -mem-shared (or
shared=3Don etc) can be defined and implemented in a simple way, before
internal refactoring.

> So during 5.0, I'm planning to consolidate -mem-path/prealloc
> handling around memory backend internally (and possibly deprecate them),
> so the only way to allocate RAM for guest would be via memdevs.
> (reducing number of options an globals that they use)
>

That would be great indeed. I tried to look at that in the past, but
was a it overwhelmed by the amount of details and/or code complexity.

> So user who wants something non trivial could override default
> non-numa behavior with
>   -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,shar=
e=3Don \
>   -machine memdev=3Dmem
> or use any other backend that suits theirs needs.

That's nice, but not as friendly as a simple -mem-shared.

thanks

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  exec.c                  | 11 ++++++++++-
> >  hw/core/numa.c          | 16 +++++++++++++++-
> >  include/sysemu/sysemu.h |  1 +
> >  qemu-options.hx         | 10 ++++++++++
> >  vl.c                    |  4 ++++
> >  5 files changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/exec.c b/exec.c
> > index ffdb518535..4e53937eaf 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -72,6 +72,10 @@
> >  #include "qemu/mmap-alloc.h"
> >  #endif
> >
> > +#ifdef CONFIG_POSIX
> > +#include "qemu/memfd.h"
> > +#endif
> > +
> >  #include "monitor/monitor.h"
> >
> >  //#define DEBUG_SUBPAGE
> > @@ -2347,7 +2351,12 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t si=
ze, MemoryRegion *mr,
> >      bool created;
> >      RAMBlock *block;
> >
> > -    fd =3D file_ram_open(mem_path, memory_region_name(mr), &created, e=
rrp);
> > +    if (mem_path) {
> > +        fd =3D file_ram_open(mem_path, memory_region_name(mr), &create=
d, errp);
> > +    } else {
> > +        fd =3D qemu_memfd_open(mr->name, size,
> > +                             F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL=
, errp);
> > +    }
>
> that's what I'm mostly against, as it spills out memdev impl. details
> into generic code.
>
> >      if (fd < 0) {
> >          return NULL;
> >      }
> > diff --git a/hw/core/numa.c b/hw/core/numa.c
> > index e3332a984f..6f72cddb1c 100644
> > --- a/hw/core/numa.c
> > +++ b/hw/core/numa.c
> > @@ -493,7 +493,8 @@ static void allocate_system_memory_nonnuma(MemoryRe=
gion *mr, Object *owner,
> >      if (mem_path) {
> >  #ifdef __linux__
> >          Error *err =3D NULL;
> > -        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0,=
 0,
> > +        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0,
> > +                                         mem_shared ? RAM_SHARED : 0,
> >                                           mem_path, &err);
> this will be gone and replaced by memory region that memdev initializes.
>
> >          if (err) {
> >              error_report_err(err);
> > @@ -513,6 +514,19 @@ static void allocate_system_memory_nonnuma(MemoryR=
egion *mr, Object *owner,
> >  #else
> >          fprintf(stderr, "-mem-path not supported on this host\n");
> >          exit(1);
> > +#endif
> > +    } else if (mem_shared) {
> > +#ifdef CONFIG_POSIX
> > +        Error *err =3D NULL;
> > +        memory_region_init_ram_from_file(mr, owner, NULL, ram_size, 0,
> > +                                         RAM_SHARED, NULL, &err);
> > +        if (err) {
> > +            error_report_err(err);
> > +            exit(1);
> > +        }
> > +#else
> > +        fprintf(stderr, "-mem-shared not supported on this host\n");
> > +        exit(1);
> >  #endif
> >      } else {
> >          memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &e=
rror_fatal);
> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > index 80c57fdc4e..80db8465a9 100644
> > --- a/include/sysemu/sysemu.h
> > +++ b/include/sysemu/sysemu.h
> > @@ -55,6 +55,7 @@ extern bool enable_cpu_pm;
> >  extern QEMUClockType rtc_clock;
> >  extern const char *mem_path;
> >  extern int mem_prealloc;
> > +extern int mem_shared;
> >
> >  #define MAX_OPTION_ROMS 16
> >  typedef struct QEMUOptionRom {
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 65c9473b73..4c69b03ad3 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -394,6 +394,16 @@ STEXI
> >  Preallocate memory when using -mem-path.
> >  ETEXI
> >
> > +DEF("mem-shared", 0, QEMU_OPTION_mem_shared,
> > +    "-mem-shared     allocate shared memory\n", QEMU_ARCH_ALL)
> > +STEXI
> > +@item -mem-shared
> > +@findex -mem-shared
> > +Allocate guest RAM with shared mapping.  Whether the allocation is
> > +anonymous or not (with -mem-path), QEMU will allocate a shared memory =
that
> > +can be shared by unrelated processes, such as vhost-user backends.
> > +ETEXI
> > +
> >  DEF("k", HAS_ARG, QEMU_OPTION_k,
> >      "-k language     use keyboard layout (for example 'fr' for French)=
\n",
> >      QEMU_ARCH_ALL)
> > diff --git a/vl.c b/vl.c
> > index 6a65a64bfd..53b1155455 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -143,6 +143,7 @@ const char* keyboard_layout =3D NULL;
> >  ram_addr_t ram_size;
> >  const char *mem_path =3D NULL;
> >  int mem_prealloc =3D 0; /* force preallocation of physical target memo=
ry */
> > +int mem_shared =3D 0;
> Also what happened to no more globals policy?
>
> >  bool enable_mlock =3D false;
> >  bool enable_cpu_pm =3D false;
> >  int nb_nics;
> > @@ -3172,6 +3173,9 @@ int main(int argc, char **argv, char **envp)
> >              case QEMU_OPTION_mem_prealloc:
> >                  mem_prealloc =3D 1;
> >                  break;
> > +            case QEMU_OPTION_mem_shared:
> > +                mem_shared =3D 1;
> > +                break;
> >              case QEMU_OPTION_d:
> >                  log_mask =3D optarg;
> >                  break;
>
>


--=20
Marc-Andr=C3=A9 Lureau

