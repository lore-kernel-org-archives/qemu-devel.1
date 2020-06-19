Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BF1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D3B2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5QFG12d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D3B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmEIc-0002ar-3M
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmEHi-0001Gl-90
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:30:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27980
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmEHf-0007kl-Mp
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592562606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HH446XeamB4PUhJUowgPRsGYfN/c1SM+wcKY7W6LDy8=;
 b=W5QFG12dbqQ3yGzJV9+MVj0p+SPUKiVSeSg4heuyhpgO2/Ra4KmNxYr29oICnPpzs2ERPj
 Bsfb73uY9zK7R5KX04Nk9sw8zJLUrKF/44KTdD0fpReS9zEnkGG+UUiApdMPXqavttXm2X
 1GXLzeksc714UFTc+0s78l/F6G1xmjU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-0e0O9mbCP5q8_bQ1qTZClA-1; Fri, 19 Jun 2020 06:30:03 -0400
X-MC-Unique: 0e0O9mbCP5q8_bQ1qTZClA-1
Received: by mail-wr1-f71.google.com with SMTP id j5so1688076wro.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 03:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=HH446XeamB4PUhJUowgPRsGYfN/c1SM+wcKY7W6LDy8=;
 b=OZvHzfvDGf9rIaMlVXyEorxJP8b8oe0LJp3wJ3Lxihn6hh/IgP3K3XhsUs2BGZWgCQ
 bUy+W/FUV5Q1Lx/KR2WNBWOH6Ku2bH6DaD+EbaOJkrcZxuhgmQCJXXdVhaEryCG2eZaK
 lLKD9AtvedZFidIm0Dn0eg5A6/VPJrDP8tdLxnU7MikCc8f+qeISQTU4+fy60mzFWBhL
 Q9uOsHJWxfQXv3cKF/LrnE8GgK2BL0IrsAFeZqLK1rHarrnGPcLbevnrIleThaLLyaxW
 0Q/LG0pfSGIev48MF0AIXUtydXAMn81rhQvHlBLjoGf45W/5p4DHG9PiJ0lhO82vTAVW
 242w==
X-Gm-Message-State: AOAM531X9zJy70A9mWfEZKDW7/J9xXh5fM/Y8prDnppF1qXo7W0JZemc
 MLbSwuGG9gn9W0MKvlkwNiZVrLV0d0ZGkgxv/kOvCAKpidbSRLs9Y2cVQMEdXRIAnGHRPLMrrlC
 htSyBuIhfkFC0618=
X-Received: by 2002:a1c:8048:: with SMTP id b69mr2930406wmd.169.1592562601778; 
 Fri, 19 Jun 2020 03:30:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPMGL60shq/f/VrwILxMoc8guaEyX3BaOuwkKHp2aHrnl7KsOnCE0VdFkdBUPGOiTE9yk70w==
X-Received: by 2002:a1c:8048:: with SMTP id b69mr2930372wmd.169.1592562601507; 
 Fri, 19 Jun 2020 03:30:01 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j41sm7161703wre.12.2020.06.19.03.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 03:30:00 -0700 (PDT)
Subject: Re: [PATCH v2] target/arm: Check supported KVM features globally (not
 per vCPU)
To: Andrew Jones <drjones@redhat.com>
References: <20200619095542.2095-1-philmd@redhat.com>
 <20200619102300.2mzawwpj4gkglco3@kamzik.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <39803018-7406-9ca8-d9e8-ca8219fdd11c@redhat.com>
Date: Fri, 19 Jun 2020 12:29:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200619102300.2mzawwpj4gkglco3@kamzik.brq.redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-arm@nongnu.org, Haibo Xu <haibo.xu@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 12:23 PM, Andrew Jones wrote:
> On Fri, Jun 19, 2020 at 11:55:42AM +0200, Philippe Mathieu-DaudÃ© wrote:
>> Since commit d70c996df23f, when enabling the PMU we get:
>>
>>   $ qemu-system-aarch64 -cpu host,pmu=on -M virt,accel=kvm,gic-version=3
>>   Segmentation fault (core dumped)
>>
>>   Thread 1 "qemu-system-aar" received signal SIGSEGV, Segmentation fault.
>>   0x0000aaaaaae356d0 in kvm_ioctl (s=0x0, type=44547) at accel/kvm/kvm-all.c:2588
>>   2588        ret = ioctl(s->fd, type, arg);
>>   (gdb) bt
>>   #0  0x0000aaaaaae356d0 in kvm_ioctl (s=0x0, type=44547) at accel/kvm/kvm-all.c:2588
>>   #1  0x0000aaaaaae31568 in kvm_check_extension (s=0x0, extension=126) at accel/kvm/kvm-all.c:916
>>   #2  0x0000aaaaaafce254 in kvm_arm_pmu_supported (cpu=0xaaaaac214ab0) at target/arm/kvm.c:213
>>   #3  0x0000aaaaaafc0f94 in arm_set_pmu (obj=0xaaaaac214ab0, value=true, errp=0xffffffffe438) at target/arm/cpu.c:1111
>>   #4  0x0000aaaaab5533ac in property_set_bool (obj=0xaaaaac214ab0, v=0xaaaaac223a80, name=0xaaaaac11a970 "pmu", opaque=0xaaaaac222730, errp=0xffffffffe438) at qom/object.c:2170
>>   #5  0x0000aaaaab5512f0 in object_property_set (obj=0xaaaaac214ab0, v=0xaaaaac223a80, name=0xaaaaac11a970 "pmu", errp=0xffffffffe438) at qom/object.c:1328
>>   #6  0x0000aaaaab551e10 in object_property_parse (obj=0xaaaaac214ab0, string=0xaaaaac11b4c0 "on", name=0xaaaaac11a970 "pmu", errp=0xffffffffe438) at qom/object.c:1561
>>   #7  0x0000aaaaab54ee8c in object_apply_global_props (obj=0xaaaaac214ab0, props=0xaaaaac018e20, errp=0xaaaaabd6fd88 <error_fatal>) at qom/object.c:407
>>   #8  0x0000aaaaab1dd5a4 in qdev_prop_set_globals (dev=0xaaaaac214ab0) at hw/core/qdev-properties.c:1218
>>   #9  0x0000aaaaab1d9fac in device_post_init (obj=0xaaaaac214ab0) at hw/core/qdev.c:1050
>>   ...
>>   #15 0x0000aaaaab54f310 in object_initialize_with_type (obj=0xaaaaac214ab0, size=52208, type=0xaaaaabe237f0) at qom/object.c:512
>>   #16 0x0000aaaaab54fa24 in object_new_with_type (type=0xaaaaabe237f0) at qom/object.c:687
>>   #17 0x0000aaaaab54fa80 in object_new (typename=0xaaaaabe23970 "host-arm-cpu") at qom/object.c:702
>>   #18 0x0000aaaaaaf04a74 in machvirt_init (machine=0xaaaaac0a8550) at hw/arm/virt.c:1770
>>   #19 0x0000aaaaab1e8720 in machine_run_board_init (machine=0xaaaaac0a8550) at hw/core/machine.c:1138
>>   #20 0x0000aaaaaaf95394 in qemu_init (argc=5, argv=0xffffffffea58, envp=0xffffffffea88) at softmmu/vl.c:4348
>>   #21 0x0000aaaaaada3f74 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at softmmu/main.c:48
>>
>> This is because in frame #2, cpu->kvm_state is still NULL
>> (the vCPU is not yet realized).
>>
>> KVM has a hard requirement of all cores supporting the same
>> feature set. We only need to check if the accelerator supports
>> a feature, not each vCPU individually.
>>
>> Fix by kvm_arm_<FEATURE>_supported() functions take a AccelState
>> argument (already realized/valid at this point) instead of a
>> CPUState argument.
> 
> This is no longer what's being done.

:S

> 
>>
>> Reported-by: Haibo Xu <haibo.xu@linaro.org>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> 
> Fixes: d70c996df23f ("target/arm/kvm: Use CPUState::kvm_state in
> kvm_arm_pmu_supported()")
> Analyzed-by: Andrew Jones <drjones@redhat.com>

Not sure this tag passes checkpatch.pl, else I'll replace by
a 'Reported-by'.

> 
>> ---
>> v2: Use global kvm_state (bonzini)
>>
>> Paolo, does this break migration of encrypted memory assumptions?
>>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Supersedes: <20200617130800.26355-1-philmd@redhat.com>
>> ---
>>  target/arm/kvm_arm.h | 21 +++++++++------------
>>  target/arm/cpu.c     |  2 +-
>>  target/arm/cpu64.c   | 10 +++++-----
>>  target/arm/kvm.c     |  4 ++--
>>  target/arm/kvm64.c   | 14 +++++---------
>>  5 files changed, 22 insertions(+), 29 deletions(-)
> 
> With the above
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks, I'll wait Paolo/Dave review before respinning.

Regards,

Phil.


