Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00740C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3D520FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLZ85XjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3D520FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVuUR-00037K-4k
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 06:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVuTF-0002KI-3Z; Fri, 23 Oct 2020 06:38:53 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:46823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVuTB-0002mS-RI; Fri, 23 Oct 2020 06:38:52 -0400
Received: by mail-ej1-x643.google.com with SMTP id t25so1663597ejd.13;
 Fri, 23 Oct 2020 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MjJQ03NOu0ti2iVISXw02YqsgUStwEloYRrrPIULmMM=;
 b=KLZ85XjGLKM1+TwDmhX3d88tgm+KFxjuh0NlCPEqSYXavz9n6x/xRS5EgVQYKtFyoo
 SsISJX8/LFHg4hWwE99fv1mMNG0Stfxdotpc7zQtbzALPyK3UiR7P1RbBj3RehTfzs4x
 w0qR2swFPLrPvphC1hfLUfeXFPNXdRV9Wq8ndpo/3FeguHxThLA6NlCeKSc/BLFWvgFk
 TJlTn0wPfKp8uxZMLSMHUi/C5gcQHrg1SKLrSMmNHKSWHz2LcHRoPVxRgWHAHBn7LwOg
 KyIYZD4W5y8xXuLcunOUu5ntB/nxRWK/K7pETKQ0OkB61IUve/PAv0cfLHZ//Db+cnzh
 sujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MjJQ03NOu0ti2iVISXw02YqsgUStwEloYRrrPIULmMM=;
 b=atqlQDPxeGzNzKSpPwAwrcdZVP9oXb9kD27BcrIvyNPQTksUv0fu7PoX96aZhT3QKR
 68FQnXw6RJ3zBnE9t1slsftOfZhDbu7NJFujdk1sFLjXCTYAA+YrJVtpPyipEVanuo3O
 e3k7rs7sXfM0ieVQodVuN3DopOwPxUdnux4Q+z4AmjtWxsAEplZ1AmSEIhGpKXdwDUQM
 b4lKOF/PwgEN0WfhgiDhp82YwiEfZHCrP1SVobLSb3UnjEWJsQImHrnRuIny2xdEKWjI
 kICbr1grXKGlu1vsm9j/LvYBj2Q/WXZnbdwaiVax8RhMog3BLGi93/p3eO4CXoDPwnAL
 1pZA==
X-Gm-Message-State: AOAM5339VF2C6386dk2p4rvT8rLr2Hp4veKpl9YCA+HnZjm9W+z/bdhN
 dG4uqepd2pza5HsfpGwJpFo7F2DY5vkEngzw70I=
X-Google-Smtp-Source: ABdhPJza1mDy+/IAQDhJrrdGlp1b7e/btZy9QCV0EVUfCipQQVQl5dAniKLhAnBAe/69yIyZW4FTuTbjrHqw+wP20fk=
X-Received: by 2002:a17:906:e949:: with SMTP id
 jw9mr1246133ejb.109.1603449527049; 
 Fri, 23 Oct 2020 03:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023101222.250147-2-kwolf@redhat.com>
In-Reply-To: <20201023101222.250147-2-kwolf@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Oct 2020 14:38:34 +0400
Message-ID: <CAJ+F1C+13s4RBvO9_K6bJdWOgac7MYXBN_y2f5BXPHD4+W-nxA@mail.gmail.com>
Subject: Re: [PATCH 1/6] char/stdio: Fix QMP default for 'signal'
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000079a29f05b2542fa1"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000079a29f05b2542fa1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 2:14 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Commit 02c4bdf1 tried to make signal=3Don the default for stdio chardevs
> except for '-serial mon:stdio', but it forgot about QMP and accidentally
> switched the QMP default from true (except for -nographic) to false
> (always). The documentation was kept unchanged and still describes the
> opposite of the old behaviour (which is an even older documentation
> bug).
>
> Fix all of this by making signal=3Dtrue the default in ChardevStdio and
> documenting it as such.
>
> Fixes: 02c4bdf1d2ca8c02a9bae16398f260b5c08d08bf
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  qapi/char.json       | 3 +--
>  chardev/char-stdio.c | 4 +---
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/qapi/char.json b/qapi/char.json
> index b4d66ec90b..43486d1daa 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -321,8 +321,7 @@
>  # Configuration info for stdio chardevs.
>  #
>  # @signal: Allow signals (such as SIGINT triggered by ^C)
> -#          be delivered to qemu.  Default: true in -nographic mode,
> -#          false otherwise.
> +#          be delivered to qemu.  Default: true.
>  #
>  # Since: 1.5
>  ##
> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index 82eaebc1db..403da308c9 100644
> --- a/chardev/char-stdio.c
> +++ b/chardev/char-stdio.c
> @@ -112,9 +112,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
>
>      qemu_chr_open_fd(chr, 0, 1);
>
> -    if (opts->has_signal) {
> -        stdio_allow_signal =3D opts->signal;
> -    }
> +    stdio_allow_signal =3D !opts->has_signal || opts->signal;
>      qemu_chr_set_echo_stdio(chr, false);
>  }
>  #endif
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000079a29f05b2542fa1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2020 at 2:14 PM Kevin=
 Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Commit 02c4bd=
f1 tried to make signal=3Don the default for stdio chardevs<br>
except for &#39;-serial mon:stdio&#39;, but it forgot about QMP and acciden=
tally<br>
switched the QMP default from true (except for -nographic) to false<br>
(always). The documentation was kept unchanged and still describes the<br>
opposite of the old behaviour (which is an even older documentation<br>
bug).<br>
<br>
Fix all of this by making signal=3Dtrue the default in ChardevStdio and<br>
documenting it as such.<br>
<br>
Fixes: 02c4bdf1d2ca8c02a9bae16398f260b5c08d08bf<br>
Signed-off-by: Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" target=3D=
"_blank">kwolf@redhat.com</a>&gt;<br></blockquote><div><br></div><div>Revie=
wed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redha=
t.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0qapi/char.json=C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 +--<br>
=C2=A0chardev/char-stdio.c | 4 +---<br>
=C2=A02 files changed, 2 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/qapi/char.json b/qapi/char.json<br>
index b4d66ec90b..43486d1daa 100644<br>
--- a/qapi/char.json<br>
+++ b/qapi/char.json<br>
@@ -321,8 +321,7 @@<br>
=C2=A0# Configuration info for stdio chardevs.<br>
=C2=A0#<br>
=C2=A0# @signal: Allow signals (such as SIGINT triggered by ^C)<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be delivered to qemu.=C2=A0 Default: t=
rue in -nographic mode,<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 false otherwise.<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be delivered to qemu.=C2=A0 Default: t=
rue.<br>
=C2=A0#<br>
=C2=A0# Since: 1.5<br>
=C2=A0##<br>
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c<br>
index 82eaebc1db..403da308c9 100644<br>
--- a/chardev/char-stdio.c<br>
+++ b/chardev/char-stdio.c<br>
@@ -112,9 +112,7 @@ static void qemu_chr_open_stdio(Chardev *chr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_open_fd(chr, 0, 1);<br>
<br>
-=C2=A0 =C2=A0 if (opts-&gt;has_signal) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stdio_allow_signal =3D opts-&gt;signal;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 stdio_allow_signal =3D !opts-&gt;has_signal || opts-&gt;sign=
al;<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_set_echo_stdio(chr, false);<br>
=C2=A0}<br>
=C2=A0#endif<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000079a29f05b2542fa1--

