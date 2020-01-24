Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C53C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F4920708
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UL8Ko1a4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F4920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuyYj-00041c-UA
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 07:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuyY2-0003KC-15
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuyY0-00057F-PL
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:58:53 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuyY0-00056C-Ip
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:58:52 -0500
Received: by mail-oi1-x244.google.com with SMTP id l7so1698460oil.12
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 04:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yP7QfpEU56++xnOHFKaFalevPO1YD+HjvVgBb9MUpRQ=;
 b=UL8Ko1a4UWgJ28hHas9TUNXZOwqkzBdeB31mJ3+JCQUl4kO5UzN4PL6biEXH6KIPKv
 0OuFxDFKxgZ0YbS3PApf+Et1wMZafhgQAPP43v3d9Ap3WbiGwIetW7wwSO87X1RpX522
 FYbdCgo8FlLbv6PVARLg82/ZBmmPSzca8Cs21zZ49OEqNIZOeOYMtmLz95aER6IgAIDm
 6Mq4Vu2xTNvG47/Gw2YgN+3+thvARdRdUuJdAI4eQXBSKYojxu6JVHaqYHmdzjQDhZ9x
 LCqBf6jcG7GR5Gx95SABNcZKGiYuKlq0CnJMvEGVKzH75sJP48XCHUWNL++aIu5SGsB2
 BSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yP7QfpEU56++xnOHFKaFalevPO1YD+HjvVgBb9MUpRQ=;
 b=Lfvut4eklglkV+wvzudJrBCuNDlfh2qaZrPvLQmauLfBgj75XpoTOGJO8NgnkdlQ2S
 vDDyi8RWJ1nRCW5oeT4/VSazu02Tpv993rNcm2FzfgM4ktajpDJbugzD8fEPSCq4JeJd
 Kbmsmo7svDKNol31bGaLTcYZGnf3xbqxTGObgJFMCGxw/9BqQBXqFMDL+v4Da1YU8aT6
 HzZ23q/kjNCegAJbG/jlYiQgkVxLAy+SOG84M3W2gOjhP5IZbA4Cd4qQE5D5P1ypwOpC
 ZcFfL/DKLTkRHW+w4HufqicuFsYuhyDK3wztcSCIu1twACqyXwbJ3ywNhzOEvmyRm+UP
 zsRA==
X-Gm-Message-State: APjAAAUXtX+g8ChDB3JtdcEETlxji85oxBy4luUgHwFEqDHHyu0/HJ4W
 yBsQ4qEqv2es1Q9BnfGCp6gjNkOx9Bmwn322xvF5wg==
X-Google-Smtp-Source: APXvYqwodPgS+HQq5M1jDaTFVhF5wLpX1q/kLblH3tZm4gMFplIymd168LH9Z/R4fWbdtB/luuoHMrSPHW68dYsRNAs=
X-Received: by 2002:aca:570d:: with SMTP id l13mr1861985oib.146.1579870731489; 
 Fri, 24 Jan 2020 04:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20200109141858.14376-1-alex.bennee@linaro.org>
 <20200109141858.14376-12-alex.bennee@linaro.org>
In-Reply-To: <20200109141858.14376-12-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 12:58:40 +0000
Message-ID: <CAFEAcA-os-6iWZ-ucM-VUECyf8sn-xoANHCqJqtSyuttgZY23A@mail.gmail.com>
Subject: Re: [PULL v2 11/14] semihosting: add qemu_semihosting_console_inc for
 SYS_READC
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Keith Packard <keithp@keithp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jan 2020 at 14:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> From: Keith Packard <keithp@keithp.com>
>
> Provides a blocking call to read a character from the console using
> semihosting.chardev, if specified. This takes some careful command
> line options to use stdio successfully as the serial ports, monitor
> and semihost all want to use stdio. Here's a sample set of command
> line options which share stdio between semihost, monitor and serial
> ports:

Hi; Coverity has some complaints about this code, and
specifically the use of getchar():

> +/*
> + * For linux-user we can safely block. However as we want to return as
> + * soon as a character is read we need to tweak the termio to disable
> + * line buffering. We restore the old mode afterwards in case the
> + * program is expecting more normal behaviour. This is slow but
> + * nothing using semihosting console reading is expecting to be fast.
> + */
> +target_ulong qemu_semihosting_console_inc(CPUArchState *env)
> +{
> +    uint8_t c;
> +    struct termios old_tio, new_tio;
> +
> +    /* Disable line-buffering and echo */
> +    tcgetattr(STDIN_FILENO, &old_tio);
> +    new_tio =3D old_tio;
> +    new_tio.c_lflag &=3D (~ICANON & ~ECHO);
> +    tcsetattr(STDIN_FILENO, TCSANOW, &new_tio);
> +
> +    c =3D getchar();

CID 1412794 points out that this assigns the result
of getchar() to a uint8_t, which drops the distinction
between EOF and a legitimate byte.
CID 1412795 is then kind of a run-on error from that,
complaining that the int result from getchar() is
truncated before returning it.

I'm not sure what we should do with EOF, but presumably
we should handle it in some way.

thanks
-- PMM

