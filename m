Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873E3C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 22:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B05D2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 22:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B05D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isZla-0005FP-Bq
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 17:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexandre.belloni@bootlin.com>) id 1isZZr-0002eH-Nc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexandre.belloni@bootlin.com>) id 1isZZq-0004hU-0T
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:54:51 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:58851)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alexandre.belloni@bootlin.com>)
 id 1isZZp-0004fC-Qj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:54:49 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr
 [90.65.92.102]) (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B79F11BF207;
 Fri, 17 Jan 2020 21:54:44 +0000 (UTC)
Date: Fri, 17 Jan 2020 22:54:44 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH 08/12] linux-user: Add support for setting alsa timer
 enhanced read using ioctl
Message-ID: <20200117215444.GD3036@piout.net>
References: <1579103618-20217-9-git-send-email-Filip.Bozuta@rt-rk.com>
 <CAK8P3a187rPhma7Q6o+hCF3h0=5MLZwh49+JqKt6BvVsAB1efQ@mail.gmail.com>
 <ceaf44c0-fd6c-c280-7f95-7bc133553089@vivier.eu>
 <CAK8P3a36KqWD4fKBLDpFhJg079bNdJDSDUAP2Zu_i1+H62Q6ZQ@mail.gmail.com>
 <518d717d-9f1e-e00e-f2a9-df8861241d1c@rt-rk.com>
 <cdcce2a3-00f5-f6d1-3083-dc36892ac5b4@vivier.eu>
 <CAL1e-=i3-nYJMo6ptA7fdcK8r6P4vv20x2+LLV6BA9ELO8H53w@mail.gmail.com>
 <CAL1e-=g8X___59zLPKLRjFNAP9bs3rVWhc8+OhMuF3TriBiynw@mail.gmail.com>
 <CAK8P3a3o1tM__gP0keo0Dg03tiJQt=5hRGhiXWga4B6gjsVbxA@mail.gmail.com>
 <CAL1e-=gv_L0fuq9t8mmOiZ2D-CwpPrZZOjwrDwKwe09jvWJpXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1e-=gv_L0fuq9t8mmOiZ2D-CwpPrZZOjwrDwKwe09jvWJpXQ@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.70.183.201
X-Mailman-Approved-At: Fri, 17 Jan 2020 17:04:39 -0500
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Quick answers to your very good questions below:

On 17/01/2020 21:50:34+0100, Aleksandar Markovic wrote:
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
> 
> My questions are:
> 
> - Is the description in man page genuinely accurate?
> 

It is accurate. It is a mask of:

#define RTC_IRQF 0x80   /* Any of the following is active */
#define RTC_PF 0x40     /* Periodic interrupt */
#define RTC_AF 0x20     /* Alarm interrupt */
#define RTC_UF 0x10     /* Update interrupt for 1Hz RTC */

Which will most likely be RTC_IRQF | RTC_AF.

> - To me (but I am really an outsider to using RTC in applications),
> this feature (blocking read()/select()) even looks very nice and
> convenient, in all fairness. But I would like to ask you: Is this
> feature used rarely or frequently by other libraries/tools/etc.? In
> other words, is the feature "obscure" or "crucial" part of RTC kernel
> support? Or, something in between?
> 

Nobody is actually using the return value.

> - Does MC146818 support this feature?
> 

This feature is implemented in the RTC core so it is supported by all
RTCs that have alarms.

Internally, the value is an unsigned long and it is casted properly by
put_user in rtc_dev_read:

https://elixir.bootlin.com/linux/v5.4/source/drivers/rtc/dev.c#L178

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

