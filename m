Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D4BC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0E320409
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmG5hMi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0E320409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFfH3-00035n-Qw
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jFfDm-00065T-8h
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luoyonggang@gmail.com>) id 1jFfDl-0004Dy-9b
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:35:30 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d]:41804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <luoyonggang@gmail.com>)
 id 1jFfDl-0004D3-1n; Sat, 21 Mar 2020 10:35:29 -0400
Received: by mail-lf1-x12d.google.com with SMTP id z22so6752241lfd.8;
 Sat, 21 Mar 2020 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=MQV8WkrGmOJVLcsHxKzyDzVUgMIqg6JpJ7PDTqCw/oE=;
 b=GmG5hMi9FmN3BMxu3/jXcx4+msu7nwt8v2xopsEmfMlFJRR+lttjOqy7FeOGIltMEQ
 jachMIegq/zwn8QBrjovQ+eDxBZJNSM4YQT66js+5VBhUdfnCLunN5N6D+JNh0+Z5uc2
 JI+H5yQ2jPafuxMaMnZTYj7C0nr/xWkRP9/jj57S+a8r+TVJnHvk4ZDvy2E3D40YFNll
 ipRcApgRJWpn2Ik+ZAmOT6GMbSvA+tapiTJ2BbyP8R5AW6d29s9vk0oGPKnGkGcTQ+st
 gLpRt3kCTJRDE/hzoX4na044XyYXuwWx6T3BKcOTaNqwzcCCP6zMaw0dQ4A2EqCw2etY
 lZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=MQV8WkrGmOJVLcsHxKzyDzVUgMIqg6JpJ7PDTqCw/oE=;
 b=JYyp2F5AHHqXdlGMc6XqMptAF20iFdsl0eZGiks9Exie4l/r+Xw37iKIPRUXtz9iwg
 XyoCI6m0ITBA1ZchGmALFfLTyT6fsGeRGN0wv9vCXIY7H934nUd/KGMOXTzrlg9+BqW7
 q+tDFhY8f4JZCt9CfnY5gIeGaRvZHuLoPlv5fSyP8LYpSoNVezkj7UCxSRSNYApq8fCj
 cXtrElMzDv2qecPdA9Z2janxU1ghmHsGTNp4ODMyLT8BIarGvszAKiqqGt1M/F9Lj6f6
 bYqkaX/mODtUPFedUaPz2e2zhmO9PrMS6vaYxyqfnxHq5IFSsJ2kvflaqSnwpuTCuPzC
 y2wQ==
X-Gm-Message-State: ANhLgQ1H/xQUYdgnhqeoz9eUqCmc15BM3Id5w3ljL9+63/eBqqTc2BA2
 A0ooWAibisevHQfrubo2R2c7iUew+B+59Xk6n9Il6S3FgRB7dQ==
X-Google-Smtp-Source: ADFU+vslb4qTv/xifTLmvqkFYQ7gwCk5KlPOST3oy3zU9/6ZBN7c0xS+7M5UwIwhbffIo1GlipgxuHv+0dfp2BfxvQo=
X-Received: by 2002:ac2:4552:: with SMTP id j18mr8403108lfm.89.1584801326821; 
 Sat, 21 Mar 2020 07:35:26 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 21 Mar 2020 22:35:16 +0800
Message-ID: <CAE2XoE8C40s6k-z781W+kxbrChgrB+B9Tx26Yx3GggtPc2SEpw@mail.gmail.com>
Subject: POWERPC_EXCP_PROGRAM POWERPC_EXCP_INVAL in PowerPC simulation.
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001ff5e305a15e5063"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12d
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

--0000000000001ff5e305a15e5063
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am facing a exception when running the following code:
```
00e86000 <excConnectCode>:
excConnectCode():
  e86000: 3c 60 00 e1 lis     r3,225
  e86004: 60 63 c3 80 ori     r3,r3,50048
  e86008: 7c 68 03 a6 mtlr    r3
```
How to implement an instruction in ppc translate?

Raise exception at 00e86000 =3D> 00000060 (21)
--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000001ff5e305a15e5063
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am facing a exception when running the following code:<d=
iv>```</div><div>00e86000 &lt;excConnectCode&gt;:<br>excConnectCode():<br>=
=C2=A0 e86000:	3c 60 00 e1 	lis =C2=A0 =C2=A0 r3,225<br>=C2=A0 e86004:	60 6=
3 c3 80 	ori =C2=A0 =C2=A0 r3,r3,50048<br>=C2=A0 e86008:	7c 68 03 a6 	mtlr =
=C2=A0 =C2=A0r3<br></div><div>```<br clear=3D"all"><div>How to implement an=
 instruction in ppc translate?</div><div><br></div><div>Raise exception at =
00e86000 =3D&gt; 00000060 (21)<br></div>-- <br><div dir=3D"ltr" class=3D"gm=
ail_signature" data-smartmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div></div>

--0000000000001ff5e305a15e5063--

