Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850FDC41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 08:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B57B20724
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 08:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B57B20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGf7o-00021f-IY
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 04:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGf7A-0001Un-Ih
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 04:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGf79-0005JY-F4
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 04:40:48 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:43387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jGf75-0005H0-Sf; Tue, 24 Mar 2020 04:40:44 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MOiLv-1itmte15Dj-00QG5S; Tue, 24 Mar 2020 09:40:29 +0100
Subject: Re: [PATCH v4 2/3] display/blizzard: Remove redundant statement in
 blizzard_draw_line16_32()
From: Laurent Vivier <laurent@vivier.eu>
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200324082235.27980-1-kuhn.chenqun@huawei.com>
 <20200324082235.27980-3-kuhn.chenqun@huawei.com>
 <aff5ca8a-af20-a3ba-4354-5c203a9eea81@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a3798e7d-702b-3da8-bde2-f5b920d89feb@vivier.eu>
Date: Tue, 24 Mar 2020 09:40:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <aff5ca8a-af20-a3ba-4354-5c203a9eea81@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A/GU3WvmHX4R771hgnpncV4rErbiRaBuJlRDaXWMGythgWhwUGv
 lwq6EuYf5i49hJuImxCdK64AeuyBhlI/3YESRtCnefXqZJF2IZ2kuHQfvZ+jIofiDlrZtvO
 BfJNaK4uOSSWLY66lNbYd4EKyGZElr9FP8MomDzxTqckhvbYHZbtuVxk71VGpz7lIPxUAYo
 i1yUkmq3wHZh5S0VNnqTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rom9t8kUlr4=:j/H2G6Wpoadr9gXpFRJzBj
 FKDVBwk/1Eahzj3IUshRJln9qS0/SR/9tX+1ZqKQEhTcYrbV6BDuabWt1hIQ5907YXE9MmqHh
 ILXrJtMix9/8Ywq+QWKVH2NJ37hczGjoQf/xyw4B0V29XkOgyp7t6W7wSkWwiVqKkQG2QgrGc
 ga5i0zIkKxO4blB8/4Iag6Uiqq6KVTnork79o8JWbFqBXA2pRVoOH5umXR6JQSezBfiqs0bDE
 0O2Y09Kx/1dxHUzwiXDdBfD2+5aPUMEbIIBGM3qD8FhTcCeLEFzbgImukumAd0UNqLIwUQQr0
 cd9DLTuWGPrfEdOtsIywv2oRB+8fiJ5Uv4fe+J0j/T6q9pB3s1mWLJ6WDMuYUQBL/pHGx5vbr
 Zxh5eUUhOPTZFSGq5Wq6yhRlx+84TVVERrcCkkVkE+5MtLLGykfbh7o/mmzSUC4XUFIJvq0pq
 SJGqF9AsMvjz2weAMnrIGOsojEOGOQ9/QS0dNkC1TGTMVTnGfCMikIU5WKdbEZEO+AB0rgyjT
 R0VLmhbXm+ky2frio+eZ1BX5+ZoCvV0aJDyukPhq4l3t7dOd+WKZ9Jc7BB30b8Ij9rmDGF6Us
 g8TauFLS8D6mk8z+g2/3/g/npndHXD/XeNjCkBPDzRpUKLQmLtSpzm4iYar2qGJSSYK+SWhXg
 IRbn1hEAlvdFV3g7GTWBQSfj0At3jel+iOanfv0a4sIZ6bewmfmZFuBe9LwYsm2yGedzYUn1o
 6whPynY3PpW+9wdYteKNRHZkDsI6NlaQnucRvPIhaCOvqv8I2eTEBOAVAM2ykq7mUBsqf+hej
 ihvD7eozyZhvfOxdypUzN8lJ+MAf9DoDcPSPhJv+3aQEo4g4hHhFAEUJKCe8jW1OSj7CZ6h
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: Peter Maydell <peter.maydell@linaro.org>, philmd@redhat.com,
 zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/03/2020 à 09:38, Laurent Vivier a écrit :
> Le 24/03/2020 à 09:22, Chen Qun a écrit :
>> Clang static code analyzer show warning:
>>   hw/display/blizzard.c:940:9: warning: Value stored to 'data' is never read
>>         data >>= 5;
>>         ^        ~
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>> ---
>> Cc: Andrzej Zaborowski <balrogg@gmail.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/display/blizzard.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
>> index 359e399c2a..62517bdf75 100644
>> --- a/hw/display/blizzard.c
>> +++ b/hw/display/blizzard.c
>> @@ -937,7 +937,6 @@ static void blizzard_draw_line16_32(uint32_t *dest,
>>          g = (data & 0x3f) << 2;
>>          data >>= 6;
>>          r = (data & 0x1f) << 3;
>> -        data >>= 5;
>>          *dest++ = rgb_to_pixel32(r, g, b);
>>      }
>>  }
>>
> 
> Perhaps it would be clearer to use extract32() to compute r, g and b?

in fact extract16() as data is uint16_t...

Thanks,
Laurent

