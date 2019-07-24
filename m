Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410F4C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1938621926
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1938621926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqHl7-000552-8Y
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 09:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48979)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqHkw-0004ga-9k
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqHkv-0001AC-3s
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:56:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqHku-00019q-Tz
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:56:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so47123468wrr.5
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 06:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tjXLcWn4HvhQIPwKDL+DSaMAaFiYxymgUNQk8wNwSJY=;
 b=XfupmP+IJY8p8rHZWV9KOzlV38jMVyhFZJMhGeismoK0ENI7NNYA/bIxzEiVl3J0Bj
 13MPrg5tQrPKATtZD2nHRCeoBjzO7smIhRqI1puuae0axNQU/8/QeL7+DlE6SE1L9TzP
 5Dg0VGW0I8QH9wRa4Vn7PL9so70BZFCKrKHwYoUpM4R2eB1tADneWKd5OJP7yulYEA5k
 fAGrgactpBlTmbvvJescb3LxiD8xrQnPg4DU3iTgoNJPr+FkJUwbJD2kVZcE+ew7kQk8
 QNmazP/AZBZn2Jl4u5oXYvHy8iTQ4tvm9txkhdcQYRh22uoLgmUBPpEf1ASFebBp3oPC
 Eozw==
X-Gm-Message-State: APjAAAWw4UPZMIj7cA6ZNtYyiFQax7bsqkL7QKNiNCQ8G5g9u8dnJ35j
 hbzuHgo/R27Ai75ICZUupxq6HQ==
X-Google-Smtp-Source: APXvYqxmYDIY/1Rcbn/bCBpN534dwYeiMepzbIrOQpuFddgO3Qhoq2TjlkRLZYDVPPiBD+/aTJgOig==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr6671900wrq.29.1563976591824;
 Wed, 24 Jul 2019 06:56:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id o6sm89761341wra.27.2019.07.24.06.56.31
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 06:56:31 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190724131309.1378-1-pbonzini@redhat.com>
 <20190724131309.1378-4-pbonzini@redhat.com>
 <21ad7858-d1f6-acae-cf3f-fd2404575138@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7c9f5b38-c133-dbde-ef04-164938caf5c0@redhat.com>
Date: Wed, 24 Jul 2019 15:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <21ad7858-d1f6-acae-cf3f-fd2404575138@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PULL 3/3] docs: correct kconfig option
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/07/19 15:23, Philippe Mathieu-Daudé wrote:
> On 7/24/19 3:13 PM, Paolo Bonzini wrote:
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Message-Id: <20190723120804.29565-1-marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Not a big deal bug I reviewed this one:
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg05128.html
> (wondering if patchwork/patchew is loosing mails/tags).

No, I just applied it before your review.

Paolo

>> ---
>>  docs/devel/kconfig.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
>> index d6f8eb0977..b7bca44704 100644
>> --- a/docs/devel/kconfig.rst
>> +++ b/docs/devel/kconfig.rst
>> @@ -267,7 +267,7 @@ the default configuration by uncommenting lines in the first group,
>>  or commenting out lines in the second group.
>>  
>>  It is also possible to run QEMU's configure script with the
>> -``--with-default-devices`` option.  When this is done, everything defaults
>> +``--without-default-devices`` option.  When this is done, everything defaults
>>  to ``n`` unless it is ``select``ed or explicitly switched on in the
>>  ``.mak`` files.  In other words, ``default`` and ``imply`` directives
>>  are disabled.  When QEMU is built with this option, the user will probably
>>


