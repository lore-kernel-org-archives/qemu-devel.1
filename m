Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86614C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 15:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F913206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 15:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbSKDuWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F913206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkUSH-0001qN-Fr
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 11:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jkURI-00013K-F9
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 11:20:52 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40166)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jkURG-0000gY-Bu
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 11:20:52 -0400
Received: by mail-ed1-x544.google.com with SMTP id p18so9682429eds.7
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 08:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2zT6tXiuI05AbKUm8jI0U9MH5HyXRAFycm2wWZFgquA=;
 b=GbSKDuWUBU+Z2Zb1vkgxUK7+3zB22eyakcMttLSpjOhpqiVb81xh5bjh+cAy3lDDNn
 xKbw98O392DwunSx2cZadon8j8BPJlvCTlx6AAIZd6qQisXh70rUmt20qM5fEIoa134c
 WdLv2BTbv953amQJwSoR15B7o3PpBjG/8lxdszPh5ecVHc7Oaof4Yka498PwVXU0oYL0
 ySd94QGUXsFDXMQvhu62tyHMxHJ/OuUP8MHFGg+VMguFURSYmeyiiWkVl6359zZ34EiT
 kOWVCoyJdZZKf7QXC5sP3Gg+TEMxwlIqKrykiIeTi9NaKjGmOJfe/SpBMk9RmEZPvt0c
 kmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2zT6tXiuI05AbKUm8jI0U9MH5HyXRAFycm2wWZFgquA=;
 b=aXrfZSe3k2KXdDbIaKdshH9aYLCADGk0iSClzv6QIkRu+5ma+ejbjop6OA87E5Bqz5
 ghA/7SPO6NHnznAUvnfCsIseWHZduv9f4csu7ONDzJiXDEKCZb652E1mJcTIOb8b33X4
 akc9gxJ0D7tPnnUrqD17qsySEs8TRQj/DXTWny55KvxIT7nv5FRS8YP9Ba/8vQi1rS60
 Ab3BikwkjGpMokHuMKYB1BzJC82/NYSxYPnsKfg6csCCWCbdCrGyJdQfgiKdzJ18OBIy
 /UNGBfDDSL0TbXxK2WlURut5PbcHoRFd8QnM/xS0EAuV6ITy1RAvD7HQvujtktd2vAJC
 AoIw==
X-Gm-Message-State: AOAM5305xX5TFSLcVIZCD0mQbs39PtOOXmHO2tEgOg85nx9hai1tfq3z
 BlVv9mpFyTl9lqL3mQVHlQ8=
X-Google-Smtp-Source: ABdhPJwTH6L0B5SOV8GM9yHuwdzmKZn5Vdsv5RxKtQM2ooAF3Yx7uTf86pH2BltKSOM1YYtzCLOXgw==
X-Received: by 2002:a05:6402:54d:: with SMTP id
 i13mr20098181edx.330.1592148043592; 
 Sun, 14 Jun 2020 08:20:43 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id v12sm6790438eda.39.2020.06.14.08.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 08:20:42 -0700 (PDT)
Date: Sun, 14 Jun 2020 18:20:41 +0300
From: Jon Doron <arilou@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200614152041.GB8561@jondnuc>
References: <20200424123444.3481728-6-arilou@gmail.com>
 <20200505150637.7131e79b@redhat.com>
 <20200511182121.GA1307176@rvkaganb.lan>
 <20200513173414.62e3cb4e@redhat.com>
 <fb1661c0-7282-58b4-03b4-a77793cc8e97@redhat.com>
 <20200522104053.4e7834a8@nas.mammed.net>
 <20200528052642.GB3071@jondnuc>
 <20200528123700.0a364b0e@redhat.com>
 <20200528110247.GD3071@jondnuc> <20200614141144.GA8561@jondnuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200614141144.GA8561@jondnuc>
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=arilou@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 14/06/2020, Jon Doron wrote:
>On 28/05/2020, Jon Doron wrote:
>>On 28/05/2020, Igor Mammedov wrote:
>>>On Thu, 28 May 2020 08:26:42 +0300
>>>Jon Doron <arilou@gmail.com> wrote:
>>>
>>>>On 22/05/2020, Igor Mammedow wrote:
>>>>>On Thu, 21 May 2020 18:02:07 +0200
>>>>>Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>>
>>>>>>On 13/05/20 17:34, Igor Mammedov wrote:
>>>>>>> I'd rather avoid using random IRQ numbers (considering we are
>>>>>>> dealing with black-box here). So if it's really necessary to have
>>>>>>> IRQ described here, I'd suggest to implement them in device model
>>>>>>> so they would be reserved and QEMU would error out in a sane way if
>>>>>>> IRQ conflict is detected.
>>>>>>
>>>>>>We don't generally detect ISA IRQ conflicts though, do we?
>>>>>
>>>>>that I don't know that's why I'm not suggesting how to do it.
>>>>>The point is hard-coding in AML random IRQs is not right thing to do,
>>>>>(especially with the lack of 'any' spec), as minimum AML should pull
>>>>>it from device model and that probably should be configurable and set
>>>>>by board.
>>>>>
>>>>>Other thing is:
>>>>>I haven't looked at VMBus device model in detail, but DSDT part aren't
>>>>>matching device though (device model is not ISA device hence AML part
>>>>>shouldn't be on in ISA scope), where to put it is open question.
>>>>>There were other issues with AML code, I've commented on, so I was
>>>>>waiting on respin with comments addressed.
>>>>>I don't think that this patch is good enough for merging.
>>>>>
>>>>>
>>>>
>>>>But it seems like the current patch does match what's Microsoft HyperV
>>>>is publishing in it's APCI tables.
>>>>
>>>>I dont think it's correct for us to "fix" Microsoft emulation even if
>>>>it's wrong, since that's what Windows probably expects to see...
>>>>
>>>>I tried looking where Microsoft uses the ACPI tables to identify the
>>>>VMBus but without much luck in order to understand how flexible a change
>>>>would be for the OS to still detect the VMBus device, but in general
>>>>I think "correcting" something that is emulated 1:1 because there is no
>>>>spec is the right way.
>>>
>>>I'd agree, if removing nonsense would break VMBus detection (does it?).
>>>if something is that doesn't make sense but has to stay because it is need
>>>to make windows happy, that's fine , just add annotate is with comment,
>>>so it won't confuse anyone why that code exists there later on.
>>>
>>>I suggest to:
>>>1. try dropping _PS* & _STA as it doesn't actually does anything and _PS3 is plain wrong
>>>2. drop one IRQ, newer hyper-v seems to be doing fine with only one
>>>3. it's not ISA device, I'd suggest to move into _SB scope
>>>4. I don't know much about IRQs but
>>>     git grep DEFINE_PROP_ | grep -i iqr
>>>  yields nothing so I'm not sure if it's acceptable. Typically it's board that assigns
>>>  IRQ and not device, for Sysbus devices (see: sysbus_init_irq/sysbus_connect_irq).
>>>  So I'd leave it upto Paolo or someone else to decide/comment on.
>>>
>>
>>Sounds like a plan, I'll try to come up with the test results
>>(at least for Windows 10 guest which is  what I have setup) and update
>>this thread with the results.
>>
>>-- Jon.
>>
>>>>
>>>>>>
>>>>>>Paolo
>>>>>>
>>>>>
>>>>
>>>
>Hi guys,
>
>Sorry for the delay...
>
>So first ill clarify what was the test, the test was to see the device
>"Microsoft Hyper-V Virtual Machine Bus" in Windows Device Manager under
>"System devices" with a state of "working properly".
>
>It seems like it's ok to drop all the _PS* and _STA.
>
>It seems to be functioning with single IRQ as well, it is worth noting 
>that even when i dropped the entire _CRS (so no IRQs resources are 
>required, the device was still showing that it's functioning, but I 
>suspect this might affect the child devices like hv-net and hv-scsi).
>
>With that said I did run into a small issue I set-up Win10 1903 (aka 
>19H1) and it seems like VMBus now requires to have the following 
>features enabled:
>HV_VP_RUNTIME_AVAILABLE
>HV_TIME_REF_COUNT_AVAILABLE
>HV_SYNIC_AVAILABLE
>HV_SYNTIMERS_AVAILABLE
>HV_APIC_ACCESS_AVAILABLE
>HV_HYPERCALL_AVAILABLE
>HV_VP_INDEX_AVAILABLE
>
>So notice that previously only SYNIC and VPINDEX was needed, now you 
>need the whole thing so you need to run qemu with something like
>-cpu host,hv-relaxed,hv_spinlocks=0x1fff,hv_time,hv-vapic,hv-vpindex,hv-synic,hv-runtime,hv-stimer
>
>The validation was done in winhv!WinHvpCheckPartitionPrivileges .
>
>Paolo I noticed you have done a PULL request, would you like to wait 
>on it and we will submit a version with a single IRQ (selectable by 
>user property) and go with Igor's suggestion dropping _PS* and _STA 
>(though like I said before I prefer to mimic the original HyperV with 
>it's bugs, but I'll leave this decision to you).
>
>Also today VMBus only verifies SYNIC is enabled I'm not sure how but I 
>wonder if we want to some how exports from the CPU which other HV 
>features are enabled so we can verify all the required ones are set, 
>would appreciate if you have any suggestions here.
>
>Cheers,
>-- Jon.

I got the latest DSDT from one of the latest builds 19041

     Device (\_SB.VMOD.VMBS)
     {
         Name (STA, 0x0F)
         Name (_ADR, Zero)  // _ADR: Address
         Name (_DDN, "VMBUS")  // _DDN: DOS Device Name
         Name (_HID, "VMBus")  // _HID: Hardware ID
         Name (_UID, Zero)  // _UID: Unique ID
         Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
         {
             STA &= 0x0D
         }

         Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
         {
             STA |= 0x0F
         }

         Method (_STA, 0, NotSerialized)  // _STA: Status
         {
             Return (STA) /* \_SB_.VMOD.VMBS.STA_ */
         }

         Name (_PS3, Zero)  // _PS3: Power State 3
         Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
         {
             IRQ (Edge, ActiveHigh, Exclusive, )
                 {5}
         })
     }

So things looks the same...

