Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CA3C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55CC2071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in3HYCTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55CC2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjvJ-0001go-NI
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuH-0008BV-S3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:41 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuD-0003rG-BE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:41 -0400
Received: by mail-pf1-x443.google.com with SMTP id 17so1602893pfw.9
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3CCQ4/urH9bUSiHO0KVHncurks4pfIdxmYpVvda1T00=;
 b=in3HYCTDLtkQ6uOZ4r8XoHFP8dZozqr7dHHjjnutCaqDFhrDwN3ZSfVQzRfoH7Kkex
 dRIwxYWlhsyHIOYxiAW6bAg4Mb7IrnTEXlbICkWUUOW2oFsMcaEWr35KXzv70rnHRf9n
 +fTFHPFMiScwkBbg/AZ20L1q11r9djaHCR1DSatboPT9dF7rOHRdWq9swzsn7OxP9Kei
 Ty3VHKD+JptTmuq10clg4PdENo2seu3lCiW2gnOGrzihXIT86m1+oRaTs0pP8R6ifRLH
 zRk4j2NHkUjzBOWzIT9ib/2TgSTU70TzrOGb/DiCEdj2jOt1xnIwpykW1zQttG1qTvnL
 YOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3CCQ4/urH9bUSiHO0KVHncurks4pfIdxmYpVvda1T00=;
 b=NltQHQG3pE2omndHNZkZgR9Ti908hEiaMzIJfbfdKIJDVTBoy8qrxPDLFTmguSLXvE
 TMLJv639pr+fzK9GvM1Ona1FWThzhnaHwY7nAfDeDaZ9ZUzlkuwUuPREqWfElbQ+9Suz
 4wiGDFn+PkfYOLxruaSw1IyZXMWoRLeTFYS83hJwqO1jGAafeLOQMkjx4/8uLGoy9YQV
 +/MaAF6jBARXt5Cnet0S52B2JO662LkJuX0Rkb9TFaFFgwHPuyDi5d5GSSiD2i3xzZ68
 iarm5dPfhKO6yGw3UPl+y1MtyQW4U4SmWJ1mPsV7kM3MRzHgTkSeXIpdHfKWs0xYS95W
 kw5Q==
X-Gm-Message-State: AOAM531JXVp8N2rjh788Ut9zErN3wGZBZW5E0+A0O7RcABb4oHE/h25+
 xDNViZ8oqC0QIavjGg2/7o5SYRaZ2P7lzg==
X-Google-Smtp-Source: ABdhPJw+DVCguQD1FEvOh0zIejRP4gx2idYUv3rYWTeuQGTeiK+VL4iO1+7uNW8BfPwCd7IzivxucA==
X-Received: by 2002:a62:8c86:: with SMTP id m128mr2610825pfd.111.1599119013754; 
 Thu, 03 Sep 2020 00:43:33 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id o6sm1512472pju.25.2020.09.03.00.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:43:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/12] meson: Convert undefsym.sh to undefsym.py
Date: Thu,  3 Sep 2020 15:43:03 +0800
Message-Id: <20200903074313.1498-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903074313.1498-1-luoyonggang@gmail.com>
References: <20200903074313.1498-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

undefsym.sh are not msys2 compatible, convert it to python script

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build         | 2994 +++++++++++++++++++++----------------------
 scripts/undefsym.py |   57 +
 scripts/undefsym.sh |   20 -
 3 files changed, 1554 insertions(+), 1517 deletions(-)
 create mode 100644 scripts/undefsym.py
 delete mode 100755 scripts/undefsym.sh

diff --git a/meson.build b/meson.build
index 55c7d2318c..c9f5d05664 100644
--- a/meson.build
+++ b/meson.build
@@ -1,1497 +1,1497 @@
-project('qemu', ['c'], meson_version: '>=3D0.55.0',
-        default_options: ['warning_level=3D1', 'c_std=3Dgnu99', 'cpp_std=
=3Dgnu++11',
-                          'b_lundef=3Dfalse','b_colorout=3Dauto'],
-        version: run_command('head', meson.source_root() / 'VERSION').stdo=
ut().strip())
-
-not_found =3D dependency('', required: false)
-if meson.version().version_compare('>=3D0.56.0')
-  keyval =3D import('keyval')
-else
-  keyval =3D import('unstable-keyval')
-endif
-ss =3D import('sourceset')
-
-sh =3D find_program('sh')
-cc =3D meson.get_compiler('c')
-config_host =3D keyval.load(meson.current_build_dir() / 'config-host.mak')
-config_all_disas =3D keyval.load(meson.current_build_dir() / 'config-all-d=
isas.mak')
-enable_modules =3D 'CONFIG_MODULES' in config_host
-enable_static =3D 'CONFIG_STATIC' in config_host
-build_docs =3D 'BUILD_DOCS' in config_host
-qemu_datadir =3D get_option('datadir') / get_option('qemu_suffix')
-qemu_docdir =3D get_option('docdir') / get_option('qemu_suffix')
-config_host_data =3D configuration_data()
-genh =3D []
-
-target_dirs =3D config_host['TARGET_DIRS'].split()
-have_user =3D false
-have_system =3D false
-foreach target : target_dirs
-  have_user =3D have_user or target.endswith('-user')
-  have_system =3D have_system or target.endswith('-softmmu')
-endforeach
-have_tools =3D 'CONFIG_TOOLS' in config_host
-have_block =3D have_system or have_tools
-
-add_project_arguments(config_host['QEMU_CFLAGS'].split(),
-                      native: false, language: ['c', 'objc'])
-add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
-                      native: false, language: 'cpp')
-add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
-                           native: false, language: ['c', 'cpp', 'objc'])
-add_project_arguments(config_host['QEMU_INCLUDES'].split(),
-                      language: ['c', 'cpp', 'objc'])
-
-python =3D import('python').find_installation()
-
-link_language =3D meson.get_external_property('link_language', 'cpp')
-if link_language =3D=3D 'cpp'
-  add_languages('cpp', required: true, native: false)
-endif
-if host_machine.system() =3D=3D 'darwin'
-  add_languages('objc', required: false, native: false)
-endif
-
-if 'SPARSE_CFLAGS' in config_host
-  run_target('sparse',
-             command: [find_program('scripts/check_sparse.py'),
-                       config_host['SPARSE_CFLAGS'].split(),
-                       'compile_commands.json'])
-endif
-
-configure_file(input: files('scripts/ninjatool.py'),
-               output: 'ninjatool',
-               configuration: config_host)
-
-supported_oses =3D ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', '=
sunos', 'linux']
-supported_cpus =3D ['ppc', 'ppc64', 's390x', 'sparc64', 'riscv32', 'riscv6=
4', 'x86', 'x86_64',
-  'arm', 'aarch64', 'mips', 'mips64', 'sparc', 'sparc64']
-
-cpu =3D host_machine.cpu_family()
-targetos =3D host_machine.system()
-
-m =3D cc.find_library('m', required: false)
-util =3D cc.find_library('util', required: false)
-winmm =3D []
-socket =3D []
-version_res =3D []
-coref =3D []
-iokit =3D []
-cocoa =3D []
-hvf =3D []
-if targetos =3D=3D 'windows'
-  socket =3D cc.find_library('ws2_32')
-  winmm =3D cc.find_library('winmm')
-
-  win =3D import('windows')
-  version_res =3D win.compile_resources('version.rc',
-                                      depend_files: files('pc-bios/qemu-ns=
is.ico'),
-                                      include_directories: include_directo=
ries('.'))
-elif targetos =3D=3D 'darwin'
-  coref =3D dependency('appleframeworks', modules: 'CoreFoundation')
-  iokit =3D dependency('appleframeworks', modules: 'IOKit')
-  cocoa =3D dependency('appleframeworks', modules: 'Cocoa')
-  hvf =3D dependency('appleframeworks', modules: 'Hypervisor')
-elif targetos =3D=3D 'sunos'
-  socket =3D [cc.find_library('socket'),
-            cc.find_library('nsl'),
-            cc.find_library('resolv')]
-elif targetos =3D=3D 'haiku'
-  socket =3D [cc.find_library('posix_error_mapper'),
-            cc.find_library('network'),
-            cc.find_library('bsd')]
-endif
-glib =3D declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split=
(),
-                          link_args: config_host['GLIB_LIBS'].split())
-gio =3D not_found
-if 'CONFIG_GIO' in config_host
-  gio =3D declare_dependency(compile_args: config_host['GIO_CFLAGS'].split=
(),
-                           link_args: config_host['GIO_LIBS'].split())
-endif
-lttng =3D not_found
-if 'CONFIG_TRACE_UST' in config_host
-  lttng =3D declare_dependency(link_args: config_host['LTTNG_UST_LIBS'].sp=
lit())
-endif
-urcubp =3D not_found
-if 'CONFIG_TRACE_UST' in config_host
-  urcubp =3D declare_dependency(link_args: config_host['URCU_BP_LIBS'].spl=
it())
-endif
-nettle =3D not_found
-if 'CONFIG_NETTLE' in config_host
-  nettle =3D declare_dependency(compile_args: config_host['NETTLE_CFLAGS']=
.split(),
-                              link_args: config_host['NETTLE_LIBS'].split(=
))
-endif
-gnutls =3D not_found
-if 'CONFIG_GNUTLS' in config_host
-  gnutls =3D declare_dependency(compile_args: config_host['GNUTLS_CFLAGS']=
.split(),
-                              link_args: config_host['GNUTLS_LIBS'].split(=
))
-endif
-pixman =3D not_found
-if have_system or have_tools
-  pixman =3D dependency('pixman-1', required: have_system, version:'>=3D0.=
21.8',
-                      method: 'pkg-config', static: enable_static)
-endif
-pam =3D not_found
-if 'CONFIG_AUTH_PAM' in config_host
-  pam =3D cc.find_library('pam')
-endif
-libaio =3D cc.find_library('aio', required: false)
-zlib =3D dependency('zlib', required: true, static: enable_static)
-linux_io_uring =3D not_found
-if 'CONFIG_LINUX_IO_URING' in config_host
-  linux_io_uring =3D declare_dependency(compile_args: config_host['LINUX_I=
O_URING_CFLAGS'].split(),
-                                      link_args: config_host['LINUX_IO_URI=
NG_LIBS'].split())
-endif
-libxml2 =3D not_found
-if 'CONFIG_LIBXML2' in config_host
-  libxml2 =3D declare_dependency(compile_args: config_host['LIBXML2_CFLAGS=
'].split(),
-                               link_args: config_host['LIBXML2_LIBS'].spli=
t())
-endif
-libnfs =3D not_found
-if 'CONFIG_LIBNFS' in config_host
-  libnfs =3D declare_dependency(link_args: config_host['LIBNFS_LIBS'].spli=
t())
-endif
-libattr =3D not_found
-if 'CONFIG_ATTR' in config_host
-  libattr =3D declare_dependency(link_args: config_host['LIBATTR_LIBS'].sp=
lit())
-endif
-seccomp =3D not_found
-if 'CONFIG_SECCOMP' in config_host
-  seccomp =3D declare_dependency(compile_args: config_host['SECCOMP_CFLAGS=
'].split(),
-                               link_args: config_host['SECCOMP_LIBS'].spli=
t())
-endif
-libcap_ng =3D not_found
-if 'CONFIG_LIBCAP_NG' in config_host
-  libcap_ng =3D declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'=
].split())
-endif
-if get_option('xkbcommon').auto() and not have_system and not have_tools
-  xkbcommon =3D not_found
-else
-  xkbcommon =3D dependency('xkbcommon', required: get_option('xkbcommon'),
-                         method: 'pkg-config', static: enable_static)
-endif
-slirp =3D not_found
-if config_host.has_key('CONFIG_SLIRP')
-  slirp =3D declare_dependency(compile_args: config_host['SLIRP_CFLAGS'].s=
plit(),
-                             link_args: config_host['SLIRP_LIBS'].split())
-endif
-vde =3D not_found
-if config_host.has_key('CONFIG_VDE')
-  vde =3D declare_dependency(link_args: config_host['VDE_LIBS'].split())
-endif
-pulse =3D not_found
-if 'CONFIG_LIBPULSE' in config_host
-  pulse =3D declare_dependency(compile_args: config_host['PULSE_CFLAGS'].s=
plit(),
-                             link_args: config_host['PULSE_LIBS'].split())
-endif
-alsa =3D not_found
-if 'CONFIG_ALSA' in config_host
-  alsa =3D declare_dependency(compile_args: config_host['ALSA_CFLAGS'].spl=
it(),
-                            link_args: config_host['ALSA_LIBS'].split())
-endif
-jack =3D not_found
-if 'CONFIG_LIBJACK' in config_host
-  jack =3D declare_dependency(link_args: config_host['JACK_LIBS'].split())
-endif
-spice =3D not_found
-if 'CONFIG_SPICE' in config_host
-  spice =3D declare_dependency(compile_args: config_host['SPICE_CFLAGS'].s=
plit(),
-                             link_args: config_host['SPICE_LIBS'].split())
-endif
-rt =3D cc.find_library('rt', required: false)
-libmpathpersist =3D not_found
-if config_host.has_key('CONFIG_MPATH')
-  libmpathpersist =3D cc.find_library('mpathpersist')
-endif
-libiscsi =3D not_found
-if 'CONFIG_LIBISCSI' in config_host
-  libiscsi =3D declare_dependency(compile_args: config_host['LIBISCSI_CFLA=
GS'].split(),
-                                link_args: config_host['LIBISCSI_LIBS'].sp=
lit())
-endif
-zstd =3D not_found
-if 'CONFIG_ZSTD' in config_host
-  zstd =3D declare_dependency(compile_args: config_host['ZSTD_CFLAGS'].spl=
it(),
-                            link_args: config_host['ZSTD_LIBS'].split())
-endif
-gbm =3D not_found
-if 'CONFIG_GBM' in config_host
-  gbm =3D declare_dependency(compile_args: config_host['GBM_CFLAGS'].split=
(),
-                           link_args: config_host['GBM_LIBS'].split())
-endif
-virgl =3D not_found
-if 'CONFIG_VIRGL' in config_host
-  virgl =3D declare_dependency(compile_args: config_host['VIRGL_CFLAGS'].s=
plit(),
-                             link_args: config_host['VIRGL_LIBS'].split())
-endif
-curl =3D not_found
-if 'CONFIG_CURL' in config_host
-  curl =3D declare_dependency(compile_args: config_host['CURL_CFLAGS'].spl=
it(),
-                            link_args: config_host['CURL_LIBS'].split())
-endif
-libudev =3D not_found
-if 'CONFIG_LIBUDEV' in config_host
-  libudev =3D declare_dependency(link_args: config_host['LIBUDEV_LIBS'].sp=
lit())
-endif
-brlapi =3D not_found
-if 'CONFIG_BRLAPI' in config_host
-  brlapi =3D declare_dependency(link_args: config_host['BRLAPI_LIBS'].spli=
t())
-endif
-
-sdl =3D not_found
-if have_system
-  sdl =3D dependency('sdl2', required: get_option('sdl'), static: enable_s=
tatic)
-  sdl_image =3D not_found
-endif
-if sdl.found()
-  # work around 2.0.8 bug
-  sdl =3D declare_dependency(compile_args: '-Wno-undef',
-                           dependencies: sdl)
-  sdl_image =3D dependency('SDL2_image', required: get_option('sdl_image'),
-                         method: 'pkg-config', static: enable_static)
-else
-  if get_option('sdl_image').enabled()
-    error('sdl-image required, but SDL was @0@',
-          get_option('sdl').disabled() ? 'disabled' : 'not found')
-  endif
-  sdl_image =3D not_found
-endif
-
-rbd =3D not_found
-if 'CONFIG_RBD' in config_host
-  rbd =3D declare_dependency(link_args: config_host['RBD_LIBS'].split())
-endif
-glusterfs =3D not_found
-if 'CONFIG_GLUSTERFS' in config_host
-  glusterfs =3D declare_dependency(compile_args: config_host['GLUSTERFS_CF=
LAGS'].split(),
-                                 link_args: config_host['GLUSTERFS_LIBS'].=
split())
-endif
-libssh =3D not_found
-if 'CONFIG_LIBSSH' in config_host
-  libssh =3D declare_dependency(compile_args: config_host['LIBSSH_CFLAGS']=
.split(),
-                              link_args: config_host['LIBSSH_LIBS'].split(=
))
-endif
-libbzip2 =3D not_found
-if 'CONFIG_BZIP2' in config_host
-  libbzip2 =3D declare_dependency(link_args: config_host['BZIP2_LIBS'].spl=
it())
-endif
-liblzfse =3D not_found
-if 'CONFIG_LZFSE' in config_host
-  liblzfse =3D declare_dependency(link_args: config_host['LZFSE_LIBS'].spl=
it())
-endif
-oss =3D not_found
-if 'CONFIG_AUDIO_OSS' in config_host
-  oss =3D declare_dependency(link_args: config_host['OSS_LIBS'].split())
-endif
-dsound =3D not_found
-if 'CONFIG_AUDIO_DSOUND' in config_host
-  dsound =3D declare_dependency(link_args: config_host['DSOUND_LIBS'].spli=
t())
-endif
-coreaudio =3D not_found
-if 'CONFIG_AUDIO_COREAUDIO' in config_host
-  coreaudio =3D declare_dependency(link_args: config_host['COREAUDIO_LIBS'=
].split())
-endif
-opengl =3D not_found
-if 'CONFIG_OPENGL' in config_host
-  opengl =3D declare_dependency(link_args: config_host['OPENGL_LIBS'].spli=
t())
-else
-endif
-gtk =3D not_found
-if 'CONFIG_GTK' in config_host
-  gtk =3D declare_dependency(compile_args: config_host['GTK_CFLAGS'].split=
(),
-                              link_args: config_host['GTK_LIBS'].split())
-endif
-vte =3D not_found
-if 'CONFIG_VTE' in config_host
-  vte =3D declare_dependency(compile_args: config_host['VTE_CFLAGS'].split=
(),
-                           link_args: config_host['VTE_LIBS'].split())
-endif
-x11 =3D not_found
-if 'CONFIG_X11' in config_host
-  x11 =3D declare_dependency(compile_args: config_host['X11_CFLAGS'].split=
(),
-                           link_args: config_host['X11_LIBS'].split())
-endif
-curses =3D not_found
-if 'CONFIG_CURSES' in config_host
-  curses =3D declare_dependency(compile_args: config_host['CURSES_CFLAGS']=
.split(),
-                              link_args: config_host['CURSES_LIBS'].split(=
))
-endif
-iconv =3D not_found
-if 'CONFIG_ICONV' in config_host
-  iconv =3D declare_dependency(compile_args: config_host['ICONV_CFLAGS'].s=
plit(),
-                             link_args: config_host['ICONV_LIBS'].split())
-endif
-gio =3D not_found
-if 'CONFIG_GIO' in config_host
-  gio =3D declare_dependency(compile_args: config_host['GIO_CFLAGS'].split=
(),
-                           link_args: config_host['GIO_LIBS'].split())
-endif
-vnc =3D not_found
-png =3D not_found
-jpeg =3D not_found
-sasl =3D not_found
-if get_option('vnc').enabled()
-  vnc =3D declare_dependency() # dummy dependency
-  png =3D dependency('libpng', required: get_option('vnc_png'),
-                   method: 'pkg-config', static: enable_static)
-  jpeg =3D cc.find_library('jpeg', has_headers: ['jpeglib.h'],
-                         required: get_option('vnc_jpeg'),
-                         static: enable_static)
-  sasl =3D cc.find_library('sasl2', has_headers: ['sasl/sasl.h'],
-                         required: get_option('vnc_sasl'),
-                         static: enable_static)
-  if sasl.found()
-    sasl =3D declare_dependency(dependencies: sasl,
-                              compile_args: '-DSTRUCT_IOVEC_DEFINED')
-  endif
-endif
-fdt =3D not_found
-if 'CONFIG_FDT' in config_host
-  fdt =3D declare_dependency(compile_args: config_host['FDT_CFLAGS'].split=
(),
-                           link_args: config_host['FDT_LIBS'].split())
-endif
-snappy =3D not_found
-if 'CONFIG_SNAPPY' in config_host
-  snappy =3D declare_dependency(link_args: config_host['SNAPPY_LIBS'].spli=
t())
-endif
-lzo =3D not_found
-if 'CONFIG_LZO' in config_host
-  lzo =3D declare_dependency(link_args: config_host['LZO_LIBS'].split())
-endif
-rdma =3D not_found
-if 'CONFIG_RDMA' in config_host
-  rdma =3D declare_dependency(link_args: config_host['RDMA_LIBS'].split())
-endif
-numa =3D not_found
-if 'CONFIG_NUMA' in config_host
-  numa =3D declare_dependency(link_args: config_host['NUMA_LIBS'].split())
-endif
-xen =3D not_found
-if 'CONFIG_XEN_BACKEND' in config_host
-  xen =3D declare_dependency(compile_args: config_host['XEN_CFLAGS'].split=
(),
-                           link_args: config_host['XEN_LIBS'].split())
-endif
-cacard =3D not_found
-if 'CONFIG_SMARTCARD' in config_host
-  cacard =3D declare_dependency(compile_args: config_host['SMARTCARD_CFLAG=
S'].split(),
-                              link_args: config_host['SMARTCARD_LIBS'].spl=
it())
-endif
-u2f =3D not_found
-if have_system
-  u2f =3D dependency('u2f-emu', required: get_option('u2f'),
-                   method: 'pkg-config',
-                   static: enable_static)
-endif
-usbredir =3D not_found
-if 'CONFIG_USB_REDIR' in config_host
-  usbredir =3D declare_dependency(compile_args: config_host['USB_REDIR_CFL=
AGS'].split(),
-                                link_args: config_host['USB_REDIR_LIBS'].s=
plit())
-endif
-libusb =3D not_found
-if 'CONFIG_USB_LIBUSB' in config_host
-  libusb =3D declare_dependency(compile_args: config_host['LIBUSB_CFLAGS']=
.split(),
-                              link_args: config_host['LIBUSB_LIBS'].split(=
))
-endif
-capstone =3D not_found
-if 'CONFIG_CAPSTONE' in config_host
-  capstone =3D declare_dependency(compile_args: config_host['CAPSTONE_CFLA=
GS'].split(),
-                                link_args: config_host['CAPSTONE_LIBS'].sp=
lit())
-endif
-libpmem =3D not_found
-if 'CONFIG_LIBPMEM' in config_host
-  libpmem =3D declare_dependency(compile_args: config_host['LIBPMEM_CFLAGS=
'].split(),
-                               link_args: config_host['LIBPMEM_LIBS'].spli=
t())
-endif
-libdaxctl =3D not_found
-if 'CONFIG_LIBDAXCTL' in config_host
-  libdaxctl =3D declare_dependency(link_args: config_host['LIBDAXCTL_LIBS'=
].split())
-endif
-
-# Create config-host.h
-
-config_host_data.set('CONFIG_SDL', sdl.found())
-config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
-config_host_data.set('CONFIG_VNC', vnc.found())
-config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
-config_host_data.set('CONFIG_VNC_PNG', png.found())
-config_host_data.set('CONFIG_VNC_SASL', sasl.found())
-config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
-config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version(=
)))
-config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('=
.')[0])
-config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('=
.')[1])
-config_host_data.set('QEMU_VERSION_MICRO', meson.project_version().split('=
.')[2])
-
-arrays =3D ['CONFIG_AUDIO_DRIVERS', 'CONFIG_BDRV_RW_WHITELIST', 'CONFIG_BD=
RV_RO_WHITELIST']
-strings =3D ['HOST_DSOSUF', 'CONFIG_IASL', 'qemu_confdir', 'qemu_datadir',
-           'qemu_moddir', 'qemu_localstatedir', 'qemu_helperdir', 'qemu_lo=
caledir',
-           'qemu_icondir', 'qemu_desktopdir', 'qemu_firmwarepath']
-foreach k, v: config_host
-  if arrays.contains(k)
-    if v !=3D ''
-      v =3D '"' + '", "'.join(v.split()) + '", '
-    endif
-    config_host_data.set(k, v)
-  elif k =3D=3D 'ARCH'
-    config_host_data.set('HOST_' + v.to_upper(), 1)
-  elif strings.contains(k)
-    if not k.startswith('CONFIG_')
-      k =3D 'CONFIG_' + k.to_upper()
-    endif
-    config_host_data.set_quoted(k, v)
-  elif k.startswith('CONFIG_') or k.startswith('HAVE_') or k.startswith('H=
OST_')
-    config_host_data.set(k, v =3D=3D 'y' ? 1 : v)
-  endif
-endforeach
-genh +=3D configure_file(output: 'config-host.h', configuration: config_ho=
st_data)
-
-minikconf =3D find_program('scripts/minikconf.py')
-config_devices_mak_list =3D []
-config_devices_h =3D {}
-config_target_h =3D {}
-config_target_mak =3D {}
-kconfig_external_symbols =3D [
-  'CONFIG_KVM',
-  'CONFIG_XEN',
-  'CONFIG_TPM',
-  'CONFIG_SPICE',
-  'CONFIG_IVSHMEM',
-  'CONFIG_OPENGL',
-  'CONFIG_X11',
-  'CONFIG_VHOST_USER',
-  'CONFIG_VHOST_KERNEL',
-  'CONFIG_VIRTFS',
-  'CONFIG_LINUX',
-  'CONFIG_PVRDMA',
-]
-ignored =3D ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
-foreach target : target_dirs
-  config_target =3D keyval.load(meson.current_build_dir() / target / 'conf=
ig-target.mak')
-
-  config_target_data =3D configuration_data()
-  foreach k, v: config_target
-    if not k.startswith('TARGET_') and not k.startswith('CONFIG_')
-      # do nothing
-    elif ignored.contains(k)
-      # do nothing
-    elif k =3D=3D 'TARGET_BASE_ARCH'
-      config_target_data.set('TARGET_' + v.to_upper(), 1)
-    elif k =3D=3D 'TARGET_NAME'
-      config_target_data.set_quoted(k, v)
-    elif v =3D=3D 'y'
-      config_target_data.set(k, 1)
-    else
-      config_target_data.set(k, v)
-    endif
-  endforeach
-  config_target_h +=3D {target: configure_file(output: target + '-config-t=
arget.h',
-                                               configuration: config_targe=
t_data)}
-
-  if target.endswith('-softmmu')
-    base_kconfig =3D []
-    foreach sym : kconfig_external_symbols
-      if sym in config_target or sym in config_host
-        base_kconfig +=3D '@0@=3Dy'.format(sym)
-      endif
-    endforeach
-
-    config_devices_mak =3D target + '-config-devices.mak'
-    config_devices_mak =3D configure_file(
-      input: ['default-configs' / target + '.mak', 'Kconfig'],
-      output: config_devices_mak,
-      depfile: config_devices_mak + '.d',
-      capture: true,
-      command: [minikconf, config_host['CONFIG_MINIKCONF_MODE'],
-                config_devices_mak, '@DEPFILE@', '@INPUT@',
-                base_kconfig])
-
-    config_devices_data =3D configuration_data()
-    config_devices =3D keyval.load(config_devices_mak)
-    foreach k, v: config_devices
-      config_devices_data.set(k, 1)
-    endforeach
-    config_devices_mak_list +=3D config_devices_mak
-    config_devices_h +=3D {target: configure_file(output: target + '-confi=
g-devices.h',
-                                                configuration: config_devi=
ces_data)}
-    config_target +=3D config_devices
-  endif
-  config_target_mak +=3D {target: config_target}
-endforeach
-
-grepy =3D find_program('scripts/grepy.sh')
-# This configuration is used to build files that are shared by
-# multiple binaries, and then extracted out of the "common"
-# static_library target.
-#
-# We do not use all_sources()/all_dependencies(), because it would
-# build literally all source files, including devices only used by
-# targets that are not built for this compilation.  The CONFIG_ALL
-# pseudo symbol replaces it.
-
-if have_system
-  config_all_devices_mak =3D configure_file(
-    output: 'config-all-devices.mak',
-    input: config_devices_mak_list,
-    capture: true,
-    command: [grepy, '@INPUT@'],
-  )
-  config_all_devices =3D keyval.load(config_all_devices_mak)
-else
-  config_all_devices =3D {}
-endif
-config_all =3D config_all_devices
-config_all +=3D config_host
-config_all +=3D config_all_disas
-config_all +=3D {
-  'CONFIG_XEN': config_host.has_key('CONFIG_XEN_BACKEND'),
-  'CONFIG_SOFTMMU': have_system,
-  'CONFIG_USER_ONLY': have_user,
-  'CONFIG_ALL': true,
-}
-
-# Generators
-
-hxtool =3D find_program('scripts/hxtool')
-shaderinclude =3D find_program('scripts/shaderinclude.pl')
-qapi_gen =3D find_program('scripts/qapi-gen.py')
-qapi_gen_depends =3D [ meson.source_root() / 'scripts/qapi/__init__.py',
-                     meson.source_root() / 'scripts/qapi/commands.py',
-                     meson.source_root() / 'scripts/qapi/common.py',
-                     meson.source_root() / 'scripts/qapi/doc.py',
-                     meson.source_root() / 'scripts/qapi/error.py',
-                     meson.source_root() / 'scripts/qapi/events.py',
-                     meson.source_root() / 'scripts/qapi/expr.py',
-                     meson.source_root() / 'scripts/qapi/gen.py',
-                     meson.source_root() / 'scripts/qapi/introspect.py',
-                     meson.source_root() / 'scripts/qapi/parser.py',
-                     meson.source_root() / 'scripts/qapi/schema.py',
-                     meson.source_root() / 'scripts/qapi/source.py',
-                     meson.source_root() / 'scripts/qapi/types.py',
-                     meson.source_root() / 'scripts/qapi/visit.py',
-                     meson.source_root() / 'scripts/qapi/common.py',
-                     meson.source_root() / 'scripts/qapi/doc.py',
-                     meson.source_root() / 'scripts/qapi-gen.py'
-]
-
-tracetool =3D [
-  python, files('scripts/tracetool.py'),
-   '--backend=3D' + config_host['TRACE_BACKENDS']
-]
-
-qemu_version_cmd =3D [find_program('scripts/qemu-version.sh'),
-                    meson.current_source_dir(),
-                    config_host['PKGVERSION'], meson.project_version()]
-qemu_version =3D custom_target('qemu-version.h',
-                             output: 'qemu-version.h',
-                             command: qemu_version_cmd,
-                             capture: true,
-                             build_by_default: true,
-                             build_always_stale: true)
-genh +=3D qemu_version
-
-hxdep =3D []
-hx_headers =3D [
-  ['qemu-options.hx', 'qemu-options.def'],
-  ['qemu-img-cmds.hx', 'qemu-img-cmds.h'],
-]
-if have_system
-  hx_headers +=3D [
-    ['hmp-commands.hx', 'hmp-commands.h'],
-    ['hmp-commands-info.hx', 'hmp-commands-info.h'],
-  ]
-endif
-foreach d : hx_headers
-  hxdep +=3D custom_target(d[1],
-                input: files(d[0]),
-                output: d[1],
-                capture: true,
-                build_by_default: true, # to be removed when added to a ta=
rget
-                command: [hxtool, '-h', '@INPUT0@'])
-endforeach
-genh +=3D hxdep
-
-# Collect sourcesets.
-
-util_ss =3D ss.source_set()
-stub_ss =3D ss.source_set()
-trace_ss =3D ss.source_set()
-block_ss =3D ss.source_set()
-blockdev_ss =3D ss.source_set()
-qmp_ss =3D ss.source_set()
-common_ss =3D ss.source_set()
-softmmu_ss =3D ss.source_set()
-user_ss =3D ss.source_set()
-bsd_user_ss =3D ss.source_set()
-linux_user_ss =3D ss.source_set()
-specific_ss =3D ss.source_set()
-specific_fuzz_ss =3D ss.source_set()
-
-modules =3D {}
-hw_arch =3D {}
-target_arch =3D {}
-target_softmmu_arch =3D {}
-
-###############
-# Trace files #
-###############
-
-# TODO: add each directory to the subdirs from its own meson.build, once
-# we have those
-trace_events_subdirs =3D [
-  'accel/kvm',
-  'accel/tcg',
-  'crypto',
-  'monitor',
-]
-if have_user
-  trace_events_subdirs +=3D [ 'linux-user' ]
-endif
-if have_block
-  trace_events_subdirs +=3D [
-    'authz',
-    'block',
-    'io',
-    'nbd',
-    'scsi',
-  ]
-endif
-if have_system
-  trace_events_subdirs +=3D [
-    'audio',
-    'backends',
-    'backends/tpm',
-    'chardev',
-    'hw/9pfs',
-    'hw/acpi',
-    'hw/alpha',
-    'hw/arm',
-    'hw/audio',
-    'hw/block',
-    'hw/block/dataplane',
-    'hw/char',
-    'hw/display',
-    'hw/dma',
-    'hw/hppa',
-    'hw/hyperv',
-    'hw/i2c',
-    'hw/i386',
-    'hw/i386/xen',
-    'hw/ide',
-    'hw/input',
-    'hw/intc',
-    'hw/isa',
-    'hw/mem',
-    'hw/mips',
-    'hw/misc',
-    'hw/misc/macio',
-    'hw/net',
-    'hw/nvram',
-    'hw/pci',
-    'hw/pci-host',
-    'hw/ppc',
-    'hw/rdma',
-    'hw/rdma/vmw',
-    'hw/rtc',
-    'hw/s390x',
-    'hw/scsi',
-    'hw/sd',
-    'hw/sparc',
-    'hw/sparc64',
-    'hw/ssi',
-    'hw/timer',
-    'hw/tpm',
-    'hw/usb',
-    'hw/vfio',
-    'hw/virtio',
-    'hw/watchdog',
-    'hw/xen',
-    'hw/gpio',
-    'hw/riscv',
-    'migration',
-    'net',
-    'ui',
-  ]
-endif
-trace_events_subdirs +=3D [
-  'hw/core',
-  'qapi',
-  'qom',
-  'target/arm',
-  'target/hppa',
-  'target/i386',
-  'target/mips',
-  'target/ppc',
-  'target/riscv',
-  'target/s390x',
-  'target/sparc',
-  'util',
-]
-
-subdir('qapi')
-subdir('qobject')
-subdir('stubs')
-subdir('trace')
-subdir('util')
-subdir('qom')
-subdir('authz')
-subdir('crypto')
-subdir('ui')
-
-
-if enable_modules
-  libmodulecommon =3D static_library('module-common', files('module-common=
.c') + genh, pic: true, c_args: '-DBUILD_DSO')
-  modulecommon =3D declare_dependency(link_whole: libmodulecommon, compile=
_args: '-DBUILD_DSO')
-endif
-
-# Build targets from sourcesets
-
-stub_ss =3D stub_ss.apply(config_all, strict: false)
-
-util_ss.add_all(trace_ss)
-util_ss =3D util_ss.apply(config_all, strict: false)
-libqemuutil =3D static_library('qemuutil',
-                             sources: util_ss.sources() + stub_ss.sources(=
) + genh,
-                             dependencies: [util_ss.dependencies(), m, gli=
b, socket])
-qemuutil =3D declare_dependency(link_with: libqemuutil,
-                              sources: genh + version_res)
-
-decodetree =3D generator(find_program('scripts/decodetree.py'),
-                       output: 'decode-@BASENAME@.c.inc',
-                       arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@OUTP=
UT@'])
-
-subdir('audio')
-subdir('io')
-subdir('chardev')
-subdir('fsdev')
-subdir('libdecnumber')
-subdir('target')
-subdir('dump')
-
-block_ss.add(files(
-  'block.c',
-  'blockjob.c',
-  'job.c',
-  'qemu-io-cmds.c',
-))
-block_ss.add(when: 'CONFIG_REPLICATION', if_true: files('replication.c'))
-
-subdir('nbd')
-subdir('scsi')
-subdir('block')
-
-blockdev_ss.add(files(
-  'blockdev.c',
-  'blockdev-nbd.c',
-  'iothread.c',
-  'job-qmp.c',
-))
-
-# os-posix.c contains POSIX-specific functions used by qemu-storage-daemon,
-# os-win32.c does not
-blockdev_ss.add(when: 'CONFIG_POSIX', if_true: files('os-posix.c'))
-softmmu_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c')])
-
-softmmu_ss.add_all(blockdev_ss)
-softmmu_ss.add(files(
-  'bootdevice.c',
-  'dma-helpers.c',
-  'qdev-monitor.c',
-), sdl)
-
-softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
-softmmu_ss.add(when: 'CONFIG_SECCOMP', if_true: [files('qemu-seccomp.c'), =
seccomp])
-softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c'=
)])
-
-common_ss.add(files('cpus-common.c'))
-
-subdir('softmmu')
-
-specific_ss.add(files('disas.c', 'exec.c', 'gdbstub.c'), capstone, libpmem=
, libdaxctl)
-specific_ss.add(files('exec-vary.c'))
-specific_ss.add(when: 'CONFIG_TCG', if_true: files(
-  'fpu/softfloat.c',
-  'tcg/optimize.c',
-  'tcg/tcg-common.c',
-  'tcg/tcg-op-gvec.c',
-  'tcg/tcg-op-vec.c',
-  'tcg/tcg-op.c',
-  'tcg/tcg.c',
-))
-specific_ss.add(when: 'CONFIG_TCG_INTERPRETER', if_true: files('disas/tci.=
c', 'tcg/tci.c'))
-
-subdir('backends')
-subdir('disas')
-subdir('migration')
-subdir('monitor')
-subdir('net')
-subdir('replay')
-subdir('hw')
-subdir('accel')
-subdir('plugins')
-subdir('bsd-user')
-subdir('linux-user')
-
-bsd_user_ss.add(files('gdbstub.c'))
-specific_ss.add_all(when: 'CONFIG_BSD_USER', if_true: bsd_user_ss)
-
-linux_user_ss.add(files('gdbstub.c', 'thunk.c'))
-specific_ss.add_all(when: 'CONFIG_LINUX_USER', if_true: linux_user_ss)
-
-# needed for fuzzing binaries
-subdir('tests/qtest/libqos')
-subdir('tests/qtest/fuzz')
-
-block_mods =3D []
-softmmu_mods =3D []
-foreach d, list : modules
-  foreach m, module_ss : list
-    if enable_modules and targetos !=3D 'windows'
-      module_ss =3D module_ss.apply(config_host, strict: false)
-      sl =3D static_library(d + '-' + m, [genh, module_ss.sources()],
-                          dependencies: [modulecommon, module_ss.dependenc=
ies()], pic: true)
-      if d =3D=3D 'block'
-        block_mods +=3D sl
-      else
-        softmmu_mods +=3D sl
-      endif
-    else
-      if d =3D=3D 'block'
-        block_ss.add_all(module_ss)
-      else
-        softmmu_ss.add_all(module_ss)
-      endif
-    endif
-  endforeach
-endforeach
-
-nm =3D find_program('nm')
-undefsym =3D find_program('scripts/undefsym.sh')
-block_syms =3D custom_target('block.syms', output: 'block.syms',
-                             input: [libqemuutil, block_mods],
-                             capture: true,
-                             command: [undefsym, nm, '@INPUT@'])
-qemu_syms =3D custom_target('qemu.syms', output: 'qemu.syms',
-                             input: [libqemuutil, softmmu_mods],
-                             capture: true,
-                             command: [undefsym, nm, '@INPUT@'])
-
-block_ss =3D block_ss.apply(config_host, strict: false)
-libblock =3D static_library('block', block_ss.sources() + genh,
-                          dependencies: block_ss.dependencies(),
-                          link_depends: block_syms,
-                          name_suffix: 'fa',
-                          build_by_default: false)
-
-block =3D declare_dependency(link_whole: [libblock],
-                           link_args: '@block.syms',
-                           dependencies: [crypto, io])
-
-qmp_ss =3D qmp_ss.apply(config_host, strict: false)
-libqmp =3D static_library('qmp', qmp_ss.sources() + genh,
-                        dependencies: qmp_ss.dependencies(),
-                        name_suffix: 'fa',
-                        build_by_default: false)
-
-qmp =3D declare_dependency(link_whole: [libqmp])
-
-foreach m : block_mods + softmmu_mods
-  shared_module(m.name(),
-                name_prefix: '',
-                link_whole: m,
-                install: true,
-                install_dir: config_host['qemu_moddir'])
-endforeach
-
-softmmu_ss.add(authz, block, chardev, crypto, io, qmp)
-common_ss.add(qom, qemuutil)
-
-common_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: [softmmu_ss])
-common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
-
-common_all =3D common_ss.apply(config_all, strict: false)
-common_all =3D static_library('common',
-                            build_by_default: false,
-                            sources: common_all.sources() + genh,
-                            dependencies: common_all.dependencies(),
-                            name_suffix: 'fa')
-
-feature_to_c =3D find_program('scripts/feature_to_c.sh')
-
-emulators =3D []
-foreach target : target_dirs
-  config_target =3D config_target_mak[target]
-  target_name =3D config_target['TARGET_NAME']
-  arch =3D config_target['TARGET_BASE_ARCH']
-  arch_srcs =3D [config_target_h[target]]
-  arch_deps =3D []
-  c_args =3D ['-DNEED_CPU_H',
-            '-DCONFIG_TARGET=3D"@0@-config-target.h"'.format(target),
-            '-DCONFIG_DEVICES=3D"@0@-config-devices.h"'.format(target)]
-  link_args =3D []
-
-  config_target +=3D config_host
-  target_inc =3D [include_directories('target' / config_target['TARGET_BAS=
E_ARCH'])]
-  if targetos =3D=3D 'linux'
-    target_inc +=3D include_directories('linux-headers', is_system: true)
-  endif
-  if target.endswith('-softmmu')
-    qemu_target_name =3D 'qemu-system-' + target_name
-    target_type=3D'system'
-    t =3D target_softmmu_arch[arch].apply(config_target, strict: false)
-    arch_srcs +=3D t.sources()
-    arch_deps +=3D t.dependencies()
-
-    hw_dir =3D target_name =3D=3D 'sparc64' ? 'sparc64' : arch
-    hw =3D hw_arch[hw_dir].apply(config_target, strict: false)
-    arch_srcs +=3D hw.sources()
-    arch_deps +=3D hw.dependencies()
-
-    arch_srcs +=3D config_devices_h[target]
-    link_args +=3D ['@block.syms', '@qemu.syms']
-  else
-    abi =3D config_target['TARGET_ABI_DIR']
-    target_type=3D'user'
-    qemu_target_name =3D 'qemu-' + target_name
-    if 'CONFIG_LINUX_USER' in config_target
-      base_dir =3D 'linux-user'
-      target_inc +=3D include_directories('linux-user/host/' / config_host=
['ARCH'])
-    else
-      base_dir =3D 'bsd-user'
-    endif
-    target_inc +=3D include_directories(
-      base_dir,
-      base_dir / abi,
-    )
-    if 'CONFIG_LINUX_USER' in config_target
-      dir =3D base_dir / abi
-      arch_srcs +=3D files(dir / 'signal.c', dir / 'cpu_loop.c')
-      if config_target.has_key('TARGET_SYSTBL_ABI')
-        arch_srcs +=3D \
-          syscall_nr_generators[abi].process(base_dir / abi / config_targe=
t['TARGET_SYSTBL'],
-                                             extra_args : config_target['T=
ARGET_SYSTBL_ABI'])
-      endif
-    endif
-  endif
-
-  if 'TARGET_XML_FILES' in config_target
-    gdbstub_xml =3D custom_target(target + '-gdbstub-xml.c',
-                                output: target + '-gdbstub-xml.c',
-                                input: files(config_target['TARGET_XML_FIL=
ES'].split()),
-                                command: [feature_to_c, '@INPUT@'],
-                                capture: true)
-    arch_srcs +=3D gdbstub_xml
-  endif
-
-  t =3D target_arch[arch].apply(config_target, strict: false)
-  arch_srcs +=3D t.sources()
-  arch_deps +=3D t.dependencies()
-
-  target_common =3D common_ss.apply(config_target, strict: false)
-  objects =3D common_all.extract_objects(target_common.sources())
-  deps =3D target_common.dependencies()
-
-  target_specific =3D specific_ss.apply(config_target, strict: false)
-  arch_srcs +=3D target_specific.sources()
-  arch_deps +=3D target_specific.dependencies()
-
-  lib =3D static_library('qemu-' + target,
-                 sources: arch_srcs + genh,
-                 dependencies: arch_deps,
-                 objects: objects,
-                 include_directories: target_inc,
-                 c_args: c_args,
-                 build_by_default: false,
-                 name_suffix: 'fa')
-
-  if target.endswith('-softmmu')
-    execs =3D [{
-      'name': 'qemu-system-' + target_name,
-      'gui': false,
-      'sources': files('softmmu/main.c'),
-      'dependencies': []
-    }]
-    if targetos =3D=3D 'windows' and (sdl.found() or gtk.found())
-      execs +=3D [{
-        'name': 'qemu-system-' + target_name + 'w',
-        'gui': true,
-        'sources': files('softmmu/main.c'),
-        'dependencies': []
-      }]
-    endif
-    if config_host.has_key('CONFIG_FUZZ')
-      specific_fuzz =3D specific_fuzz_ss.apply(config_target, strict: fals=
e)
-      execs +=3D [{
-        'name': 'qemu-fuzz-' + target_name,
-        'gui': false,
-        'sources': specific_fuzz.sources(),
-        'dependencies': specific_fuzz.dependencies(),
-        'link_depends': [files('tests/qtest/fuzz/fork_fuzz.ld')],
-      }]
-    endif
-  else
-    execs =3D [{
-      'name': 'qemu-' + target_name,
-      'gui': false,
-      'sources': [],
-      'dependencies': []
-    }]
-  endif
-  foreach exe: execs
-    emulators +=3D executable(exe['name'], exe['sources'],
-               install: true,
-               c_args: c_args,
-               dependencies: arch_deps + deps + exe['dependencies'],
-               objects: lib.extract_all_objects(recursive: true),
-               link_language: link_language,
-               link_depends: [block_syms, qemu_syms] + exe.get('link_depen=
ds', []),
-               link_args: link_args,
-               gui_app: exe['gui'])
-
-    if 'CONFIG_TRACE_SYSTEMTAP' in config_host
-      foreach stp: [
-        {'ext': '.stp-build', 'fmt': 'stap', 'bin': meson.current_build_di=
r() / exe['name'], 'install': false},
-        {'ext': '.stp', 'fmt': 'stap', 'bin': get_option('prefix') / get_o=
ption('bindir') / exe['name'], 'install': true},
-        {'ext': '-simpletrace.stp', 'fmt': 'simpletrace-stap', 'bin': '', =
'install': true},
-        {'ext': '-log.stp', 'fmt': 'log-stap', 'bin': '', 'install': true},
-      ]
-        custom_target(exe['name'] + stp['ext'],
-                      input: trace_events_all,
-                      output: exe['name'] + stp['ext'],
-                      capture: true,
-                      install: stp['install'],
-                      install_dir: qemu_datadir / '../systemtap/tapset',
-                      command: [
-                        tracetool, '--group=3Dall', '--format=3D' + stp['f=
mt'],
-                        '--binary=3D' + stp['bin'],
-                        '--target-name=3D' + target_name,
-                        '--target-type=3D' + target_type,
-                        '--probe-prefix=3Dqemu.' + target_type + '.' + tar=
get_name,
-                        '@INPUT@',
-                      ])
-      endforeach
-    endif
-  endforeach
-endforeach
-
-# Other build targets
-
-if 'CONFIG_PLUGIN' in config_host
-  install_headers('include/qemu/qemu-plugin.h')
-endif
-
-if 'CONFIG_GUEST_AGENT' in config_host
-  subdir('qga')
-endif
-
-# Don't build qemu-keymap if xkbcommon is not explicitly enabled
-# when we don't build tools or system
-if xkbcommon.found()
-  # used for the update-keymaps target, so include rules even if !have_too=
ls
-  qemu_keymap =3D executable('qemu-keymap', files('qemu-keymap.c', 'ui/inp=
ut-keymap.c') + genh,
-                           dependencies: [qemuutil, xkbcommon], install: h=
ave_tools)
-endif
-
-qemu_block_tools =3D []
-if have_tools
-  qemu_img =3D executable('qemu-img', [files('qemu-img.c'), hxdep],
-             dependencies: [authz, block, crypto, io, qom, qemuutil], inst=
all: true)
-  qemu_io =3D executable('qemu-io', files('qemu-io.c'),
-             dependencies: [block, qemuutil], install: true)
-  qemu_block_tools +=3D [qemu_img, qemu_io]
-  if targetos !=3D 'windows'
-    qemu_nbd =3D executable('qemu-nbd', files('qemu-nbd.c'),
-               dependencies: [block, qemuutil], install: true)
-    qemu_block_tools +=3D [qemu_nbd]
-  endif
-
-  subdir('storage-daemon')
-  subdir('contrib/rdmacm-mux')
-  subdir('contrib/elf2dmp')
-
-  executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c=
'),
-             dependencies: qemuutil,
-             install: true)
-
-  if 'CONFIG_VHOST_USER' in config_host
-    subdir('contrib/libvhost-user')
-    subdir('contrib/vhost-user-blk')
-    subdir('contrib/vhost-user-gpu')
-    subdir('contrib/vhost-user-input')
-    subdir('contrib/vhost-user-scsi')
-  endif
-
-  if targetos =3D=3D 'linux'
-    executable('qemu-bridge-helper', files('qemu-bridge-helper.c'),
-               dependencies: [qemuutil, libcap_ng],
-               install: true,
-               install_dir: get_option('libexecdir'))
-
-    executable('qemu-pr-helper', files('scsi/qemu-pr-helper.c', 'scsi/util=
s.c'),
-               dependencies: [authz, crypto, io, qom, qemuutil,
-                              libcap_ng, libudev, libmpathpersist],
-               install: true)
-  endif
-
-  if 'CONFIG_IVSHMEM' in config_host
-    subdir('contrib/ivshmem-client')
-    subdir('contrib/ivshmem-server')
-  endif
-endif
-
-subdir('scripts')
-subdir('tools')
-subdir('pc-bios')
-subdir('tests')
-subdir('docs')
-if 'CONFIG_GTK' in config_host
-  subdir('po')
-endif
-
-if build_docs
-  makeinfo =3D find_program('makeinfo', required: build_docs)
-
-  docs_inc =3D [
-    '-I', meson.current_source_dir(),
-    '-I', meson.current_build_dir() / 'docs',
-    '-I', '@OUTDIR@',
-  ]
-
-  version_texi =3D configure_file(output: 'version.texi',
-                              input: 'version.texi.in',
-                              configuration: {'VERSION': meson.project_ver=
sion(),
-                                              'qemu_confdir': config_host[=
'qemu_confdir']})
-
-  texi =3D {
-    'qemu-qmp-ref': ['docs/interop/qemu-qmp-ref.texi', qapi_doc_texi, vers=
ion_texi],
-  }
-  if 'CONFIG_GUEST_AGENT' in config_host
-    texi +=3D {'qemu-ga-ref': ['docs/interop/qemu-ga-ref.texi', qga_qapi_d=
oc_texi, version_texi]}
-  endif
-
-  if makeinfo.found()
-    cmd =3D [
-      'env', 'LC_ALL=3DC', makeinfo, '--no-split', '--number-sections', do=
cs_inc,
-      '@INPUT0@', '-o', '@OUTPUT@',
-    ]
-    foreach ext, args: {
-        'info': [],
-        'html': ['--no-headers', '--html'],
-        'txt': ['--no-headers', '--plaintext'],
-    }
-      t =3D []
-      foreach doc, input: texi
-        output =3D doc + '.' + ext
-        t +=3D custom_target(output,
-                      input: input,
-                      output: output,
-                      install: true,
-                      install_dir: qemu_docdir / 'interop',
-                      command: cmd + args)
-      endforeach
-      alias_target(ext, t)
-    endforeach
-  endif
-
-  texi2pdf =3D find_program('texi2pdf', required: false)
-
-  if texi2pdf.found()
-    pdfs =3D []
-    foreach doc, input: texi
-      output =3D doc + '.pdf'
-      pdfs +=3D custom_target(output,
-                    input: input,
-                    output: output,
-                    command: [texi2pdf, '-q', docs_inc, '@INPUT0@', '-o', =
'@OUTPUT@'],
-                    build_by_default: false)
-    endforeach
-    alias_target('pdf', pdfs)
-  endif
-
-  texi2pod =3D find_program('scripts/texi2pod.pl')
-  pod2man =3D find_program('pod2man', required: build_docs)
-
-  if pod2man.found()
-    foreach doc, input: texi
-      man =3D doc + '.7'
-      pod =3D custom_target(man + '.pod',
-                          input: input,
-                          output: man + '.pod',
-                          command: [texi2pod,
-                                    '-DVERSION=3D"' + meson.project_versio=
n() + '"',
-                                    '-DCONFDIR=3D"' + config_host['qemu_co=
nfdir'] + '"',
-                                    '@INPUT0@', '@OUTPUT@'])
-      man =3D custom_target(man,
-                          input: pod,
-                          output: man,
-                          capture: true,
-                          install: true,
-                          install_dir: get_option('mandir') / 'man7',
-                          command: [pod2man, '--utf8', '--section=3D7', '-=
-center=3D" "',
-                                    '--release=3D" "', '@INPUT@'])
-    endforeach
-  endif
-endif
-
-if host_machine.system() =3D=3D 'windows'
-  nsis_cmd =3D [
-    find_program('scripts/nsis.py'),
-    '@OUTPUT@',
-    get_option('prefix'),
-    meson.current_source_dir(),
-    host_machine.cpu_family(),
-    '--',
-    '-DDISPLAYVERSION=3D' + meson.project_version(),
-  ]
-  if build_docs
-    nsis_cmd +=3D '-DCONFIG_DOCUMENTATION=3Dy'
-  endif
-  if 'CONFIG_GTK' in config_host
-    nsis_cmd +=3D '-DCONFIG_GTK=3Dy'
-  endif
-
-  nsis =3D custom_target('nsis',
-                       output: 'qemu-setup-' + meson.project_version() + '=
.exe',
-                       input: files('qemu.nsi'),
-                       build_always_stale: true,
-                       command: nsis_cmd + ['@INPUT@'])
-  alias_target('installer', nsis)
-endif
-
-summary_info =3D {}
-summary_info +=3D {'Install prefix':    config_host['prefix']}
-summary_info +=3D {'BIOS directory':    config_host['qemu_datadir']}
-summary_info +=3D {'firmware path':     config_host['qemu_firmwarepath']}
-summary_info +=3D {'binary directory':  config_host['bindir']}
-summary_info +=3D {'library directory': config_host['libdir']}
-summary_info +=3D {'module directory':  config_host['qemu_moddir']}
-summary_info +=3D {'libexec directory': config_host['libexecdir']}
-summary_info +=3D {'include directory': config_host['includedir']}
-summary_info +=3D {'config directory':  config_host['sysconfdir']}
-if targetos !=3D 'windows'
-  summary_info +=3D {'local state directory': config_host['qemu_localstate=
dir']}
-  summary_info +=3D {'Manual directory':      get_option('mandir')}
-else
-  summary_info +=3D {'local state directory': 'queried at runtime'}
-endif
-summary_info +=3D {'Doc directory':     get_option('docdir')}
-summary_info +=3D {'Build directory':   meson.current_build_dir()}
-summary_info +=3D {'Source path':       meson.current_source_dir()}
-summary_info +=3D {'GIT binary':        config_host['GIT']}
-summary_info +=3D {'GIT submodules':    config_host['GIT_SUBMODULES']}
-summary_info +=3D {'C compiler':        meson.get_compiler('c').cmd_array(=
)[0]}
-summary_info +=3D {'Host C compiler':   meson.get_compiler('c', native: tr=
ue).cmd_array()[0]}
-if link_language =3D=3D 'cpp'
-  summary_info +=3D {'C++ compiler':      meson.get_compiler('cpp').cmd_ar=
ray()[0]}
-else
-  summary_info +=3D {'C++ compiler':      false}
-endif
-if targetos =3D=3D 'darwin'
-  summary_info +=3D {'Objective-C compiler': meson.get_compiler('objc').cm=
d_array()[0]}
-endif
-summary_info +=3D {'ARFLAGS':           config_host['ARFLAGS']}
-summary_info +=3D {'CFLAGS':            config_host['CFLAGS']}
-summary_info +=3D {'QEMU_CFLAGS':       config_host['QEMU_CFLAGS']}
-summary_info +=3D {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
-summary_info +=3D {'make':              config_host['MAKE']}
-summary_info +=3D {'install':           config_host['INSTALL']}
-summary_info +=3D {'python':            '@0@ (version: @1@)'.format(python=
.full_path(), python.language_version())}
-summary_info +=3D {'sphinx-build':      config_host['SPHINX_BUILD']}
-summary_info +=3D {'genisoimage':       config_host['GENISOIMAGE']}
-# TODO: add back version
-summary_info +=3D {'slirp support':     config_host.has_key('CONFIG_SLIRP'=
)}
-if config_host.has_key('CONFIG_SLIRP')
-  summary_info +=3D {'smbd':            config_host['CONFIG_SMBD_COMMAND']}
-endif
-summary_info +=3D {'module support':    config_host.has_key('CONFIG_MODULE=
S')}
-if config_host.has_key('CONFIG_MODULES')
-  summary_info +=3D {'alternative module path': config_host.has_key('CONFI=
G_MODULE_UPGRADES')}
-endif
-summary_info +=3D {'host CPU':          cpu}
-summary_info +=3D {'host endianness':   build_machine.endian()}
-summary_info +=3D {'target list':       config_host['TARGET_DIRS']}
-summary_info +=3D {'gprof enabled':     config_host.has_key('CONFIG_GPROF'=
)}
-summary_info +=3D {'sparse enabled':    meson.get_compiler('c').cmd_array(=
).contains('cgcc')}
-summary_info +=3D {'strip binaries':    get_option('strip')}
-summary_info +=3D {'profiler':          config_host.has_key('CONFIG_PROFIL=
ER')}
-summary_info +=3D {'static build':      config_host.has_key('CONFIG_TOOLS'=
)}
-if targetos =3D=3D 'darwin'
-  summary_info +=3D {'Cocoa support': config_host.has_key('CONFIG_COCOA')}
-endif
-# TODO: add back version
-summary_info +=3D {'SDL support':       sdl.found()}
-summary_info +=3D {'SDL image support': sdl_image.found()}
-# TODO: add back version
-summary_info +=3D {'GTK support':       config_host.has_key('CONFIG_GTK')}
-summary_info +=3D {'GTK GL support':    config_host.has_key('CONFIG_GTK_GL=
')}
-summary_info +=3D {'pixman':            pixman.found()}
-# TODO: add back version
-summary_info +=3D {'VTE support':       config_host.has_key('CONFIG_VTE')}
-summary_info +=3D {'TLS priority':      config_host['CONFIG_TLS_PRIORITY']}
-summary_info +=3D {'GNUTLS support':    config_host.has_key('CONFIG_GNUTLS=
')}
-# TODO: add back version
-summary_info +=3D {'libgcrypt':         config_host.has_key('CONFIG_GCRYPT=
')}
-if config_host.has_key('CONFIG_GCRYPT')
-   summary_info +=3D {'  hmac':            config_host.has_key('CONFIG_GCR=
YPT_HMAC')}
-   summary_info +=3D {'  XTS':             not config_host.has_key('CONFIG=
_QEMU_PRIVATE_XTS')}
-endif
-# TODO: add back version
-summary_info +=3D {'nettle':            config_host.has_key('CONFIG_NETTLE=
')}
-if config_host.has_key('CONFIG_NETTLE')
-   summary_info +=3D {'  XTS':             not config_host.has_key('CONFIG=
_QEMU_PRIVATE_XTS')}
-endif
-summary_info +=3D {'libtasn1':          config_host.has_key('CONFIG_TASN1'=
)}
-summary_info +=3D {'PAM':               config_host.has_key('CONFIG_AUTH_P=
AM')}
-summary_info +=3D {'iconv support':     config_host.has_key('CONFIG_ICONV'=
)}
-summary_info +=3D {'curses support':    config_host.has_key('CONFIG_CURSES=
')}
-# TODO: add back version
-summary_info +=3D {'virgl support':     config_host.has_key('CONFIG_VIRGL'=
)}
-summary_info +=3D {'curl support':      config_host.has_key('CONFIG_CURL')}
-summary_info +=3D {'mingw32 support':   targetos =3D=3D 'windows'}
-summary_info +=3D {'Audio drivers':     config_host['CONFIG_AUDIO_DRIVERS'=
]}
-summary_info +=3D {'Block whitelist (rw)': config_host['CONFIG_BDRV_RW_WHI=
TELIST']}
-summary_info +=3D {'Block whitelist (ro)': config_host['CONFIG_BDRV_RO_WHI=
TELIST']}
-summary_info +=3D {'VirtFS support':    config_host.has_key('CONFIG_VIRTFS=
')}
-summary_info +=3D {'Multipath support': config_host.has_key('CONFIG_MPATH'=
)}
-summary_info +=3D {'VNC support':       vnc.found()}
-if vnc.found()
-  summary_info +=3D {'VNC SASL support':  sasl.found()}
-  summary_info +=3D {'VNC JPEG support':  jpeg.found()}
-  summary_info +=3D {'VNC PNG support':   png.found()}
-endif
-summary_info +=3D {'xen support':       config_host.has_key('CONFIG_XEN_BA=
CKEND')}
-if config_host.has_key('CONFIG_XEN_BACKEND')
-  summary_info +=3D {'xen ctrl version':  config_host['CONFIG_XEN_CTRL_INT=
ERFACE_VERSION']}
-endif
-summary_info +=3D {'brlapi support':    config_host.has_key('CONFIG_BRLAPI=
')}
-summary_info +=3D {'Documentation':     config_host.has_key('BUILD_DOCS')}
-summary_info +=3D {'PIE':               get_option('b_pie')}
-summary_info +=3D {'vde support':       config_host.has_key('CONFIG_VDE')}
-summary_info +=3D {'netmap support':    config_host.has_key('CONFIG_NETMAP=
')}
-summary_info +=3D {'Linux AIO support': config_host.has_key('CONFIG_LINUX_=
AIO')}
-summary_info +=3D {'Linux io_uring support': config_host.has_key('CONFIG_L=
INUX_IO_URING')}
-summary_info +=3D {'ATTR/XATTR support': config_host.has_key('CONFIG_ATTR'=
)}
-summary_info +=3D {'Install blobs':     config_host.has_key('INSTALL_BLOBS=
')}
-# TODO: add back KVM/HAX/HVF/WHPX/TCG
-#summary_info +=3D {'KVM support':       have_kvm'}
-#summary_info +=3D {'HAX support':       have_hax'}
-#summary_info +=3D {'HVF support':       have_hvf'}
-#summary_info +=3D {'WHPX support':      have_whpx'}
-#summary_info +=3D {'TCG support':       have_tcg'}
-#if get_option('tcg')
-#  summary_info +=3D {'TCG debug enabled': config_host.has_key('CONFIG_DEB=
UG_TCG')}
-#  summary_info +=3D {'TCG interpreter':   config_host.has_key('CONFIG_TCG=
_INTERPRETER')}
-#endif
-summary_info +=3D {'malloc trim support': config_host.has_key('CONFIG_MALL=
OC_TRIM')}
-summary_info +=3D {'RDMA support':      config_host.has_key('CONFIG_RDMA')}
-summary_info +=3D {'PVRDMA support':    config_host.has_key('CONFIG_PVRDMA=
')}
-summary_info +=3D {'fdt support':       config_host.has_key('CONFIG_FDT')}
-summary_info +=3D {'membarrier':        config_host.has_key('CONFIG_MEMBAR=
RIER')}
-summary_info +=3D {'preadv support':    config_host.has_key('CONFIG_PREADV=
')}
-summary_info +=3D {'fdatasync':         config_host.has_key('CONFIG_FDATAS=
YNC')}
-summary_info +=3D {'madvise':           config_host.has_key('CONFIG_MADVIS=
E')}
-summary_info +=3D {'posix_madvise':     config_host.has_key('CONFIG_POSIX_=
MADVISE')}
-summary_info +=3D {'posix_memalign':    config_host.has_key('CONFIG_POSIX_=
MEMALIGN')}
-summary_info +=3D {'libcap-ng support': config_host.has_key('CONFIG_LIBCAP=
_NG')}
-summary_info +=3D {'vhost-net support': config_host.has_key('CONFIG_VHOST_=
NET')}
-summary_info +=3D {'vhost-crypto support': config_host.has_key('CONFIG_VHO=
ST_CRYPTO')}
-summary_info +=3D {'vhost-scsi support': config_host.has_key('CONFIG_VHOST=
_SCSI')}
-summary_info +=3D {'vhost-vsock support': config_host.has_key('CONFIG_VHOS=
T_VSOCK')}
-summary_info +=3D {'vhost-user support': config_host.has_key('CONFIG_VHOST=
_KERNEL')}
-summary_info +=3D {'vhost-user-fs support': config_host.has_key('CONFIG_VH=
OST_USER_FS')}
-summary_info +=3D {'vhost-vdpa support': config_host.has_key('CONFIG_VHOST=
_VDPA')}
-summary_info +=3D {'Trace backends':    config_host['TRACE_BACKENDS']}
-if config_host['TRACE_BACKENDS'].split().contains('simple')
-  summary_info +=3D {'Trace output file': config_host['CONFIG_TRACE_FILE']=
 + '-<pid>'}
-endif
-# TODO: add back protocol and server version
-summary_info +=3D {'spice support':     config_host.has_key('CONFIG_SPICE'=
)}
-summary_info +=3D {'rbd support':       config_host.has_key('CONFIG_RBD')}
-summary_info +=3D {'xfsctl support':    config_host.has_key('CONFIG_XFS')}
-summary_info +=3D {'smartcard support': config_host.has_key('CONFIG_SMARTC=
ARD')}
-summary_info +=3D {'U2F support':       u2f.found()}
-summary_info +=3D {'libusb':            config_host.has_key('CONFIG_USB_LI=
BUSB')}
-summary_info +=3D {'usb net redir':     config_host.has_key('CONFIG_USB_RE=
DIR')}
-summary_info +=3D {'OpenGL support':    config_host.has_key('CONFIG_OPENGL=
')}
-summary_info +=3D {'OpenGL dmabufs':    config_host.has_key('CONFIG_OPENGL=
_DMABUF')}
-summary_info +=3D {'libiscsi support':  config_host.has_key('CONFIG_LIBISC=
SI')}
-summary_info +=3D {'libnfs support':    config_host.has_key('CONFIG_LIBNFS=
')}
-summary_info +=3D {'build guest agent': config_host.has_key('CONFIG_GUEST_=
AGENT')}
-if targetos =3D=3D 'windows'
-  if 'WIN_SDK' in config_host
-    summary_info +=3D {'Windows SDK':       config_host['WIN_SDK']}
-  endif
-  summary_info +=3D {'QGA VSS support':   config_host.has_key('CONFIG_QGA_=
VSS')}
-  summary_info +=3D {'QGA w32 disk info': config_host.has_key('CONFIG_QGA_=
NTDDSCSI')}
-  summary_info +=3D {'QGA MSI support':   config_host.has_key('CONFIG_QGA_=
MSI_ENABLED')}
-endif
-summary_info +=3D {'seccomp support':   config_host.has_key('CONFIG_SECCOM=
P')}
-summary_info +=3D {'coroutine backend': config_host['CONFIG_COROUTINE_BACK=
END']}
-summary_info +=3D {'coroutine pool':    config_host['CONFIG_COROUTINE_POOL=
'] =3D=3D '1'}
-summary_info +=3D {'debug stack usage': config_host.has_key('CONFIG_DEBUG_=
STACK_USAGE')}
-summary_info +=3D {'mutex debugging':   config_host.has_key('CONFIG_DEBUG_=
MUTEX')}
-summary_info +=3D {'crypto afalg':      config_host.has_key('CONFIG_AF_ALG=
')}
-summary_info +=3D {'GlusterFS support': config_host.has_key('CONFIG_GLUSTE=
RFS')}
-summary_info +=3D {'gcov':              get_option('b_coverage')}
-summary_info +=3D {'TPM support':       config_host.has_key('CONFIG_TPM')}
-summary_info +=3D {'libssh support':    config_host.has_key('CONFIG_LIBSSH=
')}
-summary_info +=3D {'QOM debugging':     config_host.has_key('CONFIG_QOM_CA=
ST_DEBUG')}
-summary_info +=3D {'Live block migration': config_host.has_key('CONFIG_LIV=
E_BLOCK_MIGRATION')}
-summary_info +=3D {'lzo support':       config_host.has_key('CONFIG_LZO')}
-summary_info +=3D {'snappy support':    config_host.has_key('CONFIG_SNAPPY=
')}
-summary_info +=3D {'bzip2 support':     config_host.has_key('CONFIG_BZIP2'=
)}
-summary_info +=3D {'lzfse support':     config_host.has_key('CONFIG_LZFSE'=
)}
-summary_info +=3D {'zstd support':      config_host.has_key('CONFIG_ZSTD')}
-summary_info +=3D {'NUMA host support': config_host.has_key('CONFIG_NUMA')}
-summary_info +=3D {'libxml2':           config_host.has_key('CONFIG_LIBXML=
2')}
-summary_info +=3D {'tcmalloc support':  config_host.has_key('CONFIG_TCMALL=
OC')}
-summary_info +=3D {'jemalloc support':  config_host.has_key('CONFIG_JEMALL=
OC')}
-summary_info +=3D {'avx2 optimization': config_host.has_key('CONFIG_AVX2_O=
PT')}
-summary_info +=3D {'avx512f optimization': config_host.has_key('CONFIG_AVX=
512F_OPT')}
-summary_info +=3D {'replication support': config_host.has_key('CONFIG_REPL=
ICATION')}
-summary_info +=3D {'bochs support':     config_host.has_key('CONFIG_BOCHS'=
)}
-summary_info +=3D {'cloop support':     config_host.has_key('CONFIG_CLOOP'=
)}
-summary_info +=3D {'dmg support':       config_host.has_key('CONFIG_DMG')}
-summary_info +=3D {'qcow v1 support':   config_host.has_key('CONFIG_QCOW1'=
)}
-summary_info +=3D {'vdi support':       config_host.has_key('CONFIG_VDI')}
-summary_info +=3D {'vvfat support':     config_host.has_key('CONFIG_VVFAT'=
)}
-summary_info +=3D {'qed support':       config_host.has_key('CONFIG_QED')}
-summary_info +=3D {'parallels support': config_host.has_key('CONFIG_PARALL=
ELS')}
-summary_info +=3D {'sheepdog support':  config_host.has_key('CONFIG_SHEEPD=
OG')}
-summary_info +=3D {'capstone':          config_host.has_key('CONFIG_CAPSTO=
NE')}
-summary_info +=3D {'libpmem support':   config_host.has_key('CONFIG_LIBPME=
M')}
-summary_info +=3D {'libdaxctl support': config_host.has_key('CONFIG_LIBDAX=
CTL')}
-summary_info +=3D {'libudev':           config_host.has_key('CONFIG_LIBUDE=
V')}
-summary_info +=3D {'default devices':   config_host['CONFIG_MINIKCONF_MODE=
'] =3D=3D '--defconfig'}
-summary_info +=3D {'plugin support':    config_host.has_key('CONFIG_PLUGIN=
')}
-summary_info +=3D {'fuzzing support':   config_host.has_key('CONFIG_FUZZ')}
-if config_host.has_key('HAVE_GDB_BIN')
-  summary_info +=3D {'gdb':             config_host['HAVE_GDB_BIN']}
-endif
-summary_info +=3D {'thread sanitizer':  config_host.has_key('CONFIG_TSAN')}
-summary_info +=3D {'rng-none':          config_host.has_key('CONFIG_RNG_NO=
NE')}
-summary_info +=3D {'Linux keyring':     config_host.has_key('CONFIG_SECRET=
_KEYRING')}
-summary(summary_info, bool_yn: true)
-
-if not supported_cpus.contains(cpu)
-  message()
-  warning('SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!')
-  message()
-  message('CPU host architecture ' + cpu + ' support is not currently main=
tained.')
-  message('The QEMU project intends to remove support for this host CPU in=
')
-  message('a future release if nobody volunteers to maintain it and to')
-  message('provide a build host for our continuous integration setup.')
-  message('configure has succeeded and you can continue to build, but')
-  message('if you care about QEMU on this platform you should contact')
-  message('us upstream at qemu-devel@nongnu.org.')
-endif
-
-if not supported_oses.contains(targetos)
-  message()
-  warning('WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE RELEAS=
ES!')
-  message()
-  message('Host OS ' + targetos + 'support is not currently maintained.')
-  message('The QEMU project intends to remove support for this host OS in')
-  message('a future release if nobody volunteers to maintain it and to')
-  message('provide a build host for our continuous integration setup.')
-  message('configure has succeeded and you can continue to build, but')
-  message('if you care about QEMU on this platform you should contact')
-  message('us upstream at qemu-devel@nongnu.org.')
-endif
+project('qemu', ['c'], meson_version: '>=3D0.55.0',=0D
+        default_options: ['warning_level=3D1', 'c_std=3Dgnu99', 'cpp_std=
=3Dgnu++11',=0D
+                          'b_lundef=3Dfalse','b_colorout=3Dauto'],=0D
+        version: run_command('head', meson.source_root() / 'VERSION').stdo=
ut().strip())=0D
+=0D
+not_found =3D dependency('', required: false)=0D
+if meson.version().version_compare('>=3D0.56.0')=0D
+  keyval =3D import('keyval')=0D
+else=0D
+  keyval =3D import('unstable-keyval')=0D
+endif=0D
+ss =3D import('sourceset')=0D
+=0D
+sh =3D find_program('sh')=0D
+cc =3D meson.get_compiler('c')=0D
+config_host =3D keyval.load(meson.current_build_dir() / 'config-host.mak')=
=0D
+config_all_disas =3D keyval.load(meson.current_build_dir() / 'config-all-d=
isas.mak')=0D
+enable_modules =3D 'CONFIG_MODULES' in config_host=0D
+enable_static =3D 'CONFIG_STATIC' in config_host=0D
+build_docs =3D 'BUILD_DOCS' in config_host=0D
+qemu_datadir =3D get_option('datadir') / get_option('qemu_suffix')=0D
+qemu_docdir =3D get_option('docdir') / get_option('qemu_suffix')=0D
+config_host_data =3D configuration_data()=0D
+genh =3D []=0D
+=0D
+target_dirs =3D config_host['TARGET_DIRS'].split()=0D
+have_user =3D false=0D
+have_system =3D false=0D
+foreach target : target_dirs=0D
+  have_user =3D have_user or target.endswith('-user')=0D
+  have_system =3D have_system or target.endswith('-softmmu')=0D
+endforeach=0D
+have_tools =3D 'CONFIG_TOOLS' in config_host=0D
+have_block =3D have_system or have_tools=0D
+=0D
+add_project_arguments(config_host['QEMU_CFLAGS'].split(),=0D
+                      native: false, language: ['c', 'objc'])=0D
+add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),=0D
+                      native: false, language: 'cpp')=0D
+add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),=0D
+                           native: false, language: ['c', 'cpp', 'objc'])=
=0D
+add_project_arguments(config_host['QEMU_INCLUDES'].split(),=0D
+                      language: ['c', 'cpp', 'objc'])=0D
+=0D
+python =3D import('python').find_installation()=0D
+=0D
+link_language =3D meson.get_external_property('link_language', 'cpp')=0D
+if link_language =3D=3D 'cpp'=0D
+  add_languages('cpp', required: true, native: false)=0D
+endif=0D
+if host_machine.system() =3D=3D 'darwin'=0D
+  add_languages('objc', required: false, native: false)=0D
+endif=0D
+=0D
+if 'SPARSE_CFLAGS' in config_host=0D
+  run_target('sparse',=0D
+             command: [find_program('scripts/check_sparse.py'),=0D
+                       config_host['SPARSE_CFLAGS'].split(),=0D
+                       'compile_commands.json'])=0D
+endif=0D
+=0D
+configure_file(input: files('scripts/ninjatool.py'),=0D
+               output: 'ninjatool',=0D
+               configuration: config_host)=0D
+=0D
+supported_oses =3D ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', '=
sunos', 'linux']=0D
+supported_cpus =3D ['ppc', 'ppc64', 's390x', 'sparc64', 'riscv32', 'riscv6=
4', 'x86', 'x86_64',=0D
+  'arm', 'aarch64', 'mips', 'mips64', 'sparc', 'sparc64']=0D
+=0D
+cpu =3D host_machine.cpu_family()=0D
+targetos =3D host_machine.system()=0D
+=0D
+m =3D cc.find_library('m', required: false)=0D
+util =3D cc.find_library('util', required: false)=0D
+winmm =3D []=0D
+socket =3D []=0D
+version_res =3D []=0D
+coref =3D []=0D
+iokit =3D []=0D
+cocoa =3D []=0D
+hvf =3D []=0D
+if targetos =3D=3D 'windows'=0D
+  socket =3D cc.find_library('ws2_32')=0D
+  winmm =3D cc.find_library('winmm')=0D
+=0D
+  win =3D import('windows')=0D
+  version_res =3D win.compile_resources('version.rc',=0D
+                                      depend_files: files('pc-bios/qemu-ns=
is.ico'),=0D
+                                      include_directories: include_directo=
ries('.'))=0D
+elif targetos =3D=3D 'darwin'=0D
+  coref =3D dependency('appleframeworks', modules: 'CoreFoundation')=0D
+  iokit =3D dependency('appleframeworks', modules: 'IOKit')=0D
+  cocoa =3D dependency('appleframeworks', modules: 'Cocoa')=0D
+  hvf =3D dependency('appleframeworks', modules: 'Hypervisor')=0D
+elif targetos =3D=3D 'sunos'=0D
+  socket =3D [cc.find_library('socket'),=0D
+            cc.find_library('nsl'),=0D
+            cc.find_library('resolv')]=0D
+elif targetos =3D=3D 'haiku'=0D
+  socket =3D [cc.find_library('posix_error_mapper'),=0D
+            cc.find_library('network'),=0D
+            cc.find_library('bsd')]=0D
+endif=0D
+glib =3D declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split=
(),=0D
+                          link_args: config_host['GLIB_LIBS'].split())=0D
+gio =3D not_found=0D
+if 'CONFIG_GIO' in config_host=0D
+  gio =3D declare_dependency(compile_args: config_host['GIO_CFLAGS'].split=
(),=0D
+                           link_args: config_host['GIO_LIBS'].split())=0D
+endif=0D
+lttng =3D not_found=0D
+if 'CONFIG_TRACE_UST' in config_host=0D
+  lttng =3D declare_dependency(link_args: config_host['LTTNG_UST_LIBS'].sp=
lit())=0D
+endif=0D
+urcubp =3D not_found=0D
+if 'CONFIG_TRACE_UST' in config_host=0D
+  urcubp =3D declare_dependency(link_args: config_host['URCU_BP_LIBS'].spl=
it())=0D
+endif=0D
+nettle =3D not_found=0D
+if 'CONFIG_NETTLE' in config_host=0D
+  nettle =3D declare_dependency(compile_args: config_host['NETTLE_CFLAGS']=
.split(),=0D
+                              link_args: config_host['NETTLE_LIBS'].split(=
))=0D
+endif=0D
+gnutls =3D not_found=0D
+if 'CONFIG_GNUTLS' in config_host=0D
+  gnutls =3D declare_dependency(compile_args: config_host['GNUTLS_CFLAGS']=
.split(),=0D
+                              link_args: config_host['GNUTLS_LIBS'].split(=
))=0D
+endif=0D
+pixman =3D not_found=0D
+if have_system or have_tools=0D
+  pixman =3D dependency('pixman-1', required: have_system, version:'>=3D0.=
21.8',=0D
+                      method: 'pkg-config', static: enable_static)=0D
+endif=0D
+pam =3D not_found=0D
+if 'CONFIG_AUTH_PAM' in config_host=0D
+  pam =3D cc.find_library('pam')=0D
+endif=0D
+libaio =3D cc.find_library('aio', required: false)=0D
+zlib =3D dependency('zlib', required: true, static: enable_static)=0D
+linux_io_uring =3D not_found=0D
+if 'CONFIG_LINUX_IO_URING' in config_host=0D
+  linux_io_uring =3D declare_dependency(compile_args: config_host['LINUX_I=
O_URING_CFLAGS'].split(),=0D
+                                      link_args: config_host['LINUX_IO_URI=
NG_LIBS'].split())=0D
+endif=0D
+libxml2 =3D not_found=0D
+if 'CONFIG_LIBXML2' in config_host=0D
+  libxml2 =3D declare_dependency(compile_args: config_host['LIBXML2_CFLAGS=
'].split(),=0D
+                               link_args: config_host['LIBXML2_LIBS'].spli=
t())=0D
+endif=0D
+libnfs =3D not_found=0D
+if 'CONFIG_LIBNFS' in config_host=0D
+  libnfs =3D declare_dependency(link_args: config_host['LIBNFS_LIBS'].spli=
t())=0D
+endif=0D
+libattr =3D not_found=0D
+if 'CONFIG_ATTR' in config_host=0D
+  libattr =3D declare_dependency(link_args: config_host['LIBATTR_LIBS'].sp=
lit())=0D
+endif=0D
+seccomp =3D not_found=0D
+if 'CONFIG_SECCOMP' in config_host=0D
+  seccomp =3D declare_dependency(compile_args: config_host['SECCOMP_CFLAGS=
'].split(),=0D
+                               link_args: config_host['SECCOMP_LIBS'].spli=
t())=0D
+endif=0D
+libcap_ng =3D not_found=0D
+if 'CONFIG_LIBCAP_NG' in config_host=0D
+  libcap_ng =3D declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'=
].split())=0D
+endif=0D
+if get_option('xkbcommon').auto() and not have_system and not have_tools=0D
+  xkbcommon =3D not_found=0D
+else=0D
+  xkbcommon =3D dependency('xkbcommon', required: get_option('xkbcommon'),=
=0D
+                         method: 'pkg-config', static: enable_static)=0D
+endif=0D
+slirp =3D not_found=0D
+if config_host.has_key('CONFIG_SLIRP')=0D
+  slirp =3D declare_dependency(compile_args: config_host['SLIRP_CFLAGS'].s=
plit(),=0D
+                             link_args: config_host['SLIRP_LIBS'].split())=
=0D
+endif=0D
+vde =3D not_found=0D
+if config_host.has_key('CONFIG_VDE')=0D
+  vde =3D declare_dependency(link_args: config_host['VDE_LIBS'].split())=0D
+endif=0D
+pulse =3D not_found=0D
+if 'CONFIG_LIBPULSE' in config_host=0D
+  pulse =3D declare_dependency(compile_args: config_host['PULSE_CFLAGS'].s=
plit(),=0D
+                             link_args: config_host['PULSE_LIBS'].split())=
=0D
+endif=0D
+alsa =3D not_found=0D
+if 'CONFIG_ALSA' in config_host=0D
+  alsa =3D declare_dependency(compile_args: config_host['ALSA_CFLAGS'].spl=
it(),=0D
+                            link_args: config_host['ALSA_LIBS'].split())=0D
+endif=0D
+jack =3D not_found=0D
+if 'CONFIG_LIBJACK' in config_host=0D
+  jack =3D declare_dependency(link_args: config_host['JACK_LIBS'].split())=
=0D
+endif=0D
+spice =3D not_found=0D
+if 'CONFIG_SPICE' in config_host=0D
+  spice =3D declare_dependency(compile_args: config_host['SPICE_CFLAGS'].s=
plit(),=0D
+                             link_args: config_host['SPICE_LIBS'].split())=
=0D
+endif=0D
+rt =3D cc.find_library('rt', required: false)=0D
+libmpathpersist =3D not_found=0D
+if config_host.has_key('CONFIG_MPATH')=0D
+  libmpathpersist =3D cc.find_library('mpathpersist')=0D
+endif=0D
+libiscsi =3D not_found=0D
+if 'CONFIG_LIBISCSI' in config_host=0D
+  libiscsi =3D declare_dependency(compile_args: config_host['LIBISCSI_CFLA=
GS'].split(),=0D
+                                link_args: config_host['LIBISCSI_LIBS'].sp=
lit())=0D
+endif=0D
+zstd =3D not_found=0D
+if 'CONFIG_ZSTD' in config_host=0D
+  zstd =3D declare_dependency(compile_args: config_host['ZSTD_CFLAGS'].spl=
it(),=0D
+                            link_args: config_host['ZSTD_LIBS'].split())=0D
+endif=0D
+gbm =3D not_found=0D
+if 'CONFIG_GBM' in config_host=0D
+  gbm =3D declare_dependency(compile_args: config_host['GBM_CFLAGS'].split=
(),=0D
+                           link_args: config_host['GBM_LIBS'].split())=0D
+endif=0D
+virgl =3D not_found=0D
+if 'CONFIG_VIRGL' in config_host=0D
+  virgl =3D declare_dependency(compile_args: config_host['VIRGL_CFLAGS'].s=
plit(),=0D
+                             link_args: config_host['VIRGL_LIBS'].split())=
=0D
+endif=0D
+curl =3D not_found=0D
+if 'CONFIG_CURL' in config_host=0D
+  curl =3D declare_dependency(compile_args: config_host['CURL_CFLAGS'].spl=
it(),=0D
+                            link_args: config_host['CURL_LIBS'].split())=0D
+endif=0D
+libudev =3D not_found=0D
+if 'CONFIG_LIBUDEV' in config_host=0D
+  libudev =3D declare_dependency(link_args: config_host['LIBUDEV_LIBS'].sp=
lit())=0D
+endif=0D
+brlapi =3D not_found=0D
+if 'CONFIG_BRLAPI' in config_host=0D
+  brlapi =3D declare_dependency(link_args: config_host['BRLAPI_LIBS'].spli=
t())=0D
+endif=0D
+=0D
+sdl =3D not_found=0D
+if have_system=0D
+  sdl =3D dependency('sdl2', required: get_option('sdl'), static: enable_s=
tatic)=0D
+  sdl_image =3D not_found=0D
+endif=0D
+if sdl.found()=0D
+  # work around 2.0.8 bug=0D
+  sdl =3D declare_dependency(compile_args: '-Wno-undef',=0D
+                           dependencies: sdl)=0D
+  sdl_image =3D dependency('SDL2_image', required: get_option('sdl_image')=
,=0D
+                         method: 'pkg-config', static: enable_static)=0D
+else=0D
+  if get_option('sdl_image').enabled()=0D
+    error('sdl-image required, but SDL was @0@',=0D
+          get_option('sdl').disabled() ? 'disabled' : 'not found')=0D
+  endif=0D
+  sdl_image =3D not_found=0D
+endif=0D
+=0D
+rbd =3D not_found=0D
+if 'CONFIG_RBD' in config_host=0D
+  rbd =3D declare_dependency(link_args: config_host['RBD_LIBS'].split())=0D
+endif=0D
+glusterfs =3D not_found=0D
+if 'CONFIG_GLUSTERFS' in config_host=0D
+  glusterfs =3D declare_dependency(compile_args: config_host['GLUSTERFS_CF=
LAGS'].split(),=0D
+                                 link_args: config_host['GLUSTERFS_LIBS'].=
split())=0D
+endif=0D
+libssh =3D not_found=0D
+if 'CONFIG_LIBSSH' in config_host=0D
+  libssh =3D declare_dependency(compile_args: config_host['LIBSSH_CFLAGS']=
.split(),=0D
+                              link_args: config_host['LIBSSH_LIBS'].split(=
))=0D
+endif=0D
+libbzip2 =3D not_found=0D
+if 'CONFIG_BZIP2' in config_host=0D
+  libbzip2 =3D declare_dependency(link_args: config_host['BZIP2_LIBS'].spl=
it())=0D
+endif=0D
+liblzfse =3D not_found=0D
+if 'CONFIG_LZFSE' in config_host=0D
+  liblzfse =3D declare_dependency(link_args: config_host['LZFSE_LIBS'].spl=
it())=0D
+endif=0D
+oss =3D not_found=0D
+if 'CONFIG_AUDIO_OSS' in config_host=0D
+  oss =3D declare_dependency(link_args: config_host['OSS_LIBS'].split())=0D
+endif=0D
+dsound =3D not_found=0D
+if 'CONFIG_AUDIO_DSOUND' in config_host=0D
+  dsound =3D declare_dependency(link_args: config_host['DSOUND_LIBS'].spli=
t())=0D
+endif=0D
+coreaudio =3D not_found=0D
+if 'CONFIG_AUDIO_COREAUDIO' in config_host=0D
+  coreaudio =3D declare_dependency(link_args: config_host['COREAUDIO_LIBS'=
].split())=0D
+endif=0D
+opengl =3D not_found=0D
+if 'CONFIG_OPENGL' in config_host=0D
+  opengl =3D declare_dependency(link_args: config_host['OPENGL_LIBS'].spli=
t())=0D
+else=0D
+endif=0D
+gtk =3D not_found=0D
+if 'CONFIG_GTK' in config_host=0D
+  gtk =3D declare_dependency(compile_args: config_host['GTK_CFLAGS'].split=
(),=0D
+                              link_args: config_host['GTK_LIBS'].split())=
=0D
+endif=0D
+vte =3D not_found=0D
+if 'CONFIG_VTE' in config_host=0D
+  vte =3D declare_dependency(compile_args: config_host['VTE_CFLAGS'].split=
(),=0D
+                           link_args: config_host['VTE_LIBS'].split())=0D
+endif=0D
+x11 =3D not_found=0D
+if 'CONFIG_X11' in config_host=0D
+  x11 =3D declare_dependency(compile_args: config_host['X11_CFLAGS'].split=
(),=0D
+                           link_args: config_host['X11_LIBS'].split())=0D
+endif=0D
+curses =3D not_found=0D
+if 'CONFIG_CURSES' in config_host=0D
+  curses =3D declare_dependency(compile_args: config_host['CURSES_CFLAGS']=
.split(),=0D
+                              link_args: config_host['CURSES_LIBS'].split(=
))=0D
+endif=0D
+iconv =3D not_found=0D
+if 'CONFIG_ICONV' in config_host=0D
+  iconv =3D declare_dependency(compile_args: config_host['ICONV_CFLAGS'].s=
plit(),=0D
+                             link_args: config_host['ICONV_LIBS'].split())=
=0D
+endif=0D
+gio =3D not_found=0D
+if 'CONFIG_GIO' in config_host=0D
+  gio =3D declare_dependency(compile_args: config_host['GIO_CFLAGS'].split=
(),=0D
+                           link_args: config_host['GIO_LIBS'].split())=0D
+endif=0D
+vnc =3D not_found=0D
+png =3D not_found=0D
+jpeg =3D not_found=0D
+sasl =3D not_found=0D
+if get_option('vnc').enabled()=0D
+  vnc =3D declare_dependency() # dummy dependency=0D
+  png =3D dependency('libpng', required: get_option('vnc_png'),=0D
+                   method: 'pkg-config', static: enable_static)=0D
+  jpeg =3D cc.find_library('jpeg', has_headers: ['jpeglib.h'],=0D
+                         required: get_option('vnc_jpeg'),=0D
+                         static: enable_static)=0D
+  sasl =3D cc.find_library('sasl2', has_headers: ['sasl/sasl.h'],=0D
+                         required: get_option('vnc_sasl'),=0D
+                         static: enable_static)=0D
+  if sasl.found()=0D
+    sasl =3D declare_dependency(dependencies: sasl,=0D
+                              compile_args: '-DSTRUCT_IOVEC_DEFINED')=0D
+  endif=0D
+endif=0D
+fdt =3D not_found=0D
+if 'CONFIG_FDT' in config_host=0D
+  fdt =3D declare_dependency(compile_args: config_host['FDT_CFLAGS'].split=
(),=0D
+                           link_args: config_host['FDT_LIBS'].split())=0D
+endif=0D
+snappy =3D not_found=0D
+if 'CONFIG_SNAPPY' in config_host=0D
+  snappy =3D declare_dependency(link_args: config_host['SNAPPY_LIBS'].spli=
t())=0D
+endif=0D
+lzo =3D not_found=0D
+if 'CONFIG_LZO' in config_host=0D
+  lzo =3D declare_dependency(link_args: config_host['LZO_LIBS'].split())=0D
+endif=0D
+rdma =3D not_found=0D
+if 'CONFIG_RDMA' in config_host=0D
+  rdma =3D declare_dependency(link_args: config_host['RDMA_LIBS'].split())=
=0D
+endif=0D
+numa =3D not_found=0D
+if 'CONFIG_NUMA' in config_host=0D
+  numa =3D declare_dependency(link_args: config_host['NUMA_LIBS'].split())=
=0D
+endif=0D
+xen =3D not_found=0D
+if 'CONFIG_XEN_BACKEND' in config_host=0D
+  xen =3D declare_dependency(compile_args: config_host['XEN_CFLAGS'].split=
(),=0D
+                           link_args: config_host['XEN_LIBS'].split())=0D
+endif=0D
+cacard =3D not_found=0D
+if 'CONFIG_SMARTCARD' in config_host=0D
+  cacard =3D declare_dependency(compile_args: config_host['SMARTCARD_CFLAG=
S'].split(),=0D
+                              link_args: config_host['SMARTCARD_LIBS'].spl=
it())=0D
+endif=0D
+u2f =3D not_found=0D
+if have_system=0D
+  u2f =3D dependency('u2f-emu', required: get_option('u2f'),=0D
+                   method: 'pkg-config',=0D
+                   static: enable_static)=0D
+endif=0D
+usbredir =3D not_found=0D
+if 'CONFIG_USB_REDIR' in config_host=0D
+  usbredir =3D declare_dependency(compile_args: config_host['USB_REDIR_CFL=
AGS'].split(),=0D
+                                link_args: config_host['USB_REDIR_LIBS'].s=
plit())=0D
+endif=0D
+libusb =3D not_found=0D
+if 'CONFIG_USB_LIBUSB' in config_host=0D
+  libusb =3D declare_dependency(compile_args: config_host['LIBUSB_CFLAGS']=
.split(),=0D
+                              link_args: config_host['LIBUSB_LIBS'].split(=
))=0D
+endif=0D
+capstone =3D not_found=0D
+if 'CONFIG_CAPSTONE' in config_host=0D
+  capstone =3D declare_dependency(compile_args: config_host['CAPSTONE_CFLA=
GS'].split(),=0D
+                                link_args: config_host['CAPSTONE_LIBS'].sp=
lit())=0D
+endif=0D
+libpmem =3D not_found=0D
+if 'CONFIG_LIBPMEM' in config_host=0D
+  libpmem =3D declare_dependency(compile_args: config_host['LIBPMEM_CFLAGS=
'].split(),=0D
+                               link_args: config_host['LIBPMEM_LIBS'].spli=
t())=0D
+endif=0D
+libdaxctl =3D not_found=0D
+if 'CONFIG_LIBDAXCTL' in config_host=0D
+  libdaxctl =3D declare_dependency(link_args: config_host['LIBDAXCTL_LIBS'=
].split())=0D
+endif=0D
+=0D
+# Create config-host.h=0D
+=0D
+config_host_data.set('CONFIG_SDL', sdl.found())=0D
+config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())=0D
+config_host_data.set('CONFIG_VNC', vnc.found())=0D
+config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())=0D
+config_host_data.set('CONFIG_VNC_PNG', png.found())=0D
+config_host_data.set('CONFIG_VNC_SASL', sasl.found())=0D
+config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())=0D
+config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version(=
)))=0D
+config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('=
.')[0])=0D
+config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('=
.')[1])=0D
+config_host_data.set('QEMU_VERSION_MICRO', meson.project_version().split('=
.')[2])=0D
+=0D
+arrays =3D ['CONFIG_AUDIO_DRIVERS', 'CONFIG_BDRV_RW_WHITELIST', 'CONFIG_BD=
RV_RO_WHITELIST']=0D
+strings =3D ['HOST_DSOSUF', 'CONFIG_IASL', 'qemu_confdir', 'qemu_datadir',=
=0D
+           'qemu_moddir', 'qemu_localstatedir', 'qemu_helperdir', 'qemu_lo=
caledir',=0D
+           'qemu_icondir', 'qemu_desktopdir', 'qemu_firmwarepath']=0D
+foreach k, v: config_host=0D
+  if arrays.contains(k)=0D
+    if v !=3D ''=0D
+      v =3D '"' + '", "'.join(v.split()) + '", '=0D
+    endif=0D
+    config_host_data.set(k, v)=0D
+  elif k =3D=3D 'ARCH'=0D
+    config_host_data.set('HOST_' + v.to_upper(), 1)=0D
+  elif strings.contains(k)=0D
+    if not k.startswith('CONFIG_')=0D
+      k =3D 'CONFIG_' + k.to_upper()=0D
+    endif=0D
+    config_host_data.set_quoted(k, v)=0D
+  elif k.startswith('CONFIG_') or k.startswith('HAVE_') or k.startswith('H=
OST_')=0D
+    config_host_data.set(k, v =3D=3D 'y' ? 1 : v)=0D
+  endif=0D
+endforeach=0D
+genh +=3D configure_file(output: 'config-host.h', configuration: config_ho=
st_data)=0D
+=0D
+minikconf =3D find_program('scripts/minikconf.py')=0D
+config_devices_mak_list =3D []=0D
+config_devices_h =3D {}=0D
+config_target_h =3D {}=0D
+config_target_mak =3D {}=0D
+kconfig_external_symbols =3D [=0D
+  'CONFIG_KVM',=0D
+  'CONFIG_XEN',=0D
+  'CONFIG_TPM',=0D
+  'CONFIG_SPICE',=0D
+  'CONFIG_IVSHMEM',=0D
+  'CONFIG_OPENGL',=0D
+  'CONFIG_X11',=0D
+  'CONFIG_VHOST_USER',=0D
+  'CONFIG_VHOST_KERNEL',=0D
+  'CONFIG_VIRTFS',=0D
+  'CONFIG_LINUX',=0D
+  'CONFIG_PVRDMA',=0D
+]=0D
+ignored =3D ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']=0D
+foreach target : target_dirs=0D
+  config_target =3D keyval.load(meson.current_build_dir() / target / 'conf=
ig-target.mak')=0D
+=0D
+  config_target_data =3D configuration_data()=0D
+  foreach k, v: config_target=0D
+    if not k.startswith('TARGET_') and not k.startswith('CONFIG_')=0D
+      # do nothing=0D
+    elif ignored.contains(k)=0D
+      # do nothing=0D
+    elif k =3D=3D 'TARGET_BASE_ARCH'=0D
+      config_target_data.set('TARGET_' + v.to_upper(), 1)=0D
+    elif k =3D=3D 'TARGET_NAME'=0D
+      config_target_data.set_quoted(k, v)=0D
+    elif v =3D=3D 'y'=0D
+      config_target_data.set(k, 1)=0D
+    else=0D
+      config_target_data.set(k, v)=0D
+    endif=0D
+  endforeach=0D
+  config_target_h +=3D {target: configure_file(output: target + '-config-t=
arget.h',=0D
+                                               configuration: config_targe=
t_data)}=0D
+=0D
+  if target.endswith('-softmmu')=0D
+    base_kconfig =3D []=0D
+    foreach sym : kconfig_external_symbols=0D
+      if sym in config_target or sym in config_host=0D
+        base_kconfig +=3D '@0@=3Dy'.format(sym)=0D
+      endif=0D
+    endforeach=0D
+=0D
+    config_devices_mak =3D target + '-config-devices.mak'=0D
+    config_devices_mak =3D configure_file(=0D
+      input: ['default-configs' / target + '.mak', 'Kconfig'],=0D
+      output: config_devices_mak,=0D
+      depfile: config_devices_mak + '.d',=0D
+      capture: true,=0D
+      command: [minikconf, config_host['CONFIG_MINIKCONF_MODE'],=0D
+                config_devices_mak, '@DEPFILE@', '@INPUT@',=0D
+                base_kconfig])=0D
+=0D
+    config_devices_data =3D configuration_data()=0D
+    config_devices =3D keyval.load(config_devices_mak)=0D
+    foreach k, v: config_devices=0D
+      config_devices_data.set(k, 1)=0D
+    endforeach=0D
+    config_devices_mak_list +=3D config_devices_mak=0D
+    config_devices_h +=3D {target: configure_file(output: target + '-confi=
g-devices.h',=0D
+                                                configuration: config_devi=
ces_data)}=0D
+    config_target +=3D config_devices=0D
+  endif=0D
+  config_target_mak +=3D {target: config_target}=0D
+endforeach=0D
+=0D
+grepy =3D find_program('scripts/grepy.sh')=0D
+# This configuration is used to build files that are shared by=0D
+# multiple binaries, and then extracted out of the "common"=0D
+# static_library target.=0D
+#=0D
+# We do not use all_sources()/all_dependencies(), because it would=0D
+# build literally all source files, including devices only used by=0D
+# targets that are not built for this compilation.  The CONFIG_ALL=0D
+# pseudo symbol replaces it.=0D
+=0D
+if have_system=0D
+  config_all_devices_mak =3D configure_file(=0D
+    output: 'config-all-devices.mak',=0D
+    input: config_devices_mak_list,=0D
+    capture: true,=0D
+    command: [grepy, '@INPUT@'],=0D
+  )=0D
+  config_all_devices =3D keyval.load(config_all_devices_mak)=0D
+else=0D
+  config_all_devices =3D {}=0D
+endif=0D
+config_all =3D config_all_devices=0D
+config_all +=3D config_host=0D
+config_all +=3D config_all_disas=0D
+config_all +=3D {=0D
+  'CONFIG_XEN': config_host.has_key('CONFIG_XEN_BACKEND'),=0D
+  'CONFIG_SOFTMMU': have_system,=0D
+  'CONFIG_USER_ONLY': have_user,=0D
+  'CONFIG_ALL': true,=0D
+}=0D
+=0D
+# Generators=0D
+=0D
+hxtool =3D find_program('scripts/hxtool')=0D
+shaderinclude =3D find_program('scripts/shaderinclude.pl')=0D
+qapi_gen =3D find_program('scripts/qapi-gen.py')=0D
+qapi_gen_depends =3D [ meson.source_root() / 'scripts/qapi/__init__.py',=0D
+                     meson.source_root() / 'scripts/qapi/commands.py',=0D
+                     meson.source_root() / 'scripts/qapi/common.py',=0D
+                     meson.source_root() / 'scripts/qapi/doc.py',=0D
+                     meson.source_root() / 'scripts/qapi/error.py',=0D
+                     meson.source_root() / 'scripts/qapi/events.py',=0D
+                     meson.source_root() / 'scripts/qapi/expr.py',=0D
+                     meson.source_root() / 'scripts/qapi/gen.py',=0D
+                     meson.source_root() / 'scripts/qapi/introspect.py',=0D
+                     meson.source_root() / 'scripts/qapi/parser.py',=0D
+                     meson.source_root() / 'scripts/qapi/schema.py',=0D
+                     meson.source_root() / 'scripts/qapi/source.py',=0D
+                     meson.source_root() / 'scripts/qapi/types.py',=0D
+                     meson.source_root() / 'scripts/qapi/visit.py',=0D
+                     meson.source_root() / 'scripts/qapi/common.py',=0D
+                     meson.source_root() / 'scripts/qapi/doc.py',=0D
+                     meson.source_root() / 'scripts/qapi-gen.py'=0D
+]=0D
+=0D
+tracetool =3D [=0D
+  python, files('scripts/tracetool.py'),=0D
+   '--backend=3D' + config_host['TRACE_BACKENDS']=0D
+]=0D
+=0D
+qemu_version_cmd =3D [find_program('scripts/qemu-version.sh'),=0D
+                    meson.current_source_dir(),=0D
+                    config_host['PKGVERSION'], meson.project_version()]=0D
+qemu_version =3D custom_target('qemu-version.h',=0D
+                             output: 'qemu-version.h',=0D
+                             command: qemu_version_cmd,=0D
+                             capture: true,=0D
+                             build_by_default: true,=0D
+                             build_always_stale: true)=0D
+genh +=3D qemu_version=0D
+=0D
+hxdep =3D []=0D
+hx_headers =3D [=0D
+  ['qemu-options.hx', 'qemu-options.def'],=0D
+  ['qemu-img-cmds.hx', 'qemu-img-cmds.h'],=0D
+]=0D
+if have_system=0D
+  hx_headers +=3D [=0D
+    ['hmp-commands.hx', 'hmp-commands.h'],=0D
+    ['hmp-commands-info.hx', 'hmp-commands-info.h'],=0D
+  ]=0D
+endif=0D
+foreach d : hx_headers=0D
+  hxdep +=3D custom_target(d[1],=0D
+                input: files(d[0]),=0D
+                output: d[1],=0D
+                capture: true,=0D
+                build_by_default: true, # to be removed when added to a ta=
rget=0D
+                command: [hxtool, '-h', '@INPUT0@'])=0D
+endforeach=0D
+genh +=3D hxdep=0D
+=0D
+# Collect sourcesets.=0D
+=0D
+util_ss =3D ss.source_set()=0D
+stub_ss =3D ss.source_set()=0D
+trace_ss =3D ss.source_set()=0D
+block_ss =3D ss.source_set()=0D
+blockdev_ss =3D ss.source_set()=0D
+qmp_ss =3D ss.source_set()=0D
+common_ss =3D ss.source_set()=0D
+softmmu_ss =3D ss.source_set()=0D
+user_ss =3D ss.source_set()=0D
+bsd_user_ss =3D ss.source_set()=0D
+linux_user_ss =3D ss.source_set()=0D
+specific_ss =3D ss.source_set()=0D
+specific_fuzz_ss =3D ss.source_set()=0D
+=0D
+modules =3D {}=0D
+hw_arch =3D {}=0D
+target_arch =3D {}=0D
+target_softmmu_arch =3D {}=0D
+=0D
+###############=0D
+# Trace files #=0D
+###############=0D
+=0D
+# TODO: add each directory to the subdirs from its own meson.build, once=0D
+# we have those=0D
+trace_events_subdirs =3D [=0D
+  'accel/kvm',=0D
+  'accel/tcg',=0D
+  'crypto',=0D
+  'monitor',=0D
+]=0D
+if have_user=0D
+  trace_events_subdirs +=3D [ 'linux-user' ]=0D
+endif=0D
+if have_block=0D
+  trace_events_subdirs +=3D [=0D
+    'authz',=0D
+    'block',=0D
+    'io',=0D
+    'nbd',=0D
+    'scsi',=0D
+  ]=0D
+endif=0D
+if have_system=0D
+  trace_events_subdirs +=3D [=0D
+    'audio',=0D
+    'backends',=0D
+    'backends/tpm',=0D
+    'chardev',=0D
+    'hw/9pfs',=0D
+    'hw/acpi',=0D
+    'hw/alpha',=0D
+    'hw/arm',=0D
+    'hw/audio',=0D
+    'hw/block',=0D
+    'hw/block/dataplane',=0D
+    'hw/char',=0D
+    'hw/display',=0D
+    'hw/dma',=0D
+    'hw/hppa',=0D
+    'hw/hyperv',=0D
+    'hw/i2c',=0D
+    'hw/i386',=0D
+    'hw/i386/xen',=0D
+    'hw/ide',=0D
+    'hw/input',=0D
+    'hw/intc',=0D
+    'hw/isa',=0D
+    'hw/mem',=0D
+    'hw/mips',=0D
+    'hw/misc',=0D
+    'hw/misc/macio',=0D
+    'hw/net',=0D
+    'hw/nvram',=0D
+    'hw/pci',=0D
+    'hw/pci-host',=0D
+    'hw/ppc',=0D
+    'hw/rdma',=0D
+    'hw/rdma/vmw',=0D
+    'hw/rtc',=0D
+    'hw/s390x',=0D
+    'hw/scsi',=0D
+    'hw/sd',=0D
+    'hw/sparc',=0D
+    'hw/sparc64',=0D
+    'hw/ssi',=0D
+    'hw/timer',=0D
+    'hw/tpm',=0D
+    'hw/usb',=0D
+    'hw/vfio',=0D
+    'hw/virtio',=0D
+    'hw/watchdog',=0D
+    'hw/xen',=0D
+    'hw/gpio',=0D
+    'hw/riscv',=0D
+    'migration',=0D
+    'net',=0D
+    'ui',=0D
+  ]=0D
+endif=0D
+trace_events_subdirs +=3D [=0D
+  'hw/core',=0D
+  'qapi',=0D
+  'qom',=0D
+  'target/arm',=0D
+  'target/hppa',=0D
+  'target/i386',=0D
+  'target/mips',=0D
+  'target/ppc',=0D
+  'target/riscv',=0D
+  'target/s390x',=0D
+  'target/sparc',=0D
+  'util',=0D
+]=0D
+=0D
+subdir('qapi')=0D
+subdir('qobject')=0D
+subdir('stubs')=0D
+subdir('trace')=0D
+subdir('util')=0D
+subdir('qom')=0D
+subdir('authz')=0D
+subdir('crypto')=0D
+subdir('ui')=0D
+=0D
+=0D
+if enable_modules=0D
+  libmodulecommon =3D static_library('module-common', files('module-common=
.c') + genh, pic: true, c_args: '-DBUILD_DSO')=0D
+  modulecommon =3D declare_dependency(link_whole: libmodulecommon, compile=
_args: '-DBUILD_DSO')=0D
+endif=0D
+=0D
+# Build targets from sourcesets=0D
+=0D
+stub_ss =3D stub_ss.apply(config_all, strict: false)=0D
+=0D
+util_ss.add_all(trace_ss)=0D
+util_ss =3D util_ss.apply(config_all, strict: false)=0D
+libqemuutil =3D static_library('qemuutil',=0D
+                             sources: util_ss.sources() + stub_ss.sources(=
) + genh,=0D
+                             dependencies: [util_ss.dependencies(), m, gli=
b, socket])=0D
+qemuutil =3D declare_dependency(link_with: libqemuutil,=0D
+                              sources: genh + version_res)=0D
+=0D
+decodetree =3D generator(find_program('scripts/decodetree.py'),=0D
+                       output: 'decode-@BASENAME@.c.inc',=0D
+                       arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@OUTP=
UT@'])=0D
+=0D
+subdir('audio')=0D
+subdir('io')=0D
+subdir('chardev')=0D
+subdir('fsdev')=0D
+subdir('libdecnumber')=0D
+subdir('target')=0D
+subdir('dump')=0D
+=0D
+block_ss.add(files(=0D
+  'block.c',=0D
+  'blockjob.c',=0D
+  'job.c',=0D
+  'qemu-io-cmds.c',=0D
+))=0D
+block_ss.add(when: 'CONFIG_REPLICATION', if_true: files('replication.c'))=
=0D
+=0D
+subdir('nbd')=0D
+subdir('scsi')=0D
+subdir('block')=0D
+=0D
+blockdev_ss.add(files(=0D
+  'blockdev.c',=0D
+  'blockdev-nbd.c',=0D
+  'iothread.c',=0D
+  'job-qmp.c',=0D
+))=0D
+=0D
+# os-posix.c contains POSIX-specific functions used by qemu-storage-daemon=
,=0D
+# os-win32.c does not=0D
+blockdev_ss.add(when: 'CONFIG_POSIX', if_true: files('os-posix.c'))=0D
+softmmu_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c')])=0D
+=0D
+softmmu_ss.add_all(blockdev_ss)=0D
+softmmu_ss.add(files(=0D
+  'bootdevice.c',=0D
+  'dma-helpers.c',=0D
+  'qdev-monitor.c',=0D
+), sdl)=0D
+=0D
+softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))=0D
+softmmu_ss.add(when: 'CONFIG_SECCOMP', if_true: [files('qemu-seccomp.c'), =
seccomp])=0D
+softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c'=
)])=0D
+=0D
+common_ss.add(files('cpus-common.c'))=0D
+=0D
+subdir('softmmu')=0D
+=0D
+specific_ss.add(files('disas.c', 'exec.c', 'gdbstub.c'), capstone, libpmem=
, libdaxctl)=0D
+specific_ss.add(files('exec-vary.c'))=0D
+specific_ss.add(when: 'CONFIG_TCG', if_true: files(=0D
+  'fpu/softfloat.c',=0D
+  'tcg/optimize.c',=0D
+  'tcg/tcg-common.c',=0D
+  'tcg/tcg-op-gvec.c',=0D
+  'tcg/tcg-op-vec.c',=0D
+  'tcg/tcg-op.c',=0D
+  'tcg/tcg.c',=0D
+))=0D
+specific_ss.add(when: 'CONFIG_TCG_INTERPRETER', if_true: files('disas/tci.=
c', 'tcg/tci.c'))=0D
+=0D
+subdir('backends')=0D
+subdir('disas')=0D
+subdir('migration')=0D
+subdir('monitor')=0D
+subdir('net')=0D
+subdir('replay')=0D
+subdir('hw')=0D
+subdir('accel')=0D
+subdir('plugins')=0D
+subdir('bsd-user')=0D
+subdir('linux-user')=0D
+=0D
+bsd_user_ss.add(files('gdbstub.c'))=0D
+specific_ss.add_all(when: 'CONFIG_BSD_USER', if_true: bsd_user_ss)=0D
+=0D
+linux_user_ss.add(files('gdbstub.c', 'thunk.c'))=0D
+specific_ss.add_all(when: 'CONFIG_LINUX_USER', if_true: linux_user_ss)=0D
+=0D
+# needed for fuzzing binaries=0D
+subdir('tests/qtest/libqos')=0D
+subdir('tests/qtest/fuzz')=0D
+=0D
+block_mods =3D []=0D
+softmmu_mods =3D []=0D
+foreach d, list : modules=0D
+  foreach m, module_ss : list=0D
+    if enable_modules and targetos !=3D 'windows'=0D
+      module_ss =3D module_ss.apply(config_host, strict: false)=0D
+      sl =3D static_library(d + '-' + m, [genh, module_ss.sources()],=0D
+                          dependencies: [modulecommon, module_ss.dependenc=
ies()], pic: true)=0D
+      if d =3D=3D 'block'=0D
+        block_mods +=3D sl=0D
+      else=0D
+        softmmu_mods +=3D sl=0D
+      endif=0D
+    else=0D
+      if d =3D=3D 'block'=0D
+        block_ss.add_all(module_ss)=0D
+      else=0D
+        softmmu_ss.add_all(module_ss)=0D
+      endif=0D
+    endif=0D
+  endforeach=0D
+endforeach=0D
+=0D
+nm =3D find_program('nm')=0D
+undefsym =3D find_program('scripts/undefsym.py')=0D
+block_syms =3D custom_target('block.syms', output: 'block.syms',=0D
+                             input: [libqemuutil, block_mods],=0D
+                             capture: true,=0D
+                             command: [undefsym, nm, '@INPUT@'])=0D
+qemu_syms =3D custom_target('qemu.syms', output: 'qemu.syms',=0D
+                             input: [libqemuutil, softmmu_mods],=0D
+                             capture: true,=0D
+                             command: [undefsym, nm, '@INPUT@'])=0D
+=0D
+block_ss =3D block_ss.apply(config_host, strict: false)=0D
+libblock =3D static_library('block', block_ss.sources() + genh,=0D
+                          dependencies: block_ss.dependencies(),=0D
+                          link_depends: block_syms,=0D
+                          name_suffix: 'fa',=0D
+                          build_by_default: false)=0D
+=0D
+block =3D declare_dependency(link_whole: [libblock],=0D
+                           link_args: '@block.syms',=0D
+                           dependencies: [crypto, io])=0D
+=0D
+qmp_ss =3D qmp_ss.apply(config_host, strict: false)=0D
+libqmp =3D static_library('qmp', qmp_ss.sources() + genh,=0D
+                        dependencies: qmp_ss.dependencies(),=0D
+                        name_suffix: 'fa',=0D
+                        build_by_default: false)=0D
+=0D
+qmp =3D declare_dependency(link_whole: [libqmp])=0D
+=0D
+foreach m : block_mods + softmmu_mods=0D
+  shared_module(m.name(),=0D
+                name_prefix: '',=0D
+                link_whole: m,=0D
+                install: true,=0D
+                install_dir: config_host['qemu_moddir'])=0D
+endforeach=0D
+=0D
+softmmu_ss.add(authz, block, chardev, crypto, io, qmp)=0D
+common_ss.add(qom, qemuutil)=0D
+=0D
+common_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: [softmmu_ss])=0D
+common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)=0D
+=0D
+common_all =3D common_ss.apply(config_all, strict: false)=0D
+common_all =3D static_library('common',=0D
+                            build_by_default: false,=0D
+                            sources: common_all.sources() + genh,=0D
+                            dependencies: common_all.dependencies(),=0D
+                            name_suffix: 'fa')=0D
+=0D
+feature_to_c =3D find_program('scripts/feature_to_c.sh')=0D
+=0D
+emulators =3D []=0D
+foreach target : target_dirs=0D
+  config_target =3D config_target_mak[target]=0D
+  target_name =3D config_target['TARGET_NAME']=0D
+  arch =3D config_target['TARGET_BASE_ARCH']=0D
+  arch_srcs =3D [config_target_h[target]]=0D
+  arch_deps =3D []=0D
+  c_args =3D ['-DNEED_CPU_H',=0D
+            '-DCONFIG_TARGET=3D"@0@-config-target.h"'.format(target),=0D
+            '-DCONFIG_DEVICES=3D"@0@-config-devices.h"'.format(target)]=0D
+  link_args =3D []=0D
+=0D
+  config_target +=3D config_host=0D
+  target_inc =3D [include_directories('target' / config_target['TARGET_BAS=
E_ARCH'])]=0D
+  if targetos =3D=3D 'linux'=0D
+    target_inc +=3D include_directories('linux-headers', is_system: true)=
=0D
+  endif=0D
+  if target.endswith('-softmmu')=0D
+    qemu_target_name =3D 'qemu-system-' + target_name=0D
+    target_type=3D'system'=0D
+    t =3D target_softmmu_arch[arch].apply(config_target, strict: false)=0D
+    arch_srcs +=3D t.sources()=0D
+    arch_deps +=3D t.dependencies()=0D
+=0D
+    hw_dir =3D target_name =3D=3D 'sparc64' ? 'sparc64' : arch=0D
+    hw =3D hw_arch[hw_dir].apply(config_target, strict: false)=0D
+    arch_srcs +=3D hw.sources()=0D
+    arch_deps +=3D hw.dependencies()=0D
+=0D
+    arch_srcs +=3D config_devices_h[target]=0D
+    link_args +=3D ['@block.syms', '@qemu.syms']=0D
+  else=0D
+    abi =3D config_target['TARGET_ABI_DIR']=0D
+    target_type=3D'user'=0D
+    qemu_target_name =3D 'qemu-' + target_name=0D
+    if 'CONFIG_LINUX_USER' in config_target=0D
+      base_dir =3D 'linux-user'=0D
+      target_inc +=3D include_directories('linux-user/host/' / config_host=
['ARCH'])=0D
+    else=0D
+      base_dir =3D 'bsd-user'=0D
+    endif=0D
+    target_inc +=3D include_directories(=0D
+      base_dir,=0D
+      base_dir / abi,=0D
+    )=0D
+    if 'CONFIG_LINUX_USER' in config_target=0D
+      dir =3D base_dir / abi=0D
+      arch_srcs +=3D files(dir / 'signal.c', dir / 'cpu_loop.c')=0D
+      if config_target.has_key('TARGET_SYSTBL_ABI')=0D
+        arch_srcs +=3D \=0D
+          syscall_nr_generators[abi].process(base_dir / abi / config_targe=
t['TARGET_SYSTBL'],=0D
+                                             extra_args : config_target['T=
ARGET_SYSTBL_ABI'])=0D
+      endif=0D
+    endif=0D
+  endif=0D
+=0D
+  if 'TARGET_XML_FILES' in config_target=0D
+    gdbstub_xml =3D custom_target(target + '-gdbstub-xml.c',=0D
+                                output: target + '-gdbstub-xml.c',=0D
+                                input: files(config_target['TARGET_XML_FIL=
ES'].split()),=0D
+                                command: [feature_to_c, '@INPUT@'],=0D
+                                capture: true)=0D
+    arch_srcs +=3D gdbstub_xml=0D
+  endif=0D
+=0D
+  t =3D target_arch[arch].apply(config_target, strict: false)=0D
+  arch_srcs +=3D t.sources()=0D
+  arch_deps +=3D t.dependencies()=0D
+=0D
+  target_common =3D common_ss.apply(config_target, strict: false)=0D
+  objects =3D common_all.extract_objects(target_common.sources())=0D
+  deps =3D target_common.dependencies()=0D
+=0D
+  target_specific =3D specific_ss.apply(config_target, strict: false)=0D
+  arch_srcs +=3D target_specific.sources()=0D
+  arch_deps +=3D target_specific.dependencies()=0D
+=0D
+  lib =3D static_library('qemu-' + target,=0D
+                 sources: arch_srcs + genh,=0D
+                 dependencies: arch_deps,=0D
+                 objects: objects,=0D
+                 include_directories: target_inc,=0D
+                 c_args: c_args,=0D
+                 build_by_default: false,=0D
+                 name_suffix: 'fa')=0D
+=0D
+  if target.endswith('-softmmu')=0D
+    execs =3D [{=0D
+      'name': 'qemu-system-' + target_name,=0D
+      'gui': false,=0D
+      'sources': files('softmmu/main.c'),=0D
+      'dependencies': []=0D
+    }]=0D
+    if targetos =3D=3D 'windows' and (sdl.found() or gtk.found())=0D
+      execs +=3D [{=0D
+        'name': 'qemu-system-' + target_name + 'w',=0D
+        'gui': true,=0D
+        'sources': files('softmmu/main.c'),=0D
+        'dependencies': []=0D
+      }]=0D
+    endif=0D
+    if config_host.has_key('CONFIG_FUZZ')=0D
+      specific_fuzz =3D specific_fuzz_ss.apply(config_target, strict: fals=
e)=0D
+      execs +=3D [{=0D
+        'name': 'qemu-fuzz-' + target_name,=0D
+        'gui': false,=0D
+        'sources': specific_fuzz.sources(),=0D
+        'dependencies': specific_fuzz.dependencies(),=0D
+        'link_depends': [files('tests/qtest/fuzz/fork_fuzz.ld')],=0D
+      }]=0D
+    endif=0D
+  else=0D
+    execs =3D [{=0D
+      'name': 'qemu-' + target_name,=0D
+      'gui': false,=0D
+      'sources': [],=0D
+      'dependencies': []=0D
+    }]=0D
+  endif=0D
+  foreach exe: execs=0D
+    emulators +=3D executable(exe['name'], exe['sources'],=0D
+               install: true,=0D
+               c_args: c_args,=0D
+               dependencies: arch_deps + deps + exe['dependencies'],=0D
+               objects: lib.extract_all_objects(recursive: true),=0D
+               link_language: link_language,=0D
+               link_depends: [block_syms, qemu_syms] + exe.get('link_depen=
ds', []),=0D
+               link_args: link_args,=0D
+               gui_app: exe['gui'])=0D
+=0D
+    if 'CONFIG_TRACE_SYSTEMTAP' in config_host=0D
+      foreach stp: [=0D
+        {'ext': '.stp-build', 'fmt': 'stap', 'bin': meson.current_build_di=
r() / exe['name'], 'install': false},=0D
+        {'ext': '.stp', 'fmt': 'stap', 'bin': get_option('prefix') / get_o=
ption('bindir') / exe['name'], 'install': true},=0D
+        {'ext': '-simpletrace.stp', 'fmt': 'simpletrace-stap', 'bin': '', =
'install': true},=0D
+        {'ext': '-log.stp', 'fmt': 'log-stap', 'bin': '', 'install': true}=
,=0D
+      ]=0D
+        custom_target(exe['name'] + stp['ext'],=0D
+                      input: trace_events_all,=0D
+                      output: exe['name'] + stp['ext'],=0D
+                      capture: true,=0D
+                      install: stp['install'],=0D
+                      install_dir: qemu_datadir / '../systemtap/tapset',=0D
+                      command: [=0D
+                        tracetool, '--group=3Dall', '--format=3D' + stp['f=
mt'],=0D
+                        '--binary=3D' + stp['bin'],=0D
+                        '--target-name=3D' + target_name,=0D
+                        '--target-type=3D' + target_type,=0D
+                        '--probe-prefix=3Dqemu.' + target_type + '.' + tar=
get_name,=0D
+                        '@INPUT@',=0D
+                      ])=0D
+      endforeach=0D
+    endif=0D
+  endforeach=0D
+endforeach=0D
+=0D
+# Other build targets=0D
+=0D
+if 'CONFIG_PLUGIN' in config_host=0D
+  install_headers('include/qemu/qemu-plugin.h')=0D
+endif=0D
+=0D
+if 'CONFIG_GUEST_AGENT' in config_host=0D
+  subdir('qga')=0D
+endif=0D
+=0D
+# Don't build qemu-keymap if xkbcommon is not explicitly enabled=0D
+# when we don't build tools or system=0D
+if xkbcommon.found()=0D
+  # used for the update-keymaps target, so include rules even if !have_too=
ls=0D
+  qemu_keymap =3D executable('qemu-keymap', files('qemu-keymap.c', 'ui/inp=
ut-keymap.c') + genh,=0D
+                           dependencies: [qemuutil, xkbcommon], install: h=
ave_tools)=0D
+endif=0D
+=0D
+qemu_block_tools =3D []=0D
+if have_tools=0D
+  qemu_img =3D executable('qemu-img', [files('qemu-img.c'), hxdep],=0D
+             dependencies: [authz, block, crypto, io, qom, qemuutil], inst=
all: true)=0D
+  qemu_io =3D executable('qemu-io', files('qemu-io.c'),=0D
+             dependencies: [block, qemuutil], install: true)=0D
+  qemu_block_tools +=3D [qemu_img, qemu_io]=0D
+  if targetos !=3D 'windows'=0D
+    qemu_nbd =3D executable('qemu-nbd', files('qemu-nbd.c'),=0D
+               dependencies: [block, qemuutil], install: true)=0D
+    qemu_block_tools +=3D [qemu_nbd]=0D
+  endif=0D
+=0D
+  subdir('storage-daemon')=0D
+  subdir('contrib/rdmacm-mux')=0D
+  subdir('contrib/elf2dmp')=0D
+=0D
+  executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c=
'),=0D
+             dependencies: qemuutil,=0D
+             install: true)=0D
+=0D
+  if 'CONFIG_VHOST_USER' in config_host=0D
+    subdir('contrib/libvhost-user')=0D
+    subdir('contrib/vhost-user-blk')=0D
+    subdir('contrib/vhost-user-gpu')=0D
+    subdir('contrib/vhost-user-input')=0D
+    subdir('contrib/vhost-user-scsi')=0D
+  endif=0D
+=0D
+  if targetos =3D=3D 'linux'=0D
+    executable('qemu-bridge-helper', files('qemu-bridge-helper.c'),=0D
+               dependencies: [qemuutil, libcap_ng],=0D
+               install: true,=0D
+               install_dir: get_option('libexecdir'))=0D
+=0D
+    executable('qemu-pr-helper', files('scsi/qemu-pr-helper.c', 'scsi/util=
s.c'),=0D
+               dependencies: [authz, crypto, io, qom, qemuutil,=0D
+                              libcap_ng, libudev, libmpathpersist],=0D
+               install: true)=0D
+  endif=0D
+=0D
+  if 'CONFIG_IVSHMEM' in config_host=0D
+    subdir('contrib/ivshmem-client')=0D
+    subdir('contrib/ivshmem-server')=0D
+  endif=0D
+endif=0D
+=0D
+subdir('scripts')=0D
+subdir('tools')=0D
+subdir('pc-bios')=0D
+subdir('tests')=0D
+subdir('docs')=0D
+if 'CONFIG_GTK' in config_host=0D
+  subdir('po')=0D
+endif=0D
+=0D
+if build_docs=0D
+  makeinfo =3D find_program('makeinfo', required: build_docs)=0D
+=0D
+  docs_inc =3D [=0D
+    '-I', meson.current_source_dir(),=0D
+    '-I', meson.current_build_dir() / 'docs',=0D
+    '-I', '@OUTDIR@',=0D
+  ]=0D
+=0D
+  version_texi =3D configure_file(output: 'version.texi',=0D
+                              input: 'version.texi.in',=0D
+                              configuration: {'VERSION': meson.project_ver=
sion(),=0D
+                                              'qemu_confdir': config_host[=
'qemu_confdir']})=0D
+=0D
+  texi =3D {=0D
+    'qemu-qmp-ref': ['docs/interop/qemu-qmp-ref.texi', qapi_doc_texi, vers=
ion_texi],=0D
+  }=0D
+  if 'CONFIG_GUEST_AGENT' in config_host=0D
+    texi +=3D {'qemu-ga-ref': ['docs/interop/qemu-ga-ref.texi', qga_qapi_d=
oc_texi, version_texi]}=0D
+  endif=0D
+=0D
+  if makeinfo.found()=0D
+    cmd =3D [=0D
+      'env', 'LC_ALL=3DC', makeinfo, '--no-split', '--number-sections', do=
cs_inc,=0D
+      '@INPUT0@', '-o', '@OUTPUT@',=0D
+    ]=0D
+    foreach ext, args: {=0D
+        'info': [],=0D
+        'html': ['--no-headers', '--html'],=0D
+        'txt': ['--no-headers', '--plaintext'],=0D
+    }=0D
+      t =3D []=0D
+      foreach doc, input: texi=0D
+        output =3D doc + '.' + ext=0D
+        t +=3D custom_target(output,=0D
+                      input: input,=0D
+                      output: output,=0D
+                      install: true,=0D
+                      install_dir: qemu_docdir / 'interop',=0D
+                      command: cmd + args)=0D
+      endforeach=0D
+      alias_target(ext, t)=0D
+    endforeach=0D
+  endif=0D
+=0D
+  texi2pdf =3D find_program('texi2pdf', required: false)=0D
+=0D
+  if texi2pdf.found()=0D
+    pdfs =3D []=0D
+    foreach doc, input: texi=0D
+      output =3D doc + '.pdf'=0D
+      pdfs +=3D custom_target(output,=0D
+                    input: input,=0D
+                    output: output,=0D
+                    command: [texi2pdf, '-q', docs_inc, '@INPUT0@', '-o', =
'@OUTPUT@'],=0D
+                    build_by_default: false)=0D
+    endforeach=0D
+    alias_target('pdf', pdfs)=0D
+  endif=0D
+=0D
+  texi2pod =3D find_program('scripts/texi2pod.pl')=0D
+  pod2man =3D find_program('pod2man', required: build_docs)=0D
+=0D
+  if pod2man.found()=0D
+    foreach doc, input: texi=0D
+      man =3D doc + '.7'=0D
+      pod =3D custom_target(man + '.pod',=0D
+                          input: input,=0D
+                          output: man + '.pod',=0D
+                          command: [texi2pod,=0D
+                                    '-DVERSION=3D"' + meson.project_versio=
n() + '"',=0D
+                                    '-DCONFDIR=3D"' + config_host['qemu_co=
nfdir'] + '"',=0D
+                                    '@INPUT0@', '@OUTPUT@'])=0D
+      man =3D custom_target(man,=0D
+                          input: pod,=0D
+                          output: man,=0D
+                          capture: true,=0D
+                          install: true,=0D
+                          install_dir: get_option('mandir') / 'man7',=0D
+                          command: [pod2man, '--utf8', '--section=3D7', '-=
-center=3D" "',=0D
+                                    '--release=3D" "', '@INPUT@'])=0D
+    endforeach=0D
+  endif=0D
+endif=0D
+=0D
+if host_machine.system() =3D=3D 'windows'=0D
+  nsis_cmd =3D [=0D
+    find_program('scripts/nsis.py'),=0D
+    '@OUTPUT@',=0D
+    get_option('prefix'),=0D
+    meson.current_source_dir(),=0D
+    host_machine.cpu_family(),=0D
+    '--',=0D
+    '-DDISPLAYVERSION=3D' + meson.project_version(),=0D
+  ]=0D
+  if build_docs=0D
+    nsis_cmd +=3D '-DCONFIG_DOCUMENTATION=3Dy'=0D
+  endif=0D
+  if 'CONFIG_GTK' in config_host=0D
+    nsis_cmd +=3D '-DCONFIG_GTK=3Dy'=0D
+  endif=0D
+=0D
+  nsis =3D custom_target('nsis',=0D
+                       output: 'qemu-setup-' + meson.project_version() + '=
.exe',=0D
+                       input: files('qemu.nsi'),=0D
+                       build_always_stale: true,=0D
+                       command: nsis_cmd + ['@INPUT@'])=0D
+  alias_target('installer', nsis)=0D
+endif=0D
+=0D
+summary_info =3D {}=0D
+summary_info +=3D {'Install prefix':    config_host['prefix']}=0D
+summary_info +=3D {'BIOS directory':    config_host['qemu_datadir']}=0D
+summary_info +=3D {'firmware path':     config_host['qemu_firmwarepath']}=
=0D
+summary_info +=3D {'binary directory':  config_host['bindir']}=0D
+summary_info +=3D {'library directory': config_host['libdir']}=0D
+summary_info +=3D {'module directory':  config_host['qemu_moddir']}=0D
+summary_info +=3D {'libexec directory': config_host['libexecdir']}=0D
+summary_info +=3D {'include directory': config_host['includedir']}=0D
+summary_info +=3D {'config directory':  config_host['sysconfdir']}=0D
+if targetos !=3D 'windows'=0D
+  summary_info +=3D {'local state directory': config_host['qemu_localstate=
dir']}=0D
+  summary_info +=3D {'Manual directory':      get_option('mandir')}=0D
+else=0D
+  summary_info +=3D {'local state directory': 'queried at runtime'}=0D
+endif=0D
+summary_info +=3D {'Doc directory':     get_option('docdir')}=0D
+summary_info +=3D {'Build directory':   meson.current_build_dir()}=0D
+summary_info +=3D {'Source path':       meson.current_source_dir()}=0D
+summary_info +=3D {'GIT binary':        config_host['GIT']}=0D
+summary_info +=3D {'GIT submodules':    config_host['GIT_SUBMODULES']}=0D
+summary_info +=3D {'C compiler':        meson.get_compiler('c').cmd_array(=
)[0]}=0D
+summary_info +=3D {'Host C compiler':   meson.get_compiler('c', native: tr=
ue).cmd_array()[0]}=0D
+if link_language =3D=3D 'cpp'=0D
+  summary_info +=3D {'C++ compiler':      meson.get_compiler('cpp').cmd_ar=
ray()[0]}=0D
+else=0D
+  summary_info +=3D {'C++ compiler':      false}=0D
+endif=0D
+if targetos =3D=3D 'darwin'=0D
+  summary_info +=3D {'Objective-C compiler': meson.get_compiler('objc').cm=
d_array()[0]}=0D
+endif=0D
+summary_info +=3D {'ARFLAGS':           config_host['ARFLAGS']}=0D
+summary_info +=3D {'CFLAGS':            config_host['CFLAGS']}=0D
+summary_info +=3D {'QEMU_CFLAGS':       config_host['QEMU_CFLAGS']}=0D
+summary_info +=3D {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}=0D
+summary_info +=3D {'make':              config_host['MAKE']}=0D
+summary_info +=3D {'install':           config_host['INSTALL']}=0D
+summary_info +=3D {'python':            '@0@ (version: @1@)'.format(python=
.full_path(), python.language_version())}=0D
+summary_info +=3D {'sphinx-build':      config_host['SPHINX_BUILD']}=0D
+summary_info +=3D {'genisoimage':       config_host['GENISOIMAGE']}=0D
+# TODO: add back version=0D
+summary_info +=3D {'slirp support':     config_host.has_key('CONFIG_SLIRP'=
)}=0D
+if config_host.has_key('CONFIG_SLIRP')=0D
+  summary_info +=3D {'smbd':            config_host['CONFIG_SMBD_COMMAND']=
}=0D
+endif=0D
+summary_info +=3D {'module support':    config_host.has_key('CONFIG_MODULE=
S')}=0D
+if config_host.has_key('CONFIG_MODULES')=0D
+  summary_info +=3D {'alternative module path': config_host.has_key('CONFI=
G_MODULE_UPGRADES')}=0D
+endif=0D
+summary_info +=3D {'host CPU':          cpu}=0D
+summary_info +=3D {'host endianness':   build_machine.endian()}=0D
+summary_info +=3D {'target list':       config_host['TARGET_DIRS']}=0D
+summary_info +=3D {'gprof enabled':     config_host.has_key('CONFIG_GPROF'=
)}=0D
+summary_info +=3D {'sparse enabled':    meson.get_compiler('c').cmd_array(=
).contains('cgcc')}=0D
+summary_info +=3D {'strip binaries':    get_option('strip')}=0D
+summary_info +=3D {'profiler':          config_host.has_key('CONFIG_PROFIL=
ER')}=0D
+summary_info +=3D {'static build':      config_host.has_key('CONFIG_TOOLS'=
)}=0D
+if targetos =3D=3D 'darwin'=0D
+  summary_info +=3D {'Cocoa support': config_host.has_key('CONFIG_COCOA')}=
=0D
+endif=0D
+# TODO: add back version=0D
+summary_info +=3D {'SDL support':       sdl.found()}=0D
+summary_info +=3D {'SDL image support': sdl_image.found()}=0D
+# TODO: add back version=0D
+summary_info +=3D {'GTK support':       config_host.has_key('CONFIG_GTK')}=
=0D
+summary_info +=3D {'GTK GL support':    config_host.has_key('CONFIG_GTK_GL=
')}=0D
+summary_info +=3D {'pixman':            pixman.found()}=0D
+# TODO: add back version=0D
+summary_info +=3D {'VTE support':       config_host.has_key('CONFIG_VTE')}=
=0D
+summary_info +=3D {'TLS priority':      config_host['CONFIG_TLS_PRIORITY']=
}=0D
+summary_info +=3D {'GNUTLS support':    config_host.has_key('CONFIG_GNUTLS=
')}=0D
+# TODO: add back version=0D
+summary_info +=3D {'libgcrypt':         config_host.has_key('CONFIG_GCRYPT=
')}=0D
+if config_host.has_key('CONFIG_GCRYPT')=0D
+   summary_info +=3D {'  hmac':            config_host.has_key('CONFIG_GCR=
YPT_HMAC')}=0D
+   summary_info +=3D {'  XTS':             not config_host.has_key('CONFIG=
_QEMU_PRIVATE_XTS')}=0D
+endif=0D
+# TODO: add back version=0D
+summary_info +=3D {'nettle':            config_host.has_key('CONFIG_NETTLE=
')}=0D
+if config_host.has_key('CONFIG_NETTLE')=0D
+   summary_info +=3D {'  XTS':             not config_host.has_key('CONFIG=
_QEMU_PRIVATE_XTS')}=0D
+endif=0D
+summary_info +=3D {'libtasn1':          config_host.has_key('CONFIG_TASN1'=
)}=0D
+summary_info +=3D {'PAM':               config_host.has_key('CONFIG_AUTH_P=
AM')}=0D
+summary_info +=3D {'iconv support':     config_host.has_key('CONFIG_ICONV'=
)}=0D
+summary_info +=3D {'curses support':    config_host.has_key('CONFIG_CURSES=
')}=0D
+# TODO: add back version=0D
+summary_info +=3D {'virgl support':     config_host.has_key('CONFIG_VIRGL'=
)}=0D
+summary_info +=3D {'curl support':      config_host.has_key('CONFIG_CURL')=
}=0D
+summary_info +=3D {'mingw32 support':   targetos =3D=3D 'windows'}=0D
+summary_info +=3D {'Audio drivers':     config_host['CONFIG_AUDIO_DRIVERS'=
]}=0D
+summary_info +=3D {'Block whitelist (rw)': config_host['CONFIG_BDRV_RW_WHI=
TELIST']}=0D
+summary_info +=3D {'Block whitelist (ro)': config_host['CONFIG_BDRV_RO_WHI=
TELIST']}=0D
+summary_info +=3D {'VirtFS support':    config_host.has_key('CONFIG_VIRTFS=
')}=0D
+summary_info +=3D {'Multipath support': config_host.has_key('CONFIG_MPATH'=
)}=0D
+summary_info +=3D {'VNC support':       vnc.found()}=0D
+if vnc.found()=0D
+  summary_info +=3D {'VNC SASL support':  sasl.found()}=0D
+  summary_info +=3D {'VNC JPEG support':  jpeg.found()}=0D
+  summary_info +=3D {'VNC PNG support':   png.found()}=0D
+endif=0D
+summary_info +=3D {'xen support':       config_host.has_key('CONFIG_XEN_BA=
CKEND')}=0D
+if config_host.has_key('CONFIG_XEN_BACKEND')=0D
+  summary_info +=3D {'xen ctrl version':  config_host['CONFIG_XEN_CTRL_INT=
ERFACE_VERSION']}=0D
+endif=0D
+summary_info +=3D {'brlapi support':    config_host.has_key('CONFIG_BRLAPI=
')}=0D
+summary_info +=3D {'Documentation':     config_host.has_key('BUILD_DOCS')}=
=0D
+summary_info +=3D {'PIE':               get_option('b_pie')}=0D
+summary_info +=3D {'vde support':       config_host.has_key('CONFIG_VDE')}=
=0D
+summary_info +=3D {'netmap support':    config_host.has_key('CONFIG_NETMAP=
')}=0D
+summary_info +=3D {'Linux AIO support': config_host.has_key('CONFIG_LINUX_=
AIO')}=0D
+summary_info +=3D {'Linux io_uring support': config_host.has_key('CONFIG_L=
INUX_IO_URING')}=0D
+summary_info +=3D {'ATTR/XATTR support': config_host.has_key('CONFIG_ATTR'=
)}=0D
+summary_info +=3D {'Install blobs':     config_host.has_key('INSTALL_BLOBS=
')}=0D
+# TODO: add back KVM/HAX/HVF/WHPX/TCG=0D
+#summary_info +=3D {'KVM support':       have_kvm'}=0D
+#summary_info +=3D {'HAX support':       have_hax'}=0D
+#summary_info +=3D {'HVF support':       have_hvf'}=0D
+#summary_info +=3D {'WHPX support':      have_whpx'}=0D
+#summary_info +=3D {'TCG support':       have_tcg'}=0D
+#if get_option('tcg')=0D
+#  summary_info +=3D {'TCG debug enabled': config_host.has_key('CONFIG_DEB=
UG_TCG')}=0D
+#  summary_info +=3D {'TCG interpreter':   config_host.has_key('CONFIG_TCG=
_INTERPRETER')}=0D
+#endif=0D
+summary_info +=3D {'malloc trim support': config_host.has_key('CONFIG_MALL=
OC_TRIM')}=0D
+summary_info +=3D {'RDMA support':      config_host.has_key('CONFIG_RDMA')=
}=0D
+summary_info +=3D {'PVRDMA support':    config_host.has_key('CONFIG_PVRDMA=
')}=0D
+summary_info +=3D {'fdt support':       config_host.has_key('CONFIG_FDT')}=
=0D
+summary_info +=3D {'membarrier':        config_host.has_key('CONFIG_MEMBAR=
RIER')}=0D
+summary_info +=3D {'preadv support':    config_host.has_key('CONFIG_PREADV=
')}=0D
+summary_info +=3D {'fdatasync':         config_host.has_key('CONFIG_FDATAS=
YNC')}=0D
+summary_info +=3D {'madvise':           config_host.has_key('CONFIG_MADVIS=
E')}=0D
+summary_info +=3D {'posix_madvise':     config_host.has_key('CONFIG_POSIX_=
MADVISE')}=0D
+summary_info +=3D {'posix_memalign':    config_host.has_key('CONFIG_POSIX_=
MEMALIGN')}=0D
+summary_info +=3D {'libcap-ng support': config_host.has_key('CONFIG_LIBCAP=
_NG')}=0D
+summary_info +=3D {'vhost-net support': config_host.has_key('CONFIG_VHOST_=
NET')}=0D
+summary_info +=3D {'vhost-crypto support': config_host.has_key('CONFIG_VHO=
ST_CRYPTO')}=0D
+summary_info +=3D {'vhost-scsi support': config_host.has_key('CONFIG_VHOST=
_SCSI')}=0D
+summary_info +=3D {'vhost-vsock support': config_host.has_key('CONFIG_VHOS=
T_VSOCK')}=0D
+summary_info +=3D {'vhost-user support': config_host.has_key('CONFIG_VHOST=
_KERNEL')}=0D
+summary_info +=3D {'vhost-user-fs support': config_host.has_key('CONFIG_VH=
OST_USER_FS')}=0D
+summary_info +=3D {'vhost-vdpa support': config_host.has_key('CONFIG_VHOST=
_VDPA')}=0D
+summary_info +=3D {'Trace backends':    config_host['TRACE_BACKENDS']}=0D
+if config_host['TRACE_BACKENDS'].split().contains('simple')=0D
+  summary_info +=3D {'Trace output file': config_host['CONFIG_TRACE_FILE']=
 + '-<pid>'}=0D
+endif=0D
+# TODO: add back protocol and server version=0D
+summary_info +=3D {'spice support':     config_host.has_key('CONFIG_SPICE'=
)}=0D
+summary_info +=3D {'rbd support':       config_host.has_key('CONFIG_RBD')}=
=0D
+summary_info +=3D {'xfsctl support':    config_host.has_key('CONFIG_XFS')}=
=0D
+summary_info +=3D {'smartcard support': config_host.has_key('CONFIG_SMARTC=
ARD')}=0D
+summary_info +=3D {'U2F support':       u2f.found()}=0D
+summary_info +=3D {'libusb':            config_host.has_key('CONFIG_USB_LI=
BUSB')}=0D
+summary_info +=3D {'usb net redir':     config_host.has_key('CONFIG_USB_RE=
DIR')}=0D
+summary_info +=3D {'OpenGL support':    config_host.has_key('CONFIG_OPENGL=
')}=0D
+summary_info +=3D {'OpenGL dmabufs':    config_host.has_key('CONFIG_OPENGL=
_DMABUF')}=0D
+summary_info +=3D {'libiscsi support':  config_host.has_key('CONFIG_LIBISC=
SI')}=0D
+summary_info +=3D {'libnfs support':    config_host.has_key('CONFIG_LIBNFS=
')}=0D
+summary_info +=3D {'build guest agent': config_host.has_key('CONFIG_GUEST_=
AGENT')}=0D
+if targetos =3D=3D 'windows'=0D
+  if 'WIN_SDK' in config_host=0D
+    summary_info +=3D {'Windows SDK':       config_host['WIN_SDK']}=0D
+  endif=0D
+  summary_info +=3D {'QGA VSS support':   config_host.has_key('CONFIG_QGA_=
VSS')}=0D
+  summary_info +=3D {'QGA w32 disk info': config_host.has_key('CONFIG_QGA_=
NTDDSCSI')}=0D
+  summary_info +=3D {'QGA MSI support':   config_host.has_key('CONFIG_QGA_=
MSI_ENABLED')}=0D
+endif=0D
+summary_info +=3D {'seccomp support':   config_host.has_key('CONFIG_SECCOM=
P')}=0D
+summary_info +=3D {'coroutine backend': config_host['CONFIG_COROUTINE_BACK=
END']}=0D
+summary_info +=3D {'coroutine pool':    config_host['CONFIG_COROUTINE_POOL=
'] =3D=3D '1'}=0D
+summary_info +=3D {'debug stack usage': config_host.has_key('CONFIG_DEBUG_=
STACK_USAGE')}=0D
+summary_info +=3D {'mutex debugging':   config_host.has_key('CONFIG_DEBUG_=
MUTEX')}=0D
+summary_info +=3D {'crypto afalg':      config_host.has_key('CONFIG_AF_ALG=
')}=0D
+summary_info +=3D {'GlusterFS support': config_host.has_key('CONFIG_GLUSTE=
RFS')}=0D
+summary_info +=3D {'gcov':              get_option('b_coverage')}=0D
+summary_info +=3D {'TPM support':       config_host.has_key('CONFIG_TPM')}=
=0D
+summary_info +=3D {'libssh support':    config_host.has_key('CONFIG_LIBSSH=
')}=0D
+summary_info +=3D {'QOM debugging':     config_host.has_key('CONFIG_QOM_CA=
ST_DEBUG')}=0D
+summary_info +=3D {'Live block migration': config_host.has_key('CONFIG_LIV=
E_BLOCK_MIGRATION')}=0D
+summary_info +=3D {'lzo support':       config_host.has_key('CONFIG_LZO')}=
=0D
+summary_info +=3D {'snappy support':    config_host.has_key('CONFIG_SNAPPY=
')}=0D
+summary_info +=3D {'bzip2 support':     config_host.has_key('CONFIG_BZIP2'=
)}=0D
+summary_info +=3D {'lzfse support':     config_host.has_key('CONFIG_LZFSE'=
)}=0D
+summary_info +=3D {'zstd support':      config_host.has_key('CONFIG_ZSTD')=
}=0D
+summary_info +=3D {'NUMA host support': config_host.has_key('CONFIG_NUMA')=
}=0D
+summary_info +=3D {'libxml2':           config_host.has_key('CONFIG_LIBXML=
2')}=0D
+summary_info +=3D {'tcmalloc support':  config_host.has_key('CONFIG_TCMALL=
OC')}=0D
+summary_info +=3D {'jemalloc support':  config_host.has_key('CONFIG_JEMALL=
OC')}=0D
+summary_info +=3D {'avx2 optimization': config_host.has_key('CONFIG_AVX2_O=
PT')}=0D
+summary_info +=3D {'avx512f optimization': config_host.has_key('CONFIG_AVX=
512F_OPT')}=0D
+summary_info +=3D {'replication support': config_host.has_key('CONFIG_REPL=
ICATION')}=0D
+summary_info +=3D {'bochs support':     config_host.has_key('CONFIG_BOCHS'=
)}=0D
+summary_info +=3D {'cloop support':     config_host.has_key('CONFIG_CLOOP'=
)}=0D
+summary_info +=3D {'dmg support':       config_host.has_key('CONFIG_DMG')}=
=0D
+summary_info +=3D {'qcow v1 support':   config_host.has_key('CONFIG_QCOW1'=
)}=0D
+summary_info +=3D {'vdi support':       config_host.has_key('CONFIG_VDI')}=
=0D
+summary_info +=3D {'vvfat support':     config_host.has_key('CONFIG_VVFAT'=
)}=0D
+summary_info +=3D {'qed support':       config_host.has_key('CONFIG_QED')}=
=0D
+summary_info +=3D {'parallels support': config_host.has_key('CONFIG_PARALL=
ELS')}=0D
+summary_info +=3D {'sheepdog support':  config_host.has_key('CONFIG_SHEEPD=
OG')}=0D
+summary_info +=3D {'capstone':          config_host.has_key('CONFIG_CAPSTO=
NE')}=0D
+summary_info +=3D {'libpmem support':   config_host.has_key('CONFIG_LIBPME=
M')}=0D
+summary_info +=3D {'libdaxctl support': config_host.has_key('CONFIG_LIBDAX=
CTL')}=0D
+summary_info +=3D {'libudev':           config_host.has_key('CONFIG_LIBUDE=
V')}=0D
+summary_info +=3D {'default devices':   config_host['CONFIG_MINIKCONF_MODE=
'] =3D=3D '--defconfig'}=0D
+summary_info +=3D {'plugin support':    config_host.has_key('CONFIG_PLUGIN=
')}=0D
+summary_info +=3D {'fuzzing support':   config_host.has_key('CONFIG_FUZZ')=
}=0D
+if config_host.has_key('HAVE_GDB_BIN')=0D
+  summary_info +=3D {'gdb':             config_host['HAVE_GDB_BIN']}=0D
+endif=0D
+summary_info +=3D {'thread sanitizer':  config_host.has_key('CONFIG_TSAN')=
}=0D
+summary_info +=3D {'rng-none':          config_host.has_key('CONFIG_RNG_NO=
NE')}=0D
+summary_info +=3D {'Linux keyring':     config_host.has_key('CONFIG_SECRET=
_KEYRING')}=0D
+summary(summary_info, bool_yn: true)=0D
+=0D
+if not supported_cpus.contains(cpu)=0D
+  message()=0D
+  warning('SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!')=0D
+  message()=0D
+  message('CPU host architecture ' + cpu + ' support is not currently main=
tained.')=0D
+  message('The QEMU project intends to remove support for this host CPU in=
')=0D
+  message('a future release if nobody volunteers to maintain it and to')=0D
+  message('provide a build host for our continuous integration setup.')=0D
+  message('configure has succeeded and you can continue to build, but')=0D
+  message('if you care about QEMU on this platform you should contact')=0D
+  message('us upstream at qemu-devel@nongnu.org.')=0D
+endif=0D
+=0D
+if not supported_oses.contains(targetos)=0D
+  message()=0D
+  warning('WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE RELEAS=
ES!')=0D
+  message()=0D
+  message('Host OS ' + targetos + 'support is not currently maintained.')=
=0D
+  message('The QEMU project intends to remove support for this host OS in'=
)=0D
+  message('a future release if nobody volunteers to maintain it and to')=0D
+  message('provide a build host for our continuous integration setup.')=0D
+  message('configure has succeeded and you can continue to build, but')=0D
+  message('if you care about QEMU on this platform you should contact')=0D
+  message('us upstream at qemu-devel@nongnu.org.')=0D
+endif=0D
diff --git a/scripts/undefsym.py b/scripts/undefsym.py
new file mode 100644
index 0000000000..c690f88c7a
--- /dev/null
+++ b/scripts/undefsym.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3=0D
+# -*- coding: utf-8 -*-=0D
+=0D
+# Before a shared module's DSO is produced, a static library is built for =
it=0D
+# and passed to this script.  The script generates -Wl,-u options to force=
=0D
+# the inclusion of symbol from libqemuutil.a if the shared modules need th=
em,=0D
+# This is necessary because the modules may use functions not needed by th=
e=0D
+# executable itself, which would cause the function to not be linked in.=0D
+# Then the DSO loading would fail because of the missing symbol.=0D
+=0D
+=0D
+"""=0D
+Compare the static library with the shared module for compute the symbol d=
uplication=0D
+"""=0D
+=0D
+import sys=0D
+import subprocess=0D
+=0D
+def filter_lines_set(stdout, is_static =3D True):=0D
+    linesSet =3D set()=0D
+    for line in stdout.splitlines():=0D
+        tokens =3D line.split(b' ')=0D
+        if len(tokens) >=3D 1:=0D
+            if len(tokens) > 1:=0D
+                if is_static and tokens[1] =3D=3D b'U':=0D
+                    continue=0D
+                if not is_static and tokens[1] !=3D b'U':=0D
+                    continue=0D
+            new_line =3D b'-Wl,-u,' + tokens[0]=0D
+            if not new_line in linesSet:=0D
+                linesSet.add(new_line)=0D
+    return linesSet=0D
+=0D
+def main(args):=0D
+    if len(args) <=3D 3:=0D
+        sys.exit(0)=0D
+=0D
+    nm =3D args[1]=0D
+    staticlib =3D args[2]=0D
+    pc =3D subprocess.run([nm, "-P", "-g", staticlib], stdout=3Dsubprocess=
.PIPE)=0D
+    if pc.returncode !=3D 0:=0D
+        sys.exit(-1)=0D
+    lines_set_left =3D filter_lines_set(pc.stdout)=0D
+=0D
+    shared_modules =3D args[3:]=0D
+    pc =3D subprocess.run([nm, "-P", "-g"] + shared_modules, stdout=3Dsubp=
rocess.PIPE)=0D
+    if pc.returncode !=3D 0:=0D
+        sys.exit(-1)=0D
+    lines_set_right =3D filter_lines_set(pc.stdout, False)=0D
+    lines =3D []=0D
+    for line in sorted(list(lines_set_right)):=0D
+        if line in lines_set_left:=0D
+            lines.append(line)=0D
+    sys.stdout.write(b'\n'.join(lines).decode())=0D
+=0D
+if __name__ =3D=3D "__main__":=0D
+    main(sys.argv)=0D
diff --git a/scripts/undefsym.sh b/scripts/undefsym.sh
deleted file mode 100755
index b9ec332e95..0000000000
--- a/scripts/undefsym.sh
+++ /dev/null
@@ -1,20 +0,0 @@
-#! /usr/bin/env bash
-
-# Before a shared module's DSO is produced, a static library is built for =
it
-# and passed to this script.  The script generates -Wl,-u options to force
-# the inclusion of symbol from libqemuutil.a if the shared modules need th=
em,
-# This is necessary because the modules may use functions not needed by the
-# executable itself, which would cause the function to not be linked in.
-# Then the DSO loading would fail because of the missing symbol.
-
-if test $# -le 2; then
-  exit 0
-fi
-
-NM=3D$1
-staticlib=3D$2
-shift 2
-# Find symbols defined in static libraries and undefined in shared modules
-comm -12 \
-  <( $NM -P -g $staticlib | awk '$2!=3D"U"{print "-Wl,-u," $1}' | sort -u)=
 \
-  <( $NM -P -g "$@" | awk '$2=3D=3D"U"{print "-Wl,-u," $1}' | sort -u)
--=20
2.28.0.windows.1


