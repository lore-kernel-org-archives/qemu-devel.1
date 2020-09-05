Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C4BC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05E1208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvtBDg04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05E1208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kERbd-0005ro-Lc
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 02:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERZx-0004qf-Iz; Sat, 05 Sep 2020 02:21:37 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f]:44173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERZv-0003L3-Ef; Sat, 05 Sep 2020 02:21:37 -0400
Received: by mail-lj1-x22f.google.com with SMTP id b19so10346843lji.11;
 Fri, 04 Sep 2020 23:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=lY0r8pXQdL7oA0lPPm8ZWEd1e2LMxXbW7mUoC9+CH34=;
 b=cvtBDg04xs1/Qiyt7B1m4b3Be0ZCYE78E9pVKBaW8tANTj1tRLT+wB+zZhLVay3amM
 aaZdjxDlelZFYxNgGqm+hVgwUB7eAv8+0K+/qnTkIXEXBKOd4DqKfHKgtFGHb+fxrbz2
 Xuo7vzyE6avIA69PG0C5X/Rn19TKC6lK2JlmlJHLh9y3g328FEXizc7DTfUc1eTu2JpK
 g/QjBiqN31gf1S4YEiM84IGWHqtn4yt4KPWqg9muabok9M+h1kZYnDcZvWN4yabXL87D
 D5UkYsxrTQB5Le5s84HZPq6AiDOYHeYG2DCCQSYkHYHTxOioDPgTBBGftqCu0HLiSji1
 Q6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=lY0r8pXQdL7oA0lPPm8ZWEd1e2LMxXbW7mUoC9+CH34=;
 b=GNTc9c1/8dXZN6PfUYYeB+E4Szd79/cWboONF3ru/CPldab2u2Bpbdr3x1UXoI/0uZ
 8MnLCUo83XvxJwgTew9q2RZG1PVb77wkmJ0paQk1hDo+ZfXKzhJbK/JK7vbZjcNWdHu2
 7H/kmsEN1S3tP1aiYKVCUe17Lz0oD30zdBg4zKfg4/GoVSJHFuizRvsh9yJ879hVwxy9
 JC1cu4n2OxGimYK2idIb5ojl58C1P5BEhlt5Mc5AcvgTD+exW8/dyeNaexVxutx4FMPO
 AKFrw8OtEcZ5imbtZ+LbArl9fSrsTbKUY4oBYhIbWEsj12Z/jVoebfJ1gY2hqSrwCS5q
 UOHw==
X-Gm-Message-State: AOAM531SFDCMje1HhSW0z7bSOjN/bUrs0xmo5Z6/3X9KGNjfdYo6SsPr
 Z01rxrZ3sLnKs8iofxAGYeZ38VytFjDi+WLsQ0E=
X-Google-Smtp-Source: ABdhPJzhicPAHVpMDmDIR9vPVXa+NNLo/XLAFpEgkgrSsUMhFqnDvcstOqrgdhGTCUdlWkQuVJhElpZP3y5gWjWe7f8=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr4710730ljj.447.1599286892971; 
 Fri, 04 Sep 2020 23:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE_TJ2T2eN82km0pYqDiqOpsd=waH4EmCe==0k=GYpj3Xg@mail.gmail.com>
 <3d2db346-2517-f6e3-748d-79a8ae993e06@redhat.com>
 <CAE2XoE_3Kjjk+tRz1y7rk94+vre2FSfmCGQVWNgjNW14vSNSdw@mail.gmail.com>
 <48c60a95-c30b-433a-7955-3845074776d8@redhat.com>
 <20200904085057.GB6237@linux.fritz.box>
In-Reply-To: <20200904085057.GB6237@linux.fritz.box>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 5 Sep 2020 14:21:20 +0800
Message-ID: <CAE2XoE9na-+OPH1HcssE4yB56B2aDPb6xX1dsQ8J1BQ4d+s_Ww@mail.gmail.com>
Subject: Re: make -i check resut for msys2
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000264e8105ae8aff49"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22f.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000264e8105ae8aff49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2020 at 4:51 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 04.09.2020 um 08:03 hat Thomas Huth geschrieben:
> > On 04/09/2020 00.53, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > >
> > >
> > > On Thu, Sep 3, 2020 at 10:33 PM Thomas Huth <thuth@redhat.com
> > > <mailto:thuth@redhat.com>> wrote:
> > >
> > >     On 03/09/2020 11.18, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wr=
ote:
> > >     [...]
> > >     >   TEST    check-unit: tests/test-replication.exe
> > >     > **
> > >     > ERROR:C:/work/xemu/qemu/tests/test-replication.c:136:make_temp:
> > >     > assertion failed: (fd >=3D 0)
> > >     > ERROR test-replication.exe - Bail out!
> > >     > ERROR:C:/work/xemu/qemu/tests/test-replication.c:136:make_temp:
> > >     > assertion failed: (fd >=3D 0)
> > >
> > >     At least this one should be easy to fix: The test uses /tmp as
> > >     hard-coded directory for temporary files. I think it should use
> > >     g_get_tmp_dir() from glib to get that directory instead.
> > >
> > >      Thomas
> > >
> > > After fixes tmp path, how to fixes following error:
> > > $ tests/test-replication.exe
>
> > >
> > >
> > >
> > > # random seed: R02Sdf2e4ffc0e6fbe96624598386b538927
> > > 1..13
> > > # Start of replication tests
> > > # Start of primary tests
> > > Unexpected error in bdrv_open_inherit() at ../block.c:3456:
> > > Block protocol 'file' doesn't support the option 'locking'
> >
> > Not sure ... as a temporary test, try to remove the "locking=3Doff"
> > strings from the test. If it then works, it might be worth discussing
> > with the block layer folks how to handle this test on Windows in the
> > best way. If it still does not work, it's maybe simply not worth the
> > effort to try to get this test running on Windows - and thus mark it
> > with CONFIG_POSIX in the Makefile / meson.build.
>
> This is a bug in file-win32. It reads "locking" from the options QDict,
> but doesn't delete it from it.
>
> Does the following help? (Only compile-tested.)
>
> If it works for you, I'll send it as a proper patch.
>
> Kevin
>
> diff --git a/block/file-win32.c b/block/file-win32.c
> index ab69bd811a..e2900c3a51 100644
> --- a/block/file-win32.c
> +++ b/block/file-win32.c
> @@ -299,6 +299,11 @@ static QemuOptsList raw_runtime_opts =3D {
>              .type =3D QEMU_OPT_STRING,
>              .help =3D "host AIO implementation (threads, native)",
>          },
> +        {
> +            .name =3D "locking",
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "file locking mode (on/off/auto, default: auto)",
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -333,6 +338,7 @@ static int raw_open(BlockDriverState *bs, QDict
> *options, int flags,
>      Error *local_err =3D NULL;
>      const char *filename;
>      bool use_aio;
> +    OnOffAuto locking;
>      int ret;
>
>      s->type =3D FTYPE_FILE;
> @@ -343,10 +349,24 @@ static int raw_open(BlockDriverState *bs, QDict
> *options, int flags,
>          goto fail;
>      }
>
> -    if (qdict_get_try_bool(options, "locking", false)) {
> +    locking =3D qapi_enum_parse(&OnOffAuto_lookup,
> +                              qemu_opt_get(opts, "locking"),
> +                              ON_OFF_AUTO_AUTO, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +    switch (locking) {
> +    case ON_OFF_AUTO_ON:
>          error_setg(errp, "locking=3Don is not supported on Windows");
>          ret =3D -EINVAL;
>          goto fail;
> +    case ON_OFF_AUTO_OFF:
> +    case ON_OFF_AUTO_AUTO:
> +        break;
> +    default:
> +        g_assert_not_reached();
>      }
>
>      filename =3D qemu_opt_get(opts, "filename");
>
> Partial error fixed, new error are coming:
$ ./tests/test-replication.exe
# random seed: R02S3f4d1c01af2b0a046990e0235c481faf
1..13
# Start of replication tests
# Start of primary tests
ok 1 /replication/primary/read
ok 2 /replication/primary/write
ok 3 /replication/primary/start
ok 4 /replication/primary/stop
ok 5 /replication/primary/do_checkpoint
ok 6 /replication/primary/get_error_all
# End of primary tests
# Start of secondary tests
ok 7 /replication/secondary/read
ok 8 /replication/secondary/write
Unexpected error in bdrv_reopen_prepare() at ../block.c:4191:
Block format 'file' used by node '#block4287' does not support reopening
files

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000264e8105ae8aff49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 4, 2020 at 4:51 PM Kevin =
Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 04.09.2020 =
um 08:03 hat Thomas Huth geschrieben:<br>
&gt; On 04/09/2020 00.53, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<=
br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; On Thu, Sep 3, 2020 at 10:33 PM Thomas Huth &lt;<a href=3D"mailto=
:thuth@redhat.com" target=3D"_blank">thuth@redhat.com</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:thuth@redhat.com" target=3D"_blank">=
thuth@redhat.com</a>&gt;&gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0On 03/09/2020 11.18, =E7=BD=97=E5=8B=87=E5=88=
=9A(Yonggang Luo) wrote:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0[...]<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 TEST =C2=A0 =C2=A0check-unit: test=
s/test-replication.exe<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; **<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; ERROR:C:/work/xemu/qemu/tests/test-replic=
ation.c:136:make_temp:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; assertion failed: (fd &gt;=3D 0)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; ERROR test-replication.exe - Bail out!<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; ERROR:C:/work/xemu/qemu/tests/test-replic=
ation.c:136:make_temp:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; assertion failed: (fd &gt;=3D 0)<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0At least this one should be easy to fix: The t=
est uses /tmp as<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0hard-coded directory for temporary files. I th=
ink it should use<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0g_get_tmp_dir() from glib to get that director=
y instead.<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0=C2=A0Thomas<br>
&gt; &gt; <br>
&gt; &gt; After fixes tmp path, how to fixes following error:<br>
&gt; &gt; $ tests/test-replication.exe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; # random seed: R02Sdf2e4ffc0e6fbe96624598386b538927<br>
&gt; &gt; 1..13<br>
&gt; &gt; # Start of replication tests<br>
&gt; &gt; # Start of primary tests<br>
&gt; &gt; Unexpected error in bdrv_open_inherit() at ../block.c:3456:<br>
&gt; &gt; Block protocol &#39;file&#39; doesn&#39;t support the option &#39=
;locking&#39;=C2=A0<br>
&gt; <br>
&gt; Not sure ... as a temporary test, try to remove the &quot;locking=3Dof=
f&quot;<br>
&gt; strings from the test. If it then works, it might be worth discussing<=
br>
&gt; with the block layer folks how to handle this test on Windows in the<b=
r>
&gt; best way. If it still does not work, it&#39;s maybe simply not worth t=
he<br>
&gt; effort to try to get this test running on Windows - and thus mark it<b=
r>
&gt; with CONFIG_POSIX in the Makefile / meson.build.<br>
<br>
This is a bug in file-win32. It reads &quot;locking&quot; from the options =
QDict,<br>
but doesn&#39;t delete it from it.<br>
<br>
Does the following help? (Only compile-tested.)<br>
<br>
If it works for you, I&#39;ll send it as a proper patch.<br>
<br>
Kevin<br>
<br>
diff --git a/block/file-win32.c b/block/file-win32.c<br>
index ab69bd811a..e2900c3a51 100644<br>
--- a/block/file-win32.c<br>
+++ b/block/file-win32.c<br>
@@ -299,6 +299,11 @@ static QemuOptsList raw_runtime_opts =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D QEMU_OPT_STRING,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.help =3D &quot;host AIO im=
plementation (threads, native)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;locking&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D QEMU_OPT_STRING,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .help =3D &quot;file locking mod=
e (on/off/auto, default: auto)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ /* end of list */ }<br>
=C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0};<br>
@@ -333,6 +338,7 @@ static int raw_open(BlockDriverState *bs, QDict *option=
s, int flags,<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0const char *filename;<br>
=C2=A0 =C2=A0 =C2=A0bool use_aio;<br>
+=C2=A0 =C2=A0 OnOffAuto locking;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;type =3D FTYPE_FILE;<br>
@@ -343,10 +349,24 @@ static int raw_open(BlockDriverState *bs, QDict *opti=
ons, int flags,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (qdict_get_try_bool(options, &quot;locking&quot;, false))=
 {<br>
+=C2=A0 =C2=A0 locking =3D qapi_enum_parse(&amp;OnOffAuto_lookup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_opt_get(opts, &quot;locking&quot;),<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ON_OFF_AUTO_AUTO, &amp;local_err);<br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 switch (locking) {<br>
+=C2=A0 =C2=A0 case ON_OFF_AUTO_ON:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;locking=3Don is no=
t supported on Windows&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
+=C2=A0 =C2=A0 case ON_OFF_AUTO_OFF:<br>
+=C2=A0 =C2=A0 case ON_OFF_AUTO_AUTO:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0filename =3D qemu_opt_get(opts, &quot;filename&quot;);<=
br>
<br>
</blockquote></div>Partial error fixed, new error are coming:<div>$ ./tests=
/test-replication.exe<br># random seed: R02S3f4d1c01af2b0a046990e0235c481fa=
f<br>1..13<br># Start of replication tests<br># Start of primary tests<br>o=
k 1 /replication/primary/read<br>ok 2 /replication/primary/write<br>ok 3 /r=
eplication/primary/start<br>ok 4 /replication/primary/stop<br>ok 5 /replica=
tion/primary/do_checkpoint<br>ok 6 /replication/primary/get_error_all<br># =
End of primary tests<br># Start of secondary tests<br>ok 7 /replication/sec=
ondary/read<br>ok 8 /replication/secondary/write<br>Unexpected error in bdr=
v_reopen_prepare() at ../block.c:4191:<br>Block format &#39;file&#39; used =
by node &#39;#block4287&#39; does not support reopening files<br clear=3D"a=
ll"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">=C2=A0=
 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=
=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></d=
iv></div></div>

--000000000000264e8105ae8aff49--

