Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4115CC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0248821655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaqF/EMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0248821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBleD-0002dv-7z
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 16:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:61000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBldR-00025v-Ut
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBldQ-0002hM-KB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:37:53 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37323)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBldN-0002dK-SN; Tue, 10 Mar 2020 16:37:49 -0400
Received: by mail-io1-xd43.google.com with SMTP id k4so14227235ior.4;
 Tue, 10 Mar 2020 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MvAZVxuil2DxjBj7rVmkBNCfZoBmbXssfX+/IEcrzlc=;
 b=QaqF/EMeKtroURm0XbhyO7p57iwdEtTS3beUzi0GidKNQhhZ1qKkWeqKlKVKYXkJ/b
 vEn9Uov/mFXUxrkDv5nY0wSo5vbdbwCUULBi6WCPv0eCOD/1m6uH29jUMcD5fQqbyfhM
 X4bTV8Y6JPzHO1aStG3xMPrWPFsJ5CH5xpTCgBoXbzbdmOIH1BM37oA7w4ePgxM+UQVn
 HdzG9rMjV0ALYNgRvLbP8ggIHRTB5XbObxGpNDkeGTiWjkIcGbskl0cMJnpBXcZ17uPF
 DISlt7frKIHW3NGt1w1GLhXHAtXfSPQtKS6WLnypmAc28ZhFeA56UdWne3UFG5vHPKvJ
 Ggog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MvAZVxuil2DxjBj7rVmkBNCfZoBmbXssfX+/IEcrzlc=;
 b=fn13HsIs7CJtAWP0tEeFwpcoJaEyg0xdS12mXWhELMdwHTMOpSgHjwTdiiQP02AyP4
 7dUA7dQaKJUo6T88kI1lD43UuLfl3bLxjJ2pBDuQt2Ert7uFFTU7PC2Gx2jkSilA9xWM
 W5oMJcv98VILrnrVuUyTi5r+9NDnZVJr0A3SmmXd6QuhF6Xin2x9m4K0rtPCjR8yXW6Z
 z99vJl9auYwdwxhR5qXiOf8beJwdcQBbalRvXEuimbEadW94xC9rlPefR0JPiscEoGTi
 5r2+0dUmhPgjmHZiX+dRezCsuabR4MdwJyk36DS2MRQNXpdWu6H8HsN/6claSBumaFwh
 A7OA==
X-Gm-Message-State: ANhLgQ2g+EfLaJukYeLyI7Y65MgEGrI7dP2jZP/dOySRrIxHVCuUatzE
 yedt3s3kuze/imWFOEBz40SVyuqNzu/xL66scQk=
X-Google-Smtp-Source: ADFU+vsjIxVAnBDhXpuejUz6RTMV+qPX3RGiVekQJvpD2h3DYpzTuQE3CLMkTcMIJmb8hZvzJXC3qhRvRLPWskU/wOI=
X-Received: by 2002:a02:7b13:: with SMTP id q19mr21941727jac.73.1583872669058; 
 Tue, 10 Mar 2020 13:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200309215818.2021-1-peter.maydell@linaro.org>
 <20200309215818.2021-2-peter.maydell@linaro.org>
In-Reply-To: <20200309215818.2021-2-peter.maydell@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 10 Mar 2020 21:37:37 +0100
Message-ID: <CAPan3WqtE6NGTd=yCG2zCirgeCDtv+eSgg4DSF+hCtn9rihk7A@mail.gmail.com>
Subject: Re: [PATCH 1/5] Makefile: Allow for subdirectories in Sphinx manual
 dependencies
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cf090905a086173a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cf090905a086173a
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

On Mon, Mar 9, 2020 at 10:58 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> Currently we put 'docs/foo/*.rst' in the Make list of dependencies
> for the Sphinx 'foo' manual, which means all the files must be
> in the top level of that manual's directory. We'd like to be
> able to have subdirectories inside some of the manuals, so add
> 'docs/foo/*/*.rst' to the dependencies too.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 2e930688942..5dba949947a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1081,7 +1081,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
>  # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
>  build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)"
> $(SPHINX_BUILD) $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D
> release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1
> $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
>  # We assume all RST files in the manual's directory are used in it
> -manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
> +manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst
> $(SRC_PATH)/docs/$1/*/*.rst) \
>                $(SRC_PATH)/docs/defs.rst.inc \
>                $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
>  # Macro to write out the rule and dependencies for building manpages
> --
> 2.20.1
>
>

-- 
Niek Linnenbank

--000000000000cf090905a086173a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklin=
nenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;<br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, 2020 =
at 10:58 PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">p=
eter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Currently we put &#39;docs/foo/*.rst&#39; in the Mak=
e list of dependencies<br>
for the Sphinx &#39;foo&#39; manual, which means all the files must be<br>
in the top level of that manual&#39;s directory. We&#39;d like to be<br>
able to have subdirectories inside some of the manuals, so add<br>
&#39;docs/foo/*/*.rst&#39; to the dependencies too.<br>
<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
---<br>
=C2=A0Makefile | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/Makefile b/Makefile<br>
index 2e930688942..5dba949947a 100644<br>
--- a/Makefile<br>
+++ b/Makefile<br>
@@ -1081,7 +1081,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \<br>
=C2=A0# a single doctree: <a href=3D"https://github.com/sphinx-doc/sphinx/i=
ssues/2946" rel=3D"noreferrer" target=3D"_blank">https://github.com/sphinx-=
doc/sphinx/issues/2946</a><br>
=C2=A0build-manual =3D $(call quiet-command,CONFDIR=3D&quot;$(qemu_confdir)=
&quot; $(SPHINX_BUILD) $(if $(V),,-q) -W -b $2 -D version=3D$(VERSION) -D r=
elease=3D&quot;$(FULL_VERSION)&quot; -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1=
 $(MANUAL_BUILDDIR)/$1 ,&quot;SPHINX&quot;,&quot;$(MANUAL_BUILDDIR)/$1&quot=
;)<br>
=C2=A0# We assume all RST files in the manual&#39;s directory are used in i=
t<br>
-manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) \<br>
+manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst $(SRC_PATH)/docs/$1/*=
/*.rst) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(SRC_PATH)/docs/def=
s.rst.inc \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(SRC_PATH)/docs/$1/=
conf.py $(SRC_PATH)/docs/conf.py<br>
=C2=A0# Macro to write out the rule and dependencies for building manpages<=
br>
-- <br>
2.20.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div>

--000000000000cf090905a086173a--

