Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46369C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B88B22305
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B88B22305
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQKN-0000Zd-Ew
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvQJt-0008Jn-RN
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvQJs-0002Z5-Tg
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:05:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvQJs-0002XF-NV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:05:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so92261140wrf.11
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 11:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vi8wC7X/GDwqvPqza7CDmHXpjr8HhwAnG+jiaCgia9Q=;
 b=tNVhmwXdAaFV0POjNF0xO4N0F0fe5AYkA0ot3EwUCS7sMP8gNNC6+aIib3LverdqDN
 Ad8KLZHgXeXl/c5S+KEHkyDKqciTFL4IFD9bAchetKHczzYElVGFqeb4/LXzXB8YqTB4
 /yf3HfzUjTEYciO6XQkSM2eFT26FWJT2lIf5VJhdvvqZVuMICNkE81d6wNZ+jXePmAqy
 K5UNxxJf5Gq8B5fthBqQKqFho4ysVXqzfu/l2BiCe5BN5wjhOTVfO06dP3NjRup2V7Rq
 7VByRqeFYIbgYsgRJIG6IQcsPcpVWun3yyTzwTdUgpHBRPJ2TMfCWqZ7WUK3Sl2Ajq12
 g8aA==
X-Gm-Message-State: APjAAAUdDWyNpGFyJm//klBCpSppJW9cTCq2WKhiDR3euysFyYy6eZLS
 74Dno5fRq+s3xaLwG2zAy2331FOrpfs=
X-Google-Smtp-Source: APXvYqyKoZXJa47M0Sc5GdZON4ru8ps67WCUIQJzqtt0Ri/koUR1wW0WFb8fV3g9XcfOTqmST4uovQ==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr12242158wrl.134.1565201151530; 
 Wed, 07 Aug 2019 11:05:51 -0700 (PDT)
Received: from [192.168.1.115] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id t63sm1128306wmf.24.2019.08.07.11.05.50
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 11:05:51 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-23-armbru@redhat.com>
 <de7f547d-1c97-135f-654f-3856fa2eec2f@redhat.com>
 <20190807175708.GE4669@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <647e2542-2042-26de-d768-cdf13afa0ec4@redhat.com>
Date: Wed, 7 Aug 2019 20:05:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190807175708.GE4669@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 22/29] Include hw/boards.h a bit less
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/19 7:57 PM, Eduardo Habkost wrote:
> On Wed, Aug 07, 2019 at 07:26:56PM +0200, Philippe Mathieu-Daudé wrote:
>> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>>> hw/boards.h pulls in almost 60 headers.  The less we include it into
>>> headers, the better.  As a first step, drop superfluous inclusions,
>>> and downgrade some more to what's actually needed.  Gets rid of just
>>> one inclusion into a header.
>>>
>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
> [...]
>>> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
>>> index bcacdd1d8f..34a9f6f7a9 100644
>>> --- a/target/i386/hax-all.c
>>> +++ b/target/i386/hax-all.c
>>> @@ -33,7 +33,6 @@
>>>  #include "sysemu/reset.h"
>>>  #include "sysemu/sysemu.h"
>>>  #include "qemu/main-loop.h"
>>> -#include "hw/boards.h"
>>>  
>>>  #define DEBUG_HAX 0
>>
>> include/sysemu/hax.h misses to include "hw/boards.h":
> 
> I don't understand.  I don't see any reason for the sysemu/hax.h
> header to include hw/boards.h.

Ah, you are right, the AccelClass is defined in include/sysemu/accel.h:

typedef struct AccelClass {
    /*< private >*/
    ObjectClass parent_class;
    /*< public >*/

    const char *name;
    int (*init_machine)(MachineState *ms);
    ...

So this is where "hw/boards.h" has to be included (it is where
MachineState is defined).

>>
>> target/i386/hax-all.c: In function 'hax_accel_init':
>> target/i386/hax-all.c:354:26: error: dereferencing pointer to incomplete
>> type 'MachineState {aka struct MachineState}'
>>      int ret = hax_init(ms->ram_size);
>>                           ^
> 

