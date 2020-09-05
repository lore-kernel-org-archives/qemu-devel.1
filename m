Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADF5C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 05:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF10B208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 05:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQTOrtM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF10B208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kER0T-0007su-K9
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 01:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEQzm-0007RW-5E
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 01:44:14 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:41223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEQzk-0007pH-JU
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 01:44:13 -0400
Received: by mail-lf1-x142.google.com with SMTP id y17so4925050lfa.8
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 22:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=gZTwtsFl7NfP8mNvaA17xwjjufcDzC7B7wLVBqEj/fw=;
 b=BQTOrtM3V11kMV/sSxxhFUaxukv0bGldVHqQzBrlKPEuS2rJHWpjdbi5YIL9SCHJ2J
 +Hi8axs1hyV0+x+BqE8oioyCBPptK8AsA0NzRUZJ6YOorFJmTzNY87l9+Iq+49SUYDf2
 /MA06DfkLea5SPUj0rB9Z1TfOJBSU6eLqhcPZkNK8yjO9RwAM/z6mo+eH5vmOqYPcQ2x
 LovoI7X4fAdetUMMGIYH2INGH2Bizbr1KmVjJ50lAwwRhJ6r1qZm1K57qZunhlz0mSCy
 O5QkTbbP/qbszTUvUqs03ITHxqnyColRE3bBjGBTRNOTMDQqgJLJa/cnuU2XFnIyHW0q
 OrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=gZTwtsFl7NfP8mNvaA17xwjjufcDzC7B7wLVBqEj/fw=;
 b=aopUZ9qLglR5bc6tE3TNY1bNU5FbdRf1nkgi93U5RE5Xkkgr0arfyJ5RPN4kn21Zdy
 cLETcpqH3BhiJCNA8VOiv8MYtAKhFtp0OR1Pv9PQ8CMdc5c6CQdWKAa/yfuauaGvp8Bp
 wLipjDUtxIPoX4NJxAO9OMjepGu1nqIYGAvYqA9Pc7FRAZ26DvLFbsj0+yVo+1YrnBSm
 KhOG5FpAVQKTCmq6YLUHhGqtyjIJfmGDQhCSCLqoBhrxDvAi4EHIE66vtJFPDBQ7Zfx2
 F3dbHmig1zPYGoSbfWY57gCd6pqsK/EoT1OvlF/YKjiyzzQX7Nca9GtH1KikRD5gPvtQ
 rZew==
X-Gm-Message-State: AOAM5304VX2ZGm99Y/my/1FLMGISJ/H1Q/4qICkaKOCkfOW2c8MyFggR
 BlY4oRkmXu6EqlOeuRfQXPDdhnbg1+WnUrPWiMstzTGeWRA=
X-Google-Smtp-Source: ABdhPJwZPFdJwOo01FcuPgMr6hviUt6RPi43r+Xl20hSJt+l+tn1fw1SFyx2xXE6Msiz+uLjPzD1obC7pEuma96Mfx4=
X-Received: by 2002:a19:b83:: with SMTP id 125mr1269847lfl.126.1599284650534; 
 Fri, 04 Sep 2020 22:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200903220622.504-1-luoyonggang@gmail.com>
 <CABgObfb8xOr6JstG0MLTwqeNZJXDC7LiecrFQje9VbwZD96Mvg@mail.gmail.com>
 <CAE2XoE9n3KU-bQ4SKhKCjjQVER=b4-4em3HfxCj6qYU+XkBdWw@mail.gmail.com>
 <ddcf4e38-717e-87c1-46c3-89df8bc035c2@redhat.com>
In-Reply-To: <ddcf4e38-717e-87c1-46c3-89df8bc035c2@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 5 Sep 2020 13:43:58 +0800
Message-ID: <CAE2XoE_JJsrYW50_carvoUzj2fedwj1eCDrgpd3JY4bepF-auQ@mail.gmail.com>
Subject: Re: [PATCH] configure: the error info not consistence with option.
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007d699e05ae8a79ac"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
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

--0000000000007d699e05ae8a79ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2020 at 3:54 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 04/09/20 05:54, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >          test "$vhost_net_user" =3D "" && vhost_net_user=3D$vhost_user
> >          if test "$vhost_net_user" =3D "yes" && test "$vhost_user" =3D =
"no";
> >         then
> >         -  error_exit "--enable-vhost-net-user requires
> --enable-vhost-user"
> >         +  error_exit "--enable-vhost-net requires --enable-vhost-user"
> >          fi
> >
> >
> >     This change seems wrong.
> >
> > I didn't found --enable-vhost-net-user option handling?
> > you may grep it?
> >
> >
>
> You're right, it is all dead code.  The four lines are equivalent to
> just vhost_net_user=3D$vhost_user.  You could also add
> --enable-vhost-net-user though!
>
I remove those four lines and use vhost_net_user=3D$vhost_user instead for
simplicity,
if we have no strong need of this option, i guess remove it are better

>
> Thanks,
>
> Paolo
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000007d699e05ae8a79ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 4, 2020 at 3:54 PM Paolo =
Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 04=
/09/20 05:54, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0test &quot;$vhost_net_user&quot=
; =3D &quot;&quot; &amp;&amp; vhost_net_user=3D$vhost_user<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0if test &quot;$vhost_net_user&q=
uot; =3D &quot;yes&quot; &amp;&amp; test &quot;$vhost_user&quot; =3D &quot;=
no&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-=C2=A0 error_exit &quot;--enable-vho=
st-net-user requires --enable-vhost-user&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 error_exit &quot;--enable-vho=
st-net requires --enable-vhost-user&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0fi<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This change seems wrong.<br>
&gt; <br>
&gt; I didn&#39;t found=C2=A0--enable-vhost-net-user option handling?<br>
&gt; you may grep it?=C2=A0<br>
&gt; <br>
&gt; <br>
<br>
You&#39;re right, it is all dead code.=C2=A0 The four lines are equivalent =
to<br>
just vhost_net_user=3D$vhost_user.=C2=A0 You could also add<br>
--enable-vhost-net-user though!<br></blockquote><div>I remove those four li=
nes and use vhost_net_user=3D$vhost_user instead for simplicity,</div><div>=
if we have no strong need of this option, i guess remove it are better</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
<br>
Paolo<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000007d699e05ae8a79ac--

