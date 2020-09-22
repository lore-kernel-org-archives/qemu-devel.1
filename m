Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BA1C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A354D2388B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TxG3S7Bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A354D2388B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKh25-0003sK-JM
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miklos@szeredi.hu>) id 1kKh1C-0003Ps-Fz
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:03:34 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:34356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <miklos@szeredi.hu>) id 1kKh19-0004s3-Nz
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:03:34 -0400
Received: by mail-ua1-x944.google.com with SMTP id v8so5416628uaq.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 05:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szeredi.hu; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w1zk3N4S860pTM4e2x55L1XSkgMh5qjRuOy7Ag9dnp4=;
 b=TxG3S7Bq+549oubMaUPCzkx+vhPgamb7YMVIX2FY/inTxBA/uzovmfK8E06LW/ENJu
 6fbQq7kkl4D3+UJHIoeQ43du0IVhP52fB8BW6GVtSqndqMCAXLgjbuItuWAhFMlswkJU
 CohJPCk5UcU6F0TnadAznMPyHqNOzlQplMYFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w1zk3N4S860pTM4e2x55L1XSkgMh5qjRuOy7Ag9dnp4=;
 b=raaVd7oVEZRdsfPJYD8pRfvez1cI4q3IwElYtfjLPeLHISoxyCU3wNkWBy9KaObgfS
 2Wam+pfza0b4uABfP6fBEOLvZLhu0vU2hERkPeexxU9XKm5GCAzKANCLZ1yp7y0Th0gF
 o7qTh9FMDW+fV5s7XLcNUrhHDZuDrOgcqBEPUJsotKtd3VdkMz5Db7ig0Zs+aWJZFznx
 cY+ovkLpZyttbllTm2jOD/r1KZs+Cia9O693WUro6a7KAFixEFokQRUJjya2aaWHuRnF
 4uSPJ4EsRMdOI2I3tWYckv05RtXurthPiYHOh0qosc6LthuVihvCt0XNND3NRrEC+7M7
 KfAw==
X-Gm-Message-State: AOAM531tCCAL/ivThCTYqte+K+ANG4xrk502IY7mE1OJX8CzYghpoSMR
 zH8s2QmQm7MAqTZ3nP6WELT5PouBhjTrTYi1fphZqA==
X-Google-Smtp-Source: ABdhPJzCxSV7Jyy1Ti5MnnfYjxBovAs0U7gNjYzGBe999BiSfV39a9/7ysOsUN2+vAo8x/+NRzfKlBQtcEZnZFoe/B0=
X-Received: by 2002:ab0:25c7:: with SMTP id y7mr2846744uan.137.1600776209523; 
 Tue, 22 Sep 2020 05:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200921213216.GE13362@redhat.com>
In-Reply-To: <20200921213216.GE13362@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 22 Sep 2020 14:03:18 +0200
Message-ID: <CAJfpegujM0ygoBT5uPf4zBUDiphDTwgu97NfqaEgaa8HoSnuRw@mail.gmail.com>
Subject: Re: [PATCH] virtiofsd: Used glib "shared" thread pool
To: Vivek Goyal <vgoyal@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005577cd05afe5c1f8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::944;
 envelope-from=miklos@szeredi.hu; helo=mail-ua1-x944.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005577cd05afe5c1f8
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 21, 2020 at 11:32 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> glib offers thread pools and it seems to support "exclusive" and "shared"
> thread pools.
>
>
> https://developer.gnome.org/glib/stable/glib-Thread-Pools.html#g-thread-pool-new
>
> Currently we use "exlusive" thread pools but its performance seems to be
> poor. I tried using "shared" thread pools and performance seems much
> better. I posted performance results here.
>
> https://www.redhat.com/archives/virtio-fs/2020-September/msg00080.html
>
> So lets switch to shared thread pools. We can think of making it optional
> once somebody can show in what cases exclusive thread pools offer better
> results. For now, my simple performance tests across the board see
> better results with shared thread pools.
>

Needs this as well:

--- qemu.orig/tools/virtiofsd/passthrough_seccomp.c 2020-09-16
20:21:13.168686176 +0200
+++ qemu/tools/virtiofsd/passthrough_seccomp.c 2020-09-22
14:01:38.499164501 +0200
@@ -94,6 +94,8 @@ static const int syscall_whitelist[] = {
     SCMP_SYS(rt_sigaction),
     SCMP_SYS(rt_sigprocmask),
     SCMP_SYS(rt_sigreturn),
+    SCMP_SYS(sched_getattr),
+    SCMP_SYS(sched_setattr),
     SCMP_SYS(sendmsg),
     SCMP_SYS(setresgid),
     SCMP_SYS(setresuid),

Thanks,
Miklos

--0000000000005577cd05afe5c1f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 21, 2020 at 11:32 PM Vivek Goyal &lt;<a=
 href=3D"mailto:vgoyal@redhat.com">vgoyal@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">glib offers thread pool=
s and it seems to support &quot;exclusive&quot; and &quot;shared&quot;<br>
thread pools.<br>
<br>
<a href=3D"https://developer.gnome.org/glib/stable/glib-Thread-Pools.html#g=
-thread-pool-new" rel=3D"noreferrer" target=3D"_blank">https://developer.gn=
ome.org/glib/stable/glib-Thread-Pools.html#g-thread-pool-new</a><br>
<br>
Currently we use &quot;exlusive&quot; thread pools but its performance seem=
s to be<br>
poor. I tried using &quot;shared&quot; thread pools and performance seems m=
uch<br>
better. I posted performance results here.<br>
<br>
<a href=3D"https://www.redhat.com/archives/virtio-fs/2020-September/msg0008=
0.html" rel=3D"noreferrer" target=3D"_blank">https://www.redhat.com/archive=
s/virtio-fs/2020-September/msg00080.html</a><br>
<br>
So lets switch to shared thread pools. We can think of making it optional<b=
r>
once somebody can show in what cases exclusive thread pools offer better<br=
>
results. For now, my simple performance tests across the board see<br>
better results with shared thread pools.<br></blockquote><div><br></div><di=
v style=3D"font-size:small" class=3D"gmail_default">Needs this as well:</di=
v><div style=3D"font-size:small" class=3D"gmail_default"><br></div><div sty=
le=3D"font-size:small" class=3D"gmail_default">--- qemu.orig/tools/virtiofs=
d/passthrough_seccomp.c	2020-09-16 20:21:13.168686176 +0200<br>+++ qemu/too=
ls/virtiofsd/passthrough_seccomp.c	2020-09-22 14:01:38.499164501 +0200<br>@=
@ -94,6 +94,8 @@ static const int syscall_whitelist[] =3D {<br>=C2=A0 =C2=
=A0 =C2=A0SCMP_SYS(rt_sigaction),<br>=C2=A0 =C2=A0 =C2=A0SCMP_SYS(rt_sigpro=
cmask),<br>=C2=A0 =C2=A0 =C2=A0SCMP_SYS(rt_sigreturn),<br>+ =C2=A0 =C2=A0SC=
MP_SYS(sched_getattr),<br>+ =C2=A0 =C2=A0SCMP_SYS(sched_setattr),<br>=C2=A0=
 =C2=A0 =C2=A0SCMP_SYS(sendmsg),<br>=C2=A0 =C2=A0 =C2=A0SCMP_SYS(setresgid)=
,<br>=C2=A0 =C2=A0 =C2=A0SCMP_SYS(setresuid),<br></div></div><div class=3D"=
gmail_quote"><div style=3D"font-size:small" class=3D"gmail_default"><br></d=
iv><div style=3D"font-size:small" class=3D"gmail_default">Thanks,</div><div=
 style=3D"font-size:small" class=3D"gmail_default">Miklos</div><br></div></=
div>

--0000000000005577cd05afe5c1f8--

