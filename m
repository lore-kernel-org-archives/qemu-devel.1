Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9E2C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BB621D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BB621D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPEY-0002oJ-S1
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXOsS-0000un-10
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:19:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:49874
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXOsL-0005gt-S0; Tue, 27 Oct 2020 09:19:03 -0400
Received: from host86-148-103-79.range86-148.btcentralplus.com
 ([86.148.103.79] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXOsJ-0000vd-3r; Tue, 27 Oct 2020 13:19:01 +0000
To: Samuel Thibault <samuel.thibault@gnu.org>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-9-mark.cave-ayland@ilande.co.uk>
 <20201026095450.ko6snc4dusk3pvnw@function>
 <547c0ea5-dad4-d246-1de8-844a2e9a9507@ilande.co.uk>
 <20201026111406.jvpexlkh53g4fxff@function>
 <CAKf6xpvcnmEs+v3+Tm1srQfo=m37EAGRPynJDJy4HkMuCmD6NQ@mail.gmail.com>
 <38110b4a-34b1-3e97-5a7f-4fad1bfff080@ilande.co.uk>
 <20201026150432.yqkyceke5uppqom5@function>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a141714c-158f-0099-34ab-92fc27be6975@ilande.co.uk>
Date: Tue, 27 Oct 2020 13:18:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026150432.yqkyceke5uppqom5@function>
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
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.167,
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
Cc: Jason Andryuk <jandryuk@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/2020 15:04, Samuel Thibault wrote:

> Mark Cave-Ayland, le lun. 26 oct. 2020 13:40:05 +0000, a ecrit:
>> On 26/10/2020 13:00, Jason Andryuk wrote:
>>> On Mon, Oct 26, 2020 at 7:21 AM Samuel Thibault <samuel.thibault@gnu.org> wrote:
>>>> Aurelien, you introduced the "| 1" in
>>>>
>>>> commit abb8a13918ecc1e8160aa78582de9d5224ea70df
>>>> Author: Aurelien Jarno <aurelien@aurel32.net>
>>>> Date:   Wed Aug 13 04:23:17 2008 +0000
>>>>
>>>>       usb-serial: add support for modem lines
>>>>
>>>> [...]
>>>> @@ -357,9 +393,9 @@ static int usb_serial_handle_control(USBDevice *dev, int request, int value,
>>>>            /* TODO: TX ON/OFF */
>>>>            break;
>>>>        case DeviceInVendor | FTDI_GET_MDM_ST:
>>>> -        /* TODO: return modem status */
>>>> -        data[0] = 0;
>>>> -        ret = 1;
>>>> +        data[0] = usb_get_modem_lines(s) | 1;
>>>> +        data[1] = 0;
>>>> +        ret = 2;
>>>>            break;
>>>
>>> I'm not particularly familiar with the FTDI USB serial devices.  I
>>> found setting FTDI_THRE | FTDI_TEMT by comparing with real hardware.
>>>
>>> A little searching found this:
>>> https://elixir.bootlin.com/linux/latest/source/drivers/usb/serial/ftdi_sio.h#L541
>>>
>>> That shows "B0   Reserved - must be 1", so maybe that is why "| 1" was added?
>>
>> Right - that's for the modem status returned as part of the first 2 status
>> bytes for incoming data which is slightly different from modem status
>> returned directly from FTDI_SIO_GET_MODEM_STATUS: https://elixir.bootlin.com/linux/latest/source/drivers/usb/serial/ftdi_sio.h#L423.
>>
>> It is the latter which this patch changes and appears to match what I see on
>> my Chipi-X hardware here.
> 
> Aurelien, do you remember the reason for the addition of 1 here? It does
> look like the confusion between the incoming data bytes and the modem
> status bytes.

I spent a bit of time this morning doing some further tests on Linux using 2 machines 
and a test program to check CTS and usbmon:

usbmon when adapter unplugged:
ffff95a4bf2dd300 2366831506 S Ci:4:004:0 s c0 05 0000 0000 0002 2 <
ffff95a4bf2dd300 2366831607 C Ci:4:004:0 0 2 = 0160

usbmon when adapter plugged in and remote connected to minicom:
ffff95a4452a79c0 2457273895 S Ci:4:004:0 s c0 05 0000 0000 0002 2 <
ffff95a4452a79c0 2457274057 C Ci:4:004:0 0 2 = 3160

It seems I made a mistake here since the response is interpreted as 2 bytes rather 
than a single little-endian word: with CTS asserted on the remote the first byte is 
0x31 == FTDI_CTS | FTDI_DSR | 1, whilst the 2nd byte is 0x60 == FTDI_THRE | FTDI_TEMT 
which matches the existing QEMU code rather than the comments in ftdi_sio.h.

So sorry for the noise: I'll drop this patch from the series and post a v2 shortly.


ATB,

Mark.

