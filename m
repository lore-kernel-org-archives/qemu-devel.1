Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31264C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 18:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DCFA21872
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 18:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCFA21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoXEI-00033v-C5
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 14:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60711)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hoXE8-0002ek-D9
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 14:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hoXE7-0000No-BJ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 14:03:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hoXE7-0000Mv-1X
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 14:03:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so29581817wme.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 11:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=74wZWb2B5AbOL7Z/KQSv5bPXGSirDygWKRHsVQhtWdw=;
 b=oafft7VjFiCx308L5RW52DQjhyAyWyMWpJzP9GZq7OB1+Fy/AhbonXC5zUwJDvyV1z
 Qq+05Y+lvICk31FJK6+utlQ3jhr0r/i27xjCUHEHDy+5WjtrIAq6OhT/mxEEqEHwibAd
 805dmUA64AwhobTOoglIGFKPsX1wCmadzOF86z/kHiJFQr/YKxvfT0HOjjOIf4jT723S
 Yv0sreVsaRwteGPdlO7cSwK7KC6x2467Nl1Kt++rJu2Gfd8jVgbS5c7i6CMv9U6nr77i
 Jg+NVfaMWmLJoFgFGGXKxxVAYTj9qGCaJGDBuTaXLuw85ac+HfQ32Ah0Y6BR+I7VHJKg
 VKKA==
X-Gm-Message-State: APjAAAW0dSJ7HfYSLQ0z53N83z28Ve1ggt07BUnovLhYLq9li7GFB8Zx
 zTu81IrrsxqeBvPHMYmT3GvejA==
X-Google-Smtp-Source: APXvYqxu4LGo8Uy1saY7WhVhC4mYKb3TMqieJ6+UKp8TkZabvUutoZB1EvZG21Rti4eYM2A9Lb7E3g==
X-Received: by 2002:a1c:9696:: with SMTP id y144mr49004067wmd.73.1563559405961; 
 Fri, 19 Jul 2019 11:03:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8?
 ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id q1sm25208772wmq.25.2019.07.19.11.03.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 11:03:25 -0700 (PDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, rth@twiddle.net
References: <20190712032704.7826-1-richardw.yang@linux.intel.com>
 <20190719175400.GJ3000@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0fd200f7-ad92-d753-23ca-8c89a27fd346@redhat.com>
Date: Fri, 19 Jul 2019 20:03:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719175400.GJ3000@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] migration: check length directly to make
 sure the range is aligned
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/07/19 19:54, Dr. David Alan Gilbert wrote:
>> -        if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
>> -            error_report("ram_block_discard_range: Unaligned end address: %p",
>> -                         host_endaddr);
>> +        if (length & (rb->page_size - 1)) {
>> +            error_report("ram_block_discard_range: Unaligned length: %lx",
>> +                         length);
> Yes, I *think* this is safe, we'll need to watch out for any warnings;

Do you mean compiler or QEMU warning?  The patch is safe since there's an

    if ((uintptr_t)host_startaddr & (rb->page_size - 1)) {
        error_report("ram_block_discard_range: Unaligned start address: %p",
                     host_startaddr);
        goto err;
    }

just before this context.

Paolo

