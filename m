Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086E1C06513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DC22082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DC22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJd7-0005qD-TW
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46944)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiJbu-0005FI-CV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiJbt-0002We-6m
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:18:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46742)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiJbt-0002VF-0k
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:18:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so18007472wrw.13
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 07:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ycPWOHZ1BiCQaixmh2lB3gnp7J7qHQ68WKc90qzNU5o=;
 b=R1aEmxEWzIWsl1RglvNz6VeNOnw+82GyBZB6GN7NyuVYNQhsRg9LVULF7h8x0LNfgr
 B/LeNG+Cs9917QRlSUHNFsQRCGnVSOmDcDaqG8OLRxXp62XVgYjXqkfLYnVBhNC4Vhq8
 NbDYITYuLywQC+fKEri8PRhs4GA4QbkiXMX/ydmaDhY0Y7pxq8zN7/i50PNgLSdMK8y/
 f401+7U7I0jlYp99UOU1koaqEgaLrNscq1F24WzLCRz2p8rkdXvqxN/UVbDgAwVA1BYq
 OFDNOPDBdWdEDYKS2fVQVPW4MksPiG9cQ3m8E6AANqCYvJalVKpcIhX17kOgGoMhfMhE
 6Mcg==
X-Gm-Message-State: APjAAAUeiGhv8Xsz6jSAC83M4Qh0K7RShvE3aWQCoLxcjAUuJBU7q46M
 kAYPEizZj9uas4nTiHkpTL4GNw==
X-Google-Smtp-Source: APXvYqxcTBzxRQ/AnK8eUHsT+x0ZvCtrXznppplhoH60ie3qupT/91jV68QLyzTs9JLirWTPEqD7Hw==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr8019657wrn.52.1562077095111;
 Tue, 02 Jul 2019 07:18:15 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id z126sm4037859wmb.32.2019.07.02.07.18.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 07:18:14 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190701194942.10092-1-philmd@redhat.com>
 <20190701194942.10092-4-philmd@redhat.com>
 <CAFEAcA99QK7u+Rev5C9Xb_vmnGSZvx9EO+8D_fFB1qFmiMejcA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e15783bc-660f-f8ba-e1ed-1ec870de9474@redhat.com>
Date: Tue, 2 Jul 2019 16:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99QK7u+Rev5C9Xb_vmnGSZvx9EO+8D_fFB1qFmiMejcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v4 3/8] target/arm/helper: Move M profile
 routines to m_helper.c
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
Cc: Yang Zhong <yang.zhong@intel.com>, Andrew Jones <drjones@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/19 4:01 PM, Peter Maydell wrote:
> On Mon, 1 Jul 2019 at 20:50, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> In preparation for supporting TCG disablement on ARM, we move most
>> of TCG related v7m/v8m helpers and APIs into their own file.
>>
>> Note: It is easier to review this commit using the 'histogram'
>>       diff algorithm:
>>
>>     $ git diff --diff-algorithm=histogram ...
>>   or
>>     $ git diff --histogram ...
>>
>> Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> patch generated with git diff --histogram.
>>
>> v4: rebased
>> ---
>>  target/arm/Makefile.objs |    1 +
>>  target/arm/helper.c      | 2661 +------------------------------------
>>  target/arm/m_helper.c    | 2676 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 2681 insertions(+), 2657 deletions(-)
>>  create mode 100644 target/arm/m_helper.c
> 
> This patch doesn't compile:
> 
>>
>> -hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
>> -                                         MemTxAttrs *attrs)
>> -{
>> -    ARMCPU *cpu = ARM_CPU(cs);
>> -    CPUARMState *env = &cpu->env;
>> -    hwaddr phys_addr;
>> -    target_ulong page_size;
>> -    int prot;
>> -    bool ret;
>> -    ARMMMUFaultInfo fi = {};
>> -    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
>> -
>> -    *attrs = (MemTxAttrs) {};
>> -
>> -    ret = get_phys_addr(env, addr, 0, mmu_idx, &phys_addr,
>> -                        attrs, &prot, &page_size, &fi, NULL);
>> -
>> -    if (ret) {
>> -        return -1;
>> -    }
>> -    return phys_addr;
>> -}
>> -
> 
> ...it deletes the definition of arm_cpu_get_phys_page_attrs_debug(),
> which should stay where it is.

Grrrrr I missed that rebase failure within the 2676 lines.

I am sorry and ambarassed I failed at notice it doesn't even compile.

