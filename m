Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A627C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 03:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C4920789
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 03:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvpeISgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C4920789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTG6F-0006GR-D6
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 23:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTG5U-0005pL-Ur
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 23:07:25 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229]:42672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTG5T-0002Hd-35
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 23:07:24 -0400
Received: by mail-lj1-x229.google.com with SMTP id h20so905665lji.9
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 20:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=f+9O8rU+a2IuN+kOephSxO7+C3lpmlSBmV0Bvb1L6QI=;
 b=ZvpeISgCL9Lgs8Uo0aM54YBUq2mn/smrp3TLHapcPrDjM3uZD00Pm99UejW5KYzgO4
 wCIg9t3/dUE0+XHuZL1Nwzg3rC4eycci7mXkARn0quQKQuaCAZmXpOnToX5+K245/Q/W
 HHM58aQDrJmKLuG6BXdcxD1YA423nRLChcuZ4CN+zbS20QzfrkQA8ZAvNVhbNFKCz9P/
 J/ipU9uhj2EgHyyXUDaRus2RiZaFLTA+r8vDK7VYqfGg8QtALeroAaQ/Q3stK9P0Qemc
 p9e5vSMy2nov4SRrSMS/5KJpSPcHjWKs/YXbsDRjQCQhGuV2tvqMj69lAGjcdYEo28Nf
 2ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=f+9O8rU+a2IuN+kOephSxO7+C3lpmlSBmV0Bvb1L6QI=;
 b=FS26aWYHN/6B56ksZGywUEa5v6NI4gKrwe3E1Zj9NCVcwjSmcm2bXry6umApbv1gvZ
 durSmVd6TTp7dncx/4rHLO9o7LmO42vWAxkcOMvuGFABA9NRYdH5/fqKtCmClrxm78oi
 CSkL+KkNbeioE5w6g1Jw6ylOgwFNfChwpgrwbU45qUwMUVe/uAt6H0pNksJH8OWp8TsL
 PAgQj/OkqW77THLfno4KlFwVIq73t3FQwkFeZkRlH3sV+J0bXTP+7fJLyzsJfl+U8cH2
 uiNLSGY6zILnTyEMipthPY7kGUC5TWLO5T3D0uRV+d99eKfdvXzYpT/fkkYHmyU7NsGU
 N8Fg==
X-Gm-Message-State: AOAM53170sYZvL8XGxV08jkkPZGUTTmhtXz6JlM5U1gQ10qSGe92raho
 1Msei0HAb86Xzte+b+7kCQ+XbyAThF4QWN6JHQM=
X-Google-Smtp-Source: ABdhPJwVLi1lVNwjh+wC63Fv9fIDA2CQ52G5vzw+L751S3Of70oWapGnvf9t97lfVt0uSNASR7A7LpdtZcxcRf/6+ug=
X-Received: by 2002:a2e:9a17:: with SMTP id o23mr677728lji.242.1602817641246; 
 Thu, 15 Oct 2020 20:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201015220626.418-1-luoyonggang@gmail.com>
 <20201015220626.418-2-luoyonggang@gmail.com>
 <CABgObfZHAVioVo9xr5ViyezkNA9wq0n+Xberin0+VhzsJShGRw@mail.gmail.com>
In-Reply-To: <CABgObfZHAVioVo9xr5ViyezkNA9wq0n+Xberin0+VhzsJShGRw@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 16 Oct 2020 11:07:09 +0800
Message-ID: <CAE2XoE_e_OsWX8G9qBLEghz69KTjgnWaJuvRyeVUKDF78OfSgw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] docs: Fixes build docs on msys2/mingw
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000257b1005b1c11062"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x229.google.com
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000257b1005b1c11062
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 6:19 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
>
> Il ven 16 ott 2020, 00:06 Yonggang Luo <luoyonggang@gmail.com> ha scritto=
:
>>
>> meson didn't support running ../scripts/kernel-do directly
>
>
> Can you explain why this matters? Meson does not look at docs/conf.py.
>
> Paolo
>
>>
>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> ---
>>  docs/conf.py             | 2 +-
>>  docs/sphinx/kerneldoc.py | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/conf.py b/docs/conf.py
>> index 00e1b750e2..e584f68393 100644
>> --- a/docs/conf.py
>> +++ b/docs/conf.py
>> @@ -241,7 +241,7 @@ texinfo_documents =3D [
>>  # We use paths starting from qemu_docdir here so that you can run
>>  # sphinx-build from anywhere and the kerneldoc extension can still
>>  # find everything.
>> -kerneldoc_bin =3D os.path.join(qemu_docdir, '../scripts/kernel-doc')
>> +kerneldoc_bin =3D ['perl', os.path.join(qemu_docdir,
'../scripts/kernel-doc')]
>>  kerneldoc_srctree =3D os.path.join(qemu_docdir, '..')
>>  hxtool_srctree =3D os.path.join(qemu_docdir, '..')
>>  qapidoc_srctree =3D os.path.join(qemu_docdir, '..')
>> diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
>> index 3e87940206..3ac277d162 100644
>> --- a/docs/sphinx/kerneldoc.py
>> +++ b/docs/sphinx/kerneldoc.py
>> @@ -67,7 +67,7 @@ class KernelDocDirective(Directive):
>>
>>      def run(self):
>>          env =3D self.state.document.settings.env
>> -        cmd =3D [env.config.kerneldoc_bin, '-rst', '-enable-lineno']
>> +        cmd =3D env.config.kerneldoc_bin + ['-rst', '-enable-lineno']
  meson use the conf directly
>>
>>          filename =3D env.config.kerneldoc_srctree + '/' +
self.arguments[0]

>>          export_file_patterns =3D []
>> --
>> 2.28.0.windows.1
>>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000257b1005b1c11062
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Oct 16, 2020 at 6:19 AM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt;<br>&gt;<br>&gt; Il ven 16 ott 2020, 00:06 Yonggang Luo &lt;<=
a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; ha sc=
ritto:<br>&gt;&gt;<br>&gt;&gt; meson didn&#39;t support running ../scripts/=
kernel-do directly<br>&gt;<br>&gt;<br>&gt; Can you explain why this matters=
? Meson does not look at docs/conf.py.<br>&gt;<br>&gt; Paolo<br>&gt;<br>&gt=
;&gt;<br>&gt;&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyong=
gang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt;&gt; ---<br>&gt;&gt; =
=C2=A0docs/conf.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>&gt;=
&gt; =C2=A0docs/sphinx/kerneldoc.py | 2 +-<br>&gt;&gt; =C2=A02 files change=
d, 2 insertions(+), 2 deletions(-)<br>&gt;&gt;<br>&gt;&gt; diff --git a/doc=
s/conf.py b/docs/conf.py<br>&gt;&gt; index 00e1b750e2..e584f68393 100644<br=
>&gt;&gt; --- a/docs/conf.py<br>&gt;&gt; +++ b/docs/conf.py<br>&gt;&gt; @@ =
-241,7 +241,7 @@ texinfo_documents =3D [<br>&gt;&gt; =C2=A0# We use paths s=
tarting from qemu_docdir here so that you can run<br>&gt;&gt; =C2=A0# sphin=
x-build from anywhere and the kerneldoc extension can still<br>&gt;&gt; =C2=
=A0# find everything.<br>&gt;&gt; -kerneldoc_bin =3D os.path.join(qemu_docd=
ir, &#39;../scripts/kernel-doc&#39;)<br>&gt;&gt; +kerneldoc_bin =3D [&#39;p=
erl&#39;, os.path.join(qemu_docdir, &#39;../scripts/kernel-doc&#39;)]<br>&g=
t;&gt; =C2=A0kerneldoc_srctree =3D os.path.join(qemu_docdir, &#39;..&#39;)<=
br>&gt;&gt; =C2=A0hxtool_srctree =3D os.path.join(qemu_docdir, &#39;..&#39;=
)<br>&gt;&gt; =C2=A0qapidoc_srctree =3D os.path.join(qemu_docdir, &#39;..&#=
39;)<br>&gt;&gt; diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kernel=
doc.py<br>&gt;&gt; index 3e87940206..3ac277d162 100644<br>&gt;&gt; --- a/do=
cs/sphinx/kerneldoc.py<br>&gt;&gt; +++ b/docs/sphinx/kerneldoc.py<br>&gt;&g=
t; @@ -67,7 +67,7 @@ class KernelDocDirective(Directive):<br>&gt;&gt;<br>&g=
t;&gt; =C2=A0 =C2=A0 =C2=A0def run(self):<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0env =3D self.state.document.settings.env<br>&gt;&gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cmd =3D [env.config.kerneldoc_bin, &#39;-rst&#39;, &#39=
;-enable-lineno&#39;]<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd =3D env.=
config.kerneldoc_bin + [&#39;-rst&#39;, &#39;-enable-lineno&#39;]<div>=C2=
=A0 meson use the conf directly=C2=A0<br>&gt;&gt;<br>&gt;&gt; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0filename =3D env.config.kerneldoc_srctree + &#39;/&#39=
; + self.arguments[0]<div><br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ex=
port_file_patterns =3D []<br>&gt;&gt; --<br>&gt;&gt; 2.28.0.windows.1<br>&g=
t;&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=
=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 s=
incerely,<br>Yonggang Luo</div></div></div>

--000000000000257b1005b1c11062--

