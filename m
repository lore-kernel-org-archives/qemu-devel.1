Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B429C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220222053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220222053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57945 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNfBK-0000nB-4n
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:05:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNf9o-0008RX-66
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNf9m-000101-TW
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:03:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNf9m-0000zb-Mb
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:03:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so17712102wre.7
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 08:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=59/j8jbijb9GRmsy8+BVwJxh9KkZztFgn0HfCCnm3UM=;
	b=UG6zmgPk5A1ZctRwONifFrO6GRHaVjbJZlUbI+rXhG9EBO9SyHSj0YlUVU8LZNH9zY
	owXT1bD+ENSJr27zTX4ERGgp7eoM2e4Y4SOAYN8+B03Wxl0WlW6h40PYL8Rq295qdRL7
	4AyYnrXFLjPn9EJc984QAQxjzalTqxmoNjYYx3bHxbBwaaTngef2yDaHg2XWdsS8HNE0
	j4lITktml+k3iEdK5fwtz6EJ7riE35Wxfm2qLs1YI6OSkXnPoMK6KoKxpwqv4FYiyuYu
	QWUeL97r/qvZO1mtqQ6fDAyxZvSwQQN/QjWSTw1m3rzwFEr94hLmHxUt4MgqEuU2puJh
	RpkA==
X-Gm-Message-State: APjAAAWG8RyH3oQnvPqCQRIqJsaaazGsEuNWI6CP8pisuci9Wq8RgMe/
	1BCY5Dz9dIbSPNxzgq4KGTmSMQ==
X-Google-Smtp-Source: APXvYqylfBevJLCKzWEvOW64YF1ZERjxvruZkJ8D0xY62yBkoP35UVL4Yxw96s4XeRYMNT/964amIA==
X-Received: by 2002:a5d:4985:: with SMTP id r5mr13729156wrq.37.1557155033720; 
	Mon, 06 May 2019 08:03:53 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	r2sm10853022wmh.31.2019.05.06.08.03.52
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 08:03:52 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
References: <20190505200602.12412-1-philmd@redhat.com>
	<20190505200602.12412-5-philmd@redhat.com>
	<05b25819-eaca-3452-5933-437afbe11298@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <963e0d54-af61-4ca7-3a39-bd50318e283b@redhat.com>
Date: Mon, 6 May 2019 17:03:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <05b25819-eaca-3452-5933-437afbe11298@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 4/5] hw/block/pflash_cfi02: Extract the
 pflash_reset() code
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/19 4:57 PM, Laszlo Ersek wrote:
> On 05/05/19 22:06, Philippe Mathieu-Daudé wrote:
>> The reset() code is used in various places, refactor it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/block/pflash_cfi02.c | 25 +++++++++++++++----------
>>  1 file changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
>> index f2c6201f813..f321b74433c 100644
>> --- a/hw/block/pflash_cfi02.c
>> +++ b/hw/block/pflash_cfi02.c
>> @@ -120,6 +120,17 @@ static void pflash_register_memory(PFlashCFI02 *pfl, int rom_mode)
>>      pfl->rom_mode = rom_mode;
>>  }
>>  
>> +static void pflash_reset(PFlashCFI02 *pfl)
>> +{
>> +    trace_pflash_reset();
>> +    timer_del(&pfl->timer);
>> +    pfl->bypass = 0;
>> +    pfl->wcycle = 0;
>> +    pfl->cmd = 0;
>> +    pfl->status = 0;
>> +    pflash_register_memory(pfl, 1);
>> +}
>> +
>>  static void pflash_timer (void *opaque)
>>  {
>>      PFlashCFI02 *pfl = opaque;
>> @@ -129,11 +140,10 @@ static void pflash_timer (void *opaque)
>>      pfl->status ^= 0x80;
>>      if (pfl->bypass) {
>>          pfl->wcycle = 2;
>> +        pfl->cmd = 0;
>>      } else {
>> -        pflash_register_memory(pfl, 1);
>> -        pfl->wcycle = 0;
>> +        pflash_reset(pfl);
>>      }
>> -    pfl->cmd = 0;
>>  }
>>  
>>  static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
>> @@ -481,10 +491,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
>>  
>>      /* Reset flash */
>>   reset_flash:
>> -    trace_pflash_reset();
>> -    pfl->bypass = 0;
>> -    pfl->wcycle = 0;
>> -    pfl->cmd = 0;
>> +    pflash_reset(pfl);
>>      return;
>>  
>>   do_bypass:
>> @@ -588,9 +595,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &pfl->mem);
>>  
>>      timer_init_ns(&pfl->timer, QEMU_CLOCK_VIRTUAL, pflash_timer, pfl);
>> -    pfl->wcycle = 0;
>> -    pfl->cmd = 0;
>> -    pfl->status = 0;
>> +    pflash_reset(pfl);
>>      /* Hardcoded CFI table (mostly from SG29 Spansion flash) */
>>      /* Standard "QRY" string */
>>      pfl->cfi_table[0x10] = 'Q';
>>
> 
> I don't have a vested interest in the pflash_cfi02 device model, but I
> guess my earlier (cfi01) comments would apply -- unify first, extract
> second. (Or at least document why these changes are unobservable from
> the behavior POV.)

Ah sorry I forgot to add "Laszlo, please only review patches 1-3" in the
cover :( I use git-publish that send all the patches of the series to
all the list. I might start to add 'Cc:' tags in my patches.

> Thanks
> Laszlo
> 

