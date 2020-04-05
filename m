Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C837EC2D0F4
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 14:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865EE20672
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 14:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0xNY3mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865EE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jL6Qu-000593-Lz
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 10:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1jL6QF-0004eE-I2
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 10:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1jL6QE-0006Bk-8r
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 10:38:51 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135]:38639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1jL6QE-0006B6-45
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 10:38:50 -0400
Received: by mail-il1-x135.google.com with SMTP id n13so12209265ilm.5
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2020 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+94n6V9SmBDeFDd1ecVRlVaCBFknXJ4Ik/iao6SnOxg=;
 b=c0xNY3mW/miUzazZ8NeJvLpOuq81tzmOlfCvG+c2/A5lBZH98SgyFuHprxc+o5hnaQ
 9HAZ1Wb997uH6+Fsv4L1TBgwWn7On1bfwP5StI7uxj+9JxPCnii3MpG79Yndx8A4/sdC
 C1zFxVXQ02MwMDducuHFeqRxDhIvDRd1+X9vunkv7oa2Rt0dD0rrlMKHWsMSmO26nSEE
 2HzIaiYkzCJpo3Qev/AOA7Fq/lpFyrVmsRIM5cV6wsuEZPZbK3XyWHGfPTrnjjdH2T4u
 khY+e8PMd4d3B5096ivBRcNe+3CnuM3c5O72ngvrhYnKEERoRuu/UaEWHjICQ9xH2eFD
 SHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+94n6V9SmBDeFDd1ecVRlVaCBFknXJ4Ik/iao6SnOxg=;
 b=hpEmE6hXHXLn6fA9n0+c5XmKQW/uhty2meZURznRyI7mpOs2/LmHcKODNyEimwcsPA
 nLv2Dlg5xSIuxmxJ7n5t4eKwkKt5inh/XF+Ebjah77iIQS82mvD79dTceJn8vRbNFL71
 n6ddug2vWwE3M98fnMXa+IOja1a8PY93S4q2/uMpVe79mcqqTIiqTXdHIW8RZx5bAM7e
 iCdNZxo94/LYD9XNz3BuS6Ew+03bMBHVFNxQ4N30rDhXjx0IuRZXKBnS5q5E0n1GNY2a
 6hGGAGYQIkfTKLSBt4VgOX5xsCl/JN8CMmtiJysI5sFxn0FhxVz8aS9GKTaE4CsQF9Ms
 SXpQ==
X-Gm-Message-State: AGi0PuagL13MINkKXlm81RuwXC8FV7wYS42JpbTyVRaUyvsNIVTzzY04
 hY3fDK4cwijbpuab4fux09+KKNj4N0yZWHclAqg=
X-Google-Smtp-Source: APiQypJWr5/TQukD1Hsr/LS/KEdvSsy4U0S3xEYjuHaWy3YPgyG/s0k21djr8rAS7uk6Tg97QyO4swQ55Yk9QQtSS80=
X-Received: by 2002:a92:c00e:: with SMTP id q14mr16148356ild.124.1586097528510; 
 Sun, 05 Apr 2020 07:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <158608933730.23414.9673600050118912834.malonedeb@wampee.canonical.com>
In-Reply-To: <158608933730.23414.9673600050118912834.malonedeb@wampee.canonical.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sun, 5 Apr 2020 16:38:36 +0200
Message-ID: <CABLmASFNTz937CcuYgN_6OrioVw2Lmj72WSpi7x_ZdNVksNt7A@mail.gmail.com>
Subject: Re: [Bug 1870911] [NEW] QEMU Crashes on Launch, Windows
To: Bug 1870911 <1870911@bugs.launchpad.net>
Content-Type: multipart/alternative; boundary="000000000000c41dcb05a28c1b0f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::135
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
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c41dcb05a28c1b0f
Content-Type: text/plain; charset="UTF-8"

On Sun, Apr 5, 2020 at 3:38 PM Russell Morris <ubuntu@rkmorris.us> wrote:

> Public bug reported:
>
> Hi,
>
> I an having no issues up to (and including) v5.0.0-rc0, but when I move
> to rc1 ... it won't even execute in Windows. If I just try to, for
> example, run
>
> qemu-system-x86_64.exe --version
>
> No output, it just exits. This seems to be new with this version.
>
> Thanks!
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1870911
>
> Title:
>   QEMU Crashes on Launch, Windows
>
> Status in QEMU:
>   New
>
> Bug description:
>   Hi,
>
>   I an having no issues up to (and including) v5.0.0-rc0, but when I
>   move to rc1 ... it won't even execute in Windows. If I just try to,
>   for example, run
>
>   qemu-system-x86_64.exe --version
>
>   No output, it just exits. This seems to be new with this version.
>
>   Thanks!
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1870911/+subscriptions
>
>

Happens to me too with qemu-system-ppc. Earlier thread is here:
https://lists.nongnu.org/archive/html/qemu-ppc/2020-04/msg00027.html

For now compiling with --disable-pie will produce a running executable.

Best,
Howard

--000000000000c41dcb05a28c1b0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Apr 5, 2020 at 3:38 PM Russel=
l Morris &lt;<a href=3D"mailto:ubuntu@rkmorris.us">ubuntu@rkmorris.us</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Public=
 bug reported:<br>
<br>
Hi,<br>
<br>
I an having no issues up to (and including) v5.0.0-rc0, but when I move<br>
to rc1 ... it won&#39;t even execute in Windows. If I just try to, for<br>
example, run<br>
<br>
qemu-system-x86_64.exe --version<br>
<br>
No output, it just exits. This seems to be new with this version.<br>
<br>
Thanks!<br>
<br>
** Affects: qemu<br>
=C2=A0 =C2=A0 =C2=A0Importance: Undecided<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Status: New<br>
<br>
-- <br>
You received this bug notification because you are a member of qemu-<br>
devel-ml, which is subscribed to QEMU.<br>
<a href=3D"https://bugs.launchpad.net/bugs/1870911" rel=3D"noreferrer" targ=
et=3D"_blank">https://bugs.launchpad.net/bugs/1870911</a><br>
<br>
Title:<br>
=C2=A0 QEMU Crashes on Launch, Windows<br>
<br>
Status in QEMU:<br>
=C2=A0 New<br>
<br>
Bug description:<br>
=C2=A0 Hi,<br>
<br>
=C2=A0 I an having no issues up to (and including) v5.0.0-rc0, but when I<b=
r>
=C2=A0 move to rc1 ... it won&#39;t even execute in Windows. If I just try =
to,<br>
=C2=A0 for example, run<br>
<br>
=C2=A0 qemu-system-x86_64.exe --version<br>
<br>
=C2=A0 No output, it just exits. This seems to be new with this version.<br=
>
<br>
=C2=A0 Thanks!<br>
<br>
To manage notifications about this bug go to:<br>
<a href=3D"https://bugs.launchpad.net/qemu/+bug/1870911/+subscriptions" rel=
=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1870=
911/+subscriptions</a><br>
<br></blockquote><div><br></div><div><br></div><div>Happens to me too with =
qemu-system-ppc. Earlier thread is here:</div><div><a href=3D"https://lists=
.nongnu.org/archive/html/qemu-ppc/2020-04/msg00027.html">https://lists.nong=
nu.org/archive/html/qemu-ppc/2020-04/msg00027.html</a></div><div><br></div>=
<div>For now compiling with --disable-pie will produce a running executable=
.<br></div><div>=C2=A0</div><div>Best,</div><div>Howard<br></div></div></di=
v>

--000000000000c41dcb05a28c1b0f--

