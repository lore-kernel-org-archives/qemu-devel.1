Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F56C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4F620870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6zLMwvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4F620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaDWA-0007L0-Lq
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 02:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kaDUn-00064b-Av; Wed, 04 Nov 2020 02:46:17 -0500
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:43166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kaDUj-0006bt-B7; Wed, 04 Nov 2020 02:46:17 -0500
Received: by mail-ej1-x643.google.com with SMTP id k3so28326616ejj.10;
 Tue, 03 Nov 2020 23:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H6y2Xa3sITJofh7w+9vCnAX4wTeS1ZhGD2fNKDpGrXs=;
 b=g6zLMwviiPxq3l/yRBQtZkUwRgWUQ3ZHYoWIZs88C5tLmwKZZdx2HkHARDDpYH+KBz
 lZFjbkkXM3AgFmhjOxchNkxb78ZrmrMRYkOM2D9I2AvKh6VPLcwvNSkrf7F4SRkU26Tv
 wh7ACLaMTntyZ8A+BHjrtk6zUXqqgGHn6wvIdj/xHROVOED/9JyztK0MATvaxJh5wVNd
 DBHqxt2LZJnVy8KpfpuqGMpXE7Una1C+j1cgfd1Ih/W5dwshYKvKujabcKxoU75RceOI
 4STLvOpmZx8KKc0jplJwWZJ3lxVSqSC6oCujJgU49bTa8u3qqAaTSJfOvcnzHTN7A3VA
 OgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H6y2Xa3sITJofh7w+9vCnAX4wTeS1ZhGD2fNKDpGrXs=;
 b=McAPPn3Om90tfJGikG+rFleZnJbT0Vv84HaQQdJL5suSZsU4CbiSdQeLgpO1VRuSz2
 iGsg5WTowcd25rc2U71tCWFII+x8klhHjudD0FulPB+Ti/02D2pBDIT+PmOyVXoSygof
 cfqO+VOo9xS01iXOnmd4FGeOK3jOnIQMLyOaFYGaXMkMn56RMZh8mE6tZJMop6r39xPa
 Y9iykcSNik+6NyWmo8Q2DQfLiN7TRwCNAHiz2c/0TZxhwlqIzEdLiBOyYSKkTBCOldyT
 6GQ4MUQfx3UIpT4UHN7XjZ2572AjGbscPIOFr7cswKpygFZRz1qVZ7QjfgRPkrak7YtH
 91dQ==
X-Gm-Message-State: AOAM5325Qa3GIpr7etPAPpR14GHLiIUpspoE9sJe3x6VvLHCVcfRtaJR
 V4/In4RXJp+gduKtraAkrhaJNWkdGv/4Pzr02l2g25shNoLqGQ==
X-Google-Smtp-Source: ABdhPJyFWXRTYGiiI85XGL3mNVYWQh9YX3jOynZb7EV1amfF0iEG4YxnDKuO7MQP1VKVmpRL5zQjF95M10XtCiVR1g4=
X-Received: by 2002:a17:906:af47:: with SMTP id
 ly7mr25257487ejb.532.1604475971609; 
 Tue, 03 Nov 2020 23:46:11 -0800 (PST)
MIME-Version: 1.0
References: <5F96915D.2040102@huawei.com>
In-Reply-To: <5F96915D.2040102@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Nov 2020 11:46:00 +0400
Message-ID: <CAJ+F1CJT7SDt63ZyUAVCZhoYJ=Ep4KXF7MbcQJREaDHrTZXBeA@mail.gmail.com>
Subject: Re: [PATCH 0/4] qga: Fix some style problems
To: AlexChen <alex.chen@huawei.com>
Content-Type: multipart/alternative; boundary="00000000000056a96f05b3432c9f"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: qemu trival <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000056a96f05b3432c9f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 1:16 PM AlexChen <alex.chen@huawei.com> wrote:

> Fix some error style problems found by checkpatch.pl.
>
> alexchen (4):
>   qga: Add spaces around operator
>   qga: Delete redundant spaces
>   qga: Open brace '{' following struct go on the same
>   qga: switch and case should be at the same indent
>
>  qga/channel-win32.c  |  6 ++---
>  qga/commands-posix.c |  4 +--
>  qga/commands-win32.c | 28 ++++++++++-----------
>  qga/commands.c       |  4 +--
>  qga/main.c           | 59 ++++++++++++++++++++++----------------------
>  5 files changed, 50 insertions(+), 51 deletions(-)
>
>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

--00000000000056a96f05b3432c9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 26, 2020 at 1:16 PM AlexC=
hen &lt;<a href=3D"mailto:alex.chen@huawei.com">alex.chen@huawei.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fix som=
e error style problems found by <a href=3D"http://checkpatch.pl" rel=3D"nor=
eferrer" target=3D"_blank">checkpatch.pl</a>.<br>
<br>
alexchen (4):<br>
=C2=A0 qga: Add spaces around operator<br>
=C2=A0 qga: Delete redundant spaces<br>
=C2=A0 qga: Open brace &#39;{&#39; following struct go on the same<br>
=C2=A0 qga: switch and case should be at the same indent<br>
<br>
=C2=A0qga/channel-win32.c=C2=A0 |=C2=A0 6 ++---<br>
=C2=A0qga/commands-posix.c |=C2=A0 4 +--<br>
=C2=A0qga/commands-win32.c | 28 ++++++++++-----------<br>
=C2=A0qga/commands.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +--<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 59 +++++++++++++=
+++++++++----------------------<br>
=C2=A05 files changed, 50 insertions(+), 51 deletions(-)<br>
<br></blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &l=
t;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.co=
m</a>&gt;</div><br clear=3D"all"></div><br>-- <br><div dir=3D"ltr" class=3D=
"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000056a96f05b3432c9f--

