Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34EEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C5720727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOAGARNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C5720727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZgOO-000792-Kb
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 15:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <igotti@gmail.com>) id 1jZgN9-0005vg-NE
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:51:57 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <igotti@gmail.com>) id 1jZgN8-0006jK-KF
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:51:55 -0400
Received: by mail-lf1-x144.google.com with SMTP id h26so2821879lfg.6
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=poGW6wTrq7Q5wyU1AmTVcloYOLmEQAmWnCPBYTF6l4A=;
 b=LOAGARNKFTw2Eerxw5YvphsX261opVaKdlmQKUZgnHOXc127WG1loh1BCawCSHt6iq
 8Fijq8/Yp2tqkXzfmF3UTn0/Bk0UF9MMYj3WDGHVjYlB/uwOvx+AdILmhfnjDN9w1ftA
 b6RTPvF61ajDVUOgGdBXt0LRQpfS50wSXqcakLt9wf09UOSElZt6Kf21iq5ORJgEkIHW
 Q3/PTb9UMXmgWjpmKYvNL8MXu0XY8ZwgLbGainh6q0Rc2Ni55iAx476nJiRujkbpWdRb
 UUSGxLz47ACVWF/f97Gx3Ia7wqyr8z63UDD448TT9dtHxSv/7GEz8gsCX49mppt1nAcV
 yzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=poGW6wTrq7Q5wyU1AmTVcloYOLmEQAmWnCPBYTF6l4A=;
 b=Rr68bIYMNjBLkdMnrrnb9bcAcynRE0wOHm03TzXZtMVAEzrA1LngfL4McEKL++2TiR
 wpFxTdDoqouWHgsaSN+5dd3drNMG+2iclfcvHxGFFKp07KWuqlhP3l+pmrMbn+8LMHI6
 O56g5L5eIAW8DvVeS27D5fZ15TkVEaypJi4y9PnGDyMjenQqIK1LudAt7cP6+R1wLPuw
 KkKgmIi8TsO4oGjQ7xwR93xQW58PtEpCbxa628Rb0MH8WVIHkEmP0oUVW0XX5xVWprQm
 gmtkvdU0buFBi2mJOkC3kiHxiSFsSaxqzqFXTu5xFv1AAagtSRPXGvpp4dbnPdkUKezs
 FnSg==
X-Gm-Message-State: AOAM532tr+i356ZJggGxyME3RRfha9glOxAVO/x/lpCZ8LdwvurRl+4C
 ZUPOYRwx/yq80FuB7zTwBig4vS2gM5fA7TIGJjc=
X-Google-Smtp-Source: ABdhPJxLaaZ4AMiAvZX10TK9hSF+0+YBNX6TwcO2I9XJECh5D4WkVOhOUHebo6LOJNjlBv69Bg4O4UHq/TN3KrzK0Vg=
X-Received: by 2002:a19:c348:: with SMTP id t69mr2375388lff.207.1589572312028; 
 Fri, 15 May 2020 12:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200513173200.11830-1-alex.bennee@linaro.org>
 <20200513173200.11830-8-alex.bennee@linaro.org>
In-Reply-To: <20200513173200.11830-8-alex.bennee@linaro.org>
From: Nikolay Igotti <igotti@gmail.com>
Date: Fri, 15 May 2020 22:51:40 +0300
Message-ID: <CAEme+7FRtSsVhsgPTQfX+OKNhr_=a9VgqiTexcoKAUh_uD1=eQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] tests/tcg: add new threadcount test
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000000d85905a5b5259f"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=igotti@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000000d85905a5b5259f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure, use it for anything.

=D1=81=D1=80, 13 =D0=BC=D0=B0=D1=8F 2020 =D0=B3. =D0=B2 20:32, Alex Benn=C3=
=A9e <alex.bennee@linaro.org>:

> Based on the original testcase by Nikolay Igotti.
>
> Message-ID: <CAEme+7GLKg_dNsHizzTKDymX9HyD+Ph2iZ=3D
> WKhOw2XG+zhViXg@mail.gmail.com>
> Cc: Nikolay Igotti <igotti@gmail.com>
> [Nikolay can we have your signed of by to add the testcase?]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/multiarch/threadcount.c   | 62 +++++++++++++++++++++++++++++
>  tests/tcg/multiarch/Makefile.target |  2 +
>  2 files changed, 64 insertions(+)
>  create mode 100644 tests/tcg/multiarch/threadcount.c
>
> diff --git a/tests/tcg/multiarch/threadcount.c
> b/tests/tcg/multiarch/threadcount.c
> new file mode 100644
> index 00000000000..546dd90eeb2
> --- /dev/null
> +++ b/tests/tcg/multiarch/threadcount.c
> @@ -0,0 +1,62 @@
> +/*
> + * Thread Exerciser
> + *
> + * Unlike testthread which is mainly concerned about testing thread
> + * semantics this test is used to exercise the thread creation and
> + * accounting. A version of this test found a problem with clashing
> + * cpu_indexes which caused a break in plugin handling.
> + *
> + * Based on the original test case by Nikolay Igotti.
> + *
> + * Copyright (c) 2020 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <pthread.h>
> +
> +int max_threads =3D 10;
> +
> +typedef struct {
> +    int delay;
> +} ThreadArg;
> +
> +static void *thread_fn(void* varg)  {
> +    ThreadArg* arg =3D varg;
> +    usleep(arg->delay);
> +    free(arg);
> +    return NULL;
> +}
> +
> +int main(int argc, char **argv) {
> +    int i;
> +    pthread_t *threads;
> +
> +    if (argc > 1) {
> +        max_threads =3D atoi(argv[1]);
> +    }
> +    threads =3D calloc(sizeof(pthread_t), max_threads);
> +
> +    for (i =3D 0; i < max_threads; i++) {
> +        ThreadArg* arg =3D calloc(sizeof(ThreadArg), 1);
> +        arg->delay =3D i * 100;
> +        pthread_create(threads + i, NULL, thread_fn, arg);
> +    }
> +
> +    printf("Created %d threads\n", max_threads);
> +
> +    /* sleep until roughly half the threads have "finished" */
> +    usleep(max_threads * 50);
> +
> +    for (i =3D 0; i < max_threads; i++) {
> +        pthread_join(threads[i], NULL);
> +    }
> +
> +    printf("Done\n");
> +
> +    return 0;
> +}
> diff --git a/tests/tcg/multiarch/Makefile.target
> b/tests/tcg/multiarch/Makefile.target
> index 51fb75ecfdd..cb49cc9ccb2 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -28,6 +28,8 @@ run-float_%: float_%
>
>  testthread: LDFLAGS+=3D-lpthread
>
> +threadcount: LDFLAGS+=3D-lpthread
> +
>  # We define the runner for test-mmap after the individual
>  # architectures have defined their supported pages sizes. If no
>  # additional page sizes are defined we only run the default test.
> --
> 2.20.1
>
>

--00000000000000d85905a5b5259f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">Sure, use it for anything.</div></div><div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 1=
3 =D0=BC=D0=B0=D1=8F 2020 =D0=B3. =D0=B2 20:32, Alex Benn=C3=A9e &lt;<a hre=
f=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt;:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">Based on the original testcase by Nikolay =
Igotti.<br>
<br>
Message-ID: &lt;CAEme+7GLKg_dNsHizzTKDymX9HyD+Ph2iZ=3D<a href=3D"mailto:WKh=
Ow2XG%2BzhViXg@mail.gmail.com" target=3D"_blank">WKhOw2XG+zhViXg@mail.gmail=
.com</a>&gt;<br>
Cc: Nikolay Igotti &lt;<a href=3D"mailto:igotti@gmail.com" target=3D"_blank=
">igotti@gmail.com</a>&gt;<br>
[Nikolay can we have your signed of by to add the testcase?]<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
---<br>
=C2=A0tests/tcg/multiarch/threadcount.c=C2=A0 =C2=A0| 62 ++++++++++++++++++=
+++++++++++<br>
=C2=A0tests/tcg/multiarch/Makefile.target |=C2=A0 2 +<br>
=C2=A02 files changed, 64 insertions(+)<br>
=C2=A0create mode 100644 tests/tcg/multiarch/threadcount.c<br>
<br>
diff --git a/tests/tcg/multiarch/threadcount.c b/tests/tcg/multiarch/thread=
count.c<br>
new file mode 100644<br>
index 00000000000..546dd90eeb2<br>
--- /dev/null<br>
+++ b/tests/tcg/multiarch/threadcount.c<br>
@@ -0,0 +1,62 @@<br>
+/*<br>
+ * Thread Exerciser<br>
+ *<br>
+ * Unlike testthread which is mainly concerned about testing thread<br>
+ * semantics this test is used to exercise the thread creation and<br>
+ * accounting. A version of this test found a problem with clashing<br>
+ * cpu_indexes which caused a break in plugin handling.<br>
+ *<br>
+ * Based on the original test case by Nikolay Igotti.<br>
+ *<br>
+ * Copyright (c) 2020 Linaro Ltd<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &lt;stdint.h&gt;<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+#include &lt;pthread.h&gt;<br>
+<br>
+int max_threads =3D 10;<br>
+<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 int delay;<br>
+} ThreadArg;<br>
+<br>
+static void *thread_fn(void* varg)=C2=A0 {<br>
+=C2=A0 =C2=A0 ThreadArg* arg =3D varg;<br>
+=C2=A0 =C2=A0 usleep(arg-&gt;delay);<br>
+=C2=A0 =C2=A0 free(arg);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+int main(int argc, char **argv) {<br>
+=C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 pthread_t *threads;<br>
+<br>
+=C2=A0 =C2=A0 if (argc &gt; 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_threads =3D atoi(argv[1]);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 threads =3D calloc(sizeof(pthread_t), max_threads);<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; max_threads; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ThreadArg* arg =3D calloc(sizeof(ThreadArg), 1=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arg-&gt;delay =3D i * 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_create(threads + i, NULL, thread_fn, a=
rg);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 printf(&quot;Created %d threads\n&quot;, max_threads);<br>
+<br>
+=C2=A0 =C2=A0 /* sleep until roughly half the threads have &quot;finished&=
quot; */<br>
+=C2=A0 =C2=A0 usleep(max_threads * 50);<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; max_threads; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_join(threads[i], NULL);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 printf(&quot;Done\n&quot;);<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Make=
file.target<br>
index 51fb75ecfdd..cb49cc9ccb2 100644<br>
--- a/tests/tcg/multiarch/Makefile.target<br>
+++ b/tests/tcg/multiarch/Makefile.target<br>
@@ -28,6 +28,8 @@ run-float_%: float_%<br>
<br>
=C2=A0testthread: LDFLAGS+=3D-lpthread<br>
<br>
+threadcount: LDFLAGS+=3D-lpthread<br>
+<br>
=C2=A0# We define the runner for test-mmap after the individual<br>
=C2=A0# architectures have defined their supported pages sizes. If no<br>
=C2=A0# additional page sizes are defined we only run the default test.<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div></div>

--00000000000000d85905a5b5259f--

