Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546D9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D07320732
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5XLFjA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D07320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFuuc-0004bF-JQ
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 03:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFutt-0003md-B5; Wed, 09 Sep 2020 03:52:17 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:37821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFutr-0000Oa-AU; Wed, 09 Sep 2020 03:52:17 -0400
Received: by mail-lf1-x144.google.com with SMTP id z19so1085332lfr.4;
 Wed, 09 Sep 2020 00:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=w57mCYvue8o9dONluYZatl6z3tZVGyWM3nHoEKVLEdU=;
 b=I5XLFjA7EJhpPYmMpDDwmICUueZ2auRXmIVVjEr8jy9UB5BVWvmy8gK5xsQgF8BZ5I
 I76MitSl1uykb+qOPAmXmURf5imdTJsoHHY/UrDNQK+/X7CvOpqYg0YqG7NyPrI65Bwl
 KfpcSNxvcD6vVlSvZrN08vIYUoEHaefZgvgX8fnWuqbAUNwNcZMbT9bSilgbZbOnc+I5
 JAzvthIWGOT2PNfmKZCbECxa0+Path4bXyTlpzrE7bJZFeZS3qCYZ8wHPh4zLfIQrqJh
 WYFVbPajPYCkuLxL4l+d6IyqbyJvaDRO7plNOiATg9GaHBTvo8OjCxpnxdqMFEKUnL7g
 N88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=w57mCYvue8o9dONluYZatl6z3tZVGyWM3nHoEKVLEdU=;
 b=sLM1FTctNmOTipgJvJBLxZHKIonO49P7IDTV5hDLtrkPvC587r7S/bQZv12A5mc8XJ
 Rb0rMLnG+GQLc3LRTGm2Bt74j6PMuXZJRZQ6KtuxR484Aa6rENi1WqF/SkgMIME6TKoC
 txEh+QOCvidQr/8HYTkXsSkp7YwK5fGiaBsaAOhMK/wxKV9rezXDUSw6Eo12B8WdSlWc
 K0jJbeNYH0EgTi8sylk9Vu7jz0Xb6dDvf+lsmGb5oyq6rMG+HKCuhOySkS0WYNSTsxzF
 UeyKvvwx8cTxm3Mj2av2Vx0aOHfGcGj1IMwiftkT+UK+RbfXyUsYqw34WKWcFlngcuRK
 WN5Q==
X-Gm-Message-State: AOAM5324DYaKRkkk0hABrTgEzu4llaPZyrCQEisGNqV6N9mSrKI7emAz
 FBGG1quOR2rcpyCtSlBkl51wqVZdoe9+mfXHlI8=
X-Google-Smtp-Source: ABdhPJw0r3e4y4S1yXrtZ2e17T6xltkeLh9+ZPBV6FS++2PqfgXzEXfZI8UsK4+T7IOd0p5JtbN7CFeJ+ieo8YuRSGI=
X-Received: by 2002:ac2:5541:: with SMTP id l1mr1350397lfk.89.1599637932947;
 Wed, 09 Sep 2020 00:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-6-luoyonggang@gmail.com>
 <31826ac4-9c97-8cfa-6a23-5db069ea77af@redhat.com>
In-Reply-To: <31826ac4-9c97-8cfa-6a23-5db069ea77af@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 15:52:01 +0800
Message-ID: <CAE2XoE-OwFpps=oQxgn8wYhCYAkJB8nFpoxob+SnDFjXdd6Exg@mail.gmail.com>
Subject: Re: [PATCH 05/16] tests: disable /char/stdio/* tests in test-char.c
 on win32
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c33ffa05aedcba58"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x144.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c33ffa05aedcba58
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 3:13 PM Thomas Huth <thuth@redhat.com> wrote:

> On 08/09/2020 21.48, Yonggang Luo wrote:
> > These tests are blocking test-char to be finished.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  tests/test-char.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tests/test-char.c b/tests/test-char.c
> > index d35cc839bc..80e5bac61a 100644
> > --- a/tests/test-char.c
> > +++ b/tests/test-char.c
> > @@ -103,6 +103,7 @@ static void char_console_test(void)
> >      g_test_trap_assert_stdout("CONSOLE");
> >  }
> >  #endif
> > +#ifndef _WIN32
> >  static void char_stdio_test_subprocess(void)
> >  {
> >      Chardev *chr;
> > @@ -126,6 +127,7 @@ static void char_stdio_test(void)
> >      g_test_trap_assert_passed();
> >      g_test_trap_assert_stdout("buf");
> >  }
> > +#endif
> >
> >  static void char_ringbuf_test(void)
> >  {
> > @@ -1471,8 +1473,10 @@ int main(int argc, char **argv)
> >      g_test_add_func("/char/console/subprocess",
> char_console_test_subprocess);
> >      g_test_add_func("/char/console", char_console_test);
> >  #endif
> > +#ifndef _WIN32
> >      g_test_add_func("/char/stdio/subprocess",
> char_stdio_test_subprocess);
> >      g_test_add_func("/char/stdio", char_stdio_test);
> > +#endif
> >  #ifndef _WIN32
> >      g_test_add_func("/char/pipe", char_pipe_test);
> >  #endif
>
> I think you could rather simply replace the three #ifndef _WIN32
> sections with only one?
>
That's easy, I am wondering if /char/stdio are able works under win32?
And also the  /char/pipe, anyway disable it first, trying it latter

>
>  Thomas
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000c33ffa05aedcba58
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 3:13 PM Thomas=
 Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 08/09/2020=
 21.48, Yonggang Luo wrote:<br>
&gt; These tests are blocking test-char to be finished.<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/test-char.c | 4 ++++<br>
&gt;=C2=A0 1 file changed, 4 insertions(+)<br>
&gt; <br>
&gt; diff --git a/tests/test-char.c b/tests/test-char.c<br>
&gt; index d35cc839bc..80e5bac61a 100644<br>
&gt; --- a/tests/test-char.c<br>
&gt; +++ b/tests/test-char.c<br>
&gt; @@ -103,6 +103,7 @@ static void char_console_test(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_trap_assert_stdout(&quot;CONSOLE&quot;);<br=
>
&gt;=C2=A0 }<br>
&gt;=C2=A0 #endif<br>
&gt; +#ifndef _WIN32<br>
&gt;=C2=A0 static void char_stdio_test_subprocess(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Chardev *chr;<br>
&gt; @@ -126,6 +127,7 @@ static void char_stdio_test(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_trap_assert_passed();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_trap_assert_stdout(&quot;buf&quot;);<br>
&gt;=C2=A0 }<br>
&gt; +#endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void char_ringbuf_test(void)<br>
&gt;=C2=A0 {<br>
&gt; @@ -1471,8 +1473,10 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/console/subprocess&quo=
t;, char_console_test_subprocess);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/console&quot;, char_co=
nsole_test);<br>
&gt;=C2=A0 #endif<br>
&gt; +#ifndef _WIN32<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/stdio/subprocess&quot;=
, char_stdio_test_subprocess);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/stdio&quot;, char_stdi=
o_test);<br>
&gt; +#endif<br>
&gt;=C2=A0 #ifndef _WIN32<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/pipe&quot;, char_pipe_=
test);<br>
&gt;=C2=A0 #endif<br>
<br>
I think you could rather simply replace the three #ifndef _WIN32<br>
sections with only one?<br></blockquote><div>That&#39;s easy, I am wonderin=
g if /char/stdio are able works under win32?=C2=A0</div><div>And also the=
=C2=A0

/char/pipe, anyway disable it first, trying it latter</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000c33ffa05aedcba58--

