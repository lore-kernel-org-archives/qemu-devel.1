Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4233C43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F0E207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dopVZJLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F0E207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKYR-0003Ia-AA
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 03:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTKXG-0002pC-LF
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:52:22 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:33837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTKXD-0005Xe-4t
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:52:22 -0400
Received: by mail-lf1-x143.google.com with SMTP id z2so1763370lfr.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 00:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=/C4Y4adzXAxvB0pxlp0t8AIrloMh8LEqymw0m39WdxM=;
 b=dopVZJLBYxQkcpL/Qa4KOL3n3dJTNCoZBh6F1KKiw4b9GGpTrA3DIGexy6ezXQaRH0
 gOrFX313nrdzqR9aZIUXMAOmmnAu2atIHWCGzvcfmo9ZO5oK8ws0WdNrInyc5uPYN/Sp
 mPNOB4XhXFTRuFERBondRVUIsEewdyQqv1EWrA1oilUjkYO5ULNwxxt9ffr9Zm00j0EL
 IPy/JmItRydOgRX35ItblhldD2KiRvdT7e0tQyi/SusFnAQnbVArdYQJK+9jPHTdJuol
 5fSubLASFfjk7mPMa/N0QVdWf8XYr/BK/N6IwyZCQRHq5gTedsuLl/czx4yGQQzUa7/r
 SXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=/C4Y4adzXAxvB0pxlp0t8AIrloMh8LEqymw0m39WdxM=;
 b=MFduZJv0UsfKRi6EZRL3ucAfydujLBzZQ9byoJOnLu6XQkDZ+dMyP7XRYGi7D/T/Yf
 rapdVkPU232nKj/+6YGIXN0BM5h85fXMkkRZ+jORn8YQmFt9ZP19EmQAwdTEUfR75PR+
 mWSfzqVtdrUa0yxmEV21S2nbZLGUt2fFA0Dt5rXQpna+0+ybTOPKOSyYZIKM3mv5915l
 oN9/UKxzv76hSCze/EeGv7rQESkoRn2LPMimv3/nNYOYm7v1Lze0knQPPQt7qXo3YCAV
 Sb5iEFOWIYq2ju6PAq2hKJhhKPKfMU+HulSa91gB8uktCuTml2OqjufWsOxljKQeqTHz
 XC7g==
X-Gm-Message-State: AOAM532PmEBQ5KjcMFQNf4ce9ml6lsmyNu58pkiIjNehZAY9QLEkT9AV
 6WM9BKUPAmmd32SzsuhJ2vVoyzvk07XgS4hzUaA=
X-Google-Smtp-Source: ABdhPJzB9pExFOLEwUYljR2CdqkSYy9pGM/Wi8+ZVd9E7U+TZrHXtV+9Lxr7H3OKAAOfCvK1iHXa+gsb8u1opG+WzZ8=
X-Received: by 2002:a19:185:: with SMTP id 127mr41282lfb.356.1602834736700;
 Fri, 16 Oct 2020 00:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201015220626.418-1-luoyonggang@gmail.com>
 <20201015220626.418-4-luoyonggang@gmail.com>
 <9bd01bce-7409-26f9-5401-8f5ddd4f924c@redhat.com>
In-Reply-To: <9bd01bce-7409-26f9-5401-8f5ddd4f924c@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 16 Oct 2020 15:52:05 +0800
Message-ID: <CAE2XoE9EvboWrqMp_SD0BJ+=D3JjXUeL22qaZD=G5R+M0c4Npg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] meson: Move the detection logic for sphinx to meson
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001d61de05b1c50bfe"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001d61de05b1c50bfe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 3:46 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Here is a better way to write the meson test:
>
> if get_option('sphinx_build') =3D=3D ''
>   sphinx_build =3D find_program(['sphinx-build-3', 'sphinx-build'],
>                               required: get_option('docs'))
> else
>   sphinx_build =3D find_program(get_option('sphinx_build'),
>                               required: get_option('docs'))
> endif
>
> SPHINX_ARGS =3D [sphinx_build]
> # If we're making warnings fatal, apply this to Sphinx runs as well
> if get_option('werror')
>   SPHINX_TEST_ARGS +=3D [ '-W' ]
> endif
>
> # Check if tools are available to build documentation.
> build_docs =3D false
> if sphinx_build.found()
>   # This is a bit awkward but works: create a trivial document and
>   # try to run it with our configuration file (which enforces a
>   # version requirement). This will fail if sphinx-build is too old.
>   run_command('mkdir', ['-p', tmpdir / 'sphinx'])
>   run_command('touch', [tmpdir / 'sphinx/index.rst'])
>   sphinx_build_test_out =3D run_command(SPHINX_ARGS + [
>     '-c', meson.current_source_dir() / 'docs',
>     '-b', 'html', tmpdir / 'sphinx',
>     tmpdir / 'sphinx/out'])
>   build_docs =3D (sphinx_build_test_out.returncode() =3D=3D 0)
> endif
There is subtle error here, when  sphinx_build not found, there is
SPHINX_ARGS  should be [],
otherwise, latter place using  SPHINX_ARGS  have not found sphinx_build
will cause error by meson
..
I'll add

else
  SPHINX_ARGS  =3D []
endif

>
> if not build_docs
>   if sphinx_build_option !=3D ''
>     warning('@0@ exists but it is either too old or uses too old a Python
version'.format(sphinx_build_option))
>   endif
>   if get_option('docs').enabled()
>     error('Install a Python 3 version of python-sphinx')
>   endif
> endif
>
>
>
> On 16/10/20 00:06, Yonggang Luo wrote:
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  configure                     | 59 +++-------------------------------
> >  docs/meson.build              |  4 +--
> >  meson.build                   | 60 +++++++++++++++++++++++++++++++----
> >  meson_options.txt             |  5 ++-
> >  tests/qapi-schema/meson.build |  2 +-
> >  5 files changed, 64 insertions(+), 66 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 1ce31f97b4..ff593a8542 100755
> > --- a/configure
> > +++ b/configure
> > @@ -297,7 +297,7 @@ brlapi=3D""
> >  curl=3D""
> >  iconv=3D"auto"
> >  curses=3D"auto"
> > -docs=3D""
> > +docs=3D"auto"
> >  fdt=3D"auto"
> >  netmap=3D"no"
> >  sdl=3D"auto"
> > @@ -822,15 +822,6 @@ do
> >      fi
> >  done
> >
> > -sphinx_build=3D
> > -for binary in sphinx-build-3 sphinx-build
> > -do
> > -    if has "$binary"
> > -    then
> > -        sphinx_build=3D$(command -v "$binary")
> > -        break
> > -    fi
> > -done
> >
> >  # Check for ancillary tools used in testing
> >  genisoimage=3D
> > @@ -1226,9 +1217,9 @@ for opt do
> >    ;;
> >    --disable-crypto-afalg) crypto_afalg=3D"no"
> >    ;;
> > -  --disable-docs) docs=3D"no"
> > +  --disable-docs) docs=3D"disabled"
> >    ;;
> > -  --enable-docs) docs=3D"yes"
> > +  --enable-docs) docs=3D"enabled"
> >    ;;
> >    --disable-vhost-net) vhost_net=3D"no"
> >    ;;
> > @@ -4413,45 +4404,6 @@ if check_include linux/btrfs.h ; then
> >      btrfs=3Dyes
> >  fi
> >
> > -# If we're making warnings fatal, apply this to Sphinx runs as well
> > -sphinx_werror=3D""
> > -if test "$werror" =3D "yes"; then
> > -    sphinx_werror=3D"-W"
> > -fi
> > -
> > -# Check we have a new enough version of sphinx-build
> > -has_sphinx_build() {
> > -    # This is a bit awkward but works: create a trivial document and
> > -    # try to run it with our configuration file (which enforces a
> > -    # version requirement). This will fail if either
> > -    # sphinx-build doesn't exist at all or if it is too old.
> > -    mkdir -p "$TMPDIR1/sphinx"
> > -    touch "$TMPDIR1/sphinx/index.rst"
> > -    "$sphinx_build" $sphinx_werror -c "$source_path/docs" \
> > -                    -b html "$TMPDIR1/sphinx" \
> > -                    "$TMPDIR1/sphinx/out"  >> config.log 2>&1
> > -}
> > -
> > -# Check if tools are available to build documentation.
> > -if test "$docs" !=3D "no" ; then
> > -  if has_sphinx_build; then
> > -    sphinx_ok=3Dyes
> > -  else
> > -    sphinx_ok=3Dno
> > -  fi
> > -  if test "$sphinx_ok" =3D "yes"; then
> > -    docs=3Dyes
> > -  else
> > -    if test "$docs" =3D "yes" ; then
> > -      if has $sphinx_build && test "$sphinx_ok" !=3D "yes"; then
> > -        echo "Warning: $sphinx_build exists but it is either too old
or uses too old a Python version" >&2
> > -      fi
> > -      feature_not_found "docs" "Install a Python 3 version of
python-sphinx"
> > -    fi
> > -    docs=3Dno
> > -  fi
> > -fi
> > -
> >  # Search for bswap_32 function
> >  byteswap_h=3Dno
> >  cat > $TMPC << EOF
> > @@ -6087,9 +6039,6 @@ qemu_version=3D$(head $source_path/VERSION)
> >  echo "PKGVERSION=3D$pkgversion" >>$config_host_mak
> >  echo "SRC_PATH=3D$source_path" >> $config_host_mak
> >  echo "TARGET_DIRS=3D$target_list" >> $config_host_mak
> > -if [ "$docs" =3D "yes" ] ; then
> > -  echo "BUILD_DOCS=3Dyes" >> $config_host_mak
> > -fi
> >  if test "$modules" =3D "yes"; then
> >    # $shacmd can generate a hash started with digit, which the compiler
doesn't
> >    # like as an symbol. So prefix it with an underscore
> > @@ -6794,7 +6743,6 @@ fi
> >  echo "ROMS=3D$roms" >> $config_host_mak
> >  echo "MAKE=3D$make" >> $config_host_mak
> >  echo "PYTHON=3D$python" >> $config_host_mak
> > -echo "SPHINX_BUILD=3D$sphinx_build" >> $config_host_mak
> >  echo "GENISOIMAGE=3D$genisoimage" >> $config_host_mak
> >  echo "MESON=3D$meson" >> $config_host_mak
> >  echo "CC=3D$cc" >> $config_host_mak
> > @@ -7076,6 +7024,7 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \
> >          -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \
> >          -Dcapstone=3D$capstone -Dslirp=3D$slirp -Dfdt=3D$fdt \
> >          -Diconv=3D$iconv -Dcurses=3D$curses \
> > +        -Ddocs=3D$docs -Dsphinx_build=3D$sphinx_build \
> >          $cross_arg \
> >          "$PWD" "$source_path"
> >
> > diff --git a/docs/meson.build b/docs/meson.build
> > index 0340d489ac..f566809a6a 100644
> > --- a/docs/meson.build
> > +++ b/docs/meson.build
> > @@ -37,7 +37,7 @@ if build_docs
> >                  input: [files('conf.py'), files(manual / 'conf.py')],
> >                  depfile: manual + '.d',
> >                  depend_files: sphinx_extn_depends,
> > -                command: [SPHINX_ARGS, '-Ddepfile=3D@DEPFILE@',
> > +                command: SPHINX_ARGS + ['-Ddepfile=3D@DEPFILE@',
> >                            '-Ddepfile_stamp=3D@OUTPUT0@',
> >                            '-b', 'html', '-d', private_dir,
> >                            input_dir, output_dir])
> > @@ -59,7 +59,7 @@ if build_docs
> >                           input: this_manual,
> >                           install: build_docs,
> >                           install_dir: install_dirs,
> > -                         command: [SPHINX_ARGS, '-b', 'man', '-d',
private_dir,
> > +                         command: SPHINX_ARGS + ['-b', 'man', '-d',
private_dir,
> >                                     input_dir,
meson.current_build_dir()])
> >      endif
> >    endforeach
> > diff --git a/meson.build b/meson.build
> > index 8156df8b71..8940468208 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -17,7 +17,13 @@ cc =3D meson.get_compiler('c')
> >  config_host =3D keyval.load(meson.current_build_dir() /
'config-host.mak')
> >  enable_modules =3D 'CONFIG_MODULES' in config_host
> >  enable_static =3D 'CONFIG_STATIC' in config_host
> > -build_docs =3D 'BUILD_DOCS' in config_host
> > +
> > +# Temporary directory used for files created while
> > +# configure runs. Since it is in the build directory
> > +# we can safely blow away any previous version of it
> > +# (and we need not jump through hoops to try to delete
> > +# it when configure exits.)
> > +tmpdir =3D meson.current_build_dir() / 'config-temp'
> >
> >  if get_option('qemu_suffix').startswith('/')
> >    error('qemu_suffix cannot start with a /')
> > @@ -1235,12 +1241,52 @@ foreach d : hx_headers
> >  endforeach
> >  genh +=3D hxdep
> >
> > -SPHINX_ARGS =3D [config_host['SPHINX_BUILD'],
> > -               '-Dversion=3D' + meson.project_version(),
> > -               '-Drelease=3D' + config_host['PKGVERSION']]
> > +sphinx_build =3D not_found
> > +sphinx_build_option =3D get_option('sphinx_build')
> > +if sphinx_build_option =3D=3D ''
> > +  sphinx_build =3D find_program('sphinx-build', required: false)
> > +else
> > +  sphinx_build =3D find_program(sphinx_build_option, required: false)
> > +endif
> >
> > +SPHINX_TEST_ARGS =3D []
> > +# If we're making warnings fatal, apply this to Sphinx runs as well
> >  if get_option('werror')
> > -  SPHINX_ARGS +=3D [ '-W' ]
> > +  SPHINX_TEST_ARGS +=3D [ '-W' ]
> > +endif
> > +
> > +build_docs =3D false
> > +docs_option =3D get_option('docs')
> > +# Check if tools are available to build documentation.
> > +if sphinx_build.found() and not docs_option.disabled()
> > +    # This is a bit awkward but works: create a trivial document and
> > +    # try to run it with our configuration file (which enforces a
> > +    # version requirement). This will fail if either
> > +    # sphinx-build doesn't exist at all or if it is too old.
> > +    run_command('mkdir', ['-p', tmpdir / 'sphinx'])
> > +    run_command('touch', [tmpdir / 'sphinx/index.rst'])
> > +    sphinx_build_test_out =3D run_command(sphinx_build, SPHINX_TEST_AR=
GS
+ [
> > +      '-c', meson.current_source_dir() / 'docs',
> > +      '-b', 'html', tmpdir / 'sphinx',
> > +      tmpdir / 'sphinx/out'])
> > +    if sphinx_build_test_out.returncode() =3D=3D 0
> > +      build_docs =3D true
> > +    else
> > +      if docs_option.enabled()
> > +        if sphinx_build_option !=3D ''
> > +          warning('Warning: @0@ exists but it is either too old or
uses too old a Python version'.format(sphinx_build_option))
> > +        endif
> > +        error('Warning: Install a Python 3 version of python-sphinx')
> > +      endif
> > +      # do not building docs
> > +    endif
> > +endif
> > +
> > +SPHINX_ARGS =3D []
> > +if build_docs
> > +  SPHINX_ARGS =3D [sphinx_build]
> > +  SPHINX_ARGS +=3D SPHINX_TEST_ARGS
> > +  SPHINX_ARGS +=3D ['-Dversion=3D' + meson.project_version(), '-Drelea=
se=3D'
+ config_host['PKGVERSION']]
> >  endif
> >
> >  sphinx_extn_depends =3D [ meson.source_root() / 'docs/sphinx/depfile.p=
y',
> > @@ -1918,7 +1964,7 @@ summary_info +=3D {'QEMU_CFLAGS':
config_host['QEMU_CFLAGS']}
> >  summary_info +=3D {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
> >  summary_info +=3D {'make':              config_host['MAKE']}
> >  summary_info +=3D {'python':            '@0@ (version: @1@)'.format(py=
thon.full_path(),
python.language_version())}
> > -summary_info +=3D {'sphinx-build':      config_host['SPHINX_BUILD']}
> > +summary_info +=3D {'sphinx-build':      sphinx_build.found()}
> >  summary_info +=3D {'genisoimage':       config_host['GENISOIMAGE']}
> >  # TODO: add back version
> >  summary_info +=3D {'slirp support':     slirp_opt =3D=3D 'disabled' ? =
false
: slirp_opt}
> > @@ -1986,7 +2032,7 @@ if config_host.has_key('CONFIG_XEN_BACKEND')
> >    summary_info +=3D {'xen ctrl version':
 config_host['CONFIG_XEN_CTRL_INTERFACE_VERSION']}
> >  endif
> >  summary_info +=3D {'brlapi support':
 config_host.has_key('CONFIG_BRLAPI')}
> > -summary_info +=3D {'Documentation':
config_host.has_key('BUILD_DOCS')}
> > +summary_info +=3D {'Documentation':     build_docs}
> >  summary_info +=3D {'PIE':               get_option('b_pie')}
> >  summary_info +=3D {'vde support':
config_host.has_key('CONFIG_VDE')}
> >  summary_info +=3D {'netmap support':
 config_host.has_key('CONFIG_NETMAP')}
> > diff --git a/meson_options.txt b/meson_options.txt
> > index e6cb1e589b..0e3fa7136b 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -1,8 +1,11 @@
> >  option('qemu_suffix', type : 'string', value: 'qemu',
> >         description: 'Suffix for QEMU data/modules/config directories
(can be empty)')
> > +option('docs', type : 'feature', value : 'auto',
> > +       description: 'Documentations build support')
> >  option('docdir', type : 'string', value : 'doc',
> >         description: 'Base directory for documentation installation
(can be empty)')
> > -
> > +option('sphinx_build', type : 'string', value : '',
> > +       description: 'Use specified sphinx-build [$sphinx_build] for
building document (default to be empty)')
> >  option('gettext', type : 'boolean', value : true,
> >         description: 'Localization of the GTK+ user interface')
> >  option('sparse', type : 'feature', value : 'auto',
> > diff --git a/tests/qapi-schema/meson.build
b/tests/qapi-schema/meson.build
> > index 1f222a7a13..961b8367a9 100644
> > --- a/tests/qapi-schema/meson.build
> > +++ b/tests/qapi-schema/meson.build
> > @@ -237,7 +237,7 @@ qapi_doc_out =3D custom_target('QAPI rST doc',
> >                               # we want it to always really run the
QAPI doc
> >                               # generation code. It also means we don't
> >                               # clutter up the build dir with the cache=
.
> > -                             command: [SPHINX_ARGS,
> > +                             command:  SPHINX_ARGS + [
> >                                         '-b', 'text', '-E',
> >                                         '-c', meson.source_root() /
'docs',
> >                                         '-D', 'master_doc=3Ddoc-good',
> >
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000001d61de05b1c50bfe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Oct 16, 2020 at 3:46 PM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; Here is a better way to write the meson test:<br>&gt;<br>&gt=
; if get_option(&#39;sphinx_build&#39;) =3D=3D &#39;&#39;<br>&gt; =C2=A0 sp=
hinx_build =3D find_program([&#39;sphinx-build-3&#39;, &#39;sphinx-build&#3=
9;],<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required: get_option(&#39;docs&#=
39;))<br>&gt; else<br>&gt; =C2=A0 sphinx_build =3D find_program(get_option(=
&#39;sphinx_build&#39;),<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required: ge=
t_option(&#39;docs&#39;))<br>&gt; endif<br>&gt;<br>&gt; SPHINX_ARGS =3D [sp=
hinx_build]<br>&gt; # If we&#39;re making warnings fatal, apply this to Sph=
inx runs as well<br>&gt; if get_option(&#39;werror&#39;)<br>&gt; =C2=A0 SPH=
INX_TEST_ARGS +=3D [ &#39;-W&#39; ]<br>&gt; endif<br>&gt;<br>&gt; # Check i=
f tools are available to build documentation.<br>&gt; build_docs =3D false<=
br>&gt; if sphinx_build.found()<br>&gt; =C2=A0 # This is a bit awkward but =
works: create a trivial document and<br>&gt; =C2=A0 # try to run it with ou=
r configuration file (which enforces a<br>&gt; =C2=A0 # version requirement=
). This will fail if sphinx-build is too old.<br>&gt; =C2=A0 run_command(&#=
39;mkdir&#39;, [&#39;-p&#39;, tmpdir / &#39;sphinx&#39;])<br>&gt; =C2=A0 ru=
n_command(&#39;touch&#39;, [tmpdir / &#39;sphinx/index.rst&#39;])<br>&gt; =
=C2=A0 sphinx_build_test_out =3D run_command(SPHINX_ARGS + [<br>&gt; =C2=A0=
 =C2=A0 &#39;-c&#39;, meson.current_source_dir() / &#39;docs&#39;,<br>&gt; =
=C2=A0 =C2=A0 &#39;-b&#39;, &#39;html&#39;, tmpdir / &#39;sphinx&#39;,<br>&=
gt; =C2=A0 =C2=A0 tmpdir / &#39;sphinx/out&#39;])<br>&gt; =C2=A0 build_docs=
 =3D (sphinx_build_test_out.returncode() =3D=3D 0)<br>&gt; endif<br>There i=
s subtle error here, when =C2=A0sphinx_build not found, there is=20

SPHINX_ARGS=C2=A0 should be [],<div>otherwise, latter place using=C2=A0

SPHINX_ARGS=C2=A0 have not found sphinx_build will cause error by meson</di=
v><div>..</div><div>I&#39;ll add</div><div><br></div><div>else</div><div>=
=C2=A0 SPHINX_ARGS=C2=A0 =3D []=C2=A0=C2=A0<br></div><div>endif</div><div><=
br>&gt;<br>&gt; if not build_docs<br>&gt; =C2=A0 if sphinx_build_option !=
=3D &#39;&#39;<br>&gt; =C2=A0 =C2=A0 warning(&#39;@0@ exists but it is eith=
er too old or uses too old a Python version&#39;.format(sphinx_build_option=
))<br>&gt; =C2=A0 endif<br>&gt; =C2=A0 if get_option(&#39;docs&#39;).enable=
d()<br>&gt; =C2=A0 =C2=A0 error(&#39;Install a Python 3 version of python-s=
phinx&#39;)<br>&gt; =C2=A0 endif<br>&gt; endif<br>&gt;<br>&gt;<br>&gt;<br>&=
gt; On 16/10/20 00:06, Yonggang Luo wrote:<br>&gt; &gt; Signed-off-by: Yong=
gang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com=
</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0configure =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 59 +++-----------------=
--------------<br>&gt; &gt; =C2=A0docs/meson.build =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A04 +--<br>&gt; &gt; =C2=A0meson.build =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 60 +++++++++++++=
++++++++++++++++++----<br>&gt; &gt; =C2=A0meson_options.txt =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A05 ++-<br>&gt; &gt; =C2=A0tests/qapi-sch=
ema/meson.build | =C2=A02 +-<br>&gt; &gt; =C2=A05 files changed, 64 inserti=
ons(+), 66 deletions(-)<br>&gt; &gt;<br>&gt; &gt; diff --git a/configure b/=
configure<br>&gt; &gt; index 1ce31f97b4..ff593a8542 100755<br>&gt; &gt; ---=
 a/configure<br>&gt; &gt; +++ b/configure<br>&gt; &gt; @@ -297,7 +297,7 @@ =
brlapi=3D&quot;&quot;<br>&gt; &gt; =C2=A0curl=3D&quot;&quot;<br>&gt; &gt; =
=C2=A0iconv=3D&quot;auto&quot;<br>&gt; &gt; =C2=A0curses=3D&quot;auto&quot;=
<br>&gt; &gt; -docs=3D&quot;&quot;<br>&gt; &gt; +docs=3D&quot;auto&quot;<br=
>&gt; &gt; =C2=A0fdt=3D&quot;auto&quot;<br>&gt; &gt; =C2=A0netmap=3D&quot;n=
o&quot;<br>&gt; &gt; =C2=A0sdl=3D&quot;auto&quot;<br>&gt; &gt; @@ -822,15 +=
822,6 @@ do<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0fi<br>&gt; &gt; =C2=A0done<br>=
&gt; &gt;<br>&gt; &gt; -sphinx_build=3D<br>&gt; &gt; -for binary in sphinx-=
build-3 sphinx-build<br>&gt; &gt; -do<br>&gt; &gt; - =C2=A0 =C2=A0if has &q=
uot;$binary&quot;<br>&gt; &gt; - =C2=A0 =C2=A0then<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sphinx_build=3D$(command -v &quot;$binary&quot;)<br>&gt=
; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0break<br>&gt; &gt; - =C2=A0 =C2=A0fi<br=
>&gt; &gt; -done<br>&gt; &gt;<br>&gt; &gt; =C2=A0# Check for ancillary tool=
s used in testing<br>&gt; &gt; =C2=A0genisoimage=3D<br>&gt; &gt; @@ -1226,9=
 +1217,9 @@ for opt do<br>&gt; &gt; =C2=A0 =C2=A0;;<br>&gt; &gt; =C2=A0 =C2=
=A0--disable-crypto-afalg) crypto_afalg=3D&quot;no&quot;<br>&gt; &gt; =C2=
=A0 =C2=A0;;<br>&gt; &gt; - =C2=A0--disable-docs) docs=3D&quot;no&quot;<br>=
&gt; &gt; + =C2=A0--disable-docs) docs=3D&quot;disabled&quot;<br>&gt; &gt; =
=C2=A0 =C2=A0;;<br>&gt; &gt; - =C2=A0--enable-docs) docs=3D&quot;yes&quot;<=
br>&gt; &gt; + =C2=A0--enable-docs) docs=3D&quot;enabled&quot;<br>&gt; &gt;=
 =C2=A0 =C2=A0;;<br>&gt; &gt; =C2=A0 =C2=A0--disable-vhost-net) vhost_net=
=3D&quot;no&quot;<br>&gt; &gt; =C2=A0 =C2=A0;;<br>&gt; &gt; @@ -4413,45 +44=
04,6 @@ if check_include linux/btrfs.h ; then<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0btrfs=3Dyes<br>&gt; &gt; =C2=A0fi<br>&gt; &gt;<br>&gt; &gt; -# If we&=
#39;re making warnings fatal, apply this to Sphinx runs as well<br>&gt; &gt=
; -sphinx_werror=3D&quot;&quot;<br>&gt; &gt; -if test &quot;$werror&quot; =
=3D &quot;yes&quot;; then<br>&gt; &gt; - =C2=A0 =C2=A0sphinx_werror=3D&quot=
;-W&quot;<br>&gt; &gt; -fi<br>&gt; &gt; -<br>&gt; &gt; -# Check we have a n=
ew enough version of sphinx-build<br>&gt; &gt; -has_sphinx_build() {<br>&gt=
; &gt; - =C2=A0 =C2=A0# This is a bit awkward but works: create a trivial d=
ocument and<br>&gt; &gt; - =C2=A0 =C2=A0# try to run it with our configurat=
ion file (which enforces a<br>&gt; &gt; - =C2=A0 =C2=A0# version requiremen=
t). This will fail if either<br>&gt; &gt; - =C2=A0 =C2=A0# sphinx-build doe=
sn&#39;t exist at all or if it is too old.<br>&gt; &gt; - =C2=A0 =C2=A0mkdi=
r -p &quot;$TMPDIR1/sphinx&quot;<br>&gt; &gt; - =C2=A0 =C2=A0touch &quot;$T=
MPDIR1/sphinx/index.rst&quot;<br>&gt; &gt; - =C2=A0 =C2=A0&quot;$sphinx_bui=
ld&quot; $sphinx_werror -c &quot;$source_path/docs&quot; \<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-b htm=
l &quot;$TMPDIR1/sphinx&quot; \<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;$TMPDIR1/sphinx/out&quot; =
=C2=A0&gt;&gt; config.log 2&gt;&amp;1<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt=
; &gt; -# Check if tools are available to build documentation.<br>&gt; &gt;=
 -if test &quot;$docs&quot; !=3D &quot;no&quot; ; then<br>&gt; &gt; - =C2=
=A0if has_sphinx_build; then<br>&gt; &gt; - =C2=A0 =C2=A0sphinx_ok=3Dyes<br=
>&gt; &gt; - =C2=A0else<br>&gt; &gt; - =C2=A0 =C2=A0sphinx_ok=3Dno<br>&gt; =
&gt; - =C2=A0fi<br>&gt; &gt; - =C2=A0if test &quot;$sphinx_ok&quot; =3D &qu=
ot;yes&quot;; then<br>&gt; &gt; - =C2=A0 =C2=A0docs=3Dyes<br>&gt; &gt; - =
=C2=A0else<br>&gt; &gt; - =C2=A0 =C2=A0if test &quot;$docs&quot; =3D &quot;=
yes&quot; ; then<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0if has $sphinx_build &a=
mp;&amp; test &quot;$sphinx_ok&quot; !=3D &quot;yes&quot;; then<br>&gt; &gt=
; - =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Warning: $sphinx_build exists but=
 it is either too old or uses too old a Python version&quot; &gt;&amp;2<br>=
&gt; &gt; - =C2=A0 =C2=A0 =C2=A0fi<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0featu=
re_not_found &quot;docs&quot; &quot;Install a Python 3 version of python-sp=
hinx&quot;<br>&gt; &gt; - =C2=A0 =C2=A0fi<br>&gt; &gt; - =C2=A0 =C2=A0docs=
=3Dno<br>&gt; &gt; - =C2=A0fi<br>&gt; &gt; -fi<br>&gt; &gt; -<br>&gt; &gt; =
=C2=A0# Search for bswap_32 function<br>&gt; &gt; =C2=A0byteswap_h=3Dno<br>=
&gt; &gt; =C2=A0cat &gt; $TMPC &lt;&lt; EOF<br>&gt; &gt; @@ -6087,9 +6039,6=
 @@ qemu_version=3D$(head $source_path/VERSION)<br>&gt; &gt; =C2=A0echo &qu=
ot;PKGVERSION=3D$pkgversion&quot; &gt;&gt;$config_host_mak<br>&gt; &gt; =C2=
=A0echo &quot;SRC_PATH=3D$source_path&quot; &gt;&gt; $config_host_mak<br>&g=
t; &gt; =C2=A0echo &quot;TARGET_DIRS=3D$target_list&quot; &gt;&gt; $config_=
host_mak<br>&gt; &gt; -if [ &quot;$docs&quot; =3D &quot;yes&quot; ] ; then<=
br>&gt; &gt; - =C2=A0echo &quot;BUILD_DOCS=3Dyes&quot; &gt;&gt; $config_hos=
t_mak<br>&gt; &gt; -fi<br>&gt; &gt; =C2=A0if test &quot;$modules&quot; =3D =
&quot;yes&quot;; then<br>&gt; &gt; =C2=A0 =C2=A0# $shacmd can generate a ha=
sh started with digit, which the compiler doesn&#39;t<br>&gt; &gt; =C2=A0 =
=C2=A0# like as an symbol. So prefix it with an underscore<br>&gt; &gt; @@ =
-6794,7 +6743,6 @@ fi<br>&gt; &gt; =C2=A0echo &quot;ROMS=3D$roms&quot; &gt;=
&gt; $config_host_mak<br>&gt; &gt; =C2=A0echo &quot;MAKE=3D$make&quot; &gt;=
&gt; $config_host_mak<br>&gt; &gt; =C2=A0echo &quot;PYTHON=3D$python&quot; =
&gt;&gt; $config_host_mak<br>&gt; &gt; -echo &quot;SPHINX_BUILD=3D$sphinx_b=
uild&quot; &gt;&gt; $config_host_mak<br>&gt; &gt; =C2=A0echo &quot;GENISOIM=
AGE=3D$genisoimage&quot; &gt;&gt; $config_host_mak<br>&gt; &gt; =C2=A0echo =
&quot;MESON=3D$meson&quot; &gt;&gt; $config_host_mak<br>&gt; &gt; =C2=A0ech=
o &quot;CC=3D$cc&quot; &gt;&gt; $config_host_mak<br>&gt; &gt; @@ -7076,6 +7=
024,7 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommo=
n -Du2f=3D$u2f \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Dcapstone=
=3D$capstone -Dslirp=3D$slirp -Dfdt=3D$fdt \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0-Diconv=3D$iconv -Dcurses=3D$curses \<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0-Ddocs=3D$docs -Dsphinx_build=3D$sphinx_build \<br>=
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$cross_arg \<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;$PWD&quot; &quot;$source_path&quot;<br=
>&gt; &gt;<br>&gt; &gt; diff --git a/docs/meson.build b/docs/meson.build<br=
>&gt; &gt; index 0340d489ac..f566809a6a 100644<br>&gt; &gt; --- a/docs/meso=
n.build<br>&gt; &gt; +++ b/docs/meson.build<br>&gt; &gt; @@ -37,7 +37,7 @@ =
if build_docs<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0input: [files(&#39;conf.py&#39;), files(manual / &#39;conf.py=
&#39;)],<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0depfile: manual + &#39;.d&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0depend_files: sphinx_extn_depends=
,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0com=
mand: [SPHINX_ARGS, &#39;-Ddepfile=3D@DEPFILE@&#39;,<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command: SPHINX_ARGS + [&#3=
9;-Ddepfile=3D@DEPFILE@&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-Dde=
pfile_stamp=3D@OUTPUT0@&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-b&#=
39;, &#39;html&#39;, &#39;-d&#39;, private_dir,<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0input_dir, output_dir])<br>&gt; &gt; @@ -59,7 +59,7 @@ if build_d=
ocs<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input: this_manual,<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 install: build_docs,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 install_dir:=
 install_dirs,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [SPHINX_ARGS, &#39;-b&#39;,=
 &#39;man&#39;, &#39;-d&#39;, private_dir,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command:=
 SPHINX_ARGS + [&#39;-b&#39;, &#39;man&#39;, &#39;-d&#39;, private_dir,<br>=
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_dir, m=
eson.current_build_dir()])<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0endif<br>&gt; &=
gt; =C2=A0 =C2=A0endforeach<br>&gt; &gt; diff --git a/meson.build b/meson.b=
uild<br>&gt; &gt; index 8156df8b71..8940468208 100644<br>&gt; &gt; --- a/me=
son.build<br>&gt; &gt; +++ b/meson.build<br>&gt; &gt; @@ -17,7 +17,13 @@ cc=
 =3D meson.get_compiler(&#39;c&#39;)<br>&gt; &gt; =C2=A0config_host =3D key=
val.load(meson.current_build_dir() / &#39;config-host.mak&#39;)<br>&gt; &gt=
; =C2=A0enable_modules =3D &#39;CONFIG_MODULES&#39; in config_host<br>&gt; =
&gt; =C2=A0enable_static =3D &#39;CONFIG_STATIC&#39; in config_host<br>&gt;=
 &gt; -build_docs =3D &#39;BUILD_DOCS&#39; in config_host<br>&gt; &gt; +<br=
>&gt; &gt; +# Temporary directory used for files created while<br>&gt; &gt;=
 +# configure runs. Since it is in the build directory<br>&gt; &gt; +# we c=
an safely blow away any previous version of it<br>&gt; &gt; +# (and we need=
 not jump through hoops to try to delete<br>&gt; &gt; +# it when configure =
exits.)<br>&gt; &gt; +tmpdir =3D meson.current_build_dir() / &#39;config-te=
mp&#39;<br>&gt; &gt;<br>&gt; &gt; =C2=A0if get_option(&#39;qemu_suffix&#39;=
).startswith(&#39;/&#39;)<br>&gt; &gt; =C2=A0 =C2=A0error(&#39;qemu_suffix =
cannot start with a /&#39;)<br>&gt; &gt; @@ -1235,12 +1241,52 @@ foreach d =
: hx_headers<br>&gt; &gt; =C2=A0endforeach<br>&gt; &gt; =C2=A0genh +=3D hxd=
ep<br>&gt; &gt;<br>&gt; &gt; -SPHINX_ARGS =3D [config_host[&#39;SPHINX_BUIL=
D&#39;],<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#=
39;-Dversion=3D&#39; + meson.project_version(),<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Drelease=3D&#39; + config_host=
[&#39;PKGVERSION&#39;]]<br>&gt; &gt; +sphinx_build =3D not_found<br>&gt; &g=
t; +sphinx_build_option =3D get_option(&#39;sphinx_build&#39;)<br>&gt; &gt;=
 +if sphinx_build_option =3D=3D &#39;&#39;<br>&gt; &gt; + =C2=A0sphinx_buil=
d =3D find_program(&#39;sphinx-build&#39;, required: false)<br>&gt; &gt; +e=
lse<br>&gt; &gt; + =C2=A0sphinx_build =3D find_program(sphinx_build_option,=
 required: false)<br>&gt; &gt; +endif<br>&gt; &gt;<br>&gt; &gt; +SPHINX_TES=
T_ARGS =3D []<br>&gt; &gt; +# If we&#39;re making warnings fatal, apply thi=
s to Sphinx runs as well<br>&gt; &gt; =C2=A0if get_option(&#39;werror&#39;)=
<br>&gt; &gt; - =C2=A0SPHINX_ARGS +=3D [ &#39;-W&#39; ]<br>&gt; &gt; + =C2=
=A0SPHINX_TEST_ARGS +=3D [ &#39;-W&#39; ]<br>&gt; &gt; +endif<br>&gt; &gt; =
+<br>&gt; &gt; +build_docs =3D false<br>&gt; &gt; +docs_option =3D get_opti=
on(&#39;docs&#39;)<br>&gt; &gt; +# Check if tools are available to build do=
cumentation.<br>&gt; &gt; +if sphinx_build.found() and not docs_option.disa=
bled()<br>&gt; &gt; + =C2=A0 =C2=A0# This is a bit awkward but works: creat=
e a trivial document and<br>&gt; &gt; + =C2=A0 =C2=A0# try to run it with o=
ur configuration file (which enforces a<br>&gt; &gt; + =C2=A0 =C2=A0# versi=
on requirement). This will fail if either<br>&gt; &gt; + =C2=A0 =C2=A0# sph=
inx-build doesn&#39;t exist at all or if it is too old.<br>&gt; &gt; + =C2=
=A0 =C2=A0run_command(&#39;mkdir&#39;, [&#39;-p&#39;, tmpdir / &#39;sphinx&=
#39;])<br>&gt; &gt; + =C2=A0 =C2=A0run_command(&#39;touch&#39;, [tmpdir / &=
#39;sphinx/index.rst&#39;])<br>&gt; &gt; + =C2=A0 =C2=A0sphinx_build_test_o=
ut =3D run_command(sphinx_build, SPHINX_TEST_ARGS + [<br>&gt; &gt; + =C2=A0=
 =C2=A0 =C2=A0&#39;-c&#39;, meson.current_source_dir() / &#39;docs&#39;,<br=
>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0&#39;-b&#39;, &#39;html&#39;, tmpdir / &#3=
9;sphinx&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0tmpdir / &#39;sphinx/out&=
#39;])<br>&gt; &gt; + =C2=A0 =C2=A0if sphinx_build_test_out.returncode() =
=3D=3D 0<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0build_docs =3D true<br>&gt; &gt=
; + =C2=A0 =C2=A0else<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0if docs_option.ena=
bled()<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if sphinx_build_option !=
=3D &#39;&#39;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0warning(&#3=
9;Warning: @0@ exists but it is either too old or uses too old a Python ver=
sion&#39;.format(sphinx_build_option))<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0endif<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0error(&#39;Warning: I=
nstall a Python 3 version of python-sphinx&#39;)<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0endif<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0# do not building docs<b=
r>&gt; &gt; + =C2=A0 =C2=A0endif<br>&gt; &gt; +endif<br>&gt; &gt; +<br>&gt;=
 &gt; +SPHINX_ARGS =3D []<br>&gt; &gt; +if build_docs<br>&gt; &gt; + =C2=A0=
SPHINX_ARGS =3D [sphinx_build]<br>&gt; &gt; + =C2=A0SPHINX_ARGS +=3D SPHINX=
_TEST_ARGS<br>&gt; &gt; + =C2=A0SPHINX_ARGS +=3D [&#39;-Dversion=3D&#39; + =
meson.project_version(), &#39;-Drelease=3D&#39; + config_host[&#39;PKGVERSI=
ON&#39;]]<br>&gt; &gt; =C2=A0endif<br>&gt; &gt;<br>&gt; &gt; =C2=A0sphinx_e=
xtn_depends =3D [ meson.source_root() / &#39;docs/sphinx/depfile.py&#39;,<b=
r>&gt; &gt; @@ -1918,7 +1964,7 @@ summary_info +=3D {&#39;QEMU_CFLAGS&#39;:=
 =C2=A0 =C2=A0 =C2=A0 config_host[&#39;QEMU_CFLAGS&#39;]}<br>&gt; &gt; =C2=
=A0summary_info +=3D {&#39;QEMU_LDFLAGS&#39;: =C2=A0 =C2=A0 =C2=A0config_ho=
st[&#39;QEMU_LDFLAGS&#39;]}<br>&gt; &gt; =C2=A0summary_info +=3D {&#39;make=
&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_host[&#39;MAK=
E&#39;]}<br>&gt; &gt; =C2=A0summary_info +=3D {&#39;python&#39;: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;@0@ (version: @1@)&#39;.format(python.f=
ull_path(), python.language_version())}<br>&gt; &gt; -summary_info +=3D {&#=
39;sphinx-build&#39;: =C2=A0 =C2=A0 =C2=A0config_host[&#39;SPHINX_BUILD&#39=
;]}<br>&gt; &gt; +summary_info +=3D {&#39;sphinx-build&#39;: =C2=A0 =C2=A0 =
=C2=A0sphinx_build.found()}<br>&gt; &gt; =C2=A0summary_info +=3D {&#39;geni=
soimage&#39;: =C2=A0 =C2=A0 =C2=A0 config_host[&#39;GENISOIMAGE&#39;]}<br>&=
gt; &gt; =C2=A0# TODO: add back version<br>&gt; &gt; =C2=A0summary_info +=
=3D {&#39;slirp support&#39;: =C2=A0 =C2=A0 slirp_opt =3D=3D &#39;disabled&=
#39; ? false : slirp_opt}<br>&gt; &gt; @@ -1986,7 +2032,7 @@ if config_host=
.has_key(&#39;CONFIG_XEN_BACKEND&#39;)<br>&gt; &gt; =C2=A0 =C2=A0summary_in=
fo +=3D {&#39;xen ctrl version&#39;: =C2=A0config_host[&#39;CONFIG_XEN_CTRL=
_INTERFACE_VERSION&#39;]}<br>&gt; &gt; =C2=A0endif<br>&gt; &gt; =C2=A0summa=
ry_info +=3D {&#39;brlapi support&#39;: =C2=A0 =C2=A0config_host.has_key(&#=
39;CONFIG_BRLAPI&#39;)}<br>&gt; &gt; -summary_info +=3D {&#39;Documentation=
&#39;: =C2=A0 =C2=A0 config_host.has_key(&#39;BUILD_DOCS&#39;)}<br>&gt; &gt=
; +summary_info +=3D {&#39;Documentation&#39;: =C2=A0 =C2=A0 build_docs}<br=
>&gt; &gt; =C2=A0summary_info +=3D {&#39;PIE&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 get_option(&#39;b_pie&#39;)}<br>&gt; &gt; =C2=A0su=
mmary_info +=3D {&#39;vde support&#39;: =C2=A0 =C2=A0 =C2=A0 config_host.ha=
s_key(&#39;CONFIG_VDE&#39;)}<br>&gt; &gt; =C2=A0summary_info +=3D {&#39;net=
map support&#39;: =C2=A0 =C2=A0config_host.has_key(&#39;CONFIG_NETMAP&#39;)=
}<br>&gt; &gt; diff --git a/meson_options.txt b/meson_options.txt<br>&gt; &=
gt; index e6cb1e589b..0e3fa7136b 100644<br>&gt; &gt; --- a/meson_options.tx=
t<br>&gt; &gt; +++ b/meson_options.txt<br>&gt; &gt; @@ -1,8 +1,11 @@<br>&gt=
; &gt; =C2=A0option(&#39;qemu_suffix&#39;, type : &#39;string&#39;, value: =
&#39;qemu&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;=
Suffix for QEMU data/modules/config directories (can be empty)&#39;)<br>&gt=
; &gt; +option(&#39;docs&#39;, type : &#39;feature&#39;, value : &#39;auto&=
#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 description: &#39;Documentations =
build support&#39;)<br>&gt; &gt; =C2=A0option(&#39;docdir&#39;, type : &#39=
;string&#39;, value : &#39;doc&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 description: &#39;Base directory for documentation installation (can be=
 empty)&#39;)<br>&gt; &gt; -<br>&gt; &gt; +option(&#39;sphinx_build&#39;, t=
ype : &#39;string&#39;, value : &#39;&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 description: &#39;Use specified sphinx-build [$sphinx_build] for bui=
lding document (default to be empty)&#39;)<br>&gt; &gt; =C2=A0option(&#39;g=
ettext&#39;, type : &#39;boolean&#39;, value : true,<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 description: &#39;Localization of the GTK+ user interf=
ace&#39;)<br>&gt; &gt; =C2=A0option(&#39;sparse&#39;, type : &#39;feature&#=
39;, value : &#39;auto&#39;,<br>&gt; &gt; diff --git a/tests/qapi-schema/me=
son.build b/tests/qapi-schema/meson.build<br>&gt; &gt; index 1f222a7a13..96=
1b8367a9 100644<br>&gt; &gt; --- a/tests/qapi-schema/meson.build<br>&gt; &g=
t; +++ b/tests/qapi-schema/meson.build<br>&gt; &gt; @@ -237,7 +237,7 @@ qap=
i_doc_out =3D custom_target(&#39;QAPI rST doc&#39;,<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 # we want it to always really run the QAPI doc<br>&gt;=
 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # generation code. It also means we don=
&#39;t<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # clutter up the build di=
r with the cache.<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [SPHINX_AR=
GS,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: =C2=A0SPHINX_ARGS + [<br=
>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;-b&#39;, &#39;text&#39;, &#39;-E&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-c&#39;, meson.so=
urce_root() / &#39;docs&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-D&#39;, &#39;master_doc=3Ddoc-good=
&#39;,<br>&gt; &gt;<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>You=
rs<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000001d61de05b1c50bfe--

