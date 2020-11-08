Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0519C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CE2206DC
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CE2206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbtal-0002s6-NQ
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 17:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kbtXc-00025f-Gz
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:52:08 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kbtXa-0005Wj-Ab
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:52:08 -0500
Received: by mail-il1-f196.google.com with SMTP id n5so6612702ile.7
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 14:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bsxoeKOezDUh6BsLbQ10txlIGGkU61XQuswpx2tG1Qo=;
 b=CNWuv6K8csUI7W/91lZbt/1FPosAwNiK0K7NNNvDKQc9/1ney8H786WfjKDm0jJvYa
 C9ySzL0MnEjYh7M4rzAaGdNZgKI5lgfdZKZt81o6uTgtqeAmb6b5Rh2zWpPHoKdHbeuH
 34ZI0xw5JXmHAOTKWZzJTgwgGGem1+6p4DHiV2TuROd6x6zNH+lexXaCezBcOFw5zg+k
 /+D6v0jYtlr8WRJ6HTLcEGseSlTQ4n0DDnW1BFKW3nS0RgfJbEvYxgn8iznmejXKPunF
 ti+iX9PIQi6IvYKvcYWOqSUqZAP+fGh8IBnoHgB15xe08oO39Rr26Py9yecUV05XzkbP
 4N7w==
X-Gm-Message-State: AOAM533Ps0y78pxIphzGtQCjTVBPQmZoCgP6toB5zSg9ViQRezNjrAse
 1JtwSqMLTuYMvE7vUWe4Vo/l3wv/wPw=
X-Google-Smtp-Source: ABdhPJx5XRmc7mlWElQ2y2zAxvSwjFfy/JyZVptcv22ZKtXOoC70o9+Vknmo8q56kuk8/nIiUat2LA==
X-Received: by 2002:a92:330a:: with SMTP id a10mr7537253ilf.298.1604875925165; 
 Sun, 08 Nov 2020 14:52:05 -0800 (PST)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com.
 [209.85.166.46])
 by smtp.gmail.com with ESMTPSA id d23sm4105662ill.56.2020.11.08.14.52.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 14:52:05 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id n129so7967434iod.5
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 14:52:04 -0800 (PST)
X-Received: by 2002:a02:70ce:: with SMTP id f197mr9075830jac.120.1604875924613; 
 Sun, 08 Nov 2020 14:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20201108052605.45840-1-j@getutm.app>
 <20201108052605.45840-5-j@getutm.app>
 <80ac1230-b0b2-a3bf-df2b-8183ec6fcfbb@amsat.org>
In-Reply-To: <80ac1230-b0b2-a3bf-df2b-8183ec6fcfbb@amsat.org>
From: Joelle van Dyne <j@getutm.app>
Date: Sun, 8 Nov 2020 14:51:53 -0800
X-Gmail-Original-Message-ID: <CA+E+eSB0yeeM+j11k9=EMxbW5ySaL80xUyJT5QKoimy71ZA4jw@mail.gmail.com>
Message-ID: <CA+E+eSB0yeeM+j11k9=EMxbW5ySaL80xUyJT5QKoimy71ZA4jw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] coroutine: add libucontext as external library
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.166.196; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 17:52:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thanks, it built on my 18.04 machine but it seems that newer versions
of GCC had different behavior on the underscore assembly functions. I
will fix it and test on 20.04.

-j

On Sun, Nov 8, 2020 at 7:46 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Hi Joelle,
>
> On 11/8/20 6:26 AM, Joelle van Dyne wrote:
> > iOS does not support ucontext natively for aarch64 and the sigaltstack =
is
> > also unsupported (even worse, it fails silently, see:
> > https://openradar.appspot.com/13002712 )
> >
> > As a workaround we include a library implementation of ucontext and add=
 it
> > as a build option.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >  configure                 | 23 ++++++++++++++++++++---
> >  meson.build               | 28 +++++++++++++++++++++++++++-
> >  util/coroutine-ucontext.c |  9 +++++++++
> >  .gitmodules               |  3 +++
> >  libucontext               |  1 +
> >  meson_options.txt         |  2 ++
> >  6 files changed, 62 insertions(+), 4 deletions(-)
> >  create mode 160000 libucontext
> ...
>
> > diff --git a/meson.build b/meson.build
> > index 8894171bd1..e62324d5ac 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1259,9 +1259,34 @@ if not fdt.found() and fdt_required.length() > 0
> >    error('fdt not available but required by targets ' + ', '.join(fdt_r=
equired))
> >  endif
> >
> > +ucontext =3D not_found
> > +if get_option('ucontext').enabled()
> > +  if not fs.is_dir(meson.current_source_dir() / 'libucontext/arch' / c=
pu)
> > +    error('libucontext is wanted but not implemented for host ' + cpu)
> > +  endif
> > +  arch =3D host_machine.cpu()
> > +  ucontext_cargs =3D ['-DG_LOG_DOMAIN=3D"ucontext"', '-DCUSTOM_IMPL']
> > +  ucontext_files =3D [
> > +    'libucontext/arch' / arch / 'getcontext.S',
> > +    'libucontext/arch' / arch / 'setcontext.S',
> > +    'libucontext/arch' / arch / 'makecontext.c',
> > +    'libucontext/arch' / arch / 'startcontext.S',
> > +    'libucontext/arch' / arch / 'swapcontext.S',
> > +  ]
> > +
> > +  ucontext_inc =3D include_directories('libucontext/include')
> > +  libucontext =3D static_library('ucontext',
> > +                               sources: ucontext_files,
> > +                               c_args: ucontext_cargs,
> > +                               include_directories: ucontext_inc)
> > +  ucontext =3D declare_dependency(link_with: libucontext,
> > +                                include_directories: ucontext_inc)
> > +endif
> > +
> >  config_host_data.set('CONFIG_CAPSTONE', capstone.found())
> >  config_host_data.set('CONFIG_FDT', fdt.found())
> >  config_host_data.set('CONFIG_SLIRP', slirp.found())
> > +config_host_data.set('CONFIG_LIBUCONTEXT', ucontext.found())
> >
> >  #####################
> >  # Generated sources #
> > @@ -1477,7 +1502,7 @@ util_ss.add_all(trace_ss)
> >  util_ss =3D util_ss.apply(config_all, strict: false)
> >  libqemuutil =3D static_library('qemuutil',
> >                               sources: util_ss.sources() + stub_ss.sour=
ces() + genh,
> > -                             dependencies: [util_ss.dependencies(), m,=
 glib, socket, malloc])
> > +                             dependencies: [util_ss.dependencies(), m,=
 glib, socket, malloc, ucontext])
> >  qemuutil =3D declare_dependency(link_with: libqemuutil,
> >                                sources: genh + version_res)
> >
> > @@ -2135,6 +2160,7 @@ if targetos =3D=3D 'windows'
> >    summary_info +=3D {'QGA MSI support':   config_host.has_key('CONFIG_=
QGA_MSI')}
> >  endif
> >  summary_info +=3D {'seccomp support':   config_host.has_key('CONFIG_SE=
CCOMP')}
> > +summary_info +=3D {'libucontext support': ucontext.found()}
> >  summary_info +=3D {'coroutine backend': config_host['CONFIG_COROUTINE_=
BACKEND']}
> >  summary_info +=3D {'coroutine pool':    config_host['CONFIG_COROUTINE_=
POOL'] =3D=3D '1'}
> >  summary_info +=3D {'debug stack usage': config_host.has_key('CONFIG_DE=
BUG_STACK_USAGE')}
> > diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
> > index 904b375192..1e1dd43512 100644
> > --- a/util/coroutine-ucontext.c
> > +++ b/util/coroutine-ucontext.c
> > @@ -23,7 +23,16 @@
> >  #undef _FORTIFY_SOURCE
> >  #endif
> >  #include "qemu/osdep.h"
> > +#if defined(CONFIG_LIBUCONTEXT)
> > +#include <libucontext.h>
> > +#define ucontext_t libucontext_ucontext_t
> > +#define getcontext libucontext_getcontext
> > +#define setcontext libucontext_setcontext
> > +#define swapcontext libucontext_swapcontext
> > +#define makecontext libucontext_makecontext
> > +#else
> >  #include <ucontext.h>
> > +#endif
> >  #include "qemu/coroutine_int.h"
>
> Trying on Ubuntu 20.04 I'm getting:
>
> /usr/bin/ld: libqemuutil.a(util_coroutine-ucontext.c.o): in function
> `qemu_coroutine_new':
> util/coroutine-ucontext.c:203: undefined reference to
> `libucontext_getcontext'
> /usr/bin/ld: util/coroutine-ucontext.c:254: undefined reference to
> `libucontext_swapcontext'
> /usr/bin/ld: libucontext.a(libucontext_arch_x86_64_makecontext.c.o): in
> function `libucontext_makecontext':
> libucontext/arch/x86_64/makecontext.c:54: undefined reference to
> `_start_context'
> collect2: error: ld returned 1 exit status
>
> Regards,
>
> Phil.

