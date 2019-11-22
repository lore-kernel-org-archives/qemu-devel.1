Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B07C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 06:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75A12068E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 06:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75A12068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY290-0007T7-RO
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 01:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iY28K-0006yT-If
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 01:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iY28I-0000nC-4o
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 01:09:31 -0500
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:57217)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iY28H-0000lb-Uy
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 01:09:30 -0500
Received: from player789.ha.ovh.net (unknown [10.108.54.133])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 7160714C64D
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 07:09:27 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id C68B9C5C89B7;
 Fri, 22 Nov 2019 06:09:14 +0000 (UTC)
Date: Fri, 22 Nov 2019 07:09:13 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/5] vfio/spapr: Handle changes of master irq chip for
 VFIO devices
Message-ID: <20191122070913.5aa6f784@bahia.lan>
In-Reply-To: <20191121005607.274347-1-david@gibson.dropbear.id.au>
References: <20191121005607.274347-1-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8905305313223219686
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehfedgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.76.148
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
Cc: kvm@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 11:56:02 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Due to the way feature negotiation works in PAPR (which is a
> paravirtualized platform), we can end up changing the global irq chip
> at runtime, including it's KVM accelerate model.  That causes
> complications for VFIO devices with INTx, which wire themselves up
> directly to the KVM irqchip for performance.
> 
> This series introduces a new notifier to let VFIO devices (and
> anything else that needs to in the future) know about changes to the
> master irqchip.  It modifies VFIO to respond to the notifier,
> reconnecting itself to the new KVM irqchip as necessary.
> 
> In particular this removes a misleading (though not wholly inaccurate)
> warning that occurs when using VFIO devices on a pseries machine type
> guest.
> 
> Open question: should this go into qemu-4.2 or wait until 5.0?  It's
> has medium complexity / intrusiveness, but it *is* a bugfix that I
> can't see a simpler way to fix.  It's effectively a regression from
> qemu-4.0 to qemu-4.1 (because that introduced XIVE support by
> default), although not from 4.1 to 4.2.
> 
> Changes since RFC:
>  * Fixed some incorrect error paths pointed by aw in 3/5
>  * 5/5 had some problems previously, but they have been obsoleted by
>    other changes merged in the meantime
> 
> David Gibson (5):
>   kvm: Introduce KVM irqchip change notifier
>   vfio/pci: Split vfio_intx_update()
>   vfio/pci: Respond to KVM irqchip change notifier
>   spapr: Handle irq backend changes with VFIO PCI devices
>   spapr: Work around spurious warnings from vfio INTx initialization
> 
>  accel/kvm/kvm-all.c    | 18 ++++++++++++
>  accel/stubs/kvm-stub.c | 12 ++++++++
>  hw/ppc/spapr_irq.c     | 17 +++++++++++-
>  hw/vfio/pci.c          | 62 +++++++++++++++++++++++++++---------------
>  hw/vfio/pci.h          |  1 +
>  include/sysemu/kvm.h   |  5 ++++
>  6 files changed, 92 insertions(+), 23 deletions(-)
> 

With the issue spotted in patch 3/5 fixed, the series looks good:

Reviewed-by: Greg Kurz <groug@kaod.org>

Then I've tried passthrough of a BCM5719 gigabit adapter to a guest. It works
as expected with MSIs but if I force LSI, either through /sys or with the
pci=nomsi kernel command line, I get no interrupts for the device in the guest.
Note that the same device works ok with LSI in the host.

