Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D418DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 20:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877F72076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 20:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4KFhVF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877F72076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8rDD-0003zn-Ll
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 16:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1k8rB9-0003LV-Q1
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 16:28:55 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131]:42739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1k8rB7-0008R1-Lr
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 16:28:55 -0400
Received: by mail-lf1-x131.google.com with SMTP id c8so1600168lfh.9
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=ywaaP89nWB2FnhQtA9KR9yynz/wn47gPn39AwhFFpAo=;
 b=b4KFhVF3ycKjl9BiPqB5ZUl0RsbXMyn13pqjlC9w76CAhTHQiiPA9zicFVdS8rx62J
 I1XOdMvsS+U7JQY+XuXh9lKXowCMcyE1cAkUNmahCZatrx1MuiacKOhzKjVFseWWVG8d
 SalBaocDNbIAIEc2WzxqxD+DWPByKhmQvacfX3sDKBvJVjqE/m1qLFsWzNPCT7Zzsoxr
 ix9vnOhg9JZ3OXEuZppD0pdkVIPJEhCTMfLD8mjG83lVGrhfIJr4X597yGvyraOp+F8i
 BZDh/4Otr2mgrQULXXcLW/RdlPxcDa3RSKZZwys1z9i2ql6KPcCVUXE5vF/4qUsiVoa7
 3trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=ywaaP89nWB2FnhQtA9KR9yynz/wn47gPn39AwhFFpAo=;
 b=MsRwxs+qTDoLEd/slTXzNGCUqRAZoyzQSSrdk/BX1TevJc32/kHo7SnhPFz6F+PKg2
 u3nH8qbzCBbRDOx5Z3nrJ0hSvUduz4nUxArgYqnsW5Nj24k1xWZZyCWVabny42/To45c
 fFthbrFv+UMXbUc8BFSW3OaXmXSmtIXjA3DR4/JZ3VB339/3nFwR5TtU6JbkK900mZ62
 i94MBHwShmwKuwWYhoBmsR/4Cp6lLxUM+i2lYUrg1aWMdU6tMdIZ+U3FQonSJVeWkBn6
 X8oVYrDOFzf3+vQQwabayXu3P9vfKLbraMjGLPIyT12OpAJt5k1iE9s5d7rYq8ydceN6
 V1HQ==
X-Gm-Message-State: AOAM532hN2re2K8XnCHtbtQZ/WQW9cQZ48U0Ze01GbLskyCyRo+bX+q9
 jNbn0mdDYpPQ0WWqbs1JN5uqLu8lZXUT8DIhMFCPrgKfia50XA==
X-Google-Smtp-Source: ABdhPJwisQEAe1Gw2S4aXqPQmTFHsU4bCe3zLf11XJpWpwCOfoGIouHgPPg4d14mYyhwKKwm++kj5pw6pFaucOzbKRo=
X-Received: by 2002:ac2:4c3b:: with SMTP id u27mr64919lfq.176.1597955330409;
 Thu, 20 Aug 2020 13:28:50 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 21 Aug 2020 04:28:39 +0800
Message-ID: <CAE2XoE91V+MU_J_fmKUuepb5ivWtBd4_ojnQzMU59BO7mB3Tyw@mail.gmail.com>
Subject: Trying to install win7 on qemu 5.1 with whpx failed, any suggestion?
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d60c2205ad54f746"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x131.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d60c2205ad54f746
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

```
qemu-system-x86_64 -m 8192 ^
-machine type=3Dq35,accel=3Dwhpx ^
-boot order=3Dd ^
-vga std  ^
-serial none ^
-parallel none ^
-netdev tap,id=3Dmynet0,ifname=3Dtap1,script=3Dno,downscript=3Dno ^
-device virtio-net-pci,netdev=3Dmynet0,mac=3D52:55:00:d1:55:10 ^
-device intel-hda -device hda-duplex ^
-usb -device usb-tablet,bus=3Dusb-bus.0 ^
-cdrom en_windows_7_ultimate_with_sp1_x64_dvd_u_677332.iso ^
-drive if=3Dnone,id=3Dide0,file=3Dwin7.qcow2 ^
-device "ide-hd,drive=3Dide0,bootindex=3D1,serial=3D00000000000000000001" ^
-smp 6,sockets=3D1,cores=3D6,threads=3D1 &

```

But using accel=3Dtcg are working

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d60c2205ad54f746
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">```<div><div style=3D"color:rgb(212,212,212);background-co=
lor:rgb(30,30,30);font-family:Consolas,&quot;Courier New&quot;,monospace;fo=
nt-size:15px;line-height:20px;white-space:pre"><div>qemu-system-x86_64=C2=
=A0-m=C2=A0<span style=3D"color:rgb(181,206,168)">8192</span>=C2=A0<span st=
yle=3D"color:rgb(215,186,125)">^</span></div><div>-machine=C2=A0type=3Dq35,=
accel=3Dwhpx=C2=A0<span style=3D"color:rgb(215,186,125)">^</span></div><div=
>-boot=C2=A0order=3Dd=C2=A0<span style=3D"color:rgb(215,186,125)">^</span><=
/div><div>-vga=C2=A0std=C2=A0=C2=A0<span style=3D"color:rgb(215,186,125)">^=
</span></div><div>-serial=C2=A0none=C2=A0<span style=3D"color:rgb(215,186,1=
25)">^</span></div><div>-parallel=C2=A0none=C2=A0<span style=3D"color:rgb(2=
15,186,125)">^</span></div><div>-netdev=C2=A0tap,id=3Dmynet0,ifname=3Dtap1,=
script=3Dno,downscript=3Dno=C2=A0<span style=3D"color:rgb(215,186,125)">^</=
span></div><div>-device=C2=A0virtio-net-pci,netdev=3Dmynet0,mac=3D52:55:00:=
d1:55:10=C2=A0<span style=3D"color:rgb(215,186,125)">^</span></div><div>-de=
vice=C2=A0intel-hda=C2=A0-device=C2=A0hda-duplex=C2=A0<span style=3D"color:=
rgb(215,186,125)">^</span></div><div>-usb=C2=A0-device=C2=A0usb-tablet,bus=
=3Dusb-bus.0=C2=A0<span style=3D"color:rgb(215,186,125)">^</span></div><div=
>-cdrom=C2=A0en_windows_7_ultimate_with_sp1_x64_dvd_u_677332.iso=C2=A0<span=
 style=3D"color:rgb(215,186,125)">^</span></div><div>-drive=C2=A0if=3Dnone,=
id=3Dide0,file=3Dwin7.qcow2=C2=A0<span style=3D"color:rgb(215,186,125)">^</=
span></div><div>-device=C2=A0<span style=3D"color:rgb(206,145,120)">&quot;i=
de-hd,drive=3Dide0,bootindex=3D1,serial=3D00000000000000000001&quot;</span>=
=C2=A0<span style=3D"color:rgb(215,186,125)">^</span></div><div>-smp=C2=A06=
,sockets=3D1,cores=3D6,threads=3D<span style=3D"color:rgb(181,206,168)">1</=
span>=C2=A0&amp;</div><br></div><div>```</div><div><br></div><div>But using=
 accel=3Dtcg are working<br clear=3D"all"><div><br></div>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=
=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></d=
iv></div></div></div>

--000000000000d60c2205ad54f746--

