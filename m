Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614BDC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 12:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F6020645
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 12:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F6020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMAbG-0006r5-Tv
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 08:14:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMAZG-0005Vk-Lt
	for qemu-devel@nongnu.org; Thu, 02 May 2019 08:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMAZE-0004Wp-OU
	for qemu-devel@nongnu.org; Thu, 02 May 2019 08:12:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMAZC-0004V5-NM
	for qemu-devel@nongnu.org; Thu, 02 May 2019 08:12:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so2294816wmb.5
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 05:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8ibxnsl1k7mOd8u+30nF9rFetxOQh/taXjr+yKGxL+g=;
	b=bY06Py6gb7nF+CFnxfffPxmLvJrn1j0qfepF8Km5mtqozlrL0u0S0aiXy0V2e94PuL
	BRpTieDgAALrwDhgTXFX9e8cdI3xdxCEWzM7TXfQqruTCwPfQ1RRRAVtxXVbq0fTI5fl
	mzYmLDnVCLQqZDeOG/NAEzVptLUXvUP1JJrfwrgrZbymJbJTjMI3eC6r9t1/bpWG+HiJ
	1VX9ZtWyh2fe4D+ydaOJWCuXHWEmQjxf27X06W2mNO2WwxIxvJO82H5+x54DDLVjeElj
	joBg63FAEbBnTtbPSg1cxQZ7So8XYLubF0CxCNEu90WREL/CDth219GzsohKnWrwrscI
	p44g==
X-Gm-Message-State: APjAAAURhMmhhL3A6UC3sm5wO29ZusxYVe22ePo+vcIFbbk4bCvb2TJz
	MDDxxDapAoldoDJkwBfKxBaw1g==
X-Google-Smtp-Source: APXvYqxmUk+djEyljZXX+nNR7cxfgkO+yIsBCzxTKfbhqKtFtcp7A6t9eSjcz+baRZ55jgI5QW/fbA==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr2068837wme.148.1556799114983; 
	Thu, 02 May 2019 05:11:54 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	h81sm13923519wmf.33.2019.05.02.05.11.53
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 05:11:54 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers
	<qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>,
	qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
	<marcandre.lureau@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20190419154041.77802-1-stephen.checkoway@oberlin.edu>
	<45e6247e-cddb-2185-7f7b-503be00bd453@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f61fc519-da75-5b41-21d0-508cf89016f2@redhat.com>
Date: Thu, 2 May 2019 14:11:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <45e6247e-cddb-2185-7f7b-503be00bd453@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
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
Message-ID: <20190502121153.cugOkYPSs49pcT4B-Djkhv7T6P2VKRpD6sCM10cnkU8@z>

On 5/2/19 11:04 AM, Laurent Vivier wrote:
> On 19/04/2019 17:40, Stephen Checkoway wrote:
>> The SCC/ESCC will briefly stop asserting an interrupt when the
>> transmit FIFO is filled.
>>
>> This code doesn't model the transmit FIFO/shift register so the
>> pending transmit interrupt is never deasserted which means that an
>> edge-triggered interrupt controller will never see the low-to-high
>> transition it needs to raise another interrupt. The practical
>> consequence of this is that guest firmware with an interrupt service
>> routine for the ESCC that does not send all of the data it has
>> immediately will stop sending data if the following sequence of
>> events occurs:
>> 1. Disable processor interrupts
>> 2. Write a character to the ESCC
>> 3. Add additional characters to a buffer which is drained by the ISR
>> 4. Enable processor interrupts
>>
>> In this case, the first character will be sent, the interrupt will
>> fire and the ISR will output the second character. Since the pending
>> transmit interrupt remains asserted, no additional interrupts will
>> ever fire.
>>
>> This behavior was triggered by firmware for an embedded system with a
>> Z85C30 which necessitated this patch.
>>
>> This patch fixes that situation by explicitly lowering the IRQ when a
>> character is written to the buffer and no other interrupts are currently
>> pending.
>>
>> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>
>> I added a sentence about the Z85C30 necessitating this to the commit message.
>>
>>  hw/char/escc.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/char/escc.c b/hw/char/escc.c
>> index 628f5f81f7..c5b05a63f1 100644
>> --- a/hw/char/escc.c
>> +++ b/hw/char/escc.c
>> @@ -509,6 +509,13 @@ static void escc_mem_write(void *opaque, hwaddr addr,
>>          break;
>>      case SERIAL_DATA:
>>          trace_escc_mem_writeb_data(CHN_C(s), val);
>> +        /*
>> +         * Lower the irq when data is written to the Tx buffer and no other
>> +         * interrupts are currently pending. The irq will be raised again once
>> +         * the Tx buffer becomes empty below.
>> +         */
>> +        s->txint = 0;
>> +        escc_update_irq(s);
>>          s->tx = val;
>>          if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
>>              if (qemu_chr_fe_backend_connected(&s->chr)) {
>>
> 
> 
> Applied to my trivial-patches branch.

Mark, Artyom, are you OK with this patch?

> 
> Paolo, Marc-André, if you disagree with this change or prefer to take it
> through one of your queues, I can remove it from mine. Let me know.
> 
> 
> Thanks,
> Laurent
> 

