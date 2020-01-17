Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49401C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150D820728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrOMbT0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150D820728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRne-0005Cm-29
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1isRkL-0002WK-F3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1isRkK-00082i-GA
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:33:09 -0500
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34]:42513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1isRkK-00081a-BQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:33:08 -0500
Received: by mail-io1-xd34.google.com with SMTP id n11so25988689iom.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=vKbJroWiEVHvl8EOr3Fy9ww1XDr7npx1GYhdzb5dwBQ=;
 b=HrOMbT0E5enOIyhrJqDP7ld0zo4p5QB0HbYdbnb7NWOp0VbDjCvICMulsR1ToCWXuy
 xXGAd6cUDa7Ew/V8CZALgEA7URA0HmWyK4XKJLUVBvM0frEM1irXabyQ5f9fltai5yHg
 naniJbVKlS5N4LxTixNp4XGGlPlnwCbM7URyMUHk36Qs9J7w6wD1JUfFycuypsUVBah8
 4l7EsUwueyezkBNop6W/DsitZly+04FVWhKmj5m+oyLKUZnjX/e8QKLV3Pc+wvii45rJ
 qwbs4xEGmyeW09JMTe6QF3vNSzMVCpMAe6L8R17gMpMiQI6GojeRC2I8UZSF9qIv2jRE
 tWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=vKbJroWiEVHvl8EOr3Fy9ww1XDr7npx1GYhdzb5dwBQ=;
 b=bJwFh9APmu/ITdqooRx5hnxDIRxYlInTCjE5vzyhOGVyyw27vcw5a7kYWE9ET/Igbn
 BvikSal82x4XREFOQE/XjVCwtevUzqAp7oO4O3qo7+ARIp/CZ/50BelQqsR1ydDwMMMY
 Ow7bvh9qfHGIh6pVbLZI8kqhCQkpCxaKtz9pLrbTFA/XkS7EDU0Povah15dJTCVxdyhC
 sMaWwZpJl1mr3/Yab2sM288hiUsuM8k20KJhcH6SApAMQX8m2dsip/5uGXZmuMLXp0zk
 WIBuq6/UW3ewwbSEOiiEWIgJqd+HQWzAp2Tl0x75Mpe2UGjyg+cdvksu+hm6JG2MYVcX
 F4zQ==
X-Gm-Message-State: APjAAAVYWCjPFav7oPN9Ep+eq8quK4ez703w5RscxpOAJEjP/dlIzHY5
 4r0WqFHD7gWV1+70NjeUTfHQi9Walu6reKMDKagf3FFtkHs=
X-Google-Smtp-Source: APXvYqyEbcB18NYAQVMUeBu01dV7ogblSRouGfibTk1CWbjsL4CsVvfU/5d4Rp+qGz7Xytn/JAlG0qG6WNH8b1HvfHY=
X-Received: by 2002:a6b:92d4:: with SMTP id
 u203mr31446405iod.288.1579267986437; 
 Fri, 17 Jan 2020 05:33:06 -0800 (PST)
MIME-Version: 1.0
From: Ian Jiang <ianjiang.ict@gmail.com>
Date: Fri, 17 Jan 2020 21:32:55 +0800
Message-ID: <CAMAD20nGNi3N=Nj0x_ifUkH0Hb465eG77w6VG-vPLb1u1mPCsw@mail.gmail.com>
Subject: riscv: How to get more CSR information in debug trace?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000563f1f059c55fbcf"
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

--000000000000563f1f059c55fbcf
Content-Type: text/plain; charset="UTF-8"

The following registers are given in QEMU debug trace with "-d cpu"
parameter.
pc       0000000000001000
mhartid  0000000000000000
mstatus  0000000000000000

mip      0x0
mie      0000000000000000
mideleg  0000000000000000
medeleg  0000000000000000
mtvec    0000000000000000
mepc     0000000000000000
mcause   0000000000000000

I want more information of other CSRs, such as sstatus, misa, pmpconfig0.
How to get debug trace on all CSRs defined in RISC-V specification?
Thanks!

--
Ian Jiang

--000000000000563f1f059c55fbcf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The following registers are given in QEMU debug trace=
 with &quot;-d cpu&quot; parameter.</div>pc =C2=A0 =C2=A0 =C2=A0 0000000000=
001000<br>mhartid =C2=A00000000000000000<br>mstatus =C2=A00000000000000000 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>mip =C2=A0 =C2=A0 =C2=A00x0<br>mie =C2=A0 =C2=A0 =C2=A0000=
0000000000000<br>mideleg =C2=A00000000000000000<br>medeleg =C2=A00000000000=
000000<br>mtvec =C2=A0 =C2=A00000000000000000<br>mepc =C2=A0 =C2=A0 0000000=
000000000<br>mcause =C2=A0 0000000000000000<div><br></div><div>I want more =
information of other CSRs, such as sstatus, misa, pmpconfig0.</div><div>How=
 to get debug trace on all CSRs defined in RISC-V specification?</div><div>=
Thanks!</div><div><br></div><div>--</div><div>Ian Jiang</div></div>

--000000000000563f1f059c55fbcf--

