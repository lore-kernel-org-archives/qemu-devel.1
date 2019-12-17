Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32936C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 13:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F0E206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 13:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rn8jqi5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F0E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihD8V-0002VH-3m
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 08:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihD7o-00026d-Gj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihD7m-00045O-W6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:42:56 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihD7m-00042v-Mu
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:42:54 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so3208044wmi.5
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 05:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aI8FRt6gMNkzQ3NSwFBE3OcYXv1YpvqQnALfuHKrT4k=;
 b=rn8jqi5MN7I3O3dRsLttryixDgj2U6YQdNdTtH9dCFWeVzJslgpwr2hifmvctDsowt
 qDwbTagXv/NE5UGo3EX9F7I//K5U8PwPGEvgQACoqHd9W2nfDhRAr727pH2Qef8HO/zK
 7HkV/MCEomGNj8h3ZX/b2y5RxYaKQwTWyWpbC5u1prf6Ji3mugFIIJJxLx8PwcJThryE
 OSjbShL7/Qx/q8kzDWjQr2AqXuT1S3n7qh9z8exXbkfUjc5GIDsGervpfnEbEBK9I6v4
 Br/VZvdnoVq+5p97WewCr/hbZ3x51Xuzhwfleq7O2hmeSt7SvqG//X7JTP1kHES8S2Wh
 H+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aI8FRt6gMNkzQ3NSwFBE3OcYXv1YpvqQnALfuHKrT4k=;
 b=SaTDhST7yELis0WlRZ2+ADmzLjZyR/rr9EPooGkvAL2MfvyIM6b5FXct/mxYTUeWgr
 MoMaLCebTwgcKTTzSBUZBPzmepB6H8v/u3EhqDLpLK0i6K2gjbaA+flBb5TKOv2TwN0g
 iP+8kX8UNg7MsbsWR0FJVp6ajTY/POpVGIXsqs6wCnUKdN3DcamlM8RiAky7kyKihgp0
 yOeQgc6mtAYczulyxoHoxlTldj1PX29kC/hkk5HYM/OR0rBYIj33QWqLe7RlUBRCiz35
 wy+JoO+aXlrsTE7O+be4si8WIRAeJzj+GQrbsfAOexodJ1Wt1r14A6T+qEVXL4FZStj4
 hvkg==
X-Gm-Message-State: APjAAAWE0z2nEnbIXgB6y2RHDomUhjANw7mGh47OKxHAv/o4f1YpmMR9
 mQu1sb5Nqn4nf2SSrlvxmKsqag==
X-Google-Smtp-Source: APXvYqyxgxV2oH/Br4Y95CeMb2YylncC+EtioyrTNmFhYKLHsnhvFwENP0rkNIFF7ujlDiiaVD32qQ==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr5666898wml.50.1576590169866; 
 Tue, 17 Dec 2019 05:42:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a14sm26701755wrx.81.2019.12.17.05.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 05:42:48 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F089A1FF87;
 Tue, 17 Dec 2019 13:42:47 +0000 (GMT)
References: <77dd4863-6301-b17d-529c-451d491d4794@redhat.com>
 <20191217121443.14757-1-alex.bennee@linaro.org>
 <1ca001f0-43a5-d8fc-fee0-3a318cc698e5@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] semihosting: suspend recieving CPU when blocked
 (HACK, WIP)
In-reply-to: <1ca001f0-43a5-d8fc-fee0-3a318cc698e5@redhat.com>
Date: Tue, 17 Dec 2019 13:42:47 +0000
Message-ID: <87bls7vzjc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: keithp@keithp.com, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 17/12/19 13:14, Alex Benn=C3=A9e wrote:
>> [AJB:
>>=20
>> So this at least solves the hang of not being able to quit system
>> emulation while blocked. However there are two things we still need to
>> ensure:
>>=20
>>  - the PC has not advanced until completion so we can redo the instructi=
on
>>  - we actually wake up the CPU in console_read
>>=20
>> In my testcase console_read never seems to get called. I've tried with
>> both an external pipe loopback and using the ringbuf:
>>=20
>> qemu-system-aarch64 -M virt --display none -cpu cortex-a57 -kernel syste=
st-a64-with-console.axf -semihosting-config
>>  enable=3Don,chardev=3Dsh0 -serial mon:stdio -chardev ringbuf,logfile=3D=
foo,id=3Dsh0
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  include/exec/cpu-all.h   |  1 +
>>  hw/semihosting/console.c | 34 +++++++++++++++++-----------------
>>  2 files changed, 18 insertions(+), 17 deletions(-)
>>=20
>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>> index e96781a4559..093d7a76edd 100644
>> --- a/include/exec/cpu-all.h
>> +++ b/include/exec/cpu-all.h
>> @@ -31,6 +31,7 @@
>>  #define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external =
event) */
>>  #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to anot=
her */
>>  #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
>> +#define EXCP_BLOCKED    0x10006 /* cpu is blocked (semihosting) */
>>=20=20
>>  /* some important defines:
>>   *
>> diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
>> index 4db68d62270..bda457a0608 100644
>> --- a/hw/semihosting/console.c
>> +++ b/hw/semihosting/console.c
>> @@ -20,6 +20,7 @@
>>  #include "hw/semihosting/semihost.h"
>>  #include "hw/semihosting/console.h"
>>  #include "exec/gdbstub.h"
>> +#include "exec/exec-all.h"
>>  #include "qemu/log.h"
>>  #include "chardev/char.h"
>>  #include <pthread.h>
>> @@ -109,50 +110,49 @@ void qemu_semihosting_console_outc(CPUArchState *e=
nv, target_ulong addr)
>>=20=20
>>  typedef struct SemihostingConsole {
>>      CharBackend         backend;
>> -    pthread_mutex_t     mutex;
>> -    pthread_cond_t      cond;
>> +    CPUState            *sleeping_cpu;
>>      bool                got;
>>      Fifo8               fifo;
>>  } SemihostingConsole;
>>=20=20
>> -static SemihostingConsole console =3D {
>> -    .mutex =3D PTHREAD_MUTEX_INITIALIZER,
>> -    .cond =3D PTHREAD_COND_INITIALIZER
>> -};
>> +static SemihostingConsole console;
>>=20=20
>>  static int console_can_read(void *opaque)
>>  {
>>      SemihostingConsole *c =3D opaque;
>>      int ret;
>> -    pthread_mutex_lock(&c->mutex);
>> +    g_assert(qemu_mutex_iothread_locked());
>>      ret =3D (int) fifo8_num_free(&c->fifo);
>> -    pthread_mutex_unlock(&c->mutex);
>>      return ret;
>>  }
>>=20=20
>>  static void console_read(void *opaque, const uint8_t *buf, int size)
>>  {
>>      SemihostingConsole *c =3D opaque;
>> -    pthread_mutex_lock(&c->mutex);
>> +    g_assert(qemu_mutex_iothread_locked());
>>      while (size-- && !fifo8_is_full(&c->fifo)) {
>>          fifo8_push(&c->fifo, *buf++);
>>      }
>> -    pthread_cond_broadcast(&c->cond);
>> -    pthread_mutex_unlock(&c->mutex);
>> +    if (c->sleeping_cpu) {
>> +        cpu_resume(c->sleeping_cpu);
>> +    }
>>  }
>>=20=20
>>  target_ulong qemu_semihosting_console_inc(CPUArchState *env)
>>  {
>>      uint8_t ch;
>>      SemihostingConsole *c =3D &console;
>> -    qemu_mutex_unlock_iothread();
>> -    pthread_mutex_lock(&c->mutex);
>> -    while (fifo8_is_empty(&c->fifo)) {
>> -        pthread_cond_wait(&c->cond, &c->mutex);
>> +    g_assert(qemu_mutex_iothread_locked());
>> +    g_assert(current_cpu);
>> +    if (fifo8_is_empty(&c->fifo)) {
>> +        c->sleeping_cpu =3D current_cpu;
>> +        c->sleeping_cpu->stop =3D true;
>> +        c->sleeping_cpu->exception_index =3D EXCP_BLOCKED;
>
> Why do you need to set exception_index to something other than -1 (using
> cpu_loop_exit_noexc for example)?

If there is no exception to process we won't exit the main loop which we
need to do if we want to wait until there is data to read.

> Using ->stop here is a bit weird, since ->stop is usually related to
> pause_all_vcpus.

Arguably we could come up with a better API to cpu.c but this allows us
to use cpu_resume(c->sleeping_cpu) when waking up rather than hand
rolling our own wake-up mechanism.

>
> Paolo


--=20
Alex Benn=C3=A9e

