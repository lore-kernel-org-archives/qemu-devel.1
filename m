Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A93C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 01:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4154C206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 01:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk1+5Luo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4154C206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixKsX-0002ll-HD
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 20:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixKrw-0002Jg-6g
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixKru-0002lS-Vy
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:13:11 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixKru-0002kw-PZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:13:10 -0500
Received: by mail-ot1-x343.google.com with SMTP id a15so5089095otf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 17:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D2XLdd38zIoHxWUicyqjI+KIqj+lpNSKfejzDOiOJK8=;
 b=lk1+5Luo/ho8y95pEq6PqoQkyZDEt7MAE/G5L48xsrks68xOaL1uYNJBDLjoQeKpJJ
 sNaOGDr3YuV6C0d9L90Jj6Nh3zKQsFbD4MVpnpvM1I9zI5gUZRN0PEsmgo7mpSHz84qA
 fqw9nqVn+KFTISJxajFZTMjoKu+0tIKuK72Tvjps3WzoJFsTtVMf449ZgXeVhqOTfKqN
 FTUmpEAlTkAYghXqPu1zd8R33C40o6tgRqt2DPne46TWiU4gqPlNMDxWQ6sQsFTrfrbW
 RF0YcgETfo0aTMbG8n61IoSu3MBH00aV9sMnZdVw1T4EBTwL/CDvwlofBYmFvECF/gIA
 z7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D2XLdd38zIoHxWUicyqjI+KIqj+lpNSKfejzDOiOJK8=;
 b=hsbG1cbaGExW5y1+CGfu7uRTQb767M55r1MQWFji95PMyXdxiMuYBA7o3FmHjYgUXh
 VQrjP39jpL+MpbwMipyBTd7Xmnp39ElFpSat1s4oiKh7tcCCMuVtLzjALHhmed6pVBXY
 7kg6BAjGPD9UYsSWSWGwyVcZvlFigxrY/R6WfiJ9i59r7u+M6AC4Vgd5altZ7GUQT0j3
 DZNeL/qPnOX7NbjUwPcw+qHH6m2mlFGQOIPvXQhyllXEOHVFi2xxPWrFSaljyHpXnPwF
 82IYJAQudRbzlCubQ96jGMVLBqdIdqStaMnolPG5+KhQUWharWya1CmSmvaX7zClz705
 mU2A==
X-Gm-Message-State: APjAAAWv49X8wC4UYNf5DZzhGCcnPTedh8KZPjbc4z5PXU1vDw6I2A6D
 tQu2S4KX/DHE8ouGgU9F0XA5UP2X83pCilC6X4I=
X-Google-Smtp-Source: APXvYqxh9pPKj7/uNnCZH5Ejm/9nqcky5X2AOeMOr/xD4E0bKHGzYzkmoz0gxPwZJobmqRSyN3Zky8cB/gz5G7X8dc4=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr5591394otk.64.1580433189908;
 Thu, 30 Jan 2020 17:13:09 -0800 (PST)
MIME-Version: 1.0
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <20200131010941.10636-1-philmd@redhat.com>
In-Reply-To: <20200131010941.10636-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 31 Jan 2020 02:12:59 +0100
Message-ID: <CAL1e-=i2samx0r+B_UFP6ya0hSNeaib45ok6KY8c3u5h0wbHdg@mail.gmail.com>
Subject: Re: [PATCH 0/2] !fixup target/avr merger-rc4
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e0383c059d654602"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e0383c059d654602
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2020 at 2:09 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:
>
> Aleksandar, I addressed Alex Benn=C3=A9e comment as fixup, so you
> can squash directly. See:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg673846.html
>
> - convert DB_PRINT() to trace-events
> - fix style/indentation
>
> Based-on: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com=
>
>

That is great!

I am going to squash it into corresponding patches, and mention that in
commit messages.
Then I guess some r-b (by Alex) can be added.

Cool!

> Philippe Mathieu-Daud=C3=A9 (2):
>   !fixup "hw/misc: Add limited support for AVR power device"
>   !fixup "hw/timer: Add limited support for AVR 16-bit timer peripheral"
>
>  hw/misc/avr_power.c    | 17 +++++++++--------
>  hw/timer/avr_timer16.c | 25 +++++++++++++++----------
>  hw/misc/trace-events   |  4 ++++
>  hw/timer/trace-events  | 12 ++++++++++++
>  4 files changed, 40 insertions(+), 18 deletions(-)
>
> --
> 2.21.1
>

--000000000000e0383c059d654602
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Jan 31, 2020 at 2:09 AM Philippe Mathieu-D=
aud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt=
; wrote:<br>&gt;<br>&gt; Aleksandar, I addressed Alex Benn=C3=A9e comment a=
s fixup, so you<br>&gt; can squash directly. See:<br>&gt; <a href=3D"https:=
//www.mail-archive.com/qemu-devel@nongnu.org/msg673846.html">https://www.ma=
il-archive.com/qemu-devel@nongnu.org/msg673846.html</a><br>&gt;<br>&gt; - c=
onvert DB_PRINT() to trace-events<br>&gt; - fix style/indentation<br>&gt;<b=
r>&gt; Based-on: &lt;<a href=3D"mailto:1580428993-4767-1-git-send-email-ale=
ksandar.markovic@rt-rk.com">1580428993-4767-1-git-send-email-aleksandar.mar=
kovic@rt-rk.com</a>&gt;<br><div>&gt;</div><div><br></div><div>That is great=
!</div><div><br></div><div>I am going to squash it into corresponding patch=
es, and mention that in commit messages.</div><div>Then I guess some r-b (b=
y Alex) can be added.<br></div><div><br></div><div>Cool!<br></div><div><br>=
</div>&gt; Philippe Mathieu-Daud=C3=A9 (2):<br>&gt; =C2=A0 !fixup &quot;hw/=
misc: Add limited support for AVR power device&quot;<br>&gt; =C2=A0 !fixup =
&quot;hw/timer: Add limited support for AVR 16-bit timer peripheral&quot;<b=
r>&gt;<br>&gt; =C2=A0hw/misc/avr_power.c =C2=A0 =C2=A0| 17 +++++++++-------=
-<br>&gt; =C2=A0hw/timer/avr_timer16.c | 25 +++++++++++++++----------<br>&g=
t; =C2=A0hw/misc/trace-events =C2=A0 | =C2=A04 ++++<br>&gt; =C2=A0hw/timer/=
trace-events =C2=A0| 12 ++++++++++++<br>&gt; =C2=A04 files changed, 40 inse=
rtions(+), 18 deletions(-)<br>&gt;<br>&gt; --<br>&gt; 2.21.1<br>&gt;<br></d=
iv>

--000000000000e0383c059d654602--

