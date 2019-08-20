Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EEAC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10C722CF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10C722CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04hV-0003zA-V5
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i04gN-00030u-Vt
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i04gM-0003fW-3U
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:00:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i04gL-0003f2-SG
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:00:18 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8E9665F4A
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:00:16 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id c14so805394wml.5
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7l7LN8BgTucgmKGdzhp7EhxpnIEFhpY+m6f/aSq4pBo=;
 b=W/nyKFZRt7emwqNQb4UYcxnH5X3+kFElPjgpp467GTcpbzBGvgW7BQK+/Y6MS/9rF8
 ieLPb2IpMXcWkkYCFNw440P6Z2puN/RRmx7SNe1UTSq4eEDaw2LW7IgLzcySWPEAw9hb
 sfjGLBRDnXnJrvJvUuLj5ybCNmTcqM8lkT6KXcIdqSg2Zz9r6U9/T6vS9AaCxZZiTjwA
 AhWWdnVMuWqdf6cXp/J83yxjcJbwLDH59sO4+BpytVz/hgrVRkhR7Wl8VtFEctKa77Vm
 y1pFXLrds1iFJ1DGn6lvCxSwLZA3/dRLhfDiSwa9p3ePuz1rra5u/WzWPUOaebJGmQwx
 /udQ==
X-Gm-Message-State: APjAAAVSRD6IXymaOGWWlMwC6OEswJ6XqXhaG5sGGuGoIHyBej72lntp
 fqzOkMwPj464WOWlnFjVzKPGkEa6ndiM835ZG7zXfbzHqqUZYXjkZqEhOTE66YX8Gr/4yDs2o8R
 STrSb8Y6SqU9JaGw=
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr138021wmk.33.1566309615482;
 Tue, 20 Aug 2019 07:00:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxcXU2uiYnE1bHieA6BD8H46syiPkAgb0WX2tTjg48RzHmjLClV9YsaNw4ALhhjUEXo35gELg==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr138001wmk.33.1566309615288;
 Tue, 20 Aug 2019 07:00:15 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id e9sm18099609wrt.69.2019.08.20.07.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2019 07:00:14 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: John Snow <jsnow@redhat.com>, seabios@seabios.org,
 Nikolay Nikolov <nickysn@users.sourceforge.net>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <fccac7fa-888e-6ac5-458d-688808f3b282@redhat.com>
 <699eee57-3009-4160-a9a2-1070f92b9c20@redhat.com>
 <cc0b5a77-8bc4-070b-31e4-f29d5a174eb8@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1a45cee8-66e1-448d-78bc-4f0b9695cab4@redhat.com>
Date: Tue, 20 Aug 2019 16:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <cc0b5a77-8bc4-070b-31e4-f29d5a174eb8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Regression with floppy drive controller
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

On 8/20/19 3:38 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/20/19 3:12 PM, John Snow wrote:
>> On 8/20/19 6:25 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> [cross posting QEMU & SeaBIOS]
>>>
>>> Hello,
>>>
>>> I'v been looking at a QEMU bug report [1] which bisection resulted in=
 a
>>> SeaBIOS commit:
>>>
>>> 4a6dbcea3e412fe12effa2f812f50dd7eae90955 is the first bad commit
>>> commit 4a6dbcea3e412fe12effa2f812f50dd7eae90955
>>> Author: Nikolay Nikolov <nickysn@users.sourceforge.net>
>>> Date:   Sun Feb 4 17:27:01 2018 +0200
>>>
>>>     floppy: Use timer_check() in floppy_wait_irq()
>>>
>>>     Use timer_check() instead of using floppy_motor_counter in BDA fo=
r the
>>>     timeout check in floppy_wait_irq().
>>>
>>>     The problem with using floppy_motor_counter was that, after it re=
aches
>>>     0, it immediately stops the floppy motors, which is not what is
>>>     supposed to happen on real hardware. Instead, after a timeout (li=
ke in
>>>     the end of every floppy operation, regardless of the result - suc=
cess,
>>>     timeout or error), the floppy motors must be kept spinning for
>>>     additional 2 seconds (the FLOPPY_MOTOR_TICKS). So, now the
>>>     floppy_motor_counter is initialized to 255 (the max value) in the
>>>     beginning of the floppy operation. For IRQ timeouts, a different
>>>     timeout is used, specified by the new FLOPPY_IRQ_TIMEOUT constant
>>>     (currently set to 5 seconds - a fairly conservative value, but sh=
ould
>>>     work reliably on most floppies).
>>>
>>>     After the floppy operation, floppy_drive_pio() resets the
>>>     floppy_motor_counter to 2 seconds (FLOPPY_MOTOR_TICKS).
>>>
>>>     This is also consistent with what other PC BIOSes do.
>>>
>>>
>>> This commit improve behavior with real hardware, so maybe QEMU is not
>>> modelling something or modelling it incorrectly?
> [...]
>>
>> Well, that's unfortunate.
>>
>> What version of QEMU shipped the SeaBIOS that caused the regression?
>=20
> See https://bugs.launchpad.net/qemu/+bug/1840719/comments/3
>=20
> QEMU commit 0b8f74488e, slighly before QEMU v3.1.0
> (previous tag is v3.0.0).
>=20
> But you can use v4.1.0 too, simply change the SeaBIOS bios.bin, i.e.:
>=20
>   qemu$ git checkout v4.1.0
>=20
>   qemu$ (cd roms/seabios && git checkout 4a6dbcea3e4~) && \
>         make -C roms bios
>=20
> Now pc-bios/bios.bin is built using the last commit working,
>=20
>   qemu$ (cd roms/seabios && git checkout 4a6dbcea3e4) && \
>         make -C roms bios
>=20
> And you can reproduce the error.

Looking at the fdc timer I noticed it use a static '50 ns' magic value.

Increasing this value allows the floppy image to boot again, using this
snippet:

-- >8 --
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 9b24cb9b85..5fc54073fd 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2134,7 +2134,7 @@ static void fdctrl_handle_readid(FDCtrl *fdctrl,
int direction)

     cur_drv->head =3D (fdctrl->fifo[1] >> 2) & 1;
     timer_mod(fdctrl->result_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
) +
-             (NANOSECONDS_PER_SECOND / 50));
+             (NANOSECONDS_PER_SECOND / 5000));
 }

 static void fdctrl_handle_format_track(FDCtrl *fdctrl, int direction)
---

Any idea what is the correct value to use here?

Regards,

Phil.

