Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BC1C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE262072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4BULBBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE262072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJwAE-0002Qi-I9
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 05:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1jJw9V-0001nr-2J
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1jJw9T-0004or-Nq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:28:44 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34]:39444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1jJw9T-0004n7-JE; Thu, 02 Apr 2020 05:28:43 -0400
Received: by mail-io1-xd34.google.com with SMTP id c16so2877178iod.6;
 Thu, 02 Apr 2020 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=HuAPEc3xHBmUPSy9L5bzFQV9J2w+XtzLiuPsjegJNVM=;
 b=i4BULBBAmKbfUoo0BwphTqJQvNA7aivRdMt6tCw4knX97dlsQe8IR7A98i8HbNxbk7
 zdxAuoQvRcbkP6ILcMeIdZjHZo3Sg1gIOoYZKUJx0C0CRWseAL0XvZ423VjzGlQpnDwz
 Y6ThAwfKZDSwBejtiWiBK5MBv+n1InXz0D0R1ZeHq+yQpOIel1ZNqsbEm4iD32wWzMPc
 aey3wH9c6B9HC1+FcDkMUkPg802VXGt5/kX4XY36ND4UeD20xXMqEUUIsKGTZsyljVni
 Z6aRyMVXwOyArGLbvcEG8e5ruJeusmmaVfEPz+deoQq/jnZ7HF3lGGCYS/B9mtv8PS0M
 Bq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=HuAPEc3xHBmUPSy9L5bzFQV9J2w+XtzLiuPsjegJNVM=;
 b=t8fFf8d5FVX+vjljIFzXqqsdsTMqECIaey1uQR1LhKLc/FRiXk8EaPVGgnKaFAcAk4
 M/Pqd0ktGjeLVBanHLFFTXTvCo9fnv1+iQvRj7Sj89jgCvN4Q+R3msS5URQGfBcQHBOn
 ZV3mwYBh7GPkbu2QVXmT4Qj8ocQWiISYanewHNTSklQiM0CdIh9NwkhtMfB6ef4isPyN
 oPRUr6SXYuQ1ufQUC/U3WqStJEmWfrP8dTegYhoQyJdYgoDppvBsK8W15/PTlNzL2w2x
 V+bsp90q/60OmeXwWI95y1dUNBTuLaZXKCUkpnzIw0k6FouygyVSvbZzMEtyj0fz6H6L
 M1/w==
X-Gm-Message-State: AGi0Pubeq8MTyWt89ab6ZTetLnnHX9/QvtiikrRK3W+5hVQ0EZm+VQZy
 2rqyNfVxBo8rI8Gc8yu3CTiP7GtH29PnqQlerRSK4owg
X-Google-Smtp-Source: APiQypIs2jQqT53Kv1kjUpHcbAyQ3IudHqaTWQ89MqElRL1ZkRxkHV+W/HZOKAKbUk6YDV4Xraiv7PaDNH9wlQVtzZ8=
X-Received: by 2002:a5d:8b57:: with SMTP id c23mr1898056iot.161.1585819722042; 
 Thu, 02 Apr 2020 02:28:42 -0700 (PDT)
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 2 Apr 2020 11:28:30 +0200
Message-ID: <CABLmASEaKJKzDdvKGv+iWfp=0vdr9bupM76zvLZZ6sZFAPkuRg@mail.gmail.com>
Subject: qemu-system-ppc 5.0 rc1 crashing on Windows
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000035cfd305a24b6def"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d34
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

--00000000000035cfd305a24b6def
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I just compiled qemu-system-ppc for Windows, using native msys2 on Windows
10 64 bit and the 64 bit mingw cross compiler on Fedora 31. Both create
executables that crash:

qemu-system-ppc.exe -L pc-bios -boot c -m 512 -M mac99,via=3Dpmu -h
da C:\Mac-disks\9.2.img
Exception code=3D0xc0000005 flags=3D0x0 at 0x00007FFB2A602078. Access viola=
tion
- attempting to write data at address 0x00000000034C76EC

I bisected this down to:

d2cd29e30736afd4a1e8cac3cf4da360bbc65978 is the first bad commit
commit d2cd29e30736afd4a1e8cac3cf4da360bbc65978
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Tue Dec 17 13:47:37 2019 -1000

    configure: Do not force pie=3Dno for non-x86

    PIE is supported on many other hosts besides x86.

    The default for non-x86 is now the same as x86: pie is used
    if supported, and may be forced via --enable/--disable-pie.

    The original commit (40d6444e91c) said:

      "Non-x86 are not changed, as they require TCG changes"

    but I think that's wrong -- there's nothing about PIE that
    affects TCG one way or another.

    Tested on aarch64 (bionic) and ppc64le (centos 7) hosts.

    Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
    Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
    Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Please note that I tried again after applying patch
https://patchwork.ozlabs.org/patch/1265368/ However, this has not solved my
issue.

Best,
Howard

--00000000000035cfd305a24b6def
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><div><br></div><div>I just compiled qemu=
-system-ppc for Windows, using native msys2 on Windows 10 64 bit and the 64=
 bit mingw cross compiler on Fedora 31. Both create executables that crash:=
</div><div><br></div><div>
qemu-system-ppc.exe -L pc-bios -boot c -m 512 -M mac99,via=3Dpmu -h<br>da C=
:\Mac-disks\9.2.img<br>Exception
 code=3D0xc0000005 flags=3D0x0 at 0x00007FFB2A602078. Access violation -=20
attempting to write data at address 0x00000000034C76EC <br></div><div><br><=
/div><div>I bisected this down to: <br></div><div><br></div><div>d2cd29e307=
36afd4a1e8cac3cf4da360bbc65978 is the first bad commit</div>commit d2cd29e3=
0736afd4a1e8cac3cf4da360bbc65978<br>Author: Richard Henderson &lt;<a href=
=3D"mailto:richard.henderson@linaro.org" target=3D"_blank">richard.henderso=
n@linaro.org</a>&gt;<br>Date: =C2=A0 Tue Dec 17 13:47:37 2019 -1000<br><br>=
=C2=A0 =C2=A0 configure: Do not force pie=3Dno for non-x86<br>=C2=A0 =C2=A0=
 <br>=C2=A0 =C2=A0 PIE is supported on many other hosts besides x86.<br>=C2=
=A0 =C2=A0 <br>=C2=A0 =C2=A0 The default for non-x86 is now the same as x86=
: pie is used<br>=C2=A0 =C2=A0 if supported, and may be forced via --enable=
/--disable-pie.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 The original commit (40d=
6444e91c) said:<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 =C2=A0 &quot;Non-x86 are=
 not changed, as they require TCG changes&quot;<br>=C2=A0 =C2=A0 <br>=C2=A0=
 =C2=A0 but I think that&#39;s wrong -- there&#39;s nothing about PIE that<=
br>=C2=A0 =C2=A0 affects TCG one way or another.<br>=C2=A0 =C2=A0 <br>=C2=
=A0 =C2=A0 Tested on aarch64 (bionic) and ppc64le (centos 7) hosts.<br>=C2=
=A0 =C2=A0 <br>=C2=A0 =C2=A0 Tested-by: Alex Benn=C3=A9e &lt;<a href=3D"mai=
lto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt=
;<br>=C2=A0 =C2=A0 Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex=
.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>=C2=
=A0 =C2=A0 Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:p=
hilmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br><div>=C2=
=A0 =C2=A0 Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.h=
enderson@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;=
</div><div><br></div><div>Please note that I tried again after applying pat=
ch <a href=3D"https://patchwork.ozlabs.org/patch/1265368/" target=3D"_blank=
">https://patchwork.ozlabs.org/patch/1265368/</a> However, this has not sol=
ved my issue.</div><div><br></div><div>Best,</div><div>Howard<br></div><div=
><br></div><div><br></div></div>

--00000000000035cfd305a24b6def--

