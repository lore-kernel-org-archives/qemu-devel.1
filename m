Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AE7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEE720709
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b75EIUiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEE720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k89dK-0006hT-HZ
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 17:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k89a3-00029O-32
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:55:43 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k89a0-0007n7-H2
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:55:42 -0400
Received: by mail-pf1-x443.google.com with SMTP id u128so10624600pfb.6
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=voukceu52GCuUpJK9K5QZj3RNlzUU+7F68nNLCZ4v7A=;
 b=b75EIUiRaLcKkw6dEyhqu/qDdoSN0qJCtKjtFMQ6GhqO5Oz4KkfUYC5LKn4hTgKPE+
 uyQIKGACkm6R+qPnKntrjjHdjSsIgVbFB10AuDCmXk8FhOGfNLej3wL8B16o1L6Ogs74
 +IEPKQC14pucAFCaku9HVK2CcvWt5tDsge85LsC9eY3zn4IC6r+dLH+Ef5PfMHvL+lTc
 IZoFGevItKo0OdlMJrIa8tNyK3o0LolBI9YSCxTxlodb6et6MQSkfOjZTUJDu0wr5rMd
 NoFeUxba/RtcT7vPbWSt7ZgbecMj9ziLv844V+d2yDwNbA+yQYGlqPV5dae5Wp+gz6Kw
 i7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=voukceu52GCuUpJK9K5QZj3RNlzUU+7F68nNLCZ4v7A=;
 b=d4EuEn8xNA1wM3VaKf52C8lbkesv6CPmSXmMBnJHZICZHarNe+/ZDrNKllWQkE3bqk
 UVh9ayXq7NQSTZY54+yfQ4zcuNjiEzV+sLNh16UBACi5vIVM+Ri5IyvKLzyiOOko255L
 voSTngoTnLJXIT5aYC7OTN+F/5XQUbYVX/r6gcbYPyjp1nwnnifzP5K34OX24Ai9QqnL
 W/ABiXr0GZge6kp3CmPPQO83kxCLbkBKhBpW6++hCsbR+gYJaxB2HaYahVfWPt46jbsV
 q09Bl5RILuQirAQoJp3AGbcmhWOauT9cx/huN8sCQ7Mehf3wR/u/dIXCz6USSLXu4MTj
 /TIw==
X-Gm-Message-State: AOAM532PzOjC9ZB6HVv7JLA9u2g3sj22iopkKL9wr2s6Xz1uUkE9xDI9
 G4Hz0ozSaHpfXzCqZUVJd/ew1AlUr3QoUl4+iAs=
X-Google-Smtp-Source: ABdhPJwHkomWPztpfx+1MpV7I4iNHrdDKhJxI0FHSYJ5xNbfpoCE70KJSO2OobtYhtgWv3QhMMPOIa9E/f9c3UBeRYc=
X-Received: by 2002:a63:5b0f:: with SMTP id p15mr13506512pgb.299.1597787738674; 
 Tue, 18 Aug 2020 14:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200817235712.10957-1-aladjev.andrew@gmail.com>
 <20200817235712.10957-2-aladjev.andrew@gmail.com>
 <3cba9ec5-5041-f036-524f-c207cede4346@vivier.eu>
In-Reply-To: <3cba9ec5-5041-f036-524f-c207cede4346@vivier.eu>
From: =?UTF-8?B?0JDQvdC00YDQtdC5INCQ0LvQsNC00YzQtdCy?=
 <aladjev.andrew@gmail.com>
Date: Wed, 19 Aug 2020 00:55:27 +0300
Message-ID: <CAMw0szKUrwvD6LY1cMbHgnwVChZebJ=Mk5FwAe5TY9u_4w1=0w@mail.gmail.com>
Subject: Re: [PATCH 2/3] linux user: moving is proc functions to separate file
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000971ca805ad2df237"
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=aladjev.andrew@gmail.com; helo=mail-pf1-x443.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000971ca805ad2df237
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, we may store these functions in syscall.c.

=D0=B2=D1=82, 18 =D0=B0=D0=B2=D0=B3. 2020 =D0=B3. =D0=B2 18:56, Laurent Viv=
ier <laurent@vivier.eu>:

> Le 18/08/2020 =C3=A0 01:57, Andrew Aladjev a =C3=A9crit :
> > Signed-off-by: Andrew Aladjev <aladjev.andrew@gmail.com>
> > ---
> >  linux-user/Makefile.objs  |  5 +++--
> >  linux-user/syscall.c      | 33 +--------------------------------
> >  linux-user/syscall_proc.c | 32 ++++++++++++++++++++++++++++++++
> >  linux-user/syscall_proc.h |  7 +++++++
> >  4 files changed, 43 insertions(+), 34 deletions(-)
> >  create mode 100644 linux-user/syscall_proc.c
> >  create mode 100644 linux-user/syscall_proc.h
> >
> > diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
> > index 1940910a73..20f8828b86 100644
> > --- a/linux-user/Makefile.objs
> > +++ b/linux-user/Makefile.objs
> > @@ -1,7 +1,8 @@
> >  obj-y =3D main.o syscall.o strace.o mmap.o signal.o \
> >       elfload.o linuxload.o uaccess.o uname.o \
> > -     safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
> > -        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
> > +     safe-syscall.o syscall_proc.o \
> > +     $(TARGET_ABI_DIR)/cpu_loop.o $(TARGET_ABI_DIR)/signal.o \
> > +        exit.o fd-trans.o
> >
>
> I think this will collide with Paolo's meson pull request.
>
> >  obj-$(TARGET_HAS_BFLT) +=3D flatload.o
> >  obj-$(TARGET_I386) +=3D vm86.o
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 5741c72733..01edc9b68d 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -125,6 +125,7 @@
> >  #include "qapi/error.h"
> >  #include "fd-trans.h"
> >  #include "tcg/tcg.h"
> > +#include "syscall_proc.h"
> >
> >  #ifndef CLONE_IO
> >  #define CLONE_IO                0x80000000      /* Clone io context */
> > @@ -7482,38 +7483,6 @@ static int open_self_auxv(void *cpu_env, int fd)
> >      return 0;
> >  }
> >
> > -static int is_proc_myself(const char *filename, const char *entry)
> > -{
> > -    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
> > -        filename +=3D strlen("/proc/");
> > -        if (!strncmp(filename, "self/", strlen("self/"))) {
> > -            filename +=3D strlen("self/");
> > -        } else if (*filename >=3D '1' && *filename <=3D '9') {
> > -            char myself[80];
> > -            snprintf(myself, sizeof(myself), "%d/", getpid());
> > -            if (!strncmp(filename, myself, strlen(myself))) {
> > -                filename +=3D strlen(myself);
> > -            } else {
> > -                return 0;
> > -            }
> > -        } else {
> > -            return 0;
> > -        }
> > -        if (!strcmp(filename, entry)) {
> > -            return 1;
> > -        }
> > -    }
> > -    return 0;
> > -}
> > -
> > -#if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGENDIAN)=
 ||
> \
> > -    defined(TARGET_SPARC) || defined(TARGET_M68K) ||
> defined(TARGET_HPPA)
> > -static int is_proc(const char *filename, const char *entry)
> > -{
> > -    return strcmp(filename, entry) =3D=3D 0;
> > -}
> > -#endif
> > -
> >  #if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGENDIAN)
> >  static int open_net_route(void *cpu_env, int fd)
> >  {
> > diff --git a/linux-user/syscall_proc.c b/linux-user/syscall_proc.c
> > new file mode 100644
> > index 0000000000..34051a8e6b
> > --- /dev/null
> > +++ b/linux-user/syscall_proc.c
> > @@ -0,0 +1,32 @@
> > +#include "qemu/osdep.h"
> > +
> > +#include "syscall_proc.h"
> > +
> > +int is_proc_myself(const char *filename, const char *entry)
> > +{
> > +    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
> > +        filename +=3D strlen("/proc/");
> > +        if (!strncmp(filename, "self/", strlen("self/"))) {
> > +            filename +=3D strlen("self/");
> > +        } else if (*filename >=3D '1' && *filename <=3D '9') {
> > +            char myself[80];
> > +            snprintf(myself, sizeof(myself), "%d/", getpid());
> > +            if (!strncmp(filename, myself, strlen(myself))) {
> > +                filename +=3D strlen(myself);
> > +            } else {
> > +                return 0;
> > +            }
> > +        } else {
> > +            return 0;
> > +        }
> > +        if (!strcmp(filename, entry)) {
> > +            return 1;
> > +        }
> > +    }
> > +    return 0;
> > +}
> > +
> > +int is_proc(const char *filename, const char *entry)
> > +{
> > +    return strcmp(filename, entry) =3D=3D 0;
> > +}
> > diff --git a/linux-user/syscall_proc.h b/linux-user/syscall_proc.h
> > new file mode 100644
> > index 0000000000..3098af931f
> > --- /dev/null
> > +++ b/linux-user/syscall_proc.h
> > @@ -0,0 +1,7 @@
> > +#ifndef SYSCALL_PROC_H
> > +#define SYSCALL_PROC_H
> > +
> > +int is_proc(const char *filename, const char *entry);
> > +int is_proc_myself(const char *filename, const char *entry);
> > +
> > +#endif
> >
>
> Please add a "SPDX-License-Identifier: GPL-2.0-or-later" header in the
> new files.
>
> Thanks,
> Laurent
>
>
>
>
>

--000000000000971ca805ad2df237
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ok, we may store these functions in syscall.c.</div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=82=
, 18 =D0=B0=D0=B2=D0=B3. 2020 =D0=B3. =D0=B2 18:56, Laurent Vivier &lt;<a h=
ref=3D"mailto:laurent@vivier.eu">laurent@vivier.eu</a>&gt;:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Le 18/08/2020 =C3=A0 01:57, And=
rew Aladjev a =C3=A9crit=C2=A0:<br>
&gt; Signed-off-by: Andrew Aladjev &lt;<a href=3D"mailto:aladjev.andrew@gma=
il.com" target=3D"_blank">aladjev.andrew@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 linux-user/Makefile.objs=C2=A0 |=C2=A0 5 +++--<br>
&gt;=C2=A0 linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 | 33 +-----------------=
---------------<br>
&gt;=C2=A0 linux-user/syscall_proc.c | 32 ++++++++++++++++++++++++++++++++<=
br>
&gt;=C2=A0 linux-user/syscall_proc.h |=C2=A0 7 +++++++<br>
&gt;=C2=A0 4 files changed, 43 insertions(+), 34 deletions(-)<br>
&gt;=C2=A0 create mode 100644 linux-user/syscall_proc.c<br>
&gt;=C2=A0 create mode 100644 linux-user/syscall_proc.h<br>
&gt; <br>
&gt; diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs<br>
&gt; index 1940910a73..20f8828b86 100644<br>
&gt; --- a/linux-user/Makefile.objs<br>
&gt; +++ b/linux-user/Makefile.objs<br>
&gt; @@ -1,7 +1,8 @@<br>
&gt;=C2=A0 obj-y =3D main.o syscall.o strace.o mmap.o signal.o \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0elfload.o linuxload.o uaccess.o uname.o \<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0safe-syscall.o $(TARGET_ABI_DIR)/signal.o \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-tr=
ans.o<br>
&gt; +=C2=A0 =C2=A0 =C2=A0safe-syscall.o syscall_proc.o \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0$(TARGET_ABI_DIR)/cpu_loop.o $(TARGET_ABI_DIR)/si=
gnal.o \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit.o fd-trans.o<br>
&gt;=C2=A0 <br>
<br>
I think this will collide with Paolo&#39;s meson pull request.<br>
<br>
&gt;=C2=A0 obj-$(TARGET_HAS_BFLT) +=3D flatload.o<br>
&gt;=C2=A0 obj-$(TARGET_I386) +=3D vm86.o<br>
&gt; diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
&gt; index 5741c72733..01edc9b68d 100644<br>
&gt; --- a/linux-user/syscall.c<br>
&gt; +++ b/linux-user/syscall.c<br>
&gt; @@ -125,6 +125,7 @@<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;fd-trans.h&quot;<br>
&gt;=C2=A0 #include &quot;tcg/tcg.h&quot;<br>
&gt; +#include &quot;syscall_proc.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #ifndef CLONE_IO<br>
&gt;=C2=A0 #define CLONE_IO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x80000000=C2=A0 =C2=A0 =C2=A0 /* Clone io context */<br>
&gt; @@ -7482,38 +7483,6 @@ static int open_self_auxv(void *cpu_env, int fd=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static int is_proc_myself(const char *filename, const char *entry)<br=
>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 if (!strncmp(filename, &quot;/proc/&quot;, strlen(&quot=
;/proc/&quot;))) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 filename +=3D strlen(&quot;/proc/&quot;);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strncmp(filename, &quot;self/&quot;,=
 strlen(&quot;self/&quot;))) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename +=3D strlen(&quot;=
self/&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (*filename &gt;=3D &#39;1&#39; =
&amp;&amp; *filename &lt;=3D &#39;9&#39;) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char myself[80];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(myself, sizeof(mys=
elf), &quot;%d/&quot;, getpid());<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strncmp(filename, myse=
lf, strlen(myself))) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename +=3D=
 strlen(myself);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strcmp(filename, entry)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt; -#if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGENDIAN=
) || \<br>
&gt; -=C2=A0 =C2=A0 defined(TARGET_SPARC) || defined(TARGET_M68K) || define=
d(TARGET_HPPA)<br>
&gt; -static int is_proc(const char *filename, const char *entry)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 return strcmp(filename, entry) =3D=3D 0;<br>
&gt; -}<br>
&gt; -#endif<br>
&gt; -<br>
&gt;=C2=A0 #if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGE=
NDIAN)<br>
&gt;=C2=A0 static int open_net_route(void *cpu_env, int fd)<br>
&gt;=C2=A0 {<br>
&gt; diff --git a/linux-user/syscall_proc.c b/linux-user/syscall_proc.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..34051a8e6b<br>
&gt; --- /dev/null<br>
&gt; +++ b/linux-user/syscall_proc.c<br>
&gt; @@ -0,0 +1,32 @@<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;syscall_proc.h&quot;<br>
&gt; +<br>
&gt; +int is_proc_myself(const char *filename, const char *entry)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (!strncmp(filename, &quot;/proc/&quot;, strlen(&quot=
;/proc/&quot;))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 filename +=3D strlen(&quot;/proc/&quot;);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strncmp(filename, &quot;self/&quot;,=
 strlen(&quot;self/&quot;))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename +=3D strlen(&quot;=
self/&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (*filename &gt;=3D &#39;1&#39; =
&amp;&amp; *filename &lt;=3D &#39;9&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char myself[80];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(myself, sizeof(mys=
elf), &quot;%d/&quot;, getpid());<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strncmp(filename, myse=
lf, strlen(myself))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename +=3D=
 strlen(myself);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strcmp(filename, entry)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int is_proc(const char *filename, const char *entry)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return strcmp(filename, entry) =3D=3D 0;<br>
&gt; +}<br>
&gt; diff --git a/linux-user/syscall_proc.h b/linux-user/syscall_proc.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..3098af931f<br>
&gt; --- /dev/null<br>
&gt; +++ b/linux-user/syscall_proc.h<br>
&gt; @@ -0,0 +1,7 @@<br>
&gt; +#ifndef SYSCALL_PROC_H<br>
&gt; +#define SYSCALL_PROC_H<br>
&gt; +<br>
&gt; +int is_proc(const char *filename, const char *entry);<br>
&gt; +int is_proc_myself(const char *filename, const char *entry);<br>
&gt; +<br>
&gt; +#endif<br>
&gt; <br>
<br>
Please add a &quot;SPDX-License-Identifier: GPL-2.0-or-later&quot; header i=
n the<br>
new files.<br>
<br>
Thanks,<br>
Laurent<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--000000000000971ca805ad2df237--

