Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01C8C3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 22:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792D5206D6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 22:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792D5206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Rxt-0005Pz-N4
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 17:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j3Rx6-0004sM-W7
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j3Rx5-0005lg-Dr
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:59:48 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:60628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j3Rx4-0005iC-9Y; Sun, 16 Feb 2020 16:59:47 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 18FEE746383;
 Sun, 16 Feb 2020 22:59:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 86FF5745953; Sun, 16 Feb 2020 22:59:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 832C374569F;
 Sun, 16 Feb 2020 22:59:43 +0100 (CET)
Date: Sun, 16 Feb 2020 22:59:43 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Subject: Re: [PATCH v3] Implement the Screamer sound chip for the mac99
 machine type
In-Reply-To: <CABLmASF=9Qj0_Hh2SWO6K=Sou3mVeyLL+XXTn9WGc670KRn2AA@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2002162243190.98139@zero.eik.bme.hu>
References: <20200216163216.10745-1-programmingkidx@gmail.com>
 <CABLmASF=9Qj0_Hh2SWO6K=Sou3mVeyLL+XXTn9WGc670KRn2AA@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: John Arbuckle <programmingkidx@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 16 Feb 2020, Howard Spoelstra wrote:
> On Sun, Feb 16, 2020 at 5:32 PM John Arbuckle <programmingkidx@gmail.com>
> wrote:
>> diff --git a/hw/audio/screamer.c b/hw/audio/screamer.c
>> new file mode 100644
>> index 0000000000..ad4aba12eb
>> --- /dev/null
>> +++ b/hw/audio/screamer.c
>> @@ -0,0 +1,983 @@
>> +/*
>> + * File: Screamer.c
>> + * Description: Implement the Screamer sound chip used in Apple
>> Macintoshes.
>> + * It works by filling a buffer, then playing the buffer.
>> + */

Do you need a copyright and license header here? Especially if this is not 
all your original work but based on previous code (don't know if it is 
just saying in case as I know Mark also had some similar patches before 
but not sure how are those related if at all). If this contains code from 
somewhere else then license and author of that code may need to be 
included too.

>> +/* Called when the CPU writes to the memory addresses assigned to
>> Screamer */
>> +static void screamer_mmio_write(void *opaque, hwaddr addr, uint64_t
>> raw_value,
>> +                                unsigned size)
>> +{
>> +    DPRINTF("screamer_mmio_write() called - size: %d\n", size);
>> +    ScreamerState *state = opaque;
>> +    uint32_t value = raw_value & 0xffffffff;
>> +    addr = addr >> 4;
>> +
>> +    switch (addr) {
>> +    case SOUND_CONTROL_REG:
>> +        set_sound_control_reg(state, value);
>> +        break;
>> +    case CODEC_CONTROL_REG:
>> +        set_codec_control_reg(state, value);
>> +        break;
>> +    case CODEC_STATUS_REG:
>> +        set_codec_status_reg(state, value);
>> +        break;
>> +    case CLIP_COUNT_REG:
>> +        set_clip_count_reg(state, value);
>> +        break;
>> +    case BYTE_SWAP_REG:
>> +        set_byte_swap_reg(state, value);
>> +        break;
>> +    case FRAME_COUNT_REG:
>> +        set_frame_count_reg(state, value);
>> +        break;
>> +    default:
>> +        DPRINTF("Unknown register write - addr:%llu\tvalue:%d\n", addr,
>> value);
>> +    }
>> +}
>>
>> Hi,
>
> This patch will not compile without errors. Host is Fedora 31.
> The compiler suggests changing lines 839, 842 and 878 in screamer.c so the
> DPRINTF arguments use %lu instead of %llu.
> With that fixed, compiling completes succesfully.

Replacing with %lu may fix 32bit build but would break 64bit one. Use 
HWADDR_PRIx format string instead to print hwaddr but others will probably 
tell to remove DPRINTFs alltogether when they are not needed any more and 
replace the remaining few useful ones with traces if debugging is still 
needed. I don't mind DPRINTFs that much at least until things are stable 
enough but once the code is stable most DPRINTFs may not be needed any 
more.

I can't really review the actual patch because I don't know audio in QEMU.

Regards,
BALATON Zoltan

