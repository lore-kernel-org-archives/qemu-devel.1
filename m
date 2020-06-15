Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCE2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C682068E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C682068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkjUS-0002yC-7o
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 03:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jkjTu-0002XJ-Rn
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:24:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jkjTs-00046E-SH
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:24:34 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jkjTp-0004hG-Tt
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 07:24:30 +0000
Received: by mail-vs1-f69.google.com with SMTP id b7so1704295vsh.14
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 00:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mb5GvPq0DWHxlH1+kA1vodEW516AcRwabqpZs5YQmNs=;
 b=d/kjpOEUfHassN/qrVtrgiaBITnToQqR4zWkyLxQ2ufbN+0yiAt5RRWPVdFpePxmTF
 gUUvUGFTNctNRvkZnVzFwKm2vWTNnj+vffx5ydtXG5yWv/wR9Czx7iGDnjRaa3ooVd2L
 OusrXXC/XFD2QlzLe6IW/1EjapJTgzZDksDB6b6tRqZqfuoztVhvNS1e8vIb6weXvNN3
 GMsaR8ExOQwGfOjE7h3NU0dp2U67SqG84LVsfoHgqrFDUKh04+XkYaInopR0whCR7e6N
 tG5Eo09Km3+yveQH8bTCRDT54GMoHTU+2bRw6qsN3WWRNrMtn1v8des5UGDHeW5+PiWK
 XMag==
X-Gm-Message-State: AOAM531HBi3ZXVgH4SIrEZUs0FpsgPpNg9/wKQObpO1DMPAWIgfxBklT
 jBP7c6mlsSn1aIbgOK8TLWS7yfl/IQE1gKCvsTsafsjZolqa8TFCp0Jx/RFotwJmRYoy7fli6ho
 VZ6wnZA0WBTFxneTHbUa1hKWmkxjfu7HA+43jnnaMeG/I2puI
X-Received: by 2002:a1f:60d5:: with SMTP id u204mr16560986vkb.91.1592205869044; 
 Mon, 15 Jun 2020 00:24:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaXDVz6nl5Zp7ucYuuUW8xYiU3hfR5+xTYVQhj2VNGOU9vNv4JxxwQC6Bh/V2I1ScwnIVTKVZO/MMlTiWzt+U=
X-Received: by 2002:a1f:60d5:: with SMTP id u204mr16560975vkb.91.1592205868756; 
 Mon, 15 Jun 2020 00:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200604094425.63020-1-marcandre.lureau@redhat.com>
 <CAATJJ0KpmbbdojFy5uHyh01VdidBEBMBtcmqrKnMyhzASrN2hw@mail.gmail.com>
 <CAATJJ0+zTJBqNPV8e4A827Z-Hf0is1ocBFiZ3TmRb_2PV2HqQg@mail.gmail.com>
In-Reply-To: <CAATJJ0+zTJBqNPV8e4A827Z-Hf0is1ocBFiZ3TmRb_2PV2HqQg@mail.gmail.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Mon, 15 Jun 2020 09:24:02 +0200
Message-ID: <CAATJJ0KrXxGeZ2zo7eejGFh_ika-CTpBkhu+M3nqR66o8k5CRQ@mail.gmail.com>
Subject: Re: [PATCH] qga: fix assert regression on guest-shutdown
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000037915805a81a51f4"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=christian.ehrhardt@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 03:24:30
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000037915805a81a51f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2020 at 1:15 PM Christian Ehrhardt <
christian.ehrhardt@canonical.com> wrote:

>
>
> On Thu, Jun 4, 2020 at 3:43 PM Christian Ehrhardt <
> christian.ehrhardt@canonical.com> wrote:
>
>>
>>
>> On Thu, Jun 4, 2020 at 11:46 AM Marc-Andr=C3=A9 Lureau <
>> marcandre.lureau@redhat.com> wrote:
>>
>>> Since commit 781f2b3d1e ("qga: process_event() simplification"),
>>> send_response() is called unconditionally, but will assert when "rsp" i=
s
>>> NULL. This may happen with QCO_NO_SUCCESS_RESP commands, such as
>>> "guest-shutdown".
>>>
>>> Fixes: 781f2b3d1e5ef389b44016a897fd55e7a780bf35
>>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>>> Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  qga/main.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qga/main.c b/qga/main.c
>>> index f0e454f28d3..3febf3b0fdf 100644
>>> --- a/qga/main.c
>>> +++ b/qga/main.c
>>> @@ -531,7 +531,11 @@ static int send_response(GAState *s, const QDict
>>> *rsp)
>>>      QString *payload_qstr, *response_qstr;
>>>      GIOStatus status;
>>>
>>> -    g_assert(rsp && s->channel);
>>> +    g_assert(s->channel);
>>> +
>>> +    if (!rsp) {
>>> +        return 0;
>>> +    }
>>>
>>>
>>>
>> Thanks Marc-Andr=C3=A9,
>> LGTM and should fix the issues I was seeing.
>>
>> Reviewed-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
>>
>
> In the meantime I also got to test this against the initially reported
> issue, LGTM as well (ran as no-change backport onto 4.2).
>
> Tested-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
>

This LGTM with 2*reviews 1*tested and 11 days on the list without any
negative feedback.
I just wanted to re-check if there is anything else left for this to be
committed?

--00000000000037915805a81a51f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 9, 2020 at 1:15 PM Christ=
ian Ehrhardt &lt;<a href=3D"mailto:christian.ehrhardt@canonical.com">christ=
ian.ehrhardt@canonical.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun=
 4, 2020 at 3:43 PM Christian Ehrhardt &lt;<a href=3D"mailto:christian.ehrh=
ardt@canonical.com" target=3D"_blank">christian.ehrhardt@canonical.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 4, 2020 at 11:46 AM Marc-Andr=
=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"=
_blank">marcandre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Since commit 781f2b3d1e (&quot;qga: proc=
ess_event() simplification&quot;),<br>
send_response() is called unconditionally, but will assert when &quot;rsp&q=
uot; is<br>
NULL. This may happen with QCO_NO_SUCCESS_RESP commands, such as<br>
&quot;guest-shutdown&quot;.<br>
<br>
Fixes: 781f2b3d1e5ef389b44016a897fd55e7a780bf35<br>
Cc: Michael Roth &lt;<a href=3D"mailto:mdroth@linux.vnet.ibm.com" target=3D=
"_blank">mdroth@linux.vnet.ibm.com</a>&gt;<br>
Reported-by: Christian Ehrhardt &lt;<a href=3D"mailto:christian.ehrhardt@ca=
nonical.com" target=3D"_blank">christian.ehrhardt@canonical.com</a>&gt;<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/main.c | 6 +++++-<br>
=C2=A01 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index f0e454f28d3..3febf3b0fdf 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -531,7 +531,11 @@ static int send_response(GAState *s, const QDict *rsp)=
<br>
=C2=A0 =C2=A0 =C2=A0QString *payload_qstr, *response_qstr;<br>
=C2=A0 =C2=A0 =C2=A0GIOStatus status;<br>
<br>
-=C2=A0 =C2=A0 g_assert(rsp &amp;&amp; s-&gt;channel);<br>
+=C2=A0 =C2=A0 g_assert(s-&gt;channel);<br>
+<br>
+=C2=A0 =C2=A0 if (!rsp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
<br><br>
</blockquote></div><div><br></div><div>Thanks Marc-Andr=C3=A9,</div><div>LG=
TM and should fix the issues I was seeing.</div><br clear=3D"all"><div>Revi=
ewed-by: Christian Ehrhardt &lt;<a href=3D"mailto:christian.ehrhardt@canoni=
cal.com" target=3D"_blank">christian.ehrhardt@canonical.com</a>&gt;</div></=
div></blockquote><div><br></div><div>In the meantime I also got to test thi=
s against the initially reported issue, LGTM as well (ran as no-change back=
port onto 4.2).</div><div><br></div><div>Tested-by: Christian Ehrhardt &lt;=
<a href=3D"mailto:christian.ehrhardt@canonical.com" target=3D"_blank">chris=
tian.ehrhardt@canonical.com</a>&gt;</div></div></div>
</blockquote></div><br><div>This LGTM with 2*reviews 1*tested and 11 days o=
n the list without any negative feedback.</div><div>I just wanted to re-che=
ck if there is anything else left for this to be committed?</div></div>

--00000000000037915805a81a51f4--

