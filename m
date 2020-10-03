Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E86C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 10:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEDE206C3
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 10:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkuIbLNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEDE206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOevB-0000Rh-8b
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 06:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOeuZ-0008LY-LO
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 06:37:07 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOeuX-0006nM-R4
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 06:37:07 -0400
Received: by mail-ot1-x343.google.com with SMTP id u25so3920016otq.6
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 03:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VYwFI82HcYrq3ZgcNxh+7SPF1EvBaUooAvpT377YG+U=;
 b=kkuIbLNu/anD0Jaybii3oWCIfTglSY8QcWy0VEMk7kYxqR9SBZJg3GzDBNyVA3hs0X
 f8O7ItiVpZmFG0PDKDAtFf2ngs0jLSvRmYPcmu7cl3EiO/llS3gB/zwZpsjhdRILz6n4
 4CkEqwyCXw4uqKTUQZH8MnHnlQ7cbZpYrBvl8js/GMI53RiRSguS85jV34MbvWtQgORz
 cu9IGG84PAvnSSRfmQ7apvGD9kERUJHLzvOqbt2GbkSYIXKF4MkItCO0qdxdJ1+qYzdl
 2aqsRubeKaHyq1/Egd/Y+fDGY3B4H7YaBBOT0PrrHnVtz9y/336rnOCZhJ1etRp+bTbx
 Qm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VYwFI82HcYrq3ZgcNxh+7SPF1EvBaUooAvpT377YG+U=;
 b=j0vX7e4TCWYfUE7hNnbUB3/b3Du8ig91KJvAbmcx2FZrx5heoe2VrFFtiCyBZ+kybs
 PW3xcjFaEQiB4GEN8TWWRVY41le4iEH7tIw/NrWMkm72PHwAYjWA6H5JlpoChAm04G8o
 I89P19TOvqUsR9SeMkaKDXrTdoSPQeN0OMDK1mEHqO5nl1NfMKOIw4OYCTFN2ePJ8H+H
 Q0lonm5N26N5f3Ek3lZOsMecAlCbUatVbfGkfgRJBYO8mCbl+3mbewBy9314iHkdnotJ
 3DZ+NNSvElkwEh4YId6kFi9t3PwAV5seN8FdHcdXk8m6WMTumOC/7i6EGiwyL8BRDz26
 S1wQ==
X-Gm-Message-State: AOAM530TVhKeiH+f5uA5faHaK96SfrFJDd0r69CnSORIF3ZrrVLVDaM0
 9L9uJpNEwRIfc0fr/oYq9loTzg==
X-Google-Smtp-Source: ABdhPJyykWKhd6FiYjB5gw31NYFOzxdDlvz9ehjm7fFSXkcbpSlhgQsBUp9IHtz7QKHbMQdlKaIsEg==
X-Received: by 2002:a9d:7d8a:: with SMTP id j10mr4589711otn.27.1601721424036; 
 Sat, 03 Oct 2020 03:37:04 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id m187sm896465oia.39.2020.10.03.03.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 03:37:03 -0700 (PDT)
Subject: Re: [PATCH v4 12/12] .travis.yml: Add a KVM-only Aarch64 job
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel@nongnu.org
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-13-philmd@redhat.com>
 <bd4c4587-de23-7612-48c7-afc8b94ab9fb@linaro.org>
 <c7140a42-043c-9bc5-88c8-2cdad9ae2a14@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <01fa70d1-0f11-78a1-aeb6-885e91501429@linaro.org>
Date: Sat, 3 Oct 2020 05:37:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c7140a42-043c-9bc5-88c8-2cdad9ae2a14@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.256,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/20 5:14 AM, Thomas Huth wrote:
> On 03/10/2020 12.03, Richard Henderson wrote:
>> On 9/29/20 5:43 PM, Philippe Mathieu-Daudé wrote:
>>> Add a job to build QEMU on Aarch64 with TCG disabled, so
>>> this configuration won't bitrot over time.
>>>
>>> We explicitly modify default-configs/aarch64-softmmu.mak to
>>> only select the 'virt' and 'SBSA-REF' machines.
>>
>> I really wish we didn't have to do this.
>>
>> Can't we e.g. *not* list all of the arm boards explicitly in default-configs,
>> but use the Kconfig "default y if ..."?
>>
>> Seems like that would let --disable-tcg work as expected.
>> One should still be able to create custom configs with e.g.
>> CONFIG_EXYNOS4=n or CONIFIG_ARM_V4=n, correct?
> 
> But that would be different from how we handle all other targets currently...

So?  Does that automatically mean they're golden?
Perhaps they should be doing it the other way around too.


> IMHO we shoud go into a different direction instead, e.g. by adding a
> "--kconfig-dir" switch to the configure script. If it has not been specified,
> the configs will be read from default-configs/ (or maybe we should then rename
> it to configs/default/). But if the switch has been specified with a directory
> as parameter, the config files will be read from that directory instead. We
> could then have folders like:
> 
> - configs/default (current default-configs)
> - configs/no-tcg (all machines that work without tcg)
> - configs/lean-kvm (for "nemu"-style minimalistic settings)
> 
> etc.
> 
> What do you think?

I don't really understand the suggestion.  My first reaction is that this is
more confusing than --disable-tcg, and trying to automatically dtrt with that.


r~

