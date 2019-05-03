Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945DBC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 07:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5192075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 07:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5192075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35861 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMSSw-0005f4-If
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 03:18:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hMSRw-0005Eh-C7
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hMSRu-0006KN-Sn
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:17:40 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:34380
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hMSRl-0005OY-6s; Fri, 03 May 2019 03:17:30 -0400
Received: from host109-149-60-255.range109-149.btcentralplus.com
	([109.149.60.255] helo=[192.168.1.65])
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hMSO5-0005W7-UA; Fri, 03 May 2019 08:13:42 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers
	<qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>,
	qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
	<marcandre.lureau@redhat.com>
References: <20190419154041.77802-1-stephen.checkoway@oberlin.edu>
	<45e6247e-cddb-2185-7f7b-503be00bd453@vivier.eu>
	<f61fc519-da75-5b41-21d0-508cf89016f2@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
	mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
	3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
	E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
	PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
	PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
	AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
	OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
	NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
	mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
	z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
	T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
	DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
	y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
	2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
	14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
	YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
	Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
	BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
	opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
	NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
	Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
	KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
	imgcU9TTGC5qd9g=
Message-ID: <fc4a45ba-08d0-59ba-80eb-10a08cda3b7d@ilande.co.uk>
Date: Fri, 3 May 2019 08:14:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f61fc519-da75-5b41-21d0-508cf89016f2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 109.149.60.255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
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
Message-ID: <20190503071411.2hWQdmOCuHEySJ3HkKb1OkKetXHaV_jVjzQ50bQbv0s@z>

On 02/05/2019 13:11, Philippe Mathieu-Daudé wrote:

> On 5/2/19 11:04 AM, Laurent Vivier wrote:
>> On 19/04/2019 17:40, Stephen Checkoway wrote:
>>> The SCC/ESCC will briefly stop asserting an interrupt when the
>>> transmit FIFO is filled.
>>>
>>> This code doesn't model the transmit FIFO/shift register so the
>>> pending transmit interrupt is never deasserted which means that an
>>> edge-triggered interrupt controller will never see the low-to-high
>>> transition it needs to raise another interrupt. The practical
>>> consequence of this is that guest firmware with an interrupt service
>>> routine for the ESCC that does not send all of the data it has
>>> immediately will stop sending data if the following sequence of
>>> events occurs:
>>> 1. Disable processor interrupts
>>> 2. Write a character to the ESCC
>>> 3. Add additional characters to a buffer which is drained by the ISR
>>> 4. Enable processor interrupts
>>>
>>> In this case, the first character will be sent, the interrupt will
>>> fire and the ISR will output the second character. Since the pending
>>> transmit interrupt remains asserted, no additional interrupts will
>>> ever fire.
>>>
>>> This behavior was triggered by firmware for an embedded system with a
>>> Z85C30 which necessitated this patch.
>>>
>>> This patch fixes that situation by explicitly lowering the IRQ when a
>>> character is written to the buffer and no other interrupts are currently
>>> pending.
>>>
>>> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>
>>> I added a sentence about the Z85C30 necessitating this to the commit message.
>>>
>>>  hw/char/escc.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/hw/char/escc.c b/hw/char/escc.c
>>> index 628f5f81f7..c5b05a63f1 100644
>>> --- a/hw/char/escc.c
>>> +++ b/hw/char/escc.c
>>> @@ -509,6 +509,13 @@ static void escc_mem_write(void *opaque, hwaddr addr,
>>>          break;
>>>      case SERIAL_DATA:
>>>          trace_escc_mem_writeb_data(CHN_C(s), val);
>>> +        /*
>>> +         * Lower the irq when data is written to the Tx buffer and no other
>>> +         * interrupts are currently pending. The irq will be raised again once
>>> +         * the Tx buffer becomes empty below.
>>> +         */
>>> +        s->txint = 0;
>>> +        escc_update_irq(s);
>>>          s->tx = val;
>>>          if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
>>>              if (qemu_chr_fe_backend_connected(&s->chr)) {
>>>
>>
>>
>> Applied to my trivial-patches branch.
> 
> Mark, Artyom, are you OK with this patch?

I started testing this with my OpenBIOS test images at the start of the week, but
unfortunately got distracted by real life :)

I've now finished and confirmed there are no regressions in my local tests, so I'll
include this in the PR I am planning to send shortly containing the leon3 updates.


ATB,

Mark.

