Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A44C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3439A207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njcuNY4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3439A207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlQkd-00077J-DC
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlQjq-0006eO-V7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:35:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlQjo-00023U-EU
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:35:54 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so924107wru.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 22:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Bh06p5Mk0Henu5oxrgCqlEQFdHg5UqaccH9SSpleoZc=;
 b=njcuNY4hJJY7J6HdKKdtVwvBJawDquSExGHxnfL146lCpFUqijBbkbYm66P2o29M7D
 1HBMFjhn8XgBDpv9crL/4pM3TMw1nWL/Ukkjo07fkTXVRY+vafAFvJh119+swSXi7XSF
 S2zglSKACnZ2KUuEN6bSlsriydx89C9huHW79Jhj176aKXoLR2hGlXFnZH1yDpNI3Aaf
 3SDS5iZ6W8Tz4erTjIAghbeJWsyqymR5Jmt5r9WfkYOQZ5TkJ/cM0oWrttOi2VsBnEIb
 ebedwxPRJdfZpRfMIpgpt48sDYjhtZ+JlJRCSRloSYWSzSDVipVa4VRytSrEBGqyTEOt
 /rGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Bh06p5Mk0Henu5oxrgCqlEQFdHg5UqaccH9SSpleoZc=;
 b=uNR94FkRODQz+xynrtA1DkcEKaWuQ3H3+xPk5WfzLIO9UI/qGn2A7KcJXLQqYftoXl
 bY0IIF6JPZ7a4VVqTPri37M9SYxEKMqATRazXll6mEekdozpj+Im4iPhS/4QtIo59LUN
 WAijm4uR9oZLxIosTG9vbsL0pA33AaPDgTUs1FHtaA7DbPZcYoJ1fEolxwfVOm7TUsmc
 y3gqogd9/l2ONkPGZGvrOyDclZre3lfsQ+5J3atqZEMQXpZHmGmotQq5I7m9/vV8BfGf
 zBUpoNSx4o2eaoz+Syblxy1q7cOSNRfdd7/squpW8sXapgcY7VYzTOesHelyRD/chMlD
 mlFw==
X-Gm-Message-State: AOAM533hL1rdYOOWuemllKBdtbXPDh0nfn2putHERyC6qvCJevaC0jde
 ndwP+f0QSiwN0zku/Km7rGtnGqCMeK+lRb6iOZE=
X-Google-Smtp-Source: ABdhPJxkkLv5nDAdki6IgeTLeeeGij2Ru7aN9JSKwxP/U2TakalepoeArrGonmyogInyiNBIZyAT+eLM7ytac+4zj0Y=
X-Received: by 2002:adf:a283:: with SMTP id s3mr6153537wra.147.1592372150683; 
 Tue, 16 Jun 2020 22:35:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Tue, 16 Jun 2020 22:35:50 -0700 (PDT)
In-Reply-To: <20200616231204.8850-2-ahmedkhaledkaraman@gmail.com>
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <20200616231204.8850-2-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 17 Jun 2020 07:35:50 +0200
Message-ID: <CAHiYmc4vhJ3L4V2TZvr7cvdZYeJt9xY+cTzM_xvLz=3c30qYUQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Add 'Miscellaneous' section
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000006449e805a8410826"
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "crosa@redhat.com" <crosa@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006449e805a8410826
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 17. =D1=98=D1=83=D0=BD 2020., Ahmed Karaman=
 <ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> This new section includes the 'Performance Tools and Tests' subsection
> which will contain the the performance scripts and benchmarks written
> as a part of the 'TCG Continuous Benchmarking' project.
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 955cc8dd5c..68f668ae2a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2974,3 +2974,10 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  S: Maintained
>  F: docs/conf.py
>  F: docs/*/conf.py
> +
> +Miscellaneous
> +-------------
> +Performance Tools and Tests
> +M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +S: Maintained
> +F: scripts/performance/
> \ No newline at end of file
> --


I don't think that it makes any functional difference in this case, but it
is customary that the last line of any source file contains end-of-line
characters, so please add that in the next version of the series.

Also, I think it is more logical that this patch is the last patch in the
series - if left the way you proposed, this patch would refer to the
directory that does not exist - yet.

Otherwise, it looks good to me.

Section "Miscellaneous" makes sense to me.

Thanks,
Aleksandar



> 2.17.1
>
>

--0000000000006449e805a8410826
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 17. =D1=98=D1=83=D0=BD 2020., Ahmed=
 Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmedkhaledkar=
aman@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This new section includ=
es the &#39;Performance Tools and Tests&#39; subsection<br>
which will contain the the performance scripts and benchmarks written<br>
as a part of the &#39;TCG Continuous Benchmarking&#39; project.<br>
<br>
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 7 +++++++<br>
=C2=A01 file changed, 7 insertions(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 955cc8dd5c..68f668ae2a 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -2974,3 +2974,10 @@ M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell=
@linaro.org">peter.maydell@linaro.org</a>&gt;<br>
=C2=A0S: Maintained<br>
=C2=A0F: docs/conf.py<br>
=C2=A0F: docs/*/conf.py<br>
+<br>
+Miscellaneous<br>
+-------------<br>
+Performance Tools and Tests<br>
+M: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmed=
khaledkaraman@gmail.com</a>&gt;<br>
+S: Maintained<br>
+F: scripts/performance/<br>
\ No newline at end of file<br>
--=C2=A0</blockquote><div><br></div><div>I don&#39;t think that it makes an=
y functional difference in this case, but it is customary that the last lin=
e of any source file contains end-of-line characters, so please add that in=
 the next version of the series.</div><div><br></div><div>Also, I think it =
is more logical that this patch is the last patch in the series - if left t=
he way you proposed, this patch would refer to the directory that does not =
exist - yet.</div><div><br></div><div>Otherwise, it looks good to me.</div>=
<div><br></div><div>Section &quot;Miscellaneous&quot; makes sense to me.</d=
iv><div><br></div><div>Thanks,</div><div>Aleksandar</div><div><br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
2.17.1<br>
<br>
</blockquote>

--0000000000006449e805a8410826--

