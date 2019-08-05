Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19064C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 05:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD33920657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 05:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kej8D3ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD33920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huVys-0005XK-68
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 01:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54194)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1huVxl-0004CZ-Ko
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1huVxh-0000tO-VM
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:55:17 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:40807)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>)
 id 1huVxh-0000q7-Ew; Mon, 05 Aug 2019 01:55:13 -0400
Received: by mail-ot1-x330.google.com with SMTP id l15so26862823oth.7;
 Sun, 04 Aug 2019 22:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9hyi04J0H3wT5hTaXQ1DhUxm+HPNipAaYz5/GyRwLMg=;
 b=kej8D3akmIz7Log440nkQeFKb330sPr8VT82mBZgr8tD4HR8tFVJhqq/RGDL6VkU6o
 wDW/Iwk/qRprOnVWZR+q841iAT7u6PRDqW9a0sQnkMhZFxXuUaNfwQWvmr9mIiQVPY65
 k9EaiNxm8HE8uTRunABxL1r7xMXVLnICYq/hKtGu8Q/04nCxBfyzXZkhLOqpEMnHplAP
 nEbxzsAR9KWKJI7SF01gwUKTF4O+2Hr4aJDrK4mCtGvvDCfjtXtKTDP9bVfXPQfPe3sF
 JU1iVEdOOWgRacO0b5dWYr3HpzHch1pOEExxXm1Ogc256K0sKqu2/16Pad8KxgnbgMOr
 V27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9hyi04J0H3wT5hTaXQ1DhUxm+HPNipAaYz5/GyRwLMg=;
 b=hgPpNCcYt0u16HWUAtOjzu+o2/X03iAMb/Ot6M+TVtZ3cfwvQnxTcd75RZPxIalf+U
 Adi+iXZZj7oybNX7Dq3FgSL4BormWcHzCecR1wOKb/Otq8hmanl/y9bHPuIS+iqNKaXz
 F0J3z1u98A9tFZnXX/5dGFKJHwu8BNK69lL++ngDg+6DdFdu4zJHDtspO8q4ZJaioTbs
 U5qbRaEktN/x4uB3IJiWSizjeWChd/MH94ko54wl6N4TiO43YYG9gmBLt6bDQAF3AHlh
 SN7wl2Ml3ult/nVzgi1euhzbJIiFwINihyr8fffTOAGahTRwvIluqhpmbnZxOMhDDLXZ
 TpqQ==
X-Gm-Message-State: APjAAAVsjB6TZTwGwcvZ7lCvI3O9mgBIiqqp8FrbfOyH0IP2HGJW4vFh
 Nt9Ay3TTI0e8xGLvKyf3hcJ5RmZyzyHS7Wl3188=
X-Google-Smtp-Source: APXvYqw/YNyXfjmzunOJ2rfP4diN2mWlj+Jj564CFqj8R/pABwC0JntvIqQXBkaa6yUbdnjdjZx4jywqc9Hkv5EAOtA=
X-Received: by 2002:a05:6830:1291:: with SMTP id
 z17mr48610638otp.194.1564984512406; 
 Sun, 04 Aug 2019 22:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <7f455f0d.730d.16c5fdc21af.Coremail.hope2hope@163.com>
 <CAKXe6SKMS__GaxTL4rkTBFpCpRkRS_bHoJx8=6w6WktFr5K9XQ@mail.gmail.com>
 <70dbf96f.87bc.16c60385de4.Coremail.hope2hope@163.com>
In-Reply-To: <70dbf96f.87bc.16c60385de4.Coremail.hope2hope@163.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 5 Aug 2019 13:54:36 +0800
Message-ID: <CAKXe6S+Eu29SrVrGcCO-wrtQqmMa6Q-MXnsFV03ddx1LrXBYKA@mail.gmail.com>
To: ddm <hope2hope@163.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] How to configure QEMU to support APIC
 virtualization
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ddm <hope2hope@163.com> =E4=BA=8E2019=E5=B9=B48=E6=9C=885=E6=97=A5=E5=91=A8=
=E4=B8=80 =E4=B8=8B=E5=8D=881:20=E5=86=99=E9=81=93=EF=BC=9A

> Hi,
>
> As i know, KVM is based on passthrough host cpu to implement
> full-virtualiztion,
> if host cpu doesn't support this feature, it's impossible to turn on this
> feature by KVM.
> Wheher there are another ways in QEMU to emulate this feature=EF=BC=8Csuc=
h as
> emulate it based on pure software, not rely on hardware.
>
>
IIUC there is no APICv emulate.


Thanks,
Li Qiang



> Thanks!
>
>
> At 2019-08-05 12:42:55, "Li Qiang" <liq3ea@gmail.com> wrote:
>
>
>
> ddm <hope2hope@163.com> =E4=BA=8E2019=E5=B9=B48=E6=9C=885=E6=97=A5=E5=91=
=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:55=E5=86=99=E9=81=93=EF=BC=9A
>
>> Hi guys,
>>
>>
>> I have tried via modprobe kvmintel enable_apicv=3DY  to adjust KVM
>> parameter, but it doesn't effect,  and
>> cat /sys/module/kvm_intel/parameters/enable_apicv always return "N".
>> I don't know how to configure KVM or QEMU to support APIC virtualizaion
>> feature?
>>
>>
> AFAICT APICv is hardware feature, but I still don't know accurately after
> which CPU support it.
> You may refer the code about 'enable_apicv' related code in kvm to see ho=
w
> to detect this capability.
>
> Thanks,
> Li Qiang
>
>
>>
>> My host infos are as follows:
>> Architecture:          x86_64
>> CPU op-mode(s):        32-bit, 64-bit
>> Byte Order:            Little Endian
>> CPU(s):                1
>> On-line CPU(s) list:   0
>> Thread(s) per core:    1
>> Core(s) per socket:    1
>> Socket(s):             1
>> NUMA node(s):          1
>> Vendor ID:             GenuineIntel
>> CPU family:            6
>> Model:                 142
>> Model name:            Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
>> Stepping:              10
>> CPU MHz:               2112.001
>> BogoMIPS:              4224.00
>> Virtualization:        VT-x
>> Hypervisor vendor:     VMware
>> Virtualization type:   full
>> L1d cache:             32K
>> L1i cache:             32K
>> L2 cache:              256K
>> L3 cache:              8192K
>> NUMA node0 CPU(s):     0
>> Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
>> pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb
>> rdtscp lm constant_tsc arch_perfmon nopl xtopology tsc_reliable nonstop_=
tsc
>> cpuid pni pclmulqdq vmx ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe
>> popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm a=
bm
>> 3dnowprefetch cpuid_fault invpcid_single pti ssbd ibrs ibpb stibp
>> tpr_shadow vnmi ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2
>> invpcid rtm rdseed adx smap xsaveopt arat flush_l1d arch_capabilities
>>
>>
>> Could you tell me how to configure it?
>>
>>
>> Thanks!
>>
>>
>
>
>
