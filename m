Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7C8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77E1207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfpGu0TT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77E1207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdvC7-0002l0-1s
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 08:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jdvBX-0001qY-Cj
 for qemu-devel@nongnu.org; Wed, 27 May 2020 08:29:27 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jdvBW-0005xL-6V
 for qemu-devel@nongnu.org; Wed, 27 May 2020 08:29:27 -0400
Received: by mail-wr1-x433.google.com with SMTP id x14so18440442wrp.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uMdYIhm8d3htS71VXN/iNKpxS87VtND7FCbhR9bHxMg=;
 b=HfpGu0TTttiU24Ggmx+LqU3YUVVX8fKG+Q5AmoZXrcZTbrsLAehT9BZLnyO9cv6oKu
 2BhNzm4jV6Kg7BvlzECDMOqBOohV47DxYYCWI6/8zvmAAiOvwiFF61S7MvfnAB7MV1As
 OSJGmBgzKZqbO5483DYRPOS5Ra5SwfiZLAZCYgo9DkftVotLjY9wwsYtClZqPCAG3vrg
 zYGVYz1IM2vc1MoDOLB9SacqE8nPsW6BRlEFSeKu97JerlaXYv/Qyw88MA5ufie0UmG9
 w5UsJVxF9Uiu59ETQkE5hgB/ZmB58yFuhNkqunzpDi3mwgKouAQ6U+6jDEFUtqox62lf
 KxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uMdYIhm8d3htS71VXN/iNKpxS87VtND7FCbhR9bHxMg=;
 b=H0reikI5Y6+1SgkdTuCczVqAccmOpXFeYhHXGX/Y10+CDRA8Puy/xFSkZo6g0Df+WV
 pAwkeIt+mC8QKocs61T2Xz1qQe1g/eb/jmBypt5AbZPRk8XM3dA3JxeAxLuC4eTZ2geK
 9AePe6C7baTaETRSuFyuMwK4MAIvbb2A8YJXipNYoc4cSA63yH0WgcV3loY/2IubBRO9
 ctddL4vCwQb/PFWWoeSV5EtQD2N3LXwxLbv6lwMRbP61Lyz/4xNfKxw3jJ1Gqtt/7KrU
 OrUlsx/i7MslsuBuugPAbDaTzGiqgZ+X/AwvpOi+hBkMWx3TA+YESmcUdxVSNrlZAoI+
 jv7w==
X-Gm-Message-State: AOAM532sTGWk3SzTMwzeqGk+Cy2FSd7jkP6N/ZfEtMx61UaJwq2OC7Du
 mOU+NzVfs0ey8HLR931LRe4LbdF+5R5IiZPieOo=
X-Google-Smtp-Source: ABdhPJx43cktFkZFCUbVnxpGvkUIZNiYtreUt7PlE0//Xa+HGG/KOzpeLE2qIiTYJw9UATja+Yc6M3nD1T+i8czW+o4=
X-Received: by 2002:adf:fec8:: with SMTP id q8mr405790wrs.2.1590582564343;
 Wed, 27 May 2020 05:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <f176ccff-4988-8ba0-e3db-d859cde0db20@huawei.com>
In-Reply-To: <f176ccff-4988-8ba0-e3db-d859cde0db20@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 27 May 2020 14:29:11 +0200
Message-ID: <CAJ+F1CKS1EBuQTWqAhhiGLC0=9N_DxWXhcm6ZjHw2U2wham+SA@mail.gmail.com>
Subject: Re: [QUESTION]: vhost-user-gpu: Unable to find a satisfying
 vhost-user-gpu
To: Jun Piao <piaojun@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000bbd4f305a6a05c82"
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bbd4f305a6a05c82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, May 27, 2020 at 11:18 AM Jun Piao <piaojun@huawei.com> wrote:

> Hi Marc-Andr=C3=A9,
>
> I encounter a problem when trying to use vhost-user-gpu as below. And
> I'm not familiar to the libvirt code. Could you please help find out
> the reason?
>
> # virsh create snap1.xml
> error: Failed to create domain from snap1.xml
> error: operation failed: Unable to find a satisfying vhost-user-gpu
>
>
Libvirt implements the logic described in:
https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/interop/vhost-user.jso=
n;h=3Def8ac5941f5c8d14402566a984a0a0876d768c19;hb=3DHEAD#l171

Check if you have  /usr/share/qemu/vhost-user/50-qemu-gpu.json and if the
binary location is correct.

If it fails after that, enable libvirt debugging for more details.

hope that helps

qemu-4.1.1:
>   # ./vhost-user-gpu -v -s /home/vgpu.sock -r /dev/dri/renderD128
>
> libvirt-5.8.0:
>     <graphics type=3D'spice' port=3D'5901' tlsPort=3D'5903' autoport=3D'y=
es'>
>       <listen type=3D'socket' socket=3D'/tmp/spice.socket1'/>
>       <gl enable=3D'yes' rendernode=3D'/dev/dri/renderD128'/>
>     </graphics>
>     <video model=3D'virtio'>
>       <driver name=3D'vhostuser'/>
>       <acceleration accel3d=3D'yes' rendernode=3D'/dev/dri/renderD128'/>
>     </video>
>
> thanks,
> Jun
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000bbd4f305a6a05c82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 27, 2020 at 11:18 AM Ju=
n Piao &lt;<a href=3D"mailto:piaojun@huawei.com">piaojun@huawei.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Marc-=
Andr=C3=A9,<br>
<br>
I encounter a problem when trying to use vhost-user-gpu as below. And<br>
I&#39;m not familiar to the libvirt code. Could you please help find out<br=
>
the reason?<br>
<br>
# virsh create snap1.xml<br>
error: Failed to create domain from snap1.xml<br>
error: operation failed: Unable to find a satisfying vhost-user-gpu<br>
<br></blockquote><div><br></div><div>Libvirt implements the logic described=
 in: <a href=3D"https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/intero=
p/vhost-user.json;h=3Def8ac5941f5c8d14402566a984a0a0876d768c19;hb=3DHEAD#l1=
71">https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/interop/vhost-user=
.json;h=3Def8ac5941f5c8d14402566a984a0a0876d768c19;hb=3DHEAD#l171</a></div>=
<div><br></div><div>Check if you have=C2=A0 /usr/share/qemu/vhost-user/50-q=
emu-gpu.json and if the binary location is correct.</div><div><br></div><di=
v>If it fails after that, enable libvirt debugging for more details.</div><=
div><br></div><div>hope that helps<br></div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
qemu-4.1.1:<br>
=C2=A0 # ./vhost-user-gpu -v -s /home/vgpu.sock -r /dev/dri/renderD128<br>
<br>
libvirt-5.8.0:<br>
=C2=A0 =C2=A0 &lt;graphics type=3D&#39;spice&#39; port=3D&#39;5901&#39; tls=
Port=3D&#39;5903&#39; autoport=3D&#39;yes&#39;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 &lt;listen type=3D&#39;socket&#39; socket=3D&#39;/tmp/=
spice.socket1&#39;/&gt;<br>
=C2=A0 =C2=A0 =C2=A0 &lt;gl enable=3D&#39;yes&#39; rendernode=3D&#39;/dev/d=
ri/renderD128&#39;/&gt;<br>
=C2=A0 =C2=A0 &lt;/graphics&gt;<br>
=C2=A0 =C2=A0 &lt;video model=3D&#39;virtio&#39;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 &lt;driver name=3D&#39;vhostuser&#39;/&gt;<br>
=C2=A0 =C2=A0 =C2=A0 &lt;acceleration accel3d=3D&#39;yes&#39; rendernode=3D=
&#39;/dev/dri/renderD128&#39;/&gt;<br>
=C2=A0 =C2=A0 &lt;/video&gt;<br>
<br>
thanks,<br>
Jun<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000bbd4f305a6a05c82--

