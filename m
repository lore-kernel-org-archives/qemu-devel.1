Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE5C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 12:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2CE2084D
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 12:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUvBr+SH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2CE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJcxz-0007T0-4Y
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 08:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anselmetaf@gmail.com>) id 1iJaae-0003Cz-6z
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 05:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anselmetaf@gmail.com>) id 1iJaad-0000Ez-4Q
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 05:55:04 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:44637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anselmetaf@gmail.com>)
 id 1iJaac-0000ED-Vc
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 05:55:03 -0400
Received: by mail-ot1-x336.google.com with SMTP id 21so11478386otj.11
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=2/7z1zBI4/furZUbcmqFirypbRmME9aaYSWjlLSUxLc=;
 b=eUvBr+SHwhHea63DXuF0xTcooQn4RIO42eYaFMLyweEa01LCe/zdXWGaZTyS+uqYZj
 PF0mgDx+ngaKK2TUcHsKPz018RKBj3fxqEOeDGOGh2Pa88FEos1s1AZy5K+1A73enUeK
 V+Zpzyj+QF2PQhAb5SOJp4bX9QmjDuPoRxQQf2GtHpmBwlISYKcEo+HxBndP2f/RBNou
 PryeVRQ6F/OYq2vxlQrdJBeQYVz34EiALP3BR1xVEKVCPAkhYTTTJZpCltew2U2hhfGr
 +5YR50n7ncARLBDljIjEqOR/2QDyI1kFeUIOKhg9p+8bqGJ6QF7Fq1AP5T28QfqXfTxy
 nvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=2/7z1zBI4/furZUbcmqFirypbRmME9aaYSWjlLSUxLc=;
 b=A6WjOzhw9whJp2LbFxnt34KysyPYDboD8l7TGz/Htn9ifhOA4Ib82tdsNYwc6CFMRP
 rROzan22fMHsU6+4afNjvDh4iOVkAr2FdAz5e7iHCZ62ETWXVp7flQ+1zeRWzbKXPGRW
 FIZS/Yc4nTx5T0K5pvEH3OmSyjqMGC/QWI3nLgLhk9RYAyxqgPKgCYhdxKB9C8+sc5HQ
 s4FcSjMkwIH3rONVSdbSaI8HfsqAvs0WivH2MIq7uSUCmaelDwhbQEzyqzI8DJRycKRO
 Ddo71skv2KrPCu53V7ARB/evAX/NFiXmiYkA2xJGlhydWdKQoyKraZ9r2uUTTN8MjnKB
 PNaQ==
X-Gm-Message-State: APjAAAXrY5QrcnUxkcIADCVqvv75zumKc65m68kcH3O08Z54OGSvQT75
 cN2XOix/LPapIDXex4XPKAa+CGotqQ5GqHOVGbiaP47U
X-Google-Smtp-Source: APXvYqzt/cmsUcNqiKM4a+qSKMlBjGfSoqfoBHkIGP96Wy3AVwqGv8klHdioAQZOivMupyTNTzB7DnqoGHMivmfBS9Y=
X-Received: by 2002:a9d:5f0f:: with SMTP id f15mr18723260oti.251.1570960501288; 
 Sun, 13 Oct 2019 02:55:01 -0700 (PDT)
MIME-Version: 1.0
From: anselme taf <anselmetaf@gmail.com>
Date: Sun, 13 Oct 2019 10:54:50 +0100
Message-ID: <CAOpAi0GNUd28UuJWr5Pi_UjWB4G5MhKT=d6Pq8z371w8v+pWww@mail.gmail.com>
Subject: Need help in Qemu source code
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a2b1ee0594c7bea3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
X-Mailman-Approved-At: Sun, 13 Oct 2019 08:26:23 -0400
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

--000000000000a2b1ee0594c7bea3
Content-Type: text/plain; charset="UTF-8"

Hello dear team
I'm working on Qemu's source code, mainly on Qemu's CPU. I need you to
enlighten me on a number of points
1- How does Qemu emulate its different processors, Can I have a diagram
that describes how Qemu emulates?
2- How is the Qemu x86 CPU implemented?
3- Can I bring out a diagram?
4- How to display the TLB, the registers, the cache ...?
5- How are implemented and where are the data structures of cache,
registers and ALU?
6- How can I go about it if I have to inject faults into caches, registers
and ALU?
Thank you,

--000000000000a2b1ee0594c7bea3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font size=3D"4">Hello dear team<br>I&#39;m working on Qem=
u&#39;s source code, mainly on Qemu&#39;s CPU. I need you to enlighten me o=
n a number of points<br>1- How does Qemu emulate its different processors,=
=C2=A0Can I have a diagram that describes how Qemu emulates?</font><div><fo=
nt size=3D"4">2- How is the Qemu x86 CPU implemented?<br>3- Can I bring out=
 a diagram?<br>4- How to display the TLB, the registers, the cache ...?<br>=
5- How are implemented and where are the data structures of cache, register=
s and ALU?<br>6- How can I go about it if I have to inject faults into cach=
es, registers and ALU?</font><br><div><font size=3D"4">Thank you,<br></font=
></div></div></div>

--000000000000a2b1ee0594c7bea3--

