Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA53FC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEC42067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4PDDzh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEC42067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAGPc-0000xr-Os
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAGOs-0000XX-OI
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:36:54 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:33153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAGOr-0008MV-7N
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:36:54 -0400
Received: by mail-ed1-x544.google.com with SMTP id w14so8332444eds.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mBPfHdhqiyRD0iUA01scl9jsu38iwDluw2AT4or1YIU=;
 b=R4PDDzh/mUm1ej3Q5Lk2LHh58uljkJKPsDahy2Mq/XjgTirNDkKjTdH/qgHWn7dIj5
 Ls0HFP9kSYSjtY0nD2XM41T7ZEp9HIIYRrgl26fIQTnI2ZpCNoMEsDG+bs/QFIVkvBGT
 Q+PnK/172ZXmLKT9360EZVCaUYV3ggNHYEDFaF3D49d+JVtrbkuHP1QAwNi6pYMhzq/q
 bmC3ONIrDvj87kx8kMV71MerUxCjFIy61QNJ6+UaWBRSSZcByEe7gwsltjtyJd0iP3ez
 CnIsER/yUKGwW07lVytsc3yVbwSkVBN6R9GbMPcdDIC53JXuJtRmmNzvJni4tKLBLJVF
 urZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mBPfHdhqiyRD0iUA01scl9jsu38iwDluw2AT4or1YIU=;
 b=k3y3U9hLpFaAqQYC63SewyZnDXt9nsfgCX1kbdl/O/Ar+rQ51ov/ZwQxFiip/syL2Y
 qnrlF0X153Zjexg9fE0SsvypKPsZJR9/6LWJNYKuC96uRzKSCnM9qChurOgE7Z9ha8b9
 sNIkHBYol7T7OI9k0ZAmIIF/ecUkeLeW8RM2+RPRAgRRyvANNLlmVvHIWLila1q0VFTv
 5v4CBp6nNzxbsRak0tVKs3h3A09wtQEhLQqUxnTkAbTSMxTPqcalNhJKHS7H+KXqRiKC
 zvcBNDooHxpHDHykQcQrthXvYqB7ydaC4IMpoj3OoHl2d//YTRgAr/2rsAoIaVc22vmU
 sF/g==
X-Gm-Message-State: AOAM532Ua8McTiCkWIrkNf/ZoEe8wLqYJ31QEbEwrwudqdxz9dZLRpEa
 cSc1FncTNaCeA1aV8BxH0XASo5nq3R0AnRDnnsI=
X-Google-Smtp-Source: ABdhPJyZxYXlKSenaB1LFObZfpYQAX588hLLSO/ifn2uHqMXg2u/leqI/YZYz2kidASc+bEb8FitE1HLtqSq8nDCcmw=
X-Received: by 2002:a50:e38d:: with SMTP id b13mr6558107edm.314.1598290611554; 
 Mon, 24 Aug 2020 10:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200824163109.96938-1-berrange@redhat.com>
In-Reply-To: <20200824163109.96938-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Aug 2020 21:36:39 +0400
Message-ID: <CAJ+F1CJJ4NcTPqQJ-D++ckVijZHf3Rxdo_YVmaaPAbtPgtoivA@mail.gmail.com>
Subject: Re: [PATCH] configure: default to PIE disabled on Windows platforms
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000264bf405ada30806"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x544.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000264bf405ada30806
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Aug 24, 2020 at 8:31 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> If Windows EXE files are built with -pie/-fpie they will fail to
> launch. Historically QEMU defaulted to disabling PIE for Windows,
> but this setting was accidentally lost when the configure summary
> text was removed in
>
>   commit f9332757898a764d85e19d339ec421236e885b68
>   Author: Paolo Bonzini <pbonzini@redhat.com>
>   Date:   Mon Feb 3 13:28:38 2020 +0100
>
>     meson: move summary to meson.build
>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Fixes: f9332757898a764d85e19d339ec421236e885b68
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

(one of those innocent looking commits)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  configure | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configure b/configure
> index 67832e3bab..b6f3b6e191 100755
> --- a/configure
> +++ b/configure
> @@ -857,6 +857,7 @@ MINGW32*)
>      audio_drv_list=3D""
>    fi
>    supported_os=3D"yes"
> +  pie=3D"no"
>  ;;
>  GNU/kFreeBSD)
>    bsd=3D"yes"
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000264bf405ada30806
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Aug 24, 2020 at 8:31 PM Daniel P. Ber=
rang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">If=
 Windows EXE files are built with -pie/-fpie they will fail to<br>
launch. Historically QEMU defaulted to disabling PIE for Windows,<br>
but this setting was accidentally lost when the configure summary<br>
text was removed in<br>
<br>
=C2=A0 commit f9332757898a764d85e19d339ec421236e885b68<br>
=C2=A0 Author: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
=C2=A0 Date:=C2=A0 =C2=A0Mon Feb 3 13:28:38 2020 +0100<br>
<br>
=C2=A0 =C2=A0 meson: move summary to meson.build<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@r=
edhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
<br>
Fixes: f9332757898a764d85e19d339ec421236e885b68<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>(one of those innocent looking commits)</div><div><br></div><=
div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lur=
eau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0configure | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/configure b/configure<br>
index 67832e3bab..b6f3b6e191 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -857,6 +857,7 @@ MINGW32*)<br>
=C2=A0 =C2=A0 =C2=A0audio_drv_list=3D&quot;&quot;<br>
=C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0supported_os=3D&quot;yes&quot;<br>
+=C2=A0 pie=3D&quot;no&quot;<br>
=C2=A0;;<br>
=C2=A0GNU/kFreeBSD)<br>
=C2=A0 =C2=A0bsd=3D&quot;yes&quot;<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000264bf405ada30806--

