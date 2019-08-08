Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB83C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 07:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623AB20665
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 07:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623AB20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvcRD-0003D1-Nn
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 03:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51265)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvcQH-0002fO-7x
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvcQF-0003MH-Sq
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:01:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvcQF-0003Lx-Lw
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:01:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so93714330wrl.7
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 00:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G/ZL4e4iz98TCLCwtf4XenPuZv9ljfcx/ZJabDdJRrE=;
 b=GQkw+GmLRIAhybBQh0Tmetez4Q1q6CkNFdT0gHl+HujUMXfqJ/LJIMiYtdXrEfXSWj
 NwM4cCUYbJYhE3YlsHQYmXqVv4AFNYkUQa7t6CpKPmTvYR317gTBZmlSbc+vplip/sLD
 37zkENDZ+PbhwjR27gSod7KR+hFqrglVu6GnucMO2CZGkF9iPFyEF9WfkQsTZW8Q5UAX
 pG6ZLUnwn25BNNzpPl+tYoT/nhp9a77YAWPGasr4lEfZLJE4dUrW4iSj2TJEVyx+EHsm
 8C6mStRStHWI4oxr2fm9BCV/lNS7obVusZvrt6wTgnZkZJQyl/wVXB0V4EdPqtLrMsxE
 TOQg==
X-Gm-Message-State: APjAAAUNyitiCeHfCaP7jVWj3DG+GtcnIEx/LB+i2qsK/JMFjuPt1uif
 2aGLT7D+Wy0t7Vse1fciXXOnGQ==
X-Google-Smtp-Source: APXvYqynYKwjswlYrsx+tzQn9PJWHVUM3Pa2hIzEvgty/qoRk86UZzbQQUH/PegJDPMw3dh/kVwJGQ==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr14343924wrp.116.1565247674613; 
 Thu, 08 Aug 2019 00:01:14 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id e4sm8429179wrh.39.2019.08.08.00.01.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 00:01:14 -0700 (PDT)
To: Bin Meng <bmeng.cn@gmail.com>
References: <1565020374-23888-1-git-send-email-bmeng.cn@gmail.com>
 <1565239479-2130-1-git-send-email-bmeng.cn@gmail.com>
 <d0ca78ec-c5d4-bc80-6f2e-3e933013b5f4@redhat.com>
 <CAEUhbmVKnUkJ66A-mULpkqZppb=2c8NVAFJhZhOMpOdyRRxSQQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1070f952-68d2-8849-bac8-4b58ab10ed9b@redhat.com>
Date: Thu, 8 Aug 2019 09:01:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmVKnUkJ66A-mULpkqZppb=2c8NVAFJhZhOMpOdyRRxSQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2] hw: net: cadence_gem: Fix build errors
 in DB_PRINT()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 8:36 AM, Bin Meng wrote:
> On Thu, Aug 8, 2019 at 1:21 PM Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Hi,
>>
>> On 8/8/19 6:44 AM, Bin Meng wrote:
>>> When CADENCE_GEM_ERR_DEBUG is turned on, there are several
>>> compilation errors in DB_PRINT(). Fix them.
>>>
>>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>
>> Please don't reply to previous version, post as a new thread (it is
>> harder to notice your new versions in a emails threaded view).
>>
> 
> OK.
> 
>>> - use HWADDR_PRIx instead of TARGET_FMT_plx for consistency
>>> - use 'z' modifier to print sizeof(..)
>>>
>>>  hw/net/cadence_gem.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
>>> index d412085..b6ff2c1 100644
>>> --- a/hw/net/cadence_gem.c
>>> +++ b/hw/net/cadence_gem.c
>>> @@ -983,8 +983,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>>>              return -1;
>>>          }
>>>
>>> -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize),
>>> -                rx_desc_get_buffer(s->rx_desc[q]));
>>> +        DB_PRINT("copy %d bytes to 0x%" HWADDR_PRIx "\n",
>>
>> rx_desc_get_buffer() returns a uint64_t, shouldn't you use a PRIx64
>> format here?
> 
> HWADDR_PRIx expands to PRIx64. I got your point that since it does not
> return hwaddr, so we should use PRIx64 directly. Correct?
> 
>>
>>> +                 MIN(bytes_to_copy, rxbufsize),
>>
>> Nitpick #1: since you are cleaning this file up, bytes_to_copy and
>> rxbufsize are both unsigned, so the first format should be %u instead of %d.
> 
> Sure, will do in v3.
> 
>>
>>> +                 rx_desc_get_buffer(s, s->rx_desc[q]));
>>>
>>>          /* Copy packet data to emulated DMA buffer */
>>>          address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
>>> @@ -1157,7 +1158,7 @@ static void gem_transmit(CadenceGEMState *s)
>>>              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
>>>                                                 (p - tx_packet)) {
>>>                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x space " \
>>> -                         "0x%x\n", (unsigned)packet_desc_addr,
>>> +                         "0x%zx\n", (unsigned)packet_desc_addr,
>>
>> Nitpick #2: packet_desc_addr is of type hwaddr, so removing the cast the
>> 1st format is HWADDR_PRIx, also removing the 2nd cast the 2nd format is
>> PRIx64.
> 
> packet_desc_addr() return unsigned, so %x should be OK.

'packet_desc_addr' is of type hwaddr,
'(unsigned)packet_desc_addr' is casted to type unsigned.

Anyhow I now remember I already reviewed this patch:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg03263.html

>>
>> Then the 3rd format is now correct.
>>
>>>                           (unsigned)tx_desc_get_length(desc),
>>>                           sizeof(tx_packet) - (p - tx_packet));
>>>                  break;
>>>

