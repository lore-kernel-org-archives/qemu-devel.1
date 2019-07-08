Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855C2C606A1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5490F20656
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5490F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkQGZ-0003BZ-AX
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 05:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52284)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hkQFk-0002mV-HA
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hkQFj-0006Mn-9x
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hkQFj-0006LN-4I
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:48:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 93DF130860B5;
 Mon,  8 Jul 2019 09:47:55 +0000 (UTC)
Received: from work-vm (ovpn-117-74.ams2.redhat.com [10.36.117.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 262511837B;
 Mon,  8 Jul 2019 09:47:52 +0000 (UTC)
Date: Mon, 8 Jul 2019 10:47:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: longpeng <longpeng2@huawei.com>
Message-ID: <20190708094750.GE2746@work-vm>
References: <785B5B0623C08241B2D0E6E7D8FA6B181E0A8FFF@DGGEMM506-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785B5B0623C08241B2D0E6E7D8FA6B181E0A8FFF@DGGEMM506-MBX.china.huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 08 Jul 2019 09:48:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [BUG] VM abort after migration
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
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "v.maffione@gmail.com" <v.maffione@gmail.com>,
 "quintela@redhat.com" <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* longpeng (longpeng2@huawei.com) wrote:
> Hi guys,
> 
> We found a qemu core in our testing environment, the assertion
> 'assert(bus->irq_count[i] == 0)' in pcibus_reset() was triggered and
> the bus->irq_count[i] is '-1'.
> 
> Through analysis, it was happened after VM migration and we think
> it was caused by the following sequence:
> 
> *Migration Source*
> 1. save bus pci.0 state, including irq_count[x] ( =0 , old )
> 2. save E1000:
>    e1000_pre_save
>     e1000_mit_timer
>      set_interrupt_cause
>       pci_set_irq --> update pci_dev->irq_state to 1 and
>                   update bus->irq_count[x] to 1 ( new )
>     the irq_state sent to dest.
> 
> *Migration Dest*
> 1. Receive the irq_count[x] of pci.0 is 0 , but the irq_state of e1000 is 1.
> 2. If the e1000 need change irqline , it would call to pci_irq_handler(),
>   the irq_state maybe change to 0 and bus->irq_count[x] will become
>   -1 in this situation.
> 3. do VM reboot then the assertion will be triggered.
> 
> We also found some guys faced the similar problem:
> [1] https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02525.html
> [2] https://bugs.launchpad.net/qemu/+bug/1702621
> 
> Is there some patches to fix this problem ?

I don't remember any.

> Can we save pcibus state after all the pci devs are saved ?

Does this problem only happen with e1000? I think so.
If it's only e1000 I think we should fix it - I think once the VM is
stopped for doing the device migration it shouldn't be raising
interrupts.

Dave

> Thanks,
> Longpeng(Mike)
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

