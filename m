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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA8CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2F72067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndPs4U2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2F72067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFQa-0006iU-K5
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAFPm-00064E-B7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:33:47 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:33387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAFPj-0006j6-Gk
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:33:46 -0400
Received: by mail-ej1-x644.google.com with SMTP id u21so12059918ejz.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=knk1Q9I+oyOqjSZZgl9vtaOgdrMwR7t0RXaRoPOKa/8=;
 b=ndPs4U2UUmPYfPSd88iErVhWIuOopbGLilbhFx+00IMAiENXOelCDkKnLtIbM8fqoZ
 ECVY7nZpUKu+fbVJLPXbRzd8yWXcvMDP0Lt15/7kC3Hd5WMdFwB0Uwd0G6sic0fjpdyo
 NfPUuWgIQ5TEXaie4iVbz9ltq5FkDnxDqIcf5J5NjEkwgSGnf27FmegJBOx0B7Po0xfd
 kmAOB7q1+wZgAg8KqgSuWiixWGPjxx9SPQDtnUQnHi/3i+UHbjQDrm+idRt6afVnNZLG
 J+f+6RKEvbqmgUEzxkheJuMMMVWNvE+dNYlxKOwRe8Lnmbu2iY+FWaHuxRLqJWBTTgkq
 vDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=knk1Q9I+oyOqjSZZgl9vtaOgdrMwR7t0RXaRoPOKa/8=;
 b=E7kB3yeQDm479LmnoLM2YXZge2vTxw04H75Ok55pthsbaFrLe+RLHKcnTRR5w5xR+w
 WofM3JOjwctg6u0PlKCQ7RvuPOxvx6JEZcMA6JIfqznXOL/3j2BRvzvJS0eCIG35XKUZ
 bpuS/lSllmKYLKy8Iel/CUVhcvlC6hInqhw1yGoqPeEF3FA2AujHW2E2Ni2nUhJjmKrM
 5VCszD8gwW5nPhbp6NWbuo1WeIAi8Eahc0+MWAHE42UQlHgWhDYXSBCiK2OKyppjnt6w
 qdh2ohClikoc3s9mWS6GStFWu2IgpFuRe5VdEdZyZJaqYspHZwKv8+O7Q3hOwRDwxB71
 jprg==
X-Gm-Message-State: AOAM530f4FjCLHDFRLKXthVCMgu4nwL31UzvGRlnyJYw4eLiu2IH+vjT
 +8TwOyidY2ina+apu4Zgqg0Id//oIw9jCzznARY=
X-Google-Smtp-Source: ABdhPJw2nMvReFuYHJs1tBRlKn9GusmRrBHAGSCeknT8hV5/CXbt1C/W+IH2w3JioRjdkdUbhw+ulxalZigshROiPqA=
X-Received: by 2002:a17:906:fcad:: with SMTP id
 qw13mr6569837ejb.389.1598286820433; 
 Mon, 24 Aug 2020 09:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200824155236.789635-1-brogers@suse.com>
In-Reply-To: <20200824155236.789635-1-brogers@suse.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Aug 2020 20:33:28 +0400
Message-ID: <CAJ+F1CKVhHK2eUgwQvbXc7Bgx3jXLOqZJysjz4YF+jPEg5Arog@mail.gmail.com>
Subject: Re: [PATCH] meson: Fix chardev-baum.so name
To: Bruce Rogers <brogers@suse.com>
Content-Type: multipart/alternative; boundary="0000000000002e634f05ada226fc"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002e634f05ada226fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Aug 24, 2020 at 7:53 PM Bruce Rogers <brogers@suse.com> wrote:

> Somehow in the conversion to meson, the module named chardev-baum got
> renamed to chardev-brlapi. Change it back.
>
> Signed-off-by: Bruce Rogers <brogers@suse.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  chardev/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/meson.build b/chardev/meson.build
> index a46a6237be..7726837e34 100644
> --- a/chardev/meson.build
> +++ b/chardev/meson.build
> @@ -39,7 +39,7 @@ chardev_modules =3D {}
>  if config_host.has_key('CONFIG_BRLAPI') and sdl.found()
>    module_ss =3D ss.source_set()
>    module_ss.add(when: [sdl, brlapi], if_true: files('baum.c'))
> -  chardev_modules +=3D { 'brlapi': module_ss }
> +  chardev_modules +=3D { 'baum': module_ss }
>  endif
>
>  modules +=3D { 'chardev': chardev_modules }
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000002e634f05ada226fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 24, 2020 at 7:53 PM Bru=
ce Rogers &lt;<a href=3D"mailto:brogers@suse.com">brogers@suse.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Somehow i=
n the conversion to meson, the module named chardev-baum got<br>
renamed to chardev-brlapi. Change it back.<br>
<br>
Signed-off-by: Bruce Rogers &lt;<a href=3D"mailto:brogers@suse.com" target=
=3D"_blank">brogers@suse.com</a>&gt;<br></blockquote><div><br></div><div>Re=
viewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0chardev/meson.build | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/chardev/meson.build b/chardev/meson.build<br>
index a46a6237be..7726837e34 100644<br>
--- a/chardev/meson.build<br>
+++ b/chardev/meson.build<br>
@@ -39,7 +39,7 @@ chardev_modules =3D {}<br>
=C2=A0if config_host.has_key(&#39;CONFIG_BRLAPI&#39;) and sdl.found()<br>
=C2=A0 =C2=A0module_ss =3D ss.source_set()<br>
=C2=A0 =C2=A0module_ss.add(when: [sdl, brlapi], if_true: files(&#39;baum.c&=
#39;))<br>
-=C2=A0 chardev_modules +=3D { &#39;brlapi&#39;: module_ss }<br>
+=C2=A0 chardev_modules +=3D { &#39;baum&#39;: module_ss }<br>
=C2=A0endif<br>
<br>
=C2=A0modules +=3D { &#39;chardev&#39;: chardev_modules }<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000002e634f05ada226fc--

