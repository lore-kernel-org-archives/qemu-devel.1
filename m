Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91909C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FE22065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmlfGHUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FE22065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ8zS-0003ov-HF
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 04:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ8ys-00037O-H3
 for qemu-devel@nongnu.org; Thu, 14 May 2020 04:12:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ8yr-0005zS-EK
 for qemu-devel@nongnu.org; Thu, 14 May 2020 04:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589443956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1h+sP57UvvFs27dj9kFELW/yutXF1JyleYZndeuBKkA=;
 b=EmlfGHUl3A7Wm3nwfFinv8cQqizS/Kxm9PlzIRUclXnCnv21n+IbcrTjs6uQjSDpQRTi5X
 Nz2vMZBEjHHvH3p5q5k+h0oB5vinWefBgiy3EHZ4ZpdXY488GjaMHBYR19kJ7UNaL87viZ
 13HJR2dFWUyOcjUANbkJ/jJByXihAjs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-6WoxgopZMgaEN4cSTN1x9Q-1; Thu, 14 May 2020 04:12:30 -0400
X-MC-Unique: 6WoxgopZMgaEN4cSTN1x9Q-1
Received: by mail-wm1-f70.google.com with SMTP id h6so13088627wmi.7
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 01:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1h+sP57UvvFs27dj9kFELW/yutXF1JyleYZndeuBKkA=;
 b=dRDoaLYLzSwLGX6y8gK4c/r+Yye5o0ftawjlhs+oQJHq5DKKpdf/6PiQFapEbYgxFm
 yYt0ZKcKFbswmtJzRRCOy7SDcj63CTaqWWSXyvuZGOwOoDHecdwjU3mi3QMJGqryFT95
 tNAC1k6NB1SzaygsGfh4XbYXWe4DdjA+IHahY0w5mswSBVuGJsB9vgaEXtL2JjiqtgP6
 FUulZBzwq9gLqu2tFUXIgG26gEofrg3hvq/vF6nymLfuVTjFb9+NW6tE/hsBml0m+Rn3
 u0h02p0592GEPlq5repdVbrRZLqprUkchT43zBGS3juQP8lG7tWRc0Ul3sSrDO3Hm0qE
 H1gw==
X-Gm-Message-State: AOAM531ouJ7/1YLV87PSPcB2FJD+NMEGbXubj39k+z56Dqj7BFI072oP
 eWt5rHJgguarh1FLPyWCqmCEw8Dpse7HKX/UBxWVckqOlo9veCmF6/ghIrH1tigcyhl5lhH/GP+
 B37wunb41ZBRO3P4=
X-Received: by 2002:a5d:4b09:: with SMTP id v9mr3952362wrq.297.1589443949595; 
 Thu, 14 May 2020 01:12:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTw0P+cn+dabho3k1kyx+JFnyP5ZWcJMAL/LCWVbkjsQKj0zKMn6b6D7oBCmt/fp7kijQ9UQ==
X-Received: by 2002:a5d:4b09:: with SMTP id v9mr3952330wrq.297.1589443949385; 
 Thu, 14 May 2020 01:12:29 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id u74sm39480937wmu.13.2020.05.14.01.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 01:12:28 -0700 (PDT)
Subject: Re: Assertion failure through vring_split_desc_read
To: John Snow <jsnow@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-devel@nongnu.org
References: <20200511035124.v2ff4f5gyfh6xlgc@mozz.bu.edu>
 <c4066d16-81ef-a052-a689-160bfc36baa3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dda83bb6-1b13-779a-9322-13d927cfb6a7@redhat.com>
Date: Thu, 14 May 2020 10:12:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c4066d16-81ef-a052-a689-160bfc36baa3@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: lvivier@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 1:24 AM, John Snow wrote:
> 
> 
> On 5/10/20 11:51 PM, Alexander Bulekov wrote:
>> Hello,
>> While fuzzing, I found an input that triggers an assertion failure
>> through virtio-rng -> vring_split_desc_read. Maybe this is related to:
>> Message-ID: <20200511033001.dzvtbdhl3oz5pgiy@mozz.bu.edu>
>> Assertion failure through virtio_lduw_phys_cached
>>
>> #8 0x7fe6a9acf091 in __assert_fail /build/glibc-GwnBeO/glibc-2.30/assert/assert.c:101:3
>> #9 0x564cbe7d96fd in address_space_read_cached include/exec/memory.h:2423:5
>> #10 0x564cbe7e79c5 in vring_split_desc_read hw/virtio/virtio.c:236:5
>> #11 0x564cbe7e84ce in virtqueue_split_read_next_desc hw/virtio/virtio.c:929:5
>> #12 0x564cbe78f86b in virtqueue_split_get_avail_bytes hw/virtio/virtio.c:1009:18
>> #13 0x564cbe78ab22 in virtqueue_get_avail_bytes hw/virtio/virtio.c:1208:9
>> #14 0x564cc08aade1 in get_request_size hw/virtio/virtio-rng.c:40:5
>> #15 0x564cc08aa20b in virtio_rng_process hw/virtio/virtio-rng.c:115:12
>> #16 0x564cc08a8c48 in virtio_rng_set_status hw/virtio/virtio-rng.c:172:5
>> #17 0x564cbe7a50be in virtio_set_status hw/virtio/virtio.c:1876:9
>> #18 0x564cc08d1b8f in virtio_pci_common_write hw/virtio/virtio-pci.c:1245:9
>>
>> I can reproduce it in a qemu 5.0 build using these qtest commands:
>> https://paste.debian.net/plain/1146089
>> (not including them here, as some are quite long)
>>
>> wget https://paste.debian.net/plain/1146089 -O qtest-trace; ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc-q35-5.0  -device virtio-rng-pci,addr=04.0 -display none -nodefaults -nographic -qtest stdio < qtest-trace
>>
>> Please let me know if I can provide any further info.
>> -Alex
>>
> 
> Do you have a writeup somewhere of how you are approaching fuzzing and
> how you've found this pile of bugs so far?

There is docs/devel/fuzzing.txt:

https://git.qemu.org/?p=qemu.git;a=blob;f=docs/devel/fuzzing.txt;hb=v5.0.0

> 
> Might make for a good blog post.

Good idea!

> 
> --js
> 
> 


