Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F9C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E4721783
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E4721783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw43H-0002n9-D6
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 08:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50602)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw41t-0001wI-8Q
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw41r-0001Zc-Lp
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:29:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw41r-0001ZE-GK
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:29:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so7824356wrj.12
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 05:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q5UDIRiTFxDc9YkqxxODV1AsczyvH0Jm+9jsJd0woEw=;
 b=t1vJFT0gNY5RlSUqN5JdOLAnevcRJgUIdqrqQqH60QDr+W0li1FbyhmRkDnjwEzZX8
 PK+iQvD6UISLRHMok7VvirrATUrpp9FPjUi2y1zS7Gq/51aBXjuWJv3Tp88BwMrnp39G
 PZ9pM3vBu799THr2i3EjX81Huq6z9TQq1tqcCY9UqfETNyM3BBjzgjr+E0zLKvFtettp
 QyRBJZxwmJho2xTJT68Og1dHUIduH9ur9XT11cJkVm+wGYIb2Xspvr5qoMrKzFoQKjDe
 aTUBfgwxnWGAgTlksT0RWBncXRsAXO3uvIfYa94gZcq4rwjRyKbSLpzNAtjOLqJhCXmZ
 QtlA==
X-Gm-Message-State: APjAAAVXbdEh094Kc68V0w5Riv82NUHGpzljI7r04g4DVmADcMeOqdGc
 TzB4q/jc0fQdJEZIwUa+iBUkzsEvVbc=
X-Google-Smtp-Source: APXvYqwKBXbo6WkrDCaUn5Kl8+CzUrIQ4GoFRrn299zTfHMKeAmcluyejJ2185U5DEl6WthKERPGxQ==
X-Received: by 2002:adf:ea89:: with SMTP id s9mr4637395wrm.76.1565353794248;
 Fri, 09 Aug 2019 05:29:54 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id r16sm7016490wrc.81.2019.08.09.05.29.53
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 05:29:53 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
 <20190809064645.22656-21-armbru@redhat.com>
 <c76aaebc-d4bf-cb25-fe27-7a9c9ba644c9@redhat.com>
 <87k1bmpn7y.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <47ecba06-e9ad-e1aa-063e-be25a610400f@redhat.com>
Date: Fri, 9 Aug 2019 14:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87k1bmpn7y.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3 20/29] Include qemu/main-loop.h less
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 1:55 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>> On 8/9/19 8:46 AM, Markus Armbruster wrote:
>>> In my "build everything" tree, changing qemu/main-loop.h triggers a
>>> recompile of some 5600 out of 6600 objects (not counting tests and
>>> objects that don't depend on qemu/osdep.h).  It includes block/aio.h,
>>> which in turn includes qemu/event_notifier.h, qemu/notify.h,
>>> qemu/processor.h, qemu/qsp.h, qemu/queue.h, qemu/thread-posix.h,
>>> qemu/thread.h, qemu/timer.h, and a few more.
>>>
>>> Include qemu/main-loop.h only where it's needed.  Touching it now
>>> recompiles only some 1700 objects.  For block/aio.h and
>>> qemu/event_notifier.h, these numbers drop from 5600 to 2800.  For the
>>> others, they shrink only slightly.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>> [...]
>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>>> index 77f5df59b0..ac18a1184a 100644
>>> --- a/include/sysemu/sysemu.h
>>> +++ b/include/sysemu/sysemu.h
>>> @@ -5,7 +5,6 @@
>>>  #include "qapi/qapi-types-run-state.h"
>>>  #include "qemu/timer.h"
>>>  #include "qemu/notify.h"
>>> -#include "qemu/main-loop.h"
>>>  #include "qemu/bitmap.h"
>>>  #include "qemu/uuid.h"
>>>  #include "qom/object.h"
>>
>> netmap failing again :S
>>
>> $ make docker-image-debian-amd64 V=1 DEBUG=1
>> [...]
>>   CC      net/netmap.o
>> net/netmap.c: In function 'netmap_update_fd_handler':
>> net/netmap.c:109:5: error: implicit declaration of function
>> 'qemu_set_fd_handler' [-Werror=implicit-function-declaration]
>>      qemu_set_fd_handler(s->nmd->fd,
>>      ^~~~~~~~~~~~~~~~~~~
>> net/netmap.c:109:5: error: nested extern declaration of
>> 'qemu_set_fd_handler' [-Werror=nested-externs]
> 
> I managed to lose the fix somehow.
> 
> I admit I ran "make docker-test-build", realized docker needs root, and

Another cheap way is to register to Shippable and enable it to a public
repository from https://www.shippable.com/integrations.html, then you
simply pushing your work to your repository will trigger a good set of
Docker cross-builds.

See https://app.shippable.com/github/qemu/qemu/dashboard/history
Less than 2h to build the various targets.

> went "sod it, cross fingers & send out the patches".  My need to get out
> the changes accumulated since v2 won over the prudence to run all
> available tests first.  Not my finest hour.

