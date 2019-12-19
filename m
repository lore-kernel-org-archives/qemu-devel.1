Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0D5C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD726206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="giXFkS34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD726206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtm2-00008h-Kd
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtku-0006ye-5q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtks-0001oG-Fs
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:14:07 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtks-0001ge-3N
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:14:06 -0500
Received: by mail-wr1-x444.google.com with SMTP id d16so5535735wre.10
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 03:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VchYwTa2XZqXtmbNsj17z0nYkcR5SFWBD4w1ltQiuOs=;
 b=giXFkS34AnJyf72FIsuqEn1+uy5V3xNnK5y9ZDzXmwpM/iqIRnAE6WhQElQPQZ+EXk
 ZxhZFmS7k9gTPxQ3zp8VUIHtLO61MFxcvjTxgSAVj9VV+h9BvGl9/tcTgtKnwMUytxkH
 9bAleAaGRNusAmRrRQcylQiEwYIlitMlmixUZOhUfiPDhKdJVlepbo8E6bAX58AkIAM9
 Jkwdg1V/qCvhU9KEjmtDdlw6P78ajHDwb8n3sMBlxYr1sCL9erfqv0o66RPdeU5WSZ6y
 3YpGgF6k49lBaUnNjE441ZUQJuUauiMJDNvahKOGcNAE5Z+IZfdQszJWwDStN0qoR0il
 pmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VchYwTa2XZqXtmbNsj17z0nYkcR5SFWBD4w1ltQiuOs=;
 b=fqIPF63zuLi5cc9NFNiPq6YM4+Ncluni8ZdCvd9uLhhnCCR6qVxcBV00tXPD+FLAFt
 TO9ILba2PUrkGoDXVIAEVA8YNEMEgkc98/lA2Of9Oy/liFJBVzLrql7ugUMX22UJeuvv
 BE3+72TyLNw8NnRa32a77AZ6oxXGpY4LvflYI9QC+OlxLIuPbatXhSF9Cj8I06WiIeWI
 ZbYT6AEv+h7ZYZBM6pGFwqH8XgTVJTVKKrII3RzkPczY94w+me7dHckLf9iMa2hbsjSE
 bmZv0RiLLdX+rTzDD9AZWOFCxySW0ynSeqPgrNpz96ipq3lwol31Nb+hEPc0RscpJzL4
 +wyA==
X-Gm-Message-State: APjAAAU0ssmvzn6hcRm5nwIYGr8g3KBQP32xOoVK+XHe4wL4D4+zFx8E
 yXOgOoRnV36aOgNLIgb2PF5ZNw==
X-Google-Smtp-Source: APXvYqwpvNuavAY7KsgD9NvMVbGYQI7HztWiALQ3LAp5QxUVp8JeIiYqxIaFuMCcopa9zpZb1DxogA==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr9417416wrp.17.1576754044251;
 Thu, 19 Dec 2019 03:14:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c15sm6022465wrt.1.2019.12.19.03.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 03:14:02 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA3A81FF87;
 Thu, 19 Dec 2019 11:14:01 +0000 (GMT)
References: <20191218180029.6744-1-alex.bennee@linaro.org>
 <20191218180029.6744-4-alex.bennee@linaro.org>
 <5ca1462e-5129-2b32-f014-a732a26a0587@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 3/4] semihosting: add qemu_semihosting_console_inc
 for SYS_READC
In-reply-to: <5ca1462e-5129-2b32-f014-a732a26a0587@linaro.org>
Date: Thu, 19 Dec 2019 11:14:01 +0000
Message-ID: <87v9qcefeu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 12/18/19 8:00 AM, Alex Benn=C3=A9e wrote:
>> From: Keith Packard <keithp@keithp.com>
>>=20
>> Provides a blocking call to read a character from the console using
>> semihosting.chardev, if specified. This takes some careful command
>> line options to use stdio successfully as the serial ports, monitor
>> and semihost all want to use stdio. Here's a sample set of command
>> line options which share stdio betwen semihost, monitor and serial
>
> between.
>
>> +/**
>> + * qemu_semihosting_console_inc:
>> + * @env: CPUArchState
>> + *
>> + * Receive single character from debug console. This may be the remote
>> + * gdb session if a softmmu guest is currently being debugged. As this
>> + * call may block if no data is available we suspend the CPU and will
>> + * rexecute the instruction when data is there. Therefor two
>
> re-execute, Therefore
>
>> + * conditions must be met:
>> + *   - CPUState is syncronised before callinging this function
>
> synchronized, calling
>
>> + *   - pc is only updated once the character is succesfully returned
>
> successfully.
>
>
>> +static int console_can_read(void *opaque)
>> +{
>> +    SemihostingConsole *c =3D opaque;
>> +    int ret;
>> +    g_assert(qemu_mutex_iothread_locked());
>> +    ret =3D (int) fifo8_num_free(&c->fifo);
>> +    return ret;
>> +}
>
> Boolean result; better as
>
>   return fifo8_num_free(&c->fifo) > 0
>
> (We could usefully change IOCanReadHandler to return bool to emphasize
> this.)

It's documented as the amount you can read and other handlers return
amounts as well. I'm not sure I want to go messing with the chardev code
in this series (although I need to look at Phillipe's series).

>
>> +static void console_wake_up(gpointer data, gpointer user_data)
>> +{
>> +    CPUState *cs =3D (CPUState *) data;
>> +    /* cpu_handle_halt won't know we have work so just unbung here */
>> +    cs->halted =3D 0;
>> +    qemu_cpu_kick(cs);
>> +}
>> +
>> +static void console_read(void *opaque, const uint8_t *buf, int size)
>> +{
>> +    SemihostingConsole *c =3D opaque;
>> +    g_assert(qemu_mutex_iothread_locked());
>> +    while (size-- && !fifo8_is_full(&c->fifo)) {
>> +        fifo8_push(&c->fifo, *buf++);
>> +    }
>> +    g_slist_foreach(c->sleeping_cpus, console_wake_up, NULL);
>> +}
>
> I think you should be clearing sleeping_cpus here, after they've all been=
 kicked.
>
>> +target_ulong qemu_semihosting_console_inc(CPUArchState *env)
>> +{
>> +    uint8_t ch;
>> +    SemihostingConsole *c =3D &console;
>> +    g_assert(qemu_mutex_iothread_locked());
>> +    g_assert(current_cpu);
>> +    if (fifo8_is_empty(&c->fifo)) {
>> +        c->sleeping_cpus =3D g_slist_prepend(c->sleeping_cpus, current_=
cpu);
>> +        current_cpu->halted =3D 1;
>> +        current_cpu->exception_index =3D EXCP_HALTED;
>> +        cpu_loop_exit(current_cpu);
>> +        /* never returns */
>> +    }
>> +    c->sleeping_cpus =3D g_slist_remove_all(c->sleeping_cpus, current_c=
pu);
>
> Which would mean you would not have to do this, because current_cpu is on=
ly on
> the list when it is halted.
>
> I presume all semihosting holds the BQL before we reach here, and we are =
not
> racing on this datastructure?

Yeah this is all under BQL - which I assert is the case. I'll add a
comment to the structure.

>
>> +target_ulong qemu_semihosting_console_inc(CPUArchState *env)
>> +{
>> +    uint8_t c;
>> +    struct pollfd pollfd =3D {
>> +        .fd =3D STDIN_FILENO,
>> +        .events =3D POLLIN
>> +    };
>> +
>> +    if (poll(&pollfd, 1, -1) !=3D 1) {
>> +        qemu_log_mask(LOG_UNIMP, "%s: unexpected read from stdin failur=
e",
>> +                      __func__);
>> +        return (target_ulong) -1;
>> +    }
>
> Why are you polling stdin?  linux-user isn't system mode, there isn't a
> separate monitor thread to get blocked, and you aren't even blocking the =
thread
> to try again just returning -1 to the guest.

Hmm not sure - I guess we should just bite the bullet and potentially
block here. semihosting is linux-user is a bit of a weird use case
because we are not providing "hardware" but it seems it is used by a
bunch of testcases that want to test things like M-profile non-glibc
binaries without the baggage of a full simulation.

>
>
> r~


--=20
Alex Benn=C3=A9e

