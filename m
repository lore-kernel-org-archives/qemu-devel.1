Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D5CC3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 19:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623B32187F
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 19:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623B32187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzRCy-0005FS-AD
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 15:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzRCK-0004pk-6O
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 15:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzRCI-00052n-Pl
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 15:50:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzRCI-00051t-I2
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 15:50:38 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5535013A82
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 19:50:35 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id b1so4108672wru.4
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 12:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Mh5AKIH4zN0R7HGXNBZ+G2Rv2NiToX+SVJ0buCWoJNM=;
 b=hMu7QM1R2Ztycapj1SyDrb7k2cpbrSfubxR8g+jJypsB7RmwVgNQtFCDYbbDueNKKb
 VErQ94To/7cOcywwIjVHIwan75mUqLHhIPzQmhLteO8RQ8gFwx8aEjs307zdbGQJkdre
 HDdIpyGLxz519mDfUqAXLebf3bTQjlBOrJgXcvCQp1l5HsNBxZuxKstXjaykpmL1u9Us
 JE6Y+QWdxs/w4uO8Y8tPkY2RFvvk8gKZpruG+Duka90Wnk0u0CUICGTtYo0YYbGdKEH5
 J76out5WQrlJIoKXAgMEdku0l5h7Sr+wqOSRuOvvv8GGgC6Fz8dBUKITZJ8L3fWwAB0D
 WkTA==
X-Gm-Message-State: APjAAAXF5zV7zR+qMUEhixc4nAieXRFfbhfTjO2hdKKFq/7G5KM6aRgv
 DDQB94rtg0Co+8PkuhDXJkaGphLRzaXACWRFfApiOW3BlB2XoMVFU0SsT2BDI3KJEkSc+//jOal
 v2niuOIVy5LF3WeA=
X-Received: by 2002:adf:8183:: with SMTP id 3mr22989258wra.181.1566157833887; 
 Sun, 18 Aug 2019 12:50:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtMq2H3ucS+0sYLAG/E4b176MxQE5gowHaNIBSOSmN50b0JZxa8/cvGkkEUZLLpkuPqDrKhA==
X-Received: by 2002:adf:8183:: with SMTP id 3mr22989244wra.181.1566157833577; 
 Sun, 18 Aug 2019 12:50:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399c:411e:1ccb:f240?
 ([2001:b07:6468:f312:399c:411e:1ccb:f240])
 by smtp.gmail.com with ESMTPSA id f10sm11547975wrm.31.2019.08.18.12.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2019 12:50:32 -0700 (PDT)
To: "Yao, Jiewen" <jiewen.yao@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
 <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
 <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
 <20190816161933.7d30a881@x1.home>
 <74D8A39837DF1E4DA445A8C0B3885C503F761B96@shsmsx102.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
Date: Sun, 18 Aug 2019 21:50:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <74D8A39837DF1E4DA445A8C0B3885C503F761B96@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/08/19 02:20, Yao, Jiewen wrote:
> [Jiewen] That is OK. Then we MUST add the third adversary.
> -- Adversary: Simple hardware attacker, who can use device to perform DMA attack in the virtual world.
> NOTE: The DMA attack in the real world is out of scope. That is be handled by IOMMU in the real world, such as VTd. -- Please do clarify if this is TRUE.
> 
> In the real world:
> #1: the SMM MUST be non-DMA capable region.
> #2: the MMIO MUST be non-DMA capable region.
> #3: the stolen memory MIGHT be DMA capable region or non-DMA capable
> region. It depends upon the silicon design.
> #4: the normal OS accessible memory - including ACPI reclaim, ACPI
> NVS, and reserved memory not included by #3 - MUST be DMA capable region.
> As such, IOMMU protection is NOT required for #1 and #2. IOMMU
> protection MIGHT be required for #3 and MUST be required for #4.
> I assume the virtual environment is designed in the same way. Please
> correct me if I am wrong.
> 

Correct.  The 0x30000...0x3ffff area is the only problematic one;
Igor's idea (or a variant, for example optionally remapping
0xa0000..0xaffff SMRAM to 0x30000) is becoming more and more attractive.

Paolo

