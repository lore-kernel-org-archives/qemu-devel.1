Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD69C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F602073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmEIlRQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F602073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU4Bq-0002jX-5X
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU4Aj-00021W-Uf
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU4Aj-0003Xw-Bi
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:03:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56856
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU4Ai-0003Xp-W0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588233832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLHrjZ1+VXug6QIH0Foa/XU1kf4NBYILln4c4IgQjPw=;
 b=SmEIlRQPXmScI0So6z+vt/kJYUOVmmJuNjyBPKyzVlYJbUGe7CihKvDOkTbSfksTlNNRbw
 y3MEQ641YZOfFEAi37f0Q7lCWtyMSkf5iVWaNyY3T2BDhD3QYk7QtNX/07OtwFJpnAqgW+
 QpbdqCvXbaBchVZn9RieVTyEIdPDHjg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-7V1t5KzEP6KEm8qg9JtSkA-1; Thu, 30 Apr 2020 04:03:49 -0400
X-MC-Unique: 7V1t5KzEP6KEm8qg9JtSkA-1
Received: by mail-wr1-f71.google.com with SMTP id o8so3451746wrm.11
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 01:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SVpRPJlin+kKFzP9gNCPBRDx/nk0CAAWVq22yMbLlaE=;
 b=OEqUDNdDO4zic7kUZDcoRcfMjai10VJg18tKyYsK7+EPdz7JnWiIQtcxXvO94aazbk
 uRcseEp1Ta6IkfwRaHx8zYgMJidhxmT81TkIC6W+dsVymCU7yaIEihScrPxZBjUhqqmP
 cBeXOsYSGfXNBSBxu/YCoUhPHXBz876wePfxJgWzOu06AgY8r+sHZFxcCvfwwLU92xmx
 1h4sYqgjS7TWH5Vc3Vk40RjIzkulM7XGkrSjHbtW1ZbTH6VAZnMJiQWkok5UBUp/HDAe
 UCDquovMS3M0O5vmSLUdB4ehtnpO3ld3Rugoub6+MzIy0o1IItMW4n57crI+Fq92NHRE
 +kLg==
X-Gm-Message-State: AGi0Puaa1SZ1vaDWMws1zR6LO3rsTWNmb+V/WzTTIYeARZxRjR9kGIQm
 /ffaS5c+AaXwIQb0NFdFF9iAr7YvHha07Iws5ZG33TnmQbFoI/WTER5C/VXxAJQWXErY++PwinC
 RT3P6boYRp1ugT2U=
X-Received: by 2002:adf:d0c5:: with SMTP id z5mr2562717wrh.410.1588233828377; 
 Thu, 30 Apr 2020 01:03:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypL0xYX1wmhGJ5ixzuliG1jDvtyFXLBBRf38m2h7zU+uScvNVDzbswy8ZCbp7QsewjKqXWu9QA==
X-Received: by 2002:adf:d0c5:: with SMTP id z5mr2562688wrh.410.1588233828150; 
 Thu, 30 Apr 2020 01:03:48 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id g25sm10939121wmh.24.2020.04.30.01.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 01:03:47 -0700 (PDT)
Subject: Re: [PATCH 00/12] audio: deprecate -soundhw
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200429110214.29037-1-kraxel@redhat.com>
 <f2d7187a-953c-2b53-07fb-0a3e5f32193d@redhat.com>
 <20200430074108.pxgbu3uyvk77vivd@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <99d3334a-1b14-b0d3-9955-71e27d739c3a@redhat.com>
Date: Thu, 30 Apr 2020 10:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200430074108.pxgbu3uyvk77vivd@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 9:41 AM, Gerd Hoffmann wrote:
> On Wed, Apr 29, 2020 at 06:54:08PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Hi Gerd,
>>
>> On 4/29/20 1:02 PM, Gerd Hoffmann wrote:
>>>
>>>
>>> Gerd Hoffmann (12):
>>>     stubs: add isa_create_simple
>>>     stubs: add pci_create_simple
>>>     audio: add deprecated_register_soundhw
>>>     audio: deprecate -soundhw ac97
>>>     audio: deprecate -soundhw es1370
>>>     audio: deprecate -soundhw adlib
>>>     audio: deprecate -soundhw cs4231a
>>>     audio: deprecate -soundhw gus
>>>     audio: deprecate -soundhw sb16
>>>     audio: deprecate -soundhw hda
>>>     audio: deprecate -soundhw pcspk
>>>     [RFC] audio: try use onboard audiodev for pcspk
>>
>> I don't understand what you are trying to fix with this series.
>=20
> Almost nothing.  I'm just deprecating -soundhw, and I don't feel like
> putting too much effort into code which I want remove anyway.
>=20
> The new deprecated_register_soundhw() is there to allow removing the
> init callback for most hardware and have common code handle the simple
> cases.  Alternatively I could leave things as-is and just copy&paste the
> deprecation warning into each init callback.
>=20
> The only functional change (beside the added deprecation warnings) is
> that the pcspk realize function initializes audio in case audiodev is
> set, so "-global isa-pcspk.audiodev=3D<something>" is enough to activate
> the speaker.  The need to also have "-soundhw pcspk" on the command line
> is gone.
>=20
>> I suppose there is a problem with the pcspk, as I had a problem when I t=
ried
>> to make the soundhw more QOM-friendly.
>=20
> I see your patch adds a deprecation warning for -soundhw too.  I'm
> wondering why you want convert this to QOM now just to throw away the
> code in a few months?

Well I didn't know you planed to throw them away. I started looking at=20
the hw/audio/ files for the Arduino GSoC project because we want the ADC=20
to sample data from a stream of floats (then opposite with PWM). Using=20
.wav file seemed to make things simpler, then I noticed the AUD API.=20
Then I started to have a cleaner producer/consumer API (i.e. the 8042=20
PIT is a dsp stream producer, the pcspkr is a dsp stream consumer). To=20
to that it was simpler to implement the producer/consumer interface=20
split with the QOM API. The you know the NeverEnding Story... The=20
-soundhw cleanup was part of it, as it was simple/contained I extracted it.

>=20
> cheers,
>    Gerd
>=20


