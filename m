Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B38C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 12:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0A322CE3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 12:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0A322CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0PPr-0000Lf-7d
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 08:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1i0PP4-0008EV-NS
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1i0PP3-0006Tw-88
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:07:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1i0PP3-0006Sz-0S
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:07:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5705C195DCEA;
 Wed, 21 Aug 2019 12:07:47 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-79.ams2.redhat.com
 [10.36.117.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A02D194BE;
 Wed, 21 Aug 2019 12:07:42 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>, "Yao, Jiewen" <jiewen.yao@intel.com>
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
 <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
 <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
 <4afa24cb-1ab7-b085-ba84-70271712d62e@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ce883f0f-387a-2d7f-9446-dce2ee5d7993@redhat.com>
Date: Wed, 21 Aug 2019 14:07:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4afa24cb-1ab7-b085-ba84-70271712d62e@redhat.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Wed, 21 Aug 2019 12:07:47 +0000 (UTC)
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
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/19/19 16:10, Paolo Bonzini wrote:
> On 19/08/19 01:00, Yao, Jiewen wrote:
>> in real world, we deprecate AB-seg usage because they are vulnerable
>> to smm cache poison attack. I assume cache poison is out of scope in
>> the virtual world, or there is a way to prevent ABseg cache poison.
> 
> Indeed the SMRR would not cover the A-seg on real hardware.  However, if
> the chipset allowed aliasing A-seg SMRAM to 0x30000, it would only be
> used for SMBASE relocation of hotplugged CPU.  The firmware would still
> keep low SMRAM disabled, *except around SMBASE relocation of hotplugged
> CPUs*.  To avoid cache poisoning attacks, you only have to issue a
> WBINVD before enabling low SMRAM and before disabling it.  Hotplug SMI
> is not a performance-sensitive path, so it's not a big deal.
> 
> So I guess you agree that PCI DMA attacks are a potential vector also on
> real hardware.  As Alex pointed out, VT-d is not a solution because
> there could be legitimate DMA happening during CPU hotplug.

Alex, thank you for the help! Please let us know if we should remove you
from the CC list, in order not to clutter your inbox. (I've kept your
address for now, for saying thanks. Feel free to stop reading here. Thanks!)

> For OVMF
> we'll probably go with Igor's idea, it would be nice if Intel chipsets
> supported it too. :)

So what is Igor's idea? Please do spoon-feed it to me. I've seen the POC
patch but the memory region manipulation isn't obvious to me.

Regarding TSEG, QEMU doesn't implement it differently from normal RAM.
Instead, if memory serves, there is an extra "black hole" region that is
overlaid, which hides the RAM contents when TSEG is supposed to be
closed (and the guest is not running in SMM).

But this time we're doing something else, right? Is the idea to overlay
the RAM range at 0x30000 with a window (alias) into the "compatible"
SMRAM at 0xA0000-0xBFFFF?

I don't know how the "compatible" SMRAM is implemented in QEMU. Does the
compatible SMRAM behave in sync with TSEG? OVMF doesn't configure or
touch compatible SMRAM at all, at the moment.

Thanks
Laszlo

