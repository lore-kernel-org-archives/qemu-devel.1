Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8118C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E741207FD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0DfUpYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E741207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA8JO-0006yL-SQ
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 03:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jA8Ib-0006SD-Ce
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jA8Ia-0005ys-BL
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:25:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54314
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jA8Ia-0005uu-7e
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583483135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcmG4ayhB7xQ0na+BdVrQTV41kgMVUqe3BpcCt+6wEs=;
 b=S0DfUpYPYeXbe7OE4H4VbTNbz9wfiY87nvvD2x+gDBzir0lh2+4zC9YtL8Vqd9ndmila/v
 wt2EZH8vnwUoJBin5+l+IbIDdg4U4WigrmOAFhmq1QCNAhfui+4bKHT5FDxllvWc3p4YY2
 zVRC1dMZ8IdTcz9pOpYdJ3+MiLBmpHw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-vmuNuCOqPImU3JrlsV8nAw-1; Fri, 06 Mar 2020 03:25:34 -0500
X-MC-Unique: vmuNuCOqPImU3JrlsV8nAw-1
Received: by mail-wr1-f70.google.com with SMTP id c6so676937wrm.18
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 00:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OcmG4ayhB7xQ0na+BdVrQTV41kgMVUqe3BpcCt+6wEs=;
 b=IxCoolCiK689/wzayZFF0nybYvjnH7axm8aAkap0U6mrGXlV8BdCKa90WWycdeRiht
 UUOlrTROM1WB2L6HnFNCq2Hzk1HK4hZ9qenXNVhsVcgKJTN04+I6A+7lKmJU+HvupqHi
 3bmhg4xakc2PVpyhT6q/wJz2zYg3S0Sh5yQRygB/gZR60IEJ1Mx8doj1W2pXLjvj0SkV
 V8g2I9V5Y2HYISGMuq55zbQy8Ey2rzIW/BhnyNi57/Cm9fyFTWHfzNeP9OfHabj325fN
 1ShwFR0J4K4Y7HPM5QKYlUeK6sndgqSlbFgWMCUaLedIvh7ICRWolESoFkEZiek+pA3b
 5TJA==
X-Gm-Message-State: ANhLgQ2ABnXoBLsX0Q9jL7qS2zcL9o9t+5Uog5yedEwUxrsUveHNATkU
 jqT5Bo/7/zxTqKKLccB9wvc2a+tTHutlDXkg4oOklP5K4BTbdvPZTQrNqfIQzEFIQmERKVzFjC+
 meyrTJSl2xccn+hk=
X-Received: by 2002:adf:de12:: with SMTP id b18mr2751077wrm.268.1583483132747; 
 Fri, 06 Mar 2020 00:25:32 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuuB936vlGsfRHeJbh+uYbV/lQpPukG8yWiw1TCZ7Vfo/AG95M4GjB384fZ6nL/Zz5J5FG+8w==
X-Received: by 2002:adf:de12:: with SMTP id b18mr2751049wrm.268.1583483132445; 
 Fri, 06 Mar 2020 00:25:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b99a:4374:773d:f32e?
 ([2001:b07:6468:f312:b99a:4374:773d:f32e])
 by smtp.gmail.com with ESMTPSA id k7sm48776106wrq.12.2020.03.06.00.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 00:25:31 -0800 (PST)
Subject: Re: [PATCH qemu v7 0/5] spapr: Kill SLOF
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20200220061622.15064-1-aik@ozlabs.ru>
 <db675fc6-9d07-1780-134d-6a9279328b29@redhat.com>
 <68b71292-48db-e2ec-5f22-fe4580c2938e@ozlabs.ru>
 <4109357e-0912-9633-20ad-28269efb2422@redhat.com>
 <9fc15711-5d06-e73a-798c-6f7c9ee05884@ozlabs.ru>
 <1c8cffc2-9a4a-9389-814b-c40d60a6a919@redhat.com>
 <34b5114d-1023-dc01-dd1b-5019c2da47db@ozlabs.ru>
 <8063379b-1e02-6e46-0657-72c1e0895235@redhat.com>
 <4c284187-14f9-775b-596a-386f8f6c14e7@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d550ece8-6d8a-97d9-7142-be823b1d3255@redhat.com>
Date: Fri, 6 Mar 2020 09:25:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4c284187-14f9-775b-596a-386f8f6c14e7@ozlabs.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/03/20 02:17, Alexey Kardashevskiy wrote:
>>>>>> Okay, that's great!  I'll take a look next week.
> 
> Any luck with this?

Not really, perhaps today.  But I don't object to already including a
minimal version of this in 5.0 as long as:

- it doesn't implement read and write

- it is called x-vof instead of vof.

I know it's kinda useless (though perhaps you can already boot with
-kernel?) but I don't want to make maintenance of the series too hard.

Paolo

>>>>> Just to make sure I understood - you'll take a look on this series, you
>>>>> do not expect other patches on top, right?
>>>>
>>>> No, thanks.
>>>>
>>>>> ps. while I have your attention, what was the practical reason for
>>>>> including capstone to QEMU? Thanks,
>>>>
>>>> Newer versions of the binutils disassembler are GPLv3.
>>>
>>> but why does qemu need this kind of disassembler at all? tcg does
>>> execution and it is not replaced by capstone.
>>
>> For debugging (e.g. "x/5i $pc" from the monitor, or "-d in_asm" if
>> you're using TCG).
> 
> Ah, this is the only use, ok. We could just install it from packages
> then or (for PPC) grab from Linux's ppc xmon but ok :) Thanks,


