Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6814BC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF5821882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF5821882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibiE-0008JA-JP
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52412)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiarm-0000bG-FL
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiarl-00047S-5v
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:43:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiark-00042e-Du
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:43:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so1755716wrt.6
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7b6ZF5uQklpEPEpc/c7+9woVIVcNJX6/kU+CWiMpu2E=;
 b=q/V8U6HDFsUpkBq474H3jv7soTFYCjF1hRgJlSn8xHphQe+8iugckv3xO97/pOxJ6d
 6yzQ623RrgRhMlaMooX4PORjbXihrgkwdYMTn4TrHNNQaABpzgdIVCkCTm/TOrsb5VW9
 I19fo/xIfBn+oLJdFqjH53BpqgdTJRqzaSe/WG8psttRsjAp9WotnwJCF36gdz7xi89y
 Z9nJeSepskyQgvJM9z2MQW6RZNnJl6JBDFchcrwvFgkR8iB4j0Ca47mjAYMJJBdATp40
 0qOUZlEQ1oxDMbGQV91oosndbwHqBXB1zrDE5PMJUh7ki3aaB/BeK+uPm0yHNrEFJWMD
 xfDQ==
X-Gm-Message-State: APjAAAWRy7drClhXzmq3txiYBUTGo3/r2uHhY+NrZYVTjkqQpgtip69c
 678Tb2cabXxiFwGLHWouWVYDGQ==
X-Google-Smtp-Source: APXvYqwzLsd2NQ5jwiFeyibsHOQ31o+FGFPweaSObiH0v7nl9nLT2p7V3P8KMVjW2vKqLoB112G5zg==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr23372746wrq.333.1562143426819; 
 Wed, 03 Jul 2019 01:43:46 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id e6sm1403937wrw.23.2019.07.03.01.43.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 01:43:46 -0700 (PDT)
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190702163844.20458-1-peter.maydell@linaro.org>
 <alpine.BSF.2.21.9999.1907022343160.68337@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <18767774-2460-6f39-2909-de9e37737f4c@redhat.com>
Date: Wed, 3 Jul 2019 10:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1907022343160.68337@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/i2c/bitbang_i2c: Use in-place
 rather than malloc'd bitbang_i2c_interface struct
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
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/19 11:52 PM, BALATON Zoltan wrote:
> On Tue, 2 Jul 2019, Peter Maydell wrote:
>> Currently the bitbang_i2c_init() function allocates a
>> bitbang_i2c_interface struct which it returns.  This is unfortunate
>> because it means that if the function is used from a DeviceState
>> init method then the memory will be leaked by an "init then delete"
>> cycle, as used by the qmp/hmp commands that list device properties.
>>
>> Since three out of four of the uses of this function are in
>> device init methods, switch the function to do an in-place
>> initialization of a struct that can be embedded in the
>> device state struct of the caller.
>>
>> This fixes LeakSanitizer leak warnings that have appeared in the
>> patchew configuration (which only tries to run the sanitizers
>> for the x86_64-softmmu target) now that we use the bitbang-i2c
>> code in an x86-64 config.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> This isn't the only problem with this code : it is also
>> missing reset and migration handling and generally looks like
>> it needs proper conversion to QOM somehow. But this will shut
>> the patchew complaints up and seems ok for 4.1.
>>
>> Disclaimer: checked only that the leak-sanitizer is now happy
>> and with a 'make check'.
> 
> I've tested the ppc4xx and ati-vga parts with AROS and MorphOS and these
> can still access i2c devices so I think it works.

So:

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

>> ---
>> hw/display/ati_int.h         |  2 +-
>> include/hw/i2c/bitbang_i2c.h | 38 ++++++++++++++++++++++++++++-
>> include/hw/i2c/ppc4xx_i2c.h  |  2 +-
>> hw/display/ati.c             |  7 +++---
>> hw/i2c/bitbang_i2c.c         | 47 +++---------------------------------
>> hw/i2c/ppc4xx_i2c.c          |  6 ++---
>> hw/i2c/versatile_i2c.c       |  8 +++---
>> 7 files changed, 53 insertions(+), 57 deletions(-)
>>
>> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
>> index 9b67d0022ad..31a1927b3ec 100644
>> --- a/hw/display/ati_int.h
>> +++ b/hw/display/ati_int.h
>> @@ -88,7 +88,7 @@ typedef struct ATIVGAState {
>>     uint16_t cursor_size;
>>     uint32_t cursor_offset;
>>     QEMUCursor *cursor;
>> -    bitbang_i2c_interface *bbi2c;
>> +    bitbang_i2c_interface bbi2c;
>>     MemoryRegion io;
>>     MemoryRegion mm;
>>     ATIVGARegs regs;
>> diff --git a/include/hw/i2c/bitbang_i2c.h b/include/hw/i2c/bitbang_i2c.h
>> index 3a7126d5dee..92334e9016a 100644
>> --- a/include/hw/i2c/bitbang_i2c.h
>> +++ b/include/hw/i2c/bitbang_i2c.h
>> @@ -8,7 +8,43 @@ typedef struct bitbang_i2c_interface
>> bitbang_i2c_interface;
> 
> Maybe this typedef ^^^ can now be moved to the struct below instead of
> coming first (or even written in the same line as
> typedef struct { } bitbang_i2c_interface;
> as there is no need to have both struct bitbang_i2c_interface and the
> typedeffed name available).

Agreed, from "hw/i2c/i2c.h" to "hw/i2c/bitbang_i2c.h".

> But I don't really mind, so
> 
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> 
> Thanks for fixing this.
> 
> Regards,
> BALATON Zoltan
> 
>> #define BITBANG_I2C_SDA 0
>> #define BITBANG_I2C_SCL 1
>>
>> -bitbang_i2c_interface *bitbang_i2c_init(I2CBus *bus);
>> +typedef enum bitbang_i2c_state {
>> +    STOPPED = 0,
>> +    SENDING_BIT7,
>> +    SENDING_BIT6,
>> +    SENDING_BIT5,
>> +    SENDING_BIT4,
>> +    SENDING_BIT3,
>> +    SENDING_BIT2,
>> +    SENDING_BIT1,
>> +    SENDING_BIT0,
>> +    WAITING_FOR_ACK,
>> +    RECEIVING_BIT7,
>> +    RECEIVING_BIT6,
>> +    RECEIVING_BIT5,
>> +    RECEIVING_BIT4,
>> +    RECEIVING_BIT3,
>> +    RECEIVING_BIT2,
>> +    RECEIVING_BIT1,
>> +    RECEIVING_BIT0,
>> +    SENDING_ACK,
>> +    SENT_NACK
>> +} bitbang_i2c_state;
>> +
>> +struct bitbang_i2c_interface {
>> +    I2CBus *bus;
>> +    bitbang_i2c_state state;
>> +    int last_data;
>> +    int last_clock;
>> +    int device_out;
>> +    uint8_t buffer;
>> +    int current_addr;
>> +};
>> +
>> +/**
>> + * bitbang_i2c_init: in-place initialize the bitbang_i2c_interface
>> struct
>> + */
>> +void bitbang_i2c_init(bitbang_i2c_interface *s, I2CBus *bus);
>> int bitbang_i2c_set(bitbang_i2c_interface *i2c, int line, int level);
>>
>> #endif
> 

