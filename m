Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FFFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845F222D02
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVtdltBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845F222D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bb1-0002GX-9n
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1k3baS-0001q1-TT
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:49:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1k3baR-00021D-3U
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:49:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id 184so8888749wmb.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 01:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PKkq8xYRKOtLz5Mb8kMdvtrgQ88Mie7GXc8zOkR1xHw=;
 b=lVtdltBEVnaP0bzcj9Df4Kglfj58lQ9jA87pGbfgkor0uRbfowvk+az3Qm41PlKWTL
 kDQbTe1015o5Ro1u7fFMPvkBCgdYvOISRCOgpNAh7+xUvOcJu2Q6FoUjEH0uZ+pDC4jn
 P/qbuSz+r0YTJjPOyFWr2H6lwMa21U3T8p0nvrpuW4Fs7PWp65qesMjyizpfwljW0gC9
 Dj5vUffpWcMZnu96U/XYDcC+M7aRYjt9F4Y83BtsUsGlz19cIVLzHYAkz4CXe+vI/37L
 FO2tcIHz3qWjqc2u03agRYWsvNP2R2yJ9sU7Mw2m5r/dh+XmwyvkMVJa3ml9C90loSwY
 fvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PKkq8xYRKOtLz5Mb8kMdvtrgQ88Mie7GXc8zOkR1xHw=;
 b=TXEWaRjo5WR26kReapq2M9DCGaHT6fyUSCKBYR0GQA+BosSFph2PPF2l0OPsw7xcGC
 wFXAmA7uQPyhE+AEHapilt6Rgw8GvCV2YEikmszyXW6jchYQQzCnrtPf5eiZjfIJCZXS
 +zH4Ufg1gaEyt0FU3TM6SHMFSPmNiB+n07riNWUMJIokKw1gJfNEdH2yh0s4jQOuAfpb
 /cSkcSkRqqQR/HjJXWV1wFKj1CfOgqO1zIItkY7ZlZWckcTkEVfdusuP1TPULjY9glut
 0o1AHghUr1hNqsj98KTPoI82PYQ0At8ud8XoaUlTDtaguDvoJSXP6NDUrf8+yDoF7wza
 TEIg==
X-Gm-Message-State: AOAM532eifhuU6MKhBmFYu2H5sC4/YZ76tllRLF4SzlZRosWONsXPp/z
 1wN9XQM2Bo3WY8vH5lSVA15IKVxOjNWeSofLG+fa/jQoENg=
X-Google-Smtp-Source: ABdhPJx3lfNqycb/I1HxJ3OZDekkoQipJOov4QoNaCcFn+amoNUbpSMNhsgAmY2GkCJzz3CQ2DN0Qs9VNLTZ6KshP14=
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr7243239wmh.4.1596703756910;
 Thu, 06 Aug 2020 01:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200806081147.3123652-1-armbru@redhat.com>
 <20200806081147.3123652-2-armbru@redhat.com>
In-Reply-To: <20200806081147.3123652-2-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 6 Aug 2020 12:49:05 +0400
Message-ID: <CAJ+F1CJvsJ6zvLSXu1CoW+Q=vvw-zrS9PX_7GExTd6DoX9RxwQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs/interop/qmp-spec: Point to the QEMU QMP
 reference manual
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003e07f305ac3190b9"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003e07f305ac3190b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2020 at 12:12 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Commit 4d8bb958fa0..231aaf3a821 integrated the contents of
> docs/qmp-events.txt into QAPI schema doc comments.  It left dangling
> references to qmp-events.txt behind.  Fix to point to the QEMU QMP
> reference manual generated from the QAPI schema.
>
> Add a similar reference for commands.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/interop/qmp-spec.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
>
sure,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
> index adcf86754d..cdf5842555 100644
> --- a/docs/interop/qmp-spec.txt
> +++ b/docs/interop/qmp-spec.txt
> @@ -110,6 +110,9 @@ or
>    if provided.  The "id" member can be any json-value.  A json-number
>    incremented for each successive command works fine.
>
> +The actual commands are documented in the QEMU QMP reference manual
> +docs/interop/qemu-qmp-ref.{7,html,info,pdf,txt}.
> +
>  2.3.1 Out-of-band execution
>  ---------------------------
>
> @@ -207,13 +210,13 @@ The format of asynchronous events is:
>    there is a failure to retrieve host time, both members of the
>    timestamp will be set to -1.
>
> -For a listing of supported asynchronous events, please, refer to the
> -qmp-events.txt file.
> +The actual asynchronous events are documented in the QEMU QMP
> +reference manual docs/interop/qemu-qmp-ref.{7,html,info,pdf,txt}.
>
>  Some events are rate-limited to at most one per second.  If additional
>  "similar" events arrive within one second, all but the last one are
>  dropped, and the last one is delayed.  "Similar" normally means same
> -event type.  See qmp-events.txt for details.
> +event type.
>
>  2.6 Forcing the JSON parser into known-good state
>  -------------------------------------------------
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000003e07f305ac3190b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 6, 2020 at 12:12 PM Marku=
s Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Comm=
it 4d8bb958fa0..231aaf3a821 integrated the contents of<br>
docs/qmp-events.txt into QAPI schema doc comments.=C2=A0 It left dangling<b=
r>
references to qmp-events.txt behind.=C2=A0 Fix to point to the QEMU QMP<br>
reference manual generated from the QAPI schema.<br>
<br>
Add a similar reference for commands.<br>
<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0docs/interop/qmp-spec.txt | 9 ++++++---<br>
=C2=A01 file changed, 6 insertions(+), 3 deletions(-)<br>
<br></blockquote><div><br></div><div>sure,</div><div><div>Reviewed-by: Marc=
-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" targe=
t=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><div>=
<br></div> </div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt<br>
index adcf86754d..cdf5842555 100644<br>
--- a/docs/interop/qmp-spec.txt<br>
+++ b/docs/interop/qmp-spec.txt<br>
@@ -110,6 +110,9 @@ or<br>
=C2=A0 =C2=A0if provided.=C2=A0 The &quot;id&quot; member can be any json-v=
alue.=C2=A0 A json-number<br>
=C2=A0 =C2=A0incremented for each successive command works fine.<br>
<br>
+The actual commands are documented in the QEMU QMP reference manual<br>
+docs/interop/qemu-qmp-ref.{7,html,info,pdf,txt}.<br>
+<br>
=C2=A02.3.1 Out-of-band execution<br>
=C2=A0---------------------------<br>
<br>
@@ -207,13 +210,13 @@ The format of asynchronous events is:<br>
=C2=A0 =C2=A0there is a failure to retrieve host time, both members of the<=
br>
=C2=A0 =C2=A0timestamp will be set to -1.<br>
<br>
-For a listing of supported asynchronous events, please, refer to the<br>
-qmp-events.txt file.<br>
+The actual asynchronous events are documented in the QEMU QMP<br>
+reference manual docs/interop/qemu-qmp-ref.{7,html,info,pdf,txt}.<br>
<br>
=C2=A0Some events are rate-limited to at most one per second.=C2=A0 If addi=
tional<br>
=C2=A0&quot;similar&quot; events arrive within one second, all but the last=
 one are<br>
=C2=A0dropped, and the last one is delayed.=C2=A0 &quot;Similar&quot; norma=
lly means same<br>
-event type.=C2=A0 See qmp-events.txt for details.<br>
+event type.<br>
<br>
=C2=A02.6 Forcing the JSON parser into known-good state<br>
=C2=A0-------------------------------------------------<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000003e07f305ac3190b9--

