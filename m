Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F2EC31E43
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A784A2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A784A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haN1i-0000oa-Lx
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 12:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1haN0X-0008AJ-9s
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1haN0T-0003nH-3u
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:18:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1haN0P-0003Vp-5b
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:18:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so6314615wmj.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 09:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9gZMcMOE6LbzIHKMTOU9HKqd3BfaEkdPeL9JigdCbcA=;
 b=hWtUL4nMxyQ2e05KLLJNIDgbkyRx+0/7qYFt70PKMpSo6BAt6Lwk/qmVYHA7QVgdEg
 TwiSYyuSJW9EOmZD4a8+Ridpd3jrpIki1+cP8bP6UEz9UE6QZqZUlSwdIjOwLr1Fjrei
 2/PunYdzKLX5iH/zr0CuURdDExZgjL6+Ecmxc9PtEbO4sRceewY+6DAsp7mrMgaXVBNf
 d0VP2gsxy/d8SdESVbHUW3zCyKGyazjvhkKb1u/ggJZwWegom5aG1+e1mKb+P9ZJGBRf
 6u2o6+kgPGw3AWjlpV7sl4hiB17lnfFKUBLhTvfTLxbqpXsnzRlCZqLoU+HgyVsKtkNL
 jWZA==
X-Gm-Message-State: APjAAAUScV/FkMkJbWRHp8CrPLlx64iF8LO0ruRFl/JtO9dFh0sfxKDN
 SNzxtZtk7YcaKTskEczxWlxhig==
X-Google-Smtp-Source: APXvYqzHNQIyy+jouBxlKwBV6EILrDIN6mH4GoCqWmCZZgZaJCIfSMPVXHhaLmUqrbeEtKKbYcnsqQ==
X-Received: by 2002:a1c:7f96:: with SMTP id a144mr4839087wmd.124.1560183513755; 
 Mon, 10 Jun 2019 09:18:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:49d3:a711:c5a3:8ebf?
 ([2001:b07:6468:f312:49d3:a711:c5a3:8ebf])
 by smtp.gmail.com with ESMTPSA id j123sm13548711wmb.32.2019.06.10.09.18.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 09:18:33 -0700 (PDT)
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
 <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
 <5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
 <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
 <003b01d51f72$5e6f4160$1b4dc420$@Fursova@ispras.ru>
 <67806828-f666-0c9c-00fc-b520f15013d9@suse.de>
 <e4fe4dc0-f3c4-a051-d39d-afd7bfdc680d@redhat.com>
 <98826c5f-4a74-5364-2aef-28a10db12c20@suse.de>
 <39250506-f38f-c440-5728-7b970d32ab41@redhat.com>
 <79b821a4-7cc0-2461-7ca4-d71c3e5ee4ef@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c49abf01-c209-b206-edee-507c31269011@redhat.com>
Date: Mon, 10 Jun 2019 18:18:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <79b821a4-7cc0-2461-7ca4-d71c3e5ee4ef@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] qgraph
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
Cc: =?UTF-8?B?J9Cf0LDRiNCwJw==?= <Pavel.Dovgaluk@ispras.ru>,
 qemu-devel@nongnu.org, Natalia Fursova <Natalia.Fursova@ispras.ru>,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/19 18:12, Andreas Färber wrote:
> Am 10.06.19 um 15:52 schrieb Paolo Bonzini:
>> On 10/06/19 15:28, Andreas Färber wrote:
>>> So if we want a new QMP operation, the most sense would probably make
>>> where-can-I-attach-type(foo) returning a list of QOM paths, showing only
>>> the first free slot per bus. That would allow a more efficient lookup
>>> implementation inside QEMU than needing to check each slot[n] property
>>> via qom-get after discovering it with qom-list.
>>
>> Note that what Natalia is seeking is an introspection mechanism to be
>> used _before_ creating a virtual machine though.
> 
> QMP implied creating a virtual machine though.

Yes, but you can start QEMU with -M none and just invoke QOM
introspection commands.

> This then goes back to the long-discussed topic of not doing recursive
> realized=true when starting halted with -s but deferring that to the
> cont operation. I doubt that's been implemented in the meantime?

Nope.

Paolo

