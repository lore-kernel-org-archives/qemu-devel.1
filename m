Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D1DC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17842064A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17842064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52138 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnJR-0007Vh-U4
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51296)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbmgT-0005vz-B9
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbmgQ-0000pn-Kd
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:56:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbmgM-0000nJ-V1
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:55:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so2485630wma.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 06:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GBL3EQzgeyoyBJBMpCdxJd9FPAZnSg7xQYEkYyKYrFQ=;
 b=nOzQDTEKWx6tz26Ub3apllOEA9zbB3TGQbbKVpHHLyGy90kzrv/jTDo4FXyjcYLdJo
 p9AOHr5ZMZY4WbCK1bqHGtN+rZPq19INUzQ6b16wTsRVq6l9biaBn7svUkaxRhozQ75h
 I+kcnjN+SK9GFuKU4/0j/meyI37kruGHuamGZFV1zu4RyZ/WFmUmxE85o5lIhetG5kTN
 R6k7V4Z/LVZSGOQzwtFvEOX4jO3fjWGKnVh5wHY9kO57wy6UnmguhnsxQXcfzrGo/hUi
 4BwhN3i4/yyksPHkgsM18WJ8V1Ro1F3wlCvO6PZ9MJHZsuB0tMJrOBkng9KgV0HUnioh
 AtSQ==
X-Gm-Message-State: APjAAAVbE9KJQrVAIb2RYomhNDlWsnVoPZd1nSar2E66yE5sA3COtETr
 t1flrhoPY8TyURoQhSk0ZbuEDQ==
X-Google-Smtp-Source: APXvYqzANcvXgdnaUyR6NWpoKyTq9UhhIaMi1t1jGj2HzKU9RYEI7GJD8OukXEVO83biqh8ZUh8i8A==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr8597791wml.90.1560520553109; 
 Fri, 14 Jun 2019 06:55:53 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id t15sm2829918wrx.84.2019.06.14.06.55.51
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 06:55:52 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190613175435.6575-1-philmd@redhat.com>
 <7c44bcb6-1c72-e327-9091-394e6abfb51e@redhat.com>
 <c02e3358-f195-51e7-171f-aab2b0314c72@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <62fae3fa-ba9d-6c38-ac8f-0e453ef396f8@redhat.com>
Date: Fri, 14 Jun 2019 15:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c02e3358-f195-51e7-171f-aab2b0314c72@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] roms/edk2-build.sh: Allow to run
 edk2-build.sh from command line
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
Cc: Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 3:29 PM, Eric Blake wrote:
> On 6/14/19 5:16 AM, Philippe Mathieu-Daudé wrote:
>> Cc'ing Eric :)
>>
> 
>>> When running this script out of 'make', we get:
>>>
>>>   $ cd roms
>>>   $ ./edk2-build.sh aarch64 --arch=AARCH64 --platform=ArmVirtPkg/ArmVirtQemu.dsc > /dev/null
>>>   ./edk2-build.sh: line 46: MAKEFLAGS: unbound variable
>>>
>>> Fix this by checking the variable is defined before using it,
>>> else use a default value.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  roms/edk2-build.sh | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/roms/edk2-build.sh b/roms/edk2-build.sh
>>> index 4f46f8a6a2..5390228b4e 100755
>>> --- a/roms/edk2-build.sh
>>> +++ b/roms/edk2-build.sh
> 
> This is running under /bin/bash (hmm - not '/bin/env bash' like other
> scripts in qemu?), so...
> 
>>> @@ -43,7 +43,13 @@ fi
>>>  # any), for the edk2 "build" utility.
>>>  source ../edk2-funcs.sh
>>>  edk2_toolchain=$(qemu_edk2_get_toolchain "$emulation_target")
>>> -edk2_thread_count=$(qemu_edk2_get_thread_count "$MAKEFLAGS")
>>> +if [ -v MAKEFLAGS ]; then
> 
> the non-portable bashism '[ -v' works. However, it's just as easy to

Ah, OK.

> work around this problem portably for all POSIX shells without needing 'if':
> 
>>> +  edk2_thread_count=$(qemu_edk2_get_thread_count "$MAKEFLAGS")
>>> +else
>>> +  # We are not running within 'make', let the edk2 "build" utility to fetch
>>> +  # the logical CPU count with Python's multiprocessing.cpu_count() method.
>>> +  edk2_thread_count=0
>>> +fi
> 
> edk2_thread_count=$(qemu_edk2_get_thread_count "${MAKEFLAGS:-0}")

Argh I'm confuse, this is what I wanted to do first but I couldn't get
it working, maybe I forget the '-'.

Thanks a lot for your help, the result is way more elegant :)

> 
> at which point the really long comment needs a bit of a tweak.
> 

