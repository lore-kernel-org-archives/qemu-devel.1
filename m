Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03B4C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 12:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE6523B44
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 12:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE6523B44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmcD8-0005uB-1V
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 08:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jmcCF-0005MK-DW; Sat, 20 Jun 2020 08:02:09 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:50178
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jmcCD-0006vJ-Cp; Sat, 20 Jun 2020 08:02:07 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jmcC7-0002WT-0n; Sat, 20 Jun 2020 13:02:04 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
 <20200614142840.10245-22-mark.cave-ayland@ilande.co.uk>
 <cb9d9259-5c92-4ca1-2636-681febbf5ddd@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
Message-ID: <b56e85bc-a972-954e-6348-fe27dc2da2c4@ilande.co.uk>
Date: Sat, 20 Jun 2020 13:01:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cb9d9259-5c92-4ca1-2636-681febbf5ddd@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 21/22] adb: use adb_device prefix for ADB device trace
 events
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
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/06/2020 18:20, Philippe Mathieu-Daudé wrote:

> On 6/14/20 4:28 PM, Mark Cave-Ayland wrote:
>> This is to allow us to distinguish between ADB device events and ADB
>> bus events separately.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/input/adb-kbd.c    | 12 ++++++------
>>  hw/input/adb-mouse.c  | 12 ++++++------
>>  hw/input/trace-events | 20 ++++++++++----------
>>  3 files changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
>> index 23760ecf7b..3cfb6a7a20 100644
>> --- a/hw/input/adb-kbd.c
>> +++ b/hw/input/adb-kbd.c
>> @@ -243,7 +243,7 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
>>      olen = 0;
>>      switch (cmd) {
>>      case ADB_WRITEREG:
>> -        trace_adb_kbd_writereg(reg, buf[1]);
>> +        trace_adb_device_kbd_writereg(reg, buf[1]);
>>          switch (reg) {
>>          case 2:
>>              /* LED status */
>> @@ -256,7 +256,7 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
>>              case ADB_CMD_CHANGE_ID_AND_ACT:
>>              case ADB_CMD_CHANGE_ID_AND_ENABLE:
>>                  d->devaddr = buf[1] & 0xf;
>> -                trace_adb_kbd_request_change_addr(d->devaddr);
>> +                trace_adb_device_kbd_request_change_addr(d->devaddr);
>>                  break;
>>              default:
>>                  d->devaddr = buf[1] & 0xf;
>> @@ -270,8 +270,8 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
>>                      d->handler = buf[2];
>>                  }
>>  
>> -                trace_adb_kbd_request_change_addr_and_handler(d->devaddr,
>> -                                                              d->handler);
>> +                trace_adb_device_kbd_request_change_addr_and_handler(
>> +                    d->devaddr, d->handler);
>>                  break;
>>              }
>>          }
>> @@ -294,7 +294,7 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
>>              olen = 2;
>>              break;
>>          }
>> -        trace_adb_kbd_readreg(reg, obuf[0], obuf[1]);
>> +        trace_adb_device_kbd_readreg(reg, obuf[0], obuf[1]);
>>          break;
>>      }
>>      return olen;
>> @@ -321,7 +321,7 @@ static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
>>      /* FIXME: take handler into account when translating qcode */
>>      keycode = qcode_to_adb_keycode[qcode];
>>      if (keycode == NO_KEY) {  /* We don't want to send this to the guest */
>> -        trace_adb_kbd_no_key();
>> +        trace_adb_device_kbd_no_key();
>>          return;
>>      }
>>      if (evt->u.key.data->down == false) { /* if key release event */
>> diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
>> index e2359fd74d..577a38ff2e 100644
>> --- a/hw/input/adb-mouse.c
>> +++ b/hw/input/adb-mouse.c
>> @@ -121,7 +121,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
>>          s->dx = 0;
>>          s->dy = 0;
>>          s->dz = 0;
>> -        trace_adb_mouse_flush();
>> +        trace_adb_device_mouse_flush();
>>          return 0;
>>      }
>>  
>> @@ -130,7 +130,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
>>      olen = 0;
>>      switch (cmd) {
>>      case ADB_WRITEREG:
>> -        trace_adb_mouse_writereg(reg, buf[1]);
>> +        trace_adb_device_mouse_writereg(reg, buf[1]);
>>          switch (reg) {
>>          case 2:
>>              break;
>> @@ -152,7 +152,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
>>              case ADB_CMD_CHANGE_ID_AND_ACT:
>>              case ADB_CMD_CHANGE_ID_AND_ENABLE:
>>                  d->devaddr = buf[1] & 0xf;
>> -                trace_adb_mouse_request_change_addr(d->devaddr);
>> +                trace_adb_device_mouse_request_change_addr(d->devaddr);
>>                  break;
>>              default:
>>                  d->devaddr = buf[1] & 0xf;
>> @@ -172,8 +172,8 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
>>                      d->handler = buf[2];
>>                  }
>>  
>> -                trace_adb_mouse_request_change_addr_and_handler(d->devaddr,
>> -                                                                d->handler);
>> +                trace_adb_device_mouse_request_change_addr_and_handler(
>> +                    d->devaddr, d->handler);
>>                  break;
>>              }
>>          }
>> @@ -191,7 +191,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
>>              olen = 2;
>>              break;
>>          }
>> -        trace_adb_mouse_readreg(reg, obuf[0], obuf[1]);
>> +        trace_adb_device_mouse_readreg(reg, obuf[0], obuf[1]);
>>          break;
>>      }
>>      return olen;
>> diff --git a/hw/input/trace-events b/hw/input/trace-events
>> index a2888fd10c..6f0d78241c 100644
>> --- a/hw/input/trace-events
>> +++ b/hw/input/trace-events
>> @@ -1,18 +1,18 @@
>>  # See docs/devel/tracing.txt for syntax documentation.
>>  
>>  # adb-kbd.c
>> -adb_kbd_no_key(void) "Ignoring NO_KEY"
>> -adb_kbd_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
>> -adb_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
>> -adb_kbd_request_change_addr(int devaddr) "change addr to 0x%x"
>> -adb_kbd_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
>> +adb_device_kbd_no_key(void) "Ignoring NO_KEY"
>> +adb_device_kbd_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
>> +adb_device_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
>> +adb_device_kbd_request_change_addr(int devaddr) "change addr to 0x%x"
>> +adb_device_kbd_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
>>  
>>  # adb-mouse.c
>> -adb_mouse_flush(void) "flush"
>> -adb_mouse_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
>> -adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
>> -adb_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
>> -adb_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
>> +adb_device_mouse_flush(void) "flush"
> 
> For the following: ...
> 
>> +adb_device_mouse_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
>> +adb_device_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
>> +adb_device_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
>> +adb_device_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
> 
> ... you could use a common trace, using a device_type argument, i.e.:
> 
> adb_device_writereg(const char *device_type, int reg, uint8_t val) "%s
> reg %d val 0x%2.2x"
> 
> But then you can not filter traces for a particular device.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Yeah that's right. Generally whilst working on this I've tended to want to see either
everything or individual devices, so I'll leave this one as it is for now. Thanks for
the review though!


ATB,

Mark.

