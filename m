Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24200C35250
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 14:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED41920733
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 14:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED41920733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0nzy-0002jE-1a
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 09:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arei@altlinux.org>) id 1j0nyr-0001PP-Bs
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 09:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arei@altlinux.org>) id 1j0nyq-0007Bu-7O
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 09:54:41 -0500
Received: from air.basealt.ru ([194.107.17.39]:51406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arei@altlinux.org>) id 1j0nyp-00071I-Vy
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 09:54:40 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
 id 2E54F58958C; Sun,  9 Feb 2020 14:54:36 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by air.basealt.ru (Postfix) with ESMTPSA id 3A0815894E9
 for <qemu-devel@nongnu.org>; Sun,  9 Feb 2020 14:54:34 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id a9so7695491wmj.3
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2020 06:54:34 -0800 (PST)
X-Gm-Message-State: APjAAAV7PiMmn+uwLaLgwe4F0jqpUWDF9wQtTt8qB/kJUDPB0LbS2jvS
 VVkFfyflyZmpgRpwFX+ga82yXnoGqm6m05NkAb8=
X-Google-Smtp-Source: APXvYqzRv9Fq+UNkdYaX6Ep7ivsLdfiV6mIaUHBwQcOkV4B6WPHIraZXchTOSk5r4rpPtRLdo3Nyw+i5dEDTsFTmKA8=
X-Received: by 2002:a1c:7907:: with SMTP id l7mr9765612wme.37.1581260073620;
 Sun, 09 Feb 2020 06:54:33 -0800 (PST)
MIME-Version: 1.0
References: <CANA1cB+D-Uth0C-6qNE5HcAJkQeDsCbKqmYG7uHsLqbbofSsZQ@mail.gmail.com>
In-Reply-To: <CANA1cB+D-Uth0C-6qNE5HcAJkQeDsCbKqmYG7uHsLqbbofSsZQ@mail.gmail.com>
From: Nikita Ermakov <arei@altlinux.org>
Date: Sun, 9 Feb 2020 17:54:21 +0300
X-Gmail-Original-Message-ID: <CANA1cBKtbYqnxnSacEK3sXOYM987J5+MacpKWHdKHwB5sk672w@mail.gmail.com>
Message-ID: <CANA1cBKtbYqnxnSacEK3sXOYM987J5+MacpKWHdKHwB5sk672w@mail.gmail.com>
Subject: Question: SiFive U SPI and SD
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fc5b74059e25ccae"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
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

--000000000000fc5b74059e25ccae
Content-Type: text/plain; charset="UTF-8"

Hello!

I am trying to make an SD card working on the sifive_u
(hw/riscv/sifive_u.c) SoC machine.
As far as I understand there is no way to connect an SD card to the SoC
with cmdline for now. So, I started to dig in to the QEMU internals and
especially sifive_u SoC implementation to try to understand how I could
connect SD card to this SoC.

From what I understood I need to:
1) Implement SiFive U SPI controller.
2) Implement spi-sd adapter in a way like the hw/sd/ssi-sd.c

Probably I should merge 1) and 2) into one hw/riscv/sifive_u_spi.c source
file.

Could somebody correct me please if I am wrong at some point?
I am newbie in the QEMU internals :)

The purpose is why I want to implement this is to boot up the Linux kernel
on '-machine sifive_u' and load rootfs from SD.

-- 
Thanks,
Nikita
B8 00 4C CD 21

--000000000000fc5b74059e25ccae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr">=
<div><div>Hello!<br><br>I am trying to make an SD card working on the sifiv=
e_u (hw/riscv/sifive_u.c) SoC machine.<br>As far as I understand there is n=
o way to connect an SD card to the SoC with cmdline for now. So, I started =
to dig in to the QEMU internals and especially sifive_u SoC implementation =
to try to understand=C2=A0how I could connect SD card to this SoC.<br><br>F=
rom what I understood I need to:<br>1) Implement SiFive U SPI controller.<b=
r>2) Implement spi-sd adapter in a way like the hw/sd/ssi-sd.c<br><br>Proba=
bly I should merge 1) and 2) into one hw/riscv/sifive_u_spi.c source file.<=
br><br>Could somebody=C2=A0correct me please if I am wrong at some=C2=A0poi=
nt?<br>I am newbie in the QEMU internals :)<br><br>The purpose is why I wan=
t to implement this is to boot up the Linux kernel on &#39;-machine sifive_=
u&#39; and load rootfs from SD.<br></div><div><br></div>-- <br><div dir=3D"=
ltr" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Thanks,<br>Nikita<=
br>B8 00 4C CD 21<br></div></div></div></div>
</div></div>

--000000000000fc5b74059e25ccae--

