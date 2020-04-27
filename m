Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA5EC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 06:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C882072D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 06:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpwZe1Gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C882072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSxS4-0003YB-Ij
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 02:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jSxQf-0002UQ-EK
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 02:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jSxQe-00020j-VV
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 02:39:45 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234]:35400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jSxQe-00020S-Hu; Mon, 27 Apr 2020 02:39:44 -0400
Received: by mail-lj1-x234.google.com with SMTP id g4so16345191ljl.2;
 Sun, 26 Apr 2020 23:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=HyEUdyWjbuEJq/ktW7e2lTa+s25e+l1fZfVmWesdTbo=;
 b=qpwZe1GgGqXMi6TAkuoU4zeu9AgMl0FjMOQjdZea8gjBIEDJPHoBVUsALr6Sm9ixlp
 hDIvyQgNjGnfj0F6TsIttcBYg2J2NA2koaPj9U358ip6tIKZcwuWh+a5605WBiBOWEjL
 GN+onu8RdK68WQxtxTGwFQiuz+jiPbPOEjveUpwTTKKD2ehhLKeGEVWvA2tjTqb/O4Xa
 N0zUTpB8cuoeNjcYgFP5i6aR5PhJiblr8+MNXrjMUL9RVKorVY9XLLhbRIdlrP/jYMen
 Yz2kbbuDtHu0UhqmNo9f6kQRvEy67HaGhVVulhaRKZN7uydb/5xZxHPKiAJjgu/n1Zmo
 i1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=HyEUdyWjbuEJq/ktW7e2lTa+s25e+l1fZfVmWesdTbo=;
 b=jKrweQp8+ZZGGZjvOVEZG9xaRkmbDfuWZtfzyQ3gH7UtbuOVZ0RY7ELPRD2WCFW3S/
 y3iTkKM0cMHK51EA/MfX/ehoiWjbyYj+6fdIrMFogX3M9PiMYlv5q4+aAP3GyDMs5pk/
 OQg4MQzG6WyHuJL8NWBbiVxeRnbpoC/PjwD/tA+2W/mQOix3NYrCzWM0IZpBS5jvOlUy
 EbH6JqlsmgMOCVSuQkwE7mP6Lka1FCHbBIfFDMMCeBOMCUsojW7PSASMQuOq6rSyBD0A
 sacAbfo8Wh2wjDxAEh3o9iYRN8KSj1MRmUJTEwSRy+OQAHRGt7LIWDeYlcP6ECkz3PmG
 w6XQ==
X-Gm-Message-State: AGi0PuZHbbJC5TqL8JkVT1uFz0Sa4zAvt9S///qZaHmQ4dTGCzNUyUCv
 H8gAW3em16AWbAWNIn3/qkVPd5b8hSchcMT5O8Ys3ixkjxM=
X-Google-Smtp-Source: APiQypKCcbZv3Ar2EZcmo6uwx3fVia3oxCwQu141f5rIqMerIOib/qQg8osizPIC0ZyDc4FMArf9pOHm7gKSBDsh/wo=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr5064845ljm.165.1587969581017; 
 Sun, 26 Apr 2020 23:39:41 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 27 Apr 2020 14:39:30 +0800
Message-ID: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
Subject: About hardfloat in ppc
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ca6fa505a43ffad6"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::234
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

--000000000000ca6fa505a43ffad6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because ppc fpu-helper are always clearing float_flag_inexact,
So is that possible to optimize the performance when  float_flag_inexact
are cleared?

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ca6fa505a43ffad6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Because ppc fpu-helper are always clearing float_flag_inex=
act,<div>So is that possible=C2=A0to optimize the performance when=C2=A0

float_flag_inexact=C2=A0 are=C2=A0cleared?<br clear=3D"all"><div><br></div>=
-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_s=
ignature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC=
<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yon=
ggang Luo<br></div></div></div>

--000000000000ca6fa505a43ffad6--

