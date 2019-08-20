Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E4AC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15BE22CF4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15BE22CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i01M5-0003zF-VP
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 06:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i01Kx-0003Kx-Kt
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i01Kv-0006cH-Un
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i01Kv-0006Zj-Le
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:25:57 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 69002A23CC
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 10:25:55 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id a17so6791877wrr.10
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 03:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:openpgp:cc:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=oC7wDpFXg3tMHnfL5ict2ib9gtUl7N/dDInYCMI8K0E=;
 b=UgV5KeqtCRpMReFA4ZU9nKvX1j/CA+r3dz+dwAk7Ibi7jclEPt2WBLZmwnVzgB1+jQ
 Jej2gSRjoxUrMWW1l3FeK4CqLHPcHD1fCkLUnw20BBOZD4GIdKtUpITlXviCxSi0B/r0
 6RyOMjRshR/3tsyLkShVpVZF9i/dQpKUdkvGgcxf5v2X0/6R69AI0LzSrmyyx44jy5An
 5cFd4kH2yv09YCho60XVaYN9uXUNcoC3WpRyGd3qwsTfDLjUncid9M/wd5oIpNbjG9Zq
 o/GbZDSueayIsqpqM37GPhKuC9P1xooiG3pe1VGb1tFUo8ESnpdk+W9+YkD98oQtqrsb
 b4mw==
X-Gm-Message-State: APjAAAXu3zXCqbdp4/3bwY9zpkaMizjrLUKuOLvVo8Vd50IY6cmJTQ0F
 nYpha1c4nr8uqHqZq2w7bHNQ7M0wifV9JA+A1K13TpfdTREnt5dXHN2yZ/lLvADKm6/O6J7Qjsg
 7sq/tBoJb0kAB/5g=
X-Received: by 2002:adf:efd2:: with SMTP id i18mr32683495wrp.145.1566296754170; 
 Tue, 20 Aug 2019 03:25:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzXUqBFNaRv3SxCbR67cRhXHm+bLXJjM19jDyZ5JTRiX1Gff14Xg48P6n4NnM75O56+4d79Ew==
X-Received: by 2002:adf:efd2:: with SMTP id i18mr32683471wrp.145.1566296753950; 
 Tue, 20 Aug 2019 03:25:53 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id e9sm17016358wrt.69.2019.08.20.03.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2019 03:25:53 -0700 (PDT)
To: seabios@seabios.org, Nikolay Nikolov <nickysn@users.sourceforge.net>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fccac7fa-888e-6ac5-458d-688808f3b282@redhat.com>
Date: Tue, 20 Aug 2019 12:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] Regression with floppy drive controller
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
Cc: Alex <coderain@sdf.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[cross posting QEMU & SeaBIOS]

Hello,

I'v been looking at a QEMU bug report [1] which bisection resulted in a
SeaBIOS commit:

4a6dbcea3e412fe12effa2f812f50dd7eae90955 is the first bad commit
commit 4a6dbcea3e412fe12effa2f812f50dd7eae90955
Author: Nikolay Nikolov <nickysn@users.sourceforge.net>
Date:   Sun Feb 4 17:27:01 2018 +0200

    floppy: Use timer_check() in floppy_wait_irq()

    Use timer_check() instead of using floppy_motor_counter in BDA for the
    timeout check in floppy_wait_irq().

    The problem with using floppy_motor_counter was that, after it reaches
    0, it immediately stops the floppy motors, which is not what is
    supposed to happen on real hardware. Instead, after a timeout (like in
    the end of every floppy operation, regardless of the result - success,
    timeout or error), the floppy motors must be kept spinning for
    additional 2 seconds (the FLOPPY_MOTOR_TICKS). So, now the
    floppy_motor_counter is initialized to 255 (the max value) in the
    beginning of the floppy operation. For IRQ timeouts, a different
    timeout is used, specified by the new FLOPPY_IRQ_TIMEOUT constant
    (currently set to 5 seconds - a fairly conservative value, but should
    work reliably on most floppies).

    After the floppy operation, floppy_drive_pio() resets the
    floppy_motor_counter to 2 seconds (FLOPPY_MOTOR_TICKS).

    This is also consistent with what other PC BIOSes do.


This commit improve behavior with real hardware, so maybe QEMU is not
modelling something or modelling it incorrectly?


Regards,

Phil.


PD: How to reproduce:

- Download Windows 98 SE floppy image from [2]

- Run QEMU using the 'isapc' machine:

  $ qemu-system-i386 -M isapc \
     -fda Windows\ 98\ Second\ Edition\ Boot.img

  SeaBIOS (version rel-1.11.0-11-g4a6dbce-prebuilt.qemu.org)
  Booting from Floppy...
  Boot failed: could not read the boot disk

[1] https://bugs.launchpad.net/qemu/+bug/1840719
[2] https://winworldpc.com/download/417d71c2-ae18-c39a-11c3-a4e284a2c3a5

