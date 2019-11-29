Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4323EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1592084D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dwn32R02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1592084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadrO-0003PX-6e
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iadBQ-0007ha-De
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iadBG-0007WL-1d
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:07:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22596
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iadBC-0007Or-P2
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575022031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBzj7zbfUuW2tpKskgh6zpIacjXB0VOiM3IJQezjOFs=;
 b=Dwn32R02Cu/ba8m3bI3C/D9MEglekSswkHv2FfvVt2xjrD6V8rxFAQbJ4pbQ54hG6yHdcb
 7gpi5bY2b1QEFXEk0FdFJIiSrB5c6YvEM+oH9j7w2j6giuqlEnjnznWomUAo9dVkfcEPvk
 lkQ31hJJChtzSQOTUuRNQOnN6iEu2BQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-MtxTJQHtNsyXjRw676hftQ-1; Fri, 29 Nov 2019 05:07:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E448107ACC4;
 Fri, 29 Nov 2019 10:07:09 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B79660BE2;
 Fri, 29 Nov 2019 10:07:05 +0000 (UTC)
Date: Fri, 29 Nov 2019 11:07:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 2/2] Add -mem-shared option
Message-ID: <20191129110703.2b15c541@redhat.com>
In-Reply-To: <CAJ+F1CLZxhMf-bOAB4sVfuB1yaUMqiO70-ogpKVS3CqfC7y5KA@mail.gmail.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128141518.628245-3-marcandre.lureau@redhat.com>
 <20191128172807.788e6aeb@redhat.com>
 <CAJ+F1CLZxhMf-bOAB4sVfuB1yaUMqiO70-ogpKVS3CqfC7y5KA@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: MtxTJQHtNsyXjRw676hftQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Fri, 29 Nov 2019 00:31:32 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Thu, Nov 28, 2019 at 9:25 PM Igor Mammedov <imammedo@redhat.com> wrote=
:
> >
> > On Thu, 28 Nov 2019 18:15:18 +0400
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > =20
> > > Add an option to simplify shared memory / vhost-user setup.
> > >
> > > Currently, using vhost-user requires NUMA setup such as:
> > > -m 4G -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/=
shm,share=3Don -numa node,memdev=3Dmem
> > >
> > > As there is no other way to allocate shareable RAM, afaik.
> > >
> > > -mem-shared aims to have a simple way instead: -m 4G -mem-shared =20
> > User always can write a wrapper script if verbose CLI is too much,
> > and we won't have to deal with myriad permutations to maintain. =20
>=20
> Sure, but that's not exactly making it easier for the user,
> documentation etc (or machine that do not support numa as David
> mentionned).
on positive side it makes behavior consistent (and need to be documented
in one place (memdev)), i.e. user knows that he will get what he specified=
=20
on CLI.

With global options like you propose, good luck with figuring out
(and documenting it in user documentation will be nightmare)
if your config actually does what it's supposed to do or not.
That's unfortunate the state we are in right now with
mem-path/prealloc.

> > Also current -mem-path/prealloc in combination with memdevs is
> > the source of problems (as ram allocation uses 2 different paths).
> > It's possible to fix with a kludge but I'd rather fix it properly. =20
>=20
> I agree, however I think it's a separate problems. We don't have to
> fix both simultaneously. The semantic of a new CLI -mem-shared (or
> shared=3Don etc) can be defined and implemented in a simple way, before
> internal refactoring.
Well, it adds more invariants to already complex RAM allocation
I have to untangle. So lets look into it after memdev re-factoring.
I'll plan to post it right after merge window is open.

> > So during 5.0, I'm planning to consolidate -mem-path/prealloc
> > handling around memory backend internally (and possibly deprecate them)=
,
> > so the only way to allocate RAM for guest would be via memdevs.
> > (reducing number of options an globals that they use)
> > =20
>=20
> That would be great indeed. I tried to look at that in the past, but
> was a it overwhelmed by the amount of details and/or code complexity.
Complexity is only one side of issue, I'm mainly refactoring it because
different approaches to allocate RAM lead to subtle bugs that's hard to
spot and fix. That's why I'm against adding more invariants to the pile.

> > So user who wants something non trivial could override default
> > non-numa behavior with
> >   -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,sh=
are=3Don \
> >   -machine memdev=3Dmem
> > or use any other backend that suits theirs needs. =20
>=20
> That's nice, but not as friendly as a simple -mem-shared.
(I still do not like idea of convenience options but it won't
get onto the way much if implemented as "global property" to memdev,
so I won't object if there is real demand for it)

Simplicity in global options is deceiving once you have mixed
RAM (main and as -device), good luck with documenting how it
works in all possible configs and making it robust (so it
won't explode later) (I wouldn't take on such task).
And then poor user will have to figure it out as well.

Verbose way makes allocating backing storage consistent,
which is much more important (including end user).
The rest could be scripted or one could use higher level
mgmt tools if simplicity is desired.


> thanks
>=20
> > =20
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  exec.c                  | 11 ++++++++++-
> > >  hw/core/numa.c          | 16 +++++++++++++++-
> > >  include/sysemu/sysemu.h |  1 +
> > >  qemu-options.hx         | 10 ++++++++++
> > >  vl.c                    |  4 ++++
> > >  5 files changed, 40 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/exec.c b/exec.c
> > > index ffdb518535..4e53937eaf 100644
> > > --- a/exec.c
> > > +++ b/exec.c
> > > @@ -72,6 +72,10 @@
> > >  #include "qemu/mmap-alloc.h"
> > >  #endif
> > >
> > > +#ifdef CONFIG_POSIX
> > > +#include "qemu/memfd.h"
> > > +#endif
> > > +
> > >  #include "monitor/monitor.h"
> > >
> > >  //#define DEBUG_SUBPAGE
> > > @@ -2347,7 +2351,12 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t =
size, MemoryRegion *mr,
> > >      bool created;
> > >      RAMBlock *block;
> > >
> > > -    fd =3D file_ram_open(mem_path, memory_region_name(mr), &created,=
 errp);
> > > +    if (mem_path) {
> > > +        fd =3D file_ram_open(mem_path, memory_region_name(mr), &crea=
ted, errp);
> > > +    } else {
> > > +        fd =3D qemu_memfd_open(mr->name, size,
> > > +                             F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SE=
AL, errp);
> > > +    } =20
> >
> > that's what I'm mostly against, as it spills out memdev impl. details
> > into generic code.
> > =20
> > >      if (fd < 0) {
> > >          return NULL;
> > >      }
> > > diff --git a/hw/core/numa.c b/hw/core/numa.c
> > > index e3332a984f..6f72cddb1c 100644
> > > --- a/hw/core/numa.c
> > > +++ b/hw/core/numa.c
> > > @@ -493,7 +493,8 @@ static void allocate_system_memory_nonnuma(Memory=
Region *mr, Object *owner,
> > >      if (mem_path) {
> > >  #ifdef __linux__
> > >          Error *err =3D NULL;
> > > -        memory_region_init_ram_from_file(mr, owner, name, ram_size, =
0, 0,
> > > +        memory_region_init_ram_from_file(mr, owner, name, ram_size, =
0,
> > > +                                         mem_shared ? RAM_SHARED : 0=
,
> > >                                           mem_path, &err); =20
> > this will be gone and replaced by memory region that memdev initializes=
.
> > =20
> > >          if (err) {
> > >              error_report_err(err);
> > > @@ -513,6 +514,19 @@ static void allocate_system_memory_nonnuma(Memor=
yRegion *mr, Object *owner,
> > >  #else
> > >          fprintf(stderr, "-mem-path not supported on this host\n");
> > >          exit(1);
> > > +#endif
> > > +    } else if (mem_shared) {
> > > +#ifdef CONFIG_POSIX
> > > +        Error *err =3D NULL;
> > > +        memory_region_init_ram_from_file(mr, owner, NULL, ram_size, =
0,
> > > +                                         RAM_SHARED, NULL, &err);
> > > +        if (err) {
> > > +            error_report_err(err);
> > > +            exit(1);
> > > +        }
> > > +#else
> > > +        fprintf(stderr, "-mem-shared not supported on this host\n");
> > > +        exit(1);
> > >  #endif
> > >      } else {
> > >          memory_region_init_ram_nomigrate(mr, owner, name, ram_size, =
&error_fatal);
> > > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > > index 80c57fdc4e..80db8465a9 100644
> > > --- a/include/sysemu/sysemu.h
> > > +++ b/include/sysemu/sysemu.h
> > > @@ -55,6 +55,7 @@ extern bool enable_cpu_pm;
> > >  extern QEMUClockType rtc_clock;
> > >  extern const char *mem_path;
> > >  extern int mem_prealloc;
> > > +extern int mem_shared;
> > >
> > >  #define MAX_OPTION_ROMS 16
> > >  typedef struct QEMUOptionRom {
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 65c9473b73..4c69b03ad3 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -394,6 +394,16 @@ STEXI
> > >  Preallocate memory when using -mem-path.
> > >  ETEXI
> > >
> > > +DEF("mem-shared", 0, QEMU_OPTION_mem_shared,
> > > +    "-mem-shared     allocate shared memory\n", QEMU_ARCH_ALL)
> > > +STEXI
> > > +@item -mem-shared
> > > +@findex -mem-shared
> > > +Allocate guest RAM with shared mapping.  Whether the allocation is
> > > +anonymous or not (with -mem-path), QEMU will allocate a shared memor=
y that
> > > +can be shared by unrelated processes, such as vhost-user backends.
> > > +ETEXI
> > > +
> > >  DEF("k", HAS_ARG, QEMU_OPTION_k,
> > >      "-k language     use keyboard layout (for example 'fr' for Frenc=
h)\n",
> > >      QEMU_ARCH_ALL)
> > > diff --git a/vl.c b/vl.c
> > > index 6a65a64bfd..53b1155455 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -143,6 +143,7 @@ const char* keyboard_layout =3D NULL;
> > >  ram_addr_t ram_size;
> > >  const char *mem_path =3D NULL;
> > >  int mem_prealloc =3D 0; /* force preallocation of physical target me=
mory */
> > > +int mem_shared =3D 0; =20
> > Also what happened to no more globals policy?
> > =20
> > >  bool enable_mlock =3D false;
> > >  bool enable_cpu_pm =3D false;
> > >  int nb_nics;
> > > @@ -3172,6 +3173,9 @@ int main(int argc, char **argv, char **envp)
> > >              case QEMU_OPTION_mem_prealloc:
> > >                  mem_prealloc =3D 1;
> > >                  break;
> > > +            case QEMU_OPTION_mem_shared:
> > > +                mem_shared =3D 1;
> > > +                break;
> > >              case QEMU_OPTION_d:
> > >                  log_mask =3D optarg;
> > >                  break; =20
> >
> > =20
>=20
>=20


