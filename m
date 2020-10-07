Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96FAC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2948A20789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKroUWUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2948A20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQBpG-0002E6-V1
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQBmV-0000SG-5w; Wed, 07 Oct 2020 11:55:07 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:43146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQBmT-0008Is-7y; Wed, 07 Oct 2020 11:55:06 -0400
Received: by mail-lf1-x143.google.com with SMTP id g2so2849816lfr.10;
 Wed, 07 Oct 2020 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=0SYZjT/U5yga+MqTmx2WBDt0rVnyLfq7H/0+t0WpKLw=;
 b=cKroUWUohtJEkBSE+BW1Ul86uDJy0Mwnnyd2fCG9owlASK513zWWky1ANmyuu+Zqnp
 iucZR/B5eto+qmu9l+aB6m0XmjJmUk7Vd/8P8RgiOpRlbyPt8brmJbThuneALD4z/UrS
 R3Z0aKE1QWpLb9D4I0swwSGQM+UVTSLu7wRTxzwKuxzrVGuvHY3WOI43pRmXwMLrc1Uf
 q7t5jAw0I4rMumfK2TihtzV5/iedZ83SxIHVKd28nazG1XW+pwiS0zZIS8lELNMcfL+s
 43Kv63JNVTI6J8ZLNgP/C9ofw+SArSAXQqz6agqovyOYNtFQQHTiCDGAj2Jwfrtr/KqP
 vuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=0SYZjT/U5yga+MqTmx2WBDt0rVnyLfq7H/0+t0WpKLw=;
 b=RN3iIycCrsjhjoGC/EpYD4eNrlpXmqfNlWiwp1ia+lOF4vKeM7oaY25y6bTp7YhGF3
 28Wl8VSVhPIg7IG5yyNBd4ryV+RtZwHRrEjPptmv1Bjvog+o6PAhsv0lCOhNZxpEWw6/
 vSMWXgkgcJ2BktHEZ5Cq06NPpW22lkIaj3DJvQHybvV20APop4jVIMG4eQPiEkQvN7cA
 Jsrp+WO138Vfrv2o00AbeDKwFTP6TsZvalisEEBhnM0teh0yk36VAot7sijoLYIJY1Gj
 rUeL4S2q7RUd68r8r6i+lk8RGkEdL076sG2leEbQ9TlB08bvqOgHTI7V8nHVZLyx2Vp5
 qOyg==
X-Gm-Message-State: AOAM532GpJJL7OplBukiCyXVYmbZRMDHOHx3HP2QOrC9x0IRVPMKxsLc
 TlzPqMZp2ARpLoB99UP3PhZMJcDrrQ3PhtpdhcU=
X-Google-Smtp-Source: ABdhPJx9rNqK9GO+PcUsMZ3hymTt5QiSZN6Tz2qR6a8Db0dJBWq9ySPkr0vfsojHVbfb/xJed5zLGi888PhDhUmL+UQ=
X-Received: by 2002:a05:6512:3f0:: with SMTP id
 n16mr1107814lfq.554.1602086102210; 
 Wed, 07 Oct 2020 08:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201007145300.1197-1-luoyonggang@gmail.com>
 <20201007145300.1197-2-luoyonggang@gmail.com>
 <11e4e784-3ce9-a385-bf81-8c7e1034f42d@redhat.com>
In-Reply-To: <11e4e784-3ce9-a385-bf81-8c7e1034f42d@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2020 23:54:49 +0800
Message-ID: <CAE2XoE89z44nA=N-U_r-C8RA5Vn+C3gqABt85PLFPcSg4ET5gw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] cirrus: Fixing and speedup the msys2/mingw CI
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000005a02a05b116bd1a"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x143.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000005a02a05b116bd1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2020 at 11:12 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 07/10/2020 16.52, Yonggang Luo wrote:
> > Use cache of cirrus caching msys2
> > The install of msys2 are refer to https://github.com/msys2/setup-msys2
> > The first time install msys2 would be time consuming, so increase
timeout_in to 90m
> > according to https://cirrus-ci.org/faq/#instance-timed-out
> >
> > Apply patch of
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00072.html
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  .cirrus.yml | 110 +++++++++++++++++++++++++++++++---------------------
> >  1 file changed, 66 insertions(+), 44 deletions(-)
> >
> > diff --git a/.cirrus.yml b/.cirrus.yml
> > index d58782ce67..a1145d0366 100644
> > --- a/.cirrus.yml
> > +++ b/.cirrus.yml
> > @@ -46,64 +46,86 @@ macos_xcode_task:
> >      - gmake check
> >
> >  windows_msys2_task:
> > +  timeout_in: 90m
> >    windows_container:
> > -    image: cirrusci/windowsservercore:cmake
> > +    image: cirrusci/windowsservercore:2019
> >      os_version: 2019
> >      cpu: 8
> >      memory: 8G
> >    env:
> > +    CIRRUS_SHELL: powershell
> >      MSYS: winsymlinks:nativestrict
> >      MSYSTEM: MINGW64
> >      CHERE_INVOKING: 1
> >    printenv_script:
> > -    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
> > +    - choco install -y --no-progress 7zip
>
> Since you've now removed the 'printenv' line, I think the section should
> maybe not be called "printenv_script" anymore, should it?
May I name it install_7zip?
Cause that's a deps need installed first.
>
>  Thomas
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000005a02a05b116bd1a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Oct 7, 2020 at 11:12 PM Thomas Huth &lt;<a=
 href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt;<b=
r>&gt; On 07/10/2020 16.52, Yonggang Luo wrote:<br>&gt; &gt; Use cache of c=
irrus caching msys2<br>&gt; &gt; The install of msys2 are refer to <a href=
=3D"https://github.com/msys2/setup-msys2">https://github.com/msys2/setup-ms=
ys2</a><br>&gt; &gt; The first time install msys2 would be time consuming, =
so increase timeout_in to 90m<br>&gt; &gt; according to <a href=3D"https://=
cirrus-ci.org/faq/#instance-timed-out">https://cirrus-ci.org/faq/#instance-=
timed-out</a><br>&gt; &gt;<br>&gt; &gt; Apply patch of <a href=3D"https://l=
ists.gnu.org/archive/html/qemu-devel/2020-10/msg00072.html">https://lists.g=
nu.org/archive/html/qemu-devel/2020-10/msg00072.html</a><br>&gt; &gt;<br>&g=
t; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail=
.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0.ci=
rrus.yml | 110 +++++++++++++++++++++++++++++++---------------------<br>&gt;=
 &gt; =C2=A01 file changed, 66 insertions(+), 44 deletions(-)<br>&gt; &gt;<=
br>&gt; &gt; diff --git a/.cirrus.yml b/.cirrus.yml<br>&gt; &gt; index d587=
82ce67..a1145d0366 100644<br>&gt; &gt; --- a/.cirrus.yml<br>&gt; &gt; +++ b=
/.cirrus.yml<br>&gt; &gt; @@ -46,64 +46,86 @@ macos_xcode_task:<br>&gt; &gt=
; =C2=A0 =C2=A0 =C2=A0- gmake check<br>&gt; &gt; <br>&gt; &gt; =C2=A0window=
s_msys2_task:<br>&gt; &gt; + =C2=A0timeout_in: 90m<br>&gt; &gt; =C2=A0 =C2=
=A0windows_container:<br>&gt; &gt; - =C2=A0 =C2=A0image: cirrusci/windowsse=
rvercore:cmake<br>&gt; &gt; + =C2=A0 =C2=A0image: cirrusci/windowsservercor=
e:2019<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0os_version: 2019<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0cpu: 8<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0memory: 8G<br>&gt;=
 &gt; =C2=A0 =C2=A0env:<br>&gt; &gt; + =C2=A0 =C2=A0CIRRUS_SHELL: powershel=
l<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0MSYS: winsymlinks:nativestrict<br>&gt; &=
gt; =C2=A0 =C2=A0 =C2=A0MSYSTEM: MINGW64<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0C=
HERE_INVOKING: 1<br>&gt; &gt; =C2=A0 =C2=A0printenv_script:<br>&gt; &gt; - =
=C2=A0 =C2=A0- C:\tools\msys64\usr\bin\bash.exe -lc &#39;printenv&#39;<br>&=
gt; &gt; + =C2=A0 =C2=A0- choco install -y --no-progress 7zip<br>&gt;<br>&g=
t; Since you&#39;ve now removed the &#39;printenv&#39; line, I think the se=
ction should<br>&gt; maybe not be called &quot;printenv_script&quot; anymor=
e, should it?<div>May I name it install_7zip?</div><div>Cause that&#39;s a =
deps need installed first.<br>&gt;<br>&gt; =C2=A0Thomas<br>&gt;<br><br><br>=
--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=
=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggan=
g Luo</div></div>

--00000000000005a02a05b116bd1a--

