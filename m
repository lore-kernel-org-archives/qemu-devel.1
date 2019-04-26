Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F25BC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 19:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C7F206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 19:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C7F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK6WX-0004bc-6J
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 15:28:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hK6Vl-00047w-20
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 15:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hK6Vk-00063E-0L
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 15:27:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hK6Vj-000626-Ow
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 15:27:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AA1F76548
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 19:27:49 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D630E5D70A;
	Fri, 26 Apr 2019 19:27:44 +0000 (UTC)
Date: Fri, 26 Apr 2019 13:27:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190426132744.2b594bf5@x1.home>
In-Reply-To: <20181220054037.24320-2-peterx@redhat.com>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Fri, 26 Apr 2019 19:27:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] q35: set split kernel irqchip as
 default
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426192744.JB3UZiOTdeH8_s0PGSGTtjmti5SvfR_wgqlGoBN7jIw@z>

On Thu, 20 Dec 2018 13:40:35 +0800
Peter Xu <peterx@redhat.com> wrote:

> Starting from QEMU 4.0, let's specify "split" as the default value for
> kernel-irqchip.
> 
> So for QEMU>=4.0 we'll have: allowed=Y,required=N,split=Y
>    for QEMU<=3.1 we'll have: allowed=Y,required=N,split=N
>    (omitting all the "kernel_irqchip_" prefix)
> 
> Note that this will let the default q35 machine type to depend on
> Linux version 4.4 or newer because that's where split irqchip is
> introduced in kernel.  But it's fine since we're boosting supported
> Linux version for QEMU 4.0 to around Linux 4.5.  For more information
> please refer to the discussion on AMD's RDTSCP:
> 
>   https://lore.kernel.org/lkml/20181210181328.GA762@zn.tnic/

It looks like this broke INTx for vfio-pci, see:

https://bugs.launchpad.net/qemu/+bug/1826422

In my testing it looks like KVM advertises supporting the KVM_IRQFD
resample feature, but vfio never gets the unmask notification, so the
device remains with DisINTx set and no further interrupts are
generated.  Do we expect KVM's IRQFD with resampler to work in the
split IRQ mode?  We can certainly hope that "high performance" devices
use MSI or MSI/X, but this would be quite a performance regression with
split mode if our userspace bypass for INTx goes away.  Thanks,

Alex

PS - the least impact workaround for users is to re-enable kernel mode
irqchip with kernel_irqchip=on or <ioapic driver='kvm'/>.  We can also
force QEMU routing of INTx with the x-no-kvm-intx=on option per
vfio-pci device, but this disables the userspace bypass and brings
along higher interrupt latency and overhead.

