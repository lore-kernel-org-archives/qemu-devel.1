Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4036AC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1532E2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1532E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIZb-0006q9-58
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hyIYe-00069A-4O
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hyIYa-0005wM-9V
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:25:00 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hyIYa-0005wF-3V
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:24:56 -0400
Received: by mail-wr1-f54.google.com with SMTP id p17so2706375wrf.11
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 09:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bsE7YcO/81SljH9WTYeio0bxXW8xTJPwHm72S2QtOGY=;
 b=KcaQya/iHhTadI2UVbYp2+2HyMiS4v0K7c/1Kd5CaLqS+DHHvQtlHsmccFRkhvGURh
 eDoVN7psIgTB9XCM22sQ2Kyaq0kJTDO93HvDKZKHGMm5JfZ+M4yTO0W6kvEtnQCsg3Et
 QQoBkQPfs43CpjDKBSqc2NymSJUXUlxsCTlvXG1T9Nq1FA2XPt8W9PNPPYbszQOgjNPb
 Bzf/BQBmS8apYR4tRJqeyNDXClRUZg1sl9DuL9o1LrDzt/J+Z4vRNC8KCMiOAzDm51lt
 6o7Y9iuISUAdunIX3wNBQa5NyE53mtg5EfdbwfWHTPSwK83D/EDQX4zpfVBeUQSXiOVJ
 KMXA==
X-Gm-Message-State: APjAAAW+mKnoHe2dhH0/JQ9jiaJAtNzwT/EiJDy/pv4e5M3oN0wZokFm
 miXrftznfSM9pVf98QX/TQNIsg==
X-Google-Smtp-Source: APXvYqzIQ/J8tOj6X0wcB5Zval1alav7h8wrK4DgRqkn8QYVPGirAPFhAD/pqMb1lPDqVXzaGtmgcg==
X-Received: by 2002:a5d:678a:: with SMTP id v10mr6123660wru.116.1565886295041; 
 Thu, 15 Aug 2019 09:24:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cae:66cd:dd43:92d9?
 ([2001:b07:6468:f312:2cae:66cd:dd43:92d9])
 by smtp.gmail.com with ESMTPSA id e4sm5452409wrh.39.2019.08.15.09.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2019 09:24:54 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <20190815180733.4b396b5d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f6c58790-7298-d991-844e-48f4a9dc8937@redhat.com>
Date: Thu, 15 Aug 2019 18:24:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815180733.4b396b5d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.54
Subject: Re: [Qemu-devel] CPU hotplug using SMM with QEMU+OVMF
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
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Nakajima, Jun" <jun.nakajima@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>, Laszlo Ersek <lersek@redhat.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/08/19 18:07, Igor Mammedov wrote:
> Looking at Q35 code and Seabios SMM relocation as example, if I see it
> right QEMU has:
>     - SMRAM is aliased from DRAM at 0xa0000
>     - and TSEG steals from the top of low RAM when configured
> 
> Now problem is that default SMBASE at 0x30000 isn't backed by anything
> in SMRAM address space and default SMI entry falls-through to the same
> location in System address space.
> 
> The later is not trusted and entry into SMM mode will corrupt area + might
> jump to 'random' SMI handler (hence save/restore code in Seabios).
> 
> Here is an idea, can we map a memory region at 0x30000 in SMRAM address
> space with relocation space/code reserved. It could be a part of TSEG
> (so we don't have to invent ABI to configure that)?

No, there could be real mode code using it.  What we _could_ do is
initialize SMBASE to 0xa0000, but I think it's better to not deviate too
much from processor behavior (even if it's admittedly a 20-years legacy
that doesn't make any sense).

Paolo

