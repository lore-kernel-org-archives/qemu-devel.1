Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A024C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8391B206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdLnGL1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8391B206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIp6b-00056Y-H4
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIozW-0004wz-W3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:10:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIozT-0007e6-Pi
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:10:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id l9so1060171wme.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NpXTMk5G/mYrlxq57uvRkdpsAdB0r/hroZIIr1th2o4=;
 b=DdLnGL1pMA0sfzvsyQViHI008NtpCHtAAOi/D6sGtKx9vvr7lzG2yrJgUfnQcGDuxG
 d95kZ1i9r6PlNV4BfdtUvKIH5fgpVEKGCN7sWxkZkis3AOGPG9mOP4zxaLdrHxmqfmV6
 q8DGbNScnyUxFNOwcP3wknYjM/SRR17SDujRRyjtg0ZJ1Mb9CJm6/qS3FU7pIBKHyUNs
 NndE6qClLY/5PtzT3sTHrd3Dtnwo9Y3ji+VQCwt5wYj2mxv8lxA12WCfTTGc0g4xIf6B
 VCSToBsVlJ51/1tgCHLc6e5FZvMz0UhdHGVNneUFqbHgXLgdtGNwmyqsY0ezKcnIfUxx
 RA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NpXTMk5G/mYrlxq57uvRkdpsAdB0r/hroZIIr1th2o4=;
 b=pZgIsRdj2yMm2NLfz2kUdS6TlME4SZ8j5PFjiJNVpcVOHGeMthMKUK0S5i9/f0ycd2
 0FwmVx472kFMfrOEc69y3JQU+s9SahAUDkqrgEBUBJGIcuUV3akzw62FI03zoWsdXI7+
 R7WaKXAEC8BpsWK1xjHWPdoFLnAuDH6C+v3n7PT2UD2tk+BSYwrEP6PKt3WCc8hRws9a
 NK6vX7L9cKYpcOD4dg+E4bg6eH2QLF7Sbq6byBauyY8VTI6O0j/DmIfXBRVTYBmDNXRJ
 Eu8lS16YZW6uuq2lSK9vQG2W/E/8qUC/JUzcd59sgy/9MHrec0TblmSUbR94iUA8Hno6
 awiA==
X-Gm-Message-State: AOAM530BZ8mudZS4ZrR5ugMgGyKW5JRhP9VH0I72KRp/k/Huwe1xdLwV
 IxTPhKwtBeh1AwiEV0Hf2+s=
X-Google-Smtp-Source: ABdhPJwYGRhST9sCBc8+/gjXQFH9lbInZSx0LoTPrNN5Pta08IatQidIFaJGHck6lgm1GFRjL+pKPg==
X-Received: by 2002:a1c:6487:: with SMTP id y129mr9140411wmb.90.1600330185937; 
 Thu, 17 Sep 2020 01:09:45 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i6sm40891138wra.1.2020.09.17.01.09.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 01:09:45 -0700 (PDT)
Subject: Re: [PATCH V9 6/6] hw/mips: Add Loongson-3 machine support
To: Huacai Chen <chenhuacai@gmail.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-7-git-send-email-chenhc@lemote.com>
 <c3804617-7c65-4082-de76-81e718f6d139@amsat.org>
 <CAAhV-H5OysVNvGzD066eVqA+-k2+GJDjwSGR0hJT0VUh3Ld83A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <828c48db-c409-2c51-ab4b-795623d67193@amsat.org>
Date: Thu, 17 Sep 2020 10:09:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5OysVNvGzD066eVqA+-k2+GJDjwSGR0hJT0VUh3Ld83A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.062,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 11:49 AM, Huacai Chen wrote:
>>> We now already have a full functional Linux kernel (based on Linux-5.4.x
>>> LTS, the kvm host side and guest side have both been upstream for Linux-
>>> 5.9, but Linux-5.9 has not been released yet) here:
>>>
>>> https://github.com/chenhuacai/linux
>>>
>>> Of course the upstream kernel is also usable (though it is "unstable"
>>> now):
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>
>>> How to use QEMU/Loongson-3?
>>> 1, Download kernel source from the above URL;
>>> 2, Build a kernel with arch/mips/configs/loongson3_defconfig;
>>> 3, Boot a Loongson-3A4000 host with this kernel (for KVM mode);
>>> 4, Build QEMU-master with this patchset;
>>
>> Which produces all the following errors:
>>
>> hw/mips/loongson3_virt.c: In function 'get_cpu_freq':
>> hw/mips/loongson3_virt.c:372:12: error: variable 'freq_reg' has
>> initializer but incomplete type
>>      struct kvm_one_reg freq_reg = {
>>             ^
>> hw/mips/loongson3_virt.c:373:9: error: unknown field 'id' specified in
>> initializer
>>          .id = KVM_REG_MIPS_COUNT_HZ,
>>          ^
>> hw/mips/loongson3_virt.c:373:15: error: 'KVM_REG_MIPS_COUNT_HZ'
>> undeclared (first use in this function)
>>          .id = KVM_REG_MIPS_COUNT_HZ,
>>                ^
> I don't know how to reproduce these errors, struct kvm_one_reg and
> KVM_REG_MIPS_COUNT_HZ are both defined..., could you please tell me?
> My build steps are like this:
> mkdir build
> cd build
> ../configure
> make

Building on Ubuntu 20.04.

C compiler for the host machine: cc (gcc 9.3.0 "cc (Ubuntu
9.3.0-10ubuntu2) 9.3.0")
C linker for the host machine: cc ld.bfd 2.34

