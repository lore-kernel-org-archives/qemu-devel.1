Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35BAC74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD582064A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD582064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlF0A-00055t-NN
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 11:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50574)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlEzh-0004hQ-B7
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlEzg-0002U7-Df
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:58:57 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:34810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlEzg-0002TN-7m
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:58:56 -0400
Received: by mail-wm1-f47.google.com with SMTP id w9so4968487wmd.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 08:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4ckaWfPPYiX5j6aYHHbxSqNy/lUN8f42G0qiIlfZYP8=;
 b=reM9hpureKf+m0RgNvYJiiBoKh9KWFMV2Kq2eN5RSINZjqP2WbB2w1xjAJIm3PKj1R
 6Tut8kda7vs2Txd8s9iutKW1HtENL0UqgNjCIgwdx9ol7+/d2wNWWHLaB575syy0hvfq
 2B8W51rqM44fysMaRqRks/w7pP0ajNEXtt6fxC1hDKaNutDTTyIB8UWk8MDG8+IQ1LYi
 1BBxRhJOTvrUTrjMoWEGjGAX7zIDX1Tipqtgfowl2QgnyzsF4WuFBMQamrMNEAw+D+39
 y2bnL1jx+F/ybhHe3OKErAOIMVvsb0SlDV++wn96k6Y1H1j+roPD04MjGx1FuPpRZbFa
 WmXQ==
X-Gm-Message-State: APjAAAW2kU0vZGmxBX0vDquI25RkhcSIfBoKSFCwMzTm1moAMew14yFN
 6RDAicmqW6VwvKdl1syuw+KpSw==
X-Google-Smtp-Source: APXvYqxLHjOUmADeRJ31a2R9j+BlYKwjPwvyQfN+QTi2GjqkqkoPiKhZl15lklYf7fYDC17OS4otwQ==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr5914440wmf.162.1562774334961; 
 Wed, 10 Jul 2019 08:58:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id s63sm2397593wme.17.2019.07.10.08.58.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 08:58:54 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 ddm <hope2hope@163.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <c49fcb4.af77.16bdae2795a.Coremail.hope2hope@163.com>
 <adefe3b6-f8ff-5010-58e5-45a4445a648f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c7076dee-b401-9595-028e-fc0349e74a7f@redhat.com>
Date: Wed, 10 Jul 2019 17:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <adefe3b6-f8ff-5010-58e5-45a4445a648f@redhat.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.47
Subject: Re: [Qemu-devel] Can not relocate APIC registers address from
 0xFEE00000 to self-defined physical addr
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/19 17:41, Philippe Mathieu-Daud¨¦ wrote:
> 
> I wrote a Small OS (based on linux0.11) support SMP, and it can run
> well on bochs, Now i want to migrate it to Qemu, i found that when i
> use wrmsr command to relocate the APIC regsiters addr to a new
> physical address, it can not work, i can not initial APIC timer to
> trigger timer interrupt by the new physical addr just i relocate, but
> when use rdmsr to get APIC base addr has been changed to the new
> physical address, it's strange. In SMP env, if can not relocate APIC
> registers addr for each processor with  different addr, it will
> result in conflict. So, i want to know qemu4.0 whether support
> remaping APIC base address by wrmsr command? if support, please tell
> me how to remap APIC base addr for each processor.

Yes, this is not supported by QEMU.  However, you don't need to change
the base address, because each processor will only write to its own APIC
even if all of them use the same base address.

Paolo

