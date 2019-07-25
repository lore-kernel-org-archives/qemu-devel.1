Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD19C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C0F229F9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C0F229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqcFU-0006Oh-K8
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54528)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqcFH-0005kq-UR
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqcFG-0001go-RA
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:49:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqcFG-0001fo-KF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:49:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so47225749wrm.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=upi3cyDdc6DFPYW8/wqSwP4NpEO2pkVT3xjducvYpJA=;
 b=aU2MYgE9LxRki5or+AOF8ZB9SYI/unl7wzcpU811juq7ZAx35OZxtt6dx6Gwlj8Dp9
 neugFv9Yh1eNTcZw/D2XYzq1c/WYnodzosYjVkmXTCm3IwaJaxycBTgrno8X/yYka+cq
 G4iDaWdLfBU2vvwYjAgnj+sJ54a7ySovw7Gyc8v5ebnyIBlKwuWlFD2yWWzdUc0QkL3c
 Ug56kPQg7MpaY2+i8OOTheuPkNWbaHHw7goFMWdvxGqTNwCZLwGXfyps+1nz8Pl9ScME
 KwZoEl56D1Xfaw9qUPN9/KbRSIYfbmjrQkfjGbvrzknDxsdWPSyn8HNJhm9+HZnjP7eI
 KACg==
X-Gm-Message-State: APjAAAVL5LNCoX2AY+taGRAmVtOm7talKdE0Xxqo8KN9hyeFPxHwhKxP
 SAsvNo3szDeWFQofLQX8PF1YEw==
X-Google-Smtp-Source: APXvYqwSPi4Lghppf0GyFLcgflvOMwfb7T+Wae7lVTpgamHnXAEPxckQORR828RK9k4MdUDgc78ibA==
X-Received: by 2002:adf:9ece:: with SMTP id b14mr45338830wrf.192.1564055353591; 
 Thu, 25 Jul 2019 04:49:13 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id c3sm52035222wrx.19.2019.07.25.04.49.11
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 04:49:13 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45d1ebe4b2ed4c039c9da20a738652df@tpw09926dag18e.domain1.systemhost.net>
 <1564048532722.5565@bt.com> <c35579f0-2a7d-a2e6-ff18-65c5013e1684@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <14bea5de-dd5f-54c5-d7aa-713708abfa7b@redhat.com>
Date: Thu, 25 Jul 2019 13:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c35579f0-2a7d-a2e6-ff18-65c5013e1684@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v4 09/15] cputlb: Access MemoryRegion with
 MemOp
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 david@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, alex.williamson@redhat.com,
 arikalo@wavecomp.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 rth@twiddle.net, atar4qemu@gmail.com, ehabkost@redhat.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 shorne@gmail.com, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 kbastian@mail.uni-paderborn.de, cohuck@redhat.com, laurent@vivier.eu,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 1:38 PM, Philippe Mathieu-Daudé wrote:
> On 7/25/19 11:55 AM, tony.nguyen@bt.com wrote:
>> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
>> ---
>>  accel/tcg/cputlb.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index 523be4c..a4a0bf7 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -906,8 +906,8 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>>          qemu_mutex_lock_iothread();
>>          locked = true;
>>      }
>> -    r = memory_region_dispatch_read(mr, mr_offset,
>> -                                    &val, size, iotlbentry->attrs);
>> +    r = memory_region_dispatch_read(mr, mr_offset, &val, SIZE_MEMOP(size),
>> +                                    iotlbentry->attrs);
>>      if (r != MEMTX_OK) {
>>          hwaddr physaddr = mr_offset +
>>              section->offset_within_address_space -
>> @@ -947,8 +947,8 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>>          qemu_mutex_lock_iothread();
>>          locked = true;
>>      }
>> -    r = memory_region_dispatch_write(mr, mr_offset,
>> -                                     val, size, iotlbentry->attrs);
>> +    r = memory_region_dispatch_write(mr, mr_offset, val, SIZE_MEMOP(size),
>> +                                    iotlbentry->attrs);
>>      if (r != MEMTX_OK) {
>>          hwaddr physaddr = mr_offset +
>>              section->offset_within_address_space -
>> --
>> 1.8.3.1
>>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Hmm now reading patch #11 I think you should also convert
cpu_transaction_failed() in this patch, not in #11, and this will make
#11 easier to review.

