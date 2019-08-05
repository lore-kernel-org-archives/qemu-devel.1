Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1189DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEDC12086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZF29VBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDC12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hudu8-0006vI-6D
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 10:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36799)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hudtc-0006Qp-9E
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hudtb-0005Ra-0O
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:23:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hudta-0005Ox-O2
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:23:30 -0400
Received: by mail-wm1-x342.google.com with SMTP id u25so62855993wmc.4
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=couvBRMghYUj9Iey4nHeYY7nI5O5CC4Ov5cBjX+9IgM=;
 b=XZF29VBjr1U2UzCevW2mEpo0KeSgiyNeLi+wPwfYSr4cRjRMsXDgWCyL76OAVyMpZ5
 2IUnmw47qeZronUxCw7g7nh8EZBXnmVEmaZQKKBtV6AdAYb5c8YMqYfqFJn6TBr89uZw
 x2FViapjTmYfH2x9rVF2PVifCYvrsOPxerJ0PdiXHkmXL+OHZrptbeucrRw/KFDGdQPv
 YdSxY/ywEQUJdZQ0TUh+MEbIR2IgclYMy5uBdP12VKyCdCKeAZMfWnQEPJ4YBx1Dz9cr
 FGIhro9iOQDxmJMyD3v28U0BLkdgkjLTyH+IQpdvV9AxHr/fZnRgIhW9QG7iOIV52EsF
 8sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=couvBRMghYUj9Iey4nHeYY7nI5O5CC4Ov5cBjX+9IgM=;
 b=TtjM3j3JliFQ3qAWav4Vl+ZBtPG+x1FTYLEEI58ixeUo4kiEanZ9BfinYGTVYxgAVG
 kAdabCkftPtD0u9k9eBRifqVLMEcfUb1nwCvMNc2iVYrInm0MPjoBndlAWXTCI4Uc8Y5
 ghJPFAJaGNSG8//x6eBM10Jf2Nxy2KKyBFAOKY27yKeIBEKesTKxHgFbPfx8XxYEAC+M
 py7Kt9PcRCzWU0YjteWaPIS/F3MEbyeA7EW+995ey92U46H8n36ywSgdPIFwuJOMVDsh
 aVhp8ME0aKNXJj1joA3o8LXWRtkdUH3aDMxQ3k5F0Nmtm75QJwCj3rQwS/5OkwM0/hrM
 p0yA==
X-Gm-Message-State: APjAAAVazhqIicnhqd4n/Ftq5X9OWNc1t1hUSxr/VIDjnvT7PDp45Hbv
 lO4Xm2Dm7cuqxZr4/kqPqg9MuQ==
X-Google-Smtp-Source: APXvYqz9EqiJOsBOlo/8xvHwS1iIZ9rbtfWd9EXmr5N3Y0JQYznOTzxVcauq5navmOiXQcmmNVBZiA==
X-Received: by 2002:a05:600c:2388:: with SMTP id
 m8mr18295470wma.23.1565015008589; 
 Mon, 05 Aug 2019 07:23:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h133sm91066214wme.28.2019.08.05.07.23.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 05 Aug 2019 07:23:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 93C811FF87;
 Mon,  5 Aug 2019 15:23:27 +0100 (BST)
References: <20190803184800.8221-1-richard.henderson@linaro.org>
 <8736ifkbod.fsf@linaro.org>
 <db7e63d9-fcf6-fda2-c164-af8f90815617@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <db7e63d9-fcf6-fda2-c164-af8f90815617@linaro.org>
Date: Mon, 05 Aug 2019 15:23:27 +0100
Message-ID: <87zhknitcw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 00/34] target/arm: Implement ARMv8.1-VHE
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/5/19 6:02 AM, Alex Benn=C3=A9e wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> About half of this patch set is cleanup of the qemu tlb handling
>>> leading up to the actual implementation of VHE, and the biggest
>>> piece of that: The EL2&0 translation regime.
>>>
>>> Changes since v2:
>>>   * arm_mmu_idx was incomplete; test TGE+E2H not just E2H.
>>>   * arm_sctlr was incomplete; now uses arm_mmu_idx to avoid
>>>     duplication of tests.
>>>   * Update aa64_zva_access and ctr_el0_access for EL2.
>>>
>>> Changes since v1:
>>>   * Merge feedback from AJB.
>>>   * Split out 7 renaming patches from "Reorganize ARMMMUIdx".
>>>   * Alex's MIDR patch keeps the nested KVM from spitting warnings.
>>>
>>> I have tested
>>>
>>>   qemu-system-aarch64 -accel kvm -cpu host -M virt,gic-version-host \
>>>     -m 512 -bios /usr/share/edk2/aarch64/QEMU_EFI.fd -nographic
>>
>> So testing with a host doing:
>>
>>   ./aarch64-softmmu/qemu-system-aarch64 -machine type=3Dvirt,virtualizat=
ion=3Don -cpu cortex-a57 -serial mon:stdio -nic user,model=3Dvirtio-net-pci=
,hostfwd=3Dtcp::2222-:22 -device virtio-scsi-pci -drive file=3D/dev/zvol/ha=
ckpool-0/debian-buster-arm64,id=3Dhd0,index=3D0,if=3Dnone,format=3Draw,disc=
ard=3Don -device scsi-hd,drive=3Dhd0 -kernel ../linux.git/builds/arm64/arch=
/arm64/boot/Image -append "console=3DttyAMA0 root=3D/dev/sda2" -display non=
e -m 4096 -smp 8
>>
>> And a guest doing:
>>
>>   ./aarch64-softmmu/qemu-system-aarch64 -machine type=3Dvirt -cpu host
>>   -serial mon:stdio -nic user,model=3Dvirtio-net-pci -device
>>   virtio-scsi-pci -kernel /boot/vmlinuz-4.19.0-5-arm64 -append "console=
=3DttyAMA0 panic=3D-1" -display none -m 256 -smp 4 --no-reboot
>>   --enable-kvm
>>
>> I triggered:
>>
>>   ERROR:/home/alex.bennee/lsrc/qemu.git/target/arm/helper.c:3436:update_=
lpae_el1_asid: code should not be reached
>> fish: =E2=80=9C./aarch64-softmmu/qemu-system-a=E2=80=A6=E2=80=9D termina=
ted by signal SIGABRT (Abort)
>
> Whoops.  Rebase error while changing the signature of this function.
> Thanks for re-testing the case where VHE isn't present.  :-P
>
>> With -cpu max on the host it hangs the whole thing. I'm going to
>> continue to experiment with explicit GIC versions.
>
> Hangs the host?  Are you sure that the guest isn't just slow?

Ahh nested terminology - the aarch64 VHE host hangs so I can't access
it's shells either. I'll try and get a better trace once I've gotten a
reliable non-VHE guest-guest boot ;-)

> That's why I changed my testing to boot a debug edk2, which
> outputs stuff much sooner than the kernel does.

Looking via gdbstub it looked like stuff had stopped happening but you
are right it could be just slow. None of the threads seem to be doing
anything.

> Although I have no idea why the guest should be extra slow.
> It does seem like it ought to be booting at the same speed as
> the host.  I see tlb flushes as quite high in the profile,
> and wonder if I'm doing too many of them.

Hmm yeah they do seem a bit high:

TLB full flushes    8
TLB partial flushes 39036316
TLB elided flushes  256488402

... 10 seconds ...

TLB full flushes    8
TLB partial flushes 40393340
TLB elided flushes  265444803

For non-VHE that seems expected because we should be changing the entire
mapping regime as we bounce between the EL1's - shouldn't be as high for
VHE right?


>
>
> r~


--
Alex Benn=C3=A9e

