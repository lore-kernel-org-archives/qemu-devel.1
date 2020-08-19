Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E0DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 01:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EB3204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 01:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="BwCaOZW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EB3204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=comstyle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8DMP-0001ln-DY
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 21:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1k8DLg-0001Md-RQ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 21:57:08 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]:40795
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1k8DLe-0005HM-Oe
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 21:57:08 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4BWWBx2M5Gz8PbJ;
 Tue, 18 Aug 2020 21:58:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=subject:to
 :cc:references:from:message-id:date:mime-version:in-reply-to
 :content-type:content-transfer-encoding; s=default; bh=NS7k7Lh6B
 EFG/E4Fk5xgwiyiOOE=; b=BwCaOZW36vVmg6at0bSD0lqjKQbBYuSiYfpqAcJHc
 SL7K7Nvu8J0DEP5gA/Zxt2EQUWvic5ZUavp1h88qzWmRSpcqxGM6/elCvUjSp34N
 GWblDtD/N4Ex3dSVPbjZXC29Obrt6uR5YwuKISS7T5Dx+Q0A100LeAL1ZuV85eGT
 HY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=subject:to
 :cc:references:from:message-id:date:mime-version:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=icX
 QhCweJHXtfB2EMTHY26zcmDDj0TQ8RGae+OeMbdJ2EGkFKxL48RMjtG9w6EDxDk7
 ZZA1l+rdBDWGRNGt7ARPgjp2qz4a/DJAj9JJgBz9YiP+UW2qdiRAaN6SxKcOJv8K
 G6lzQOD4evbu/T78b6SNokTwPy8q5xRHbUjausnM=
Received: from [192.168.6.30]
 (bras-vprn-toroon2719w-lp130-20-50-101-192-154.dsl.bell.ca [50.101.192.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4BWWBx1TVMz8Pb7;
 Tue, 18 Aug 2020 21:58:01 -0400 (EDT)
Subject: Re: [PULL 147/150] meson: convert po/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
 <20200818141025.21608-148-pbonzini@redhat.com>
From: Brad Smith <brad@comstyle.com>
Message-ID: <ee10449d-d36e-7138-42e2-1c6cdb68320a@comstyle.com>
Date: Tue, 18 Aug 2020 21:56:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200818141025.21608-148-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/2020 10:10 AM, Paolo Bonzini wrote:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Meson warns if xgettext is not found.  In the future we may want to add
> a required argument to i18n.gettext(); in the meanwhile, I am adding a
> --enable-gettext/--disable-gettext option and feature detection in
> configure.  This preserves QEMU's default behavior of detecting system
> features, without any warning, if neither --enable-* nor --disable-*
> is requested.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   Makefile          |  5 +---
>   configure         | 21 +++++++++++++-
>   meson.build       |  3 ++
>   meson_options.txt |  1 +
>   po/LINGUAS        |  8 +++++
>   po/Makefile       | 52 ---------------------------------
>   po/POTFILES       |  1 +
>   po/meson.build    |  7 +++++
>   po/messages.po    | 74 ----------------------------------------------=
-
>   tests/vm/freebsd  |  1 +
>   tests/vm/netbsd   |  1 +
>   tests/vm/openbsd  |  1 +
>   12 files changed, 44 insertions(+), 131 deletions(-)
>   create mode 100644 po/LINGUAS
>   delete mode 100644 po/Makefile
>   create mode 100644 po/POTFILES
>   create mode 100644 po/meson.build
>   delete mode 100644 po/messages.po
>
> diff --git a/Makefile b/Makefile
> index bbb27f7981..8ba5990504 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -210,7 +210,7 @@ distclean: clean ninja-distclean
>   	rm -f config-host.mak config-host.h*
>   	rm -f tests/tcg/config-*.mak
>   	rm -f config-all-disas.mak config.status
> -	rm -f po/*.mo tests/qemu-iotests/common.env
> +	rm -f tests/qemu-iotests/common.env
>   	rm -f roms/seabios/config.mak roms/vgabios/config.mak
>   	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
>   	rm -f *-config-target.h *-config-devices.mak *-config-devices.h
> @@ -288,9 +288,6 @@ endif
>   	mkdir -p "$(DESTDIR)$(qemu_desktopdir)"
>   	$(INSTALL_DATA) $(SRC_PATH)/ui/qemu.desktop \
>   		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
> -ifdef CONFIG_GTK
> -	$(MAKE) -C po $@
> -endif
>   	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
>   	set -e; for x in $(KEYMAPS); do \
>   		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_d=
atadir)/keymaps"; \
> diff --git a/configure b/configure
> index 86f384be29..0167822204 100755
> --- a/configure
> +++ b/configure
> @@ -522,6 +522,7 @@ rng_none=3D"no"
>   secret_keyring=3D""
>   libdaxctl=3D""
>   meson=3D""
> +gettext=3D""
>  =20
>   bogus_os=3D"no"
>   malloc_trim=3D""
> @@ -1112,6 +1113,10 @@ for opt do
>     ;;
>     --enable-vnc) vnc=3D"enabled"
>     ;;
> +  --disable-gettext) gettext=3D"false"
> +  ;;
> +  --enable-gettext) gettext=3D"true"
> +  ;;
>     --oss-lib=3D*) oss_lib=3D"$optarg"
>     ;;
>     --audio-drv-list=3D*) audio_drv_list=3D"$optarg"
> @@ -2983,6 +2988,19 @@ if test "$whpx" !=3D "no" ; then
>       fi
>   fi
>  =20
> +##########################################
> +# gettext probe
> +if test "$gettext" !=3D "false" ; then
> +  if has xgettext; then
> +    gettext=3Dtrue
> +  else
> +    if test "$gettext" =3D "true" ; then
> +      feature_not_found "gettext" "Install xgettext binary"
> +    fi
> +    gettext=3Dfalse
> +  fi
> +fi
> +
>   ##########################################
>   # Sparse probe
>   if test "$sparse" !=3D "no" ; then
> @@ -8047,7 +8065,7 @@ DIRS=3D"$DIRS docs docs/interop fsdev scsi"
>   DIRS=3D"$DIRS pc-bios/optionrom pc-bios/s390-ccw"
>   DIRS=3D"$DIRS roms/seabios"
>   LINKS=3D"Makefile"
> -LINKS=3D"$LINKS tests/tcg/lm32/Makefile po/Makefile"
> +LINKS=3D"$LINKS tests/tcg/lm32/Makefile"
>   LINKS=3D"$LINKS tests/tcg/Makefile.target"
>   LINKS=3D"$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
>   LINKS=3D"$LINKS pc-bios/s390-ccw/Makefile"
> @@ -8179,6 +8197,7 @@ NINJA=3D$PWD/ninjatool $meson setup \
>           -Db_coverage=3D$(if test "$gcov" =3D yes; then echo true; els=
e echo false; fi) \
>   	-Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \
>   	-Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg -Dvnc_png=
=3D$vnc_png \
> +	-Dgettext=3D$gettext \
>           $cross_arg \
>           "$PWD" "$source_path"
>  =20
> diff --git a/meson.build b/meson.build
> index afe684cbad..57cfa8723d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1108,6 +1108,9 @@ subdir('tools')
>   subdir('pc-bios')
>   subdir('tests')
>   subdir('docs')
> +if 'CONFIG_GTK' in config_host
> +  subdir('po')
> +endif
>  =20
>   if build_docs
>     makeinfo =3D find_program('makeinfo', required: build_docs)
> diff --git a/meson_options.txt b/meson_options.txt
> index 67455c57bc..e5f45243ce 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -1,3 +1,4 @@
> +option('gettext', type : 'boolean', value : true)
>   option('sdl', type : 'feature', value : 'auto')
>   option('sdl_image', type : 'feature', value : 'auto')
>   option('vnc', type : 'feature', value : 'enabled')
> diff --git a/po/LINGUAS b/po/LINGUAS
> new file mode 100644
> index 0000000000..cc4b5c3b36
> --- /dev/null
> +++ b/po/LINGUAS
> @@ -0,0 +1,8 @@
> +bg
> +de_DE
> +fr_FR
> +hu
> +it
> +sv
> +tr
> +zh_CN
> diff --git a/po/Makefile b/po/Makefile
> deleted file mode 100644
> index c041f4c858..0000000000
> --- a/po/Makefile
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -# This makefile is very special as it's meant to build as part of the =
build
> -# process and also within the source tree to update the translation fi=
les.
> -
> -# Set SRC_PATH for in-tree builds without configuration.
> -SRC_PATH=3D..
> -
> -# The default target must come before any include statements.
> -all:
> -
> -.PHONY:	all build clean install update
> -
> -%.mo: %.po
> -	$(call quiet-command, msgfmt -o $@ $<,"GEN","$@")
> -
> --include ../config-host.mak
> -include $(SRC_PATH)/rules.mak
> -
> -PO_PATH=3D$(SRC_PATH)/po
> -
> -VERSION=3D$(shell cat $(SRC_PATH)/VERSION)
> -SRCS=3D$(filter-out $(PO_PATH)/messages.po,$(wildcard $(PO_PATH)/*.po)=
)
> -OBJS=3D$(patsubst $(PO_PATH)/%.po,%.mo,$(SRCS))
> -
> -vpath %.po $(PO_PATH)
> -
> -all:
> -	@echo "Use 'make update' to update translation files or use 'make bui=
ld'"
> -	@echo "or 'make install' to build and install the translation files."
> -
> -update: $(SRCS)
> -
> -build: $(OBJS)
> -
> -clean:
> -	rm -f $(OBJS)
> -
> -install: $(OBJS)
> -	for obj in $(OBJS); do \
> -	    base=3D$$(basename $$obj .mo); \
> -	    $(INSTALL) -d $(DESTDIR)$(prefix)/share/locale/$$base/LC_MESSAGES=
; \
> -	    $(INSTALL) -m644 $$obj $(DESTDIR)$(prefix)/share/locale/$$base/LC=
_MESSAGES/qemu.mo; \
> -	done
> -
> -$(PO_PATH)/messages.po: $(SRC_PATH)/ui/gtk.c
> -	$(call quiet-command, ( cd $(SRC_PATH) && \
> -          xgettext -o - --from-code=3DUTF-8 --foreign-user --no-locati=
on \
> -	    --package-name=3DQEMU --package-version=3D$(VERSION) \
> -	    --msgid-bugs-address=3Dqemu-devel@nongnu.org -k_ -C ui/gtk.c | \
> -	  sed -e s/CHARSET/UTF-8/) >$@,"GEN","$@")
> -
> -$(PO_PATH)/%.po: $(PO_PATH)/messages.po
> -	$(call quiet-command, msgmerge -q $@ $< > $@.bak && mv $@.bak $@,"GEN=
","$@")
> diff --git a/po/POTFILES b/po/POTFILES
> new file mode 100644
> index 0000000000..d34d5ed9aa
> --- /dev/null
> +++ b/po/POTFILES
> @@ -0,0 +1 @@
> +ui/gtk.c
> diff --git a/po/meson.build b/po/meson.build
> new file mode 100644
> index 0000000000..1387fd979a
> --- /dev/null
> +++ b/po/meson.build
> @@ -0,0 +1,7 @@
> +i18n =3D import('i18n')
> +
> +if get_option('gettext')
> +  i18n.gettext(meson.project_name(),
> +               args: '--msgid-bugs-address=3Dqemu-devel@nongnu.org',
> +               preset: 'glib')
> +endif
> diff --git a/po/messages.po b/po/messages.po
> deleted file mode 100644
> index 065bd459a0..0000000000
> --- a/po/messages.po
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -# SOME DESCRIPTIVE TITLE.
> -# This file is put in the public domain.
> -# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
> -#
> -#, fuzzy
> -msgid ""
> -msgstr ""
> -"Project-Id-Version: QEMU 2.12.91\n"
> -"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
> -"POT-Creation-Date: 2018-07-18 07:56+0200\n"
> -"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
> -"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
> -"Language-Team: LANGUAGE <LL@li.org>\n"
> -"Language: \n"
> -"MIME-Version: 1.0\n"
> -"Content-Type: text/plain; charset=3DUTF-8\n"
> -"Content-Transfer-Encoding: 8bit\n"
> -
> -msgid " - Press Ctrl+Alt+G to release grab"
> -msgstr ""
> -
> -msgid " [Paused]"
> -msgstr ""
> -
> -msgid "_Pause"
> -msgstr ""
> -
> -msgid "_Reset"
> -msgstr ""
> -
> -msgid "Power _Down"
> -msgstr ""
> -
> -msgid "_Quit"
> -msgstr ""
> -
> -msgid "_Fullscreen"
> -msgstr ""
> -
> -msgid "_Copy"
> -msgstr ""
> -
> -msgid "Zoom _In"
> -msgstr ""
> -
> -msgid "Zoom _Out"
> -msgstr ""
> -
> -msgid "Best _Fit"
> -msgstr ""
> -
> -msgid "Zoom To _Fit"
> -msgstr ""
> -
> -msgid "Grab On _Hover"
> -msgstr ""
> -
> -msgid "_Grab Input"
> -msgstr ""
> -
> -msgid "Show _Tabs"
> -msgstr ""
> -
> -msgid "Detach Tab"
> -msgstr ""
> -
> -msgid "Show Menubar"
> -msgstr ""
> -
> -msgid "_Machine"
> -msgstr ""
> -
> -msgid "_View"
> -msgstr ""


This last part is redundant. If glib2 and/or gtk+3 is installed then gett=
ext
is installed.

The package name is wrong as well as gettext changed from gettext to
gettext-runtime relatively recently.


> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index b34b14fc53..5f866e09c4 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -39,6 +39,7 @@ class FreeBSDVM(basevm.BaseVM):
>           "bash",
>           "gmake",
>           "gsed",
> +        "gettext",
>  =20
>           # libs: crypto
>           "gnutls",
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 93d48b6fdd..ffb65a89be 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -37,6 +37,7 @@ class NetBSDVM(basevm.BaseVM):
>           "bash",
>           "gmake",
>           "gsed",
> +        "gettext",
>  =20
>           # libs: crypto
>           "gnutls",
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 7e27fda642..8356646f21 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -36,6 +36,7 @@ class OpenBSDVM(basevm.BaseVM):
>           "bash",
>           "gmake",
>           "gsed",
> +        "gettext",
>  =20
>           # libs: usb
>           "libusb1",

