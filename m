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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AFEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E0920848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHLRuZKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E0920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTPmP-0005Gw-GD
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 09:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTPlm-0004fo-Ql
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:27:42 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e]:36707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTPli-0008OQ-Ug
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:27:42 -0400
Received: by mail-lf1-x12e.google.com with SMTP id h6so2911401lfj.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=HeJh2RhhX20vlN4E7cVoclheUKfsPczq13srP2QxPKU=;
 b=OHLRuZKqgBs0hH0pwG1bGiqWCv660rctHJzUfHAnf0AO3uMHSar24UusjLTWvVp/17
 w0Ay83OQXbF13QskH0lxTt5mSxLWhC5kwhcWtyJzzRBXMYv1YH4hgcNCWjtTgZw/teTF
 B//J8l2OGU/fLVostOBIjjiAdc9GtWCltLsoIdeyc6qV4ZyM+6iCnqGggOiJooDh1Wqj
 IQpXzF0Cxn5tpb1/JNCj8ejnEyb5j5r2QCRVqpTqjQvjEIYZrYwbb0FL44M9kKY4P+i+
 JbhWaJaE93V/YC6cO5mrhtuzxZcjY20WpaUwSm/mWo/55FGrIoYcLltc0W0stxfbRLHF
 lMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=HeJh2RhhX20vlN4E7cVoclheUKfsPczq13srP2QxPKU=;
 b=mLwE51/8DwY680Mzyo0l7D/EgpQ+5R7VqoLjxK8v9qc4SdvM1+bwqeiJpDrLIvhy28
 cvUF+hTlqXYenaAW0FQMoUcJhGWRXz4W34MdSL3m5nw7/qFNdS7dQBNlNpe+uwUXWBDd
 9AzaBdjZf19wk53Zn6pQkpIjFYvaq3mUgPpFmlk5Wy7RcEOw6qlURB2Z4Ztgk2+YcfQ0
 OawXnVU66UQXs024UWGzh9HHqga7QcabAZZ+a1/0VXFNWys141+unOcVjFvJx48Px39n
 StwptbusaMmnPvSrRGe1Le1x2P1PMXQy4JoPy3N3hB+8tdgN7KeNi776jwUz6+9FKPtr
 18Gg==
X-Gm-Message-State: AOAM530vQmUYj6cJzjQcGIlnq3bCHZjnn3SNrAKCFB2oTBFhhqOsJBcL
 chF+1a9ihIWdsD5aeonNPet9WUFb7JA+ziB9YC4=
X-Google-Smtp-Source: ABdhPJwJeuRvGQ5cXgWqkP+QHuOrbyfRJ31HK9cpJL2eLwaryzctCUWVEJ2UfKNB9cPIli2bAY+TmMDwjuuMP1pPkZc=
X-Received: by 2002:a19:f819:: with SMTP id a25mr1258197lff.382.1602854857238; 
 Fri, 16 Oct 2020 06:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201016114814.1564523-1-pbonzini@redhat.com>
 <20201016114814.1564523-19-pbonzini@redhat.com>
In-Reply-To: <20201016114814.1564523-19-pbonzini@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 16 Oct 2020 21:27:25 +0800
Message-ID: <CAE2XoE8cF3Bse9AE3zb9GGqmygqDx1=zxXHF6OE9an_ridWVsw@mail.gmail.com>
Subject: Re: [PULL 18/22] meson: Move the detection logic for sphinx to meson
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000646d0605b1c9ba36"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12e.google.com
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

--000000000000646d0605b1c9ba36
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 7:48 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Yonggang Luo <luoyonggang@gmail.com>
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Message-Id: <20201015220626.418-4-luoyonggang@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure         | 59 ++++-------------------------------------------
>  docs/meson.build  | 46 ++++++++++++++++++++++++++++++++++++
>  meson.build       | 30 ++++++++----------------
>  meson_options.txt |  4 ++++
>  4 files changed, 64 insertions(+), 75 deletions(-)
>
> diff --git a/configure b/configure
> index 3edbdd2a24..68f097861d 100755
> --- a/configure
> +++ b/configure
> @@ -297,7 +297,7 @@ brlapi=3D""
>  curl=3D""
>  iconv=3D"auto"
>  curses=3D"auto"
> -docs=3D""
> +docs=3D"auto"
>  fdt=3D"auto"
>  netmap=3D"no"
>  sdl=3D"auto"
> @@ -820,15 +820,6 @@ do
>      fi
>  done
>
> -sphinx_build=3D
> -for binary in sphinx-build-3 sphinx-build
> -do
> -    if has "$binary"
> -    then
> -        sphinx_build=3D$(command -v "$binary")
> -        break
> -    fi
> -done
>
>  # Check for ancillary tools used in testing
>  genisoimage=3D
> @@ -1228,9 +1219,9 @@ for opt do
>    ;;
>    --disable-crypto-afalg) crypto_afalg=3D"no"
>    ;;
> -  --disable-docs) docs=3D"no"
> +  --disable-docs) docs=3D"disabled"
>    ;;
> -  --enable-docs) docs=3D"yes"
> +  --enable-docs) docs=3D"enabled"
>    ;;
>    --disable-vhost-net) vhost_net=3D"no"
>    ;;
> @@ -4419,45 +4410,6 @@ if check_include linux/btrfs.h ; then
>      btrfs=3Dyes
>  fi
>
> -# If we're making warnings fatal, apply this to Sphinx runs as well
> -sphinx_werror=3D""
> -if test "$werror" =3D "yes"; then
> -    sphinx_werror=3D"-W"
> -fi
> -
> -# Check we have a new enough version of sphinx-build
> -has_sphinx_build() {
> -    # This is a bit awkward but works: create a trivial document and
> -    # try to run it with our configuration file (which enforces a
> -    # version requirement). This will fail if either
> -    # sphinx-build doesn't exist at all or if it is too old.
> -    mkdir -p "$TMPDIR1/sphinx"
> -    touch "$TMPDIR1/sphinx/index.rst"
> -    "$sphinx_build" $sphinx_werror -c "$source_path/docs" \
> -                    -b html "$TMPDIR1/sphinx" \
> -                    "$TMPDIR1/sphinx/out"  >> config.log 2>&1
> -}
> -
> -# Check if tools are available to build documentation.
> -if test "$docs" !=3D "no" ; then
> -  if has_sphinx_build; then
> -    sphinx_ok=3Dyes
> -  else
> -    sphinx_ok=3Dno
> -  fi
> -  if test "$sphinx_ok" =3D "yes"; then
> -    docs=3Dyes
> -  else
> -    if test "$docs" =3D "yes" ; then
> -      if has $sphinx_build && test "$sphinx_ok" !=3D "yes"; then
> -        echo "Warning: $sphinx_build exists but it is either too old or
uses too old a Python version" >&2
> -      fi
> -      feature_not_found "docs" "Install a Python 3 version of
python-sphinx"
> -    fi
> -    docs=3Dno
> -  fi
> -fi
> -
>  # Search for bswap_32 function
>  byteswap_h=3Dno
>  cat > $TMPC << EOF
> @@ -6093,9 +6045,6 @@ qemu_version=3D$(head $source_path/VERSION)
>  echo "PKGVERSION=3D$pkgversion" >>$config_host_mak
>  echo "SRC_PATH=3D$source_path" >> $config_host_mak
>  echo "TARGET_DIRS=3D$target_list" >> $config_host_mak
> -if [ "$docs" =3D "yes" ] ; then
> -  echo "BUILD_DOCS=3Dyes" >> $config_host_mak
> -fi
>  if test "$modules" =3D "yes"; then
>    # $shacmd can generate a hash started with digit, which the compiler
doesn't
>    # like as an symbol. So prefix it with an underscore
> @@ -6784,7 +6733,6 @@ fi
>  echo "ROMS=3D$roms" >> $config_host_mak
>  echo "MAKE=3D$make" >> $config_host_mak
>  echo "PYTHON=3D$python" >> $config_host_mak
> -echo "SPHINX_BUILD=3D$sphinx_build" >> $config_host_mak
>  echo "GENISOIMAGE=3D$genisoimage" >> $config_host_mak
>  echo "MESON=3D$meson" >> $config_host_mak
>  echo "NINJA=3D$ninja" >> $config_host_mak
> @@ -7066,6 +7014,7 @@ NINJA=3D$ninja $meson setup \
>          -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \
>          -Dcapstone=3D$capstone -Dslirp=3D$slirp -Dfdt=3D$fdt \
>          -Diconv=3D$iconv -Dcurses=3D$curses -Dlibudev=3D$libudev\
> +        -Ddocs=3D$docs -Dsphinx_build=3D$sphinx_build \
>          $cross_arg \
>          "$PWD" "$source_path"
>
> diff --git a/docs/meson.build b/docs/meson.build
> index 0340d489ac..789dca8cc0 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -1,4 +1,50 @@

> +if get_option('sphinx_build') =3D=3D ''
> +  sphinx_build =3D find_program(['sphinx-build-3', 'sphinx-build'],
> +                              required: get_option('docs'))
> +else
> +  sphinx_build =3D find_program(get_option('sphinx_build'),
> +                              required: get_option('docs'))
> +endif
> +
> +# Check if tools are available to build documentation.
> +build_docs =3D false
> +if sphinx_build.found()
> +  SPHINX_ARGS =3D [sphinx_build]
> +  # If we're making warnings fatal, apply this to Sphinx runs as well
> +  if get_option('werror')
> +    SPHINX_ARGS +=3D [ '-W' ]
> +  endif
> +
> +  # This is a bit awkward but works: create a trivial document and
> +  # try to run it with our configuration file (which enforces a
> +  # version requirement). This will fail if sphinx-build is too old.
> +  run_command('mkdir', ['-p', tmpdir / 'sphinx'])
> +  run_command('touch', [tmpdir / 'sphinx/index.rst'])
> +  sphinx_build_test_out =3D run_command(SPHINX_ARGS + [
> +    '-c', meson.current_source_dir(),
> +    '-b', 'html', tmpdir / 'sphinx',
> +    tmpdir / 'sphinx/out'])
> +  build_docs =3D (sphinx_build_test_out.returncode() =3D=3D 0)
> +
> +  if not build_docs
> +    warning('@0@ exists but it is either too old or uses too old a
Python version'.format(sphinx_build_option))
Here need to be get_option('sphinx_build')




> +    if get_option('docs').enabled()
> +      error('Install a Python 3 version of python-sphinx')
> +    endif
> +  endif
> +endif
> +
>  if build_docs
> +  SPHINX_ARGS +=3D ['-Dversion=3D' + meson.project_version(), '-Drelease=
=3D' +
config_host['PKGVERSION']]
> +
> +  sphinx_extn_depends =3D [ meson.source_root() / 'docs/sphinx/depfile.p=
y',
> +                          meson.source_root() / 'docs/sphinx/hxtool.py',
> +                          meson.source_root() /
'docs/sphinx/kerneldoc.py',
> +                          meson.source_root() /
'docs/sphinx/kernellog.py',
> +                          meson.source_root() / 'docs/sphinx/qapidoc.py'=
,
> +                          meson.source_root() /
'docs/sphinx/qmp_lexer.py',
> +                          qapi_gen_depends ]
> +
>    configure_file(output: 'index.html',
>                   input: files('index.html.in'),
>                   configuration: {'VERSION': meson.project_version()},
> diff --git a/meson.build b/meson.build
> index 15732f4701..05fb59a00b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -17,7 +17,13 @@ cc =3D meson.get_compiler('c')
>  config_host =3D keyval.load(meson.current_build_dir() / 'config-host.mak=
')
>  enable_modules =3D 'CONFIG_MODULES' in config_host
>  enable_static =3D 'CONFIG_STATIC' in config_host
> -build_docs =3D 'BUILD_DOCS' in config_host
> +
> +# Temporary directory used for files created while
> +# configure runs. Since it is in the build directory
> +# we can safely blow away any previous version of it
> +# (and we need not jump through hoops to try to delete
> +# it when configure exits.)
> +tmpdir =3D meson.current_build_dir() / 'meson-private/temp'
>
>  if get_option('qemu_suffix').startswith('/')
>    error('qemu_suffix cannot start with a /')
> @@ -1266,22 +1272,6 @@ foreach d : hx_headers
>  endforeach
>  genh +=3D hxdep
>
> -SPHINX_ARGS =3D [config_host['SPHINX_BUILD'],
> -               '-Dversion=3D' + meson.project_version(),
> -               '-Drelease=3D' + config_host['PKGVERSION']]
> -
> -if get_option('werror')
> -  SPHINX_ARGS +=3D [ '-W' ]
> -endif
> -
> -sphinx_extn_depends =3D [ meson.source_root() / 'docs/sphinx/depfile.py'=
,
> -                        meson.source_root() / 'docs/sphinx/hxtool.py',
> -                        meson.source_root() / 'docs/sphinx/kerneldoc.py'=
,
> -                        meson.source_root() / 'docs/sphinx/kernellog.py'=
,
> -                        meson.source_root() / 'docs/sphinx/qapidoc.py',
> -                        meson.source_root() / 'docs/sphinx/qmp_lexer.py'=
,
> -                        qapi_gen_depends ]
> -
>  ###################
>  # Collect sources #
>  ###################
> @@ -1866,8 +1856,8 @@ endif
>  subdir('scripts')
>  subdir('tools')
>  subdir('pc-bios')
> -subdir('tests')
>  subdir('docs')
> +subdir('tests')
>  if 'CONFIG_GTK' in config_host
>    subdir('po')
>  endif
> @@ -1949,7 +1939,7 @@ summary_info +=3D {'QEMU_CFLAGS':
config_host['QEMU_CFLAGS']}
>  summary_info +=3D {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
>  summary_info +=3D {'make':              config_host['MAKE']}
>  summary_info +=3D {'python':            '@0@ (version: @1@)'.format(pyth=
on.full_path(),
python.language_version())}
> -summary_info +=3D {'sphinx-build':      config_host['SPHINX_BUILD']}
> +summary_info +=3D {'sphinx-build':      sphinx_build.found()}
>  summary_info +=3D {'genisoimage':       config_host['GENISOIMAGE']}
>  # TODO: add back version
>  summary_info +=3D {'slirp support':     slirp_opt =3D=3D 'disabled' ? fa=
lse :
slirp_opt}
> @@ -2017,7 +2007,7 @@ if config_host.has_key('CONFIG_XEN_BACKEND')
>    summary_info +=3D {'xen ctrl version':
 config_host['CONFIG_XEN_CTRL_INTERFACE_VERSION']}
>  endif
>  summary_info +=3D {'brlapi support':
 config_host.has_key('CONFIG_BRLAPI')}
> -summary_info +=3D {'Documentation':     config_host.has_key('BUILD_DOCS'=
)}
> +summary_info +=3D {'Documentation':     build_docs}
>  summary_info +=3D {'PIE':               get_option('b_pie')}
>  summary_info +=3D {'vde support':       config_host.has_key('CONFIG_VDE'=
)}
>  summary_info +=3D {'netmap support':
 config_host.has_key('CONFIG_NETMAP')}
> diff --git a/meson_options.txt b/meson_options.txt
> index 77b3fabd00..967229b66e 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -2,7 +2,11 @@ option('qemu_suffix', type : 'string', value: 'qemu',
>         description: 'Suffix for QEMU data/modules/config directories
(can be empty)')
>  option('docdir', type : 'string', value : 'doc',
>         description: 'Base directory for documentation installation (can
be empty)')
> +option('sphinx_build', type : 'string', value : '',
> +       description: 'Use specified sphinx-build [$sphinx_build] for
building document (default to be empty)')
>
> +option('docs', type : 'feature', value : 'auto',
> +       description: 'Documentations build support')
>  option('gettext', type : 'boolean', value : true,
>         description: 'Localization of the GTK+ user interface')
>  option('sparse', type : 'feature', value : 'auto',
> --
> 2.26.2
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000646d0605b1c9ba36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Oct 16, 2020 at 7:48 PM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; From: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.c=
om">luoyonggang@gmail.com</a>&gt;<br>&gt;<br>&gt; Signed-off-by: Yonggang L=
uo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&g=
t;<br>&gt; Message-Id: &lt;<a href=3D"mailto:20201015220626.418-4-luoyongga=
ng@gmail.com">20201015220626.418-4-luoyonggang@gmail.com</a>&gt;<br>&gt; Si=
gned-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonz=
ini@redhat.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0configure =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 59 ++++-------------------------------------------<br>&gt; =
=C2=A0docs/meson.build =C2=A0| 46 ++++++++++++++++++++++++++++++++++++<br>&=
gt; =C2=A0meson.build =C2=A0 =C2=A0 =C2=A0 | 30 ++++++++----------------<br=
>&gt; =C2=A0meson_options.txt | =C2=A04 ++++<br>&gt; =C2=A04 files changed,=
 64 insertions(+), 75 deletions(-)<br>&gt;<br>&gt; diff --git a/configure b=
/configure<br>&gt; index 3edbdd2a24..68f097861d 100755<br>&gt; --- a/config=
ure<br>&gt; +++ b/configure<br>&gt; @@ -297,7 +297,7 @@ brlapi=3D&quot;&quo=
t;<br>&gt; =C2=A0curl=3D&quot;&quot;<br>&gt; =C2=A0iconv=3D&quot;auto&quot;=
<br>&gt; =C2=A0curses=3D&quot;auto&quot;<br>&gt; -docs=3D&quot;&quot;<br>&g=
t; +docs=3D&quot;auto&quot;<br>&gt; =C2=A0fdt=3D&quot;auto&quot;<br>&gt; =
=C2=A0netmap=3D&quot;no&quot;<br>&gt; =C2=A0sdl=3D&quot;auto&quot;<br>&gt; =
@@ -820,15 +820,6 @@ do<br>&gt; =C2=A0 =C2=A0 =C2=A0fi<br>&gt; =C2=A0done<b=
r>&gt;<br>&gt; -sphinx_build=3D<br>&gt; -for binary in sphinx-build-3 sphin=
x-build<br>&gt; -do<br>&gt; - =C2=A0 =C2=A0if has &quot;$binary&quot;<br>&g=
t; - =C2=A0 =C2=A0then<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0sphinx_build=3D=
$(command -v &quot;$binary&quot;)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0brea=
k<br>&gt; - =C2=A0 =C2=A0fi<br>&gt; -done<br>&gt;<br>&gt; =C2=A0# Check for=
 ancillary tools used in testing<br>&gt; =C2=A0genisoimage=3D<br>&gt; @@ -1=
228,9 +1219,9 @@ for opt do<br>&gt; =C2=A0 =C2=A0;;<br>&gt; =C2=A0 =C2=A0--=
disable-crypto-afalg) crypto_afalg=3D&quot;no&quot;<br>&gt; =C2=A0 =C2=A0;;=
<br>&gt; - =C2=A0--disable-docs) docs=3D&quot;no&quot;<br>&gt; + =C2=A0--di=
sable-docs) docs=3D&quot;disabled&quot;<br>&gt; =C2=A0 =C2=A0;;<br>&gt; - =
=C2=A0--enable-docs) docs=3D&quot;yes&quot;<br>&gt; + =C2=A0--enable-docs) =
docs=3D&quot;enabled&quot;<br>&gt; =C2=A0 =C2=A0;;<br>&gt; =C2=A0 =C2=A0--d=
isable-vhost-net) vhost_net=3D&quot;no&quot;<br>&gt; =C2=A0 =C2=A0;;<br>&gt=
; @@ -4419,45 +4410,6 @@ if check_include linux/btrfs.h ; then<br>&gt; =C2=
=A0 =C2=A0 =C2=A0btrfs=3Dyes<br>&gt; =C2=A0fi<br>&gt;<br>&gt; -# If we&#39;=
re making warnings fatal, apply this to Sphinx runs as well<br>&gt; -sphinx=
_werror=3D&quot;&quot;<br>&gt; -if test &quot;$werror&quot; =3D &quot;yes&q=
uot;; then<br>&gt; - =C2=A0 =C2=A0sphinx_werror=3D&quot;-W&quot;<br>&gt; -f=
i<br>&gt; -<br>&gt; -# Check we have a new enough version of sphinx-build<b=
r>&gt; -has_sphinx_build() {<br>&gt; - =C2=A0 =C2=A0# This is a bit awkward=
 but works: create a trivial document and<br>&gt; - =C2=A0 =C2=A0# try to r=
un it with our configuration file (which enforces a<br>&gt; - =C2=A0 =C2=A0=
# version requirement). This will fail if either<br>&gt; - =C2=A0 =C2=A0# s=
phinx-build doesn&#39;t exist at all or if it is too old.<br>&gt; - =C2=A0 =
=C2=A0mkdir -p &quot;$TMPDIR1/sphinx&quot;<br>&gt; - =C2=A0 =C2=A0touch &qu=
ot;$TMPDIR1/sphinx/index.rst&quot;<br>&gt; - =C2=A0 =C2=A0&quot;$sphinx_bui=
ld&quot; $sphinx_werror -c &quot;$source_path/docs&quot; \<br>&gt; - =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-b html &quo=
t;$TMPDIR1/sphinx&quot; \<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;$TMPDIR1/sphinx/out&quot; =C2=A0&gt;&g=
t; config.log 2&gt;&amp;1<br>&gt; -}<br>&gt; -<br>&gt; -# Check if tools ar=
e available to build documentation.<br>&gt; -if test &quot;$docs&quot; !=3D=
 &quot;no&quot; ; then<br>&gt; - =C2=A0if has_sphinx_build; then<br>&gt; - =
=C2=A0 =C2=A0sphinx_ok=3Dyes<br>&gt; - =C2=A0else<br>&gt; - =C2=A0 =C2=A0sp=
hinx_ok=3Dno<br>&gt; - =C2=A0fi<br>&gt; - =C2=A0if test &quot;$sphinx_ok&qu=
ot; =3D &quot;yes&quot;; then<br>&gt; - =C2=A0 =C2=A0docs=3Dyes<br>&gt; - =
=C2=A0else<br>&gt; - =C2=A0 =C2=A0if test &quot;$docs&quot; =3D &quot;yes&q=
uot; ; then<br>&gt; - =C2=A0 =C2=A0 =C2=A0if has $sphinx_build &amp;&amp; t=
est &quot;$sphinx_ok&quot; !=3D &quot;yes&quot;; then<br>&gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0echo &quot;Warning: $sphinx_build exists but it is either =
too old or uses too old a Python version&quot; &gt;&amp;2<br>&gt; - =C2=A0 =
=C2=A0 =C2=A0fi<br>&gt; - =C2=A0 =C2=A0 =C2=A0feature_not_found &quot;docs&=
quot; &quot;Install a Python 3 version of python-sphinx&quot;<br>&gt; - =C2=
=A0 =C2=A0fi<br>&gt; - =C2=A0 =C2=A0docs=3Dno<br>&gt; - =C2=A0fi<br>&gt; -f=
i<br>&gt; -<br>&gt; =C2=A0# Search for bswap_32 function<br>&gt; =C2=A0byte=
swap_h=3Dno<br>&gt; =C2=A0cat &gt; $TMPC &lt;&lt; EOF<br>&gt; @@ -6093,9 +6=
045,6 @@ qemu_version=3D$(head $source_path/VERSION)<br>&gt; =C2=A0echo &qu=
ot;PKGVERSION=3D$pkgversion&quot; &gt;&gt;$config_host_mak<br>&gt; =C2=A0ec=
ho &quot;SRC_PATH=3D$source_path&quot; &gt;&gt; $config_host_mak<br>&gt; =
=C2=A0echo &quot;TARGET_DIRS=3D$target_list&quot; &gt;&gt; $config_host_mak=
<br>&gt; -if [ &quot;$docs&quot; =3D &quot;yes&quot; ] ; then<br>&gt; - =C2=
=A0echo &quot;BUILD_DOCS=3Dyes&quot; &gt;&gt; $config_host_mak<br>&gt; -fi<=
br>&gt; =C2=A0if test &quot;$modules&quot; =3D &quot;yes&quot;; then<br>&gt=
; =C2=A0 =C2=A0# $shacmd can generate a hash started with digit, which the =
compiler doesn&#39;t<br>&gt; =C2=A0 =C2=A0# like as an symbol. So prefix it=
 with an underscore<br>&gt; @@ -6784,7 +6733,6 @@ fi<br>&gt; =C2=A0echo &qu=
ot;ROMS=3D$roms&quot; &gt;&gt; $config_host_mak<br>&gt; =C2=A0echo &quot;MA=
KE=3D$make&quot; &gt;&gt; $config_host_mak<br>&gt; =C2=A0echo &quot;PYTHON=
=3D$python&quot; &gt;&gt; $config_host_mak<br>&gt; -echo &quot;SPHINX_BUILD=
=3D$sphinx_build&quot; &gt;&gt; $config_host_mak<br>&gt; =C2=A0echo &quot;G=
ENISOIMAGE=3D$genisoimage&quot; &gt;&gt; $config_host_mak<br>&gt; =C2=A0ech=
o &quot;MESON=3D$meson&quot; &gt;&gt; $config_host_mak<br>&gt; =C2=A0echo &=
quot;NINJA=3D$ninja&quot; &gt;&gt; $config_host_mak<br>&gt; @@ -7066,6 +701=
4,7 @@ NINJA=3D$ninja $meson setup \<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0-Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Dcapstone=3D$capstone -Dslirp=3D$slirp -=
Dfdt=3D$fdt \<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Diconv=3D$iconv -D=
curses=3D$curses -Dlibudev=3D$libudev\<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-Ddocs=3D$docs -Dsphinx_build=3D$sphinx_build \<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0$cross_arg \<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot;$PWD&quot; &quot;$source_path&quot;<br>&gt;<br>&gt; diff --git a/docs=
/meson.build b/docs/meson.build<br>&gt; index 0340d489ac..789dca8cc0 100644=
<br>&gt; --- a/docs/meson.build<br>&gt; +++ b/docs/meson.build<br>&gt; @@ -=
1,4 +1,50 @@<div><br>&gt; +if get_option(&#39;sphinx_build&#39;) =3D=3D &#3=
9;&#39;<br>&gt; + =C2=A0sphinx_build =3D find_program([&#39;sphinx-build-3&=
#39;, &#39;sphinx-build&#39;],<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0requi=
red: get_option(&#39;docs&#39;))<br>&gt; +else<br>&gt; + =C2=A0sphinx_build=
 =3D find_program(get_option(&#39;sphinx_build&#39;),<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0required: get_option(&#39;docs&#39;))<br>&gt; +endif<br=
>&gt; +<br>&gt; +# Check if tools are available to build documentation.<br>=
&gt; +build_docs =3D false<br>&gt; +if sphinx_build.found()<br>&gt; + =C2=
=A0SPHINX_ARGS =3D [sphinx_build]<br>&gt; + =C2=A0# If we&#39;re making war=
nings fatal, apply this to Sphinx runs as well<br>&gt; + =C2=A0if get_optio=
n(&#39;werror&#39;)<br>&gt; + =C2=A0 =C2=A0SPHINX_ARGS +=3D [ &#39;-W&#39; =
]<br>&gt; + =C2=A0endif<br>&gt; +<br>&gt; + =C2=A0# This is a bit awkward b=
ut works: create a trivial document and<br>&gt; + =C2=A0# try to run it wit=
h our configuration file (which enforces a<br>&gt; + =C2=A0# version requir=
ement). This will fail if sphinx-build is too old.<br>&gt; + =C2=A0run_comm=
and(&#39;mkdir&#39;, [&#39;-p&#39;, tmpdir / &#39;sphinx&#39;])<br>&gt; + =
=C2=A0run_command(&#39;touch&#39;, [tmpdir / &#39;sphinx/index.rst&#39;])<b=
r>&gt; + =C2=A0sphinx_build_test_out =3D run_command(SPHINX_ARGS + [<br>&gt=
; + =C2=A0 =C2=A0&#39;-c&#39;, meson.current_source_dir(),<br>&gt; + =C2=A0=
 =C2=A0&#39;-b&#39;, &#39;html&#39;, tmpdir / &#39;sphinx&#39;,<br>&gt; + =
=C2=A0 =C2=A0tmpdir / &#39;sphinx/out&#39;])<br>&gt; + =C2=A0build_docs =3D=
 (sphinx_build_test_out.returncode() =3D=3D 0)<br>&gt; +<br>&gt; + =C2=A0if=
 not build_docs<br>&gt; + =C2=A0 =C2=A0warning(&#39;@0@ exists but it is ei=
ther too old or uses too old a Python version&#39;.format(sphinx_build_opti=
on))<br>Here need to be

get_option(&#39;sphinx_build&#39;)

<br><br><br><br><br>&gt; + =C2=A0 =C2=A0if get_option(&#39;docs&#39;).enabl=
ed()<br>&gt; + =C2=A0 =C2=A0 =C2=A0error(&#39;Install a Python 3 version of=
 python-sphinx&#39;)<br>&gt; + =C2=A0 =C2=A0endif<br>&gt; + =C2=A0endif<br>=
&gt; +endif<br>&gt; +<br>&gt; =C2=A0if build_docs<br>&gt; + =C2=A0SPHINX_AR=
GS +=3D [&#39;-Dversion=3D&#39; + meson.project_version(), &#39;-Drelease=
=3D&#39; + config_host[&#39;PKGVERSION&#39;]]<br>&gt; +<br>&gt; + =C2=A0sph=
inx_extn_depends =3D [ meson.source_root() / &#39;docs/sphinx/depfile.py&#3=
9;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson.source_root() / &#39;docs/sphinx/hxtoo=
l.py&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson.source_root() / &#39;docs/sphin=
x/kerneldoc.py&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson.source_root() / &#39;=
docs/sphinx/kernellog.py&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson.source_root()=
 / &#39;docs/sphinx/qapidoc.py&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson.source_=
root() / &#39;docs/sphinx/qmp_lexer.py&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qapi_=
gen_depends ]<br>&gt; +<br>&gt; =C2=A0 =C2=A0configure_file(output: &#39;in=
dex.html&#39;,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 input: files(&#39;<a href=3D"http://index.html.in">index.html.in=
</a>&#39;),<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 configuration: {&#39;VERSION&#39;: meson.project_version()},<br>&gt=
; diff --git a/meson.build b/meson.build<br>&gt; index 15732f4701..05fb59a0=
0b 100644<br>&gt; --- a/meson.build<br>&gt; +++ b/meson.build<br>&gt; @@ -1=
7,7 +17,13 @@ cc =3D meson.get_compiler(&#39;c&#39;)<br>&gt; =C2=A0config_h=
ost =3D keyval.load(meson.current_build_dir() / &#39;config-host.mak&#39;)<=
br>&gt; =C2=A0enable_modules =3D &#39;CONFIG_MODULES&#39; in config_host<br=
>&gt; =C2=A0enable_static =3D &#39;CONFIG_STATIC&#39; in config_host<br>&gt=
; -build_docs =3D &#39;BUILD_DOCS&#39; in config_host<br>&gt; +<br>&gt; +# =
Temporary directory used for files created while<br>&gt; +# configure runs.=
 Since it is in the build directory<br>&gt; +# we can safely blow away any =
previous version of it<br>&gt; +# (and we need not jump through hoops to tr=
y to delete<br>&gt; +# it when configure exits.)<br>&gt; +tmpdir =3D meson.=
current_build_dir() / &#39;meson-private/temp&#39;<br>&gt;<br>&gt; =C2=A0if=
 get_option(&#39;qemu_suffix&#39;).startswith(&#39;/&#39;)<br>&gt; =C2=A0 =
=C2=A0error(&#39;qemu_suffix cannot start with a /&#39;)<br>&gt; @@ -1266,2=
2 +1272,6 @@ foreach d : hx_headers<br>&gt; =C2=A0endforeach<br>&gt; =C2=A0=
genh +=3D hxdep<br>&gt;<br>&gt; -SPHINX_ARGS =3D [config_host[&#39;SPHINX_B=
UILD&#39;],<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39=
;-Dversion=3D&#39; + meson.project_version(),<br>&gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Drelease=3D&#39; + config_host[&#39;P=
KGVERSION&#39;]]<br>&gt; -<br>&gt; -if get_option(&#39;werror&#39;)<br>&gt;=
 - =C2=A0SPHINX_ARGS +=3D [ &#39;-W&#39; ]<br>&gt; -endif<br>&gt; -<br>&gt;=
 -sphinx_extn_depends =3D [ meson.source_root() / &#39;docs/sphinx/depfile.=
py&#39;,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0meson.source_root() / &#39;docs/sphinx/hxtool.py=
&#39;,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0meson.source_root() / &#39;docs/sphinx/kerneldoc=
.py&#39;,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson.source_root() / &#39;docs/sphinx/kernello=
g.py&#39;,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson.source_root() / &#39;docs/sphinx/qapid=
oc.py&#39;,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson.source_root() / &#39;docs/sphinx/qmp_l=
exer.py&#39;,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qapi_gen_depends ]<br>&gt; -<br>&gt; =C2=
=A0###################<br>&gt; =C2=A0# Collect sources #<br>&gt; =C2=A0####=
###############<br>&gt; @@ -1866,8 +1856,8 @@ endif<br>&gt; =C2=A0subdir(&#=
39;scripts&#39;)<br>&gt; =C2=A0subdir(&#39;tools&#39;)<br>&gt; =C2=A0subdir=
(&#39;pc-bios&#39;)<br>&gt; -subdir(&#39;tests&#39;)<br>&gt; =C2=A0subdir(&=
#39;docs&#39;)<br>&gt; +subdir(&#39;tests&#39;)<br>&gt; =C2=A0if &#39;CONFI=
G_GTK&#39; in config_host<br>&gt; =C2=A0 =C2=A0subdir(&#39;po&#39;)<br>&gt;=
 =C2=A0endif<br>&gt; @@ -1949,7 +1939,7 @@ summary_info +=3D {&#39;QEMU_CFL=
AGS&#39;: =C2=A0 =C2=A0 =C2=A0 config_host[&#39;QEMU_CFLAGS&#39;]}<br>&gt; =
=C2=A0summary_info +=3D {&#39;QEMU_LDFLAGS&#39;: =C2=A0 =C2=A0 =C2=A0config=
_host[&#39;QEMU_LDFLAGS&#39;]}<br>&gt; =C2=A0summary_info +=3D {&#39;make&#=
39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_host[&#39;MAKE&=
#39;]}<br>&gt; =C2=A0summary_info +=3D {&#39;python&#39;: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&#39;@0@ (version: @1@)&#39;.format(python.full_pat=
h(), python.language_version())}<br>&gt; -summary_info +=3D {&#39;sphinx-bu=
ild&#39;: =C2=A0 =C2=A0 =C2=A0config_host[&#39;SPHINX_BUILD&#39;]}<br>&gt; =
+summary_info +=3D {&#39;sphinx-build&#39;: =C2=A0 =C2=A0 =C2=A0sphinx_buil=
d.found()}<br>&gt; =C2=A0summary_info +=3D {&#39;genisoimage&#39;: =C2=A0 =
=C2=A0 =C2=A0 config_host[&#39;GENISOIMAGE&#39;]}<br>&gt; =C2=A0# TODO: add=
 back version<br>&gt; =C2=A0summary_info +=3D {&#39;slirp support&#39;: =C2=
=A0 =C2=A0 slirp_opt =3D=3D &#39;disabled&#39; ? false : slirp_opt}<br>&gt;=
 @@ -2017,7 +2007,7 @@ if config_host.has_key(&#39;CONFIG_XEN_BACKEND&#39;)=
<br>&gt; =C2=A0 =C2=A0summary_info +=3D {&#39;xen ctrl version&#39;: =C2=A0=
config_host[&#39;CONFIG_XEN_CTRL_INTERFACE_VERSION&#39;]}<br>&gt; =C2=A0end=
if<br>&gt; =C2=A0summary_info +=3D {&#39;brlapi support&#39;: =C2=A0 =C2=A0=
config_host.has_key(&#39;CONFIG_BRLAPI&#39;)}<br>&gt; -summary_info +=3D {&=
#39;Documentation&#39;: =C2=A0 =C2=A0 config_host.has_key(&#39;BUILD_DOCS&#=
39;)}<br>&gt; +summary_info +=3D {&#39;Documentation&#39;: =C2=A0 =C2=A0 bu=
ild_docs}<br>&gt; =C2=A0summary_info +=3D {&#39;PIE&#39;: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_option(&#39;b_pie&#39;)}<br>&gt; =C2=A0=
summary_info +=3D {&#39;vde support&#39;: =C2=A0 =C2=A0 =C2=A0 config_host.=
has_key(&#39;CONFIG_VDE&#39;)}<br>&gt; =C2=A0summary_info +=3D {&#39;netmap=
 support&#39;: =C2=A0 =C2=A0config_host.has_key(&#39;CONFIG_NETMAP&#39;)}<b=
r>&gt; diff --git a/meson_options.txt b/meson_options.txt<br>&gt; index 77b=
3fabd00..967229b66e 100644<br>&gt; --- a/meson_options.txt<br>&gt; +++ b/me=
son_options.txt<br>&gt; @@ -2,7 +2,11 @@ option(&#39;qemu_suffix&#39;, type=
 : &#39;string&#39;, value: &#39;qemu&#39;,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 description: &#39;Suffix for QEMU data/modules/config directories (c=
an be empty)&#39;)<br>&gt; =C2=A0option(&#39;docdir&#39;, type : &#39;strin=
g&#39;, value : &#39;doc&#39;,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 descript=
ion: &#39;Base directory for documentation installation (can be empty)&#39;=
)<br>&gt; +option(&#39;sphinx_build&#39;, type : &#39;string&#39;, value : =
&#39;&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 description: &#39;Use specified =
sphinx-build [$sphinx_build] for building document (default to be empty)&#3=
9;)<br>&gt;<br>&gt; +option(&#39;docs&#39;, type : &#39;feature&#39;, value=
 : &#39;auto&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 description: &#39;Documen=
tations build support&#39;)<br>&gt; =C2=A0option(&#39;gettext&#39;, type : =
&#39;boolean&#39;, value : true,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 descri=
ption: &#39;Localization of the GTK+ user interface&#39;)<br>&gt; =C2=A0opt=
ion(&#39;sparse&#39;, type : &#39;feature&#39;, value : &#39;auto&#39;,<br>=
&gt; --<br>&gt; 2.26.2<br>&gt;<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=
=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000646d0605b1c9ba36--

