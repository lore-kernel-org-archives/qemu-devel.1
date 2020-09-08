Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C61FC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D142A2078B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rh6S2HsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D142A2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFi7l-0008Iv-Tf
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFi71-0007Va-Qu
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:13:00 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFi6z-0006NX-EX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:12:59 -0400
Received: by mail-wm1-x342.google.com with SMTP id y15so291619wmi.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=O4FcC86KYQ9whYHKzlglDVxAsaKfWG4LrJ5YrGf3pPQ=;
 b=rh6S2HsHt3g7Xhoj1pfnY29BRvqoqfAJuIr7nG31/Fw0ceG6v5UxhqCmxIlf7Igp01
 W3DDD5RvGgjPV5IjBe4WiRhzhRE0R63HRL81Qqc+cGo1W6RmkmDNNn92IpminCCGrZGe
 DDS0I8EXPul2TgD2IGkMWXcnetghVgtnp0ky62Ad/+bcvfYab7O18Me91utrLwc4+/ep
 GNMn1cRjGJt5rHPpDLTViHqLvsTym8mWvF4GTCDKFgwKP8znaao9FHvg5pjTkz3B/5y2
 57so5FLcPco49tcRSS6RpumhSfsAmbCIsEMtAD8Izv3kt+6WRl1VVa0aThL/9ybIjgVZ
 wBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O4FcC86KYQ9whYHKzlglDVxAsaKfWG4LrJ5YrGf3pPQ=;
 b=Ax2EuQE0aTwJf210fLPvXjXH8o//1tSAfwoCv4cL1lE1IgVMHBeWD9ETwsADOYo3GQ
 RzPtfc8RpLUuSWZxDg23SxbCRTVGbpR3jn/jzNnjmdUw8VOkDGspCAJ6sMEkE8j4OF7k
 QdyJrqOzi5oZnVtjg+YAbPThXaeTXe1GN7j7DCb+M7eiR70+xZd6TVWGVw8LLuVy5HPA
 yZWWdHiUAvKx9jir4Hn8dSemOq5p9TG6G3TaYAO2QuYJk05sKHQ8jJkN0beJsIEufjik
 qoU+tA6qzlcPSWUHBb2uN3AuQj0L1qeYf9FZWomCmYqIoZ1QM6EqqSUWhln+Tdd/8Uqy
 7c1Q==
X-Gm-Message-State: AOAM530pkki4ho4cCFUCTOkcHugVlB6G981jIKxYfeSBXk1MUyQzwjBu
 GL3A8kMgsrLuLucFQ/5rnNQ=
X-Google-Smtp-Source: ABdhPJxclKQwnD8mwP2QriR0wP++Duehc7+jZXURP3Dutss4q49xB9EYPTGhBc6j/l6WU8awkuUOwQ==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr341695wmi.186.1599588775888; 
 Tue, 08 Sep 2020 11:12:55 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u17sm282565wmm.4.2020.09.08.11.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 11:12:54 -0700 (PDT)
Subject: Re: [PATCH V2 for-5.2] hw/null-machine: Add the kvm_type() hook for
 MIPS
To: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1598256668-12131-1-git-send-email-chenhc@lemote.com>
 <caa3c014-ba68-0875-4dd5-faed9282ca95@redhat.com>
 <20200908175946.GF1618070@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <697d031b-654b-f258-0f05-3485919cf2db@amsat.org>
Date: Tue, 8 Sep 2020 20:12:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908175946.GF1618070@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.626,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen <chenhuacai@gmail.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, David Gibson <dgibson@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 7:59 PM, Eduardo Habkost wrote:
> On Tue, Sep 08, 2020 at 07:25:47PM +0200, Thomas Huth wrote:
>> On 24/08/2020 10.11, Huacai Chen wrote:
>>> MIPS has two types of KVM: TE & VZ, and TE is the default type. Now,
>>> libvirt uses a null-machine to detect the kvm capability. In the MIPS
>>> case, it will return "KVM not supported" on a VZ platform by default.
>>> So, add the kvm_type() hook to the null-machine.
>>>
>>> This seems not a very good solution, but I cannot do it better now.
>>
>> This is still ugly. Why do the other architectures do not have the
>> same problem? Let's see... in kvm-all.c, we have:
>>
>>     int type = 0;
>>     [...]
>>     kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
>>     if (mc->kvm_type) {
>>         type = mc->kvm_type(ms, kvm_type);
>>     } else if (kvm_type) {
>>         ret = -EINVAL;
>>         fprintf(stderr, "Invalid argument kvm-type=%s\n", kvm_type);
>>         goto err;
>>     }
>>
>>     do {
>>         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
>>     } while (ret == -EINTR);
>>
>> Thus the KVM_CREATE_VM ioctl is likely called with type = 0 in this
>> case (i.e. when libvirt probes with the "null"-machine).
>>
>> Now let's have a look at the kernel. The "type" parameter is passed
>> there to the architecture specific function kvm_arch_init_vm().
>> For powerpc, this looks like:
>>
>> 	if (type == 0) {
>> 		if (kvmppc_hv_ops)
>> 			kvm_ops = kvmppc_hv_ops;
>> 		else
>> 			kvm_ops = kvmppc_pr_ops;
>> 		if (!kvm_ops)
>> 			goto err_out;
>> 	} else	if (type == KVM_VM_PPC_HV) {
>> 		if (!kvmppc_hv_ops)
>> 			goto err_out;
>> 		kvm_ops = kvmppc_hv_ops;
>> 	} else if (type == KVM_VM_PPC_PR) {
>> 		if (!kvmppc_pr_ops)
>> 			goto err_out;
>> 		kvm_ops = kvmppc_pr_ops;
>> 	} else
>> 		goto err_out;
>>
>> That means for type == 0, it automatically detects the best
>> kvm-type.
>>
>> For mips, this function looks like this:
>>
>> 	switch (type) {
>> #ifdef CONFIG_KVM_MIPS_VZ
>> 	case KVM_VM_MIPS_VZ:
>> #else
>> 	case KVM_VM_MIPS_TE:
>> #endif
>> 		break;
>> 	default:
>> 		/* Unsupported KVM type */
>> 		return -EINVAL;
>> 	};
>>
>> That means, for type == 0, it returns -EINVAL here!
>>
>> Looking at the API docu in Documentation/virt/kvm/api.rst
>> the description of the type parameter is quite sparse, but it
>> says:
>>
>>  "You probably want to use 0 as machine type."
>>
>> So I think this is a bug in the implementation of KVM in the
>> mips kernel code. The kvm_arch_init_vm() in the mips code should
>> do the same as on powerpc, and use the best available KVM type
>> there instead of returning EINVAL. Once that is fixed there,
>> you don't need this patch here for QEMU anymore.
> 
> If there's a way to make it work with older kernels, I assume we
> would still want to do it.

IIUC this is available since kernel v5.8-rc1 (merged in 52cd0d972fa6)
less than 3 months ago. v5.9-rc4 just got released, not sure if this
can be fixed for the v5.9 release.

Is this small older kernels window important?

Huacai, can you amend in the commit description since when the
feature is available in the Linux kernel please? (just for
informative purpose).

> 
> However, this kind of kvm-specific + arch-specific knowledge
> doesn't belong to machine core code.  If we are going to add a
> #ifdef TARGET_MIPS to the code, we can simply do it inside
> kvm-all.c:kvm_init().
> 

