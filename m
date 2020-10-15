Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B916C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5635722226
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8MyaIwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5635722226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSuym-0004QU-94
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 00:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kSuxx-0003yL-Mm
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:34:13 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kSuxv-00057A-Qw
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:34:13 -0400
Received: by mail-lj1-x243.google.com with SMTP id d24so1695318ljg.10
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 21:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=psnGgAGEEwaOcxnWIDIPAHYplObslFKtxQrTE4Cbtqo=;
 b=O8MyaIwpNl/MaBmFAI7H4yNQDNscCwC+Ghi2UPJfxttlBRHjUa2gb8/JHRIcQliIKB
 xoLU/kj5WMVTVNMy6pqPJ/qOQ4vGQxs29xSNaX+wkYgmlJXjovc4IG3ydoUxQGB3/IiP
 9Lt3nMUq7tgk/5UB9oCj/2jijCubWxpD/+O/q9lSvI0DUwYPZ/0k8nJaVw0Mz79SkQKf
 h1x3jojk4BSpR0yV0JU+8nnddoJq4SWR/OyyZT+pBkiQQcik5Vb8+m2t4xyyX8vObpP+
 XYwbGRXMDrCgpuDDsy40v+/O48v6Q69RK2KkzzMkKe+Dh6q2rKJZ4NVmJrWFC1Z6H2kB
 hFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=psnGgAGEEwaOcxnWIDIPAHYplObslFKtxQrTE4Cbtqo=;
 b=NtLUoWxsyelnbyWP2zVMgNSEzG67kmJTcxJVqHtuWaDg5r9KKJ7RXD+lxrdWnE3AbB
 yjOCmXb1Q8gXe25+KuW6GU0cbOb6pfNm3+3bPwlrV50owtdDZllQwB3sVmI5ymM2Brpo
 lc0rFmPFZnKWtFS0Pe84VkpvtqQNc3hUcDFFnqE9tGKutED7R80ej4UG+CTyttQoUFNG
 CfWRsdsUtYv3VSAz5SWdtldlyI1wIugPjqk+JFkS9pLCFUvqfDWt2yBV0n1qX6VwVGcY
 58rZCKJzzaugVW9MP2ANJb5pcAvIpWq1b8Cw8Dqpg2ZP0GiWWnWXIHKKaerBU7KxZK8f
 bM0A==
X-Gm-Message-State: AOAM530EqTHbG1ilAcTbRwLW+vU0Y5rokVhilhbSpBBvVJgXCRCnzwNq
 Zpw3eLLXgjEEnMrQdRBh0D+s18mN4JT9lIWIBc8=
X-Google-Smtp-Source: ABdhPJyBgFMYkhW6DA+QW8akVZwqEw3/y49CmVcWo4AOyOeCvoj6KxbIqRmacXlOmJhqWLXzmMmvMtSbR5cKvB3r3B4=
X-Received: by 2002:a2e:9a17:: with SMTP id o23mr555664lji.242.1602736449899; 
 Wed, 14 Oct 2020 21:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201014221939.196958-1-brogers@suse.com>
In-Reply-To: <20201014221939.196958-1-brogers@suse.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 15 Oct 2020 12:33:58 +0800
Message-ID: <CAE2XoE_1T8cobLaZT=gCugHozV=todSvQynNYvQ-VxXVMKxc-w@mail.gmail.com>
Subject: Re: [PATCH] meson.build: don't condition iconv detection on library
 detection
To: Bruce Rogers <brogers@suse.com>
Content-Type: multipart/alternative; boundary="000000000000c3d20e05b1ae2800"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
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
Cc: qemu-level <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c3d20e05b1ae2800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2020 at 6:19 AM Bruce Rogers <brogers@suse.com> wrote:
>
> It isn't necessarily the case that use of iconv requires an additional
> library. For that reason we shouldn't conditionalize iconv detection on
> libiconv.found.
>
> Fixes: 5285e593c33 (configure: Fixes ncursesw detection under msys2/mingw
by convert them to meson)
>
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  meson.build | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 1a4a482492..84c8ec9541 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -431,15 +431,13 @@ if not get_option('iconv').disabled()
>    libiconv =3D cc.find_library('iconv',
>                               required: false,
>                               static: enable_static)
> -  if libiconv.found()
> -    if cc.links('''
> -      #include <iconv.h>
> -      int main(void) {
> -        iconv_t conv =3D iconv_open("WCHAR_T", "UCS-2");
> -        return conv !=3D (iconv_t) -1;
> -      }''', dependencies: [libiconv])
> -      iconv =3D declare_dependency(dependencies: [libiconv])
> -    endif
> +  if cc.links('''
> +    #include <iconv.h>
> +    int main(void) {
> +      iconv_t conv =3D iconv_open("WCHAR_T", "UCS-2");
> +      return conv !=3D (iconv_t) -1;
> +    }''', dependencies: [libiconv])
> +    iconv =3D declare_dependency(dependencies: [libiconv])
>    endif
>  endif
>  if get_option('iconv').enabled() and not iconv.found()
> --
> 2.28.0
>
Reviewed-by: Yonggang Luo<l <brogers@suse.com>uoyonggang@gmail.com>

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000c3d20e05b1ae2800
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, Oct 15, 2020 at 6:19 AM Bruce Rogers &lt;<=
a href=3D"mailto:brogers@suse.com">brogers@suse.com</a>&gt; wrote:<br>&gt;<=
br>&gt; It isn&#39;t necessarily the case that use of iconv requires an add=
itional<br>&gt; library. For that reason we shouldn&#39;t conditionalize ic=
onv detection on<br>&gt; libiconv.found.<br>&gt;<br>&gt; Fixes: 5285e593c33=
 (configure: Fixes ncursesw detection under msys2/mingw by convert them to =
meson)<br>&gt;<br>&gt; Signed-off-by: Bruce Rogers &lt;<a href=3D"mailto:br=
ogers@suse.com">brogers@suse.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0meson.bu=
ild | 16 +++++++---------<br>&gt; =C2=A01 file changed, 7 insertions(+), 9 =
deletions(-)<br>&gt;<br>&gt; diff --git a/meson.build b/meson.build<br>&gt;=
 index 1a4a482492..84c8ec9541 100644<br>&gt; --- a/meson.build<br>&gt; +++ =
b/meson.build<br>&gt; @@ -431,15 +431,13 @@ if not get_option(&#39;iconv&#3=
9;).disabled()<br>&gt; =C2=A0 =C2=A0libiconv =3D cc.find_library(&#39;iconv=
&#39;,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required: false,<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 static: enable_static)<br>&gt; - =C2=A0if libic=
onv.found()<br>&gt; - =C2=A0 =C2=A0if cc.links(&#39;&#39;&#39;<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0#include &lt;iconv.h&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0=
int main(void) {<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0iconv_t conv =3D icon=
v_open(&quot;WCHAR_T&quot;, &quot;UCS-2&quot;);<br>&gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return conv !=3D (iconv_t) -1;<br>&gt; - =C2=A0 =C2=A0 =C2=A0}&#3=
9;&#39;&#39;, dependencies: [libiconv])<br>&gt; - =C2=A0 =C2=A0 =C2=A0iconv=
 =3D declare_dependency(dependencies: [libiconv])<br>&gt; - =C2=A0 =C2=A0en=
dif<br>&gt; + =C2=A0if cc.links(&#39;&#39;&#39;<br>&gt; + =C2=A0 =C2=A0#inc=
lude &lt;iconv.h&gt;<br>&gt; + =C2=A0 =C2=A0int main(void) {<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0iconv_t conv =3D iconv_open(&quot;WCHAR_T&quot;, &quot;UCS=
-2&quot;);<br>&gt; + =C2=A0 =C2=A0 =C2=A0return conv !=3D (iconv_t) -1;<br>=
&gt; + =C2=A0 =C2=A0}&#39;&#39;&#39;, dependencies: [libiconv])<br>&gt; + =
=C2=A0 =C2=A0iconv =3D declare_dependency(dependencies: [libiconv])<br>&gt;=
 =C2=A0 =C2=A0endif<br>&gt; =C2=A0endif<br>&gt; =C2=A0if get_option(&#39;ic=
onv&#39;).enabled() and not iconv.found()<br>&gt; --<br>&gt; 2.28.0<br>&gt;=
<br>Reviewed-by: Yonggang Luo&lt;<a href=3D"mailto:brogers@suse.com" target=
=3D"_blank">l</a><a href=3D"mailto:uoyonggang@gmail.com">uoyonggang@gmail.c=
om</a>&gt;<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=
=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 s=
incerely,<br>Yonggang Luo</div>

--000000000000c3d20e05b1ae2800--

