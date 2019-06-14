Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1ABC31E4E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5FB2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0fw0iKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5FB2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbrJa-00011k-Lz
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37414)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hbqDA-0007Rv-NL
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hbqD1-0005iR-3M
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:41:55 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hbqD0-0005V0-MK
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:41:50 -0400
Received: by mail-ot1-x343.google.com with SMTP id 107so3399841otj.8
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ttcj1Gl2EMuiTXx8LS5XqgJD/ipgyuC+lSBbp+vwVTI=;
 b=g0fw0iKB6fKxUyXL9JiKRZLVk+6fUywD/Vr2Boh3zB54iiPwT/67PLg4gKWscEn/37
 wSB8tMrNVKue96V+bhyg64dVuWeaX7y0HVpeDJea6YYX5c1odq1yN9S2UCb+IKnPSEPZ
 pyHEiYDybIZu9ZCwxfaV0iTT5XIfwzkim5tEYltakBdpsXgRkeDyci+d3PHS8oAVYLn3
 tSIb8WfZpDnCFDwNRrtZRajOZ5iNSD62efPcM4NOvL404WYuGZIBCWeau4BgdIyShk6I
 n9heFJbORhlr634EoTSKUW2EOliPrnxR457MsdorRVcchqUM44ZI0DysuTWyhniY2tGr
 uoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ttcj1Gl2EMuiTXx8LS5XqgJD/ipgyuC+lSBbp+vwVTI=;
 b=NOwjXqmPfLPXJtKW0jyZtNAqCMd/bK0Ug9L4LT0RjPpEoupqFd/ETs68ES3E9EJuLB
 UKGf9bsea/qSEL4hb3qoPX13SjD+77EgB9NsGOKo3p/zaPebGSppbZk60iw4mmL+lsXX
 wBebNJavwbEOE/wVyk7FK2pbbv7mhYB4lMMDDqCMHtbxDfGJIwcTavrk90jYLjISMIMY
 XMtGqoc0A3eO+Dmb11B9pbH4YDpHtgt3qc0bwSEfHdUfFLguG/pTQIggxTGyWSc//wz4
 Qf1yemNqQNblDZly63wZ+6WlBje+qFrylodxEcfw/MVXgUIs88Hc681CXYbnNPhnMRey
 16Cg==
X-Gm-Message-State: APjAAAX50Xs8+SleAjy9QefGYpmfXig31GfqtVsxOCOp2tqU3sgCoF87
 QJjMlZZJkF2qscj+IXFKAaz6tXjxYHFhkNpZ2OU=
X-Google-Smtp-Source: APXvYqzW2BgcAPBs3oXfXCH9iQFUfqdox63RdincJf0LVjMniSP/69VcLIQRPmhS5sOH/m6a2SbaBNHliS6h2MrnfAQ=
X-Received: by 2002:a05:6830:c6:: with SMTP id
 x6mr18497571oto.64.1560534095922; 
 Fri, 14 Jun 2019 10:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190614171200.21078-1-alex.bennee@linaro.org>
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 14 Jun 2019 19:41:24 +0200
Message-ID: <CAL1e-=g6Yd6+w3P23Y5z68EEXo30VGKhGJMrEaqcS6G01dT2=Q@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 00/50] tcg plugin support
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

On Fri, Jun 14, 2019 at 7:22 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> Hi,
>
> This is v3 of the proposed plugins API for QEMU. As Emilio is busy
> having finished his time at Columbia I have volunteered to take the
> patch series forward. Emilio's RFC v2 was posted last year:
>
>   Subject: [RFC v2 00/38] Plugin support
>   Date: Sun,  9 Dec 2018 14:37:11 -0500
>   Message-Id: <20181209193749.12277-1-cota@braap.org>
>
> The idea is to present a plugin interface that allows for interesting
> experiments to be written while not exposing the internal details of
> how the TCG works to the wider world.
>
> Changes from last year
>
>   - re-basing and fixing up conflicts
>   - moved to plugins/ and split files up (core/api/loader)
>   - added a design document (docs/devel/plugins.rst)
>   - replaced auto-growing structures with glib GArray and friends
>   - expanded API to include access to disassembly
>   - wrote some more example plugins
>   - dropped the RFC tag ;-)
>
> There are a few things left to sort out. Currently the haddr
> calculation relies on the softmmu TLB code for each architecture to
> dump it in a cpu_env location. Currently this is only done on x86 and
> we would require some tweaking to each backend. I think it would
> probably be better to just have a wrapper helper which could do the
> lookup of the (hot) TLB in C to calculate the address before calling
> the helpers.
>

Great to see this series!

Is there any particular conceptual reason why not all targets are included
(i.e. mips, s390, etc.)? Or it was just, let's say, lack of your time resou=
rces
to complete everything?

Yours,
Aleksandar

> I also ended up adding a bunch of miscellaneous fixes at the end while
> I was re-spinning. If they get some review I'll try and get the
> non-controversial stuff up-streamed first.
>
> The area that needs the most review is the single pass TCG op
> insertion code. When plugins are enabled each instruction gets dummy
> ops inserted and then at the end we swap those out for the actual
> calls or remove them from the stream. Hopefully this is not too much
> of an abuse of TCG mechanisms.
>
> I'm aiming to get this in for 4.1 but I guess that will depend on how
> the review and iteration goes.
>
> Alex Benn=C3=A9e (12):
>   docs/devel: add plugins.rst design document
>   configure: add --enable-plugins (MOVE TO END)
>   plugin: add implementation of the api
>   tests/tcg: enable plugin testing
>   tests/plugin: add a hotblocks plugin
>   plugin: add qemu_plugin_insn_disas helper
>   tests/plugin: add instruction execution breakdown
>   tests/plugin: add hotpages plugin to breakdown memory access patterns
>   accel/stubs: reduce headers from tcg-stub
>   include/exec: wrap cpu_ldst.h in CONFIG_TCG
>   include/exec/cpu-defs.h: fix typo
>   TODO: API changes to make?
>
> Emilio G. Cota (36):
>   trace: expand mem_info:size_shift to 3 bits
>   tcg/README: fix typo s/afterwise/afterwards/
>   cpu: introduce cpu_in_exclusive_work_context()
>   translate-all: use cpu_in_exclusive_work_context() in tb_flush
>   plugin: add user-facing API
>   plugin: add core code
>   queue: add QTAILQ_REMOVE_SEVERAL
>   cputlb: document get_page_addr_code
>   cputlb: introduce get_page_addr_code_hostp
>   plugin-gen: add module for TCG-related code
>   tcg: add tcg_gen_st_ptr
>   tcg: add MO_HADDR to TCGMemOp
>   atomic_template: fix indentation in GEN_ATOMIC_HELPER
>   atomic_template: add inline trace/plugin helpers
>   cpu_ldst_useronly_template: remove redundant #ifndef CODE_ACCESS
>   tcg: let plugins instrument memory accesses
>   translate-all: notify plugin code of tb_flush
>   *-user: notify plugin of exit
>   *-user: plugin syscalls
>   cpu: hook plugin vcpu events
>   plugin-gen: add plugin_insn_append
>   translator: add translator_ld{ub,sw,uw,l,q}
>   target/arm: call qemu_plugin_insn_append
>   target/ppc: fetch code with translator_ld
>   target/sh4: fetch code with translator_ld
>   target/i386: fetch code with translator_ld
>   target/hppa: fetch code with translator_ld
>   target/m68k: fetch code with translator_ld
>   target/alpha: fetch code with translator_ld
>   target/riscv: fetch code with translator_ld
>   target/sparc: fetch code with translator_ld
>   target/xtensa: fetch code with translator_ld
>   target/openrisc: fetch code with translator_ld
>   translator: inject instrumentation from plugins
>   plugin: add API symbols to qemu-plugins.symbols
>   tests/plugin: add sample plugins
>
> Llu=C3=ADs Vilanova (2):
>   vl: support -plugin option
>   linux-user: support -plugin option
>
>  Makefile                                  |   11 +-
>  Makefile.target                           |    2 +
>  accel/stubs/tcg-stub.c                    |    3 -
>  accel/tcg/Makefile.objs                   |    1 +
>  accel/tcg/atomic_template.h               |  117 ++-
>  accel/tcg/cpu-exec.c                      |    3 +
>  accel/tcg/cputlb.c                        |   56 +-
>  accel/tcg/plugin-gen.c                    | 1079 +++++++++++++++++++++
>  accel/tcg/plugin-helpers.h                |    6 +
>  accel/tcg/translate-all.c                 |   15 +-
>  accel/tcg/translator.c                    |   16 +
>  bsd-user/syscall.c                        |   12 +
>  configure                                 |   86 +-
>  cpus-common.c                             |    2 +
>  cpus.c                                    |   10 +
>  disas.c                                   |  103 ++
>  docs/devel/index.rst                      |    1 +
>  docs/devel/plugins.rst                    |   99 ++
>  exec.c                                    |    2 +
>  include/disas/disas.h                     |    2 +
>  include/exec/cpu-defs.h                   |   11 +-
>  include/exec/cpu_ldst.h                   |    9 +
>  include/exec/cpu_ldst_template.h          |   40 +-
>  include/exec/cpu_ldst_useronly_template.h |   36 +-
>  include/exec/exec-all.h                   |   64 +-
>  include/exec/helper-gen.h                 |    1 +
>  include/exec/helper-proto.h               |    1 +
>  include/exec/helper-tcg.h                 |    1 +
>  include/exec/plugin-gen.h                 |   71 ++
>  include/exec/translator.h                 |   30 +-
>  include/qemu/plugin.h                     |  261 +++++
>  include/qemu/qemu-plugin.h                |  349 +++++++
>  include/qemu/queue.h                      |   10 +
>  include/qom/cpu.h                         |   19 +
>  linux-user/exit.c                         |    1 +
>  linux-user/main.c                         |   18 +
>  linux-user/syscall.c                      |    3 +
>  plugins/.gitignore                        |    2 +
>  plugins/Makefile.objs                     |   21 +
>  plugins/api.c                             |  274 ++++++
>  plugins/core.c                            |  524 ++++++++++
>  plugins/loader.c                          |  353 +++++++
>  plugins/plugin.h                          |   95 ++
>  plugins/qemu-plugins.symbols              |   36 +
>  qemu-options.hx                           |   17 +
>  qom/cpu.c                                 |    2 +
>  target/alpha/translate.c                  |    2 +-
>  target/arm/translate-a64.c                |    2 +
>  target/arm/translate.c                    |    8 +-
>  target/hppa/translate.c                   |    2 +-
>  target/i386/translate.c                   |   10 +-
>  target/m68k/translate.c                   |    2 +-
>  target/openrisc/translate.c               |    2 +-
>  target/ppc/translate.c                    |    8 +-
>  target/riscv/translate.c                  |    2 +-
>  target/sh4/translate.c                    |    4 +-
>  target/sparc/translate.c                  |    2 +-
>  target/xtensa/translate.c                 |    4 +-
>  tcg/README                                |    2 +-
>  tcg/i386/tcg-target.inc.c                 |    8 +
>  tcg/tcg-op.c                              |   40 +-
>  tcg/tcg-op.h                              |   16 +
>  tcg/tcg-opc.h                             |    3 +
>  tcg/tcg.c                                 |   22 +
>  tcg/tcg.h                                 |   28 +
>  tests/Makefile.include                    |   10 +-
>  tests/plugin/Makefile                     |   31 +
>  tests/plugin/bb.c                         |   66 ++
>  tests/plugin/empty.c                      |   30 +
>  tests/plugin/hotblocks.c                  |  145 +++
>  tests/plugin/hotpages.c                   |  152 +++
>  tests/plugin/howvec.c                     |  297 ++++++
>  tests/plugin/insn.c                       |   63 ++
>  tests/plugin/mem.c                        |   93 ++
>  tests/tcg/Makefile                        |   34 +
>  tests/tcg/arm/Makefile.softmmu-target     |    1 +
>  trace-events                              |    2 +-
>  vl.c                                      |   11 +
>  78 files changed, 4855 insertions(+), 122 deletions(-)
>  create mode 100644 accel/tcg/plugin-gen.c
>  create mode 100644 accel/tcg/plugin-helpers.h
>  create mode 100644 docs/devel/plugins.rst
>  create mode 100644 include/exec/plugin-gen.h
>  create mode 100644 include/qemu/plugin.h
>  create mode 100644 include/qemu/qemu-plugin.h
>  create mode 100644 plugins/.gitignore
>  create mode 100644 plugins/Makefile.objs
>  create mode 100644 plugins/api.c
>  create mode 100644 plugins/core.c
>  create mode 100644 plugins/loader.c
>  create mode 100644 plugins/plugin.h
>  create mode 100644 plugins/qemu-plugins.symbols
>  create mode 100644 tests/plugin/Makefile
>  create mode 100644 tests/plugin/bb.c
>  create mode 100644 tests/plugin/empty.c
>  create mode 100644 tests/plugin/hotblocks.c
>  create mode 100644 tests/plugin/hotpages.c
>  create mode 100644 tests/plugin/howvec.c
>  create mode 100644 tests/plugin/insn.c
>  create mode 100644 tests/plugin/mem.c
>
> --
> 2.20.1
>
>

