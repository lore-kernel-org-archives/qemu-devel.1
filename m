Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD81C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17DD207F9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17DD207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicJ2-000126-OM
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jicEf-0004MV-3x
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:16:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jicEd-0002re-1y
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:16:04 -0400
Received: from mail-ua1-f72.google.com ([209.85.222.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jicEa-0005BP-7c
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:16:00 +0000
Received: by mail-ua1-f72.google.com with SMTP id z22so7734838uam.19
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oBhDRxmjvs3r+x2JBEPIEKih8R2LG/6YLL/TgHpysBo=;
 b=J0TfZ/mpaiOvUzVHw4AR5VUl5gCx8bNHa6ClBZZf4lVhAIKGvBROQWcje8YWTkRAeV
 ZQXDD3GV3uvGN6UWcdTaX0/2tu8XTIEa30f8BSbRp0lkK0vGZndLeiI7oKfey39ScHiB
 zEljwMsapdtWUOU/KCXEVroBXL31MCxUpwH2c75KI67SqjMwEF7W7K4MOiPoX4fobb7D
 hkSuYjUTNyPBJGT5PZLhXsS5pLI7opLdJYEyFNXMzVVouEhL7EFiC+Varj5u6BQa/tnW
 1B2b0SluPhFCD4L73+SYMdvVBlmjVcYf/4uqLxOMlwuoIVfvMYbouRZ1hAJHq/BBX4s6
 VH2Q==
X-Gm-Message-State: AOAM53375nu785Pmsvb0x2iZyo8QI1ORjmMnwE/A5qjHm18JZQFEfEH7
 p3fESD23yvnW144OsVblYxIR+BxHOZOuCcw6MxLN4zp+gG6G91N3N75djsWs86LyPy92rqRJ8KO
 vMq8bVA9T2FlTUhKOITVlWjepKUsSCDZpQC816NXzokD1y3jx
X-Received: by 2002:a9f:3603:: with SMTP id r3mr2177768uad.102.1591701359307; 
 Tue, 09 Jun 2020 04:15:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmaGQFxOhx2Yn4JL5g8p7sivi95iRaCunk5hZ3CB0BeYUrBILM+ESNko7eTRcj30ZNE5FuqjbRjtkxkTiew9U=
X-Received: by 2002:a9f:3603:: with SMTP id r3mr2177754uad.102.1591701358999; 
 Tue, 09 Jun 2020 04:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200604094425.63020-1-marcandre.lureau@redhat.com>
 <CAATJJ0KpmbbdojFy5uHyh01VdidBEBMBtcmqrKnMyhzASrN2hw@mail.gmail.com>
In-Reply-To: <CAATJJ0KpmbbdojFy5uHyh01VdidBEBMBtcmqrKnMyhzASrN2hw@mail.gmail.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Tue, 9 Jun 2020 13:15:33 +0200
Message-ID: <CAATJJ0+zTJBqNPV8e4A827Z-Hf0is1ocBFiZ3TmRb_2PV2HqQg@mail.gmail.com>
Subject: Re: [PATCH] qga: fix assert regression on guest-shutdown
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000017a5e305a7a4dabc"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=christian.ehrhardt@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 07:16:00
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001 autolearn=_AUTOLEARN
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

--00000000000017a5e305a7a4dabc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2020 at 3:43 PM Christian Ehrhardt <
christian.ehrhardt@canonical.com> wrote:

>
>
> On Thu, Jun 4, 2020 at 11:46 AM Marc-Andr=C3=A9 Lureau <
> marcandre.lureau@redhat.com> wrote:
>
>> Since commit 781f2b3d1e ("qga: process_event() simplification"),
>> send_response() is called unconditionally, but will assert when "rsp" is
>> NULL. This may happen with QCO_NO_SUCCESS_RESP commands, such as
>> "guest-shutdown".
>>
>> Fixes: 781f2b3d1e5ef389b44016a897fd55e7a780bf35
>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qga/main.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/qga/main.c b/qga/main.c
>> index f0e454f28d3..3febf3b0fdf 100644
>> --- a/qga/main.c
>> +++ b/qga/main.c
>> @@ -531,7 +531,11 @@ static int send_response(GAState *s, const QDict
>> *rsp)
>>      QString *payload_qstr, *response_qstr;
>>      GIOStatus status;
>>
>> -    g_assert(rsp && s->channel);
>> +    g_assert(s->channel);
>> +
>> +    if (!rsp) {
>> +        return 0;
>> +    }
>>
>>
>>
> Thanks Marc-Andr=C3=A9,
> LGTM and should fix the issues I was seeing.
>
> Reviewed-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
>

In the meantime I also got to test this against the initially reported
issue, LGTM as well (ran as no-change backport onto 4.2).

Tested-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>

--00000000000017a5e305a7a4dabc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 4, 2020 at 3:43 PM Christ=
ian Ehrhardt &lt;<a href=3D"mailto:christian.ehrhardt@canonical.com">christ=
ian.ehrhardt@canonical.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun=
 4, 2020 at 11:46 AM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre=
.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Since comm=
it 781f2b3d1e (&quot;qga: process_event() simplification&quot;),<br>
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

--00000000000017a5e305a7a4dabc--

