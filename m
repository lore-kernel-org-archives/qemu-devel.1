Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7668FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 20:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CAD21848
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 20:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFR/6zoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CAD21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN0tX-0005Ml-BP
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 16:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iN0sl-0004nK-8C
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 16:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iN0sj-0001yM-Cf
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 16:35:54 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:40489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iN0sj-0001yI-59; Tue, 22 Oct 2019 16:35:53 -0400
Received: by mail-oi1-x22c.google.com with SMTP id b25so3774390oib.7;
 Tue, 22 Oct 2019 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=YPmj/nroWY0pTnSVHHA4UhdKmPCO0A3bdgtwqRgYaGo=;
 b=DFR/6zoeVy6/EZZquIR4CKBenL9MCjSYmfcOatm/SFh2JfvsQGJJtk3gsSqYiNWPim
 sTPbyTIrJb726fC/REzZmiYwFN3v2MuL55rQT4GRi3uA4nEzlQzTiuA4AgyfKOXleEd3
 9itqkBs//KECiYMu2XsU5YCSpuUwrQiDEtcKkRzz0SlGH04PqcsVJ8deKupznYK7ZEaM
 kPG3mjObZgidxuX60sdZfcp/0iFNNFgjgo7T9LSnjEXDt9jUIOtWa8VyJm+Jzsbsdc2U
 cHBJMU0SbzJwSsGaC57gPeRYgQA4engp4TZoBd0cIR7wYK296eyBRNLjJR6VP7ISsZnw
 G5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=YPmj/nroWY0pTnSVHHA4UhdKmPCO0A3bdgtwqRgYaGo=;
 b=hfHxaj2QgRRYDcyTnJQ05avruiB/pNZJSZ/AuOzeyf1qpgl9l7V4Xrw0d4aghKI6cR
 m3l7Y+5DlJSwYE7LV/cZrmb0nMGOaXH2YF1FRTOMS3LRhl9SJwq+ysH1LgfMpdakj2OI
 7wnXsaUGtTwVj0/107KbBnFQGuicutywe4F+c28+WnqwXrrt1sjQEWdRxM0HLv2+DXyp
 I56IxjEglHW+939xS5OfmweCGCtx0h4zA7U/tuznV5c1bVEdRAc247wYGyo/OnEO3/Wk
 2D5BFG4zCnqpTwNwcCIE35x+/NOYyFOBvOfWxrfjl2sEXVMOAmM1k/hIUCbjUL0tAPxY
 mUEw==
X-Gm-Message-State: APjAAAXZF3LGXMyDaTQbxew1pdBC1u/KliStAUwzDDkmZTPkPaJLjDPh
 4l4Ru1s+l07VpUapjSgNxoHf+1SdewApxCvI2nM=
X-Google-Smtp-Source: APXvYqy5CEdCgvPAm5uRl5gixuERACt1C00QNn6PxVDKprY7gloOD6Eyig0YnOSySs1jluNMdMT0SF/eIW3hBkJljFs=
X-Received: by 2002:aca:4d12:: with SMTP id a18mr4382186oib.79.1571776552341; 
 Tue, 22 Oct 2019 13:35:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Tue, 22 Oct 2019 13:35:51
 -0700 (PDT)
In-Reply-To: <20191008082815.8267-1-thuth@redhat.com>
References: <20191008082815.8267-1-thuth@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 22 Oct 2019 22:35:51 +0200
Message-ID: <CAL1e-=ihiQiFptBKHyVEo_DZv5xHwa7eGuM7UFLo_c5DbYtxhA@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Remove generated files when doing
 'distclean' (and 'clean')
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000119323059585bf78"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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

--000000000000119323059585bf78
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
> Hello, Thomas,

Do you intend to send a new version of this patch?

It looks to me this is a very nice clean up that definitely should go into
4.2, no?

Aleksandat



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
>  # Build the help program automatically
>
>  all: $(QEMU_IOTESTS_HELPERS-y)
> --
> 2.18.1
>
>
>

--000000000000119323059585bf78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 8, 2019, Thomas Huth &lt;<a href=3D"mailto:thut=
h@redhat.com">thuth@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">When running &quot;make distclean&quot; we currently leave a lot of ge=
nerated<br>
files in the build directory. These should be completely removed.<br>
Some of the generated files are removed in the &quot;clean&quot; target (wh=
ich<br>
is a prerequisite for the &quot;distclean&quot; target), since binary files=
<br>
should be removed in this step already.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@re=
dhat.com</a>&gt;<br>
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
<br></blockquote><div>Hello, Thomas,</div><div><br></div><div>Do you intend=
 to send a new version of this patch?</div><div><br></div><div>It looks to =
me this is a very nice clean up that definitely should go into 4.2, no?</di=
v><div><br></div><div>Aleksandat</div><div><br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
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
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f trace/generated-tracers-<wbr>dtrace.dtrac=
e*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f trace/generated-tracers-<wbr>dtrace.h*<br=
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
+<br>
=C2=A0# Build the help program automatically<br>
<br>
=C2=A0all: $(QEMU_IOTESTS_HELPERS-y)<br>
-- <br>
2.18.1<br>
<br>
<br>
</blockquote>

--000000000000119323059585bf78--

