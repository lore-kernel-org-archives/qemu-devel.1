Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5F9C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0C622263
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0C622263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0PV-0000k3-Pa
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kX0DI-0003eS-LM
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:58:57 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:47404
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kX0DG-0000w7-0B; Mon, 26 Oct 2020 06:58:55 -0400
Received: from host86-148-103-79.range86-148.btcentralplus.com
 ([86.148.103.79] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kX0DE-0000ek-Pg; Mon, 26 Oct 2020 10:58:59 +0000
To: Samuel Thibault <samuel.thibault@gnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Andryuk <jandryuk@gmail.com>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-9-mark.cave-ayland@ilande.co.uk>
 <20201026095450.ko6snc4dusk3pvnw@function>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <547c0ea5-dad4-d246-1de8-844a2e9a9507@ilande.co.uk>
Date: Mon, 26 Oct 2020 10:58:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026095450.ko6snc4dusk3pvnw@function>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.103.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 8/9] dev-serial: fix FTDI_GET_MDM_ST response
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/2020 09:54, Samuel Thibault wrote:

> Hello,
> 
> (Cc-ing Aurelien who introduced the support for modem control, and Jason
> who added the missing THRE and TEMT flags).
> 
> Mark Cave-Ayland, le lun. 26 oct. 2020 08:34:00 +0000, a ecrit:
>> The FTDI_GET_MDM_ST response should only return a single byte indicating the
>> modem status with bit 0 cleared (as documented in the Linux ftdi_sio.h header
>> file).
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/usb/dev-serial.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
>> index 4c374d0790..fa734bcf54 100644
>> --- a/hw/usb/dev-serial.c
>> +++ b/hw/usb/dev-serial.c
>> @@ -360,9 +360,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>>           /* TODO: TX ON/OFF */
>>           break;
>>       case VendorDeviceRequest | FTDI_GET_MDM_ST:
>> -        data[0] = usb_get_modem_lines(s) | 1;
>> -        data[1] = FTDI_THRE | FTDI_TEMT;
>> -        p->actual_length = 2;
>> +        data[0] = usb_get_modem_lines(s);
>> +        p->actual_length = 1;
> 
> Err, but Linux' drivers/usb/serial/ftdi_sio.c:ftdi_process_packet()
> contradicts this:
> 
> 	if (len < 2) {
> 		dev_dbg(&port->dev, "malformed packet\n");
> 		return 0;
> 	}
> 
> 	status = buf[0] & FTDI_STATUS_B0_MASK;
> 	if (status != priv->prev_status) {
> 		char diff_status = status ^ priv->prev_status;
> 
> 		if (diff_status & FTDI_RS0_CTS)
> 			port->icount.cts++;
> 
> [...]
> 
> 	/* save if the transmitter is empty or not */
> 	if (buf[1] & FTDI_RS_TEMT)
> 		priv->transmit_empty = 1;
> 	else
> 		priv->transmit_empty = 0;
> 
> Did you actually get an issue with seeing this packet contain two bytes?

Hi Samuel,

Thanks for the review! There are 2 different places where the status is read: the one 
above in ftdi_process_packet() relates to the control packet header for incoming data 
which is always 2 bytes, whereas this relates to FTDI_SIO_GET_MODEM_STATUS_REQUEST in 
https://elixir.bootlin.com/linux/latest/source/drivers/usb/serial/ftdi_sio.c#L2825.

I have a FTDI Chipi-X adapter to compare with and that returns 2 bytes, but it looks 
like I mis-read the code and it's the SIO chipsets that return 1 byte which are older 
than the chipset being emulated by QEMU. This came from reading 
https://elixir.bootlin.com/linux/latest/source/drivers/usb/serial/ftdi_sio.h#L415 
which states that only 1 byte should be returned, but of course that comment could be 
out of date.

A quick test shows my Chipi-X returns 0x1 0x60 with nothing attached in response to 
FTDI_SIO_GET_MODEM_STATUS_REQUEST: assuming the reply length should be 2 bytes, the 
comment about B0-B3 being zero and the response from my Chip-X above suggests that 
the "| 1" should still be dropped from the response.


ATB,

Mark.

