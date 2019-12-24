Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190B3C2D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 16:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27C020643
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 16:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m24eG4mM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27C020643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijn6q-0007K7-W4
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 11:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <padmashree9107@gmail.com>) id 1ijn67-0006fm-3I
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 11:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <padmashree9107@gmail.com>) id 1ijn66-0004DO-1b
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 11:31:50 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d]:34037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <padmashree9107@gmail.com>)
 id 1ijn65-0004D0-Tq
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 11:31:49 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id l7so647152ybp.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2019 08:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=CFWAb8666CqcEC+0V4kfFmJiQTAo+FfurLxyFbNdbcQ=;
 b=m24eG4mMjIMX6Y0zM4lBO0TrsvGoEPq+wTW+bgQv3h8yDHjIvXrF21ARlnkl+wAA/v
 f2QZ0vc/QGyMmnhOnIyQqA5ZbXktZ2S2ROs1tr9KIo77spxh+08nt/mcV4HWjUpdWYnm
 llG6owvzMjyDPaTi7PETF94/lDQJekw9s5JPNK3DvpAqSIDj6+VzOJtqW0UKtk3Nzquz
 qJSivbzap5aEqhKzCFNopsnu1Dx2TT0GQuW2Yr/vmcMySqR2eH0nOgeVBK+XxMxgpk3o
 ajFwc3sQ/egmaqeS5kvbaN35yl6d/AsW/i6tREFIyag4qH2MYTUvvZYtrlumDJaxLh0N
 xihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=CFWAb8666CqcEC+0V4kfFmJiQTAo+FfurLxyFbNdbcQ=;
 b=lqYb7opA7NrCvqxnndU47y3ILOmWypMq2bDtrtDY7jtypNovKToRM519p3C5jEYQeW
 iOij9chGGf74Wcc2pWgRPabHOKTvixLqZ5+/rCw+11wn4+qu/VGjkn4BdlWZuLf3gKK6
 4S+2uTtCtwiCyFoOM7MCNXR4qj+IIHp6deWwZxYgQU+8NjjtxAqVmzjIQwJ8ba37lR/r
 5gCqb2MPbMJRN9ksbqtESBrvyZJT/9mc4e4Whcu8QbI/oEFlkF7U+AVvZqNOEIKCmR5e
 ATfTuCG5HqIMnBkmMqGen1s3CxcFkbwsaCzh0o7TqnuG5hzpWbHjVnnKijHM06sPZGzf
 ZxPg==
X-Gm-Message-State: APjAAAUWMe3fWtsHNk8IHDY7ZFiV5brhGWpSywG6MEgDRSdv2LMm8guP
 PviLKutQLuYnlgXczh/z9tpL1TCsK2wIcBdVechhD38o
X-Google-Smtp-Source: APXvYqxMEUVbS8vDvvKKV4o/Mcu0OXtVc+tlC2y1W7aVi19dysUlYEymmWbGf9JEfKhAaeksHKojOB6EoipCeSiaN4c=
X-Received: by 2002:a5b:70d:: with SMTP id g13mr24926038ybq.270.1577205108630; 
 Tue, 24 Dec 2019 08:31:48 -0800 (PST)
MIME-Version: 1.0
From: padmashree mandri <padmashree9107@gmail.com>
Date: Tue, 24 Dec 2019 22:01:37 +0530
Message-ID: <CANT-jrLcehCiWpau5TaXpReb_B-J6hVN-ycRZek158w1vduRKQ@mail.gmail.com>
Subject: Audio not working in Qemu-4.2 with pulse audio.
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003ce9cf059a75ae7c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b2d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003ce9cf059a75ae7c
Content-Type: text/plain; charset="UTF-8"

Hi all,

                I tried to run Qemu-4.2  with pulse audio but faced issue
as there is no audio at all in guest .However it works fine with ALSA. I
tried the same in Qemu-3.0 with pulseaudio. It was working fine. But facing
issue after upgrading to Qemu-4.2. Any suggestions?



Thanks

Padmashree

--0000000000003ce9cf059a75ae7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;fo=
nt-size:11pt;font-family:Calibri,sans-serif">Hi all,</p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <i>=C2=A0</i>=C2=A0I tried to run Qemu-4.2=C2=A0 with pulse audio but f=
aced issue as there is no audio at all in guest .However it works fine with=
 ALSA. I tried the same in Qemu-3.0 with pulseaudio. It was working fine. B=
ut facing issue after upgrading to Qemu-4.2. Any suggestions?</p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">=C2=A0</p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Thanks</p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif">Padmashree</p></div>

--0000000000003ce9cf059a75ae7c--

