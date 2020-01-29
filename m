Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB77C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 00:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D86024685
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 00:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D86024685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwbEm-0008TI-CF
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 19:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arei@altlinux.org>) id 1iwbEC-000810-Cs
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 19:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arei@altlinux.org>) id 1iwbEB-0001AT-8m
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 19:29:08 -0500
Received: from air.basealt.ru ([194.107.17.39]:57784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arei@altlinux.org>) id 1iwbEB-00013r-0j
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 19:29:07 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
 id E88B5589587; Wed, 29 Jan 2020 00:29:00 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by air.basealt.ru (Postfix) with ESMTPSA id EF98058958F
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 00:28:56 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id g17so18181427wro.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 16:28:56 -0800 (PST)
X-Gm-Message-State: APjAAAWEtmwOKzx+G18C1SMarfDLA3Ow3w2DhNs5ojbOtzRMuwGEd0Ok
 G63NBqGrv1AcfJbFi6o+hNDveQBFy20VwZB5VDY=
X-Google-Smtp-Source: APXvYqzNto+yqydVbdNoE1vdg6Fv0RgpP0HaF8quqkBLdu9I/UMlIKFxFIQzPLjIHJsP4PgAHMaAO0wAYDkozGxaEEo=
X-Received: by 2002:adf:eec3:: with SMTP id a3mr4114689wrp.337.1580257736314; 
 Tue, 28 Jan 2020 16:28:56 -0800 (PST)
MIME-Version: 1.0
From: Nikita Ermakov <arei@altlinux.org>
Date: Wed, 29 Jan 2020 03:28:20 +0300
X-Gmail-Original-Message-ID: <CANA1cBJVuJ8Lx5KEQGFRb7trcnOsTbb26+K_efLM+26TB_KfCQ@mail.gmail.com>
Message-ID: <CANA1cBJVuJ8Lx5KEQGFRb7trcnOsTbb26+K_efLM+26TB_KfCQ@mail.gmail.com>
Subject: Debugging heterogeneous SoC
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000006d64c059d3c6d46"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 194.107.17.39
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

--00000000000006d64c059d3c6d46
Content-Type: text/plain; charset="UTF-8"

Hello,

I am trying to debug the sifive_u SoC in the QEMU with GDB.
SiFive Unleashed contains one E51 core and four U54 cores.
In the hw/riscv/sifve_u.c E51 and U54 cores are placed in the different CPU
clusters.
In the gdbstub.c, it is searches only the first cluster and it always finds
cluster with E51 core, if I understand it correctly.
In the GDB with `info threads` I could see only E51 core but none of the
U54 cores.

Is it possible to somehow get an access to another CPU cluster in the
GDB/QEMU?

-- 
Thanks,
Nikita
B8 00 4C CD 21

--00000000000006d64c059d3c6d46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,<br><br>I am trying to debug the sifive_u SoC i=
n the QEMU with=C2=A0GDB.<br>SiFive Unleashed contains one E51 core and fou=
r U54 cores.<br>In the hw/riscv/sifve_u.c E51 and U54 cores are placed in t=
he different CPU clusters.<br>In the gdbstub.c,  it is searches only the fi=
rst cluster and it always finds cluster with E51 core,=C2=A0if I understand=
 it correctly.<br>In the GDB with `info threads` I could see only E51 core =
but none of the U54 cores.<br><br>Is it possible to somehow get an access t=
o another CPU cluster in the GDB/QEMU?<br><div><div><br></div>-- <br><div d=
ir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><di=
v dir=3D"ltr">Thanks,<br>Nikita<br>B8 00 4C CD 21<br></div></div></div></di=
v></div>

--00000000000006d64c059d3c6d46--

