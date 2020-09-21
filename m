Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC6C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA082076E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+SKoUdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA082076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBSK-0001XP-EF
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kKBR8-00010N-2J
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:20:14 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kKBR1-0008Sg-FE
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:20:13 -0400
Received: by mail-lf1-x144.google.com with SMTP id y11so12276872lfl.5
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 19:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nFHWnu2WjARwmj40k+Z6ibaGUXVISbKruYv+OzNU2U4=;
 b=f+SKoUdSMibTUImaiLU6VuKBUfjvtiQpEs2Se+lTiBPeIMSEWYkbKtH6EE4wdzuDHM
 GxqOdtRbSa2idg26af8Pdj5mj1/Ahf+OZeFJykANiYyTwbAuJheRWtMJgHgon9xNxie1
 ZfHbv3Jd4G7+EZAbZkG+JqJaD6yuW3hjsrVz2sup9HH3kGJ/T7DR63UwArM3JMFrTF+x
 Wn8vUl2tw9UdPTqlkvnVSAUN4VSsDkOeog2UEGSvIlRm/yuRuzfJCbOB8Wog7sA2Is8w
 16/wBUFJiIaUjYicsAWFkmSfEjuuFoYSFM4W8UL3eLpCfsFksTcW0GvX/4F1a8c6IhJk
 O0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nFHWnu2WjARwmj40k+Z6ibaGUXVISbKruYv+OzNU2U4=;
 b=JuMQOfsECeNMtOD5+sR2z188xa4eUDe8jSnHqB37CwbU6XVGsbiqc5ilnb2vyqTJFH
 uMxhN0ttSwp8sEHY3t+2zP+rvj8c2+QvuMrrgR/ym8zOW1DFXFhAdVZu/ymah4iU8uIF
 TGKaaeDZw9fnw3IyGe+FJV1iDjirg/vCU8790n3Ylxm1LlOGeAUkx3T35Vq3d6VwTGvV
 kjw7zDiJBx13kdbcuvu8gSP9r6kVmsjZ48L4WvMhekQzBEOc7TLSy9BWtBtV8NzBLb/z
 bL0WgVIx3g4uhkmkNmpqP/aXxjb+39+LXW824VXccbdTx/sI0h53/VV5hRxgPP+1RmYR
 +MSQ==
X-Gm-Message-State: AOAM532pxMwyjhYlyLwPQ5rJNNzH/juzT/ffOZMRV0u1OZMwakIllSbM
 IAQ4rv7oE9YTyG3WcPINMWnFJmB58arhvTPcvjE=
X-Google-Smtp-Source: ABdhPJy2YxRaaOrTfxCFG61yzle3GglLVCplJO6+wKSN/9WW5aBm2oWDpN3bhsSi1jRUNbcmc0grs1hG+jEDIH+Qtrc=
X-Received: by 2002:a19:6a08:: with SMTP id u8mr14384888lfu.51.1600654805574; 
 Sun, 20 Sep 2020 19:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <CAHiYmc6br+UYwxFa9sS8Xu=zubXVOJ5ms6+2NBk=0YOnmnjQ7A@mail.gmail.com>
In-Reply-To: <CAHiYmc6br+UYwxFa9sS8Xu=zubXVOJ5ms6+2NBk=0YOnmnjQ7A@mail.gmail.com>
From: chen huacai <zltjiangshi@gmail.com>
Date: Mon, 21 Sep 2020 10:19:53 +0800
Message-ID: <CABDp7VrhKWLCaGhUYmtqO8BNiBAEUHnznQubW-H36q_OooYQ0g@mail.gmail.com>
Subject: Re: [PATCH V9 0/6] mips: Add Loongson-3 machine support
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Aleksandar,

On Thu, Sep 17, 2020 at 4:22 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
>
>
> On Wednesday, September 16, 2020, Huacai Chen <zltjiangshi@gmail.com> wrote:
>>
>> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
>> R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
>> Loongson-3A R4 is the newest and its ISA is almost the superset of all
>> others. To reduce complexity, in QEMU we just define two CPU types:
>>
>> 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
>>    suitable for TCG because Loongson-3A R1 has fewest ASE.
>> 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
>>    suitable for KVM because Loongson-3A R4 has the VZ ASE.
>>
>> Loongson-3 lacks English documents. I've tried to translated them with
>> translate.google.com, and the machine translated documents (together
>> with their original Chinese versions) are available here.
>>
>> Loongson-3A R1 (Loongson-3A1000)
>> User Manual Part 1:
>> http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf
>> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P1.pdf (Chinese Version)
>> User Manual Part 2:
>> http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf
>> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P2.pdf (Chinese Version)
>>
>> Loongson-3A R2 (Loongson-3A2000)
>> User Manual Part 1:
>> http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf
>> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf (Chinese Version)
>> User Manual Part 2:
>> http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf
>> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf (Chinese Version)
>>
>> Loongson-3A R3 (Loongson-3A3000)
>> User Manual Part 1:
>> http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf
>> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.pdf (Chinese Version)
>> User Manual Part 2:
>> http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf
>> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.pdf (Chinese Version)
>>
>> Loongson-3A R4 (Loongson-3A4000)
>> User Manual Part 1:
>> http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf
>> http://ftp.godson.ac.cn/lemote/3A4000user.pdf (Chinese Version)
>> User Manual Part 2:
>> I'm sorry that it is unavailable now.
>>
>> And human-translated documents (W.I.P) are available here now:
>> https://github.com/loongson-community/docs/tree/master/English-translation-of-Loongson-manual
>>
>> Both KVM and TCG are available now!
>>
>> We now already have a full functional Linux kernel (based on Linux-5.4.x
>> LTS, the kvm host side and guest side have both been upstream for Linux-
>> 5.9, but Linux-5.9 has not been released yet) here:
>>
>> https://github.com/chenhuacai/linux
>>
>> Of course the upstream kernel is also usable (though it is "unstable"
>> now):
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>
>> How to use QEMU/Loongson-3?
>> 1, Download kernel source from the above URL;
>> 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
>> 3, Boot a Loongson-3A4000 host with this kernel (for KVM mode);
>> 4, Build QEMU-master with this patchset;
>> 5, modprobe kvm (only necessary for KVM mode);
>> 6, Use QEMU with TCG:
>>        qemu-system-mips64el -M loongson3-virt,accel=tcg -cpu Loongson-3A1000 -kernel <path_to_kernel> -append ...
>>    Use QEMU with KVM:
>>        qemu-system-mips64el -M loongson3-virt,accel=kvm -cpu Loongson-3A4000 -kernel <path_to_kernel> -append ...
>>
>>    The "-cpu" parameter is optional here and QEMU will use the correct type for TCG/KVM automatically.
>>
>> V1 -> V2:
>> 1, Add a cover letter;
>> 2, Improve CPU definitions;
>> 3, Remove LS7A-related things (Use GPEX instead);
>> 4, Add a description of how to run QEMU/Loongson-3.
>>
>> V2 -> V3:
>> 1, Fix all possible checkpatch.pl errors and warnings.
>>
>> V3 -> V4:
>> 1, Sync code with upstream;
>> 2, Remove merged patches;
>> 3, Fix build failure without CONFIG_KVM;
>> 4, Add Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>.
>>
>> V4 -> V5:
>> 1, Improve coding style;
>> 2, Remove merged patches;
>> 3, Rename machine name from "loongson3" to "loongson3-virt";
>> 4, Rework the "loongson3-virt" machine to drop any ISA things;
>> 5, Rework "hw/mips: Implement the kvm_type() hook in MachineClass";
>> 6, Add Jiaxun Yang as a reviewer of Loongson-3.
>>
>> V5 -> V6:
>> 1, Fix license preamble;
>> 2, Improve commit messages;
>> 3, Add hw/intc/loongson_liointc.c to MAINTAINERS;
>> 4, Fix all possible checkpatch.pl errors and warnings.
>>
>> V7 and V8 have only one patch (machine definition) with some minor improvements.
>>
>> V8 -> V9:
>> 1, Update KVM type definition from kernel;
>> 2, Fix PageMask with variable page size for TCG;
>> 3, Add TCG support (add Loongson-EXT instructions).
>>
>> Huacai Chen and Jiaxun Yang (6):
>>  linux-headers: Update MIPS KVM type defintition
>>  target/mips: Fix PageMask with variable page size
>>  target/mips: Add loongson-ext lswc2 group of instructions (Part 1)
>>  target/mips: Add loongson-ext lswc2 group of instructions (Part 2)
>>  target/mips: Add loongson-ext lsdc2 group of instructions
>>  hw/mips: Add Loongson-3 machine support
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  default-configs/mips64el-softmmu.mak |   1 +
>>  hw/mips/Kconfig                      |  11 +
>>  hw/mips/fw_cfg.c                     |  35 ++
>>  hw/mips/fw_cfg.h                     |  19 +
>>  hw/mips/loongson3_virt.c             | 956 +++++++++++++++++++++++++++++++++++
>>  hw/mips/meson.build                  |   3 +-
>>  linux-headers/linux/kvm.h            |   5 +-
>>  target/mips/cp0_helper.c             |  36 +-
>>  target/mips/cpu.h                    |   1 +
>>  target/mips/translate.c              | 437 ++++++++++++++++
>>  10 files changed, 1494 insertions(+), 10 deletions(-)
>>  create mode 100644 hw/mips/fw_cfg.c
>>  create mode 100644 hw/mips/fw_cfg.h
>>  create mode 100644 hw/mips/loongson3_virt.c
>> --
>
>
> There should be a suitable note in QEMU documentation describing new functionality.
OK, I will update documentations in V10.

Huacai
>
> Thanks,
> Aleksandar
>
>
>>
>> 2.7.0



-- 
Huacai Chen

