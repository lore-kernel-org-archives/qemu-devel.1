Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEC9C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03ACE20716
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ACE20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiTG0-0003Ya-4U
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 20:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTCk-00065U-EE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTCi-0008TV-Tx
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:05:14 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTCi-0008Qv-JX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:05:12 -0500
Received: by mail-yw1-f67.google.com with SMTP id 10so4595242ywv.5
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 17:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rfZd3X4kFZ8+r7BcBBI0XVWCOdXjW2lSAaUxJ5cf304=;
 b=OzqCHB2CD2iLylu8W4SRqVYmhDtUfwWOUp3HTjbmXFK9ie0Pd6JuLFS6y4Wpib1JTp
 BGPej6QuWzUYSisK01kq6p/bUAnvOMSGY98cEtUah2S9Ce8JKFrZZDFm5iU2ote5dtxK
 NgWxawdnqafKlHe4ZxQBrLoJcZK5SOtyo+eYsT41IKB+ho+rji4j5hgfrDsk9QtjGjTa
 bATcRIhAbUo/r3afn4B7kFhLtMzB/57T3TcA+Uf1QpIcjYm5dq9S5sPSgm2aNw18sQr2
 940vGBG++l3kYeaCEJzGOvsrk9cH0V113RUGuTTZ1MfXaC46Vnj+xChOyyFNFFobS4h/
 qVpQ==
X-Gm-Message-State: APjAAAVskd6C9fvP1HJpd5p4F8Rym+NW9piMFKF2WkA3g9VrJfGnZ4fI
 p5AS4zqhPQye+p93g1w/p3O9v7YgUccBybI4aiPWPlO9
X-Google-Smtp-Source: APXvYqxnc6mlbFry0Aw2uRItq8HlYIqUsMgzMH4qbS33mEWuA+95x5r3lpdxMJq5VvH02C7GtEDwAfVvTHymwlcOdzY=
X-Received: by 2002:a0d:d84b:: with SMTP id a72mr12746924ywe.33.1576890311686; 
 Fri, 20 Dec 2019 17:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20191221010226.9230-1-f4bug@amsat.org>
In-Reply-To: <20191221010226.9230-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 21 Dec 2019 02:05:00 +0100
Message-ID: <CAAdtpL6nxYySPX77o31iWgTD2tGrigs2KSvA_nVEjM3drxQ7AQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] hw/avr: Introduce the Arduino boards
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.67
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Stefan Hajnoczi <stefanha@redhat.com>,
 Phillip Stevens <phillip.stevens@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Dec 21, 2019 at 2:02 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Hi,
>
> This series add the arduino boards, aiming at removing the
> 'sample' board that doesn't follow any specification.
>
> Since v1:
> - Addressed Igor comments
> - Addressed Aleksandar comments
> - Fixed UART issue (was due to IRQ shifted by 2 in CPU)
>
> TODO after merge is:
> - Extract Timer8 common parts from Timer16
> - Add GPIOs
> - Connect LED to GPIO on Arduino
> - Plug to Scratch (See http://s4a.cat/).
>   (I plan to purpose that as a GSoC idea).
>
> Thank you for having insisted with this port during so long!
(This comment is for Michael)

I forgot to amend this series (including Michael patches) is available here=
:
https://gitlab.com/philmd/qemu/commits/arduino-v2

> Regards,
>
> Phil.
>
> Based-on: <20191218210329.1960-1-mrolnik@gmail.com>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg666384.html

