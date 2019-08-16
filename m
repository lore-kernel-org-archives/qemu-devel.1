Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC8BC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2616C206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2616C206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyXNH-0008L3-Rn
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 04:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1hyWsN-0000gY-NJ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hyWsM-00051V-7Z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:42:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hyWsL-00051H-VV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:42:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB3453090FD1;
 Fri, 16 Aug 2019 07:42:16 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFA0017493;
 Fri, 16 Aug 2019 07:42:14 +0000 (UTC)
Date: Fri, 16 Aug 2019 09:42:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190816094212.28184314@redhat.com>
In-Reply-To: <f6c58790-7298-d991-844e-48f4a9dc8937@redhat.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <20190815180733.4b396b5d@redhat.com>
 <f6c58790-7298-d991-844e-48f4a9dc8937@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 16 Aug 2019 07:42:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: "Chen,
 Yingwen" <yingwen.chen@intel.com>, edk2-devel-groups-io <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Nakajima, Jun" <jun.nakajima@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>, Laszlo Ersek <lersek@redhat.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Aug 2019 18:24:53 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 15/08/19 18:07, Igor Mammedov wrote:
> > Looking at Q35 code and Seabios SMM relocation as example, if I see it
> > right QEMU has:
> >     - SMRAM is aliased from DRAM at 0xa0000
> >     - and TSEG steals from the top of low RAM when configured
> > 
> > Now problem is that default SMBASE at 0x30000 isn't backed by anything
> > in SMRAM address space and default SMI entry falls-through to the same
> > location in System address space.
> > 
> > The later is not trusted and entry into SMM mode will corrupt area + might
> > jump to 'random' SMI handler (hence save/restore code in Seabios).
> > 
> > Here is an idea, can we map a memory region at 0x30000 in SMRAM address
> > space with relocation space/code reserved. It could be a part of TSEG
> > (so we don't have to invent ABI to configure that)?  
> 
> No, there could be real mode code using it.

My impression was that QEMU/KVM's SMM address space is accessible only from
CPU in SMM mode, so SMM CPU should access in-depended SMRAM at 0x30000 in
SMM address space while not SMM CPUs (including real mode) should access
0x30000 from normal system RAM.


> What we _could_ do is
> initialize SMBASE to 0xa0000, but I think it's better to not deviate too
> much from processor behavior (even if it's admittedly a 20-years legacy
> that doesn't make any sense).

Agreed, it's better to follow spec, that's one of the reasons why I was toying
with idea of using separate SMRAM at 0x30000 mapped only in SMM address space.

Practically we would be following spec: SDM: 34.4 SMRAM
"
System logic can use the SMI acknowledge transaction or the assertion of the SMIACT# pin to decode accesses to
the SMRAM and redirect them (if desired) to specific SMRAM memory. If a separate RAM memory is used for
SMRAM, system logic should provide a programmable method of mapping the SMRAM into system memory space
when the processor is not in SMM. This mechanism will enable start-up procedures to initialize the SMRAM space
(that is, load the SMI handler) before executing the SMI handler during SMM.
"

Another benefit that gives us, is that we won't have to pull in
all existing CPUs into SMM (essentially another stop_machine) to
guarantee exclusive access to 0x30000 in normal RAM.

> 
> Paolo


