Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8500CC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 06:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AED22248
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 06:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmCnVBAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AED22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXfDQ-0007Qy-TS
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 02:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1kXfA3-00056c-5G; Wed, 28 Oct 2020 02:42:19 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:37591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1kXfA1-0000Ip-6c; Wed, 28 Oct 2020 02:42:18 -0400
Received: by mail-vs1-xe44.google.com with SMTP id b4so2255983vsd.4;
 Tue, 27 Oct 2020 23:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sa4UEROik2uM9xhhpz2pXjcWm10npUnARQEkA35Fldw=;
 b=CmCnVBAjhg9pOG3d2t3mTwwAFIKnqMQVO2hha/PjLTTpBy4vjjOg/ikP0Naxhu7eyd
 ILpXBaq7D+9dUPlODgROW/FMDT4fzcJiC2ssF5q9n3hl5ePpRpNqxpmnPLwKrgL7UXnw
 VY8oFn2pR1ZcV0kOgfpa1VFnqdJjeYgYFL3r/YC19y6gWw4RByx0HiUavUU+wjnb1gFM
 HlfEqp8kgq52BKWJCliIYMEwXg93qOjaMErQy8OlKW0q1Lxx8RYRK2Dc+7Otxa7xufEJ
 FtVQ09WilG3F/RFGAbuiOPNeOXO4eJUH/MdrfWQfpq1q2aO5qGFj05X9A0qcal/va2vt
 Q16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sa4UEROik2uM9xhhpz2pXjcWm10npUnARQEkA35Fldw=;
 b=GY9HzBLFG5oWPa1hmSYMA6To/iiBmWnrMlPyoGszewrjP53+oL2UkAVfSUgu6o/t82
 ipl9iqlLF2zxmDm0sBe7QKFjrGVFsABV24lQOchMOFl2LxCEOxS0ERPK9XWEkxdCojJf
 5C0KqS5EhrKhvuVxoqdTtvB70grBIX44pDsC2sIVaGPF1wzAPwb+Trz6IpioGbveJ3De
 mHL6kHpirV/FlwFDVMQKy889DHow3G3MWmF5L/nY3inelgjZsy/Pnc/0KAlog7h9xvsE
 7tgqY+alyC37jEqcp6/CBm7VipbcAmYXMChXyG210Xz2YDnxJ1NrOLkmoFqzOboH9mkZ
 xeEQ==
X-Gm-Message-State: AOAM531WfBJDsgs0VXSsmr7Er2p87AELykq2eSzhrzppAalg38iY4atb
 gqMiKFwnOZU0uFEObQWHb/nP5+C1UmWURAuWhSU=
X-Google-Smtp-Source: ABdhPJxDrRAFVSnJFNQygoPDtFcIMrNvsOig12zLRsT6sHiYS12qZ+GMDuPoeVOl5Zgcbe0UW+IluajHHvKPYXQaiNs=
X-Received: by 2002:a67:d387:: with SMTP id b7mr3990350vsj.24.1603867335797;
 Tue, 27 Oct 2020 23:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-7-kuhn.chenqun@huawei.com>
In-Reply-To: <20201028041819.2169003-7-kuhn.chenqun@huawei.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 28 Oct 2020 07:42:03 +0100
Message-ID: <CAAM0arNiHFoXPs2xrAWY=T8_hb5_eqqQXsfkmkk-uxLr=NWDrA@mail.gmail.com>
Subject: Re: [PATCH 6/9] target/sparc/win_helper: silence the compiler warnings
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000d12e8305b2b5768a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e44;
 envelope-from=a.tarasenko@gmail.com; helo=mail-vs1-xe44.google.com
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d12e8305b2b5768a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 28 =D0=BE=D0=BA=D1=82. 2020 =D0=B3., 5:19 Chen Qun <kuhn.chen=
qun@huawei.com>:

> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed
> warning:
> target/sparc/win_helper.c: In function =E2=80=98get_gregset=E2=80=99:
> target/sparc/win_helper.c:304:9: warning: this statement may fall through
> [-Wimplicit-fallthrough=3D]
>   304 |         trace_win_helper_gregset_error(pstate);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> target/sparc/win_helper.c:306:5: note: here
>   306 |     case 0:
>       |     ^~~~
>
> Add the corresponding "fall through" comment to fix it.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

---
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>  target/sparc/win_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
> index 8290a21142..32eacc05e6 100644
> --- a/target/sparc/win_helper.c
> +++ b/target/sparc/win_helper.c
> @@ -303,6 +303,7 @@ static inline uint64_t *get_gregset(CPUSPARCState
> *env, uint32_t pstate)
>      default:
>          trace_win_helper_gregset_error(pstate);
>          /* pass through to normal set of global registers */
> +        /* fall through */
>      case 0:
>          return env->bgregs;
>      case PS_AG:
> --
> 2.27.0
>
>

--000000000000d12e8305b2b5768a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">=D1=81=D1=80, 28 =D0=BE=D0=BA=D1=82. 2020 =D0=B3., 5:19 Chen Q=
un &lt;<a href=3D"mailto:kuhn.chenqun@huawei.com">kuhn.chenqun@huawei.com</=
a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">When using -Wimplicit-fallt=
hrough in our CFLAGS, the compiler showed warning:<br>
target/sparc/win_helper.c: In function =E2=80=98get_gregset=E2=80=99:<br>
target/sparc/win_helper.c:304:9: warning: this statement may fall through [=
-Wimplicit-fallthrough=3D]<br>
=C2=A0 304 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_win_helper_gregset_erro=
r(pstate);<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~<br>
target/sparc/win_helper.c:306:5: note: here<br>
=C2=A0 306 |=C2=A0 =C2=A0 =C2=A0case 0:<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~<br>
<br>
Add the corresponding &quot;fall through&quot; comment to fix it.<br>
<br>
Reported-by: Euler Robot &lt;<a href=3D"mailto:euler.robot@huawei.com" targ=
et=3D"_blank" rel=3D"noreferrer">euler.robot@huawei.com</a>&gt;<br>
Signed-off-by: Chen Qun &lt;<a href=3D"mailto:kuhn.chenqun@huawei.com" targ=
et=3D"_blank" rel=3D"noreferrer">kuhn.chenqun@huawei.com</a>&gt;<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><span style=
=3D"font-family:sans-serif">Reviewed-by:=C2=A0</span><span style=3D"font-fa=
mily:sans-serif">Artyom Tarasenko &lt;</span><a href=3D"mailto:atar4qemu@gm=
ail.com" style=3D"font-family:sans-serif">atar4qemu@gmail.com</a><span styl=
e=3D"font-family:sans-serif">&gt;</span><br></div><div dir=3D"auto"><span s=
tyle=3D"font-family:sans-serif"><br></span></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
Cc: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk" t=
arget=3D"_blank" rel=3D"noreferrer">mark.cave-ayland@ilande.co.uk</a>&gt;<b=
r>
Cc: Artyom Tarasenko &lt;<a href=3D"mailto:atar4qemu@gmail.com" target=3D"_=
blank" rel=3D"noreferrer">atar4qemu@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/sparc/win_helper.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c<br>
index 8290a21142..32eacc05e6 100644<br>
--- a/target/sparc/win_helper.c<br>
+++ b/target/sparc/win_helper.c<br>
@@ -303,6 +303,7 @@ static inline uint64_t *get_gregset(CPUSPARCState *env,=
 uint32_t pstate)<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_win_helper_gregset_error(pstate);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* pass through to normal set of global r=
egisters */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */<br>
=C2=A0 =C2=A0 =C2=A0case 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return env-&gt;bgregs;<br>
=C2=A0 =C2=A0 =C2=A0case PS_AG:<br>
-- <br>
2.27.0<br>
<br>
</blockquote></div></div></div>

--000000000000d12e8305b2b5768a--

