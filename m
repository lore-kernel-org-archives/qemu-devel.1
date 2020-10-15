Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6210CC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB442076A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqU6pl4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB442076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTBGs-0006jN-KK
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBEK-0004B8-OP
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:56:12 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236]:39708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBEI-0005hj-O3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:56:12 -0400
Received: by mail-lj1-x236.google.com with SMTP id m16so371627ljo.6
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=H7e+0WOBLW8aRTos9GU/JOF7GZIONYIwjpIA310J49M=;
 b=rqU6pl4m1zwWHLidUvvYgjX2DgEALmQWZVzg3gBeIQfHKmsUJMlHne8/UuPVDzvtVg
 v8doJ+nbsaw6DTjF9l5pSPsEtr92xBrTsS5O2Ugj0iAZR0j5QSO0/wfzzyaA3mhiEMBW
 2UO4t+YXe9NJo+VVuMQzRme99W5q1Jlz80/EcEt1E1gbjvzloC2o8hLkPloTbEFe9FXY
 7IXUodV91ycJDekWakJFMgZctRe7oQADU2HGxGUOphtn/xlDFft/pfzDZjovbW1Wq5j+
 N4zofen0FtfoRtntDxogIwv4iUTDyQbSjnTsmqDtRNh8JqTySBaJthbDxw3up++YHbvQ
 P1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=H7e+0WOBLW8aRTos9GU/JOF7GZIONYIwjpIA310J49M=;
 b=pOwHmSHmEE48wgtbqlxxCLNQRr5Il5vC8lnmDwWmYgekgD7W5V9yxDHanYenVr5gUe
 xUYQ9T4+WmFncRfwkFCygxZ+9FTzdOeeCRSuXHufd5pvCqN1aizYOIeczXVQL32wpfkn
 jw9Uig2DrL7N7P8aNf2q4aa6fiXPHBQI0aEHc84DgG/DKsMpHv+uyMSaDgyNzCpDhaWl
 T+saviQzcoxfLRhBDMHwRrt7ARojtPOwYb1Cm0jv55BPVe5904GXfPLX2ZDzaai389ry
 JYHRYp6dEtpxz9QWQOxwzsDsdK6TZichrviHSr2UlP2Op2w6LaioLpVsufEfVgsUGB/t
 aDUA==
X-Gm-Message-State: AOAM533ewJIJwReRzxtgEJoZduTh7alqbtMWjrfzu4QRrWdrKPK/kPpM
 tcJwg011qI++BPhL6eTUheFSefH3sbdfQM5GFAc=
X-Google-Smtp-Source: ABdhPJz6y+8m6SKJgROSKSKdA94p4l+W07SjlYJkaGe1M9mzNnjJvv67/qbKmI56RxaEytnLtDvTtxO2y3x7rnmnbSo=
X-Received: by 2002:a2e:3217:: with SMTP id y23mr262679ljy.300.1602798968754; 
 Thu, 15 Oct 2020 14:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201015201035.1964-1-luoyonggang@gmail.com>
 <CABgObfYY5SPAzouBG84eVdUY5rFwknNuoMovg8VFfvXuhZOA+w@mail.gmail.com>
In-Reply-To: <CABgObfYY5SPAzouBG84eVdUY5rFwknNuoMovg8VFfvXuhZOA+w@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 16 Oct 2020 05:55:56 +0800
Message-ID: <CAE2XoE-ZYCJHJ3M7XxM8it_M==Hm5h6MZonESBjz2YXrcZeTvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fixes docs building on msys2/mingw
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002dd60805b1bcb751"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x236.google.com
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

--0000000000002dd60805b1bcb751
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 5:53 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Looks good, apart from the CR removal patch that can simply be dropped.
Resend with fixes, the CR removal patch composite two part.

>
> Paolo
>
> Il gio 15 ott 2020, 22:10 Yonggang Luo <luoyonggang@gmail.com> ha scritto=
:
>>
>> v1 - v2
>> Also move the docs configure part from
>> configure to meson, this also fixed the pending
>> ninjatool removal caused issue that docs  can
>> not be build under msys2/mingw
>>
>> Yonggang Luo (4):
>>   docs: Fixes build docs on msys2/mingw
>>   configure: the docdir option should passed to meson as is.
>>   meson: Move the detection logic for sphinx to meson
>>   cirrus: Enable doc build on msys2/mingw
>>
>>  .cirrus.yml                   |  6 +++-
>>  configure                     | 62 +++--------------------------------
>>  docs/conf.py                  |  2 +-
>>  docs/meson.build              |  4 +--
>>  docs/sphinx/kerneldoc.py      |  2 +-
>>  meson.build                   | 59 +++++++++++++++++++++++++++++----
>>  meson_options.txt             |  5 ++-
>>  scripts/rst-sanitize.py       | 21 ++++++++++++
>>  tests/qapi-schema/meson.build |  7 ++--
>>  9 files changed, 95 insertions(+), 73 deletions(-)
>>  create mode 100644 scripts/rst-sanitize.py
>>
>> --
>> 2.28.0.windows.1
>>
>>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000002dd60805b1bcb751
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Oct 16, 2020 at 5:53 AM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; Looks good, apart from the CR removal patch that can simply =
be dropped.<div>Resend with fixes, the CR removal patch composite two part.=
</div><div><br>&gt;<br>&gt; Paolo<br>&gt;<br>&gt; Il gio 15 ott 2020, 22:10=
 Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmai=
l.com</a>&gt; ha scritto:<br>&gt;&gt;<br>&gt;&gt; v1 - v2<br>&gt;&gt; Also =
move the docs configure part from<br>&gt;&gt; configure to meson, this also=
 fixed the pending<br>&gt;&gt; ninjatool removal caused issue that docs =C2=
=A0can<br>&gt;&gt; not be build under msys2/mingw<br>&gt;&gt;<br>&gt;&gt; Y=
onggang Luo (4):<br>&gt;&gt; =C2=A0 docs: Fixes build docs on msys2/mingw<b=
r>&gt;&gt; =C2=A0 configure: the docdir option should passed to meson as is=
.<br>&gt;&gt; =C2=A0 meson: Move the detection logic for sphinx to meson<br=
>&gt;&gt; =C2=A0 cirrus: Enable doc build on msys2/mingw<br>&gt;&gt;<br>&gt=
;&gt; =C2=A0.cirrus.yml =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | =C2=A06 +++-<br>&gt;&gt; =C2=A0configure =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 62 +++--------------=
------------------<br>&gt;&gt; =C2=A0docs/conf.py =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A02 +-<br>&gt;&gt; =C2=A0docs/m=
eson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A04 +--<br=
>&gt;&gt; =C2=A0docs/sphinx/kerneldoc.py =C2=A0 =C2=A0 =C2=A0| =C2=A02 +-<b=
r>&gt;&gt; =C2=A0meson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 59 +++++++++++++++++++++++++++++----<br>&gt;&gt; =C2=A0=
meson_options.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A05 ++-<b=
r>&gt;&gt; =C2=A0scripts/rst-sanitize.py =C2=A0 =C2=A0 =C2=A0 | 21 ++++++++=
++++<br>&gt;&gt; =C2=A0tests/qapi-schema/meson.build | =C2=A07 ++--<br>&gt;=
&gt; =C2=A09 files changed, 95 insertions(+), 73 deletions(-)<br>&gt;&gt; =
=C2=A0create mode 100644 scripts/rst-sanitize.py<br>&gt;&gt;<br>&gt;&gt; --=
<br>&gt;&gt; 2.28.0.windows.1<br>&gt;&gt;<br>&gt;&gt;<br><br><br>--<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=
=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</di=
v></div>

--0000000000002dd60805b1bcb751--

