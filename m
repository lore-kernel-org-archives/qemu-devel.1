Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB65EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C6921556
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvKIa7Q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C6921556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG3tu-0004nY-Pn
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG3t6-0003ma-MW; Wed, 09 Sep 2020 13:28:04 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG3t4-0001Q2-QC; Wed, 09 Sep 2020 13:28:04 -0400
Received: by mail-lj1-x243.google.com with SMTP id a22so4565501ljp.13;
 Wed, 09 Sep 2020 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=RwgBRnPlh/MQohEyO0yaWpWbyXHSUxrPm0nMPESEb8o=;
 b=jvKIa7Q4lvRx46LQNjxHmMZAC6IyD0nTHYKJkyv95IKLsmHeplurt4+M4knG4c2RX3
 lp/hD+S/jssEMmYw+dRFuR5YHurFIsRHoDra3CEy7UhzahgUY9ZAbpkk8fbGv6e63Vpe
 PmiyGfIhbu6WEe4G0nQa2vhzhGiNrk8v0/QAlxC6HUQw762DyXJDUhPMsw6UbA6eO5TK
 j9utjpbIT0rLjzViywsQEZsgvJ15Ns7xhoEwA1cS4HqNQlpKVzjtVc3G5Zzy6ROGKeNy
 BYa3ghLOUUqVuiNdE253oxPN8qyCxw9p+eDLTbauscZiagcaYt8lr/dGtHC1dduKCJz/
 ipKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=RwgBRnPlh/MQohEyO0yaWpWbyXHSUxrPm0nMPESEb8o=;
 b=JzAiGZC+PgkrXoYTNgfyulmPOSIYwHJKfrhR+yQGZZndz2Ldtjy5bxhWH3i1+ZQoFb
 AS8s8pub4rdGfbEZ4HM4QoA/V/6USVziGGQqfk6VbBdrM1nzeqE/5jFBJuZZ/OAyaomX
 /SZ4EJJnhFXhRKERh2ZBGly8biFjjMHVijGBeN0tvJmPcjIhaElqt9r1tt0OzyrDSOXU
 xhHkKYu6X42/7HzR6y1A8NZudm2U/uEQQXmt3Rs/UoTjYkD0k5zpWLo121eax0J+28ZX
 02PRF0WOBQaduzCb/q/pbvzb+TPHXqo08tUF00boQzcAlo4eQmZcfD8kE/4/xPvVV7p3
 /OfA==
X-Gm-Message-State: AOAM530N1NsmKAWubcOm6AHPzVuufyftMoyx7fmY9ZAYUgFNrK2yYpGu
 mRaulEouWLFU3XKKLdJa9F2MRE0MKc8PzniuwOg=
X-Google-Smtp-Source: ABdhPJz+AI8teYrnhrmP5/1oxxQgctEVZUW4Vz86vFld7a8xQiYnlMkKRZ9jnk3V7Ac2LAqbwqhGUwxQVSQzEjUNdbY=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr2600141ljj.447.1599672480136; 
 Wed, 09 Sep 2020 10:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200908151052.713-1-luoyonggang@gmail.com>
 <20200908151052.713-3-luoyonggang@gmail.com>
 <20200909084107.GE12090@stefanha-x1.localdomain>
 <ef674b21-cdad-9aea-662e-315006438ed4@redhat.com>
In-Reply-To: <ef674b21-cdad-9aea-662e-315006438ed4@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 10 Sep 2020 01:27:47 +0800
Message-ID: <CAE2XoE8K6OHBm2DnRQEGjrMFhKU-BngSzh2vjYH5c+Q-2eo9kg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] rcu: add uninit destructor for rcu
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ef82de05aee4c5af"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
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
 Daniel Brodsky <dnbrdsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ef82de05aee4c5af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 1:23 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 09/09/20 10:41, Stefan Hajnoczi wrote:
> > On Tue, Sep 08, 2020 at 11:10:52PM +0800, Yonggang Luo wrote:
> >> This is necessary if the pending  rcu calls are closing and removing
> >> temp files. This also provide a function
> >> void rcu_wait_finished(void);
> >> to fixes test-logging.c test failure on msys2/mingw.
> >> On windows if the file doesn't closed, you can not remove it.
> >>
> >> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >> ---
> >>  include/qemu/rcu.h   |  5 +++++
> >>  tests/test-logging.c |  2 ++
> >>  util/rcu.c           | 37 ++++++++++++++++++++++++++++++++++++-
> >>  3 files changed, 43 insertions(+), 1 deletion(-)
> > Can the new drain_call_rcu() function be used? Maxim recently posted th=
e
> > following patch:
> >
> https://patchew.org/QEMU/20200831150124.206267-1-mlevitsk@redhat.com/2020=
0831150124.206267-3-mlevitsk@redhat.com/
> >
> > Whether drain_call_rcu() or rcu_wait_finished() is used, please include
> > a comment in the code that documents why the wait is necessary. For
> > example, "qemu_log_close() uses RCU for its FILE pointer but Windows
> > cannot remove open files, so we need to wait for RCU here".
> >
> > Another option is to wait for RCU inside qemu_log_close() so that
> > callers don't need to worry about this implementation detail:
> >
> >   #ifdef _WIN32
> >   /* Windows cannot remove open files so we need to wait for RCU here *=
/
> >   drain_call_rcu();
> >   #endif
> >
>
> In this case even synchronize_rcu() should be okay.
>
> Tried and not working.

> Paolo
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ef82de05aee4c5af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 10, 2020 at 1:23 AM Paolo=
 Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 0=
9/09/20 10:41, Stefan Hajnoczi wrote:<br>
&gt; On Tue, Sep 08, 2020 at 11:10:52PM +0800, Yonggang Luo wrote:<br>
&gt;&gt; This is necessary if the pending=C2=A0 rcu calls are closing and r=
emoving<br>
&gt;&gt; temp files. This also provide a function<br>
&gt;&gt; void rcu_wait_finished(void);<br>
&gt;&gt; to fixes test-logging.c test failure on msys2/mingw.<br>
&gt;&gt; On windows if the file doesn&#39;t closed, you can not remove it.<=
br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmai=
l.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 include/qemu/rcu.h=C2=A0 =C2=A0|=C2=A0 5 +++++<br>
&gt;&gt;=C2=A0 tests/test-logging.c |=C2=A0 2 ++<br>
&gt;&gt;=C2=A0 util/rcu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 37 ++++=
++++++++++++++++++++++++++++++++-<br>
&gt;&gt;=C2=A0 3 files changed, 43 insertions(+), 1 deletion(-)<br>
&gt; Can the new drain_call_rcu() function be used? Maxim recently posted t=
he<br>
&gt; following patch:<br>
&gt; <a href=3D"https://patchew.org/QEMU/20200831150124.206267-1-mlevitsk@r=
edhat.com/20200831150124.206267-3-mlevitsk@redhat.com/" rel=3D"noreferrer" =
target=3D"_blank">https://patchew.org/QEMU/20200831150124.206267-1-mlevitsk=
@redhat.com/20200831150124.206267-3-mlevitsk@redhat.com/</a><br>
&gt; <br>
&gt; Whether drain_call_rcu() or rcu_wait_finished() is used, please includ=
e<br>
&gt; a comment in the code that documents why the wait is necessary. For<br=
>
&gt; example, &quot;qemu_log_close() uses RCU for its FILE pointer but Wind=
ows<br>
&gt; cannot remove open files, so we need to wait for RCU here&quot;.<br>
&gt; <br>
&gt; Another option is to wait for RCU inside qemu_log_close() so that<br>
&gt; callers don&#39;t need to worry about this implementation detail:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0#ifdef _WIN32<br>
&gt;=C2=A0 =C2=A0/* Windows cannot remove open files so we need to wait for=
 RCU here */<br>
&gt;=C2=A0 =C2=A0drain_call_rcu();<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; <br>
<br>
In this case even synchronize_rcu() should be okay.<br>
<br></blockquote><div>Tried and not working.=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
Paolo<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000ef82de05aee4c5af--

