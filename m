Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74A2C1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 22:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88189206F9
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 22:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBmcG1vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88189206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG9H9-0005OF-P7
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 18:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jG9GZ-0004tY-3p
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jG9GY-0007Oe-84
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:40:23 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:39047)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jG9GY-0007OW-1T
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:40:22 -0400
Received: by mail-il1-x141.google.com with SMTP id r5so6681169ilq.6
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LiMieYQUgeIG4zQm6B4gzBteHb3jiqXzEo9arHbGAto=;
 b=SBmcG1vpDhKcC9R+voGLvqIL5Iv+FyT48f/ZgoE6463NNMnQpY1kqIF93Q3MKIQgzO
 FBCMq2EbvMIUaLI45PJUDYJ8ofm50rJh9lMNbuK43cEWMst/HcPL2V/sxLuPjq0j6+3C
 9pVahncpoY2HFBykfdKu4lHxhxtZwDEK/scn2m5SGSWQTkXQw0BxGCIEFG9wgXeBkbcE
 RE/D0c63tlH0LY04fphNUDvEkGnH4PNEqQnIkZXHB5Z0XAQ5gnrlVh2R3GrD3zLZa1Mj
 XIT0OhbaOJEXb2o5AFhW6tjwgfUag+5OOZOv76ci6WfWgAbF61AhhBQEkQwS5APrtLQO
 aVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LiMieYQUgeIG4zQm6B4gzBteHb3jiqXzEo9arHbGAto=;
 b=adPkos5zS/rN/4/vlcZWVGA0LRUTAjwVdiL546aMq6u1Dga5iKfUWybIltxoJdn8lm
 +mlLZGne2pME/nbButmbfvM25CbYFBxPGKwtZ9mKMzZ/y892/jZ5GgwkuWeI9Ed+i/n9
 xppEDWhONd2S1MxqGQIJYDIVFdC8zKMhCVLSP37QuJ0Yl3d0/BIVzinnjlCFbODGD9cy
 so2CYjWOQwKZ1rXre1Q3JgbAIyi8+GgaXGwHShdz9v9YYZSFPGVLJe/OVX3begn2n+s/
 OKn9sWwkKxiiW/b+f4YelVeBoZpSbigkSZDB7510oUZP8Eo0aVKnFzhkjOjcIBb2gH5m
 3m8w==
X-Gm-Message-State: ANhLgQ2+B1fNP93i+KsLT1rCwuqid0A9mmDzyk2vVbCTXOMMzkfVsrmI
 QnUGiWH+YWIRoL2oaTW/aH7kgQz/5YFJjd9BCbA=
X-Google-Smtp-Source: ADFU+vvkR1fDYxLfBvjTOvYjWV95JcC3rVb4GNssW8PmUz39vlIdVXM6jC5rHLJ0tcOs7OqcE6SpLTgAZfU9+XRTTxw=
X-Received: by 2002:a92:96c6:: with SMTP id
 g189mr18081473ilh.276.1584916820735; 
 Sun, 22 Mar 2020 15:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200322222726.10244-1-pauldzim@gmail.com>
In-Reply-To: <20200322222726.10244-1-pauldzim@gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Sun, 22 Mar 2020 15:39:54 -0700
Message-ID: <CADBGO79DFLsmdOqE=ui+rQG74JvSkL5BEouYrTHmyQ-pdHxS-Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] dwc-hsotg (aka dwc2) USB host contoller emulation
To: kraxel@redhat.com
Content-Type: multipart/alternative; boundary="000000000000193b6d05a179347a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000193b6d05a179347a
Content-Type: text/plain; charset="UTF-8"

On Sun, Mar 22, 2020 at 3:28 PM Paul Zimmerman <pauldzim@gmail.com> wrote:

< snip >

> 2) I have imported the register description file from the Linux
>    kernel. This file is licensed GPL-2 only, is this OK?

Never mind about the license, I see it is actually GPL 2.0 or later. I
guess the question remains whether it is OK to copy the file directly
like this?

Thanks,
Paul

--000000000000193b6d05a179347a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><font face=3D"monospace">On Sun, Mar 22, 2020 at 3=
:28 PM Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com">pauldzim@gm=
ail.com</a>&gt; wrote:<br><br></font><div><font face=3D"monospace">&lt; sni=
p &gt;</font></div><div><font face=3D"monospace"><br>&gt; 2) I have importe=
d the register description file from the Linux<br>&gt; =C2=A0 =C2=A0kernel.=
 This file is licensed GPL-2 only, is this OK?<br><br></font></div><div><fo=
nt face=3D"monospace">Never mind about the license, I see it is actually GP=
L 2.0 or later. I</font></div><div><font face=3D"monospace">guess the quest=
ion remains whether it is OK to copy the file directly</font></div><div><fo=
nt face=3D"monospace">like this?</font></div><div><font face=3D"monospace">=
<br></font></div><div><font face=3D"monospace">Thanks,</font></div><div><fo=
nt face=3D"monospace">Paul</font></div></div>

--000000000000193b6d05a179347a--

