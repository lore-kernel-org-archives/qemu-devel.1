Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8262C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2365206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr9zvxMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2365206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip7Yw-0000fz-Rr
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 04:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1ip7YM-0000F4-EZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1ip7YL-00069e-FL
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:23:02 -0500
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c]:38603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1ip7YL-00068u-9f
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:23:01 -0500
Received: by mail-io1-xd2c.google.com with SMTP id v3so2437909ioj.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 01:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ROItf+AmQr4H5HvpEojLzlYghkrl4dJmSpPPVDfsxuY=;
 b=Fr9zvxMDxnhxTVMl3UYPxEv3gH2jP+l13qzmaE1lM4YAdTVJTN7EuZugKdGeQ3tAhp
 phwDyjTga2JeY3mFWEsi80eQBXB1RKWcsBV9Xq68+R9BTb+Z/094hgo87+DM7m8a2HVb
 fH2LzXU8wG1cIoUrA1093HzjEgWHNYxuzF6uoQZ5MRjmLT5Bzk+XJeeUil1it0mbFU6/
 pSTpUX9EYsVmQ3D1kUQk02Nt3wQ6/iMEM2uTOuP+VsEJi/FlnUNNzT6I3OFuDma7SmOS
 Nli7UF2k3Yd9h1v67ksKesksuStgZZxUGyx1qYr6maEbAYFaHdj42pgb44gWe8WSwzah
 ErRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ROItf+AmQr4H5HvpEojLzlYghkrl4dJmSpPPVDfsxuY=;
 b=JUvxJFGUZYn/KVtCzasu9+dUt8CraFFue0xiXr2Fzvp5/Gkmczbe5Si9kDeAANeqzk
 fm7KACopu/qfOPbL7qLb3UJSXzzJAJ8lmNYNCa44ZrhSln9PwBKXzuAY8Mu6xR/epYIX
 ErASFE5qzJNqOh2uJqNY9M5woQ75faRNa8bbJXRg9dH9ESNgi4tCmBhHouGVB+o7qg7e
 pCrlE58orPSdVO8KkLYaVZSCWLtIS9uCSY+1/7Cxu5BV3/Q6FPLjzcntR0oy0QDG7ZTg
 MQi1AIiLuDglTP9M422qDHs3+7d/vUDzjXLaH0JD8srx+iY5GxzpH1HzzUmlKxvTrUNf
 i+Ow==
X-Gm-Message-State: APjAAAW4cVG0BVC3N0mr+8azYG7kxUhqmrcudFeL9bHqi6Do2YzAn4ZU
 LK1QnXEkzba0UbpM7cmp35BsNAfDaOlwulVxWRReDVTItQU=
X-Google-Smtp-Source: APXvYqxp4fJxsQbC1uitHrFeze6J6T05I4176aDN8316nS1+ex7R9x1CNhBs77YpsyUhNJCYU7/0tT6sHzMwX/8Bt6U=
X-Received: by 2002:a02:9a08:: with SMTP id b8mr3175458jal.1.1578475379848;
 Wed, 08 Jan 2020 01:22:59 -0800 (PST)
MIME-Version: 1.0
From: Ian Jiang <ianjiang.ict@gmail.com>
Date: Wed, 8 Jan 2020 17:22:48 +0800
Message-ID: <CAMAD20mmgEa_W869C961T_1DQnx+J=dKYFJgv=2WEw5iDL5T1A@mail.gmail.com>
Subject: riscv: How to debug a wrong pc after executing ret instruction?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004d79e2059b9d70f7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2c
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

--0000000000004d79e2059b9d70f7
Content-Type: text/plain; charset="UTF-8"

Problem
======
The next instruction after executing "ret" (i.e. jalr x0, 0(x1)) is not at
0x000000008000056c (x1/ra) as expected,  but at  0x000000008000056c.
How to debug this issue? Any suggestion is appreciated.

QEMU command
=============
qemu-system-riscv64 -nographic -machine virt -kernel my-test.elf -smp 1 -d
in_asm,cpu

Trace (piece)
===========
IN:
0x0000000081150000:  00259eb7  lui t4,2461696
0x0000000081150004:  00099b37  lui s6,626688
0x0000000081150008:  01db3023  sd t4,0(s6)
0x000000008115000c:  00008067  ret

pc        0000000081150000
x1/ra    000000008000056c

IN:
0x0000000080003da0: 10503023  sd t0,256(zero)
...


QEMU version
===========
upstream tag v4.2.0

--
Ian Jiang

--0000000000004d79e2059b9d70f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Problem</div><div>=3D=3D=3D=3D=3D=3D</div><div>T=
he next instruction after executing &quot;ret&quot; (i.e. jalr x0, 0(x1)) i=
s not at 0x000000008000056c (x1/ra) as expected,=C2=A0 but at=C2=A0 0x00000=
0008000056c.</div><div>How to debug this issue? Any suggestion is appreciat=
ed.</div><div><br></div><div></div></div><div>QEMU command<br></div><div>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>qemu-system-riscv64 -nogr=
aphic -machine virt -kernel my-test.elf -smp 1 -d in_asm,cpu</div><div><br>=
</div><div>Trace (piece)</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><=
div>IN:</div><div>0x0000000081150000:=C2=A0 00259eb7=C2=A0 lui t4,2461696</=
div><div>0x0000000081150004:=C2=A0 00099b37=C2=A0 lui s6,626688<br></div><d=
iv>0x0000000081150008:=C2=A0 01db3023=C2=A0 sd t4,0(s6)<br></div><div>0x000=
000008115000c:=C2=A0 00008067=C2=A0 ret<br></div><div><br></div><div>pc=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0000000081150000</div><div>x1/ra=C2=A0 =C2=A0 0000=
00008000056c</div><div><br></div><div>IN:</div><div>0x0000000080003da0: 105=
03023=C2=A0 sd t0,256(zero)</div><div>...</div><div><br></div><div><br></di=
v>QEMU version<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><div>upstream tag v=
4.2.0<div><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature"=
 data-smartmail=3D"gmail_signature">--<br>Ian Jiang</div></div></div></div>=
</div></div>

--0000000000004d79e2059b9d70f7--

