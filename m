Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC6AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1345206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1345206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgqAi-0005MR-0k
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jgq9r-0004p6-IA
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:43:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jgq9p-0007Sr-JN
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:43:47 -0400
Received: from mail-ua1-f72.google.com ([209.85.222.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jgq9n-0003vL-C7
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:43:43 +0000
Received: by mail-ua1-f72.google.com with SMTP id f26so2055665uao.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 06:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=osY920AbIM7l5qzygeE9P3bU93KOTBCqMrMRZpDWXrM=;
 b=W9HZr0/vZkXr+aEU1g5S/MwHh1/wq5uRICVKYF4GNNrbePvaGnBe0apaQSHibEcr04
 6U0SdFPJoYvA+6Oq3aYGD9QHmMzm3xJ1NF/74Fwdx9fit0+cumdf88ix5f4lUAS6kVfj
 szWH3upUV5cD4chFgzrxPcgGQy9GYneAWzMTxyy2mSEC+xueuV3zSiZ8VEqzOmB2+L8v
 1g7s2Jjaj/v4wPI644yVDyNsJdmVkwmWmDsrwUCDQAr7PzEuQ2eCP/rBde/24aKenS7s
 xzSAbBhN4t/gpeia9pSW5pvUtUmoVMCnUHda7EJFNFLjsNo57a5H5ETSmGKL8xGxng6u
 qZuA==
X-Gm-Message-State: AOAM530ao+swXIXvYTiIIyo488PzFXk4WPa+1huSa08HP+fKoJ+s9pZK
 J4T7v5LVulxnGeUFq5jYtGDfxrek2mjRi453wWQoF3m7v8boWnBvOPES6MZynE8C1CcAHvNamfp
 uBlYtlHMSz0hG6OsADvAFcy5BXOyIgvTaNTgZMHekL0utZex9
X-Received: by 2002:a67:c806:: with SMTP id u6mr3282377vsk.94.1591278222501;
 Thu, 04 Jun 2020 06:43:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMkEguD5AkybfTMkO205saesFLLTO/70L6IKTO3GJeX6bAaNLesDsj6VJpc8S7ulpJ5Xa+64kCs/Vm+iztI2Q=
X-Received: by 2002:a67:c806:: with SMTP id u6mr3282356vsk.94.1591278222186;
 Thu, 04 Jun 2020 06:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200604094425.63020-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200604094425.63020-1-marcandre.lureau@redhat.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Thu, 4 Jun 2020 15:43:16 +0200
Message-ID: <CAATJJ0KpmbbdojFy5uHyh01VdidBEBMBtcmqrKnMyhzASrN2hw@mail.gmail.com>
Subject: Re: [PATCH] qga: fix assert regression on guest-shutdown
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002c34e005a7425586"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=christian.ehrhardt@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 09:43:43
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--0000000000002c34e005a7425586
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2020 at 11:46 AM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Since commit 781f2b3d1e ("qga: process_event() simplification"),
> send_response() is called unconditionally, but will assert when "rsp" is
> NULL. This may happen with QCO_NO_SUCCESS_RESP commands, such as
> "guest-shutdown".
>
> Fixes: 781f2b3d1e5ef389b44016a897fd55e7a780bf35
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index f0e454f28d3..3febf3b0fdf 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -531,7 +531,11 @@ static int send_response(GAState *s, const QDict *rs=
p)
>      QString *payload_qstr, *response_qstr;
>      GIOStatus status;
>
> -    g_assert(rsp && s->channel);
> +    g_assert(s->channel);
> +
> +    if (!rsp) {
> +        return 0;
> +    }
>
>
>
Thanks Marc-Andr=C3=A9,
LGTM and should fix the issues I was seeing.

Reviewed-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>


--=20
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--0000000000002c34e005a7425586
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 4, 2020 at 11:46 AM Marc-=
Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcan=
dre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Since commit 781f2b3d1e (&quot;qga: process_event() si=
mplification&quot;),<br>
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
cal.com">christian.ehrhardt@canonical.com</a>&gt;</div><div><br></div><div>=
<br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Christian Ehrha=
rdt<br>Staff Engineer, Ubuntu Server<br>Canonical Ltd</div></div>

--0000000000002c34e005a7425586--

