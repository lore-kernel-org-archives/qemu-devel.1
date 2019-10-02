Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BD6C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352D820679
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352D820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFgCj-0006Vf-Aq
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 11:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFgAC-0004iU-Id
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFgAB-0007mS-8v
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22797)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFgAB-0007lQ-0t
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:03:35 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F191B87630
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 15:03:33 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id s19so2226041wmj.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 08:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eSxMRX8GN8phVB9NSHa6t4tc2qgaPgMGgXLbL3nw8NA=;
 b=Ue0ZZQFM1GgwHoZ9Q9K9Hz84KJyqOUjwDw3ldUfNyVpD+E/V9SeK5bxes949ckCg01
 SlmJw+ihdB6GZqDW9OkhzwrZNtOataK2f92FiExAgdYJRYAqSvXJC53gY0vwxmgj598e
 CEvUAguwa1+dcCcLI2rbW6reFcVlzLh4wwzOxwhWwJLyQApH8yZ/YzWm3zw3KlKdOvtZ
 CvCAixoywA2zFuHzYXY8vpVZ/vlERrvfTAQT+pITDamJq9vs/MDcrTB04BQU300QoSkt
 BDc3Ob2PcntSMeKQtVO8XPv7avUU3CUmBYUOLUQbMKGG4LTyfjZt6HMv+cmjELFd90rD
 GN0Q==
X-Gm-Message-State: APjAAAXBb+1PYWobYxbkgQgBHQCqtz+o7YZV1EAkqIpWEn1r48m6N0ZD
 M0SiSKs0DXVZFxNHVfzesCAYqUqZjn+EQufhyzSxXDHHizK+WEBYXww4j0ISfx5mVCXzW/eeSk9
 Gw/psx6zlJqalHgs=
X-Received: by 2002:adf:f011:: with SMTP id j17mr3189710wro.131.1570028612660; 
 Wed, 02 Oct 2019 08:03:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyUFwjkoSlSkZAMw1gCVW+6lIOMj8EGfX9wo7EyYU02QEdSJdtxyxrS7EMcReH+mW/PoMZ/uw==
X-Received: by 2002:adf:f011:: with SMTP id j17mr3189665wro.131.1570028612323; 
 Wed, 02 Oct 2019 08:03:32 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id u10sm38054548wrg.55.2019.10.02.08.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2019 08:03:31 -0700 (PDT)
Subject: Re: [PATCH v13 1/9] esp: add pseudo-DMA as used by Macintosh
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190927090453.24712-1-laurent@vivier.eu>
 <20190927090453.24712-2-laurent@vivier.eu>
 <84f1108e-cc69-558d-4d67-ebb0b7b5f42a@redhat.com>
 <e62b699d-6e05-1914-65b6-683e81b7640d@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <85676490-43a7-5348-ecf3-c5654eb111ff@redhat.com>
Date: Wed, 2 Oct 2019 17:03:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e62b699d-6e05-1914-65b6-683e81b7640d@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/19 2:33 PM, Laurent Vivier wrote:
> Le 02/10/2019 =C3=A0 13:10, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>> On 9/27/19 11:04 AM, Laurent Vivier wrote:
>>> There is no DMA in Quadra 800, so the CPU reads/writes the data from =
the
>>> PDMA register (offset 0x100, ESP_PDMA in hw/m68k/q800.c) and copies t=
hem
>>> to/from the memory.
>>>
>>> There is a nice assembly loop in the kernel to do that, see
>>> linux/drivers/scsi/mac_esp.c:MAC_ESP_PDMA_LOOP().
>>>
>>> The start of the transfer is triggered by the DREQ interrupt (see lin=
ux
>>> mac_esp_send_pdma_cmd()), the CPU polls on the IRQ flag to start the
>>> transfer after a SCSI command has been sent (in Quadra 800 it goes
>>> through the VIA2, the via2-irq line and the vIFR register)
>>>
>>> The Macintosh hardware includes hardware handshaking to prevent the C=
PU
>>> from reading invalid data or writing data faster than the peripheral
>>> device can accept it.
>>>
>>> This is the "blind mode", and from the doc:
>>> "Approximate maximum SCSI transfer rates within a blocks are 1.4 MB p=
er
>>> second for blind transfers in the Macintosh II"
>>>
>>> Some references can be found in:
>>>  =C2=A0=C2=A0 Apple Macintosh Family Hardware Reference, ISBN 0-201-1=
9255-1
>>>  =C2=A0=C2=A0 Guide to the Macintosh Family Hardware, ISBN-0-201-5240=
5-8
>>>
>>> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>>  =C2=A0 hw/scsi/esp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 338 ++++++++++++++++++++++++++++++++++++++----
>>>  =C2=A0 include/hw/scsi/esp.h |=C2=A0 15 ++
>>
>> I recommend you to install the scripts/git.orderfile file.
>=20
> done
>=20
>>
>>>  =C2=A0 2 files changed, 324 insertions(+), 29 deletions(-)
>>>
> ...
>>> --- a/include/hw/scsi/esp.h
>>> +++ b/include/hw/scsi/esp.h
>>> @@ -14,10 +14,18 @@ typedef void (*ESPDMAMemoryReadWriteFunc)(void
>>> *opaque, uint8_t *buf, int len);
>>>  =C2=A0 =C2=A0 typedef struct ESPState ESPState;
>>>  =C2=A0 +enum pdma_origin_id {
>>> +=C2=A0=C2=A0=C2=A0 PDMA,
>>> +=C2=A0=C2=A0=C2=A0 TI,
>>> +=C2=A0=C2=A0=C2=A0 CMD,
>>> +=C2=A0=C2=A0=C2=A0 ASYNC,
>>> +};
>>> +
>>>  =C2=A0 struct ESPState {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t rregs[ESP_REGS];
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t wregs[ESP_REGS];
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_irq irq;
>>> +=C2=A0=C2=A0=C2=A0 qemu_irq irq_data;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t chip_id;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool tchi_written;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int32_t ti_size;
>>> @@ -48,6 +56,12 @@ struct ESPState {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ESPDMAMemoryReadWriteFunc dma_memory_=
write;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *dma_opaque;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*dma_cb)(ESPState *s);
>>> +=C2=A0=C2=A0=C2=A0 uint8_t pdma_buf[32];
>>> +=C2=A0=C2=A0=C2=A0 int pdma_origin;
>>
>> 'int' -> 'enum pdma_origin_id'
>>
>> You can also declare the enum in place:
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum pdma_origin_id {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PDMA,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TI,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CMD,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASYNC,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } pdma_origin;
>=20
> If I remember correctly I put an "int" here because I didn't find the
> VMSTATE_XXX() to use and VMSTATE_INT32() doesn't like the enum type
> (which should be treated as an int).

Yes you are correct, I didn't check this was a migrated enum.

Regards,

Phil.

