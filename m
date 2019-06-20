Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE1C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4049D2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4049D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdt2u-00067E-FB
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38222)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdspX-0005vW-9G
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hdspV-0005hp-4t
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:54:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hdspU-0005gu-RM
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:54:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so2132272wre.7
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 01:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bKIJZqiFl4l4o66k6yfT1TnpYbh61d/kfZkBLPVzF6M=;
 b=GCHCF1+XJXhRM66h42Mgf096moOy4DWdS0dyrA2E108aYhx1IUYo7o6w8oc2oGos0t
 XPUYvXwf1WeNp60Ea7O5Q+1SZti07kpBbKQR4aq2esky8aBJmXHVVp7sqLQj2REva/tv
 dyVLsYRfDqpacHNiZKbEm3tlzn8uyRlWvT7hyo1l4Hx6vafHxEqUoHVYc8F/XiGl11qX
 iU3KgccD4UPhPQ+Txu4KVK8rZUpjlnFaPH+BfNPPkkM00BRjlqO/AtniF+pEhCXChu/s
 TTPuqhtha2kYeumSj5ibhaLFnE+w1Cz3WrSu52CUVua33PewbKnz/xwCbzMxdiBG5j7W
 h2nw==
X-Gm-Message-State: APjAAAW6M6gVh1w2qDYZ18za4sD8PpuIAymluqn+zDbe1QQ8XcxalkNW
 jhQ2rMPDrN909v/tsxQUbMiZtw==
X-Google-Smtp-Source: APXvYqzn2cocCa8OeZQurMS1hWzrBXcr8Qo2CaF+LXcy3l7rhmNdHRcKeKL1Kjqd5XmdI92YB9R6Dg==
X-Received: by 2002:adf:c614:: with SMTP id n20mr33482581wrg.17.1561020839736; 
 Thu, 20 Jun 2019 01:53:59 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id v204sm4683826wma.20.2019.06.20.01.53.58
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 01:53:59 -0700 (PDT)
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Stefan Hajnoczi <stefanha@gmail.com>
References: <20190613050937.124903-1-aik@ozlabs.ru>
 <35361394-42ba-dcf0-6fe2-5a0a538d1440@redhat.com>
 <d20e26db-7157-d9bd-c707-d7f4443396c0@ozlabs.ru>
 <20190614093306.GG10957@stefanha-x1.localdomain>
 <33c70ea6-08d7-d4ba-210b-328ea275cfe5@ozlabs.ru>
 <fa361ec0-c734-567a-d617-6613b6e89f78@redhat.com>
 <bbbf2fd0-34e5-c9a9-a11c-f87d07cc3b8f@ozlabs.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1aa3e97b-b5f7-1b88-eb14-af8926701ce4@redhat.com>
Date: Thu, 20 Jun 2019 10:53:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bbbf2fd0-34e5-c9a9-a11c-f87d07cc3b8f@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH qemu] loader: Trace loaded images
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/19 7:50 AM, Alexey Kardashevskiy wrote:
> On 17/06/2019 14:56, Philippe Mathieu-Daudé wrote:
>> On 6/17/19 3:25 AM, Alexey Kardashevskiy wrote:
>>> On 14/06/2019 19:33, Stefan Hajnoczi wrote:
>>>> On Fri, Jun 14, 2019 at 10:13:04AM +1000, Alexey Kardashevskiy wrote:
>>>>>
>>>>>
>>>>> On 13/06/2019 23:08, Philippe Mathieu-Daudé wrote:
>>>>>> Hi Alexey,
>>>>>>
>>>>>> On 6/13/19 7:09 AM, Alexey Kardashevskiy wrote:
>>>>>>> This adds a trace point which prints every loaded image. This includes
>>>>>>> bios/firmware/kernel/initradmdisk/pcirom.
>>>>>>>
>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>>> ---
>>>>>>>
>>>>>>> The example for a pseries guest:
>>>>>>>
>>>>>>> loader_write_rom slof.bin: @0x0 size=0xe22e0 ROM=0
>>>>>>> loader_write_rom phdr #0: /home/aik/t/vml4120le: @0x400000 size=0x13df000 ROM=0
>>>>>>> loader_write_rom /home/aik/t/le.cpio: @0x1ad0000 size=0x9463a00 ROM=0
>>>>>>
>>>>>> I find the "ROM=0" part confuse, maybe you can change to "ROM:false".
>>>>>
>>>>> How? I mean I can do that in the code as rom->isrom?"true":"false" and
>>>>> make trace point accept "%s" but it is quite ugly and others seem to
>>>>> just use %d for bool.
>>>>
>>>> Yes, %d is the convention for bool.  Perhaps you can name it "is_rom"
>>>> instead of "ROM".  That way the name communicates that this is a boolean
>>>> value.
>>>
>>> It is quite obvious though that it is boolean even as "ROM" (what else
>>> can that be realistically?) and there does not seem to be a convention
>>> about xxx:N vs is_xxx:N. And personally I find longer lines worse for
>>> limited width screens (I run multiple qemus in tiled tmux). Whose tree
>>> is this going to? Let's ask that person :)
>>
>> Personally I find 'is_rom' clearer. I read 2 addresses, then my first
>> reaction was to parse it as another address. But it is also true we now
>> enforce traced hex values with '0x' prefix, so your 'ROM' is unlikely an
>> address. Tiled tmux is an acceptable argument. Anyway you already got my
>> R-b.
>>
>> Tree: the PPC tree is likely to get it merged quicker than the MISC tree.
> 
> 
> There is nothing specific about PPC though so I guess it is the MISC
> tree, who does maintain that?

Paolo, Cc'ing him.

