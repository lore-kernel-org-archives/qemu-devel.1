Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25835C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA72F20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA72F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnHkn-00030v-7P
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 03:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43560)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnHkb-0002Pz-1k
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnHkZ-0006gf-Uc
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:19:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnHkZ-0006ft-Oc
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:19:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so4671699wrr.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 00:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tnVNqHoiSgR4rP6XelwFnflFmdAT2038/qPRxCmlvno=;
 b=jjy3Ci+Fe0RAtgmcKS4pE+qtl1m01c4dCZLbDPQsc+Se+0NA3WLUjGt5Dc8StRNVhJ
 GyngzJ8uZT7bAEHMf3fQM6gXpInXY4ktDN0no0D16LBW9kVso6aN651dH5OpRWu5qjAl
 InUlwZkaRftJSya7/L+1qeB9E6Gjy+00Q7jyDP/dq8XIo822BEeDMMFHd9B0cxCnGh5u
 /BcADorZKSq2ElvxlBeOMIvlB1eK9OHODTutm6GwfOnhP0OKUAycghisJ0XzIX5d0ctL
 VUTluE3evI4zk1O4vXHwEYZrjLgzHVMmfoeZ7+fgzBNcxAzmwodUNJOn/BhBQ4Lbr/vP
 5NvQ==
X-Gm-Message-State: APjAAAVsGhi07Vj/MdJQbgv7niXO6O33bo8mbNpMxwkf/JaHpfdUvZ9P
 18bUphRY0Doh8fuXdZO4ig7rNw==
X-Google-Smtp-Source: APXvYqz3/yzb20m4x1/IIV8ME4b+bSJCzY12Z8Y1T1903sJ5pG/ndWp0ZoUBtG6yZSbpdJHoK/Ddbw==
X-Received: by 2002:adf:e504:: with SMTP id j4mr33075107wrm.222.1563261586434; 
 Tue, 16 Jul 2019 00:19:46 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id x20sm40687579wrg.10.2019.07.16.00.19.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 00:19:45 -0700 (PDT)
To: Ramon Fried <rfried.dev@gmail.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20190615051722.13994-1-rfried.dev@gmail.com>
 <CAGi-RUJazCVVh9NwpQ1AHfPdPLW1aYxKst6w6PKfCk2doBz_9w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8422687a-f410-64a4-1211-b06a4f26681e@redhat.com>
Date: Tue, 16 Jul 2019 09:19:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAGi-RUJazCVVh9NwpQ1AHfPdPLW1aYxKst6w6PKfCk2doBz_9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] net: cadence_gem: clear RX control
 descriptor
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 9:11 AM, Ramon Fried wrote:
> ping
> 
> On Sat, Jun 15, 2019 at 8:17 AM Ramon Fried <rfried.dev@gmail.com> wrote:
>>
>> The RX ring descriptors control field is used for setting
>> SOF and EOF (start of frame and end of frame).
>> The SOF and EOF weren't cleared from the previous descriptors,
>> causing inconsistencies in ring buffer.
>> Fix that by clearing the control field of every descriptors we're
>> processing.
>>
>> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
>> ---
>>  hw/net/cadence_gem.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
>> index ecee22525c..d83a82bdb0 100644
>> --- a/hw/net/cadence_gem.c
>> +++ b/hw/net/cadence_gem.c
>> @@ -406,6 +406,11 @@ static inline void rx_desc_set_sof(uint32_t *desc)
>>      desc[1] |= DESC_1_RX_SOF;
>>  }
>>
>> +static inline void rx_desc_clear(uint32_t *desc)
>> +{
>> +    desc[1]  = 0;
>> +}
>> +
>>  static inline void rx_desc_set_eof(uint32_t *desc)
>>  {
>>      desc[1] |= DESC_1_RX_EOF;
>> @@ -994,6 +999,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>>          bytes_to_copy -= MIN(bytes_to_copy, rxbufsize);
>>
>>          /* Update the descriptor.  */
>> +        rx_desc_clear(s->rx_desc[q]);

Maybe move the call before the comment, regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>> +
>>          if (first_desc) {
>>              rx_desc_set_sof(s->rx_desc[q]);
>>              first_desc = false;
>> --
>> 2.21.0
>>

