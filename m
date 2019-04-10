Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A8C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221BA2075B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221BA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEJRV-0002Xa-1r
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 16:03:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEJQd-0002GH-55
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEJQV-0008VO-S1
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:02:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEJQR-0007wN-O2
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:02:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so4363086wrx.9
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 13:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=G4RH2D6PPWQz6Xc+ZAdvZ+q0zeeNMRyHXYBq7Rf5VB0=;
	b=ZoHQ7h9MzEp2gOAMy3rYq2abytG7eGXFn+aLok4bk5ZsFI8SStUyKloSHVCg6CezWu
	FIsogXUhzWcjAOfYwqof/6OC4AkOC5XdbYzRrbPupeGH5OIB8KKpKRNgordUKY907V9p
	la6gSVkL3vVoOz1krHhJF89ucMdrFJZkYRg3/MExV60w/R0gRo1OYHSb65/tmvcT/8oi
	sZnyKFUt+XqW8463m7v/vz9Ck8BZ35Uu+/n3FlQQp6RVBX/YUBogKLO+T4nqxCnl9lJb
	U7+EIH7nrmcjrjs93HepN9NJepAyWQ+1PdAEaNfAf018vcqqIJPeDVlm7jKBFsJuoPUN
	byUQ==
X-Gm-Message-State: APjAAAXRlsLb1yQ7nS4KyiFb8PxGs9dSs54i+POn4XrwPUbunqwzmWQs
	Wwrc4JQDnQViqWjjXXCcxp7UhQ==
X-Google-Smtp-Source: APXvYqymGI8vLX4yZ0xiA9uLf+D8tY494tXWInDdqRJG1SnZngHCqubWpRCAike+jQ2Od3qFlsTVKA==
X-Received: by 2002:adf:e4c2:: with SMTP id v2mr27889256wrm.124.1554926485180; 
	Wed, 10 Apr 2019 13:01:25 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	o2sm29376356wrs.89.2019.04.10.13.01.24
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Apr 2019 13:01:24 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-devel@nongnu.org,
	Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>
References: <20190305051007.56009-1-stephen.checkoway@oberlin.edu>
	<52a82d3a-3b79-c61d-93fa-f087af45f6fb@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1328f591-897f-8762-d324-cccb5f63a360@redhat.com>
Date: Wed, 10 Apr 2019 22:01:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <52a82d3a-3b79-c61d-93fa-f087af45f6fb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] hw/char/escc: Lower irq when transmit
 buffer is filled
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
Cc: qemu-trivial@nongnu.org,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410200118.F5dbss4z7jXP99icTMdDTjycqw_c6iG8O4X-R-BhsmE@z>

On 3/6/19 12:01 PM, Paolo Bonzini wrote:
> On 05/03/19 06:10, Stephen Checkoway wrote:
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
>> This fixes that situation by explicitly lowering the IRQ when a
>> character is written to the buffer.
>>
>> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> 
> Looks good but I would like Mark to give his ack as well.
> 
> Mark, could you also add hw/char/escc.c to both SPARC and Mac sections
> of MAINTAINERS?

Cc'ing Artyom who also made some changes in this file, and Laurent.


Stephen, which particular chipset are you using?

This file models various types. I had a talk with Mark or Laurent at
last KVM forum about this device. IIRC, while the sun4m machines use a
real chipset, the MacIO embeds an slighly modified IP core.

I can't find what you describe in the Z85C30 doc, however in the ESCC
datasheet referenced in escc.c (which happens to be a 85MiB pdf!!!) I found:

  Transmit Interrupts and Transmit Buffer Empty Bit on the NMOS/CMOS

  The TxIP is reset either by writing data to the transmit buffer or
  by issuing the Reset Tx Int command in WR0.

I understand the NMOS/CMOS desc. matches the Z85C30 (no FIFO used).

So your description and patch makes sens.
What worries me is the controller could have other pending IRQs to
deliver and you are clearing them. Shouldn't we only clear the
INTR_TXINT bit, and call escc_update_irq() which should lower the IRQ if
no bits are pending?

Maybe as:

    s->wregs[W_INTR] &= ~INTR_TXINT;
    escc_update_irq(s);

Thanks,

Phil.

> Thanks,
> 
> Paolo
> 
>> ---
>>  hw/char/escc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/char/escc.c b/hw/char/escc.c
>> index 628f5f81f7..bea55ad8da 100644
>> --- a/hw/char/escc.c
>> +++ b/hw/char/escc.c
>> @@ -509,6 +509,7 @@ static void escc_mem_write(void *opaque, hwaddr addr,
>>          break;
>>      case SERIAL_DATA:
>>          trace_escc_mem_writeb_data(CHN_C(s), val);
>> +        qemu_irq_lower(s->irq);
>>          s->tx = val;
>>          if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
>>              if (qemu_chr_fe_backend_connected(&s->chr)) {
>>
> 
> 

