Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C8C33CB6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 21:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7172072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 21:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7172072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isZS7-0007Gc-Tv
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 16:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arnd@arndb.de>) id 1isZR9-00069f-IM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arnd@arndb.de>) id 1isZR7-0004Pk-Av
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:45:51 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:55753)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arnd@arndb.de>) id 1isZR7-0004OA-1l
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:45:49 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mleo0-1jIWKp2rWU-00ioda for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020
 22:45:45 +0100
Received: by mail-qt1-f173.google.com with SMTP id j5so22929827qtq.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 13:45:45 -0800 (PST)
X-Gm-Message-State: APjAAAXCN5xRdWFgcW4uIqTRmFuxVvlNYhcR0w2KiVWMWAcOf1z5ejVP
 M7cdOORQ7eifuhNani4lkrRmTCIOhChWcfCgoBw=
X-Google-Smtp-Source: APXvYqwPGUg2H2r+FAIwNs270IiUt3Q8Te08RmlCLLcJAdJj3kQoY7zwhAIoZXheX7+d59yilF2roefgV6MzK67YWn4=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr9463965qtr.142.1579297544415; 
 Fri, 17 Jan 2020 13:45:44 -0800 (PST)
MIME-Version: 1.0
References: <1579103618-20217-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579103618-20217-9-git-send-email-Filip.Bozuta@rt-rk.com>
 <CAK8P3a187rPhma7Q6o+hCF3h0=5MLZwh49+JqKt6BvVsAB1efQ@mail.gmail.com>
 <ceaf44c0-fd6c-c280-7f95-7bc133553089@vivier.eu>
 <CAK8P3a36KqWD4fKBLDpFhJg079bNdJDSDUAP2Zu_i1+H62Q6ZQ@mail.gmail.com>
 <518d717d-9f1e-e00e-f2a9-df8861241d1c@rt-rk.com>
 <cdcce2a3-00f5-f6d1-3083-dc36892ac5b4@vivier.eu>
 <CAL1e-=i3-nYJMo6ptA7fdcK8r6P4vv20x2+LLV6BA9ELO8H53w@mail.gmail.com>
 <CAL1e-=g8X___59zLPKLRjFNAP9bs3rVWhc8+OhMuF3TriBiynw@mail.gmail.com>
 <CAK8P3a3o1tM__gP0keo0Dg03tiJQt=5hRGhiXWga4B6gjsVbxA@mail.gmail.com>
 <CAL1e-=gv_L0fuq9t8mmOiZ2D-CwpPrZZOjwrDwKwe09jvWJpXQ@mail.gmail.com>
In-Reply-To: <CAL1e-=gv_L0fuq9t8mmOiZ2D-CwpPrZZOjwrDwKwe09jvWJpXQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Jan 2020 22:45:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1YrK4_Xx13821P58rn1L_xZN5gJYt-Pef+aHdM-_V85g@mail.gmail.com>
Message-ID: <CAK8P3a1YrK4_Xx13821P58rn1L_xZN5gJYt-Pef+aHdM-_V85g@mail.gmail.com>
Subject: Re: [PATCH 08/12] linux-user: Add support for setting alsa timer
 enhanced read using ioctl
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TXbnEuL45ZG/BBn9x5SffuKFdRET6KqtXc8S59Qsei3PHiTUk77
 eYjsENyIvSlva2hw5nXSF/JS95OYlRalXCV5S1bUJP7nMhJGPKBT/LNzC53jODNf65Her1W
 LfG00WoooD5mql1xnwV7+C08l/wAZezITZUZTlfYlBrurxUmq3Kw5swg/xBBbBvx/9c5MmM
 cUoEnYeq9j4PcSNxGW2EA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YJ+6DRC+M1U=:dn/84lbLcps/j8l429bYFX
 /er8B44Og6B9tBOfuqybVhSBfl1O8kr5mi+3Cp5WgSftPu7qrbmLc3Gj/CBrlOeYI9N+x4ZRY
 Ng+MJOUlciHHCZtOfQ11dqkUEiM0Ah/iYNwQZTj5xjN+b45yKexcNrTxan7JGi1/3crdEOFKL
 l6RQhSyseXkSSfTe8nmKjnuCc7DOGwJDIz705jNGKKMqeaosUOuuHSpFFutkACzS7tF9j1v1F
 9py88sOfFKiqn1KO1AhcWc+VB+KlHXgt4ErkrCs9An+F6GXHwKr1we5r+Ms08tqe9D/o/qn91
 YxP2boVq2GcAdNbY08iO8QhJzWT9agVLDhZt3yCE+y00NMZLTARg9WL1DJ4ap4h8jaDMgdDga
 1JdPOxjLDY88aAOBDE4m+C3tEHKyEA537e/mm/Zyw0Xdl3EcPBuoOoHAWyYh4kWbx05G6B6mU
 EY1UgIk73R75091//1x+gGCg/p88dWbv7M15IW5rVXV45BQg4YR0eRR6BDnpIUotPsQvHSjWJ
 SEi8s2v5HG+fZ+HYfwrPwxGKBgoch0xZoGpHdKd9Imp1rtiEtzpe1fJx4nPwz+6zX8bXx/ECP
 jsLCjEMVXYXkZbz9UYXpyKb1EgMu5Org6qVbMf2+OK4Jq7Vd2GIEY7ch5EOacIvCQ98CUhLIs
 9LWVSt6bRiqCC4EV7gRYPPxi5D/Pl2Ud3MqASgthmK7HefvcuvxKs0mn6ATfkcBGcop3zNxI/
 xcctCs82BZ74iOQgjasjOTmFp1+EO0Y29kyC+XoMHDXnT+bMkWINYpIBFLQL2kzd6gXx30nOV
 HEIPnUN+UBy+RLv+6I2sQPt3GriESYfbps/oF8ClQQEZF9n3Luydyee2NC8OhGGasgEIAj7Xk
 7KQZdMGE02GIGAWxIQJw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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
Cc: linux-rtc@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 17, 2020 at 9:50 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:

> Alexandre (and Arnd too, or any other person knowledgeable in the area),
>
> I just need to clarify a couple of details with you, please.
>
> Firstly, here is what man page rtc(4) says:
>
> "The /dev/rtc (or /dev/rtc0, /dev/rtc1, etc.) device can be opened
> only once (until it is closed) and it is read-only. On read(2) and
> select(2) the calling process is blocked until the next interrupt from
> that RTC is received. Following the interrupt, the process can read a
> long integer, of which the least significant byte contains a bit mask
> encoding the types of interrupt that occurred, while the remaining 3
> bytes contain the number of interrupts since the last read(2)."
>
> So, it looks read() will always return only 4 bytes of useful info
> (regardless of host being 32-bit/64-bit).

It says "long integer", which is 64-bit on a 64-bit machine.

> My questions are:
>
> - Is the description in man page genuinely accurate?

Starting with linux-2.6.18, there is another possibility: If an
application asks for exactly four bytes on a 64-bit kernel,
it gets the lower four bytes, as it would on a 32-bit kernel.

This is a hack that was introduced for running 32-bit compat
tasks.

For any other size less than sizeof(long), the kernel reports
an EINVAL error, and for anything larger or equal to sizeof(long)
it attempts to output a long word.

> - To me (but I am really an outsider to using RTC in applications),
> this feature (blocking read()/select()) even looks very nice and
> convenient, in all fairness. But I would like to ask you: Is this
> feature used rarely or frequently by other libraries/tools/etc.? In
> other words, is the feature "obscure" or "crucial" part of RTC kernel
> support? Or, something in between?

> - Does MC146818 support this feature?

No idea, I'll leave these for Alexandre or someone else to answer.

      Arnd

