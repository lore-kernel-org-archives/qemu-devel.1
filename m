Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA09C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6222074B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa/EJoBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6222074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGrS-0006dF-D7
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kNGqK-00069v-MC
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:43:00 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kNGqJ-0002Bk-5I
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:43:00 -0400
Received: by mail-lf1-x143.google.com with SMTP id d15so5786417lfq.11
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=mW4SBhPit+wlp8bCGOmHqsTWZEg7XTKs77eGhf9CREw=;
 b=Sa/EJoBr+Bfey4OqqsNJfj/sfBWlCNckB58LKNL4AJqsFdOUUAZHuxSLCNbMeAI4dQ
 CFqD2xR8eUdwCcioPWIFHiHKw1cSnH5ZS9I+DDklSHe2JmHwaXqwfi9ByX1dD7wiuOkG
 NZnDrtmsfbA6ZNp+nFG2nbYdB6ugAEiPlVhKPWVr3e8O9HI34eteKIWODUXcR1oC003d
 OOdf+jtOyRD6yMsEKfT/EQ2QOOXIUumMyBUIK+nWTg640wBUeIp5xnBWQIHHzIhz1NsK
 Hh6QQ69+uuEW0ljcm7EBktB1kkC2sZXgkZ5jrA0Mq4kHoawOytlOyxu1RX0K4/XIeEDG
 jV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=mW4SBhPit+wlp8bCGOmHqsTWZEg7XTKs77eGhf9CREw=;
 b=QbSzAxRTNUwypUd8L9QIxNDZVob+bDgOc1JjIddTylHxPyzqB9EbYtULIzQ1H0pyNe
 1j7oR1XlguNu6femsrXfL2sLkiRGfUY6dAoDP0cQBmZv2/GnQ2VFqCeryoEPR9TOOYLU
 dr9+nPq4+N5ExVIrNDEHOncju2puYutcniAOyMrg9L44Wom1PjcwqlXXK49touCjguKG
 Nwz3x+BoAGdFX1UiF1kv924ISszrq7AGw5cJTx8OP5B/+zt4GGRESIZeG0qxHsL96pB2
 hnaM1OFnQ//hdoeNiy/SKXcj7q8EpR1ROj2Je/KnmZGys1Bom7ffy8kErx0ACpjpxeFE
 N3eg==
X-Gm-Message-State: AOAM531lpJyAj1ilmp55iZapd6NhaaYNdI6RMeVuwENuq64dKlcN83Dl
 XidUpA4cOLBgl3Bv1SvxpcgO9GpniveH0ixaH8U=
X-Google-Smtp-Source: ABdhPJywg0l7U9yEoq/hvyA80AUYzIvOM5ykM1OI9c42SN99/S43f+ltCHMLcu7/+FHvratr63oiXF5jl8V5DammUUs=
X-Received: by 2002:a19:560a:: with SMTP id k10mr1251436lfb.599.1601390577156; 
 Tue, 29 Sep 2020 07:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200929143654.518157-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200929143654.518157-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2020 22:42:49 +0800
Message-ID: <CAE2XoE9x4ovaUaNJhh=-deYqYJKQC68wQaACQbnC28EZoeEqUg@mail.gmail.com>
Subject: Re: [PATCH v2] build-sys: fix git version from -version
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007f87e805b074cc5d"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x143.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, lersek@redhat.com,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007f87e805b074cc5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 10:38 PM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Typo introduced with the script.
>
> Fixes: 2c273f32d3 ("meson: generate qemu-version.h")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qemu-version.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> index 03128c56a2..3f6e7e6d41 100755
> --- a/scripts/qemu-version.sh
> +++ b/scripts/qemu-version.sh
> @@ -9,7 +9,7 @@ version=3D"$3"
>  if [ -z "$pkgversion" ]; then
>      cd "$dir"
>      if [ -e .git ]; then
> -        pkgversion=3D$(git describe --match 'v*' --dirty | echo "")
> +        pkgversion=3D$(git describe --match 'v*' --dirty) || :
>      fi
>  fi
>
> --
> 2.26.2
>
>
Maybe this script can convert to python? as we are converting to
meson+python,
for less care about different bash/zsh/xsh differences?

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000007f87e805b074cc5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Sep 29, 2020 at 10:38 PM &lt;<a href=3D"ma=
ilto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; wrote=
:<br>&gt;<br>&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;<br>&gt;<br>&gt; =
Typo introduced with the script.<br>&gt;<br>&gt; Fixes: 2c273f32d3 (&quot;m=
eson: generate qemu-version.h&quot;)<br>&gt; Signed-off-by: Marc-Andr=C3=A9=
 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau=
@redhat.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0scripts/qemu-version.sh | 2 +=
-<br>&gt; =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>&gt;<br>&g=
t; diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh<br>&gt; i=
ndex 03128c56a2..3f6e7e6d41 100755<br>&gt; --- a/scripts/qemu-version.sh<br=
>&gt; +++ b/scripts/qemu-version.sh<br>&gt; @@ -9,7 +9,7 @@ version=3D&quot=
;$3&quot;<br>&gt; =C2=A0if [ -z &quot;$pkgversion&quot; ]; then<br>&gt; =C2=
=A0 =C2=A0 =C2=A0cd &quot;$dir&quot;<br>&gt; =C2=A0 =C2=A0 =C2=A0if [ -e .g=
it ]; then<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgversion=3D$(git describe=
 --match &#39;v*&#39; --dirty | echo &quot;&quot;)<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0pkgversion=3D$(git describe --match &#39;v*&#39; --dirty) || :=
<br>&gt; =C2=A0 =C2=A0 =C2=A0fi<br>&gt; =C2=A0fi<br>&gt;<br>&gt; --<br>&gt;=
 2.26.2<br>&gt;<br>&gt;<br>Maybe this script can convert to python? as we a=
re converting to meson+python,<div>for less care about different bash/zsh/x=
sh differences?<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000007f87e805b074cc5d--

