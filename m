Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8513AC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FF620639
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVoMO3bt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FF620639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvCK-0004FS-Pw
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIv5h-0004yu-33
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:40:53 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f]:46901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIv5b-0006PR-90
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:40:52 -0400
Received: by mail-lf1-x12f.google.com with SMTP id b22so2417570lfs.13
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 07:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=8FOn75ea5PCViutIXpJ9LstH9WGOCWXH+VaHsx9B1TY=;
 b=eVoMO3btpYH4mfo5heV72Jw39fQLUt8N3TVkyR8geRLcTQW4cJ1CGyeXH+3yctUGnl
 pSSJWhQKsl0fxuTntAHyBfou8abQ5q+cmzE8Xa/jn9rSJULIb5ZmMDJ5F5n0AGUhWMky
 4wctoSuNLMHqTV6A0nBjspUs1BgvGsl/+Wz3Fe+vV6Qts0KjO9l7SQ5nXezQ5r9vNwOk
 QhpzCMXwc9mwXr0K0RCC5ZxhsHgBpwnOEYPb+huxQsuJPwBkMDSuJMGfFskC8zhOzGgE
 H2NgxZMF2q7wFAbzstbQT+VINiaVAJBOu18ZEUM79u4/W464FS9Ncu93OZc2cLkN+dQb
 Yorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=8FOn75ea5PCViutIXpJ9LstH9WGOCWXH+VaHsx9B1TY=;
 b=fFrrYsLY9hrkYsIfDo7Z9tuoHc7LQyNsgyGLm/q/1PDQ6EiSpefA368cdSB9P+qmK6
 9m72tNlqAvSMuBZu0mulbXLEv+vfpRSkDAn+BEWnyGqyCsGgUfEJRQtCdWnyg4EToyra
 qwf4IuEUH23hsF7liY+QRLW4xyjmMTrK305bFtfGa7GZbuU7X6dHZvxTFUHiOcjM1NV5
 PUvTobru04FgJeb6JAjaTZnAXWVclnK+LVlJx3PA5i1jOedg7/PRC8c5qys/KpFwFwSW
 U3PEVu2ArdziW8Ku9R8BUMnrhwy4ZtOXCmzxS8MfH+FtUrAB/LbN6dYtdSjvBITBajB0
 Zd9A==
X-Gm-Message-State: AOAM5331kbB6IIqAGtvPbx4I9WdHzIGo51et1r2UGwJoeak5fxiLKTQt
 hf0+YYYj8dQzKDhDLoQMdHjdnx8eMqdZq3aPOyE=
X-Google-Smtp-Source: ABdhPJyzRQUAX1nqz/AW1Ek3vfEichHt0OGq2B9od5HDPTY/FYw9l2tHHVV4JyopfjtKWdaJkABB6GgC6B2YOzRohxA=
X-Received: by 2002:a19:a407:: with SMTP id q7mr8715780lfc.377.1600353643332; 
 Thu, 17 Sep 2020 07:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200916114731.102080-1-thuth@redhat.com>
 <CAFEAcA-sN1+wsZ9sN6PckR=_74Ncj1y=AVZ9QHj5WpxxsJvQ8A@mail.gmail.com>
In-Reply-To: <CAFEAcA-sN1+wsZ9sN6PckR=_74Ncj1y=AVZ9QHj5WpxxsJvQ8A@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 17 Sep 2020 22:40:31 +0800
Message-ID: <CAE2XoE_APDazcLgdrv3h1TW_3Fw_qEADhQKb58O74pdeGz=stQ@mail.gmail.com>
Subject: Re: [PULL 00/24] qtests, unit tests and Cirrus-CI fixes / improvements
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006d0ab605af835ece"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12f.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006d0ab605af835ece
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2020 at 9:46 PM Peter Maydell <peter.maydell@linaro.org>
wrote:
>
> On Wed, 16 Sep 2020 at 12:47, Thomas Huth <thuth@redhat.com> wrote:
> >
> >  Hi Peter,
> >
> > the following changes since commit
de39a045bd8d2b49e4f3d07976622c29d58e0bac:
> >
> >   Merge remote-tracking branch
'remotes/kraxel/tags/vga-20200915-pull-request' into staging (2020-09-15
14:25:05 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-16
> >
> > for you to fetch changes up to 114daec31d64600e5a070abcdb8de2cf74d01e94=
:
> >
> >   cirrus: Building freebsd in a single shot (2020-09-16 12:15:07 +0200)
> >
> > ----------------------------------------------------------------
> > * Fix "readlink -f" problem in iotests on macOS (to fix the Cirrus-CI
tests)
> > * Some minor qtest improvements
> > * Fix the unit tests to work on MSYS2, too
> > * Enable building and testing on MSYS2 in the Cirrus-CI
> > * Build FreeBSD with one task again in the Cirrus-CI
> > ----------------------------------------------------------------
>
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
> for any user-visible changes.
>
> -- PMM

cirrus are too slow:
```

pm215 Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2=
=E2=80=A6
=E2=80=A6
5e0a8fd2 hours ago

Git stats

 80,622 commits
--

after two hours still not finished.

Github have far more hardware resources. except doesn't have freebsd.
When I using github with wind32, it's running around 1hour with full
build(all target build).
That's because when trigger github ci, it's will allocating resouce
instantly

         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000006d0ab605af835ece
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, Sep 17, 2020 at 9:46 PM Peter Maydell &lt;=
<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt=
; wrote:<br>&gt;<br>&gt; On Wed, 16 Sep 2020 at 12:47, Thomas Huth &lt;<a h=
ref=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt; &gt=
;<br>&gt; &gt; =C2=A0Hi Peter,<br>&gt; &gt;<br>&gt; &gt; the following chan=
ges since commit de39a045bd8d2b49e4f3d07976622c29d58e0bac:<br>&gt; &gt;<br>=
&gt; &gt; =C2=A0 Merge remote-tracking branch &#39;remotes/kraxel/tags/vga-=
20200915-pull-request&#39; into staging (2020-09-15 14:25:05 +0100)<br>&gt;=
 &gt;<br>&gt; &gt; are available in the Git repository at:<br>&gt; &gt;<br>=
&gt; &gt; =C2=A0 <a href=3D"https://gitlab.com/huth/qemu.git">https://gitla=
b.com/huth/qemu.git</a> tags/pull-request-2020-09-16<br>&gt; &gt;<br>&gt; &=
gt; for you to fetch changes up to 114daec31d64600e5a070abcdb8de2cf74d01e94=
:<br>&gt; &gt;<br>&gt; &gt; =C2=A0 cirrus: Building freebsd in a single sho=
t (2020-09-16 12:15:07 +0200)<br>&gt; &gt;<br>&gt; &gt; -------------------=
---------------------------------------------<br>&gt; &gt; * Fix &quot;read=
link -f&quot; problem in iotests on macOS (to fix the Cirrus-CI tests)<br>&=
gt; &gt; * Some minor qtest improvements<br>&gt; &gt; * Fix the unit tests =
to work on MSYS2, too<br>&gt; &gt; * Enable building and testing on MSYS2 i=
n the Cirrus-CI<br>&gt; &gt; * Build FreeBSD with one task again in the Cir=
rus-CI<br>&gt; &gt; -------------------------------------------------------=
---------<br>&gt;<br>&gt;<br>&gt; Applied, thanks.<br>&gt;<br>&gt; Please u=
pdate the changelog at <a href=3D"https://wiki.qemu.org/ChangeLog/5.2">http=
s://wiki.qemu.org/ChangeLog/5.2</a><br>&gt; for any user-visible changes.<b=
r>&gt;<br>&gt; -- PMM<br><br>cirrus are too slow:<div>```</div><div><br>pm2=
15 Merge remote-tracking branch &#39;remotes/huth-gitlab/tags/pull-request-=
2=E2=80=A6<br>=E2=80=A6<br>5e0a8fd2 hours ago<br><br>Git stats<br><br>=C2=
=A080,622 commits<br>--</div><div><br></div><div>after two hours still not =
finished.</div><div><br></div><div>Github have far more hardware resources.=
 except doesn&#39;t have freebsd.</div><div>When I using github with wind32=
, it&#39;s running around 1hour with full build(all target build).</div><di=
v>That&#39;s because when trigger github ci, it&#39;s will allocating resou=
ce instantly</div><div><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000006d0ab605af835ece--

