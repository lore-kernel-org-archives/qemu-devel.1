Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087B5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 19:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B992072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 19:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e94BlKro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B992072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihINP-0006Vw-0u
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 14:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihIME-0005zy-Iy
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 14:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihIMB-0008NJ-I1
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 14:18:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46760
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihIMB-0008MG-3L
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 14:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576610285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EY10WP4C5yT0xa3xvruWTgq7ZCMlsvawrEsae2c6ffY=;
 b=e94BlKroZ42FntPCk1SNLtpZ9GPHv/MjY+/hywi168aDCwU9uMAR21m++lgw3ukKJ3hD4R
 OmjklBxfO0xx8sGGZFbk0Tf94PZG/9ueRiNQCirJWDM6LN4TgSwHc15RatkvwkkGuC8nSV
 VESNbF4KLnPcRZzMsbof4anYQfmwGYs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-QLVI9fYkPxetp3ZhOTW9NQ-1; Tue, 17 Dec 2019 14:18:01 -0500
Received: by mail-wr1-f70.google.com with SMTP id 90so5728694wrq.6
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 11:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EY10WP4C5yT0xa3xvruWTgq7ZCMlsvawrEsae2c6ffY=;
 b=b8PmRHsYkchZG9FRgFVje6FTVT7hCWRwknZiFfxU3YDIznszPi/eg39g4sFOrasasN
 +t/kLDpxDcEEoQf61NReL7ZQHZ94oLrXG/qZQgd5oaGvxv5gqvQ9raR5GUbsELnkGtyf
 WAEZhbMj3R3Ni2ywnjZQtZFHUt3S9jJ3TpEjoZ+TbqY2bulXIYa9jxaNGHhhSo7Sy80L
 eXmVrHqYBodLkDBKB6FKLK5sJ4kraLU3aH9RyamhhC71cf0FqFyvasnKhtofcrOOAn/Y
 ANlHICjITINgNq59coIYN9Kahk3Cz0K/dfsqkgTVlyqiIRHAiU3geRzpBcSLmwbBM5fu
 LJ3Q==
X-Gm-Message-State: APjAAAWGVN4SJxgM0KX2Xph5rat/c5aQHRY/QGdgfFPotS4c3reoZLku
 9SHrwNXA/FVxBUHBBNnHpiD7VTfPkm5/OzgUCfc6/UuDErUZZ+KBujzmsfiHR0k2HxGk2NMaplA
 J/lQ+6sbMPA4DvKQ=
X-Received: by 2002:adf:edd0:: with SMTP id v16mr38342897wro.310.1576610279770; 
 Tue, 17 Dec 2019 11:17:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoHAMWMMSrzhnAyGEUJuVGYq0yhfLIUc/4YNqvkuAe/BV2FxqPYxzqtQz8DCPgmNz2bVOQbQ==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr38342870wro.310.1576610279589; 
 Tue, 17 Dec 2019 11:17:59 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id e18sm24951383wrw.70.2019.12.17.11.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 11:17:58 -0800 (PST)
Subject: Re: [PATCH] memory: Do not allow subregion out of the parent region
 range
To: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20191214160223.20012-1-philmd@redhat.com>
 <da81a3e7-62a8-f46e-c12f-4dead2a9091f@redhat.com>
 <92bb8e12-3ece-9811-438b-8fa64d2bde66@redhat.com>
 <4a07cc6f-8762-145e-2b54-c61b0e287f19@redhat.com>
 <127AF076-D309-4952-B572-52587A93F46A@redhat.com>
 <c5c27111-efc5-0a05-bdbd-415533e5bc30@linaro.org>
 <CAFEAcA955AwoDiuYxm0mJKV1qzyBorAz06dqi0tg2kMBT9GMTA@mail.gmail.com>
 <ab832e97-f583-c347-0b4d-0d2e11f6b2b3@redhat.com>
 <20191217115237.18e7fc4c@x1.home>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3d41dde6-9f74-c741-590e-58c86d34e2e1@redhat.com>
Date: Tue, 17 Dec 2019 20:17:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217115237.18e7fc4c@x1.home>
Content-Language: en-US
X-MC-Unique: QLVI9fYkPxetp3ZhOTW9NQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Christophe de Dinechin <dinechin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 7:52 PM, Alex Williamson wrote:
> On Tue, 17 Dec 2019 19:31:41 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 17/12/19 19:17, Peter Maydell wrote:
>>> On Tue, 17 Dec 2019 at 16:57, Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
>>>>
>>>> On 12/17/19 1:58 AM, Christophe de Dinechin wrote:
>>>>>
>>>>>   
>>>>>> On 17 Dec 2019, at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>>> Yes, the idea is that you could have for one version of the device
>>>>>>
>>>>>>    parent 0x000-0x7ff
>>>>>>      stuff 0x000-0x3ff
>>>>>>      morestuff 0x400-0x7ff
>>>>>>
>>>>>> and for another
>>>>>>
>>>>>>    parent 0x000-0x3ff
>>>>>>      stuff 0x000-0x3ff
>>>>>>      morestuff 0x400-0x7ff
>>>>>>
>>>>>> where parent is the BAR, and you can share the code to generate the tree
>>>>>> underneath parent.
>>>>>
>>>>> I can see why you would have code reuse reasons to do that,
>>>>> but frankly it looks buggy and confusing. In the rare cases
>>>>> where this is indented, maybe add a flag making it explicit?
>>>>
>>>> The guest OS is programming the BAR, producing a configuration that, while it
>>>> doesn't make sense, is also legal per PCI.  QEMU cannot abort for this
>>>> configuration.
>>>
>>> Does guest programming of the PCI BAR size actually change the size
>>> of the 'parent' region, or does it just result in the creation
>>> of an appropriately sized alias into 'parent' ?
>>
>> Resizable BARs are not handled by the PCI host bridge but rather from
>> the device itself, so the device is free to handle them either way.
> 
> More specifically, it's the responsibility of drivers within the guest
> to resize the parent bridge aperture to make the extent of the BAR
> accessible.  This does seem like an interesting way to implement a
> resizable BAR in QEMU though.  Thanks,

This is something I'm thinking about since some time, as I observed this 
behavior in 3 different MIPS boards with different northbridge chipset 
(Malta with the GT64120, Fuloong2E with the Bonito).
The firmware sets one layout, Linux (or other) reinit & reorder all the 
memory layout. I guess Mark hit the same issue with his sparc64 based 
boards.


