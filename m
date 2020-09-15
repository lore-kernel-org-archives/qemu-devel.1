Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07030C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987FC21D43
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9XZykFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987FC21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9aG-0003Io-Qt
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9Zd-0002ns-CJ; Tue, 15 Sep 2020 07:56:37 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:34551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9Zb-0005Xa-Kt; Tue, 15 Sep 2020 07:56:37 -0400
Received: by mail-lj1-x243.google.com with SMTP id v23so2595227ljd.1;
 Tue, 15 Sep 2020 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=ED5UUky6yiLiSJRG4QKPB61kDJSG5iPivMEPYgd7Pzw=;
 b=d9XZykFTyJhbET9b3yGhrOR6RjJUm6SfWtBADorU3F55O97BfatFxzZZqi9W/+tDei
 9kkh4OjlbBMsNQFWvWhSvka223k/T0ea8Sq81U9KOWzcY+DvU2lE/vow0y5Ww8c9prSW
 b4DJPiQQlW8TzFy1HI9sS1lDlCLxOd/8oWwcolYEjzRBJ8ShxZ3idgfe7lVNAa2LkWKT
 LrPDuraZO37/AE9c+wGHqWsaRu7GUUYbz1dUrkiODZrP5AYqsgEYl+gOclwLMd/jg9te
 FoRF7SyPcrCU5xZm51BhG/o1MA2KvRnYIxsrNBoJoaBU7ItNAbV2nw4SPF467K290IUB
 yuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=ED5UUky6yiLiSJRG4QKPB61kDJSG5iPivMEPYgd7Pzw=;
 b=dmx7lPZxlUziaFIPd/trvRR6xR2kN01j3vBRMrivRnM/6Co/x9R8HbhvMOX2xGA9vT
 mo1Wx8vp3gcANn66yRmj2F97P16iufJw+TD+/p+/bqKVtf+bsMyB1D3ub4GauxNC7DAO
 cT1bXuOzd9pWpjl5g76fqB/WY2qOTpH0JswDfyh+WdwtyLyCQ0P1SZ/mPl81dUtw3BmL
 JSYHXqD26LYQ3EUV1GcD+caAU3hvOf7mrW3tlWzyrep8L17dwDUWka9wxFTQliDISU71
 IGAApCUL9t7rixr+c9VV9NYZtdtGfJ4rdlPSa2+9RLyIbK3nZ7D9kD6LcAwztFecJCfU
 jvbg==
X-Gm-Message-State: AOAM5315b63v5Gb+uYJ1Ltjjkj0i8RDtnTBJdMV2A26YTkTLYhCrpDeD
 Nyw8pJ6AIVUjCL3vEU9+TX4H+9XC4d20tkHSzp4=
X-Google-Smtp-Source: ABdhPJxaN0bbp7qFdle1e1sojeHA+hCx5aknZdUur31p27JeUl9vCJ+YkPhF7WBdEzUA2mUnA/DV5n8/9//pn6aqcpo=
X-Received: by 2002:a05:651c:1119:: with SMTP id
 d25mr6079481ljo.300.1600170991839; 
 Tue, 15 Sep 2020 04:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-28-luoyonggang@gmail.com>
 <34306ec4-bafb-20dc-f90f-ff320fa4b575@redhat.com>
 <4b60c854-d11c-28fb-57cf-e6e922e57df1@redhat.com>
In-Reply-To: <4b60c854-d11c-28fb-57cf-e6e922e57df1@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 15 Sep 2020 19:56:20 +0800
Message-ID: <CAE2XoE92B8fXC39==OS+xmYzjCDKg6pM8cG3doyLQN9ir8VsOA@mail.gmail.com>
Subject: Re: [PATCH v8 27/27] Revert "configure: add --ninja option"
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008c6eeb05af58d7d7"
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
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008c6eeb05af58d7d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 7:44 PM Thomas Huth <thuth@redhat.com> wrote:

> On 13/09/2020 16.08, Paolo Bonzini wrote:
> > On 13/09/20 00:44, Yonggang Luo wrote:
> >> This reverts commit 48328880fddf0145bdccc499160fb24dfabfbd41.
> >>
> >> The --ninja option doesn't need anymore because of upgrade meson to
> 0.55.2
> >> At that version we can use ninjatool
> >
> > We might actually get rid of ninjatool before QEMU 5.2 goes out, if we
> > decide to make Ninja a mandatory build dependency.  So we can hold on
> > patches 26 and 27.  Thanks for testing though!
> >
> > I'm also not sure about patch 16, since that's not my area, but Daniel
> > and Ed both reviewed it so that's okay.
> >
> > Finally, instead of checking !_WIN32 it's better to check CONFIG_POSIX
> > or CONFIG_WIN32.  That can be changed on commit though.
> >
> > Everything else seems okay.  I'll wait a couple days and queue the whol=
e
> > bunch up to patch 25.
>
> Patch 13 definitely needs a replacement, and I think patch 2 should
> likely go through the block tree instead...
>
I am prepareing V9, and move nfs related things to the end  patch 13 are
re-implemented
please wait for some minutes

>
> But I recently started to experiment with these patches, too, and I
> think I got a reasonable subset now which should be OK for getting
> merged (e.g. disabling NFS and the crypto test in the CI for now). I'll
> take those through my testing tree. The remaining work can then be done
> on top later.
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

--0000000000008c6eeb05af58d7d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15, 2020 at 7:44 PM Thoma=
s Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_blank">thuth@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 13/09/2020 16.08, Paolo Bonzini wrote:<br>
&gt; On 13/09/20 00:44, Yonggang Luo wrote:<br>
&gt;&gt; This reverts commit 48328880fddf0145bdccc499160fb24dfabfbd41.<br>
&gt;&gt;<br>
&gt;&gt; The --ninja option doesn&#39;t need anymore because of upgrade mes=
on to 0.55.2<br>
&gt;&gt; At that version we can use ninjatool<br>
&gt; <br>
&gt; We might actually get rid of ninjatool before QEMU 5.2 goes out, if we=
<br>
&gt; decide to make Ninja a mandatory build dependency.=C2=A0 So we can hol=
d on<br>
&gt; patches 26 and 27.=C2=A0 Thanks for testing though!<br>
&gt; <br>
&gt; I&#39;m also not sure about patch 16, since that&#39;s not my area, bu=
t Daniel<br>
&gt; and Ed both reviewed it so that&#39;s okay.<br>
&gt; <br>
&gt; Finally, instead of checking !_WIN32 it&#39;s better to check CONFIG_P=
OSIX<br>
&gt; or CONFIG_WIN32.=C2=A0 That can be changed on commit though.<br>
&gt; <br>
&gt; Everything else seems okay.=C2=A0 I&#39;ll wait a couple days and queu=
e the whole<br>
&gt; bunch up to patch 25.<br>
<br>
Patch 13 definitely needs a replacement, and I think patch 2 should<br>
likely go through the block tree instead...<br></blockquote><div>I am prepa=
reing V9, and move nfs related things to the end=C2=A0 patch 13 are re-impl=
emented</div><div>please wait for some minutes</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
But I recently started to experiment with these patches, too, and I<br>
think I got a reasonable subset now which should be OK for getting<br>
merged (e.g. disabling NFS and the crypto test in the CI for now). I&#39;ll=
<br>
take those through my testing tree. The remaining work can then be done<br>
on top later.<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=
=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang L=
uo<br></div></div>

--0000000000008c6eeb05af58d7d7--

