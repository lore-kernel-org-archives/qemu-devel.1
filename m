Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F12FC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 00:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECED2087B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 00:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECED2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLd7x-00066n-SS
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 20:29:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hLd79-0005ly-Qq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 20:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hLd76-0006to-PP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 20:28:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hLd76-0006tP-G6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 20:28:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A4E15D60F
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 00:28:43 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7785C6DA84;
	Wed,  1 May 2019 00:28:38 +0000 (UTC)
Date: Tue, 30 Apr 2019 18:28:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190430182837.5af22e13@x1.home>
In-Reply-To: <9de36ff8-78ec-8cb0-6c23-4c8ecc1efad9@redhat.com>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
	<20190426132744.2b594bf5@x1.home> <20190426150236.1af2ff08@x1.home>
	<94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
	<daded638-42f1-9bc3-8c36-66b0fbba9438@redhat.com>
	<20190429082106.4fd59e77@x1.home> <20190430170149.6c82398a@x1.home>
	<9de36ff8-78ec-8cb0-6c23-4c8ecc1efad9@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 01 May 2019 00:28:43 +0000 (UTC)
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S .
	Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Peter Xu <peterx@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501002837.7HiuE92BKWt7MtqLUyrE04m343WG6WRzS_-5dt7RYDc@z>

On Wed, 1 May 2019 01:09:48 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 01/05/19 01:01, Alex Williamson wrote:
> > Poking at this a bit, we can add kvm_irqchip_is_split() to the set of
> > things we test for in hw/vfio/pci.c:vfio_intx_enable_kvm() to avoid the
> > KVM INTx bypass when using split IRQ chip.  
> 
> Yes, this should be enough.
> 
> > The only way I can get the GPU/Windows configuration usable is to
> > assert the IRQ, immediately de-assert, and unmask the device all from
> > vfio_intx_interrupt().  An interrupt intensive graphics benchmark runs
> > at ~80% of KVM irqchip with about 10% more CPU load with this
> > experiment (but it actually runs!).  
> 
> Nice.  If you can do it directly from hw/vfio there may be no need to do
> more changes to the IOAPIC, and least not immediately.  But that is not
> a good emulation of INTX, isn't it?  IIUC, it relies on the
> level-triggered interrupt never being masked in the IOAPIC.

Yeah, that's the problem, well one of the problems in addition to the
lower performance and increased overhead, is that it's a rather poor
emulation of INTx.  It matches pci_irq_pulse(), which has been
discouraged from use.  Anything but kernel irqchip makes me nervous for
INTx, but emulating it with a different physical IRQ type definitely
more so.

> > Any other insights appreciated, and I really would like to understand
> > what we've gained with split irqchip and whether it's worth this.  
> 
> We've gained guest interrupt remapping support, we are not relying on
> newer kernel versions, and the attack surface from the guest to the
> hypervisor is smaller.

Interrupt remapping is really only necessary with high vCPU counts or
maybe nested device assignment, seems doubtful that has a larger user
base.  I did re-watch the video of Steve Rutherford's talk from a
couple years ago, but he does re-iterate that pulling the ioapic from
KVM does have drawbacks for general purpose VMs that I thought would
have precluded it from becoming the default for the base QEMU machine
type.  Getting a GeForce card to run with MSI requires (repeated)
regedit'ing on Windows or module options on Linux.  The audio device
can require the same, otherwise we're probably mostly looking at old
devices assigned for compatibility using INTx, NICs or USB devices
would of course more likely use MSI/X for anything reasonably modern.
Thanks,

Alex

