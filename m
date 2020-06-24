Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00961C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C062D20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="KZoP2ilG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C062D20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2VI-0005Al-0h
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jo2Uh-0004m1-Nm
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:19:03 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jo2Uf-00009K-NY
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:19:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id o2so1967416wmh.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nx0SWlU3PgE6SxjZnSztqg/w6JPPXSoL4OgEoikf8zE=;
 b=KZoP2ilGVcu9fiQSIxgXk82Z31AJHXv//j0hnYApEyyXmiLyGwqOZna7Yq6WJSVE7b
 llrPEw+mrPxq7o+hsgR9sby4Md9egnMtmVRW649B8MfoLx/M6iN+lPoRw0Fob5JSeOUB
 L46dAK/5rttderSLzDFTTM5R/ReLqKpEJVY8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nx0SWlU3PgE6SxjZnSztqg/w6JPPXSoL4OgEoikf8zE=;
 b=OmrP9klUebtI0Rj7+P3DWaA3VcNfShKpboYgmXkIw1Q2VGqd53lwBJsEJoEKy/UiW8
 0HmERmHTuRCdtAu6drhcHLpnv4ISdwpQ77j44UzHKLAcAfQfyVhwsRO1Qd3zbImN4r3C
 2NIn0ElDW7e1mQuMBALcDWl51/HG9rirxUCOtDH70puaGG5ky1bIj3yKB2fJ8c6j2/ga
 VSxEcP952SIxYiF0D08uvluuw6GBZBYBo01NSXUgMfLj9naAewTW/9I2E08ZF89A890O
 bDE+iL5FhHku9aS04uVTKffOsExbprAeEoGR3c+ZQoUu8OU8k7ULTF4wsWPZ/s8LZelg
 dFGQ==
X-Gm-Message-State: AOAM532Sx9KXT2w7j/YT8UwmOMkeHcmHU//tJQw5PfrscoIIK8uZwx3e
 omsMzDeiGDq5edwyeHCLacSIHhsPq3CGy4tSUjjrcQ==
X-Google-Smtp-Source: ABdhPJwNHRyQp5x11vWncnyeMNiMceUcVCjSJ9/F3sR0kdI2mNVm9T6lV7yoxUxCXoTo5p/3IGqodji6FPJWwNSxOS8=
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr12985558wmh.166.1592993940196; 
 Wed, 24 Jun 2020 03:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200624100054.7168-1-dereksu@qnap.com>
 <c0bcaab9-9a9f-e8a7-8ae7-e886a44a968e@redhat.com>
In-Reply-To: <c0bcaab9-9a9f-e8a7-8ae7-e886a44a968e@redhat.com>
From: Derek Su <dereksu@qnap.com>
Date: Wed, 24 Jun 2020 18:18:49 +0800
Message-ID: <CAKEOLWXBq2gekxOSMKhioWa07QLw2kkirqzvyntmjw1nHgOpaw@mail.gmail.com>
Subject: Re: [PATCH v1] chardev/char-socket: fix double free of err after
 socket is disconnected
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ef621305a8d1cd52"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=dereksu@qnap.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: marcandre.lureau@redhat.com, lichun <lichun@ruijie.com.cn>,
 jwsu1986@gmail.com, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ef621305a8d1cd52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oops! Sorry, I dont=E2=80=99t notice this patch before.

Thanks.

Derek

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>=E6=96=BC 2020=E5=B9=B46=E6=
=9C=8824=E6=97=A5 =E9=80=B1=E4=B8=89=EF=BC=8C=E4=B8=8B=E5=8D=886:12=E5=AF=
=AB=E9=81=93=EF=BC=9A

> On 6/24/20 12:00 PM, Derek Su wrote:
> > The err is freed in check_report_connect_error() conditionally,
> > calling error_free() directly may lead to a double-free bug.
>
> This seems the same issue Lichun is working on, right?
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg714709.html
>
> >
> > Signed-off-by: Derek Su <dereksu@qnap.com>
> > ---
> >  chardev/char-socket.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index afebeec5c3..a009bed5ee 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -1086,7 +1086,11 @@ static void qemu_chr_socket_connected(QIOTask
> *task, void *opaque)
> >      if (qio_task_propagate_error(task, &err)) {
> >          tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
> >          check_report_connect_error(chr, err);
> > -        error_free(err);
> > +
> > +        if (!s->connect_err_reported) {
> > +            error_free(err);
> > +        }
> > +
> >          goto cleanup;
> >      }
> >
> >
>
> --

Best regards,

Derek Su
QNAP Systems, Inc.
Email: dereksu@qnap.com
Tel: (+886)-2-2393-5152 ext. 15017
Address: 13F., No.56, Sec. 1, Xinsheng S. Rd., Zhongzheng Dist., Taipei
City, Taiwan

--000000000000ef621305a8d1cd52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><div dir=3D"auto">Oops! Sorry, I dont=E2=80=99t notice =
this patch before.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thank=
s.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Derek</div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu=
-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&=
gt;=E6=96=BC 2020=E5=B9=B46=E6=9C=8824=E6=97=A5 =E9=80=B1=E4=B8=89=EF=BC=8C=
=E4=B8=8B=E5=8D=886:12=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)"=
>On 6/24/20 12:00 PM, Derek Su wrote:<br>
&gt; The err is freed in check_report_connect_error() conditionally,<br>
&gt; calling error_free() directly may lead to a double-free bug.<br>
<br>
This seems the same issue Lichun is working on, right?<br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg714709.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-d=
evel@nongnu.org/msg714709.html</a><br>
<br>
&gt; <br>
&gt; Signed-off-by: Derek Su &lt;<a href=3D"mailto:dereksu@qnap.com" target=
=3D"_blank">dereksu@qnap.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 chardev/char-socket.c | 6 +++++-<br>
&gt;=C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/chardev/char-socket.c b/chardev/char-socket.c<br>
&gt; index afebeec5c3..a009bed5ee 100644<br>
&gt; --- a/chardev/char-socket.c<br>
&gt; +++ b/chardev/char-socket.c<br>
&gt; @@ -1086,7 +1086,11 @@ static void qemu_chr_socket_connected(QIOTask *=
task, void *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (qio_task_propagate_error(task, &amp;err)) {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcp_chr_change_state(s, TCP_CHARDEV_=
STATE_DISCONNECTED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check_report_connect_error(chr, err)=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(err);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!s-&gt;connect_err_reported) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; <br>
<br>
</blockquote></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" =
data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><=
div><div dir=3D"ltr"><div><font face=3D"Arial, sans-serif" color=3D"#000000=
"><span style=3D"font-size:13.3333px"><br>Best regards,<br></span><br><span=
 style=3D"font-size:13.3333px">Derek Su</span></font></div><div><font face=
=3D"Arial, sans-serif" color=3D"#000000"><span style=3D"font-size:13.3333px=
">QNAP Systems, Inc.</span></font></div><div><font face=3D"Arial, sans-seri=
f" color=3D"#000000"><span style=3D"font-size:13.3333px">Email: <a href=3D"=
mailto:dereksu@qnap.com" target=3D"_blank">dereksu@qnap.com</a></span></fon=
t></div><div><font face=3D"Arial, sans-serif" color=3D"#000000"><span style=
=3D"font-size:13.3333px">Tel: (+886)-2-2393-5152 ext. 15017</span></font></=
div><div><font face=3D"Arial, sans-serif" color=3D"#000000"><span style=3D"=
font-size:13.3333px">Address: 13F., No.56, Sec. 1, Xinsheng S. Rd., Zhongzh=
eng Dist., Taipei City, Taiwan</span></font></div></div></div></div></div><=
/div></div>

--000000000000ef621305a8d1cd52--

