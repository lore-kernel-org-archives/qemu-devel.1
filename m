Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487D3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 01:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C8420678
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 01:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/iv2lgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C8420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGBfO-0001sg-Uc
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 21:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGBeg-0001MW-3s
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 21:45:42 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGBec-0006Dg-2s
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 21:45:41 -0400
Received: by mail-pg1-x544.google.com with SMTP id s65so2305896pgb.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 18:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=srlzi6kO9KxXkI8QJDt5Z43HoR7v2ko9LYXQ8jt4y44=;
 b=u/iv2lgVycfu88AolfBLdcxoQkKwFXlBKbtJ8zj8UK6eoFLqKxQheAfb05BlbcjwKz
 G8IsBcKBAAda2DaUi0COUFu04Hgo/bR90dfH8TpuflZRaHnC1khAEnRbSFJQPHZdmbOU
 52oCPFtp2JMMYx+7+DIob4TqY2CPbrFgfDAD4HYjqQ0FZNHOF9gB/q+C2Fs3bpOQg0YE
 hue7OYmW6G4eWQeXxXOT1y6I0qdgh2BpgOh4Ybit8LKhLF1Gi1vG2NHllpk0fVbF9hS8
 f0vWsNBOavuocqCQkz3yBm5hrrBsPxXEPuV1wvG1Tk++5ZE9iciU1ZSfbVrnFoMcVRO7
 rjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=srlzi6kO9KxXkI8QJDt5Z43HoR7v2ko9LYXQ8jt4y44=;
 b=IziTSDF1GAWs+Ric/ciyXZBgVZyl2Hyc2/KSRgBXCQ9NViLZd+/IgWkH6TTOr+dXxz
 SB9hO15Gt4t8pgMCFIPN/xk/q3x0wYj2EhRPkdDUlOePZIp1kv3XAORso583zDMeykBQ
 21o5Rtn6MhDQjdflrx0gwNV2UkTTyo9gouWzkTsIZGZje9gZQeuvJuFgV2+5EdMS3JDv
 4FrppX+2JeQ0loMMRbS37ENKJnJAUYASshyBgQPnzVdiXZRAX5NvhHTV5Nbl3750A+0e
 e26KgndcT9XlCSKiq6t0TFw4yJn+7mEhWFBmIv97W8rcYw9i9P74cfUe70rTZ1bmuNXr
 P6zg==
X-Gm-Message-State: AOAM532sqZJzMP5z/2SolZww9CM7anOO/sGQMnimOk6eiCT2MutWLaOg
 25O+If6FwFa4r7UjnT2hgNDAhQ==
X-Google-Smtp-Source: ABdhPJyqpWOeqHuTEIwwj1uDXktA1dBPRjOp1EaAUDe2coNSXU+KFMxtpo7uhsAAcumooCW0G+ElHQ==
X-Received: by 2002:a62:b407:: with SMTP id h7mr3166747pfn.134.1599702336093; 
 Wed, 09 Sep 2020 18:45:36 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s20sm3936396pfu.112.2020.09.09.18.45.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 18:45:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
To: Andrew Jones <drjones@redhat.com>, Steven Price <steven.price@arm.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5cb1d7ed-54a5-4337-6c3d-2e3e7df89f17@linaro.org>
Date: Wed, 9 Sep 2020 18:45:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.576,
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
Cc: Peter Maydell <Peter.Maydell@arm.com>, Juan Quintela <quintela@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 8:25 AM, Andrew Jones wrote:
>>  * Provide a KVM-specific method to extract the tags from guest memory.
>>    This might also have benefits in terms of providing an easy way to
>>    read bulk tag data from guest memory (since the LDGM instruction
>>    isn't available at EL0).
> 
> Maybe we need a new version of KVM_GET_DIRTY_LOG that also provides
> the tags for all addresses of each dirty page.

KVM_GET_DIRTY_LOG just provides one bit per dirty page, no?  Then VMM copies
the data out from its local address to guest memory.

There'd be no difference with or without tags, afaik.  It's just about how VMM
copies the data, with or without tags.

>>  * Provide support for user space setting the TCMA0 or TCMA1 bits in
>>    TCR_EL1. These would allow the VMM to generate pointers which are not
>>    tag checked.
> 
> So this is necessary to allow the VMM to keep tag checking enabled for
> itself, plus map guest memory as PROT_MTE, and write to that memory when
> needed? 

I don't see a requirement for the VMM to set TCMA0.


r~

