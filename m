Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBD5C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 12:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31273221FF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 12:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31273221FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmcB6-0004GC-CF
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 08:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jmcAG-0003ZX-5A; Sat, 20 Jun 2020 08:00:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:50164
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jmcAD-0006IW-OG; Sat, 20 Jun 2020 08:00:03 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jmcA6-0002VG-JG; Sat, 20 Jun 2020 12:59:59 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
 <20200614142840.10245-23-mark.cave-ayland@ilande.co.uk>
 <ab46d38d-9b64-18c9-bd2f-08e48b1dc82f@amsat.org>
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
Message-ID: <fb205d96-e167-ddaf-d33f-558d72326429@ilande.co.uk>
Date: Sat, 20 Jun 2020 12:59:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ab46d38d-9b64-18c9-bd2f-08e48b1dc82f@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 22/22] adb: add ADB bus trace events
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

On 14/06/2020 18:16, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 6/14/20 4:28 PM, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/input/adb.c        | 23 ++++++++++++++++++++++-
>>  hw/input/trace-events |  7 +++++++
>>  2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/input/adb.c b/hw/input/adb.c
>> index fe0f6c7ef3..4976f52c36 100644
>> --- a/hw/input/adb.c
>> +++ b/hw/input/adb.c
>> @@ -29,10 +29,18 @@
>>  #include "qemu/module.h"
>>  #include "qemu/timer.h"
>>  #include "adb-internal.h"
>> +#include "trace.h"
>>  
>>  /* error codes */
>>  #define ADB_RET_NOTPRESENT (-2)
>>  
>> +static const char *adb_commands[] = {
>> +    "RESET", "FLUSH", "(Reserved 0x2)", "(Reserved 0x3)",
>> +    "Reserved (0x4)", "(Reserved 0x5)", "(Reserved 0x6)", "(Reserved 0x7)",
>> +    "LISTEN r0", "LISTEN r1", "LISTEN r2", "LISTEN r3",
>> +    "TALK r0", "TALK r1", "TALK r2", "TALK r3",
>> +};
>> +
>>  static void adb_device_reset(ADBDevice *d)
>>  {
>>      qdev_reset_all(DEVICE(d));
>> @@ -86,9 +94,16 @@ static int do_adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf,
>>  
>>  int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
>>  {
>> +    int ret;
>> +
>> +    trace_adb_bus_request(buf[0] >> 4, adb_commands[buf[0] & 0xf], len);
>> +
>>      assert(s->autopoll_blocked);
>>  
>> -    return do_adb_request(s, obuf, buf, len);
>> +    ret = do_adb_request(s, obuf, buf, len);
>> +
>> +    trace_adb_bus_request_done(buf[0] >> 4, adb_commands[buf[0] & 0xf], ret);
>> +    return ret;
>>  }
>>  
>>  int adb_poll(ADBBusState *s, uint8_t *obuf, uint16_t poll_mask)
>> @@ -160,6 +175,8 @@ void adb_set_autopoll_mask(ADBBusState *s, uint16_t mask)
>>  
>>  void adb_autopoll_block(ADBBusState *s)
>>  {
>> +    trace_adb_bus_autopoll_block("autopoll BLOCKED");
> 
> Regarding how trace backends work, in this case it is better
> to use a boolean value and let the backend do the formatting:
> 
>        trace_adb_bus_autopoll_block(true);
> 
> The rationale is it is easier for backends to filter on a
> bool (register) arg rather than fetching memory for strcmp.
> 
> So format can be:
> 
> adb_bus_autopoll_block(bool state) "autopoll is_blocked:%u"
> 
> Anyway if you want to keep as it, it is cleaner to change the
> format as "autopoll %s".
> 
>> +
>>      s->autopoll_blocked = true;
> 
> This can also be:
> 
>        trace_adb_bus_autopoll_block(s->autopoll_blocked);
> 
>>  
>>      if (s->autopoll_enabled) {
>> @@ -169,6 +186,8 @@ void adb_autopoll_block(ADBBusState *s)
>>  
>>  void adb_autopoll_unblock(ADBBusState *s)
>>  {
>> +    trace_adb_bus_autopoll_block("autopoll UNBLOCKED");
>> +
>>      s->autopoll_blocked = false;
> 
> Ditto:
> 
>        trace_adb_bus_autopoll_block(s->autopoll_blocked);
> 
>>  
>>      if (s->autopoll_enabled) {
>> @@ -183,7 +202,9 @@ static void adb_autopoll(void *opaque)
>>      ADBBusState *s = opaque;
>>  
>>      if (!s->autopoll_blocked) {
>> +        trace_adb_bus_autopoll_cb(s->autopoll_mask);
>>          s->autopoll_cb(s->autopoll_cb_opaque);
>> +        trace_adb_bus_autopoll_cb_done(s->autopoll_mask);
>>      }
>>  
>>      timer_mod(s->autopoll_timer,
>> diff --git a/hw/input/trace-events b/hw/input/trace-events
>> index 6f0d78241c..119d1ce2bd 100644
>> --- a/hw/input/trace-events
>> +++ b/hw/input/trace-events
>> @@ -14,6 +14,13 @@ adb_device_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x
>>  adb_device_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
>>  adb_device_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
>>  
>> +# adb.c
>> +adb_bus_request(uint8_t addr, const char *cmd, int size) "device 0x%x %s cmdsize=%d"
>> +adb_bus_request_done(uint8_t addr, const char *cmd, int size) "device 0x%x %s replysize=%d"
>> +adb_bus_autopoll_block(const char *s) "%s"
>> +adb_bus_autopoll_cb(uint16_t mask) "executing autopoll_cb with autopoll mask 0x%x"
>> +adb_bus_autopoll_cb_done(uint16_t mask) "done executing autopoll_cb with autopoll mask 0x%x"
>> +
>>  # pckbd.c
>>  pckbd_kbd_read_data(uint32_t val) "0x%02x"
>>  pckbd_kbd_read_status(int status) "0x%02x"
>>
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Thanks for the review: I think you're right in that the boolean makes things easier
for other trace backends, so I'll implement your changes in a v2.


ATB,

Mark.

