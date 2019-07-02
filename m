Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B946C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D222063F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D222063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFrS-0007dq-4q
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45266)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hiFq5-0006l8-IC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hiFq4-00033N-I5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:16:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28885)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hiFq4-00031y-6b
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:16:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B50653087955;
 Tue,  2 Jul 2019 10:16:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com
 [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0159179CB;
 Tue,  2 Jul 2019 10:16:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DBC9911AB5; Tue,  2 Jul 2019 12:16:25 +0200 (CEST)
Date: Tue, 2 Jul 2019 12:16:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190702101625.trsg5dnnf2a4woqs@sirius.home.kraxel.org>
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081733.ff6cboiddln5wmti@sirius.home.kraxel.org>
 <878stgygiu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878stgygiu.fsf@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 02 Jul 2019 10:16:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm
 machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > Can we get rid of the kernel command line hacking please?
> > The virtio-mmio devices should be discoverable somehow.
> >
> > Device tree (as suggested by paolo) would work.
> > Custom acpi device (simliar to fw_cfg) is another option.
> > I'd tend to pick acpi, I wouldn't be surprised if we'll
> > need acpi anyway at some point.
> >
> > Maybe even do both, then switch at runtime depending on -no-acpi
> > (simliar to arm/aarch64).
> 
> Microvm tries to do things in the cheapest possible way.

But taking too many shortcuts tends to hurt in the long run.
It also cuts off useful use cases.

I think microvm has more value than just the reduced boot time.
Specifically the reduced attack surface is useful I think, even
beyond container-style workloads.  Being able to boot standard
cloud images (with the cloud image kernel loaded via cloud image
boot loader) in microvm would be useful for example.

So, yes, I want microvm being designed in a way that it can run
firmware and have it handle the boot process.  For starters just
qboot for fast direct kernel boot, but longer term also seabios
and/or ovmf.

Can look at the seabios side, but probably not before I'm back
from my summer vacation in august.  For seabios a simple & reliable
time source would be quite useful.  Direct kernel boot might be doable
without that, but as soon as any I/O (read from cloud image disk) is
involved a time source is needed.  Right now seabios uses the acpi
pm_timer.  tsc should work too if seabios can figure the frequency
without a calibration loop (invtsc should be enough).  Maybe seabios
needs kvmclock support ...

Is there any way to detect microvm from the guest?  pc/q35 can be
easily detected by looking at the pci host bridge.

Do you have boot time numbers for qboot vs. no-firmware boot?
Is the difference big enough that it makes sense to maintain both?

cheers,
  Gerd


