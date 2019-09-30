Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DD9C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320DF20842
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="echogDvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320DF20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvYF-0002NZ-Ao
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <doug16k@gmail.com>) id 1iEvWa-0001gR-PW
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <doug16k@gmail.com>) id 1iEvWZ-0000wJ-Kh
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:15:36 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36]:38599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <doug16k@gmail.com>) id 1iEvWZ-0000vp-GY
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:15:35 -0400
Received: by mail-io1-xd36.google.com with SMTP id u8so38117514iom.5
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 06:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=9dpRGe4mZR0En1v7Fc4zpv0Zv/h1PEOvJB2vEeZqNGc=;
 b=echogDvGydWC41DnThTCsAMXZLPJycuIWyS34YWD574+TkNNBP/ihIVOpdtSdngUOF
 cL0KXvwk6uBtTLQUR1Nm3xktddB+qfbmIzCWDPfeKqyhHI/PxUhnijhaOfiChSmY6RUM
 vzqO/pLGHPpCbBPzRDm5SIaEhuUjjLf9wxY3Hd2gmKGhx6c+oDkIVEQ69ftZqq73+/93
 JEF7/gq9ooJk0DkV1EUQTGSQa6qVPF8VUyg0biPDiCCIq6cjoB3PBSVZ4OoPyqWuNae5
 6jycVxEX3PAiCHq2OH+DL+9H+2bPb8Mi1pXB8T9WD7wEAxRSK7MDI8QAmJFRE8xU34IR
 cqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=9dpRGe4mZR0En1v7Fc4zpv0Zv/h1PEOvJB2vEeZqNGc=;
 b=ImOv81DvWYbj1nKuyYE2nffMwqA5OSo0D7P0GTdgLr4kMnvPJNF0XYJV8Rq5JUkAAZ
 VrjE/UspoeR/4aSFfuF+O4BPCxBr2U73XZTTqkIBnq7XxTjHVQPxXmOf1hw21h5ieadN
 3NljeuRkpGcQ3CjCQ34w/1vb91QVl/6LwKIT5jKSS3vihDZjIxOeCpZ88eTQoIE0VKd4
 oeWesMbnkCxFtRikCx8pjYqSUN9j0l9MLWOPV7ErW92B6hVqs6egKreWal2QH0y7tHVJ
 jizrzv2ZyMIiLkS8eyNWJI3kTwlklhLpQ8PfuaqTwme2D7B1ALB3BrkzRx0x0zWyOrdw
 QXqQ==
X-Gm-Message-State: APjAAAUuhuvj3Qf2fQfPkYrZ7KAjGbv+MrPJ3poJOvtuuWUEKFF8hdVu
 xa94gtEaWOboG/2/Wm3bcZ2VcENGzT37O2IprTwUkM5vJz0=
X-Google-Smtp-Source: APXvYqyv064uuyzxIKJTsTwC2Or1JLxq9AYWm/BnwMjh9Xbu1HLWJSFr2dbSslJBxiot2fDIxlNgXFa/axA812TbaCw=
X-Received: by 2002:a92:4648:: with SMTP id t69mr19648195ila.282.1569849334582; 
 Mon, 30 Sep 2019 06:15:34 -0700 (PDT)
MIME-Version: 1.0
From: Doug Gale <doug16k@gmail.com>
Date: Mon, 30 Sep 2019 09:15:24 -0400
Message-ID: <CAEfK_44VEF17nRgzNvVe+MPmAfS34kiJ_ozubWFkVYV0rm71sw@mail.gmail.com>
Subject: Lockup with --accel tcg,thread=single
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d36
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

I found a lockup in single threaded TCG, with OVMF bios, 16 CPUs.

qemu-system-x86_64 --accel tcg,thread=single -smp cpus=16 -bios
/usr/share/ovmf/OVMF.fd

Using Ubuntu 18.04 LTS, default gnome desktop. There is no guest OS,
there is no hard drive, just the OVMF firmware locks it up. (I
narrowed it down to this from a much larger repro)

Let that run for about 10 seconds or so, then attempt to Ctrl-C in the
terminal that launched qemu. You should see the hung program thing
(wait or force quit) appear on the qemu window, and the terminal just
prints ^C without interrupting qemu. DO NOT click force quit or wait.
Use killall -9 qemu-system-x86_64 to kill it if you must, gdb kill is
also okay. If you force quit you will likely freeze the entire gnome
desktop. This is what kmsg reports:
https://gist.githubusercontent.com/doug65536/810e0471c11008c97edb4aa0d86ddd66/raw/40038a355542f0edb1f14a7c7fb7c2db60da0025/end%2520of%2520syslog%2520after%2520desktop%2520lockup,
this is what syslog reports:
https://gist.githubusercontent.com/doug65536/810e0471c11008c97edb4aa0d86ddd66/raw/40038a355542f0edb1f14a7c7fb7c2db60da0025/the%2520end%2520of%2520dmesg%2520after%2520desktop%2520lockup.
Probably bugs in gnome but just warning about locking up your machines
when reproducing.

Peter Maydell helped me bisect it in IRC.
 Works fine at commit 1e8a98b53867f61
 Fails at commit 9458a9a1df1a4c7

MTTCG works fine all the way up to master.

Configure command line:

../qemu/configure --target-list=x86_64-softmmu,i386-softmmu
--audio-drv-list=pa --enable-libusb --disable-libssh
--enable-virglrenderer --enable-opengl --enable-debug

The issue occurs without --enable-debug. I didn't strip the configure
down though, it may not need all of those configure options exactly.

OVMF from ubuntu package manager, package named ovmf, exact version is
0~20180205.c0d9813c-2ubuntu0.1

Stack trace at lockup at
https://gist.githubusercontent.com/doug65536/810e0471c11008c97edb4aa0d86ddd66/raw/40038a355542f0edb1f14a7c7fb7c2db60da0025/backtrace%2520all

