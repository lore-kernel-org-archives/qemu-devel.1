Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FD2C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622EC2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+iHqBCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622EC2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTB03-0002MJ-OS
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTAyp-0001i7-Tz
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:40:13 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:41398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTAym-0003Rn-UE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:40:11 -0400
Received: by mail-lj1-x242.google.com with SMTP id p15so327995ljj.8
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=5dpxu6V8QG1tXXq+mBUa87SxiirjEDAowgx3qURpbi0=;
 b=l+iHqBCw4n6PkAE+e/8IcRvKSwWeK7b+v9OU2y84vnvblyi+ux37tGPYzLZNTXFXIH
 5kXoO/8A//HRQ80zmhYlAmLe5f2xi1LGwiOvaiV5ttUCwEkI/vUv/qLBBqnyHQ8Vr8Rm
 RubQuInerprRMIcbDHT/fiTzF+OCxXLYP8TGly+1oEQrHgHmSjYzOlvWTN7170a129Ar
 +UXLIIaepve9I9jV3jaIpm1ABWtLUdVmhQV3yfTP5ZbbGKlkivk2YBeMMesSmGSojKL+
 rg2VN+PT/SmUBKGnoimecH2ivAwATjoN7bI8sz6iujGo2JMgJoML0J9Oqp7b94bqR/f1
 jTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=5dpxu6V8QG1tXXq+mBUa87SxiirjEDAowgx3qURpbi0=;
 b=hQsZm72QmqkO14T/5BHTsUTBx63Tvw+kpAwbgDtQxRQQILOdyw8MQ8DOgdpkJGdyb8
 qZJfNSSIvDss4VZSk+xHIWUezyqcmTKBzJDba9W8ldPhpFmfoW2nWvaY87oeAJycyEMo
 pglACIHfBH6zEHHEBqf5f4hfUsA39u1gjqMRRCkX8Sv1NR6Pgq9UuMgPU8n3UXblC8i/
 07AUfxQkXfZLvwuJjERt3SJYGNs0pfcy6u8c0MabDLZUTskAnYzAz0fl/HmyIaV/T2YL
 olLYykHeW5f7neXY3/UQ7Ce3E3n78OResGU1DHiIJw9S7bzqHKd+vZFSuPV/c9yN2Zij
 FLCQ==
X-Gm-Message-State: AOAM5305JdWeEHFvImfhufiPzdYzrKyrcqTZFAfdwozZRwXhAcLimwSJ
 Ad9egMwGmMLMMfnYEXXr0kn2ru8IHZ3yL/TS+Yk=
X-Google-Smtp-Source: ABdhPJxc8ldd9KmuxwXsVRji4jTjIZuEfH1RKZ3yC+2MG/Yr8JKnhndNaOLYNjEiDILY7BbIo5EyRJK1t26PktkgmIc=
X-Received: by 2002:a2e:9a17:: with SMTP id o23mr288092lji.242.1602798006829; 
 Thu, 15 Oct 2020 14:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201015201035.1964-1-luoyonggang@gmail.com>
 <20201015201035.1964-3-luoyonggang@gmail.com>
 <CABgObfYXes_WRnqkBs2-1cTQVRu5PMO1Wv9vguWxY_41aFzTfQ@mail.gmail.com>
In-Reply-To: <CABgObfYXes_WRnqkBs2-1cTQVRu5PMO1Wv9vguWxY_41aFzTfQ@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 16 Oct 2020 05:39:55 +0800
Message-ID: <CAE2XoE_X_Ep43MvFGtBPR934oKofnWZhYvTA2ajbWhvbFnPxKA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] configure: the docdir option should passed to
 meson as is.
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d807de05b1bc7d24"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x242.google.com
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

--000000000000d807de05b1bc7d24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Grep  qemu_docdir and docdir  in configure, you will know why,  qemu_docdir
not used at all in configure,

On Fri, Oct 16, 2020 at 5:24 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Why?
>
> Paolo
>
> Il gio 15 ott 2020, 22:11 Yonggang Luo <luoyonggang@gmail.com> ha scritto=
:
>>
>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> ---
>>  configure | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/configure b/configure
>> index f839c2a557..1ce31f97b4 100755
>> --- a/configure
>> +++ b/configure
>> @@ -971,7 +971,7 @@ for opt do
>>    ;;
>>    --with-suffix=3D*) qemu_suffix=3D"$optarg"
>>    ;;
>> -  --docdir=3D*) qemu_docdir=3D"$optarg"
>> +  --docdir=3D*) docdir=3D"$optarg"
>>    ;;
>>    --sysconfdir=3D*) sysconfdir=3D"$optarg"
>>    ;;
>> @@ -5770,7 +5770,6 @@ fi
>>  qemu_confdir=3D"$sysconfdir/$qemu_suffix"
>>  qemu_moddir=3D"$libdir/$qemu_suffix"
>>  qemu_datadir=3D"$datadir/$qemu_suffix"
>> -qemu_docdir=3D"$docdir/$qemu_suffix"
>>  qemu_localedir=3D"$datadir/locale"
>>  qemu_icondir=3D"$datadir/icons"
>>  qemu_desktopdir=3D"$datadir/applications"
>> --
>> 2.28.0.windows.1
>>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d807de05b1bc7d24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Grep=C2=A0

qemu_docdir and docdir=C2=A0 in configure, you will know why,=C2=A0

qemu_docdir not used at all in configure,<div><br>On Fri, Oct 16, 2020 at 5=
:24 AM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@re=
dhat.com</a>&gt; wrote:<br>&gt;<br>&gt; Why?<br>&gt;<br>&gt; Paolo<br>&gt;<=
br>&gt; Il gio 15 ott 2020, 22:11 Yonggang Luo &lt;<a href=3D"mailto:luoyon=
ggang@gmail.com">luoyonggang@gmail.com</a>&gt; ha scritto:<br>&gt;&gt;<br>&=
gt;&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail=
.com">luoyonggang@gmail.com</a>&gt;<br>&gt;&gt; ---<br>&gt;&gt; =C2=A0confi=
gure | 3 +--<br>&gt;&gt; =C2=A01 file changed, 1 insertion(+), 2 deletions(=
-)<br>&gt;&gt;<br>&gt;&gt; diff --git a/configure b/configure<br>&gt;&gt; i=
ndex f839c2a557..1ce31f97b4 100755<br>&gt;&gt; --- a/configure<br>&gt;&gt; =
+++ b/configure<br>&gt;&gt; @@ -971,7 +971,7 @@ for opt do<br>&gt;&gt; =C2=
=A0 =C2=A0;;<br>&gt;&gt; =C2=A0 =C2=A0--with-suffix=3D*) qemu_suffix=3D&quo=
t;$optarg&quot;<br>&gt;&gt; =C2=A0 =C2=A0;;<br>&gt;&gt; - =C2=A0--docdir=3D=
*) qemu_docdir=3D&quot;$optarg&quot;<br>&gt;&gt; + =C2=A0--docdir=3D*) docd=
ir=3D&quot;$optarg&quot;<br>&gt;&gt; =C2=A0 =C2=A0;;<br>&gt;&gt; =C2=A0 =C2=
=A0--sysconfdir=3D*) sysconfdir=3D&quot;$optarg&quot;<br>&gt;&gt; =C2=A0 =
=C2=A0;;<br>&gt;&gt; @@ -5770,7 +5770,6 @@ fi<br>&gt;&gt; =C2=A0qemu_confdi=
r=3D&quot;$sysconfdir/$qemu_suffix&quot;<br>&gt;&gt; =C2=A0qemu_moddir=3D&q=
uot;$libdir/$qemu_suffix&quot;<br>&gt;&gt; =C2=A0qemu_datadir=3D&quot;$data=
dir/$qemu_suffix&quot;<br>&gt;&gt; -qemu_docdir=3D&quot;$docdir/$qemu_suffi=
x&quot;<br>&gt;&gt; =C2=A0qemu_localedir=3D&quot;$datadir/locale&quot;<br>&=
gt;&gt; =C2=A0qemu_icondir=3D&quot;$datadir/icons&quot;<br>&gt;&gt; =C2=A0q=
emu_desktopdir=3D&quot;$datadir/applications&quot;<br>&gt;&gt; --<br>&gt;&g=
t; 2.28.0.windows.1<br>&gt;&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000d807de05b1bc7d24--

