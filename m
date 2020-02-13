Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22331C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E578020873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhQ+AGrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E578020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FTd-0002rF-64
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2FSE-0000h3-Qs
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2FSD-0000wz-P8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:26:58 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2FS9-0000dS-GC; Thu, 13 Feb 2020 09:26:53 -0500
Received: by mail-pg1-x543.google.com with SMTP id d9so3199392pgu.3;
 Thu, 13 Feb 2020 06:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s50XvQnoQSUg49YR8kGWh2NJT/BLHna6vSzN//Vm66o=;
 b=nhQ+AGrZdEhJdLgZEci6TjjmQP3dNV6eep5Xn2GDxgT1QzZVL+C1tXzZ+ckuDNAxx7
 NjTLkIzF5j9+O7gw+TXVOaRe5WL0KEhoL7Uq4nRnHnXQVRB3pDbVwuYmLZ1+Qu3LWYOG
 31P86zyqXlNU5scpBF7sSfnpu3gX2C3sE3VmrRJTYAhx13HVO2D8XDatFS9SwNp7RsQV
 PTApZmM1sBWIiQ7Nb6nG48oXOO94zG64z6ZgQHuMgUUMcwEAQBFjToJOX6t8FAZyDqoG
 5f5mu6kGo16t1ruByn65OHxbTTRO9RfgLHGw9dcbYlStTQ1OEI97Y4Y/Jq/aOi6fF1LW
 nIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s50XvQnoQSUg49YR8kGWh2NJT/BLHna6vSzN//Vm66o=;
 b=EY5ywVdPhcMQUBa6dUaQZv+CGYWdmKDMrOGtjPhj0mGvvk+9+qj3+Ry6uqcrzyNNyZ
 8+oEji2fc/P8FkURkYvL8jtpDMU+/mIdGbfKcqjPsij8AroO2bUeO3KmvlmmIQMYSfIa
 IbGSeW25j/ApW5XKb0jRerqFEFxnlhYUjcx518sgxwSALInjSPlHy1fk+0QZs+kGrn6A
 n9F2YfaTqI6EFJM679aMLHXfNRm5igcGyVN7mdhOCer8a6+Fa31w4yBVXCUFpRUEw2f2
 fZEkCoHgjbm+K+Lk9HOhQ6arT5j/f+ia9MusRDUjDdAncXW3FWf7yECB0+YznbbQVWjL
 NgiQ==
X-Gm-Message-State: APjAAAX8RwwyLbXhHLKvEo2zmp3IsV3PLCkK/LOnavgLAmbpFrUWwEbE
 idL9TfSO6MdUX0ioCasejfmCTMnE
X-Google-Smtp-Source: APXvYqzKvYndIx8VWYbSkTcMBkvzNmzXpeYOUvSJRO1afjU3/y6mvrED7lraljP5rcKhSX3VyHHP0w==
X-Received: by 2002:a65:68d8:: with SMTP id k24mr18995581pgt.208.1581604011625; 
 Thu, 13 Feb 2020 06:26:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 k4sm3436172pfg.40.2020.02.13.06.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 06:26:49 -0800 (PST)
Subject: Re: Question about (and problem with) pflash data access
To: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy
 <aik@ozlabs.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200212184648.GA584@roeck-us.net>
 <504e7722-0b60-ec02-774d-26a7320e5309@redhat.com>
 <20200212230918.GA27242@roeck-us.net>
 <560224fe-f0a3-c64a-6689-e824225cfbb9@redhat.com>
 <279d959f-f7e5-65e1-9c68-459f3fed56d3@ozlabs.ru>
 <52f0b829-151a-3dd0-0ec7-c3155185510c@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9f652340-1277-0eb2-bc2c-402b4209a220@roeck-us.net>
Date: Thu, 13 Feb 2020 06:26:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <52f0b829-151a-3dd0-0ec7-c3155185510c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 1:51 AM, Paolo Bonzini wrote:
> On 13/02/20 08:40, Alexey Kardashevskiy wrote:
>>>>
>>>> memory-region: system
>>>>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>>>       0000000000000000-0000000001ffffff (prio 0, romd): omap_sx1.flash0-1
>>>>       0000000000000000-0000000001ffffff (prio 0, rom): omap_sx1.flash0-0
>>> Eh two memory regions with same size and same priority... Is this legal?
>>
>> I'd say yes if used with memory_region_set_enabled() to make sure only
>> one is enabled. Having both enabled is weird and we should print a
>> warning.
> 
> Yeah, it's undefined which one becomes visible.
> 

I have a patch fixing that, resulting in

(qemu) info mtree -f
FlatView #0
  AS "I/O", root: io
  Root memory region: io
   0000000000000000-000000000000ffff (prio 0, i/o): io

FlatView #1
  AS "memory", root: system
  AS "cpu-memory-0", root: system
  Root memory region: system
   0000000000000000-0000000001ffffff (prio 0, romd): omap_sx1.flash0
   0000000002000000-0000000003ffffff (prio 0, i/o): sx1.cs0
   0000000004000000-0000000007ffffff (prio 0, i/o): sx1.cs1
   0000000008000000-000000000bffffff (prio 0, i/o): sx1.cs2
   000000000c000000-000000000fffffff (prio 0, i/o): sx1.cs3
   ...

but unfortunately that doesn't fix my problem. The data in the
omap_sx1.flash0 region is as wrong as before.

What really puzzles me is that there is no trace output for
flash data accesses (trace_pflash_data_read and trace_pflash_data_write),
meaning the actual flash data access must be handled elsewhere.
Can someone give me a hint where that might be ?
Clearly I am missing something about inner workings of qemu.

Thanks,
Guenter

