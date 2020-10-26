Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E715C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1B520727
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfRDR+nv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1B520727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX65j-0003mQ-Ti
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kX61D-0006BC-Dd
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:10:52 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kX61B-0007JM-EN
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:10:51 -0400
Received: by mail-ed1-x541.google.com with SMTP id a6so8832438edx.6
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rzrQK/kF6NzrrIEHQxsC6pLBJ0gJpon3St/4LPuqovE=;
 b=rfRDR+nvOS/nCluIn7jHk7SN+zxESkJqE9vuArZBbVB7mZzlyBtBR9+UPS3nDyYemm
 GeOUAIqRgn3q1mqMLXSttn9aexuK4JWNGdjMUPnzdaSV+V0vAhsVcvqxdVVwsM8eiTxB
 g0ZOIOv2B5Y4Zkmoy1j6//tDR48snPeU/NCSRlOXGuD3bocb4HcDeAo0nOxxgpWWeP+7
 jwwAoawoszsQbmqj1L/NtQjCSBy3OV3JNA3ftWVGTFwLUI4qBm5cQalUm8wpWvCLxoVp
 KFcUYSDWix65VMWMNVluZHaqy4+U81RKcgEJk4WEETuXw56moKZQ2wV4fxqFxoXlhxjc
 CAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rzrQK/kF6NzrrIEHQxsC6pLBJ0gJpon3St/4LPuqovE=;
 b=t6KlYtig4xffKTdR366gxJ1529+c5seDY8wgayOdSe6llLWG2DV/ul2B5QZR8meb96
 yxX8sCvT31uk1iJBnu/mUAbCxZui7UjHG0626UN8cPsPkr6jNpDqx/uOKG3Cg7IIQv+f
 cFtU3oiuSZXrgYsPXdwscpu1F2OnxM/6owZGbKxq49vbTsiSr0vvQy1fgyQ9VYYTVDqR
 cz/xYQ9LzIuUFnRdCruA4M1kHQAd6v1+UVfoKAKDTP2xDm1XqcM8YcHDyxxdZMdDU0yC
 4s/f4HIQ7rbE39ObTctp4t7+w7nk8AmNMt2D1x75Rk4RDSDYXDDssWPfSXXh+B0Me1Fc
 4VQA==
X-Gm-Message-State: AOAM531TJeeGeK53KPNM+BlYdwYvaqtaZ0ZqT5T5S+7Xg+4wfiG1I+Qy
 90HH0UApSwSYUC6qzbtbweFUh/EiaaMchVKsdrrQdPfZRZuGbQ==
X-Google-Smtp-Source: ABdhPJw5O0pFa+1K3RL9rcwaDO8LPu88zqHH/tJqXlg2S7xGdy9ZBXcyh/xxZksejvh7NY0w9moKJRmL0BSlf9ZdiI4=
X-Received: by 2002:a05:6402:d6:: with SMTP id
 i22mr16406766edu.53.1603732245801; 
 Mon, 26 Oct 2020 10:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201020081257.2054548-1-marcandre.lureau@redhat.com>
In-Reply-To: <20201020081257.2054548-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 26 Oct 2020 21:10:33 +0400
Message-ID: <CAJ+F1CKOJ9SH9AW3eW1EPLPafG9Y-O12R9v7YNQ-WMp=VBM5=g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] qemu-ga: add ssh-{get,add,remove}-authorized-keys
To: QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d3708005b29602bf"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x541.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d3708005b29602bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 12:14 PM <marcandre.lureau@redhat.com> wrote:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi
>
> Add new commands to help modify a user .ssh/authorized_keys.
>
> Although it's possible already to modify the authorized_keys files via
> file-{read,write} or exec, the commands are often denied by default, and
> the
> logic is left to the client. Let's add specific commands for this job.
>
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1885332
>
> v3:
>  - add "qga: add ssh-get-authorized-keys" & "qga: add *reset argument to
>    ssh-add-authorized-keys" patches
>  - add some fixup! patches to be squashed after review, adding 'if'
>  - added the reviewed-by
>  - misc doc improvements
>
>
ping (approaching soft-freeze)

I can resend with the fixup squashed, or let the maintainer do it?

thanks

v2:
>  - misc doc improvements
>  - various warnings fixes
>  - fix build for !unix
>  - added reviewed-by
>
> Marc-Andr=C3=A9 Lureau (7):
>   glib-compat: add g_unix_get_passwd_entry_qemu()
>   qga: add ssh-{add,remove}-authorized-keys
>   fixup! qga: add ssh-{add,remove}-authorized-keys
>   fixup! qga: add ssh-{add,remove}-authorized-keys
>   qga: add *reset argument to ssh-add-authorized-keys
>   meson: minor simplification
>   qga: add ssh-get-authorized-keys
>
>  include/glib-compat.h    |  26 ++
>  qga/commands-posix-ssh.c | 516 +++++++++++++++++++++++++++++++++++++++
>  qga/meson.build          |  34 ++-
>  qga/qapi-schema.json     |  67 +++++
>  4 files changed, 636 insertions(+), 7 deletions(-)
>  create mode 100644 qga/commands-posix-ssh.c
>
> --
> 2.28.0
>
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d3708005b29602bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 20, 2020 at 12:14 PM &lt;=
<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">F=
rom: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.c=
om" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
Hi<br>
<br>
Add new commands to help modify a user .ssh/authorized_keys.<br>
<br>
Although it&#39;s possible already to modify the authorized_keys files via<=
br>
file-{read,write} or exec, the commands are often denied by default, and th=
e<br>
logic is left to the client. Let&#39;s add specific commands for this job.<=
br>
<br>
Fixes:<br>
<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1885332" rel=3D"no=
referrer" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D1=
885332</a><br>
<br>
v3:<br>
=C2=A0- add &quot;qga: add ssh-get-authorized-keys&quot; &amp; &quot;qga: a=
dd *reset argument to<br>
=C2=A0 =C2=A0ssh-add-authorized-keys&quot; patches<br>
=C2=A0- add some fixup! patches to be squashed after review, adding &#39;if=
&#39;<br>
=C2=A0- added the reviewed-by<br>
=C2=A0- misc doc improvements<br>
<br></blockquote><div><br></div><div>ping (approaching soft-freeze)</div><d=
iv><br></div><div>I can resend with the fixup squashed, or let the maintain=
er do it?</div><div><br></div><div>thanks</div><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
v2:<br>
=C2=A0- misc doc improvements<br>
=C2=A0- various warnings fixes<br>
=C2=A0- fix build for !unix<br>
=C2=A0- added reviewed-by<br>
<br>
Marc-Andr=C3=A9 Lureau (7):<br>
=C2=A0 glib-compat: add g_unix_get_passwd_entry_qemu()<br>
=C2=A0 qga: add ssh-{add,remove}-authorized-keys<br>
=C2=A0 fixup! qga: add ssh-{add,remove}-authorized-keys<br>
=C2=A0 fixup! qga: add ssh-{add,remove}-authorized-keys<br>
=C2=A0 qga: add *reset argument to ssh-add-authorized-keys<br>
=C2=A0 meson: minor simplification<br>
=C2=A0 qga: add ssh-get-authorized-keys<br>
<br>
=C2=A0include/glib-compat.h=C2=A0 =C2=A0 |=C2=A0 26 ++<br>
=C2=A0qga/commands-posix-ssh.c | 516 ++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 34 ++-<br>
=C2=A0qga/qapi-schema.json=C2=A0 =C2=A0 =C2=A0|=C2=A0 67 +++++<br>
=C2=A04 files changed, 636 insertions(+), 7 deletions(-)<br>
=C2=A0create mode 100644 qga/commands-posix-ssh.c<br>
<br>
-- <br>
2.28.0<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000d3708005b29602bf--

