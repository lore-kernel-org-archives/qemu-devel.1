Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AE6C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6333D208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6333D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsyUn-0003yZ-Is
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 19:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34592)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsyUR-0003Yn-P3
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsyUQ-0006TZ-Sk
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:58:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsyUQ-0006TR-Mv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:58:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so62670726wma.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 16:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dyb97nclF/b6ZwgfcaF7Gq3uKg1zCz2BXYTf5tpTyMw=;
 b=rIi84g5mUh9KrWTBeduYskJIv/CwGhnEXthYsTpr0OdPqw2WCBQ56NiScXXDJolX7Z
 PAdNONZz1oVtIB8qufZPfdrCOu1UF/1w/ijRY/rLqL1lFlUwwTSDlRgzhvLzkShxP8VJ
 A+AVdaAhpbXOjbwIePT5cM2CEVka/RzFr/bfAQS5uvjFn68Wk7gnRO/7vR2G99gRIau1
 JKDK7QzODvbjCn7HDPIasa9Y55Em3ukFsC63RQquWuBQyYjl9K+/5wpbmPB6pIe7eCeC
 duQqJan7cFUYph6uXa3lD8n/cD++vGLBz+wIsrFerLPLr7oNKK5LkXa+7ASl4Fmf9Pro
 IaIQ==
X-Gm-Message-State: APjAAAWjrahwqyS1maYeKRU3LocF0bwtf0eBQVjIbFuTuYt0oTJs7EAN
 1eT4NDz6DfpBRu426wD8hcstvTmeBuU=
X-Google-Smtp-Source: APXvYqxvKplWHoIm1Wdn6Qvdbc94I8yOiklVCV4JhsS/X/7WgaK3HMZ2vocpEVnsYz/tYFCEkLeviQ==
X-Received: by 2002:a7b:c398:: with SMTP id s24mr114441256wmj.53.1564617517496; 
 Wed, 31 Jul 2019 16:58:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3?
 ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
 by smtp.gmail.com with ESMTPSA id s12sm64718558wmh.34.2019.07.31.16.58.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 16:58:36 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
References: <20190729125755.45008-1-slp@redhat.com>
 <932a0c3c-b6cb-540f-ca07-1559c8fe9049@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9953cc99-80b3-814c-f75e-a16c987c23e5@redhat.com>
Date: Thu, 1 Aug 2019 01:58:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <932a0c3c-b6cb-540f-ca07-1559c8fe9049@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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

On 30/07/19 18:06, Laszlo Ersek wrote:
> On 07/29/19 14:57, Sergio Lopez wrote:
>> Implement the modern (v2) personality, according to the VirtIO 1.0
>> specification.
>>
>> Support for v2 among guests is not as widespread as it'd be
>> desirable. While the Linux driver has had it for a while, support is
>> missing, at least, from Tianocore EDK II, NetBSD and FreeBSD.
> 
> That's right; not only are there no plans to implement virtio-mmio/1.0
> for OVMF (to my knowledge), I'd even argue against such efforts.
> 
> OVMF is a heavy-weight guest firmware, which I see entirely out of scope
> for "micro VMs". And so virtio-mmio/1.0 would seem like a needless &
> unwelcome complication, from the OVMF maintainership perspective.

But given that, why not rip out virtio-mmio completely?

Paolo

