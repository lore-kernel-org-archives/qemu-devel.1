Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89418C28CBC
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 03:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C081207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 03:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv3PZdZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C081207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWX0T-00014p-Cp
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 23:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jWWzZ-0000b1-Pg
 for qemu-devel@nongnu.org; Wed, 06 May 2020 23:14:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jWWzW-0002yi-Ba
 for qemu-devel@nongnu.org; Wed, 06 May 2020 23:14:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id l18so4514624wrn.6
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 20:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=bCWuH6dn8NIgDvI7lhZSiBDzT3+RpLJ+uPe3dKAA7IY=;
 b=Mv3PZdZ3dOaWNpESk/mTc/1epgKxq7/YMdBj9qTHrYBVHlExSuhNtD4EkK+7xbuPRC
 jOp/0JBAAjUxkD59UPCTU75iAQKQ9WLkNBDdWA46Hu/tI8Etyue2qXPzS2zek4kou9do
 hy8pfHCdeS6DNudMRmUnLJOrrjBfec2BjvXvDuGLneAC1F8vYG+2F1xDLjzKjuDnSjkz
 QSQDp88fPs1BYYxOd+gQjTRDr2sMpv0iasGAa4oZJr1iH/vdfINFT4rkkIGg2bsA+2MK
 C+jjl4eB0+ViTkbS8aGsagVRS5xMmqEZLryh/dhzQ/wJdKdRYx/Z74Nodha1q4tygwB8
 DI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bCWuH6dn8NIgDvI7lhZSiBDzT3+RpLJ+uPe3dKAA7IY=;
 b=Ft/vDWFsJvcdBoQ/IkoSRlkQWpNbpS6PsJwexr+/TM5lKNPWAR6hxWECm1pPhbrT8H
 RhyvE1kugwuMfjFR2NsGfabK1tb7D6RMKegMI5co4bZRttvPxpGrp0J5g4O4e8vxVCro
 /S0Rfp1exurdBnw85GywTUfysVuhKCAi/pJO866h2TAfWSFDhYn+Rtl9wSe8Ut0p7NRJ
 tO8l74w4+1WJHCUJlNjSyWXpCAA/bP+e5oLV7dJ1v/fTB7f3zXYF3lwj8znuVhpCc9Xe
 6eoIGACoHTfqJ4kGRkD3ghU5Hc9DmsAWAuvMhLvbmdxe/NfAqHo/e+YzsaVXIUnx6/6O
 jV6g==
X-Gm-Message-State: AGi0PuZBLP4zjZ3lK05bDXHXlrpOxysTrusjrV/YgZBg6tIPtXMEmLFk
 UMfPeBs0aognJp52YRu/bCc=
X-Google-Smtp-Source: APiQypLzxJqVrmF6ZIMm2TALvLpSiNPMicRn1+6IRMmNkU+K6t0gMJGOpdbyS4FGWhjqlxibHhVbuQ==
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr5931413wrs.279.1588821267371; 
 Wed, 06 May 2020 20:14:27 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id l17sm5527720wrv.80.2020.05.06.20.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 20:14:26 -0700 (PDT)
Date: Thu, 7 May 2020 06:14:25 +0300
From: Jon Doron <arilou@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200507031425.GG2862@jondnuc>
References: <20200424123444.3481728-1-arilou@gmail.com>
 <20200424123444.3481728-6-arilou@gmail.com>
 <20200505150637.7131e79b@redhat.com>
 <20200505153838.GC2862@jondnuc>
 <30fea22b-ef36-04d9-17ef-d13e3f93a3c5@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30fea22b-ef36-04d9-17ef-d13e3f93a3c5@maciej.szmigiero.name>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=arilou@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: eyakovlev@virtuozzo.com, ehabkost@redhat.com, rvkagan@gmail.com,
 qemu-devel@nongnu.org, liran.alon@oracle.com,
 Roman Kagan <rkagan@virtuozzo.com>, pbonzini@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you Maciej :)

Igor it seems like the IRQ being used is 5 and not 7 & 13 like in the 
current patch. Seems like it needs to reside in the _CRS like you said.

Seems like it has all those _STA/_DIS/_PS0 just like the way it's 
currently in the patch (unless I'm missing something).

Notice _PS3 is not a Method.

So just to summarize the changes i need to do:
1. Change from 2 IRQs to single one (and use 5 as the default)
2. IRQs needs to be under _CRS.
3. You mentioned you want under a different location than the ISA bug 
where would you want it to be?

Please let me know if there is anything else.

Thanks,
-- Jon.

On 06/05/2020, Maciej S. Szmigiero wrote:
>On 05.05.2020 17:38, Jon Doron wrote:
>> On 05/05/2020, Igor Mammedov wrote:
>>
>> I dont know what were the original intentions of the original patch authors (at this point I simply rebased it, and to be honest I did not need this patch to get where I was going to, but it was part of the original patchset).
>>
>> But I'm willing to do any changes so we can keep going forward with this.
>>
>>> On Fri, 24 Apr 2020 15:34:43 +0300
>>> Jon Doron <arilou@gmail.com> wrote:
>>>
>>>> Guest OS uses ACPI to discover VMBus presence.  Add a corresponding
>>>> entry to DSDT in case VMBus has been enabled.
>>>>
>>>> Experimentally Windows guests were found to require this entry to
>>>> include two IRQ resources. They seem to never be used but they still
>>>> have to be there.
>>>>
>>>> Make IRQ numbers user-configurable via corresponding properties; use 7
>>>> and 13 by default.
>>> well, it seems that at least linux guest driver uses one IRQ,
>>> abeit not from ACPI descriptior
>>>
>>> perhaps it's what hyperv host puts into _CRS.
>>> Could you dump ACPI tables and check how hyperv describes vmbus in acpi?
>>>
>>>
>>
>> I can no longer get to the HyperV computer I had (in the office so hopefully if someone else has access to HyperV machine and willing to reply here with the dumped ACPI tables that would be great).
>>
>
>Here is a VMBus ACPI device description from Hyper-V in Windows Server 2019:
>
>Device (\_SB.VMOD.VMBS)
>{
>    Name (STA, 0x0F)
>    Name (_ADR, Zero)  // _ADR: Address
>    Name (_DDN, "VMBUS")  // _DDN: DOS Device Name
>    Name (_HID, "VMBus")  // _HID: Hardware ID
>    Name (_UID, Zero)  // _UID: Unique ID
>    Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
>    {
>	STA &= 0x0D
>    }
>
>    Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
>    {
>	STA |= 0x0F
>    }
>
>    Method (_STA, 0, NotSerialized)  // _STA: Status
>    {
>	Return (STA) /* \_SB_.VMOD.VMBS.STA_ */
>    }
>
>    Name (_PS3, Zero)  // _PS3: Power State 3
>    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>    {
>	IRQ (Edge, ActiveHigh, Exclusive, )
>	    {5}
>    })
>}
>
>It seems to use just IRQ 5.
>
>Maciej

