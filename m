Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84F5C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8146B229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8146B229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbTb-0006eL-Se
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41966)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqbTQ-00063e-B8
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqbTP-0007mH-6f
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:59:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqbTO-0007jy-VQ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:59:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so44571078wmj.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 03:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=soIWWHrLvhZt3MjKgXrRXvRwi32B3m+Tq+Pj6WkIRsQ=;
 b=dNwcfrF1zHJVVpviyUY6UfGzyTXJ0526ppeuIJFlix6bNin9MQojc1kfiP9gsYeTrX
 1ccB80q5DJCkrVVuEOvDLNQohRT6pB8YoEjSdDwJ2AOP1/5gawJ03fejS5WRhxtOyOSf
 kjtInnq/WofF2l/frSHe4uKxOHY3HZOv939ks8MW1nD7zLI3DJciNl7VEC+HKfS5oCh9
 OUleaBl16JeCGGl5nIFWUa9xWTSrQPkfYCDJOYoLDbIp5xHMJeO5szAzOKZ9YqpMQIJR
 +2jSvSroTt4ILfP4CzPmtUsUwkYCWQaxGsIwPbCmmJoYZxX9PJHYBIxep4tYi+n1u2l3
 x7CA==
X-Gm-Message-State: APjAAAWVA5f5omG/GVglBv+JhFGlG6dWLoFA+KK8hXz6gcAM9pOwZC5u
 DF55gIWO511nN/HgzSmgPSN2LA==
X-Google-Smtp-Source: APXvYqz2Zc7xgRdAXv8q0ApOTaM99s7PbHV5qfyyGNApEPl2wfconyDw+SLIDXQOS5flnkIQqKLWxw==
X-Received: by 2002:a1c:f90f:: with SMTP id x15mr2510391wmh.69.1564052385886; 
 Thu, 25 Jul 2019 03:59:45 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id g131sm34155252wmf.37.2019.07.25.03.59.44
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 03:59:45 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190719131425.10835-1-philmd@redhat.com>
 <20190719131425.10835-4-philmd@redhat.com>
 <6ff431d9-36bd-27a1-077b-b2cb1331750d@redhat.com>
 <bc3dc756-23a8-48a3-02ca-abaae6d0db96@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bc3713cf-0e5c-52ed-c00c-fe4e24be608d@redhat.com>
Date: Thu, 25 Jul 2019 12:59:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <bc3dc756-23a8-48a3-02ca-abaae6d0db96@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH-for-4.1 3/7]
 hw/block/pflash_cfi02: Rewrite a fall through comment
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <minyard@acm.org>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 2:27 AM, John Snow wrote:
> On 7/22/19 7:43 AM, Philippe Mathieu-Daudé wrote:
>> On 7/19/19 3:14 PM, Philippe Mathieu-Daudé wrote:
>>> GCC9 is confused by this comment when building with CFLAG
>>> -Wimplicit-fallthrough=2:
>>>
>>>   hw/block/pflash_cfi02.c: In function ‘pflash_write’:
>>>   hw/block/pflash_cfi02.c:574:16: error: this statement may fall through [-Werror=implicit-fallthrough=]
>>>     574 |             if (boff == 0x55 && cmd == 0x98) {
>>>         |                ^
>>>   hw/block/pflash_cfi02.c:581:9: note: here
>>>     581 |         default:
>>>         |         ^~~~~~~
>>>   cc1: all warnings being treated as errors
>>>
>>> Rewrite the comment using 'fall through' which is recognized by
>>> GCC and static analyzers.
>>>
>>> Reported-by: Stefan Weil <sw@weilnetz.de>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  hw/block/pflash_cfi02.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
>>> index f68837a449..42886f6af5 100644
>>> --- a/hw/block/pflash_cfi02.c
>>> +++ b/hw/block/pflash_cfi02.c
>>> @@ -577,7 +577,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
>>>                  pfl->cmd = 0x98;
>>>                  return;
>>>              }
>>> -            /* No break here */
>>> +            /* fall through */
>>>          default:
>>>              DPRINTF("%s: invalid write for command %02x\n",
>>>                      __func__, pfl->cmd);
>>>
>>
>> Queued to pflash/next, thanks.
>>
> 
> Are you queueing everything or just this one patch? It would be a little
> inconvenient to split a series up like that.

Oops I simply queued this particular one.

> (Most other maintainers will, I believe, expect that with an "ACK" or
> similar that someone else will stage the series.)

I thought these are not critical bugfixes for 4.1, but since I had to do
a pull request for pflash, I could include it. (I already noticed
maintainers queueing particular patches from cleanup series).

Next time I'll ping/wait.

Regards,

Phil.

