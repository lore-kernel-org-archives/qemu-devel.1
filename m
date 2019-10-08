Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928ACC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F82206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxnq09SC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F82206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHoTu-00029n-F2
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iHoS1-0001O4-Gb
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iHoRz-0002Op-JY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:18:49 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:41823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iHoRx-0002F9-B6; Tue, 08 Oct 2019 08:18:45 -0400
Received: by mail-oi1-x231.google.com with SMTP id w65so14559511oiw.8;
 Tue, 08 Oct 2019 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Ha/roMY7Eb8mAwoWURrGovkTOvHU3cGJLEhBffqxlq4=;
 b=Nxnq09SCh+j+HK0fxsRqjH+smRkjvQFjAXP4/gGHX85garg2NvAp+K/+llMynYRbD3
 Mro9CvWvbuF75he8hJe9ihGLbnB9UnmN/1XAp3BgYS/q1LYqh/+hyG7fh2r3vTjoKJYl
 /rtiD06pEWrDG2XR5r5fdwFeny4x3n2lUd8VPxaKdj1O+Tyup+NIqhdo3JqGh8gFYdcE
 2LEeaEENCkVlWow58yF+LVZWsX2q/cRqY4FD1QiFT0tisZBTiiZBw/tLecsg4dl6hxaf
 mOmegBYL3B39OWG6GAxEZSKaclt0He+3A5sQEEHuDabG1OHvkqPJYZGAX4t8+p3V/wgm
 G6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Ha/roMY7Eb8mAwoWURrGovkTOvHU3cGJLEhBffqxlq4=;
 b=Norbp7FEZ7YhAmjJpziH5eYrydNjjeC7/Q7Hay43ApqIXEOYz04GU5/Zkm9IG/qEQT
 sM1no1SbVmby7+xZs6Dtq8SjTB6TOa3s+jHDybY+40a1wYAsS7U+ta7KXWlwxju1iPPG
 lxALfHP+hYFbnK6MrSfdIAl21AtKaaWwiso9ZXvvV4uprO5wUG/ArhOrSDLpHPQbQ03c
 kiRL15XuDjRKM+wzCkRNFDEBINdtangYw8oM+aXizmpqKe39ej73ai7aUqdUdj0Sk85H
 fukC6CoxBItTabc9om5/ZIQlEDYGoMQWFLuEdLxdoZaQIUbsXCTJnMsyMcwobj4pQpBZ
 I/1w==
X-Gm-Message-State: APjAAAUrmvAKLNJbZ6pO8IFbauPm+tlyJQdoHQ4pqgXNixsUzer/0v1n
 /ZpRI61oICjy7QXxzcaJMJSn0c+GYikyilu6WaI=
X-Google-Smtp-Source: APXvYqyyeKRJYJ0dOkxc+K2qovl/CdAyaZJ/RO04KhRhKVPXHRvvOlbkPtVoBlISQq7SBCnOmLM8cK7xFtElsApnFPI=
X-Received: by 2002:aca:c5cb:: with SMTP id v194mr3479205oif.106.1570537122936; 
 Tue, 08 Oct 2019 05:18:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Tue, 8 Oct 2019 05:18:42 -0700 (PDT)
In-Reply-To: <20191008082815.8267-1-thuth@redhat.com>
References: <20191008082815.8267-1-thuth@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 8 Oct 2019 14:18:42 +0200
Message-ID: <CAL1e-=gYkhM99Ee0LxZJ5dCjeEdC08G4_Tm3WCZpCSWvJ=b26Q@mail.gmail.com>
Subject: [PATCH v2] Makefile: Remove generated files when doing 'distclean'
 (and 'clean')
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000051bc140594652b0a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000051bc140594652b0a
Content-Type: text/plain; charset="UTF-8"

On Tuesday, October 8, 2019, Thomas Huth <thuth@redhat.com> wrote:

> When running "make distclean" we currently leave a lot of generated
> files in the build directory. These should be completely removed.
> Some of the generated files are removed in the "clean" target (which
> is a prerequisite for the "distclean" target), since binary files
> should be removed in this step already.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Remove tests/qemu-iotests/common.env in "distclean", not in "clean"
>  - Improved patch description
>
>  Makefile               |  6 +++---
>  tests/Makefile.include | 12 +++++++++++-
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 30f0abfb42..767b1ffb25 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -696,14 +696,14 @@ clean: recurse-clean
>                 -exec rm {} +
>         rm -f $(edk2-decompressed)
>         rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.*
> *.pod *~ */*~
> -       rm -f fsdev/*.pod scsi/*.pod
> +       rm -f fsdev/*.pod scsi/*.pod docs/*.pod docs/*/*.pod
> docs/*/.buildinfo
>         rm -f qemu-img-cmds.h
>         rm -f ui/shader/*-vert.h ui/shader/*-frag.h
>         @# May not be present in generated-files-y
>         rm -f trace/generated-tracers-dtrace.dtrace*
>         rm -f trace/generated-tracers-dtrace.h*
>         rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
> -       rm -f qapi-gen-timestamp
> +       rm -f qapi-gen-timestamp vhost-user-input
>         rm -rf qga/qapi-generated
>         rm -f config-all-devices.mak
>
> @@ -724,7 +724,7 @@ distclean: clean
>         rm -f tests/tcg/config-*.mak
>         rm -f config-all-devices.mak config-all-disas.mak config.status
>         rm -f $(SUBDIR_DEVICES_MAK)
> -       rm -f po/*.mo tests/qemu-iotests/common.env
> +       rm -f po/*.mo
>         rm -f roms/seabios/config.mak roms/vgabios/config.mak
>         rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
>         rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky
> qemu-doc.kys
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3543451ed3..694f193fb6 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1176,11 +1176,21 @@ check: check-block check-qapi-schema check-unit
> check-softfloat check-qtest chec
>  check-clean:
>         rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>         rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST),
> $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
> -       rm -f tests/test-qapi-gen-timestamp
>         rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
> +       rm -f tests/test-qapi-gen-timestamp tests/qht-bench$(EXESUF) \
> +               tests/fp/fp-test tests/fp/*.out tests/qapi-schema/*.test.*
>
>  clean: check-clean
>
> +check-distclean:
> +       rm -f tests/qemu-iotests/common.env tests/qemu-iotests/check.*
> +       rm -f tests/test-qapi-types*.c tests/test-qapi-visit*.c \
> +               tests/test-qapi-commands*.c tests/test-qapi-events*.c \
> +               tests/test-qapi-emit-events.[ch]
> tests/test-qapi-introspect.c \
> +               tests/include/test-qapi-*.c
> +
> +distclean: check-distclean
> +


Sorry for bad email format, I have some difficultues with mail accounts and
 mail clients.

Thomas,

If I remember well, QAPI-related c files are generated while doing 'make'.
If that is true, these files should be deleted by 'make clean', shouldn't
they?

Thanks,
Aleksandar



>  # Build the help program automatically
>
>  all: $(QEMU_IOTESTS_HELPERS-y)
> --
> 2.18.1
>
>
>

--00000000000051bc140594652b0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 8, 2019, Thomas Huth &lt;<a href=3D"mailto:thut=
h@redhat.com" target=3D"_blank">thuth@redhat.com</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">When running &quot;make distclean&quot; we currently=
 leave a lot of generated<br>
files in the build directory. These should be completely removed.<br>
Some of the generated files are removed in the &quot;clean&quot; target (wh=
ich<br>
is a prerequisite for the &quot;distclean&quot; target), since binary files=
<br>
should be removed in this step already.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0v2:<br>
=C2=A0- Remove tests/qemu-iotests/common.env in &quot;distclean&quot;, not =
in &quot;clean&quot;<br>
=C2=A0- Improved patch description<br>
<br>
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 6 +++---<br>
=C2=A0tests/Makefile.include | 12 +++++++++++-<br>
=C2=A02 files changed, 14 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/Makefile b/Makefile<br>
index 30f0abfb42..767b1ffb25 100644<br>
--- a/Makefile<br>
+++ b/Makefile<br>
@@ -696,14 +696,14 @@ clean: recurse-clean<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -exec rm {} +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f $(edk2-decompressed)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y)=
 TAGS cscope.* *.pod *~ */*~<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f fsdev/*.pod scsi/*.pod<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f fsdev/*.pod scsi/*.pod docs/*.pod docs/*/=
*.pod docs/*/.buildinfo<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f qemu-img-cmds.h<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f ui/shader/*-vert.h ui/shader/*-frag.h<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @# May not be present in generated-files-y<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f trace/generated-tracers-dtrace<wbr>.dtrac=
e*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f trace/generated-tracers-dtrace<wbr>.h*<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f $(foreach f,$(generated-files-y),$(f) $(f=
)-timestamp)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f qapi-gen-timestamp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f qapi-gen-timestamp vhost-user-input<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf qga/qapi-generated<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f config-all-devices.mak<br>
<br>
@@ -724,7 +724,7 @@ distclean: clean<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f tests/tcg/config-*.mak<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f config-all-devices.mak config-all-disas.m=
ak config.status<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f $(SUBDIR_DEVICES_MAK)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f po/*.mo tests/qemu-iotests/common.env<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f po/*.mo<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f roms/seabios/config.mak roms/vgabios/conf=
ig.mak<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f <a href=3D"http://qemu-doc.info" target=
=3D"_blank">qemu-doc.info</a> qemu-doc.aux qemu-doc.cp qemu-doc.cps<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f qemu-doc.fn qemu-doc.fns <a href=3D"http:=
//qemu-doc.info" target=3D"_blank">qemu-doc.info</a> <a href=3D"http://qemu=
-doc.ky" target=3D"_blank">qemu-doc.ky</a> qemu-doc.kys<br>
diff --git a/tests/Makefile.include b/tests/Makefile.include<br>
index 3543451ed3..694f193fb6 100644<br>
--- a/tests/Makefile.include<br>
+++ b/tests/Makefile.include<br>
@@ -1176,11 +1176,21 @@ check: check-block check-qapi-schema check-unit che=
ck-softfloat check-qtest chec<br>
=C2=A0check-clean:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS=
_HELPERS-y)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_=
LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/test-qapi-gen-timestamp<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/test-qapi-gen-timestamp tests/qht-b=
ench$(EXESUF) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/fp/fp-test te=
sts/fp/*.out tests/qapi-schema/*.test.*<br>
<br>
=C2=A0clean: check-clean<br>
<br>
+check-distclean:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/qemu-iotests/common.env tests/qemu-=
iotests/check.*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/test-qapi-types*.c tests/test-qapi-=
visit*.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/test-qapi-com=
mands*.c tests/test-qapi-events*.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/test-qapi-emi=
t-events.[<wbr>ch] tests/test-qapi-introspect.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/include/test-=
qapi-*.c<br>
+<br>
+distclean: check-distclean<br>
+</blockquote><div><br></div><div>Sorry for bad email format, I have some d=
ifficultues with mail accounts and =C2=A0mail clients.</div><div><br></div>=
<div>Thomas,</div><div><br></div><div>If I remember well, QAPI-related c fi=
les are generated while doing &#39;make&#39;. If that is true, these files =
should be deleted by &#39;make clean&#39;, shouldn&#39;t they?</div><div><b=
r></div><div>Thanks,</div><div>Aleksandar</div><div><br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
=C2=A0# Build the help program automatically<br>
<br>
=C2=A0all: $(QEMU_IOTESTS_HELPERS-y)<br>
-- <br>
2.18.1<br>
<br>
<br>
</blockquote>

--00000000000051bc140594652b0a--

