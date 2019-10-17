Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEE2FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4177620869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4177620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL3TK-0003bW-En
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL3SS-00038O-Eh
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL3SQ-00022I-B2
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:56:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL3SQ-00021g-3I
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:56:38 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A69A63CBE2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 10:56:36 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z205so961650wmb.7
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 03:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wu5u7KI0XMs64BWGJ0e74lh478FbAVJbyhcQ98bW4RQ=;
 b=uGPF6ZjQkxJpRizJO0/5f+D3jd0ITSp/i1cpIHN9J6fjLaA9K33Ch58jH1GMGBZEQw
 RhHpNMW3iVoqlJT9BXFceio8HgjR/3p0iiw5TghPcG6ZVgdNIAk7lgWhJcSkJXI1rwDl
 hUfsRQuW9qqWofBuTANSdBHk6htbu9Vq5+2Aoj6XmuddMKGKN29hqP8FIYhosGaPHXnq
 kalyxfKT4lXOcMXO7ikW9wDySRw+/W8zXe6rOMVxsummDiCxdPWSgOEWb74YG7JHartB
 1uoLdeMw3dfeCGAAtbBzz3eDjBYikTWUzIC5bIvm1WBIOUM4ehS7fEDOcVHSW5SLJdWJ
 B5rw==
X-Gm-Message-State: APjAAAXEUcEyLQNdUCGzfVZgW1/yPvx7Ql4JTKosIqNa+7KTh4LQSxFn
 5AoMqGgnLsNd72WhWUcOGzunvBilRYoc8IdDtw6ZPxmDesGtgGmZe3PncIjtJFLrN8w7NE3mmYM
 Iq71+vBtNoPMarv4=
X-Received: by 2002:a7b:c773:: with SMTP id x19mr2247101wmk.157.1571309795418; 
 Thu, 17 Oct 2019 03:56:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwHR8f8SQMXO1nEgnjev2E29jT9jApGgMj3PYJK5PXnAgs+EmF2Gdqw0H0hGPKqlBjWFMA0mA==
X-Received: by 2002:a7b:c773:: with SMTP id x19mr2247077wmk.157.1571309795229; 
 Thu, 17 Oct 2019 03:56:35 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id f83sm1882500wmf.43.2019.10.17.03.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 03:56:34 -0700 (PDT)
Subject: Re: [PATCH v10 13/15] docs/microvm.rst: document the new microvm
 machine type
To: Sergio Lopez <slp@redhat.com>
References: <20191016101241.24405-1-slp@redhat.com>
 <20191016101241.24405-14-slp@redhat.com>
 <d981516f-f23a-47f5-d825-a101fdaaf471@redhat.com> <87ftjrhcq7.fsf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6e84a3fb-0ded-6302-af44-a1d70eea60fa@redhat.com>
Date: Thu, 17 Oct 2019 12:56:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87ftjrhcq7.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 12:45 PM, Sergio Lopez wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> Hi Sergio,
>>
>> On 10/16/19 12:12 PM, Sergio Lopez wrote:
>>> +Supported devices
>>> +-----------------
>>> +
>>> +The microvm machine type supports the following devices:
>>> +
>>> +- ISA bus
>>> +- i8259 PIC (optional)
>>> +- i8254 PIT (optional)
>>> +- MC146818 RTC (optional)
>>> +- One ISA serial port (optional)
>>> +- LAPIC
>>> +- IOAPIC (with kernel-irqchip=3Dsplit by default)
>>> +- kvmclock (if using KVM)
>>> +- fw_cfg
>>> +- Up to eight virtio-mmio devices (configured by the user)
>>
>> If we have VirtIO devices, why not use virtio-serial instead of the
>> one on the ISA bus?
>=20
> The serial port on the ISA bus is simpler, and thus is supported for
> both SeaBIOS debugging and Linux's earlyprintk. This makes it *very*
> convenient for debugging boot issues.

"... but it's also compatible with SeaBIOS"

OK. Maybe we can add a comment such "These devices are the minimum=20
required to run SeaBIOS" in the 'Supported devices' section.

>=20
> Also, as it's explained in the documentation, users that no longer need
> it can disable the device and just rely on virtio-console.
>=20
> Sergio.
>=20

