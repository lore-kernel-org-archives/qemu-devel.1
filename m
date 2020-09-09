Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A094AC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51F6207DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcNiaMBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51F6207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvh6-0007ux-Q0
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFvgA-0006D5-C6; Wed, 09 Sep 2020 04:42:10 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFvg8-0007hC-Kc; Wed, 09 Sep 2020 04:42:10 -0400
Received: by mail-lj1-x243.google.com with SMTP id b19so2403250lji.11;
 Wed, 09 Sep 2020 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=NDABxyVyl1pQooZpojSpIpc+FlozjQKM/r8a8BjFwX4=;
 b=FcNiaMBw0HBPk2cXQ62q1Ga7q4A/bCUts0K1vDxuhDYRmGQXC4XUvYsOjy0HfNxLHt
 IrAo0DOnGmUs5Mqf1rijCwDJujyYtbEFwB6o47RcRrYYNTHqs35JJtkAMt7j/tv94/WD
 hXCkOMuOULbMGmP/cDm4YGvsWY1BATSa5cHteOe0XWu5trflRmW+if0h1QH1rrQinKKY
 /x+WLKVtX2hZoPTmi81cJPSDl7fxmR7pIiBn+RZEnNX3BIZEDvj/mmogEscMLA42+Ijp
 IldWQlUVr9hWSJWUea+A1Hly8gAkL8Ls1joTjbn3evkvd3JpHnrUJTRADo6/TwbY9ycN
 4tYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=NDABxyVyl1pQooZpojSpIpc+FlozjQKM/r8a8BjFwX4=;
 b=cBgTmZpfR5rStSOiPosrvKmYbQCjqYwOBLg8/d6TTVzcxMO1DZhzy4ZuV9/PfGizKt
 ome4QFcQi2RdBOkEV+1N0/k5Tl6fwDqhzD5qgxzas2Xn30N1++bkcw0y/r24dGJOpxe/
 Jb3F415Bs34w9DTtbX4XqgOKRrdfpcdQxXTEIsf/DRktV3srup0TkrQ1YCxYJcmRtCU9
 UbPir+ee4HVo0uyOSPAQ3CPl/1PM8ltlaBe/ABvESJc51pJBxLUQC1TiVVh6rM95SChb
 cMNiBxdGbH5KhTrDMjP0DmuA9tlgy8TWw6WFFn2QQtgt/C+7lkJSO59Q3vSkVJhH004R
 6dFw==
X-Gm-Message-State: AOAM5328Qdlei0ejz98uzi2QlmDs3bmQK7zjCccwXuZ1g5oCrh04m+A3
 1MaNPcM+fmi3Jz01N4vJeK1E2E2/ao7bRgGmthY=
X-Google-Smtp-Source: ABdhPJzkPiwnTNwpZlrHWjQMrstK/ef9FK5+nPaL5aj11Up4z+9hTXXAenOEmqEbU67Us0oQUh5Mei+rXh4c7criZ5I=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr1322402ljj.120.1599640926351; 
 Wed, 09 Sep 2020 01:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-9-luoyonggang@gmail.com>
 <20200909081931.GC5219@linux.fritz.box>
In-Reply-To: <20200909081931.GC5219@linux.fritz.box>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 16:41:55 +0800
Message-ID: <CAE2XoE-g=jw_=j8RbZ29FBrERt6mj8WHbR2Pt9LQ0PaC2tg96g@mail.gmail.com>
Subject: Re: [PATCH 08/16] block: get file-win32.c handle locking option
 consistence with file-posix.c
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002ef3c205aedd6dc2"
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
Cc: Peter Lieven <pl@kamp.de>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002ef3c205aedd6dc2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 4:19 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 08.09.2020 um 21:48 hat Yonggang Luo geschrieben:
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  block/file-win32.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
>
> This is almost the same as my separately posted 'file-win32: Fix
> "locking" option', except that you changed the order of variable
> definitions which will cause a merge conflict.
>
> When you take patches from other people, you should correctly attribute
> them and not make them look as if they were your own.
>
> Commit messages should not be empty, but explain the motivation for the
> change.
>
I know someone else have already have fixes for it, so I didn't detail it
much, Ineed
I wanna skip it when sending patches, but  git-publish.py didn't handle it
well under Win32 yet

>
> In this case, dropping the patch is easiest because my patch is already
> in a pull request and will probably be merged soon.
>
I am waiting it to merged, at the current stage, if I don't include this
patch the
test runner will fail.

>
> Kevin
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000002ef3c205aedd6dc2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 4:19 PM Kevin =
Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 08.09.2020 =
um 21:48 hat Yonggang Luo geschrieben:<br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 block/file-win32.c | 23 +++++++++++++++++++++--<br>
&gt;=C2=A0 1 file changed, 21 insertions(+), 2 deletions(-)<br>
<br>
This is almost the same as my separately posted &#39;file-win32: Fix<br>
&quot;locking&quot; option&#39;, except that you changed the order of varia=
ble<br>
definitions which will cause a merge conflict.<br>
<br>
When you take patches from other people, you should correctly attribute<br>
them and not make them look as if they were your own.<br>
<br>
Commit messages should not be empty, but explain the motivation for the<br>
change.<br></blockquote><div>I know someone else have already have fixes fo=
r it, so I didn&#39;t detail it much, Ineed</div><div>I wanna skip it when =
sending patches, but=C2=A0 git-publish.py didn&#39;t handle it well under W=
in32 yet=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
In this case, dropping the patch is easiest because my patch is already<br>
in a pull request and will probably be merged soon.<br></blockquote><div>I =
am waiting it to merged, at the current stage, if I don&#39;t include this =
patch the</div><div>test runner will fail.=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
Kevin<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000002ef3c205aedd6dc2--

