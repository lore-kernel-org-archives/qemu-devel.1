Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB8BC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586B7206DD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzaH5cAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586B7206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSvg-0002Fm-7i
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPStO-0008Ux-6O
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:14 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPStK-00027W-LK
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:13 -0400
Received: by mail-lj1-x242.google.com with SMTP id a4so3351913lji.12
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=KZSr1+RWhjf73U8t/JBw3lLrcq3qCKPaCeufJWjWElk=;
 b=NzaH5cApY7pP8PbQGrKxnQlPEOEaaV8HAaDJ/9bPap0zDWMWhZmU+TRboiArX+YkCr
 At7cDGOJpvRDxv2ZI07NmJLZTMN2TjbZ50xptiCkXsyPwg4khd171HlJAn2wuL7wf+pv
 ZDfi9GqO3Vg/4GrKbrS3rLZGQQ/lIEreSNFPJ5+WMtaRD2tdvN5NnQRQDKJx7FgHvmmj
 ZwPnGuv0UBcy0IQyvc2olHSwag6VbvkZPhbCgGH47yGJ68tZ8gCjDBRVbaSQb7dAL2LE
 VasCDHbQUc9j2RmDyMWVv5Qf1CySVIUSpbivMcRGO7apxg1RgFNMzxlWIM5CtkHLu5Xt
 4svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=KZSr1+RWhjf73U8t/JBw3lLrcq3qCKPaCeufJWjWElk=;
 b=SYcmKenHnfsp8Jk+eimxSIFTACywI1Y5OYek2RFQ7e49ncFuoX47WUpFHLEhqyH8xz
 kTd1EhOf3GCWuL/Dr/NGVU/RKsXT0Ma+kMQnDC5eDFnjAdq9IB3ZDwDyWp7jlohIJjpQ
 EDxHYoErOZJa3mKnTfP8KqMEOJClSZpghHTXne+76nxGoqHikG7F8dB2HiGG26/3DgEB
 BBGMGN+V6EQ9kkVKWCtXTkdR9++0bcB4/rAxcHYRniLlXQEiO9SNl4ag5UBNYJlRM2ig
 UtTu9xrrQ7E99SE4CL7VkB/4If1bZQuvxgRaicc9K7MeCAi6BHNmpemRRL+2NqZmmdNx
 8P9A==
X-Gm-Message-State: AOAM533ZjeNVl6A44Y9EuaJmfDkW7mDs6AOMe1xOw9PPQZaKzLwtyM5k
 3pZXdk59EIYcChWntvr1mCXta4O/yPKtu87N7a8=
X-Google-Smtp-Source: ABdhPJzrILBFsenUhsRIY8/O6MFTiBFerhZtaYWEZNKMJoRwoAnSW2Xd3AO6fWIKsyiFsQJEkaYYpaaDMgAqVB0d6AE=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr130185ljj.447.1601913548860;
 Mon, 05 Oct 2020 08:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201001163429.1348-1-luoyonggang@gmail.com>
 <20201001163429.1348-5-luoyonggang@gmail.com>
 <87sgat2bqh.fsf@linaro.org>
In-Reply-To: <87sgat2bqh.fsf@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 5 Oct 2020 23:58:59 +0800
Message-ID: <CAE2XoE_UUUSyMaeEbZzci2t9GQ+1sgm=B5M7qOytr6JX+XPgJQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] plugin: define QEMU_PLUGIN_API_IMPLEMENTATION first
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000a73da05b0ee902d"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000a73da05b0ee902d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, I split this out just for easier review, so the lines changed in api.c
and core.c
equales to the number of function exported, anyway

On Mon, Oct 5, 2020 at 6:44 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Yonggang Luo <luoyonggang@gmail.com> writes:
>
> > This is used to distinguish from the qemu and plugin in
> > header qemu-plugin.h
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  plugins/api.c  | 1 +
> >  plugins/core.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/plugins/api.c b/plugins/api.c
> > index bbdc5a4eb4..f16922ca8b 100644
> > --- a/plugins/api.c
> > +++ b/plugins/api.c
> > @@ -35,6 +35,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > +#define QEMU_PLUGIN_API_IMPLEMENTATION
> >  #include "qemu/plugin.h"
>
> This doesn't do anything in this patch. You should split the special
> handling in the plugin header and combine it in this patch. Also I'm not
> quite sure of the logic you are trying to achieve later on:
>
>   #if !defined(QEMU_PLUGIN_API_IMPLEMENTATION)
>   #if defined(QEMU_PLUGIN_IMPLEMENTATION)
>   #define QEMU_PLUGIN_EXTERN
>   #else
>   #define QEMU_PLUGIN_EXTERN extern
>   #endif
>
> It seems to me you could get away with only one symbol - ideally just
> defined in plugins/api.c so you don't need to churn the plugins with
> changes, e.g.
>
>   #ifdef QEMU_PLUGIN_API_IMPLEMENTATION
>   #define QEMU_PLUGIN_EXTERN
>   #else
>   #define QEMU_PLUGIN_EXTERN extern
>   #endif
>
> But I'd still like to have a better answer as to why we need the extern?
> Is this a limitation of the mingw compiler or some windows special?
>
> >  #include "cpu.h"
> >  #include "sysemu/sysemu.h"
> > diff --git a/plugins/core.c b/plugins/core.c
> > index 51bfc94787..7a79ea4179 100644
> > --- a/plugins/core.c
> > +++ b/plugins/core.c
> > @@ -12,6 +12,7 @@
> >   * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >  #include "qemu/osdep.h"
> > +#define QEMU_PLUGIN_API_IMPLEMENTATION
> >  #include "qemu/error-report.h"
> >  #include "qemu/config-file.h"
> >  #include "qapi/error.h"
>
> I don't think we include qemu/plugin.h from this file although it does
> raise the question of what happens when other parts of QEMU include the
> internal qemu/plugins.h header.
>
> --
> Alex Benn=C3=A9e



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000000a73da05b0ee902d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, I split this out just for easier review, so the lines =
changed in api.c and core.c<div>equales to the number of function exported,=
 anyway<br><br>On Mon, Oct 5, 2020 at 6:44 PM Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br=
>&gt;<br>&gt;<br>&gt; Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.=
com">luoyonggang@gmail.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; This is use=
d to distinguish from the qemu and plugin in<br>&gt; &gt; header qemu-plugi=
n.h<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"ma=
ilto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<=
br>&gt; &gt; =C2=A0plugins/api.c =C2=A0| 1 +<br>&gt; &gt; =C2=A0plugins/cor=
e.c | 1 +<br>&gt; &gt; =C2=A02 files changed, 2 insertions(+)<br>&gt; &gt;<=
br>&gt; &gt; diff --git a/plugins/api.c b/plugins/api.c<br>&gt; &gt; index =
bbdc5a4eb4..f16922ca8b 100644<br>&gt; &gt; --- a/plugins/api.c<br>&gt; &gt;=
 +++ b/plugins/api.c<br>&gt; &gt; @@ -35,6 +35,7 @@<br>&gt; &gt; =C2=A0 */<=
br>&gt; &gt; <br>&gt; &gt; =C2=A0#include &quot;qemu/osdep.h&quot;<br>&gt; =
&gt; +#define QEMU_PLUGIN_API_IMPLEMENTATION<br>&gt; &gt; =C2=A0#include &q=
uot;qemu/plugin.h&quot;<br>&gt;<br>&gt; This doesn&#39;t do anything in thi=
s patch. You should split the special<br>&gt; handling in the plugin header=
 and combine it in this patch. Also I&#39;m not<br>&gt; quite sure of the l=
ogic you are trying to achieve later on:<br>&gt;<br>&gt; =C2=A0 #if !define=
d(QEMU_PLUGIN_API_IMPLEMENTATION)<br>&gt; =C2=A0 #if defined(QEMU_PLUGIN_IM=
PLEMENTATION)<br>&gt; =C2=A0 #define QEMU_PLUGIN_EXTERN<br>&gt; =C2=A0 #els=
e<br>&gt; =C2=A0 #define QEMU_PLUGIN_EXTERN extern<br>&gt; =C2=A0 #endif<br=
>&gt;<br>&gt; It seems to me you could get away with only one symbol - idea=
lly just<br>&gt; defined in plugins/api.c so you don&#39;t need to churn th=
e plugins with<br>&gt; changes, e.g.<br>&gt;<br>&gt; =C2=A0 #ifdef QEMU_PLU=
GIN_API_IMPLEMENTATION<br>&gt; =C2=A0 #define QEMU_PLUGIN_EXTERN<br>&gt; =
=C2=A0 #else<br>&gt; =C2=A0 #define QEMU_PLUGIN_EXTERN extern<br>&gt; =C2=
=A0 #endif<br>&gt;<br>&gt; But I&#39;d still like to have a better answer a=
s to why we need the extern?<br>&gt; Is this a limitation of the mingw comp=
iler or some windows special?<br>&gt;<br>&gt; &gt; =C2=A0#include &quot;cpu=
.h&quot;<br>&gt; &gt; =C2=A0#include &quot;sysemu/sysemu.h&quot;<br>&gt; &g=
t; diff --git a/plugins/core.c b/plugins/core.c<br>&gt; &gt; index 51bfc947=
87..7a79ea4179 100644<br>&gt; &gt; --- a/plugins/core.c<br>&gt; &gt; +++ b/=
plugins/core.c<br>&gt; &gt; @@ -12,6 +12,7 @@<br>&gt; &gt; =C2=A0 * SPDX-Li=
cense-Identifier: GPL-2.0-or-later<br>&gt; &gt; =C2=A0 */<br>&gt; &gt; =C2=
=A0#include &quot;qemu/osdep.h&quot;<br>&gt; &gt; +#define QEMU_PLUGIN_API_=
IMPLEMENTATION<br>&gt; &gt; =C2=A0#include &quot;qemu/error-report.h&quot;<=
br>&gt; &gt; =C2=A0#include &quot;qemu/config-file.h&quot;<br>&gt; &gt; =C2=
=A0#include &quot;qapi/error.h&quot;<br>&gt;<br>&gt; I don&#39;t think we i=
nclude qemu/plugin.h from this file although it does<br>&gt; raise the ques=
tion of what happens when other parts of QEMU include the<br>&gt; internal =
qemu/plugins.h header.<br>&gt;<br>&gt; --<br>&gt; Alex Benn=C3=A9e<br><br><=
br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=
=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>=
Yonggang Luo</div></div>

--0000000000000a73da05b0ee902d--

