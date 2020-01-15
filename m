Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D6EC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CAB214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CAB214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlvk-0007mv-3W
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arnd@arndb.de>) id 1irlgH-0004ST-5Q
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arnd@arndb.de>) id 1irlgD-0006QH-Ge
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:38:09 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:39417)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arnd@arndb.de>) id 1irlgD-0006Pi-71
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:38:05 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MDQNq-1iysPd2IrO-00AXgJ for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020
 17:38:03 +0100
Received: by mail-qt1-f169.google.com with SMTP id e5so16287643qtm.6
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 08:38:03 -0800 (PST)
X-Gm-Message-State: APjAAAU7SlsJ+l4wBoei8UhT4R/ITTllHRh4FBLP2zw/Wsc9RXLffGj0
 lSxvgNh8fIdnGv3/0g/+EjdDv+B3z5iifHUbCTw=
X-Google-Smtp-Source: APXvYqyU79v40HCVvy5/1my5dhbt6rIXsp6umrxXSt64WmYh+yeHr+OlDRwBSuluNmB+IDuImE67+xzJNOLOxNSkONs=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr4335026qtr.142.1579106282525; 
 Wed, 15 Jan 2020 08:38:02 -0800 (PST)
MIME-Version: 1.0
References: <1579103618-20217-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579103618-20217-9-git-send-email-Filip.Bozuta@rt-rk.com>
 <CAK8P3a187rPhma7Q6o+hCF3h0=5MLZwh49+JqKt6BvVsAB1efQ@mail.gmail.com>
 <ceaf44c0-fd6c-c280-7f95-7bc133553089@vivier.eu>
In-Reply-To: <ceaf44c0-fd6c-c280-7f95-7bc133553089@vivier.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Jan 2020 17:37:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a36KqWD4fKBLDpFhJg079bNdJDSDUAP2Zu_i1+H62Q6ZQ@mail.gmail.com>
Message-ID: <CAK8P3a36KqWD4fKBLDpFhJg079bNdJDSDUAP2Zu_i1+H62Q6ZQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] linux-user: Add support for setting alsa timer
 enhanced read using ioctl
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sABXv7PNOiYOscB896iJN56whtDM1X4NyV/aIcX92gGp9tzZ6fK
 ZZ/m8aJCKeoAzyzwDt6nJxk4e7KbPapJoZzYhJOQLhXcyU+/9Xmd6xlUkfi+7lfcT5SzrLd
 TFDgj7XTYpm1bmGITw4D5e6ewsqyDvyns2B3Pc0zhrcg5YMBVuEjb6PlSzbOlU2TiX4kY1s
 zk9mhFzZlZqF31/PhHFMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0H4HYFkrWcs=:zBcQCsmfK4MB0xYiGYmbSB
 zXwGzfXICHd6qTLQVxl4XugmJRxJiP9bta5inNYKQ5+ZfrI+gCT0iBS+GPTJCa+2N67GolAI6
 PysZbhkJ/opZC3A5AHgkWay1LNkYed7VZFZG2lRGe8VN2svf3htM5QsS5vc1BCXxhNChln0Ax
 tOQvx5SD8TuKkuR24zPYg6ntFkh8GZT6s0F1ArrwbpN6+kHJ9y9WYu2o4MjIUh1ngHOobZUoX
 Wwssun7a3AC/Ku9QAggqaKvgTHS+M8hhm6J/wIF1ErroBVAIAsExhz8Ev0xM8HPy+uvOLTwja
 HkEOzemq81NB8g2140mVSz8bgz/IIH93etYVcS993R01+3U13YM4dL/pElbhNRKa8nRH7UpEe
 17ZIT8DONrjxI8pZVXEoxE5KHKpNeBXj2OyRV5zzLk0HMXvkN158sQTs9V4mx9abzhXqIokgr
 /+addioVNqgQQqwMcoX50vjTzvrhuMB5NBGLPZRCPhqDcQM9fLLS2jKf+HKgO/GpPt60FMTU7
 Kk35xC5piwxpGAn0zczk28b+bFY4HlICQo8NFms9OKDZeYpon3N/yLvG4CQoBWG5BIQEl7Dfq
 gmyQSuWF0c+BpBNMUPd4+KxFmWckX6ciN5VgLMv7osG4Pqnhm+w1DyaqVVS/EjqXWStMujuKX
 eCKQNTuI97MZabwlgh02SicVhPwrsuBKjFvm1s7D3KBg+rj9Y+Cla6KQQ+aFd9FeftryTI6xQ
 daQJ8g82cNINye3ZCOob0UxP0ACXHEG5I7d+Xrg14Z1kdq3vcLGI2MUzVEsA58jQXbJio8jE6
 elL6vMbRDZAGGt+AHKXC/aLwnZqhLWzKWf4Jgt+ifeeRbCFnWXF3kimCc2X5F4hDHVSh2QZ3c
 6xJ9fAhjoJTYErJLTLKg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Filip Bozuta <Filip.Bozuta@rt-rk.com>, Max Filippov <jcmvbkbc@gmail.com>,
 amarkovic@wavecomp.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 5:32 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 15/01/2020 =C3=A0 17:18, Arnd Bergmann a =C3=A9crit :
> > On Wed, Jan 15, 2020 at 4:53 PM Filip Bozuta <Filip.Bozuta@rt-rk.com> w=
rote:
> >>
> >> This patch implements functionality of following ioctl:
> >>
> >> SNDRV_TIMER_IOCTL_TREAD - Setting enhanced time read
> >>
> >>     Sets enhanced time read which is used for reading time with timest=
amps
> >>     and events. The third ioctl's argument is a pointer to an 'int'. E=
nhanced
> >>     reading is set if the third argument is different than 0, otherwis=
e normal
> >>     time reading is set.
> >>
> >> Implementation notes:
> >>
> >>     Because the implemented ioctl has 'int' as its third argument, the
> >>     implementation was straightforward.
> >>
> >> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> >
> > I think this one is wrong when you go between 32-bit and 64-bit
>
> kernel uses an "int" and "int" is always 32bit.
> The problem is most likely with timespec I think.
>
> > targets, and it gets worse with the kernel patches that just got
> > merged for linux-5.5, which extends the behavior to deal with
> > 64-bit time_t on 32-bit architectures.
> >
> > Please have a look at
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log=
/?h=3D80fe7430c70859
>
> Yes, we already had the same kind of problem with SIOCGSTAMP and
> SIOCGSTAMPNS.
>
> Do the kernel patches add new ioctl numbers to differentiate 32bit and
> 64bit time_t?

Yes, though SNDRV_TIMER_IOCTL_TREAD is worse: the ioctl argument
is a pure 'int' that decides what format you get when you 'read' from the
same file descriptor.

For emulating 64-bit on 32-bit kernels, you have to use the new
SNDRV_TIMER_IOCTL_TREAD64, and for emulating 32-bit on
64-bit kernels, you probably have to return -ENOTTY to
SNDRV_TIMER_IOCTL_TREAD_OLD unless you also want to
emulate the read() behavior.
When a 32-bit process calls SNDRV_TIMER_IOCTL_TREAD64,
you can translate that into the 64-bit
SNDRV_TIMER_IOCTL_TREAD_OLD.

     Arnd

