Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AABC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C97206F4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7jBQyYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C97206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFxMa-00038d-Aq
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 06:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFxLr-0002aO-2i; Wed, 09 Sep 2020 06:29:19 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFxLo-0004oX-Pb; Wed, 09 Sep 2020 06:29:18 -0400
Received: by mail-lj1-x244.google.com with SMTP id u4so2783356ljd.10;
 Wed, 09 Sep 2020 03:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=fldaev8VsATYMtrpie1YrrCgeC0TFFGG550SEOm6/cc=;
 b=C7jBQyYt5676rhwjsHbj2eaos6RAz7YmT2DFb1XGffgTmc3PjN1exvLVdmwqxAeL8G
 AbZGu52OvZ6DJXaPV5u4OBDZYdX8YMo6dOq3GRc68vSIUivFdUUzNhmR507KwXwZHzZ4
 KgPzHHm1/dpQuC/Y7yCjdYd1fOgPauJXdhaACzV013RZeqYeNMC9/nvzMxtLPEg6ptsa
 BZyHeYAVBOCPgXHV0tsgsslk98sRYqD56I/qWabX5sU63Ls5I3HzgKqg6kVX5ISYfp1R
 Yt0FsLraIz5TyNXrSsVo/779EYvTzxG0qYszojITaUJq10YTgTs1QzevBy4Ejda+s+lt
 0exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=fldaev8VsATYMtrpie1YrrCgeC0TFFGG550SEOm6/cc=;
 b=YBr8NQh/J1RvBNkzvRjRh1DmO7/pFDUWB0yiwxuq4uWNDjhgsr2L/OjlzoyUUQ88a4
 uBnztcSaExVLdrbOYEHQBtbppGNJ/VZWnIdDZPLBzhrMf1C4g/Yx3j11DltAHOLNOOW8
 gHBd7uDuBqXlMVZLGgJFjjaNyWl1G9Wz1xeWs8wsxXwj9/gPze/pMHJqXVCsmAJw5jAb
 2Djk6ECosCGJtmYVBgb/Vdd7X0HY+p9SWhD0UXmAkFMERppl3GNk27w50VLcvwWlbynZ
 E6iuxiqH3OMgM40GAgkVDXxKAroQJwAXm0ig3yhuznMFa0EVNeI72+y7WmJoXm6rjT+e
 CJVw==
X-Gm-Message-State: AOAM530ZPMV8zP7d4VB71Xj9QyIhHDvqcv55jeUGcBLJtxG9zEAMcKxM
 6Q01LHve/NW+WMB1LKWsOI6YOdj7TrafZ9D+3PU=
X-Google-Smtp-Source: ABdhPJysuRd2OXrQrHaJel6xLYX9pIzzUvrP+G43fpS98PR3sd49e/uG3O8GiT/75cc7zXOhC8hmEypOnV5Ipzju4c4=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr1647339ljj.447.1599647354294; 
 Wed, 09 Sep 2020 03:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200908151052.713-1-luoyonggang@gmail.com>
 <20200908151052.713-3-luoyonggang@gmail.com>
 <20200909084107.GE12090@stefanha-x1.localdomain>
In-Reply-To: <20200909084107.GE12090@stefanha-x1.localdomain>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 18:29:03 +0800
Message-ID: <CAE2XoE9WjZGLg-FzWDGT7Opjm=xk00d65Nhiiyj7PzCVcznyoA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] rcu: add uninit destructor for rcu
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005197b305aedeec24"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x244.google.com
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
Cc: Juan Quintela <quintela@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 qemu-level <qemu-devel@nongnu.org>, Maxim Levitsky <mlevitsk@redhat.com>,
 Daniel Brodsky <dnbrdsky@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005197b305aedeec24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 4:41 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Tue, Sep 08, 2020 at 11:10:52PM +0800, Yonggang Luo wrote:
> > This is necessary if the pending  rcu calls are closing and removing
> > temp files. This also provide a function
> > void rcu_wait_finished(void);
> > to fixes test-logging.c test failure on msys2/mingw.
> > On windows if the file doesn't closed, you can not remove it.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  include/qemu/rcu.h   |  5 +++++
> >  tests/test-logging.c |  2 ++
> >  util/rcu.c           | 37 ++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 43 insertions(+), 1 deletion(-)
>
> Can the new drain_call_rcu() function be used? Maxim recently posted the
> following patch:
>
> https://patchew.org/QEMU/20200831150124.206267-1-mlevitsk@redhat.com/2020=
0831150124.206267-3-mlevitsk@redhat.com/
>
> Whether drain_call_rcu() or rcu_wait_finished() is used, please include
> a comment in the code that documents why the wait is necessary. For
> example, "qemu_log_close() uses RCU for its FILE pointer but Windows
> cannot remove open files, so we need to wait for RCU here".
>
> Another option is to wait for RCU inside qemu_log_close() so that
> callers don't need to worry about this implementation detail:
>
>   #ifdef _WIN32
>   /* Windows cannot remove open files so we need to wait for RCU here */
>   drain_call_rcu();
>
once  drain_call_rcu  function are merged, I will convert the patch to use
it.

>   #endif
>
> > diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> > index 570aa603eb..dd0a92c1d0 100644
> > --- a/include/qemu/rcu.h
> > +++ b/include/qemu/rcu.h
> > @@ -124,6 +124,11 @@ extern void rcu_unregister_thread(void);
> >  extern void rcu_enable_atfork(void);
> >  extern void rcu_disable_atfork(void);
> >
> > +/*
> > + * Wait all rcu call executed and exit the rcu thread.
> > + */
> > +extern void rcu_wait_finished(void);
> > +
> >  struct rcu_head;
> >  typedef void RCUCBFunc(struct rcu_head *head);
> >
> > diff --git a/tests/test-logging.c b/tests/test-logging.c
> > index 957f6c08cd..7a5b59f4a5 100644
> > --- a/tests/test-logging.c
> > +++ b/tests/test-logging.c
> > @@ -210,6 +210,8 @@ int main(int argc, char **argv)
> >                           tmp_path, test_logfile_lock);
> >
> >      rc =3D g_test_run();
> > +    qemu_log_close();
> > +    rcu_wait_finished();
> >
> >      rmdir_full(tmp_path);
> >      g_free(tmp_path);
> > diff --git a/util/rcu.c b/util/rcu.c
> > index 60a37f72c3..43367988b9 100644
> > --- a/util/rcu.c
> > +++ b/util/rcu.c
> > @@ -308,10 +308,20 @@ void rcu_unregister_thread(void)
> >      qemu_mutex_unlock(&rcu_registry_lock);
> >  }
> >
> > +typedef struct QemuRcuMessage {
> > +    struct rcu_head rcu;
> > +    void *message;
> > +} QemuRcuMessage;
> > +
> > +static int rcu_thread_exit_called =3D 0;
> > +static int rcu_thread_exited =3D 0;
> > +static QemuRcuMessage rcu_thread_message;
> > +
> >  static void rcu_init_complete(void)
> >  {
> >      QemuThread thread;
> > -
> > +    atomic_mb_set(&rcu_thread_exit_called, 0);
> > +    atomic_mb_set(&rcu_thread_exited, 0);
> >      qemu_mutex_init(&rcu_registry_lock);
> >      qemu_mutex_init(&rcu_sync_lock);
> >      qemu_event_init(&rcu_gp_event, true);
> > @@ -327,6 +337,26 @@ static void rcu_init_complete(void)
> >      rcu_register_thread();
> >  }
> >
> > +static void rcu_thread_exit(QemuRcuMessage *param)
> > +{
> > +    atomic_mb_set((int*)param->message, 1);
> > +    qemu_thread_exit(NULL);
> > +}
> > +
> > +void rcu_wait_finished(void)
> > +{
> > +    if (atomic_xchg(&rcu_thread_exit_called, 1) =3D=3D 0)
> > +    {
> > +        rcu_thread_message.message =3D &rcu_thread_exited;
> > +        call_rcu(&rcu_thread_message, rcu_thread_exit, rcu);
> > +    }
> > +
> > +    while (atomic_mb_read(&rcu_thread_exited) =3D=3D 0)
> > +    {
> > +        g_usleep(10000);
> > +    }
> > +}
> > +
> >  static int atfork_depth =3D 1;
> >
> >  void rcu_enable_atfork(void)
> > @@ -379,3 +409,8 @@ static void __attribute__((__constructor__))
> rcu_init(void)
> >  #endif
> >      rcu_init_complete();
> >  }
> > +
> > +static void __attribute__((__destructor__)) rcu_uninit(void)
> > +{
> > +    rcu_wait_finished();
> > +}
> > --
> > 2.28.0.windows.1
> >
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000005197b305aedeec24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 4:41 PM Stefan=
 Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Tue, Sep 08, 2020 at 11:10:52PM +0800, Yonggang Luo wrote:<br>
&gt; This is necessary if the pending=C2=A0 rcu calls are closing and remov=
ing<br>
&gt; temp files. This also provide a function<br>
&gt; void rcu_wait_finished(void);<br>
&gt; to fixes test-logging.c test failure on msys2/mingw.<br>
&gt; On windows if the file doesn&#39;t closed, you can not remove it.<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/qemu/rcu.h=C2=A0 =C2=A0|=C2=A0 5 +++++<br>
&gt;=C2=A0 tests/test-logging.c |=C2=A0 2 ++<br>
&gt;=C2=A0 util/rcu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 37 ++++++++=
++++++++++++++++++++++++++++-<br>
&gt;=C2=A0 3 files changed, 43 insertions(+), 1 deletion(-)<br>
<br>
Can the new drain_call_rcu() function be used? Maxim recently posted the<br=
>
following patch:<br>
<a href=3D"https://patchew.org/QEMU/20200831150124.206267-1-mlevitsk@redhat=
.com/20200831150124.206267-3-mlevitsk@redhat.com/" rel=3D"noreferrer" targe=
t=3D"_blank">https://patchew.org/QEMU/20200831150124.206267-1-mlevitsk@redh=
at.com/20200831150124.206267-3-mlevitsk@redhat.com/</a><br>
<br>
Whether drain_call_rcu() or rcu_wait_finished() is used, please include<br>
a comment in the code that documents why the wait is necessary. For<br>
example, &quot;qemu_log_close() uses RCU for its FILE pointer but Windows<b=
r>
cannot remove open files, so we need to wait for RCU here&quot;.<br>
<br>
Another option is to wait for RCU inside qemu_log_close() so that<br>
callers don&#39;t need to worry about this implementation detail:<br>
<br>
=C2=A0 #ifdef _WIN32<br>
=C2=A0 /* Windows cannot remove open files so we need to wait for RCU here =
*/<br>
=C2=A0 drain_call_rcu();<br></blockquote><div>once=C2=A0

drain_call_rcu=C2=A0 function are merged, I will convert the patch to use i=
t.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 #endif<br>
<br>
&gt; diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h<br>
&gt; index 570aa603eb..dd0a92c1d0 100644<br>
&gt; --- a/include/qemu/rcu.h<br>
&gt; +++ b/include/qemu/rcu.h<br>
&gt; @@ -124,6 +124,11 @@ extern void rcu_unregister_thread(void);<br>
&gt;=C2=A0 extern void rcu_enable_atfork(void);<br>
&gt;=C2=A0 extern void rcu_disable_atfork(void);<br>
&gt;=C2=A0 <br>
&gt; +/*<br>
&gt; + * Wait all rcu call executed and exit the rcu thread.<br>
&gt; + */<br>
&gt; +extern void rcu_wait_finished(void);<br>
&gt; +<br>
&gt;=C2=A0 struct rcu_head;<br>
&gt;=C2=A0 typedef void RCUCBFunc(struct rcu_head *head);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/test-logging.c b/tests/test-logging.c<br>
&gt; index 957f6c08cd..7a5b59f4a5 100644<br>
&gt; --- a/tests/test-logging.c<br>
&gt; +++ b/tests/test-logging.c<br>
&gt; @@ -210,6 +210,8 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp_path, test_logfile_lock);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 rc =3D g_test_run();<br>
&gt; +=C2=A0 =C2=A0 qemu_log_close();<br>
&gt; +=C2=A0 =C2=A0 rcu_wait_finished();<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 rmdir_full(tmp_path);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(tmp_path);<br>
&gt; diff --git a/util/rcu.c b/util/rcu.c<br>
&gt; index 60a37f72c3..43367988b9 100644<br>
&gt; --- a/util/rcu.c<br>
&gt; +++ b/util/rcu.c<br>
&gt; @@ -308,10 +308,20 @@ void rcu_unregister_thread(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock(&amp;rcu_registry_lock);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +typedef struct QemuRcuMessage {<br>
&gt; +=C2=A0 =C2=A0 struct rcu_head rcu;<br>
&gt; +=C2=A0 =C2=A0 void *message;<br>
&gt; +} QemuRcuMessage;<br>
&gt; +<br>
&gt; +static int rcu_thread_exit_called =3D 0;<br>
&gt; +static int rcu_thread_exited =3D 0;<br>
&gt; +static QemuRcuMessage rcu_thread_message;<br>
&gt; +<br>
&gt;=C2=A0 static void rcu_init_complete(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuThread thread;<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 atomic_mb_set(&amp;rcu_thread_exit_called, 0);<br>
&gt; +=C2=A0 =C2=A0 atomic_mb_set(&amp;rcu_thread_exited, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_mutex_init(&amp;rcu_registry_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_mutex_init(&amp;rcu_sync_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_event_init(&amp;rcu_gp_event, true);<br>
&gt; @@ -327,6 +337,26 @@ static void rcu_init_complete(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 rcu_register_thread();<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void rcu_thread_exit(QemuRcuMessage *param)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 atomic_mb_set((int*)param-&gt;message, 1);<br>
&gt; +=C2=A0 =C2=A0 qemu_thread_exit(NULL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +void rcu_wait_finished(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (atomic_xchg(&amp;rcu_thread_exit_called, 1) =3D=3D =
0)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rcu_thread_message.message =3D &amp;rcu_t=
hread_exited;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 call_rcu(&amp;rcu_thread_message, rcu_thr=
ead_exit, rcu);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 while (atomic_mb_read(&amp;rcu_thread_exited) =3D=3D 0)=
<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_usleep(10000);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static int atfork_depth =3D 1;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void rcu_enable_atfork(void)<br>
&gt; @@ -379,3 +409,8 @@ static void __attribute__((__constructor__)) rcu_i=
nit(void)<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 rcu_init_complete();<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +static void __attribute__((__destructor__)) rcu_uninit(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 rcu_wait_finished();<br>
&gt; +}<br>
&gt; -- <br>
&gt; 2.28.0.windows.1<br>
&gt; <br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000005197b305aedeec24--

