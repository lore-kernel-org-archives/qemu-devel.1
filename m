Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5410EC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 07:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B47A20645
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 07:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B47A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35925 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMSWb-0007Eo-9s
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 03:22:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMSVi-0006u3-Id
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMSVe-0004sQ-SY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:21:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34649)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMSVZ-0004pL-9r; Fri, 03 May 2019 03:21:27 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MA88C-1hSSm51NJy-00BfhQ; Fri, 03 May 2019 09:21:19 +0200
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers
	<qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>,
	qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
	<marcandre.lureau@redhat.com>
References: <20190419154041.77802-1-stephen.checkoway@oberlin.edu>
	<45e6247e-cddb-2185-7f7b-503be00bd453@vivier.eu>
	<f61fc519-da75-5b41-21d0-508cf89016f2@redhat.com>
	<fc4a45ba-08d0-59ba-80eb-10a08cda3b7d@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <af92f288-7159-b7ad-3360-5c2bb9b392f6@vivier.eu>
Date: Fri, 3 May 2019 09:21:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <fc4a45ba-08d0-59ba-80eb-10a08cda3b7d@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IaRGgoXUbowM2FyeOKOLzDzVjVYD6YnOcBE1mUntBVoX7+58ASg
	Wm7v2fo3bQnTcWKSMELhfpKlH2o3F3XpntBkfLyps8eyy4jh7Ue0DC5d/pPWiC/kxGXBEMX
	vOgwiof6GPVHlZ7z5xth+4kxrSsScAPuFck1JDPF+RGOa2e3qglA+yaqGXM800AEhYOCkY9
	0oQmFYU9qQPK7qQSTDkLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/NL1IKTiwQA=:zTOgbwKkBmuHhLUiyuMAMl
	8mRa79ceknQTZJF3hPNhcX7C5aql1b/Zqtse1v7P7qW8IPUG71pB17syrBhYJFDj67btXnCOu
	Ph7XSE0ch7/UAW/yFbjNQqFjDa1YCl9KwAg0JnyxP1n8APkcvBJRwOwKvlzSrpbH7ytSiWLRM
	YPOej0KJTlGkhfeMhfhJJnoUUTvPLndfw8mlphd4GdCRhAT4fy0J2N08bEA7asM6+TBOFi3Z5
	U7GzQebQK5rKQsDCoUhb23cGRRVLL1lMw6zwYuHuqvb/Y0J6CUOrq6L5LpXBeWKfoPNYF3r+E
	zRQOUHiCEHyjwhudg9Vj0FQzSuIltDET4peSaB98SivsqH4eHVNzFUuo75QwpghyhXceTxw7j
	J+/eB3xdveTD1bAKIo4wW1mp8T32MNf6fwNVOIcRL9nRQ29xrqSmS7Pup0TVP9rCTrVEtEmdW
	wy+xoqRI1eT5fJRwma2xOxNcB0oiiAksQbF50OyzjZm3kmFmvBu0JIfpc9FokJJ1/DFL6yX9l
	WLFdTcS9JSB70x4asuMXrhvw8TXLLZ1yTxPtsgfF+WUBqdPU3ojbe9PF64WdujTQubAVWPlMH
	2sYz5qf/1C5noacl615AnWE5EfL/ibG54KwOGh5GDm8wrxr+20B6q8h3nmZQZ3NlMBiiqfQsg
	2UX5Iv4RHWaqihLeFD2ZRr3la/g7HCU2bLh/Mw3lyiKCG39FSa4az72dGxHLA2Dz0RgIcnt3q
	oeJ8jY020aMsL5xoJ0tidt0AT9xz0s6kBRp2rSID3QJdhszGpprcm0k5jV8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v3] hw/char/escc: Lower irq
 when transmit buffer is filled
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503072116.kcyyiWR_kN8HgRAqA6m8BwMmcAskQvV547kSPBILW4A@z>

On 03/05/2019 09:14, Mark Cave-Ayland wrote:
> On 02/05/2019 13:11, Philippe Mathieu-Daudé wrote:
> 
>> On 5/2/19 11:04 AM, Laurent Vivier wrote:
>>> On 19/04/2019 17:40, Stephen Checkoway wrote:
>>>> The SCC/ESCC will briefly stop asserting an interrupt when the
>>>> transmit FIFO is filled.
>>>>
>>>> This code doesn't model the transmit FIFO/shift register so the
>>>> pending transmit interrupt is never deasserted which means that an
>>>> edge-triggered interrupt controller will never see the low-to-high
>>>> transition it needs to raise another interrupt. The practical
>>>> consequence of this is that guest firmware with an interrupt service
>>>> routine for the ESCC that does not send all of the data it has
>>>> immediately will stop sending data if the following sequence of
>>>> events occurs:
>>>> 1. Disable processor interrupts
>>>> 2. Write a character to the ESCC
>>>> 3. Add additional characters to a buffer which is drained by the ISR
>>>> 4. Enable processor interrupts
>>>>
>>>> In this case, the first character will be sent, the interrupt will
>>>> fire and the ISR will output the second character. Since the pending
>>>> transmit interrupt remains asserted, no additional interrupts will
>>>> ever fire.
>>>>
>>>> This behavior was triggered by firmware for an embedded system with a
>>>> Z85C30 which necessitated this patch.
>>>>
>>>> This patch fixes that situation by explicitly lowering the IRQ when a
>>>> character is written to the buffer and no other interrupts are currently
>>>> pending.
>>>>
>>>> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>>
>>>> I added a sentence about the Z85C30 necessitating this to the commit message.
>>>>
>>>>  hw/char/escc.c | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/hw/char/escc.c b/hw/char/escc.c
>>>> index 628f5f81f7..c5b05a63f1 100644
>>>> --- a/hw/char/escc.c
>>>> +++ b/hw/char/escc.c
>>>> @@ -509,6 +509,13 @@ static void escc_mem_write(void *opaque, hwaddr addr,
>>>>          break;
>>>>      case SERIAL_DATA:
>>>>          trace_escc_mem_writeb_data(CHN_C(s), val);
>>>> +        /*
>>>> +         * Lower the irq when data is written to the Tx buffer and no other
>>>> +         * interrupts are currently pending. The irq will be raised again once
>>>> +         * the Tx buffer becomes empty below.
>>>> +         */
>>>> +        s->txint = 0;
>>>> +        escc_update_irq(s);
>>>>          s->tx = val;
>>>>          if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
>>>>              if (qemu_chr_fe_backend_connected(&s->chr)) {
>>>>
>>>
>>>
>>> Applied to my trivial-patches branch.
>>
>> Mark, Artyom, are you OK with this patch?
> 
> I started testing this with my OpenBIOS test images at the start of the week, but
> unfortunately got distracted by real life :)
> 
> I've now finished and confirmed there are no regressions in my local tests, so I'll
> include this in the PR I am planning to send shortly containing the leon3 updates.

Hi Mark,

I've already included a leon3 patch ("hw/sparc/leon3: Allow load of
uImage firmwares") in the PR I sent yesterday for the trivial branch.
I've removed from my PR this patch about the ESCC, so you can take it.

Thanks,
Laurent

