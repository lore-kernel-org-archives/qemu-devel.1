Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CC9C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA132074F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asLpx+Kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA132074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNI05-0005gn-1k
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kNHzN-0005Ey-4J
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:56:25 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kNHzL-00069G-Ak
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:56:24 -0400
Received: by mail-lf1-x141.google.com with SMTP id y2so6089727lfy.10
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=21czC2JLaatrnGVMGly1jMw64+f7oStNi1ELekt0HTI=;
 b=asLpx+Kpu4XRhpDFUdQG+HPT7q6sAsZU/2qtCqNqByO6pqTLRN4Pco6marYurSkI2A
 UhITgQHR7nVkl3tmYcsBJLBa2mg4tEMe9U0syRMaMC0RW2zi+1YOXquXSs4bvQYXdbJU
 6S17L+4bELWe6sHuv34CVQF1yTkLqGuEXq45ugdh7bF94w4hqyAa3Nh1+vIdU2zvNSx0
 52nKt+lCyWU+p8apDhuoTas+fvt2Pr0YGzxecnzODPpLrYDFG6AEACRsgsEcSScGFKMA
 QZSnyebpAt15kNnWav8ArR49LKIDFBlfO8Rz8Ifenk/KAm+kvZR3Xx36Gx62E5aHWz4r
 GNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=21czC2JLaatrnGVMGly1jMw64+f7oStNi1ELekt0HTI=;
 b=Xmg5tczw0HKUYLZB8oC31biptgs5ZNh+hLUUK6Jt1+TGxENE5CbwwzmEwLZdKbISIy
 tIBKFRWq1AD17QY/TvZfP48H40FM1GadM5tLrSskkEbNzzl+YDln1leIVswDI+ZKmrGW
 jQYaYwQjuY9wiqiFrZtLgKPlf1o15uUJeA4NEzFesyjzsAG8+EGnvv6MFaqQiDr76pOv
 +ePH5VBYQLqByCLW+xNkL52mPdK85P8yEzn52Zhfg8lLP5alXKPCqOBMj9vdLFFm5+h/
 u7zXgaHnzT4KJlyMpW1JQSVasj7SnfjfCJVYg3JPIaRDSWhdVCiUICX8F7VOvNzLBMen
 Fonw==
X-Gm-Message-State: AOAM530gOFYadpQF1Ij/LIB0Za76kZQR5TjcrIn6PY+h9g1j5qVQzBFq
 rdm6dA4Rf0j5lCHg+J2SiYi1YfbKQItvUciIb1w=
X-Google-Smtp-Source: ABdhPJwktPedAIOc8yfQoY2bqt4qNoVVD5gJOBpMp28imWxcEhVHuX+ajCvcM5IgzI2AaMfETIHxVzZz/x5kXcgk47Q=
X-Received: by 2002:a19:a407:: with SMTP id q7mr1372676lfc.377.1601394981454; 
 Tue, 29 Sep 2020 08:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200929143654.518157-1-marcandre.lureau@redhat.com>
 <CAE2XoE9x4ovaUaNJhh=-deYqYJKQC68wQaACQbnC28EZoeEqUg@mail.gmail.com>
 <CAJ+F1C+oGqrKYKPTnNrO-3XM7_raaHY4ofdbd1xxtY8CPYd-mQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+oGqrKYKPTnNrO-3XM7_raaHY4ofdbd1xxtY8CPYd-mQ@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2020 23:56:09 +0800
Message-ID: <CAE2XoE9BryPq0OfwnyFQRKX1_T6Qu46uwFBHxuWFgvnyht7hPw@mail.gmail.com>
Subject: Re: [PATCH v2] build-sys: fix git version from -version
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000003c66805b075d3b9"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x141.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000003c66805b075d3b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 11:33 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:
>
>
>
> On Tue, Sep 29, 2020 at 6:43 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 <luoyonggang@gmail.com>
wrote:
>>
>>
>>
>> On Tue, Sep 29, 2020 at 10:38 PM <marcandre.lureau@redhat.com> wrote:
>> >
>> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> > Typo introduced with the script.
>> >
>> > Fixes: 2c273f32d3 ("meson: generate qemu-version.h")
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  scripts/qemu-version.sh | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
>> > index 03128c56a2..3f6e7e6d41 100755
>> > --- a/scripts/qemu-version.sh
>> > +++ b/scripts/qemu-version.sh
>> > @@ -9,7 +9,7 @@ version=3D"$3"
>> >  if [ -z "$pkgversion" ]; then
>> >      cd "$dir"
>> >      if [ -e .git ]; then
>> > -        pkgversion=3D$(git describe --match 'v*' --dirty | echo "")
>> > +        pkgversion=3D$(git describe --match 'v*' --dirty) || :
>> >      fi
>> >  fi
>> >
>> > --
>> > 2.26.2
>> >
>> >
>> Maybe this script can convert to python? as we are converting to
meson+python,
>> for less care about different bash/zsh/xsh differences?
>
>
> You are welcome to do it :)
> thanks
No problem. I've done one before.
>
>>
>> --
>>          =E6=AD=A4=E8=87=B4
>> =E7=A4=BC
>> =E7=BD=97=E5=8B=87=E5=88=9A
>> Yours
>>     sincerely,
>> Yonggang Luo
>
>
>
> --
> Marc-Andr=C3=A9 Lureau



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000003c66805b075d3b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Sep 29, 2020 at 11:33 PM Marc-Andr=C3=A9 L=
ureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com">marcandre.lureau@gm=
ail.com</a>&gt; wrote:<br>&gt;<br>&gt;<br>&gt;<br>&gt; On Tue, Sep 29, 2020=
 at 6:43 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;<a href=3D"mailto=
:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; wrote:<br>&gt;&gt;<br=
>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; On Tue, Sep 29, 2020 at 10:38 PM &lt;<a h=
ref=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&=
gt; wrote:<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; From: Marc-Andr=C3=A9 Lureau &=
lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.c=
om</a>&gt;<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Typo introduced with the scrip=
t.<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Fixes: 2c273f32d3 (&quot;meson: genera=
te qemu-version.h&quot;)<br>&gt;&gt; &gt; Signed-off-by: Marc-Andr=C3=A9 Lu=
reau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@re=
dhat.com</a>&gt;<br>&gt;&gt; &gt; ---<br>&gt;&gt; &gt; =C2=A0scripts/qemu-v=
ersion.sh | 2 +-<br>&gt;&gt; &gt; =C2=A01 file changed, 1 insertion(+), 1 d=
eletion(-)<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; diff --git a/scripts/qemu-vers=
ion.sh b/scripts/qemu-version.sh<br>&gt;&gt; &gt; index 03128c56a2..3f6e7e6=
d41 100755<br>&gt;&gt; &gt; --- a/scripts/qemu-version.sh<br>&gt;&gt; &gt; =
+++ b/scripts/qemu-version.sh<br>&gt;&gt; &gt; @@ -9,7 +9,7 @@ version=3D&q=
uot;$3&quot;<br>&gt;&gt; &gt; =C2=A0if [ -z &quot;$pkgversion&quot; ]; then=
<br>&gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0cd &quot;$dir&quot;<br>&gt;&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0if [ -e .git ]; then<br>&gt;&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0pkgversion=3D$(git describe --match &#39;v*&#39; --dirty | ech=
o &quot;&quot;)<br>&gt;&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgversion=3D=
$(git describe --match &#39;v*&#39; --dirty) || :<br>&gt;&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0fi<br>&gt;&gt; &gt; =C2=A0fi<br>&gt;&gt; &gt;<br>&gt;&gt; &gt;=
 --<br>&gt;&gt; &gt; 2.26.2<br>&gt;&gt; &gt;<br>&gt;&gt; &gt;<br>&gt;&gt; M=
aybe this script can convert to python? as we are converting to meson+pytho=
n,<br>&gt;&gt; for less care about different bash/zsh/xsh differences?<br>&=
gt;<br>&gt;<br>&gt; You are welcome to do it :)<br>&gt; thanks<div>No probl=
em. I&#39;ve done one before.<br>&gt;<br>&gt;&gt;<br>&gt;&gt; --<br>&gt;&gt=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>&gt;&gt; =E7=A4=
=BC<br>&gt;&gt; =E7=BD=97=E5=8B=87=E5=88=9A<br>&gt;&gt; Yours<br>&gt;&gt; =
=C2=A0 =C2=A0 sincerely,<br>&gt;&gt; Yonggang Luo<br>&gt;<br>&gt;<br>&gt;<b=
r>&gt; --<br>&gt; Marc-Andr=C3=A9 Lureau<br><br><br><br>--<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=
=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--00000000000003c66805b075d3b9--

