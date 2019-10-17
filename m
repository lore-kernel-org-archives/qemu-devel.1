Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF37AECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A589520820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A589520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL94S-0005RT-CI
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iL8Ts-0007OX-Hg
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iL8Tr-0003Or-JT
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:18:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iL8Tr-0003OX-EA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:18:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6CCF718CB915;
 Thu, 17 Oct 2019 16:18:26 +0000 (UTC)
Received: from [10.36.117.42] (ovpn-117-42.ams2.redhat.com [10.36.117.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 641445D9CA;
 Thu, 17 Oct 2019 16:18:23 +0000 (UTC)
Subject: Re: Default CPU models on s390x and ppc64
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191017151606.GA1880840@orkuz.int.mamuti.net>
 <82ea23ea-be23-c374-3f10-65d8f6e79432@redhat.com>
 <CAFEAcA-pkD_LCh++TWoO77=Bu9mYe7HOkaeyCXjLopAmqhpi-g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1feb4b48-a380-8c9e-561d-d62e8e45b3e8@redhat.com>
Date: Thu, 17 Oct 2019 18:18:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-pkD_LCh++TWoO77=Bu9mYe7HOkaeyCXjLopAmqhpi-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 17 Oct 2019 16:18:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: David Gibson <dgibson@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 David Hildenbrand <dhildenb@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17.10.19 18:13, Peter Maydell wrote:
> On Thu, 17 Oct 2019 at 17:09, David Hildenbrand <david@redhat.com> wrote:
>> The default model under KVM is "host", under TCG it's "qemu". We should
>> not use "qemu" under KVM, although it might work on some setups ...
> 
> Possibly a tangent, but on Arm the approach we used to deal
> with "'-cpu host' only works for kvm" was to define a "-cpu max"
> meaning "best thing you can give me", which is an alias for
> -cpu host with KVM and an alias for a CPU with all the extra
> features we have emulation support under TCG. Then users can
> use '-cpu max' and have something that generally will DTRT
> regardless of accelerator.
> 

We do have "-cpu max" on s390x as well. (under TCG, it enables some 
additional features over "qemu", under KVM it is basically "host).

-- 

Thanks,

David / dhildenb

