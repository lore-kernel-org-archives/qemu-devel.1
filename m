Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1D8C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 06:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C1E2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 06:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C1E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0gRm-0004Jz-Eb
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 02:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0gQg-0003UO-Dw
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0gQe-00087x-Nb
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0gQe-00086K-69
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:18:36 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8615B3D94D
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 06:18:34 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id b135so1639394wmg.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 23:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iiBEH8fXUbhWBIB4wbYVRRr/TM6QjP1OwASK7bN4h0Q=;
 b=AGH6eKEFxBZY9S/7Y7tLg6AMiPO1a6dp4HivAs8MCCe8/NuQLnga1E+HNLAYfWRsnl
 MLQv5Rb6K8vs0HoH+bgTQhv9TZ2BYyohFYqp7FH7uVrGTbQaCZld99P3bHwR0BfViM2+
 F2FUWtLBV/nitWjOlEUuFEEUaorGv3jh1fx2lVrK7p7sPn9bJ26k5nks+sT8J+Lx4rZK
 hdE56YGKtI210QRhrXnsjUsRLZrub8A/hO3Didrz3YeIuRbePIkIy+t2RdfmOvrI9kNB
 Ga9Qs58GVHcLMkHcCq1i7+joeOr1vT/4VOAkj+w/sH/HA6lRnoBVrMvGRlgl/029K04Z
 FC0A==
X-Gm-Message-State: APjAAAXO3JgGD5ID1qtLpmXNkW5iWn0HGBd9O74HI4omn5S4bRr8SNuK
 YN3R8S/EjFetv+wRr3RXsy8rOyqan5do49B1G6lJp2VLT2GQaHPA15mIUH67L7Hp2ndkvq/5AGB
 GMHCLdQVfwxeMZV0=
X-Received: by 2002:adf:f851:: with SMTP id d17mr17409282wrq.77.1566454713223; 
 Wed, 21 Aug 2019 23:18:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzG1lOk+FLkDtdneMHPZRxRAGC20uZGPXtwxtDRUpjMAuYdrTgBUAcoPtH0Oq6hzwejRDZnwg==
X-Received: by 2002:adf:f851:: with SMTP id d17mr17409267wrq.77.1566454712945; 
 Wed, 21 Aug 2019 23:18:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id b3sm43343624wrm.72.2019.08.21.23.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 23:18:32 -0700 (PDT)
To: "Kinney, Michael D" <michael.d.kinney@intel.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>, "Yao, Jiewen"
 <jiewen.yao@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
 <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
 <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
 <20190816161933.7d30a881@x1.home>
 <74D8A39837DF1E4DA445A8C0B3885C503F761B96@shsmsx102.ccr.corp.intel.com>
 <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
 <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9C671@ORSMSX113.amr.corp.intel.com>
 <a76014e2-2f0a-afce-6d15-1c45c5c1e467@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9D74A@ORSMSX113.amr.corp.intel.com>
 <adf3f3b8-1dc9-79e1-7411-4d9131657a1f@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9E82C@ORSMSX113.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <772d64f7-e153-e9e6-dd69-9f34de5bb577@redhat.com>
Date: Thu, 22 Aug 2019 08:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <E92EE9817A31E24EB0585FDF735412F5B9D9E82C@ORSMSX113.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [edk2-rfc] [edk2-devel] CPU hotplug using SMM with
 QEMU+OVMF
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
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Laszlo Ersek <lersek@redhat.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/19 22:17, Kinney, Michael D wrote:
> Paolo,
> 
> It makes sense to match real HW.

Note that it'd also be fine to match some kind of official Intel
specification even if no processor (currently?) supports it.

> That puts us back to
> the reset vector and handling the initial SMI at
> 3000:8000.  That is all workable from a FW implementation
> perspective.  It look like the only issue left is DMA.
> 
> DMA protection of memory ranges is a chipset feature.
> For the current QEMU implementation, what ranges of
> memory are guaranteed to be protected from DMA?  Is
> it only A/B seg and TSEG?

Yes.

Paolo

>> Yes, all of these would work.  Again, I'm interested in
>> having something that has a hope of being implemented in
>> real hardware.
>>
>> Another, far easier to implement possibility could be a
>> lockable MSR (could be the existing
>> MSR_SMM_FEATURE_CONTROL) that allows programming the
>> SMBASE outside SMM.  It would be nice if such a bit
>> could be defined by Intel.
>>
>> Paolo


