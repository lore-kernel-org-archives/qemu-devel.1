Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBCDC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8254D22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8254D22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0U4D-0005OF-Nf
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0U3X-0004ho-MN
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0U3V-0002r9-Q7
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:05:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0U3V-0002qd-Hr
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:05:53 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 94E6C7E425
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:05:52 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id k10so1496895wru.23
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gXJ+NHbUHMveReSqMrUcgn6Az2OcygrDoyZ/PQGsmgc=;
 b=MjzH5lIMqJu9siOH1V1LsNnaTqlM12dC+miT/E5QSNxReT/ZY92mBzWSh9ZqRZxF6t
 MpwW3bKYWJibHi0jBFc17m0FhbuFHWlx3LJ+PA9ypLOkgTuYJ0N3PUeWQUxKlhpaLzhD
 twSTPS8E8z8/rHFdRmGqgYux9kgX7Rvl6rVc+Tv+pOWtZvcfQqR4nu8rTqx4HZBrId//
 LOtDLeokLuyA4JDRcVZczQudzIVrEEoUDojp3o++9sRY6QxzCda/PG9HyIx6RZWUJDjD
 ylSzTv7LE1sYI25JgX31O2SeMmp3o4FhnGxEDj6Cq9TvzvjTwYCDDhQZPmzRjX74yW0r
 1xew==
X-Gm-Message-State: APjAAAXgBQxxGACroYsqe7xEXr8FbUfDvyYkeqNMz1oGPpcca4J3txUx
 IGS7ZD4cZIYrUdu0L1L1SpptRag2q/S7zQ6wqU1C/2m6K4IEDOfTL2ubSNg+F6v+htRFuolkjz5
 CF/Z61EEyCOx57Bw=
X-Received: by 2002:a05:600c:207:: with SMTP id
 7mr1147873wmi.146.1566407150416; 
 Wed, 21 Aug 2019 10:05:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzag7f0De7kGe4F0By0ZV/xiSzZmZkPOU5yGbJSHJEYAOGAx+79c3hCoq1s11d6qZKPNTfzVQ==
X-Received: by 2002:a05:600c:207:: with SMTP id
 7mr1147826wmi.146.1566407150091; 
 Wed, 21 Aug 2019 10:05:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id c8sm21411577wrn.50.2019.08.21.10.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 10:05:49 -0700 (PDT)
To: "Kinney, Michael D" <michael.d.kinney@intel.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>, "Yao, Jiewen"
 <jiewen.yao@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
 <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
 <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
 <20190816161933.7d30a881@x1.home>
 <74D8A39837DF1E4DA445A8C0B3885C503F761B96@shsmsx102.ccr.corp.intel.com>
 <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
 <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9C671@ORSMSX113.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a76014e2-2f0a-afce-6d15-1c45c5c1e467@redhat.com>
Date: Wed, 21 Aug 2019 19:05:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <E92EE9817A31E24EB0585FDF735412F5B9D9C671@ORSMSX113.amr.corp.intel.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [edk2-rfc] [edk2-devel] CPU hotplug using SMM with
 QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Laszlo Ersek <lersek@redhat.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/19 17:48, Kinney, Michael D wrote:
> Perhaps there is a way to avoid the 3000:8000 startup
> vector.
> 
> If a CPU is added after a cold reset, it is already in a
> different state because one of the active CPUs needs to
> release it by interacting with the hot plug controller.
> 
> Can the SMRR for CPUs in that state be pre-programmed to
> match the SMRR in the rest of the active CPUs?
> 
> For OVMF we expect all the active CPUs to use the same
> SMRR value, so a check can be made to verify that all 
> the active CPUs have the same SMRR value.  If they do,
> then any CPU released through the hot plug controller 
> can have its SMRR pre-programmed and the initial SMI
> will start within TSEG.
> 
> We just need to decide what to do in the unexpected 
> case where all the active CPUs do not have the same
> SMRR value.
> 
> This should also reduce the total number of steps.

The problem is not the SMRR but the SMBASE.  If the SMBASE area is
outside TSEG, it is vulnerable to DMA attacks independent of the SMRR.
SMBASE is also different for all CPUs, so it cannot be preprogrammed.

(As an aside, virt platforms are also immune to cache poisoning so they
don't have SMRR yet - we could use them for SMM_CODE_CHK_EN and block
execution outside SMRR but we never got round to it).

An even simpler alternative would be to make A0000h the initial SMBASE.
 However, I would like to understand what hardware platforms plan to do,
if anything.

Paolo

> Mike
> 
>> -----Original Message-----
>> From: rfc@edk2.groups.io [mailto:rfc@edk2.groups.io] On
>> Behalf Of Yao, Jiewen
>> Sent: Sunday, August 18, 2019 4:01 PM
>> To: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Alex Williamson <alex.williamson@redhat.com>; Laszlo
>> Ersek <lersek@redhat.com>; devel@edk2.groups.io; edk2-
>> rfc-groups-io <rfc@edk2.groups.io>; qemu devel list
>> <qemu-devel@nongnu.org>; Igor Mammedov
>> <imammedo@redhat.com>; Chen, Yingwen
>> <yingwen.chen@intel.com>; Nakajima, Jun
>> <jun.nakajima@intel.com>; Boris Ostrovsky
>> <boris.ostrovsky@oracle.com>; Joao Marcal Lemos Martins
>> <joao.m.martins@oracle.com>; Phillip Goerl
>> <phillip.goerl@oracle.com>
>> Subject: Re: [edk2-rfc] [edk2-devel] CPU hotplug using
>> SMM with QEMU+OVMF
>>
>> in real world, we deprecate AB-seg usage because they
>> are vulnerable to smm cache poison attack.
>> I assume cache poison is out of scope in the virtual
>> world, or there is a way to prevent ABseg cache poison.
>>
>> thank you!
>> Yao, Jiewen
>>
>>
>>> 在 2019年8月19日，上午3:50，Paolo Bonzini
>> <pbonzini@redhat.com> 写道：
>>>
>>>> On 17/08/19 02:20, Yao, Jiewen wrote:
>>>> [Jiewen] That is OK. Then we MUST add the third
>> adversary.
>>>> -- Adversary: Simple hardware attacker, who can use
>> device to perform DMA attack in the virtual world.
>>>> NOTE: The DMA attack in the real world is out of
>> scope. That is be handled by IOMMU in the real world,
>> such as VTd. -- Please do clarify if this is TRUE.
>>>>
>>>> In the real world:
>>>> #1: the SMM MUST be non-DMA capable region.
>>>> #2: the MMIO MUST be non-DMA capable region.
>>>> #3: the stolen memory MIGHT be DMA capable region or
>> non-DMA capable
>>>> region. It depends upon the silicon design.
>>>> #4: the normal OS accessible memory - including ACPI
>> reclaim, ACPI
>>>> NVS, and reserved memory not included by #3 - MUST be
>> DMA capable region.
>>>> As such, IOMMU protection is NOT required for #1 and
>> #2. IOMMU
>>>> protection MIGHT be required for #3 and MUST be
>> required for #4.
>>>> I assume the virtual environment is designed in the
>> same way. Please
>>>> correct me if I am wrong.
>>>>
>>>
>>> Correct.  The 0x30000...0x3ffff area is the only
>> problematic one;
>>> Igor's idea (or a variant, for example optionally
>> remapping
>>> 0xa0000..0xaffff SMRAM to 0x30000) is becoming more
>> and more attractive.
>>>
>>> Paolo
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Groups.io Links: You receive all messages sent to this
>> group.
>>
>> View/Reply Online (#47):
>> https://edk2.groups.io/g/rfc/message/47
>> Mute This Topic: https://groups.io/mt/32887711/1643496
>> Group Owner: rfc+owner@edk2.groups.io
>> Unsubscribe: https://edk2.groups.io/g/rfc/unsub
>> [michael.d.kinney@intel.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
> 


