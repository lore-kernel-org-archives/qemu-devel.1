Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF8C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3438A21929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3438A21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAucr-0003ui-HX
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iAuY1-0005rL-Ii
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iAuO0-0003eu-Vw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:14:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48438)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iAuO0-0003e9-OI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:14:08 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3BCB7C04B940
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 11:14:07 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id l6so906691wrn.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 04:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ksW9OAKIwlqoKZgEZg5+dj3rDJ+7uCseXlk3mec/F8A=;
 b=Mqk2kIZs+3SCRU2K3PwCGgiV935jAR15ZUKrWQS1n7Cu/0gReYcsMiiO+PaZg1cU8R
 vsM7td47DqJnXITh2E5x9CMXP8PHwi03zLN/rj/9swrhO4V8Hn3V7gz7gxXS7RfOz/eK
 dxl2jMX3ia+71GY4qOyo2UbxGU26kcX5iZd96Z3mMEgtTRcG19KcNvFqhgJXx2co+KDd
 1J/KpIiBo8ddwXBxrrjUV3KH35EUZp23hjxXdUP6UETdZEjissT1mrdM0XBSiT0xFBSL
 GI8l0mEDQI+WA38ADZo/b7AcOdzJLq2a8TRZlX0RP8DPur57KomsDmLjuaRF2YjYGp3q
 Z7Pg==
X-Gm-Message-State: APjAAAUpaCMMFmWVXAQynU1oK4FNp0M6o1PKmHGSLHjPHLhZo0Lb/d6N
 FQt28/FV6lmfS1YCCqQqMgP6o9NU6ObllWClV4YMJNZPHBMb0/jsKBuD8LZWCY/cA3z6PdAQYa4
 RDmAdUvNfFBVd4Oc=
X-Received: by 2002:adf:de03:: with SMTP id b3mr6316916wrm.14.1568891645650;
 Thu, 19 Sep 2019 04:14:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwXrYCumNAY0fVfgMJAEcbTYIyAAwlm5LqPAfabqrxFAUQpT/zfdctgCljn6ro/hRe3goQXCA==
X-Received: by 2002:adf:de03:: with SMTP id b3mr6316900wrm.14.1568891645403;
 Thu, 19 Sep 2019 04:14:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id c132sm7555037wme.27.2019.09.19.04.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 04:14:04 -0700 (PDT)
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Wang <jasowang@redhat.com>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <8302a4ae-1914-3046-b3b5-b3234d7dda02@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B1D1@SHSMSX104.ccr.corp.intel.com>
 <6d73572e-1e89-b04a-bdd6-98ac73798083@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B90C@SHSMSX104.ccr.corp.intel.com>
 <204219fa-ee72-ca60-52a4-fb4bbc887773@redhat.com>
 <20190919052819.GA18391@joy-OptiPlex-7040>
 <7b6d6343-33de-ebd7-9846-af54a45a82a2@redhat.com>
 <20190919061756.GB18391@joy-OptiPlex-7040>
 <e0efbdc0-aad9-0d17-ec68-36460865501f@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57DD2A@SHSMSX104.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1ec55b2e-6a59-f1df-0604-5b524da0f001@redhat.com>
Date: Thu, 19 Sep 2019 13:14:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D57DD2A@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
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
Cc: 'Alex Williamson' <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/19 09:16, Tian, Kevin wrote:
>>> why GPA1 and GPA2 should be both dirty?
>>> even they have the same HVA due to overlaping virtual address space in
>>> two processes, they still correspond to two physical pages.
>>> don't get what's your meaning :)
>>
>> The point is not leave any corner case that is hard to debug or fix in
>> the future.
>>
>> Let's just start by a single process, the API allows userspace to maps
>> HVA to both GPA1 and GPA2. Since it knows GPA1 and GPA2 are equivalent,
>> it's ok to sync just through GPA1. That means if you only log GPA2, it
>> won't work.
> 
> I noted KVM itself doesn't consider such situation (one HVA is mapped
> to multiple GPAs), when doing its dirty page tracking. If you look at
> kvm_vcpu_mark_page_dirty, it simply finds the unique memslot which
> contains the dirty gfn and then set the dirty bit within that slot. It
> doesn't attempt to walk all memslots to find out any other GPA which
> may be mapped to the same HVA. 
> 
> So there must be some disconnect here. let's hear from Paolo first and
> understand the rationale behind such situation.

In general, userspace cannot assume that it's okay to sync just through
GPA1.  It must sync the host page if *either* GPA1 or GPA2 are marked dirty.

The situation really only arises in special cases.  For example,
0xfffe0000..0xffffffff and 0xe0000..0xfffff might be the same memory.
From "info mtree" before the guest boots:

    0000000000000000-ffffffffffffffff (prio -1, i/o): pci
      00000000000e0000-00000000000fffff (prio 1, i/o): alias isa-bios
@pc.bios 0000000000020000-000000000003ffff
      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios

However, non-x86 machines may have other cases of aliased memory so it's
a case that you should cover.

Paolo

