Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BDBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2FC20792
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ov6OfhM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2FC20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyaEz-0004je-9Y
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jyaEK-0004JC-3a
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:21:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jyaEH-0002Xr-EF
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595506899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDbmFZucWJjyl+r8jzyLknV7m6a7Hx5im1a8WLVx1BE=;
 b=Ov6OfhM8PNdBCAqUCPlVdvvglTvIcqCJ7UUo6GYwelLWkMyyKl1V3grfDhbXDpagRE2Cqb
 ZQ144FycW/EL812ocJV+5H2klnAx9f+ZvpHJ9CvFMdgXkjfh1UFtnggg80O7qq0mulSn2X
 Qacll1LRZeaVByxHKkMif7cDaHqrOKQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-TvemSHQxNxezFOakTFXB4w-1; Thu, 23 Jul 2020 08:21:37 -0400
X-MC-Unique: TvemSHQxNxezFOakTFXB4w-1
Received: by mail-ej1-f71.google.com with SMTP id du17so2358330ejc.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 05:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RDbmFZucWJjyl+r8jzyLknV7m6a7Hx5im1a8WLVx1BE=;
 b=NtaEaC1E9hkGFW+rHAVLCAhvyTs2fJyO3cfDi5TX3lDHFGU5K+BVXNY6PS9bTtTmRb
 JxKhsAUvEFcX6rt9O069MwNuDCoZnSZ1EGkzub1rFeVGOrqU+bfXTh5iPFW1J6UGJvhV
 u5z0cpriBNzXlcDdB1BKN85BJKCPLUhMsW4yQo9Kai59eBAEokDz5VFCMo3QsuKVYAdo
 QOXjc3nUdb8hndB6GaXKPZJFNCgRrhtku2NjJFE3jXnhdptQQ8uii2JHhdLxA8WU5x+w
 J2tAGOgR+F1Ovzv1jvGXv2TpQbJ5FWmiTb2hTC7kHL1Aps5G5v7Kz/KjUhvYx9t77WCw
 lMhA==
X-Gm-Message-State: AOAM530xFMkDqO30+EwUFwrigDq+o50ya9HEfADcDKqZxWXYyWsl/rIV
 tAwh7p4HbddxWuVayh7kSzbWWm6xwuk7pFTqsETZ8PLgk7VYWcbl+uV9C5zwMcdkdYxlRDcQh1R
 D4ZIqgQ+LDbQOyDY=
X-Received: by 2002:a05:6402:1ac4:: with SMTP id
 ba4mr3793703edb.60.1595506895674; 
 Thu, 23 Jul 2020 05:21:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdKG8ryIxX7oM1gSeuke/xIMd7yIh1tsm1HFyBwfiVWGXsM6yWhUUG5AlnFmhZD9FeZLp1BA==
X-Received: by 2002:a05:6402:1ac4:: with SMTP id
 ba4mr3793673edb.60.1595506895288; 
 Thu, 23 Jul 2020 05:21:35 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id t20sm1914040ejd.124.2020.07.23.05.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 05:21:34 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: 5.1.0-rc1 regression: reset fails with kvm and -cpu host
In-Reply-To: <3eba2f87-5527-bd7c-2eb7-ce67cb32d9ef@redhat.com>
References: <bf007af9-f81e-3542-0237-5ea467f34377@siemens.com>
 <20200722173513.GO1274972@habkost.net>
 <7be95bd6-dfc6-2c22-85a1-a1c932d07fdd@siemens.com>
 <20200722204731.GP1274972@habkost.net> <20200722212159.GQ1274972@habkost.net>
 <20200723084026.GB2622@work-vm>
 <3eba2f87-5527-bd7c-2eb7-ce67cb32d9ef@redhat.com>
Date: Thu, 23 Jul 2020 14:21:33 +0200
Message-ID: <87pn8mo20i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daudé <philmd@redhat.com> writes:

> +Vitaly
>
> On 7/23/20 10:40 AM, Dr. David Alan Gilbert wrote:
>> * Eduardo Habkost (ehabkost@redhat.com) wrote:
>>> On Wed, Jul 22, 2020 at 04:47:32PM -0400, Eduardo Habkost wrote:
>>>> On Wed, Jul 22, 2020 at 08:05:01PM +0200, Jan Kiszka wrote:
>>>>> On 22.07.20 19:35, Eduardo Habkost wrote:
>>>>>> Hi Jan,
>>>>>>
>>>>>> What was the last version where it worked for you?  Does using
>>>>>> "-cpu host,-vmx" help?
>>>>>
>>>>> Yeah, -vmx does indeed help.
>>>>>
>>>>> I didn't have the time to bisect yet. Just check my reflog, picked
>>>>> eb6490f544, and that works.
>>>>
>>>> Thanks!
>>>>
>>>> I could reproduce it locally[1], I will bisect it.
>>>>
>>>> The good news is that "-cpu host,+vmx" still works, on commit
>>>> eb6490f544.
>>>>
>>>> [1] Linux 5.6.19-300.fc32.x86_64, Intel Core i7-8665U CPU.
>>>
>>> Bisected to:
>>>
>>> commit b16c0e20c74218f2d69710cedad11da7dd4d2190
>>> Author: Paolo Bonzini <pbonzini@redhat.com>
>>> Date:   Wed May 20 10:49:22 2020 -0400
>>>
>>>     KVM: add support for AMD nested live migration
>>>
>>>     Support for nested guest live migration is part of Linux 5.8, add the
>>>     corresponding code to QEMU.  The migration format consists of a few
>>>     flags, is an opaque 4k blob.
>>>
>>>     The blob is in VMCB format (the control area represents the L1 VMCB
>>>     control fields, the save area represents the pre-vmentry state; KVM does
>>>     not use the host save area since the AMD manual allows that) but QEMU
>>>     does not really care about that.  However, the flags need to be
>>>     copied to hflags/hflags2 and back.
>>>
>>>     In addition, support for retrieving and setting the AMD nested virtualization
>>>     states allows the L1 guest to be reset while running a nested guest, but
>>>     a small bug in CPU reset needs to be fixed for that to work.
>>>
>>>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> 
>> Guesswork led me to try reverting the chunk in kvm_put_nested_state;
>> without it the reset seems to work; I can't explain that code though.
>> 

(sorry, missed the beginning of the discussion)

So one does:

(qemu) system_reset 

on Intel wiht '-cpu host' and the result is:

(qemu) KVM: entry failed, hardware error 0x80000021

If you're running a guest on an Intel machine without unrestricted mode
support, the failure can be most likely due to the guest entering an invalid
state for Intel VT. For example, the guest maybe running in big real mode
which is not supported on less recent Intel processors.

EAX=00000064 EBX=91df5efe ECX=00000000 EDX=000003f8
ESI=00000000 EDI=91ee32c0 EBP=90643260 ESP=00013c68
EIP=906428e6 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 00000000 0000ffff 00009300
CS =f000 ffff0000 0000ffff 00009b00
SS =0000 00000000 0000ffff 00009300
DS =0000 00000000 0000ffff 00009300
FS =0000 00000000 0000ffff 00009300
GS =0000 00000000 0000ffff 00009300
LDT=0000 00000000 0000ffff 00008200
TR =0000 00000000 0000ffff 00008b00
GDT=     00000000 0000ffff
IDT=     00000000 0000ffff
CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000000
Code=?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? <??> ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ??

I can take a look (if no one beats me to it).

-- 
Vitaly


