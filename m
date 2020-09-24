Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A0FC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3907F2311B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCAcymBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3907F2311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTx2-00054m-2z
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLTLv-0000Kt-O6
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:40:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLTLr-0007Xc-Lg
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:40:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id a9so4092635wmm.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Gka7nXcDbZ00olQHSXjZzQSruXAZ5zUcfMCetjN9ozw=;
 b=WCAcymBKHqZykwWGtJPECq7IqIpjawKpPY0B2r2EAdLcCwlj90U5Ddo7lyMeSGxIua
 R0zYQrSFYnNtF/AZe9fzL9nqF4AQGtQWNPo3lc/feQ0fM02zs1OkwPW81+8225qLcyn9
 y491vm+Q14aBSILFBvCC7LOj+H3IlAOerAavGuoy0zoiYp+Hj4zJglWwZqQQVeGMDLL/
 Y12IxtMj4/VSriFu0fnFY1G8jUdWjIMkSYf0o8+In3Xf+30Lla5cSQ0gJq7VHNpOyxFO
 PHT3/7Tu7fRHC0aIjvjuTjhCc+Bl96sVk5XBuokDCH4x2Mu4adMJU9UC2RZy0aqlxq9K
 JZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gka7nXcDbZ00olQHSXjZzQSruXAZ5zUcfMCetjN9ozw=;
 b=hxkGYNsPqMaxXsmt9Anniat0vws28ReS/y9q4hOUsYcZlOxv+b32AHKxdrI8iqo2BE
 /VLoNi/I9FZ7xTYln9k0IWohWvI1zPswNb3IHZr7Aq1rVFSNYCe1+eG/5to20jboFRxT
 jbkQAjYxjBmH3RP5bLtHRPvS34ZsrIVJEKEGzqDqMN74wfL6J+MSGnPToZsEtvg24g6+
 ohsww9R4loi6Bjf2CWHyTqrwTrJUa/MYThd/XqZqQaN7qlkFTjAW53Jd2kKhUhhoOk2u
 WhSJVpL0VXOCAD104PdL9vGJZYlOUTECdXdjSV2Ihz3lVkfHg3N1TXocu+5d+X7nZGjR
 5+1g==
X-Gm-Message-State: AOAM533hKjKetj/HGWNoO4Xu8/YrjvQJ8xHuDeSCvmwDd1QEI/nx5LIc
 ZJ6ZwyiFA1mF0aVc9U0SRHA=
X-Google-Smtp-Source: ABdhPJzsppPKrIC351GdrWfngqCPAF9cW9fO3wnwZIHvaX3t8X9wOfxUhdFH69IpW9ircbqin+4+Aw==
X-Received: by 2002:a1c:63c1:: with SMTP id x184mr5464069wmb.138.1600962004954; 
 Thu, 24 Sep 2020 08:40:04 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id 9sm3813041wmf.7.2020.09.24.08.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 08:40:04 -0700 (PDT)
Subject: Re: [PATCH V9 6/6] hw/mips: Add Loongson-3 machine support
To: Huacai Chen <chenhuacai@gmail.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-7-git-send-email-chenhc@lemote.com>
 <c3804617-7c65-4082-de76-81e718f6d139@amsat.org>
 <CAAhV-H5OysVNvGzD066eVqA+-k2+GJDjwSGR0hJT0VUh3Ld83A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4a461bbc-3765-4d3c-7e7b-952dab564af1@amsat.org>
Date: Thu, 24 Sep 2020 17:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5OysVNvGzD066eVqA+-k2+GJDjwSGR0hJT0VUh3Ld83A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.214,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 11:49 AM, Huacai Chen wrote:
> Hi, Philippe,
> 
> On Wed, Sep 16, 2020 at 3:56 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Hi Huacai,
>>
>> On 9/16/20 4:12 AM, Huacai Chen wrote:
...
>> hw/mips/loongson3_virt.c:373:15: note: each undeclared identifier is
>> reported only once for each function it appears in
>> hw/mips/loongson3_virt.c:373:15: error: excess elements in struct
>> initializer [-Werror]
>> hw/mips/loongson3_virt.c:373:15: note: (near initialization for 'freq_reg')
>> hw/mips/loongson3_virt.c:374:9: error: unknown field 'addr' specified in
>> initializer
>>          .addr = (uintptr_t)(&freq)
>>          ^
>> hw/mips/loongson3_virt.c:374:17: error: excess elements in struct
>> initializer [-Werror]
>>          .addr = (uintptr_t)(&freq)
>>                  ^
>> hw/mips/loongson3_virt.c:374:17: note: (near initialization for 'freq_reg')
>> hw/mips/loongson3_virt.c:372:24: error: storage size of 'freq_reg' isn't
>> known
>>      struct kvm_one_reg freq_reg = {
>>                         ^
>> hw/mips/loongson3_virt.c:380:41: error: 'KVM_GET_ONE_REG' undeclared
>> (first use in this function)
>>          ret = kvm_vcpu_ioctl(first_cpu, KVM_GET_ONE_REG, &freq_reg);
>>                                          ^
>> hw/mips/loongson3_virt.c:372:24: error: unused variable 'freq_reg'
>> [-Werror=unused-variable]
>>      struct kvm_one_reg freq_reg = {
>>                         ^
>> hw/mips/loongson3_virt.c: In function 'init_loongson_params':
>> hw/mips/loongson3_virt.c:467:25: error: cast from pointer to integer of
>> different size [-Werror=pointer-to-int-cast]
>>      lp->memory_offset = (unsigned long long)init_memory_map(p)
>>                          ^
> I guess this happens on a 32bit platform where pointer is 32bit, and
> could you please suggest a best solution for this? Maybe use uintptr_t
> instead of unsigned long long?

Since the machine doesn't have to know the EFI structures
layout, I'd change your method to fill EFI structures as i.e.:

/*
 * @ptr: Pointer to fill
 * @size: Buffer size available at @ptr
 * Returns: Structure size filled on success, -1 on error.
 */
size_t fill_efi_memory_map_loongson(char *ptr, size_t size);

And move that to hw/mips/loongson_efi.{c,h}.

Then you don't need to worry about host pointer size, you just
exchange buffer/size, then caller can round up and increment an
offset.

BTW the EFI helpers are not endian safe.

You should use the helpers described in docs/devel/loads-stores.rst:

stw_le_p, stl_le_p(), ... (as I don't expect big-endian guests).

Regards,

Phil.

