Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6F3C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA5521D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA5521D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwUU-0005gI-B1
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iAvsy-000702-Cz
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iAvis-0005KC-8i
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:39:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iAvis-0005IC-0x
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:39:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 878AF3082132;
 Thu, 19 Sep 2019 12:39:44 +0000 (UTC)
Received: from [10.72.12.81] (ovpn-12-81.pek2.redhat.com [10.72.12.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F7665C1B5;
 Thu, 19 Sep 2019 12:39:38 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
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
 <1ec55b2e-6a59-f1df-0604-5b524da0f001@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <00084b36-3281-7c8d-5057-427eaabfb174@redhat.com>
Date: Thu, 19 Sep 2019 20:39:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1ec55b2e-6a59-f1df-0604-5b524da0f001@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 19 Sep 2019 12:39:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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


On 2019/9/19 =E4=B8=8B=E5=8D=887:14, Paolo Bonzini wrote:
> On 19/09/19 09:16, Tian, Kevin wrote:
>>>> why GPA1 and GPA2 should be both dirty?
>>>> even they have the same HVA due to overlaping virtual address space =
in
>>>> two processes, they still correspond to two physical pages.
>>>> don't get what's your meaning :)
>>> The point is not leave any corner case that is hard to debug or fix i=
n
>>> the future.
>>>
>>> Let's just start by a single process, the API allows userspace to map=
s
>>> HVA to both GPA1 and GPA2. Since it knows GPA1 and GPA2 are equivalen=
t,
>>> it's ok to sync just through GPA1. That means if you only log GPA2, i=
t
>>> won't work.
>> I noted KVM itself doesn't consider such situation (one HVA is mapped
>> to multiple GPAs), when doing its dirty page tracking. If you look at
>> kvm_vcpu_mark_page_dirty, it simply finds the unique memslot which
>> contains the dirty gfn and then set the dirty bit within that slot. It
>> doesn't attempt to walk all memslots to find out any other GPA which
>> may be mapped to the same HVA.
>>
>> So there must be some disconnect here. let's hear from Paolo first and
>> understand the rationale behind such situation.
> In general, userspace cannot assume that it's okay to sync just through
> GPA1.  It must sync the host page if *either* GPA1 or GPA2 are marked d=
irty.


Maybe we need document this somewhere.


>
> The situation really only arises in special cases.  For example,
> 0xfffe0000..0xffffffff and 0xe0000..0xfffff might be the same memory.
>  From "info mtree" before the guest boots:
>
>      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>        00000000000e0000-00000000000fffff (prio 1, i/o): alias isa-bios
> @pc.bios 0000000000020000-000000000003ffff
>        00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>
> However, non-x86 machines may have other cases of aliased memory so it'=
s
> a case that you should cover.
>
> Paolo


Any other issue that still need to be covered consider userspace need to=20
sync both GPAs?

Thanks


