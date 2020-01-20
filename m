Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD32C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF69E2070C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gakwTrm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF69E2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYk9-0001v2-Oi
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 10:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1itYiT-0000EM-NP
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1itYiS-0008L1-7B
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:49 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1itYiR-0008KW-VX; Mon, 20 Jan 2020 10:11:48 -0500
Received: by mail-pg1-x543.google.com with SMTP id x8so15682117pgk.8;
 Mon, 20 Jan 2020 07:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7wmGLD3FxzDo4Qx/leRHIRfy/hhT4P6n4YaMsQ4AyN0=;
 b=gakwTrm6YofyPH/0EjTZtzRtzAQVDPCnBBbuqh4/L/lpF4X4i4nt+Zf3sPCUNk7APd
 3VJPRYk1cFjMOUKQQJUj4BXJEX8hkmT2sq0FhkmNGzVNaLxhs+jKgTx59NO/5UQL4QtM
 I0KgOYGMARZUXo5PUIfZ7PQkn3z489LlJ+8UuLm8OEtILOcRNX7KDJqrwkOUG23r1Dbj
 lw7Z+DoupzTJVQXPxqnBYU84Dw1yNqcJJsZpt96cjhDMrF/duFKZ02WO6MSIhqDoLK8/
 Z4+pWiozTSFROY1eb7GWt8dPKSVpPZ20TOZx8mf4TNVhDehXZ8K1cOwPvr2b9T8ti4wX
 iPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7wmGLD3FxzDo4Qx/leRHIRfy/hhT4P6n4YaMsQ4AyN0=;
 b=MFkmHIaiA33OEH+SGkU7VuRmy78xifN6ywpw8VQesdvw2bDNRLDKeNAlCI5h5NvVPG
 O3BXT/070/B3EonHsW/XL86tWQ/cURT3QaVFJ3UEIVHm2FLnLcf1NJHMqVbIFJaq/zG9
 9Q9vIPDR5I8pmVoDT2CyOGoOE/PlGH5DZXO+4Z35oanH00lVHrQx4cc31JHt0JfGL92q
 1Da1hLPfEOwKJE7ohKasslSadlS4weOOmN5izNSj/R/wVnXbxBJEzyRsPerSevHo9L7W
 WvaxL1WR1fCpkJqZWRblohrFP8vS5m+kH2HLTozY0PF4pgH17w9PopzvSJ6WaBxgUF0R
 PwWw==
X-Gm-Message-State: APjAAAUUm38npFF2n/crhzvwii0QJcDtEW4danJJjkNXfK+TThVOnmWd
 YLGGgT9jreoT6MWjupuae1gfhJsA
X-Google-Smtp-Source: APXvYqztYQaKD3jo4x7OzY+M5F35gyyZS2gz+ECHb2JL7urHYbTTGOHuxg5IPl+UY52i3KAZow0kwQ==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr17570821pff.240.1579533106552; 
 Mon, 20 Jan 2020 07:11:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 a2sm37978328pgv.64.2020.01.20.07.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 07:11:45 -0800 (PST)
Subject: Re: [PATCH v2 2/7] hw/arm/exynos4210: Fix DMA initialization
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200118164229.22539-1-linux@roeck-us.net>
 <20200118164229.22539-3-linux@roeck-us.net>
 <CAFEAcA8yH8deTL6PrX42Lh_TbR=gx4QbukuKUOo1XgLod=2ZXg@mail.gmail.com>
 <526c74cf-bbaf-2c79-08ec-9472288aaa59@roeck-us.net>
 <CAFEAcA8j=RnrBcoJzpYJZcLUgyq4N-o7TVKhutoDR27idUu-1g@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <aae690a7-d580-e08c-c8cb-5aa6b30e5c2c@roeck-us.net>
Date: Mon, 20 Jan 2020 07:11:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8j=RnrBcoJzpYJZcLUgyq4N-o7TVKhutoDR27idUu-1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 6:46 AM, Peter Maydell wrote:
> On Mon, 20 Jan 2020 at 14:30, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 1/20/20 5:35 AM, Peter Maydell wrote:
>>> As the comment in or-irq.h notes, we can safely simply bump the
>>> #define value without breaking anything if you need more input
>>> OR lines than 32.
>>>
>>
>> Yes, I noticed the comment, and I did that initially, but then
>> I noticed the complexity of actually doing it in the code
>> increasing it from 16 to 32, and decided I better leave it alone.
> 
> Yeah, the conversion from 16 to 32 was hairy because our
> initial implementation made the migration-compatibility
> awkward. When I wrote that conversion I was careful to
> avoid creating a similar problem for my future self if
> I needed to bump the value again :-)
> 

Ok, with that in mind I'll add a patch increasing the limit.
I'll set it to 48. Then we can discuss if the new limit is
sufficient/acceptable ;-).

Thanks,
Guenter

