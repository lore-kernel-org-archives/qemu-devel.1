Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DEAC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659392146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dza7MnyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659392146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDAhI-0004DM-9U
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 13:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDAfH-0003Y3-Bq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDAfG-00007W-0f
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:01:18 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDAfF-000071-QV
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:01:17 -0400
Received: by mail-pf1-x444.google.com with SMTP id b128so3914906pfa.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J1JH6uMyxn8nQIR9PJxKTGU89vsVOKYDJiipmhqb9iY=;
 b=dza7MnyV/c7UoRzGy6QgRXU9GFnQ5y11loM+kkJtmy5Ttc12gJvDgZtFbEBT6YPPhb
 3NV67OecmEa6YMT+sUMRk/pLIM0CESEIJJeJzMa0MItWfSEt8fjMR9NtWkzubdqjLnCk
 4/attZrjnGb2KReAyt0J6IoAIJe/FpQxV7g3iqYyKx/KHGnu5wonLVRR/vvRJ2zc1Z8y
 j7rVJecQTknmHMnLNxQgHkT63e/ZlNCsqrr4fHeY7P6BR9C9fAWBncMDYH4YfkUAPd8l
 aiyhj3bwSX9LpuGJ36urh8UjMBZ4ctzhifcSiosTzQqAOkSgI0wupIYNhTfkGti74RR8
 fjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J1JH6uMyxn8nQIR9PJxKTGU89vsVOKYDJiipmhqb9iY=;
 b=OmN3YGaCpWyI63YNck5B/vlauH9kMbUbjElNR8z/VIDW/QRkDj8RpIy0y1PIQNhrAU
 EW5JYyC+HMHcZ51Gc3B5eNrjx4ZSCFQtUJic5vVEsSV47vuhIBxcoxg4bD1Z/wtMyFfT
 2iA2Vm8Vz3om/R2MOTnTwbcjEcueX0oDc/dzW/tr/lW01g7wVRqnxFCRkRV+eH62+/kE
 5iDF7lDDXyXgHjjvLHZm5sqZ9+H6LFItYQMABy/NZ1GMbxNga8CRzvbM7BJqHmbiGozD
 x9wD6wJ6tYJZGPGxtTV29nxvB7Pdk9A4ryUz3Z8ziBvPPArOhHqllr7xegYjyF5y975r
 kvaw==
X-Gm-Message-State: APjAAAXZ1vVtRfdtZTmRCs0WN+Lq/v6VnND1CPjZKrWUWn36e5ajUVpc
 Zy13S+E12g7TY9weqHTOOYLxYA==
X-Google-Smtp-Source: APXvYqyBeS4/CdYVfo+dcj867tUvuchDHdTDTCzM22XJ8V7TeX1SLmgvYGU7QFay5TYjzvOJNYaExA==
X-Received: by 2002:a65:67d4:: with SMTP id b20mr276898pgs.445.1569430875682; 
 Wed, 25 Sep 2019 10:01:15 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id x9sm10339723pje.27.2019.09.25.10.01.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Sep 2019 10:01:14 -0700 (PDT)
Subject: Re: [PATCH v4 08/16] cputlb: Move ROM handling from I/O path to TLB
 path
To: David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-9-richard.henderson@linaro.org>
 <87v9th9qnz.fsf@linaro.org> <080af734-eccb-16c9-2664-72dd26ff460c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <762b5a49-2f94-a82e-f8bf-61080de592a2@linaro.org>
Date: Wed, 25 Sep 2019 10:01:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <080af734-eccb-16c9-2664-72dd26ff460c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:59 PM, David Hildenbrand wrote:
>>> +            if (section->readonly) {
>>> +                tn.addr_write |= TLB_ROM;
>>> +            } else if (cpu_physical_memory_is_clean(
>>> +                        memory_region_get_ram_addr(section->mr) + xlat)) {
>>> +                tn.addr_write |= TLB_NOTDIRTY;
>>> +            }
>>
>> This reads a bit weird because we are saying romd isn't a ROM but
>> something that identifies as RAM can be ROM rather than just a memory
>> protected piece of RAM.
>>
> 
> I proposed a bunch of alternatives as reply to v3 (e.g.,
> TLB_DISCARD_WRITES), either Richard missed them or I missed his reply :)

Missed it, sorry.


r~

