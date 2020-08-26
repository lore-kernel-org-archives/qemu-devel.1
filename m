Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9952DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678F52078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVuaIOtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678F52078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxWY-0005hY-OB
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxVo-0005FB-J2
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:38:56 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:32966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxVm-0007dn-UL
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:38:56 -0400
Received: by mail-lj1-x241.google.com with SMTP id v4so2912941ljd.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=3XNe4x48czLtXup55rZZfnKVWqfwqExuhRUXCy2tkU4=;
 b=HVuaIOtgdPrh94Yno2n8EsPGQ6ceTiavsAolzYqY3w5yAUmrAWQIG70nb2aT5MAs0E
 BmfKqTn5kWsiILyPPS92J1xof2hIkfZyOaMKfijXINapkSET2yjI4NQXLIbyQfix6RSQ
 JTkMzjeU5z7k8MuVOQJRIK2XXea+N5djLIWFY854ZlsC7eedVgYLqtcgswHdAuO7ipVS
 iNexREGG1qomipjj2ZAt5JvfDFmR9nBQIHnO1oDccd/AKks7ioIv3PXbDefzO6HHM/OO
 uuZYYlY9wpOthIhAGA0ZgLpTrpJXjON0uqJlte6zK8jskxUy8WFawlM3O16t/FI8UdYA
 57yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=3XNe4x48czLtXup55rZZfnKVWqfwqExuhRUXCy2tkU4=;
 b=VnROTsHqOt7crjEcJt+2eRvtrNnhpN+KecJakX+HID9ocoKC57LeNtyjGT5PX/9rBU
 1bdpZ3Dfw6n2IbpbL5SMY88CgPHMKvQT2cgi6oCsVYbsfFDB4geZHSNz75g7RQYr5Gc3
 XkUgFfHGAmwgyikEzIPspkir8Qf0BnxV8aG7sVW8BwGjErAEWirbFfpzFC9sxluPNHHE
 BCwnzaCBFrGdJ0BZLlYZ2RdJzUMoxla/cDEnY/yMi42cfJzcEgdPd7SMphzoUGuPc739
 60gEY4OONA2Wz/wN450NW0h/mrREXeEgB5e72ya/WGLOr+aDWoexSpiI4o2hA6tft9CR
 BL6A==
X-Gm-Message-State: AOAM531jaSjOMMJ6ciqs2ahvNSTt8Hdy+Q47xVeploS5R8uf8dG4TGhC
 H+4E8Mgors4wq0uKiiUTxBmeVrYJHxLIIZSoTx8=
X-Google-Smtp-Source: ABdhPJy4biHgDgUgLcWO3HFXYA13OsaEHWXS5U4vz3PuYYo0ADtNZhwL1l9R4Krz4gvxe9Ia4wskUP0wegdoF9BWqQk=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr8036742ljg.447.1598456333221; 
 Wed, 26 Aug 2020 08:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <20200826151006.80-4-luoyonggang@gmail.com>
 <CABgObfbL9rdB1T0gzYvT4uR9D8ghLmo7OYaVdk+Vdk_vSjjvoA@mail.gmail.com>
 <CAE2XoE-mG9PFZF3hA4XpZ62oUicMQDid5AMqvUbx+yoOfLY=EQ@mail.gmail.com>
 <CABgObfagsQcHhAFTfDcqH5hWOzrwuHocygu10uWO7XR8BPmyEw@mail.gmail.com>
In-Reply-To: <CABgObfagsQcHhAFTfDcqH5hWOzrwuHocygu10uWO7XR8BPmyEw@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 26 Aug 2020 23:38:41 +0800
Message-ID: <CAE2XoE_+Fa_hAAyS103T_QjE+goV_n6SqMkWZ_5mhCLNOmUw8A@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] configure: Fix include and linkage issue on msys2
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ee426d05adc99de9"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ee426d05adc99de9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 11:36 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Wed, Aug 26, 2020 at 5:33 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 <luoyonggang@gmail.com>
> wrote:
> >
> >
> > On Wed, Aug 26, 2020 at 11:24 PM Paolo Bonzini <pbonzini@redhat.com>
> wrote:
> >> I'm a bit wary of this patch, the effects are quite wide-ranging. If
> >> we move all the detection of dependencies to meson, it will take a
> >> while but we should get a similar effect.
> >
> > Only on MINGW the $PWD sematic are changed, so I don't think there is
> side effect of this patch.
>
> Yes the side effect is only on MINGW but the affected variables are
> used everywhere so it's a rather hard to review change.
>
Gotcha, review it carefully

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

--000000000000ee426d05adc99de9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 11:36 PM Paol=
o Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Wed, Aug 26, 2020 at 5:33 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;=
<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gmai=
l.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Aug 26, 2020 at 11:24 PM Paolo Bonzini &lt;<a href=3D"mailto:p=
bonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; wrote:<br=
>
&gt;&gt; I&#39;m a bit wary of this patch, the effects are quite wide-rangi=
ng. If<br>
&gt;&gt; we move all the detection of dependencies to meson, it will take a=
<br>
&gt;&gt; while but we should get a similar effect.<br>
&gt;<br>
&gt; Only on MINGW the $PWD sematic are changed, so I don&#39;t think there=
 is side effect of this patch.<br>
<br>
Yes the side effect is only on MINGW but the affected variables are<br>
used everywhere so it&#39;s a rather hard to review change.<br></blockquote=
><div>Gotcha, review it carefully=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
Paolo<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000ee426d05adc99de9--

