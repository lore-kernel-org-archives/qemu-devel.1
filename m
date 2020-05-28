Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66CEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BCF20888
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVZudNBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BCF20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGJr-0004HZ-Py
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jeGJI-0003sa-CX
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:02:52 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:33988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jeGJH-0005ih-AP
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:02:51 -0400
Received: by mail-ej1-x641.google.com with SMTP id l27so9483982ejc.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 04:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pyN3K7tTHjuvekpOqVYMQhwIz8R0uymSGMDp7XOU0tA=;
 b=sVZudNBJ0j4ZZtm25yUJ0uKWypqoE4Xp1N6J3XzbAAImzI3a9CMY3fStryBIr1Q3hW
 aTuaKd37Ty/8wmnQLkVpFLIX1kUBr2tCN85ddxn58xH/T5lIJUHb3M8GGVd7kzigRtxQ
 HyZBAKuBU6EpZzaNKq9qrMfvlixUTBYUT2vdPr+N+ItSkTP2IkBXEQV02VlV9Hn4Qybk
 YR3IvKOvkMUx/B9tC2i3gS2aCwgsoyZsjHjbfjfZCTaZ9JHxJDeXXzaMwQKLTUq3jfmr
 OXQpoRrkw0tqs+kcUoSWo5U5dvQVgnt6wUYU8zqjG+SGgrRtqcRxHZtV1i9bSLLdOlVc
 Fi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pyN3K7tTHjuvekpOqVYMQhwIz8R0uymSGMDp7XOU0tA=;
 b=JkajINBy3uYvGcxGcvOYgBobt898aTQFSLA2VUDUaGPAjTSuW2L4/PRhQ5N46w1rzn
 1GoabxkxSd4MDIaz47281oA2vaa5D65qJWDS/5bMpbxCSPlMTsGgpx0NQBzzUrPWJiq1
 6tcZ+2GtNwz+cAXMunW/9brwdA8LIDNqVjlZmf2f/rzWMFvpU+U2N6rl3DbZQibhLn2n
 YrpvFvQOZRCgpWOEv3vA0sF2YDIL0kgJyTog4fTl50Zv3UD/M6dikJKn6zqZYf1OqdFl
 6u8snUMTE4JpFrubmRL/pZE0EYy1S1S/k36e//B6C5Vl/u/SawkuwSgnLlI/xhsDMW+t
 T0og==
X-Gm-Message-State: AOAM533KBGAQMkl/zkb1KPo/qnjw/674HFnomVZ8rFnh3L3Zi2hJaWYy
 1OS0rOD7dH4UIgSil9mpMNM=
X-Google-Smtp-Source: ABdhPJwXIysWlxye3IDDh1/qntYFKU5wAbyO3E5DykygUGH+Xnzeo7dHGkLqcPuAPrV65Pim0UA5Jg==
X-Received: by 2002:a17:906:e112:: with SMTP id
 gj18mr2445988ejb.352.1590663769693; 
 Thu, 28 May 2020 04:02:49 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id y16sm5088962ejq.82.2020.05.28.04.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 04:02:49 -0700 (PDT)
Date: Thu, 28 May 2020 14:02:47 +0300
From: Jon Doron <arilou@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200528110247.GD3071@jondnuc>
References: <20200424123444.3481728-1-arilou@gmail.com>
 <20200424123444.3481728-6-arilou@gmail.com>
 <20200505150637.7131e79b@redhat.com>
 <20200511182121.GA1307176@rvkaganb.lan>
 <20200513173414.62e3cb4e@redhat.com>
 <fb1661c0-7282-58b4-03b4-a77793cc8e97@redhat.com>
 <20200522104053.4e7834a8@nas.mammed.net>
 <20200528052642.GB3071@jondnuc>
 <20200528123700.0a364b0e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200528123700.0a364b0e@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, Roman Kagan <rvkagan@yandex-team.ru>,
 liran.alon@oracle.com, Roman Kagan <rkagan@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, vkuznets@redhat.com,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/05/2020, Igor Mammedov wrote:
>On Thu, 28 May 2020 08:26:42 +0300
>Jon Doron <arilou@gmail.com> wrote:
>
>> On 22/05/2020, Igor Mammedow wrote:
>> >On Thu, 21 May 2020 18:02:07 +0200
>> >Paolo Bonzini <pbonzini@redhat.com> wrote:
>> >
>> >> On 13/05/20 17:34, Igor Mammedov wrote:
>> >> > I'd rather avoid using random IRQ numbers (considering we are
>> >> > dealing with black-box here). So if it's really necessary to have
>> >> > IRQ described here, I'd suggest to implement them in device model
>> >> > so they would be reserved and QEMU would error out in a sane way if
>> >> > IRQ conflict is detected.
>> >>
>> >> We don't generally detect ISA IRQ conflicts though, do we?
>> >
>> >that I don't know that's why I'm not suggesting how to do it.
>> >The point is hard-coding in AML random IRQs is not right thing to do,
>> >(especially with the lack of 'any' spec), as minimum AML should pull
>> >it from device model and that probably should be configurable and set
>> >by board.
>> >
>> >Other thing is:
>> >I haven't looked at VMBus device model in detail, but DSDT part aren't
>> >matching device though (device model is not ISA device hence AML part
>> >shouldn't be on in ISA scope), where to put it is open question.
>> >There were other issues with AML code, I've commented on, so I was
>> >waiting on respin with comments addressed.
>> >I don't think that this patch is good enough for merging.
>> >
>> >
>>
>> But it seems like the current patch does match what's Microsoft HyperV
>> is publishing in it's APCI tables.
>>
>> I dont think it's correct for us to "fix" Microsoft emulation even if
>> it's wrong, since that's what Windows probably expects to see...
>>
>> I tried looking where Microsoft uses the ACPI tables to identify the
>> VMBus but without much luck in order to understand how flexible a change
>> would be for the OS to still detect the VMBus device, but in general
>> I think "correcting" something that is emulated 1:1 because there is no
>> spec is the right way.
>
>I'd agree, if removing nonsense would break VMBus detection (does it?).
>if something is that doesn't make sense but has to stay because it is need
>to make windows happy, that's fine , just add annotate is with comment,
>so it won't confuse anyone why that code exists there later on.
>
>I suggest to:
> 1. try dropping _PS* & _STA as it doesn't actually does anything and _PS3 is plain wrong
> 2. drop one IRQ, newer hyper-v seems to be doing fine with only one
> 3. it's not ISA device, I'd suggest to move into _SB scope
> 4. I don't know much about IRQs but
>       git grep DEFINE_PROP_ | grep -i iqr
>    yields nothing so I'm not sure if it's acceptable. Typically it's board that assigns
>    IRQ and not device, for Sysbus devices (see: sysbus_init_irq/sysbus_connect_irq).
>    So I'd leave it upto Paolo or someone else to decide/comment on.
>

Sounds like a plan, I'll try to come up with the test results
(at least for Windows 10 guest which is  what I have setup) and update
this thread with the results.

-- Jon.

>>
>> >>
>> >> Paolo
>> >>
>> >
>>
>

