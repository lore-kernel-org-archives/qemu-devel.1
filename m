Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DBDC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF7E21BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF7E21BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvJ1A-00005E-N4
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41666)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hvIze-0007AZ-0S
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hvIzc-0005IL-UO
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:16:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hvIzc-0005HM-Ov
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:16:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so90884094wru.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ik12nwOBMQLtI3joPNRn2RmodxBG9wi8VAy/nqQXW38=;
 b=FK31qX4xvr86Mvgzr/xX6KjRRDYxGG3QUbw4KbpBCdS6tRfdBwQAq8IyEAnicnx35+
 thzB0lCWSkfNTDMI8Pqwx0TqDZDOExHfZ80YNL4rmB1pYQjQhi/iTixkNqiJ6c3LX1j4
 pLCE+vaqd4tAWTNX2rWhd034omVV7/r8Zt7atTaOkkZmG9Qj1OgjKy+jHyuv+yu5UwkK
 oOwe0AwiT1n8mL5k2SoaCIq7YYDxvBAtfqIo7PiJCHnKBqSuTxCH+s+drJHk25iNiRJA
 ZGaYlYOF03tLhuBx7zJGjR8oxCHlC4CvIoMn03e9ynWraaXyGrzy7h0752rnwph8jlf+
 7NYw==
X-Gm-Message-State: APjAAAUn/4selobC7cokjDuXuhoNtotiacn0scexq/8vzBAwRzpSt5mq
 0VBjBfEdp9LFnCKvrEX6Nf3qWMQGm68=
X-Google-Smtp-Source: APXvYqzLHTC0IwD3ME668CK6cZi4+nkPNQOU3ThlyzQJIFstTHJmAB7K/UJ/MiiLHILYbt4H3qbNSQ==
X-Received: by 2002:a5d:424e:: with SMTP id s14mr3096259wrr.333.1565172987486; 
 Wed, 07 Aug 2019 03:16:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id p13sm15585095wrw.90.2019.08.07.03.16.26
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 03:16:26 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-5-armbru@redhat.com>
 <4c43b5ba-4204-6a28-d3f1-348d8d25c6d5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1cabeef1-20c4-eeba-7ede-8472ca378524@redhat.com>
Date: Wed, 7 Aug 2019 12:16:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4c43b5ba-4204-6a28-d3f1-348d8d25c6d5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 04/29] memory: Fix type of
 IOMMUMemoryRegionClass member @parent_class
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/19 12:11, Philippe Mathieu-Daudé wrote:
> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>> TYPE_IOMMU_MEMORY_REGION is a direct subtype of TYPE_MEMORY_REGION.
>> Its instance struct is IOMMUMemoryRegion, and its first member is a
>> MemoryRegion.  Correct.  Its class struct is IOMMUMemoryRegionClass,
>> and its first member is a DeviceClass.  Wrong.  Messed up when commit
>> 1221a474676 introduced the QOM type.  It even included hw/qdev-core.h
>> just for that.
>>
>> TYPE_MEMORY_REGION doesn't bother to define a class struct.  This is
>> fine, it simply defaults to its super-type TYPE_OBJECT's class struct
>> ObjectClass.  Changing IOMMUMemoryRegionClass's first member's type to
>> ObjectClass would be a minimal fix, if a bit brittle: if
>> TYPE_MEMORY_REGION ever acquired own class struct, we'd have to update
>> IOMMUMemoryRegionClass to use it.
>>
>> Fix it the clean and robust way instead: give TYPE_MEMORY_REGION its
>> own class struct MemoryRegionClass now, and use it for
>> IOMMUMemoryRegionClass's first member.
>>
>> Revert the include of hw/qdev-core.h, and fix the few files that have
>> come to rely on it.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

