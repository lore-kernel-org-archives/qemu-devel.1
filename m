Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B724CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 19:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD482080F
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 19:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD482080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQzUo-0002v4-8j
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 15:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iQzTp-0002QK-3h
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iQzTn-0002d8-Gf
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:54:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55282)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iQzTn-0002bt-BA
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:54:35 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E71E83F51
 for <qemu-devel@nongnu.org>; Sat,  2 Nov 2019 19:54:33 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id i23so5332099wmb.3
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2019 12:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l3JmXjj1K7b6dRDQQ9okG9CZwOKYzzJISgrU/0/DBOg=;
 b=uKPtJy2qoiQ1e9lJDLu8C2S06CNkwo23VLMeGcthr7aGnn35lLrXGVg2MlBiGKVPRQ
 Xr9R2R2YKnGQpW1x8FG8GJEDJF17tbUWwdCZ6+RWOdBd/gQGNSR9v1sLmx28NT4tEWOm
 GU1wAqcgY3WgUFrb16e8gYCSdYiWbIixU8jvPugwkrsYJnRVK/oaiN8SoVYQNn+oMzEA
 wW+rzZ7I4qK6wKVoCPAp/M6rsm2RbOC9pycfcp2cYsbqSF+ET22PqANZVraT+avhwrgF
 gKiu0AqhyPb32EBWYlQKIjICOkYMr/l2yxGFK9dDv+cDgY3UPvIJXD+yL4lnJvHurQ53
 uciw==
X-Gm-Message-State: APjAAAUdwZaVbbh4TJifwCqA5LIe7i5FUuP6QlBULexO7hj9SrpdtHVl
 MqLjCWy2pkQ8XnZI0qllDzYfVLIBYROicGDgDXjkvk9QtfnVj1LM929iJOrfFH/7YzyzR4l9dDE
 72zx5cf8UD/h66Tk=
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr868343wrs.288.1572724471800;
 Sat, 02 Nov 2019 12:54:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzB7/2OlxjSQ2paf0DHS04LjUiwDXzb4KhKxWAw9hzKRtHLRncuBiwln99t1/szlA4bfOYQkg==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr868327wrs.288.1572724471573;
 Sat, 02 Nov 2019 12:54:31 -0700 (PDT)
Received: from [10.34.4.205] ([109.190.253.11])
 by smtp.gmail.com with ESMTPSA id o81sm2814122wmb.38.2019.11.02.12.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Nov 2019 12:54:30 -0700 (PDT)
Subject: Re: [RFC] q800: fix I/O memory map
To: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
References: <20191031100341.3827-1-laurent@vivier.eu>
 <f0e03032-0ef1-3c8a-0f8d-9608c5c7a5fb@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1a0f2f9d-c777-8e60-d018-e1da58078596@redhat.com>
Date: Sat, 2 Nov 2019 20:54:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f0e03032-0ef1-3c8a-0f8d-9608c5c7a5fb@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

On 11/2/19 7:10 PM, Laurent Vivier wrote:
> Paolo,
> 
> the RFC was mainly for you:
> 
> Is this the good way to replicate 256 times a memory chunk containing a
> bunch of different MMIO spaces?

I asked Richard about this and he said this is OK because this is
the FlatView memory tree. It is then optimized in AddressSpace
(see memory_region_transaction_commit). What matters in term of
performance are the AddressSpaces.

> ...
>> +    /*
>> +     * Memory from VIA_BASE to VIA_BASE + 0x40000 is repeated
>> +     * from VIA_BASE + 0x40000 to VIA_BASE + 0x4000000
>> +     */
>> +    for (i = 1; i < 256; i++) {
>> +        MemoryRegion *io = g_malloc(sizeof(*io));
>> +        char *name = g_strdup_printf("mac_m68k.io[%d]", i);
>> +
>> +        memory_region_init_alias(io, NULL, name, get_system_memory(),
>> +                                 VIA_BASE, 0x40000);
>> +        memory_region_add_subregion(get_system_memory(),
>> +                                    VIA_BASE + i * 0x40000, io);
>> +        g_free(name);
>> +    }
>> +
> ...
> Thanks,
> Laurent
> 

