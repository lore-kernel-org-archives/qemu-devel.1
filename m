Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4117CC32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 09:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C13207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 09:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C13207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioOWa-0007Oh-85
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 04:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ioOVu-0006pF-NT
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ioOVt-00089E-FH
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:17:30 -0500
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:59140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ioOVt-00088U-8q
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:17:29 -0500
Received: from player792.ha.ovh.net (unknown [10.108.42.142])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id DB36E1BE29B
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 10:17:26 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id 82EE3DECCEB6;
 Mon,  6 Jan 2020 09:17:19 +0000 (UTC)
Date: Mon, 6 Jan 2020 10:17:18 +0100
From: Greg Kurz <groug@kaod.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] vfio/pci: Don't remove irqchip notifier if not registered
Message-ID: <20200106101718.79499f12@bahia.lan>
In-Reply-To: <20191231133915.115363-1-peterx@redhat.com>
References: <20191231133915.115363-1-peterx@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18097152156012550525
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgtdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.58.226
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 yanghliu@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Dec 2019 08:39:15 -0500
Peter Xu <peterx@redhat.com> wrote:

> The kvm irqchip notifier is only registered if the device supports
> INTx, however it's unconditionally removed.  If the assigned device
> does not support INTx, this will cause QEMU to crash when unplugging
> the device from the system.  Change it to conditionally remove the
> notifier only if the notify hook is setup.
> 
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Alex Williamson <alex.williamson@redhat.com>
> Reported-by: yanghliu@redhat.com
> Fixes: c5478fea27 ("vfio/pci: Respond to KVM irqchip change notifier", 2019-11-26)
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1782678
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Good catch... sorry for missing this during review :-\

Cc'ing stable since we certainly want this fix in 4.2.1 as well.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/vfio/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2d40b396f2..337a173ce7 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3076,7 +3076,9 @@ static void vfio_exitfn(PCIDevice *pdev)
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> -    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +    if (vdev->irqchip_change_notifier.notify) {
> +        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +    }
>      vfio_disable_interrupts(vdev);
>      if (vdev->intx.mmap_timer) {
>          timer_free(vdev->intx.mmap_timer);


