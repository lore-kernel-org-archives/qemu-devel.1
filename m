Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54824C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6FB20736
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6FB20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC52e-0007gs-9Y
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jC51Y-0006wE-2F
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jC51T-0000zz-3G
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:20:03 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:44729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jC51S-0000y5-TO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:19:59 -0400
Received: from player687.ha.ovh.net (unknown [10.108.35.59])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 90A0E2722CB
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 18:19:56 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 432EB1046BAF1;
 Wed, 11 Mar 2020 17:19:42 +0000 (UTC)
Date: Wed, 11 Mar 2020 18:19:41 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 0/2] spapr: Use vIOMMU translation for virtio by default
Message-ID: <20200311181941.0ff9286c@bahia.home>
In-Reply-To: <20200305043009.611636-1-david@gibson.dropbear.id.au>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2142587524751137254
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvvddgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.132
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
Cc: pair@us.ibm.com, mst@redhat.com, aik@ozlabs.ru,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, paulus@samba.org,
 clg@kaod.org, mdroth@us.ibm.com, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  5 Mar 2020 15:30:07 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Upcoming Secure VM support for pSeries machines introduces some
> complications for virtio, since the transfer buffers need to be
> explicitly shared so that the hypervisor can access them.
> 
> While it's not strictly speaking dependent on it, the fact that virtio
> devices bypass normal platform IOMMU translation complicates the issue
> on the guest side.  Since there are some significan downsides to
> bypassing the vIOMMU anyway, let's just disable that.
> 
> There's already a flag to do this in virtio, just turn it on by
> default for forthcoming pseries machine types.
> 
> Any opinions on whether dropping support for the older guest kernels
> is acceptable at this point?
> 
> Changes since v2:
>  * Rebase and improve some comments
> Changes since v1:
>  * Added information on which guest kernel versions will no longer
>    work with these changes
>  * Use Michael Tsirkin's suggested better way of handling the machine
>    type change
> 
> David Gibson (2):
>   spapr: Disable legacy virtio devices for pseries-5.0 and later

This disables legacy AND transitional devices. IIUC this first patch
is needed because only non-transitional (pure virtio-1) devices
support iommu_platform=on, ie. this check in virtio_pci_device_plugged():

    if (legacy) {
        if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
            error_setg(errp, "VIRTIO_F_IOMMU_PLATFORM was supported by"
                       " neither legacy nor transitional device");
            return ;
        }

It certainly looks right for legacy devices but what about
transitional ones ? I couldn't find any indication in the
spec or in the QEMU archives that explains why IOMMU should
only be used with non-transitional devices...

Jason or Michael, can you explain ?

>   spapr: Enable virtio iommu_platform=on by default
> 
>  hw/ppc/spapr.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 


