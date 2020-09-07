Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED30EC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DCA2145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvwHI77o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DCA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNLV-0002dm-Gv
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNKk-0001jJ-Nt
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:01:46 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNKi-00082R-IL
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:01:46 -0400
Received: by mail-lj1-x242.google.com with SMTP id u4so16422653ljd.10
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=8yiwjkvETdw1mpSSjbpKEjIm/2IqdsU3I5dYHBqTGxs=;
 b=DvwHI77oMjquDqqebo9vDYA+KcJTfL7tyZ1TVeub3/4cXvbCFzOy4gLhB3lZ6kfAGs
 M+XPsSesGubOI98kKtpaKvgER2jqtsdKShqCX9fNFBr1wL3aLUGbqh+QUV1Ka/97b3e+
 Wf4RcNApSA7YTY4l4udrcdEfIdJT7zsMfNKBuKT3Gn5m+IlHJ9fgc1aPZvkB6ku895vx
 aWsEwVKwXhwamGa7eEvGcaFiiJHeq6icKUHvPDlAxqesEl0Bh2Mhs7vSIBM0T7fjLyoj
 vN4YeX2hCDsBvUAcHSpl+uzrfz655Sa2FoFMAcq9558tPfZAQ3/Ex08U1QU/RH4pkMlT
 flng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=8yiwjkvETdw1mpSSjbpKEjIm/2IqdsU3I5dYHBqTGxs=;
 b=dTwZdk2hL2AEmiswYzPEcYgJedf7LIHyllQxwH+CS2ApbiUa20P+MxNxkrv2CV/IDR
 0SsK/Re07wBJLz3ciIilUdLJiAGiNm6Zr4LMoW54HUYd4PMz3F/WV1xxDcE+M2zoCMfM
 YPkmN1699qH+ysU7JTgp7xMrU9Z/HVy0W9bXUqq4QhJmttcWJftpoj8ryOWFL5dRq43u
 Rup4lc6I6pAGbGcFdP8RESYoQP4TrVXt2T5n3I72RV9LhvJAxCDiS88uaBrKbWRb24bf
 2CJOfsY+XGaW918BtV5bZbasQDyUnkEQUTPR43kBZSxYHp3WMLLpgj+BG/vTAVv68DmC
 qInA==
X-Gm-Message-State: AOAM532MkxvL0aSkUZmfK1RQ0lOi4I1AyhJOoNko/mbj+ocEvGh9cmza
 +uaBVHpj8BPegqILAiaMCf91opj8J8JywQhSEPY=
X-Google-Smtp-Source: ABdhPJwK7s6ntM9k+eVJMWHDXJyt5ufl2+Js76dIkCUcunBI60D/7CGJeCq+en4zm2Oj5NC3ygoK9nvli6YFbzya4Vk=
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr11879416ljj.368.1599508902309; 
 Mon, 07 Sep 2020 13:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200907195025.2308-1-luoyonggang@gmail.com>
 <20200907195025.2308-3-luoyonggang@gmail.com>
 <CABgObfasCYQhiX5YnOPH5CEZ3ev=QNuqbyEv=LUjvibug=4mwg@mail.gmail.com>
In-Reply-To: <CABgObfasCYQhiX5YnOPH5CEZ3ev=QNuqbyEv=LUjvibug=4mwg@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 8 Sep 2020 04:01:31 +0800
Message-ID: <CAE2XoE9bAFiGP6nXrtRCf6Ha05tg3N89j3trc7qzE9dUa=Sk_w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] meson: Fixes jemalloc and tcmalloc can not
 building.
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000eff6b205aebeaf01"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x242.google.com
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000eff6b205aebeaf01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2020 at 4:00 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> Hi, LIBS is going away soon. I have a few more Meson patches including on=
e
> for tcmalloc and jemalloc, I won't post them super soon though.
>
OK, then I'll skip this

>
> Paolo
>
> Il lun 7 set 2020, 21:50 Yonggang Luo <luoyonggang@gmail.com> ha scritto:
>
>> Currently, the LIBS are not exposed to meson and meson didn't use that
>> Use base_lib =3D declare_dependency(link_args: config_host['LIBS'].split=
())
>> to force use it
>>
>>
>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> ---
>>  configure   | 9 +++++++++
>>  meson.build | 5 ++++-
>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 823756f4a4..7b2f3d64b0 100755
>> --- a/configure
>> +++ b/configure
>> @@ -7245,6 +7245,14 @@ if test "$libxml2" =3D "yes" ; then
>>    echo "LIBXML2_LIBS=3D$libxml2_libs" >> $config_host_mak
>>  fi
>>
>> +if test "$tcmalloc" =3D "yes" ; then
>> +  echo "CONFIG_TCMALLOC=3Dy" >> $config_host_mak
>> +fi
>> +
>> +if test "$jemalloc" =3D "yes" ; then
>> +  echo "CONFIG_JEMALLOC=3Dy" >> $config_host_mak
>> +fi
>> +
>>  if test "$replication" =3D "yes" ; then
>>    echo "CONFIG_REPLICATION=3Dy" >> $config_host_mak
>>  fi
>> @@ -7416,6 +7424,7 @@ echo "PKG_CONFIG=3D$pkg_config_exe" >>
>> $config_host_mak
>>  echo "WINDRES=3D$windres" >> $config_host_mak
>>  echo "CFLAGS=3D$CFLAGS" >> $config_host_mak
>>  echo "CFLAGS_NOPIE=3D$CFLAGS_NOPIE" >> $config_host_mak
>> +echo "LIBS=3D$LIBS" >> $config_host_mak
>>  echo "QEMU_CFLAGS=3D$QEMU_CFLAGS" >> $config_host_mak
>>  echo "QEMU_CXXFLAGS=3D$QEMU_CXXFLAGS" >> $config_host_mak
>>  echo "QEMU_INCLUDES=3D$QEMU_INCLUDES" >> $config_host_mak
>> diff --git a/meson.build b/meson.build
>> index 5421eca66a..6e909213ee 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -116,6 +116,9 @@ endif
>>  # grandfathered in from the QEMU Makefiles.
>>  add_project_arguments(config_host['GLIB_CFLAGS'].split(),
>>                        native: false, language: ['c', 'cpp', 'objc'])
>> +
>> +base_lib =3D declare_dependency(link_args: config_host['LIBS'].split())
>> +
>>  glib =3D declare_dependency(link_args: config_host['GLIB_LIBS'].split()=
)
>>  gio =3D not_found
>>  if 'CONFIG_GIO' in config_host
>> @@ -818,7 +821,7 @@ util_ss.add_all(trace_ss)
>>  util_ss =3D util_ss.apply(config_all, strict: false)
>>  libqemuutil =3D static_library('qemuutil',
>>                               sources: util_ss.sources() +
>> stub_ss.sources() + genh,
>> -                             dependencies: [util_ss.dependencies(), m,
>> glib, socket])
>> +                             dependencies: [util_ss.dependencies(), m,
>> base_lib, glib, socket])
>>  qemuutil =3D declare_dependency(link_with: libqemuutil,
>>                                sources: genh + version_res)
>>
>> --
>> 2.28.0.windows.1
>>
>>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000eff6b205aebeaf01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 8, 2020 at 4:00 AM Paolo =
Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"auto">Hi, LIBS is going away soon. I have a few more Meson patches i=
ncluding one for tcmalloc and jemalloc, I won&#39;t post them super soon th=
ough.</div></blockquote><div>OK, then I&#39;ll skip this=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div dir=3D"au=
to"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 7 set 2020, 21:50 Yonggan=
g Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyon=
ggang@gmail.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Currently, the LIBS are not exposed to meson and meson =
didn&#39;t use that<br>
Use base_lib =3D declare_dependency(link_args: config_host[&#39;LIBS&#39;].=
split())<br>
to force use it<br>
<br>
<br>
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" re=
l=3D"noreferrer" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
---<br>
=C2=A0configure=C2=A0 =C2=A0| 9 +++++++++<br>
=C2=A0meson.build | 5 ++++-<br>
=C2=A02 files changed, 13 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/configure b/configure<br>
index 823756f4a4..7b2f3d64b0 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -7245,6 +7245,14 @@ if test &quot;$libxml2&quot; =3D &quot;yes&quot; ; t=
hen<br>
=C2=A0 =C2=A0echo &quot;LIBXML2_LIBS=3D$libxml2_libs&quot; &gt;&gt; $config=
_host_mak<br>
=C2=A0fi<br>
<br>
+if test &quot;$tcmalloc&quot; =3D &quot;yes&quot; ; then<br>
+=C2=A0 echo &quot;CONFIG_TCMALLOC=3Dy&quot; &gt;&gt; $config_host_mak<br>
+fi<br>
+<br>
+if test &quot;$jemalloc&quot; =3D &quot;yes&quot; ; then<br>
+=C2=A0 echo &quot;CONFIG_JEMALLOC=3Dy&quot; &gt;&gt; $config_host_mak<br>
+fi<br>
+<br>
=C2=A0if test &quot;$replication&quot; =3D &quot;yes&quot; ; then<br>
=C2=A0 =C2=A0echo &quot;CONFIG_REPLICATION=3Dy&quot; &gt;&gt; $config_host_=
mak<br>
=C2=A0fi<br>
@@ -7416,6 +7424,7 @@ echo &quot;PKG_CONFIG=3D$pkg_config_exe&quot; &gt;&gt=
; $config_host_mak<br>
=C2=A0echo &quot;WINDRES=3D$windres&quot; &gt;&gt; $config_host_mak<br>
=C2=A0echo &quot;CFLAGS=3D$CFLAGS&quot; &gt;&gt; $config_host_mak<br>
=C2=A0echo &quot;CFLAGS_NOPIE=3D$CFLAGS_NOPIE&quot; &gt;&gt; $config_host_m=
ak<br>
+echo &quot;LIBS=3D$LIBS&quot; &gt;&gt; $config_host_mak<br>
=C2=A0echo &quot;QEMU_CFLAGS=3D$QEMU_CFLAGS&quot; &gt;&gt; $config_host_mak=
<br>
=C2=A0echo &quot;QEMU_CXXFLAGS=3D$QEMU_CXXFLAGS&quot; &gt;&gt; $config_host=
_mak<br>
=C2=A0echo &quot;QEMU_INCLUDES=3D$QEMU_INCLUDES&quot; &gt;&gt; $config_host=
_mak<br>
diff --git a/meson.build b/meson.build<br>
index 5421eca66a..6e909213ee 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -116,6 +116,9 @@ endif<br>
=C2=A0# grandfathered in from the QEMU Makefiles.<br>
=C2=A0add_project_arguments(config_host[&#39;GLIB_CFLAGS&#39;].split(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0native: false, language: [&#39;c&#39;, &#39;cpp&#39;, &#39;objc&#=
39;])<br>
+<br>
+base_lib =3D declare_dependency(link_args: config_host[&#39;LIBS&#39;].spl=
it())<br>
+<br>
=C2=A0glib =3D declare_dependency(link_args: config_host[&#39;GLIB_LIBS&#39=
;].split())<br>
=C2=A0gio =3D not_found<br>
=C2=A0if &#39;CONFIG_GIO&#39; in config_host<br>
@@ -818,7 +821,7 @@ util_ss.add_all(trace_ss)<br>
=C2=A0util_ss =3D util_ss.apply(config_all, strict: false)<br>
=C2=A0libqemuutil =3D static_library(&#39;qemuutil&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sources: util_ss.sources() + stub_ss.source=
s() + genh,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dependencies: [util_ss.dependencies(), m, gl=
ib, socket])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dependencies: [util_ss.dependencies(), m, ba=
se_lib, glib, socket])<br>
=C2=A0qemuutil =3D declare_dependency(link_with: libqemuutil,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sources: genh + version_res)<br>
<br>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000eff6b205aebeaf01--

