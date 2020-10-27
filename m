Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8B2C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF4B21655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XspB1kbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF4B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXO5s-0000WK-5z
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kXO3J-0007Bs-KF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 08:26:13 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kXO3G-0002Om-UT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 08:26:13 -0400
Received: by mail-ed1-x541.google.com with SMTP id o18so1225343edq.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 05:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=evJLjU+QywP+uIgYJlGBlEyN0S7jCg60N7XVAHexTPU=;
 b=XspB1kbw7NqKs8f6znDkwchBFiaye+IidK9ctmjO40uj979KwAMudffOM4fZkaf35D
 JuNDEY3aerqCnvpWSRLXahs2lt6vL32/EZaRdMbZMK6HsYX1F0/dAMTSFR/bIjonK9Re
 cVqNgXrk2iRs1XV0fu6t/+XItgX7PhVGnYUJBBsVJL66iVe4BYqDXFLlpT0G0l8pK6Ml
 nKxDFcjh8nENyVufI5pMfhhg1CIQcbSrglNPt8rfu9tVgKult3ynM21TF+SQLZSf5k70
 ZDdGZ46Mr2aCj2BtcEFwU7xvZFuLkWgqYfZsllgcevjw69j3FmT/H3dMT0I66XTDdm1o
 pLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=evJLjU+QywP+uIgYJlGBlEyN0S7jCg60N7XVAHexTPU=;
 b=iRGUH5Vg8zEbELNRrq1VkalTzUFHhn0eUMzUWM3eBl06QpIlK1MJyK9CZK9Ceonxu3
 HqJuTu+cZyxP+WAHjuwvTNovMJWp5AOGpxD6dNs75ZppbHVpqyzR1Krzal30ZUra04fb
 LbTFBwOoiEe4B1X7n5lQGRktjsyxmsZJgrITkNxtTsJElthZD16mHWIu9XTaYp2UZjaC
 F9K48+0QiyFlJ3djsOIx5IHD66WL21zZ8P7pcFt5xR/FSF8tJQi62Wc6dIqP5sa29+Jv
 zLUzoKXyIrBPHvaMh6rqgIxeWQY7BUUo8GsV/WG3hPAzgRZNbw3G3GC5udToNEkqf21y
 UgeA==
X-Gm-Message-State: AOAM533pa+gP5esFSsJCKEuzX0rd853OJXxniEpXX74X9e7235JECv8m
 c/5ARQ+bWBFCdBw5O343a5zLQgWz246aYz/TSmk=
X-Google-Smtp-Source: ABdhPJzkUGiCri3KOopxkXaCxNcilY4GFZzLt38qHY3E/IZkIMpV12OuXTnVUUxQ6zz5TbgkB0Cegr60B1MebG+D4Ug=
X-Received: by 2002:a05:6402:195:: with SMTP id
 r21mr1948083edv.164.1603801561318; 
 Tue, 27 Oct 2020 05:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201027121026.3025930-1-armbru@redhat.com>
In-Reply-To: <20201027121026.3025930-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 Oct 2020 16:25:49 +0400
Message-ID: <CAJ+F1CLfFWyWmAuN6g6qZ91Z-j6UJUHzfHK4JR19tfD2z9RZFA@mail.gmail.com>
Subject: Re: [PATCH] docs/devel/qapi-code-gen: Fix up examples
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005a4aec05b2a626b7"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x541.google.com
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005a4aec05b2a626b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 4:22 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  docs/devel/qapi-code-gen.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index c6438c6aa9..6906a06ad2 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -393,7 +393,7 @@ is identical on the wire to:
>   { 'enum': 'Enum', 'data': ['one', 'two'] }
>   { 'struct': 'Branch1', 'data': { 'data': 'str' } }
>   { 'struct': 'Branch2', 'data': { 'data': 'int' } }
> - { 'union': 'Flat': 'base': { 'type': 'Enum' }, 'discriminator': 'type',
> + { 'union': 'Flat', 'base': { 'type': 'Enum' }, 'discriminator': 'type',
>     'data': { 'one': 'Branch1', 'two': 'Branch2' } }
>
>  The optional 'if' member specifies a conditional.  See "Configuring
> @@ -590,6 +590,8 @@ When in doubt, do not implement OOB execution support=
.
>  Member 'allow-preconfig' declares whether the command is available
>  before the machine is built.  It defaults to false.  For example:
>
> + { 'enum': 'QMPCapability',
> +   'data': [ 'oob' ] }
>   { 'command': 'qmp_capabilities',
>     'data': { '*enable': [ 'QMPCapability' ] },
>     'allow-preconfig': true }
> @@ -824,7 +826,7 @@ Example: a struct with conditional feature
> 'allow-negative-numbers'
>  { 'struct': 'TestType',
>    'data': { 'number': 'int' },
>    'features': [ { 'name': 'allow-negative-numbers',
> -                  'if' 'defined(IFCOND)' } ] }
> +                  'if': 'defined(IFCOND)' } ] }
>
>  Please note that you are responsible to ensure that the C code will
>  compile with an arbitrary combination of conditions, since the
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000005a4aec05b2a626b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 27, 2020 at 4:22 PM Marku=
s Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Sign=
ed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" targe=
t=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0docs/devel/qapi-code-gen.txt | 6 ++++--<br>
=C2=A01 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt<br=
>
index c6438c6aa9..6906a06ad2 100644<br>
--- a/docs/devel/qapi-code-gen.txt<br>
+++ b/docs/devel/qapi-code-gen.txt<br>
@@ -393,7 +393,7 @@ is identical on the wire to:<br>
=C2=A0 { &#39;enum&#39;: &#39;Enum&#39;, &#39;data&#39;: [&#39;one&#39;, &#=
39;two&#39;] }<br>
=C2=A0 { &#39;struct&#39;: &#39;Branch1&#39;, &#39;data&#39;: { &#39;data&#=
39;: &#39;str&#39; } }<br>
=C2=A0 { &#39;struct&#39;: &#39;Branch2&#39;, &#39;data&#39;: { &#39;data&#=
39;: &#39;int&#39; } }<br>
- { &#39;union&#39;: &#39;Flat&#39;: &#39;base&#39;: { &#39;type&#39;: &#39=
;Enum&#39; }, &#39;discriminator&#39;: &#39;type&#39;,<br>
+ { &#39;union&#39;: &#39;Flat&#39;, &#39;base&#39;: { &#39;type&#39;: &#39=
;Enum&#39; }, &#39;discriminator&#39;: &#39;type&#39;,<br>
=C2=A0 =C2=A0 &#39;data&#39;: { &#39;one&#39;: &#39;Branch1&#39;, &#39;two&=
#39;: &#39;Branch2&#39; } }<br>
<br>
=C2=A0The optional &#39;if&#39; member specifies a conditional.=C2=A0 See &=
quot;Configuring<br>
@@ -590,6 +590,8 @@ When in doubt, do not implement OOB execution support.<=
br>
=C2=A0Member &#39;allow-preconfig&#39; declares whether the command is avai=
lable<br>
=C2=A0before the machine is built.=C2=A0 It defaults to false.=C2=A0 For ex=
ample:<br>
<br>
+ { &#39;enum&#39;: &#39;QMPCapability&#39;,<br>
+=C2=A0 =C2=A0&#39;data&#39;: [ &#39;oob&#39; ] }<br>
=C2=A0 { &#39;command&#39;: &#39;qmp_capabilities&#39;,<br>
=C2=A0 =C2=A0 &#39;data&#39;: { &#39;*enable&#39;: [ &#39;QMPCapability&#39=
; ] },<br>
=C2=A0 =C2=A0 &#39;allow-preconfig&#39;: true }<br>
@@ -824,7 +826,7 @@ Example: a struct with conditional feature &#39;allow-n=
egative-numbers&#39;<br>
=C2=A0{ &#39;struct&#39;: &#39;TestType&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: { &#39;number&#39;: &#39;int&#39; },<br>
=C2=A0 =C2=A0&#39;features&#39;: [ { &#39;name&#39;: &#39;allow-negative-nu=
mbers&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;if&#39=
; &#39;defined(IFCOND)&#39; } ] }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;if&#39=
;: &#39;defined(IFCOND)&#39; } ] }<br>
<br>
=C2=A0Please note that you are responsible to ensure that the C code will<b=
r>
=C2=A0compile with an arbitrary combination of conditions, since the<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000005a4aec05b2a626b7--

