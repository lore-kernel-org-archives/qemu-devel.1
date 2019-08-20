Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F80C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E31922CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E31922CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06tk-0005fz-Fp
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i06t4-0005EC-Tn
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i06t3-0006L9-8n
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:21:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i06t3-0006KR-1Y
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:21:33 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ADA96693E7
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 16:21:31 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id l16so927665wmg.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 09:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ea1RN9N8atXeGhJKNhTiAn8BJNQMPJstYaAd8WLOiHs=;
 b=sOwyEvY4WELPlE4xxBGl7omsT0ta8TOjkgHYFdOPDY8bbmUZI4yTlVvH3I3wc5jePn
 0tW+fQq5chpZNG0wTXF5M6yNAovoEqJU55FmlJtmIZ2avnKs13k7wirpNquG9ygNMAzd
 lCOy6JnrXQXm4dBdeiat/qTWJVTTrIo+DrWq0OMS6wyt3LPmHw6IIXLLWnt2Un37gBU4
 7zmdYZzk5mzTrtiVPT0lqSgaAcM3mSktZTatkCF2D3qAfGrgKQyMoTyDT0nJ3ZKz7a8N
 vriBjYPtVWICALlltfEoKQ9noddnaLsfcEuU8s/ZVE9zmElHO/F3R9t4mJPYnZ0xNJqT
 +I6Q==
X-Gm-Message-State: APjAAAVlonHFSupHpW5e5JjgEjgwzDPjWpjqXAjIZcf2VAfaDgQYUhST
 +6sDJoDyW7kj03rSs3pB4bJp90ME5uujh00necpTQ4uBKJd6AWSFilArpMzXoGIPdP5JHZFOUWb
 +ODXrgf79oXbIHho=
X-Received: by 2002:adf:e504:: with SMTP id j4mr34297422wrm.222.1566318090299; 
 Tue, 20 Aug 2019 09:21:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxCmFb0XH8cKCLQONOilq9Hd9fsyNr8TwzRqqjQNscEo+WQxbVnggU4uIm7m7673lneutusKA==
X-Received: by 2002:adf:e504:: with SMTP id j4mr34297386wrm.222.1566318090091; 
 Tue, 20 Aug 2019 09:21:30 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id t14sm12316181wrs.58.2019.08.20.09.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2019 09:21:29 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: John Snow <jsnow@redhat.com>, seabios@seabios.org,
 Nikolay Nikolov <nickysn@users.sourceforge.net>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <fccac7fa-888e-6ac5-458d-688808f3b282@redhat.com>
 <699eee57-3009-4160-a9a2-1070f92b9c20@redhat.com>
 <cc0b5a77-8bc4-070b-31e4-f29d5a174eb8@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7f6e8a5c-8262-ae39-333a-e8f18b3174f0@redhat.com>
Date: Tue, 20 Aug 2019 18:21:28 +0200
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
Cc: Alex <coderain@sdf.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Eduardo, Paolo.

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

Back from here.

So the SeaBIOS patch is:

diff --git a/src/hw/floppy.c b/src/hw/floppy.c
index 77dbade..3012b3a 100644
--- a/src/hw/floppy.c
+++ b/src/hw/floppy.c
@@ -34,6 +34,7 @@
 #define FLOPPY_GAPLEN 0x1B
 #define FLOPPY_FORMAT_GAPLEN 0x6c
 #define FLOPPY_PIO_TIMEOUT 1000
+#define FLOPPY_IRQ_TIMEOUT 5000

 #define FLOPPY_DOR_MOTOR_D     0x80 // Set to turn drive 3's motor ON
 #define FLOPPY_DOR_MOTOR_C     0x40 // Set to turn drive 2's motor ON
@@ -221,8 +222,9 @@ floppy_wait_irq(void)
 {
     u8 frs =3D GET_BDA(floppy_recalibration_status);
     SET_BDA(floppy_recalibration_status, frs & ~FRS_IRQ);
+    u32 end =3D timer_calc(FLOPPY_IRQ_TIMEOUT);
     for (;;) {
-        if (!GET_BDA(floppy_motor_counter)) {
+        if (timer_check(end)) {
             warn_timeout();
             floppy_disable_controller();
             return DISK_RET_ETIMEOUT;

timer_calc() unit is milliseconds, so this patch should wait upto
5seconds before failing, and it seems the timeout is not used at all.

SeaBIOS timer.c:

// Return the TSC value that is 'msecs' time in the future.
u32
timer_calc(u32 msecs)
{
    return timer_read() + (GET_GLOBAL(TimerKHz) * msecs);
}

static u32
timer_read(void)
{
    u16 port =3D GET_GLOBAL(TimerPort);
    if (CONFIG_TSC_TIMER && !port)
        // Read from CPU TSC
        return rdtscll() >> GET_GLOBAL(ShiftTSC);
    if (CONFIG_PMTIMER && port !=3D PORT_PIT_COUNTER0)
        // Read from PMTIMER
        return timer_adjust_bits(inl(port), 0xffffff);
    // Read from PIT.
    outb(PM_SEL_READBACK | PM_READ_VALUE | PM_READ_COUNTER0, PORT_PIT_MOD=
E);
    u16 v =3D inb(PORT_PIT_COUNTER0) | (inb(PORT_PIT_COUNTER0) << 8);
    return timer_adjust_bits(v, 0xffff);
}

Using the default QEMU config, we build SeaBIOS to use the TSC timer:

builds/seabios-128k/.config:CONFIG_TSC_TIMER=3Dy
builds/seabios-256k/.config:CONFIG_TSC_TIMER=3Dy

$ qemu-system-i386 -M isapc -cpu 486 \
  -fda Windows\ 98\ Second\ Edition\ Boot.img \
  -chardev stdio,id=3Dseabios \
  -device isa-debugcon,iobase=3D0x402,chardev=3Dseabios
Booting from Floppy...
Floppy_drive_recal 0
Floppy_enable_controller
WARNING - Timeout at floppy_wait_irq:228!
Floppy_disable_controller
Floppy_enable_controller
WARNING - Timeout at floppy_wait_irq:228!
Floppy_disable_controller
Boot failed: could not read the boot disk

Now enabling the TSC feature:

$ qemu-system-i386 -M isapc -cpu 486,tsc \
  -fda Windows\ 98\ Second\ Edition\ Boot.img \
  -chardev stdio,id=3Dseabios \
  -device isa-debugcon,iobase=3D0x402,chardev=3Dseabios
Booting from Floppy...
Floppy_drive_recal 0
Floppy_enable_controller
Floppy_media_sense on drive 0 found rate 0
Booting from 0000:7c00
Floppy_disable_controller
Floppy_enable_controller
Floppy_drive_recal 0
Floppy_media_sense on drive 0 found rate 0

Do we need a cpu with TSC support to run SeaBIOS?

So we should use '-cpu Conroe' or '-cpu core2duo' minimum?

