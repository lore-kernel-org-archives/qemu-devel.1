Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57131C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9141E20732
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j45WfkdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9141E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkhX-0006xl-CB
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFkgg-0006L7-TO; Tue, 08 Sep 2020 16:57:59 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFkge-00032Z-J9; Tue, 08 Sep 2020 16:57:58 -0400
Received: by mail-lj1-x243.google.com with SMTP id u4so659782ljd.10;
 Tue, 08 Sep 2020 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=YKNGFIhab+O8UQv9llUqPAnsmhPCuuxkAz5XKfWraAE=;
 b=j45WfkdBHqz5+ayAnYUbptx5zzvq5iqEFqBmCOiTG4fy2pD/+DY/PuRujgS3suMkq5
 ADE+v4c08yXFi6NilAi96ToTxIooHR7HbTRJpBW1XW8EbXnwnUaqG+/qxUvS2IeYvQBd
 4y8/Q7uEe4E7Li/QtdUi2bdPLs6FuYOt/2/Pu90UqITgroezDxAKq6U64Ul5vM+rfftZ
 N0+tNCRx/C+Wi7q+ehYl5/uZfdBPBULER2wGpZxA75a9PcrhtJ5mGYzPGUJlh1lrSFa5
 dcZtA6flykaC8lfcJePItt5l53I8HBM4T8Mnd8gxsNB3J+p0dLI3HY+sXGIpmfJfp4GJ
 1cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=YKNGFIhab+O8UQv9llUqPAnsmhPCuuxkAz5XKfWraAE=;
 b=ROVobsHMKk/dcrZakLpru68oIWCYc7EOcYZ5Wdfk+dzgSYDKJUln9cmIHF+ACP/QhU
 v4VxlN0kypb63ZdJmiazWkfYx6nd3tK7/KW5R7WEVFRrAJydjRKywjnHnvW52SomXC6C
 zwVzKElAM4b+s+VfsCOx/zA0ZsN/eZ5QMkmpLqnBo0wkY9mvPd7QWgjizECRKqOX9ER6
 9ejsZ/WBRum4PaitPgopPGs2buUiJVp2FZFbqeXBKKCntcStGo4SpZnC4jfLRzcQkP0p
 oMEnTRjpyVkANDqCqULYXSjDpQJ7qGzTairNaOuUz06PxNh4vsfK9km5sWuKPFvog3fU
 +6Ig==
X-Gm-Message-State: AOAM532Xy0dI5CoJ4bcC+x3d3LIowcWZLbBRa3pEjqB7vLBp8NPnpFJM
 UYRCe6rL+WNcOF5jwgUjIhdHgSJu7UDzDBU7Ylc=
X-Google-Smtp-Source: ABdhPJyGEfbCZuS15URkheQLmwxTRAbeV45c0CjRIf5Iouol8o6zFMETgXds2JiuSbulfk9BLJLyx3nnvH/b6U/n0QE=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr177788ljj.447.1599598674620;
 Tue, 08 Sep 2020 13:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-3-luoyonggang@gmail.com>
 <CAFEAcA9PBBqykwBqTzQiYbwK5qZmhEsdn5ZURGHaFNPgoE0vvA@mail.gmail.com>
In-Reply-To: <CAFEAcA9PBBqykwBqTzQiYbwK5qZmhEsdn5ZURGHaFNPgoE0vvA@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 04:57:43 +0800
Message-ID: <CAE2XoE8DrcBr3bxor_sLSHSDMcADmzBjGHHUbH2DqXPdxLiEEQ@mail.gmail.com>
Subject: Re: [PATCH 02/16] ci: fixes msys2 build by upgrading capstone to 4.0.2
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c8b4ce05aed396f4"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c8b4ce05aed396f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 4:36 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 8 Sep 2020 at 20:50, Yonggang Luo <luoyonggang@gmail.com> wrote:
> >
> > The currently random version capstone have the following compiling issu=
e:
> >   CC      /c/work/xemu/qemu/build/slirp/src/arp_table.o
> > make[1]: *** No rule to make target
> =E2=80=9C/c/work/xemu/qemu/build/capstone/capstone.lib=E2=80=9D=E3=80=82 =
Stop.
> >
> > Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1 are the
> tagged version 4.0.2
>
> Richard H says that last time we tried to move the capstone
> submodule forward there were "all sorts of random portability problems
> across old/odd systems", so this is probably likely to have issues
> when it gets tested on other systems.
>
Which system specifically, maybe they are dropped now or we can convert
capstone to meson?

>
> thanks
> -- PMm
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000c8b4ce05aed396f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 4:36 AM Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Tue, 8 Sep 2020 at 20:50, Yonggang Luo &lt;<a href=3D"mailto:luoyon=
ggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The currently random version capstone have the following compiling iss=
ue:<br>
&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 /c/work/xemu/qemu/build/slirp/src/a=
rp_table.o<br>
&gt; make[1]: *** No rule to make target =E2=80=9C/c/work/xemu/qemu/build/c=
apstone/capstone.lib=E2=80=9D=E3=80=82 Stop.<br>
&gt;<br>
&gt; Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1 are the tag=
ged version 4.0.2<br>
<br>
Richard H says that last time we tried to move the capstone<br>
submodule forward there were &quot;all sorts of random portability problems=
<br>
across old/odd systems&quot;, so this is probably likely to have issues<br>
when it gets tested on other systems.<br></blockquote><div>Which system spe=
cifically, maybe they are dropped now or we can convert capstone to meson?=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMm<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000c8b4ce05aed396f4--

