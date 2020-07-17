Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30708C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A18206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A18206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRAC-0002A1-4m
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwR9P-0001i6-6b
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:15:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwR9N-0006yA-1s
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:15:46 -0400
Received: from mail-vs1-f72.google.com ([209.85.217.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwR9L-0002Po-1l
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:15:43 +0000
Received: by mail-vs1-f72.google.com with SMTP id s67so1795265vss.7
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 07:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YkdMRo5Hr6aNaRk/vfmPDStRhR1kwLqb24YcxDZaZsA=;
 b=p3Rbr++E/DbjoFJ5Z/60wqP8zwZD8ka47sP7UPTQUoK0vDyWC48UwbO3dENYA1FSDA
 EGZ7hRqHctqYtr8/sdF+1Bkp1TwyyzSw0kXW3dx7bfGfoUX7qYjBaeN5iZvuqv6/TDU+
 JnpDrp7d0qb6KVS3zdfTYFFUuKxks/OfeceBZi0HR7XnS46dMcQGRdNf8Q08zZMhu3ll
 mKZOQ05eWgjrn2ACmtmeMg3zIuVfcxNaQMbDge2ZtYKAUFQRkryRQ0Le9+RIuRIFgwk6
 4ab1w3fiaurOo7LmUMY46oVGz4BjbGLLptgvHc0Rev5HP6Y6prnja/Zyl8UFzKOh6Ho5
 43pw==
X-Gm-Message-State: AOAM532RUJsT0E0Cn4m4f4SMzQAyshjBgDhK6wF4STILOwHdPhwEQE4u
 FJpB+rQ+NlIHHecW79KkJ10+98dP1UCbsK4STl4jyqQaculSrWvJ8NVhbD3KmyZkfI+7gvLJ8Pw
 tjsKLNz/mo2g7yCf62gBg9ehB77HWnWoJckCWGSpS5YAAoBu1
X-Received: by 2002:a1f:255:: with SMTP id 82mr7594668vkc.39.1594995342196;
 Fri, 17 Jul 2020 07:15:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUC+3K/8AmLSUoGw3KGFDVVy4UTXJU7xiIcqdgNU7YeX7+GksZalY3lH5PBJ/0y4licf5hodVtC5OAF2qDyF4=
X-Received: by 2002:a1f:255:: with SMTP id 82mr7594643vkc.39.1594995341905;
 Fri, 17 Jul 2020 07:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200717140714.124263-1-christian.ehrhardt@canonical.com>
In-Reply-To: <20200717140714.124263-1-christian.ehrhardt@canonical.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Fri, 17 Jul 2020 16:15:15 +0200
Message-ID: <CAATJJ0+ONgyxZztZJi_03-++aXa1pM-r5dKf7An2KiYhvYNgvw@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: reduce default code gen buffer on small hosts
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c5e9d605aaa3caac"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=christian.ehrhardt@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 09:40:52
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c5e9d605aaa3caac
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 17, 2020 at 4:07 PM Christian Ehrhardt <
christian.ehrhardt@canonical.com> wrote:

> Since v5.0.0 and 600e17b2 "accel/tcg: increase default code gen buffer
> size for 64 bit" in particular qemu with TCG regularly gets OOM Killed
> on small hosts.
>
> The former 47a2def4 "accel/tcg: remove link between guest ram and TCG
> cache size" removed the link to guest size which is right, but at least
> some connection to the host size needs to be retained to avoid growing
> out of control on common CI setups which run at 1-2G host sizes.
>
> The lower value of 1/8th of the host memory size and the default (of
> currently 1G) will be taken to initialize the TB. There already is a
> Min/Max check in place to not reach ridiculously small values.
>
> Fixes: 600e17b2
>

Just found "[PATCH v1 0/5] candidate fixes for 5.1-rc1 (shippable,
semihosting, OOM tcg)"
which was submitted while I was prepping this one (this is a busy day since
I'll be off for a week).

Please ignore this patch here and give the series of Alex a look as it is
the more advanced version :-).


> Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> ---
>  accel/tcg/translate-all.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 2afa46bd2b..ffcd67060e 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -977,6 +977,29 @@ static inline size_t size_code_gen_buffer(size_t
> tb_size)
>      /* Size the buffer.  */
>      if (tb_size == 0) {
>          tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
> +        /*
> +         * A static default of 1G turned out to break (OOM Kill) many
> common
> +         * CI setups that run at 1-2G Host memory size.
> +         * At the same time the former default of ram_size/4 wasted
> performance
> +         * on large host systems when running small guests.
> +         * Common CI guest sizes are 0.5-1G which meant ~128M-256M TB
> size.
> +         * A Default of 1/8th of the host size will get small hosts a
> +         * similar TB size than they had prior to v5.0 and common bare
> metal
> +         * systems (>=8G) the new 1G default that was set in v5.0
> +         */
> +#if defined _SC_PHYS_PAGES && defined _SC_PAGESIZE
> +        {
> +            unsigned long max = DEFAULT_CODE_GEN_BUFFER_SIZE;
> +            double pages = (double)sysconf(_SC_PHYS_PAGES);
> +
> +            if (pages > 0 && pagesize > 0) {
> +                max = (unsigned long)((pages * qemu_real_host_page_size)
> / 8);
> +            }
> +            if (max < DEFAULT_CODE_GEN_BUFFER_SIZE) {
> +                tb_size = max;
> +            }
> +        }
> +#endif
>      }
>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
>          tb_size = MIN_CODE_GEN_BUFFER_SIZE;
> --
> 2.27.0
>
>

-- 
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--000000000000c5e9d605aaa3caac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 17, 2020 at 4:07 PM Chris=
tian Ehrhardt &lt;<a href=3D"mailto:christian.ehrhardt@canonical.com" targe=
t=3D"_blank">christian.ehrhardt@canonical.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Since v5.0.0 and 600e17b2 &quo=
t;accel/tcg: increase default code gen buffer<br>
size for 64 bit&quot; in particular qemu with TCG regularly gets OOM Killed=
<br>
on small hosts.<br>
<br>
The former 47a2def4 &quot;accel/tcg: remove link between guest ram and TCG<=
br>
cache size&quot; removed the link to guest size which is right, but at leas=
t<br>
some connection to the host size needs to be retained to avoid growing<br>
out of control on common CI setups which run at 1-2G host sizes.<br>
<br>
The lower value of 1/8th of the host memory size and the default (of<br>
currently 1G) will be taken to initialize the TB. There already is a<br>
Min/Max check in place to not reach ridiculously small values.<br>
<br>
Fixes: 600e17b2<br></blockquote><div><br></div><div>Just found &quot;[PATCH=
 v1 0/5] candidate fixes for 5.1-rc1 (shippable, semihosting, OOM tcg)&quot=
;</div><div>which was submitted while I was prepping this one (this is a bu=
sy day since I&#39;ll be off for a week).</div><div><br></div><div>Please i=
gnore this patch here and give the series of Alex a look as it is the more =
advanced version :-).</div><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
Signed-off-by: Christian Ehrhardt &lt;<a href=3D"mailto:christian.ehrhardt@=
canonical.com" target=3D"_blank">christian.ehrhardt@canonical.com</a>&gt;<b=
r>
---<br>
=C2=A0accel/tcg/translate-all.c | 23 +++++++++++++++++++++++<br>
=C2=A01 file changed, 23 insertions(+)<br>
<br>
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c<br>
index 2afa46bd2b..ffcd67060e 100644<br>
--- a/accel/tcg/translate-all.c<br>
+++ b/accel/tcg/translate-all.c<br>
@@ -977,6 +977,29 @@ static inline size_t size_code_gen_buffer(size_t tb_si=
ze)<br>
=C2=A0 =C2=A0 =C2=A0/* Size the buffer.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (tb_size =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* A static default of 1G turned out to b=
reak (OOM Kill) many common<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* CI setups that run at 1-2G Host memory=
 size.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* At the same time the former default of=
 ram_size/4 wasted performance<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* on large host systems when running sma=
ll guests.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Common CI guest sizes are 0.5-1G which=
 meant ~128M-256M TB size.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* A Default of 1/8th of the host size wi=
ll get small hosts a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* similar TB size than they had prior to=
 v5.0 and common bare metal<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* systems (&gt;=3D8G) the new 1G default=
 that was set in v5.0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+#if defined _SC_PHYS_PAGES &amp;&amp; defined _SC_PAGESIZE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long max =3D DEFAULT_CO=
DE_GEN_BUFFER_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 double pages =3D (double)sysconf=
(_SC_PHYS_PAGES);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pages &gt; 0 &amp;&amp; page=
size &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max =3D (unsigned =
long)((pages * qemu_real_host_page_size) / 8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (max &lt; DEFAULT_CODE_GEN_BU=
FFER_SIZE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tb_size =3D max;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (tb_size &lt; MIN_CODE_GEN_BUFFER_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tb_size =3D MIN_CODE_GEN_BUFFER_SIZE;<br>
-- <br>
2.27.0<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Christian Ehrhardt<br>Staff Engineer, Ubuntu Server<br>Canonical Ltd</div>=
</div>

--000000000000c5e9d605aaa3caac--

