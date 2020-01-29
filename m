Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD1DC33C9E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 00:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0821C2467E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 00:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0821C2467E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwbfL-00042Q-5G
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 19:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arei@altlinux.org>) id 1iwbem-0003dp-BX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 19:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arei@altlinux.org>) id 1iwbel-00025h-8G
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 19:56:36 -0500
Received: from air.basealt.ru ([194.107.17.39]:52278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arei@altlinux.org>) id 1iwbel-000233-0o
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 19:56:35 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
 id 7F4C65895A1; Wed, 29 Jan 2020 00:56:32 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by air.basealt.ru (Postfix) with ESMTPSA id A91D7589587
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 00:56:30 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id t14so4556189wmi.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 16:56:30 -0800 (PST)
X-Gm-Message-State: APjAAAVgXllQGcAI4Y/O0dd5YegiugUKIaa8DqvMZcXxq48Fa6ggdHfJ
 T6ppV8nhWz5sGAEt2naUXImN4V4m/3gONEFXbhM=
X-Google-Smtp-Source: APXvYqxI+xFJyK23qWzgOnEGVBFvY8qrOqTAo8ro9IDlDGmLxPJdsbItU0HNjuG1mNvAscuFcalw+ZIF0niv+31MBqI=
X-Received: by 2002:a1c:7907:: with SMTP id l7mr7576059wme.37.1580259390100;
 Tue, 28 Jan 2020 16:56:30 -0800 (PST)
MIME-Version: 1.0
References: <CANA1cBJVuJ8Lx5KEQGFRb7trcnOsTbb26+K_efLM+26TB_KfCQ@mail.gmail.com>
 <CAKmqyKP45vT+se16sxj6NZRo2e5wck1oDuUPJw2m5papL-m4hg@mail.gmail.com>
In-Reply-To: <CAKmqyKP45vT+se16sxj6NZRo2e5wck1oDuUPJw2m5papL-m4hg@mail.gmail.com>
From: Nikita Ermakov <arei@altlinux.org>
Date: Wed, 29 Jan 2020 03:55:54 +0300
X-Gmail-Original-Message-ID: <CANA1cB+5C0Y3vgdJ_xNujexPTixWH8bfgt8mPkEQf0LBq=VJfg@mail.gmail.com>
Message-ID: <CANA1cB+5C0Y3vgdJ_xNujexPTixWH8bfgt8mPkEQf0LBq=VJfg@mail.gmail.com>
Subject: Re: Debugging heterogeneous SoC
To: Alistair Francis <alistair23@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000999aeb059d3ccfb9"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 194.107.17.39
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000999aeb059d3ccfb9
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2020 at 03:43, Alistair Francis <alistair23@gmail.com> wrote:

> Use these commands to attach GDB to QEMU:
>
>         target extended-remote :1234
>         add-inferior
>         inferior 2
>         attach 2
>         set schedule-multiple
>         info threads
>
> Alistair
>
Thank you! It is worked! :)

-- 
Thanks,
Nikita
B8 00 4C CD 21

--000000000000999aeb059d3ccfb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, 29 Jan 2020 at 03:43, Alistai=
r Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gmail.com<=
/a>&gt; wrote:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Use these commands to attach GDB to QEMU:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 target extended-remote :1234<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add-inferior<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 inferior 2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 attach 2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 set schedule-multiple<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 info threads<br>
<br>
Alistair<br></blockquote><div>Thank you! It is worked! :)=C2=A0</div></div>=
<div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr">Thanks,<br>Nikita<br>B8 00 4C CD 21<br></div></div></div>

--000000000000999aeb059d3ccfb9--

