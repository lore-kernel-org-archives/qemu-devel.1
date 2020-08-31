Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA77C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A03820719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A03820719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrOi-0003kv-Eb
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrD6-0003Xi-Vm
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrD5-0001Wr-9z
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id p185so7555255qkb.11
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qKvgrwAbuO+EyqOMVk4tOCuKYE/8HRYizGKnvI8gtCM=;
 b=lk0u8pDcaF2T++HJseWKl9F/3q+f0jm7TuE4mlhXelNFK1FCWYIFgytKVr3LVKIGcF
 B70yb+xXl54iLTPdchsIXLP8ltl4i4MQxp61iAaXrNIvHYBpe8j1l+/bviwNqex0TU1O
 KAwZThpTQjKMngBdpqjDL5zzXfxGMIOOEzOQVQl4GJdEkniGr3TjrUDewuZBuhip2Enn
 IJYFgzvcEbVt+yxuPK0lQ/qUxX5ViZ/9i6LDbFNpKi7zxCZHK2s8qUMp/8TCF0N7lteu
 Y1wCXpgyXSFX9LEGbz3iRSJVO0V4M3CWdDqT33460QyluFnp6UK8dX6kcF8IbrKkZfaL
 Q4Fg==
X-Gm-Message-State: AOAM533JffdQtZBQyBl1hsL4HesQ8U1dT+8YBsufV6kCz/sQ2NuDsnOd
 YpEshnirOfDoKPDtN8ox+FTyC3ydQBprpok5/Ys=
X-Google-Smtp-Source: ABdhPJyt+0wQbWWjf/P1vhNjOxCzdMcjATXT2pFJP1nflQsBNs1CRUSfPe8Um05NTNx7uVhg8otOS/J3KaG6nrXqC90=
X-Received: by 2002:ae9:f101:: with SMTP id k1mr3391904qkg.122.1598908766220; 
 Mon, 31 Aug 2020 14:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200827113259.25064-1-peter.maydell@linaro.org>
 <AC5F071F-2965-4401-858C-2E4373C052E4@walle.cc>
In-Reply-To: <AC5F071F-2965-4401-858C-2E4373C052E4@walle.cc>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 22:08:57 +0200
Message-ID: <CAAdtpL4mVd9qB3y1i0TJpQWi+0hyONckNj47cDho_Q5tD81Nkw@mail.gmail.com>
Subject: Re: [PATCH] Deprecate lm32 port
To: Michael Walle <michael@walle.cc>
Content-Type: multipart/alternative; boundary="00000000000009f67505ae32f533"
Received-SPF: pass client-ip=209.85.222.195;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qk1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:16:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000009f67505ae32f533
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 27 ao=C3=BBt 2020 14:07, Michael Walle <michael@walle.cc> a =C3=A9c=
rit :

> Am 27. August 2020 13:32:59 MESZ schrieb Peter Maydell <
> peter.maydell@linaro.org>:
> >Deprecate our lm32 target support. Michael Walle (former lm32
> >maintainer)
> >suggested that we do this in 2019:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html
> >because the only public user of the architecture is the many-years-dead
> >milkymist project. (The Linux port to lm32 was never merged upstream.)
> >
> >In commit 4b4d96c776f552e (March 2020) we marked it as 'orphan' in
> >the MAINTAINERS file, but didn't officially deprecate it. Mark it
> >deprecated now, with the intention of removing it from QEMU in
> >mid-2021 before the 6.1 release.
> >
> >Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Acked-by: Michael Walle <michael@walle.cc>
>

Thanks Michael for your contributions. I could learn few things looking at
the code and the git history.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


> Thanks,
> -michael
>
>
>

--00000000000009f67505ae32f533
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le jeu. 27 ao=C3=BBt 2020 14:07, Michael Walle &lt;michael=
@walle.cc&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">A=
m 27. August 2020 13:32:59 MESZ schrieb Peter Maydell &lt;<a href=3D"mailto=
:peter.maydell@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.mayde=
ll@linaro.org</a>&gt;:<br>
&gt;Deprecate our lm32 target support. Michael Walle (former lm32<br>
&gt;maintainer)<br>
&gt;suggested that we do this in 2019:<br>
&gt; <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg60502=
4.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://www.mail-ar=
chive.com/qemu-devel@nongnu.org/msg605024.html</a><br>
&gt;because the only public user of the architecture is the many-years-dead=
<br>
&gt;milkymist project. (The Linux port to lm32 was never merged upstream.)<=
br>
&gt;<br>
&gt;In commit 4b4d96c776f552e (March 2020) we marked it as &#39;orphan&#39;=
 in<br>
&gt;the MAINTAINERS file, but didn&#39;t officially deprecate it. Mark it<b=
r>
&gt;deprecated now, with the intention of removing it from QEMU in<br>
&gt;mid-2021 before the 6.1 release.<br>
&gt;<br>
&gt;Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro=
.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;=
<br>
<br>
Acked-by: Michael Walle &lt;michael@walle.cc&gt;<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks Michael for your con=
tributions. I could learn few things looking at the code and the git histor=
y.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><span style=3D"font-f=
amily:sans-serif;font-size:13.696px">Reviewed-by: Philippe Mathieu-Daud=C3=
=A9 &lt;</span><a href=3D"mailto:f4bug@amsat.org" style=3D"text-decoration:=
none;color:rgb(66,133,244);font-family:sans-serif;font-size:13.696px">f4bug=
@amsat.org</a><span style=3D"font-family:sans-serif;font-size:13.696px">&gt=
;</span><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks, <br>
-michael <br>
<br>
<br>
</blockquote></div></div></div>

--00000000000009f67505ae32f533--

