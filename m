Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9982DC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72335217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72335217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2CzL-0004NV-M8
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 06:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j2CxW-0003RT-Gv
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j2CxU-0004vs-Nk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:47:06 -0500
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:49549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j2CxT-0004tR-E5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:47:04 -0500
Received: from player697.ha.ovh.net (unknown [10.110.171.5])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 767AF8C80A
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 12:47:00 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id 365D5F56DB9D;
 Thu, 13 Feb 2020 11:46:45 +0000 (UTC)
Date: Thu, 13 Feb 2020 12:46:43 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 0/2] spapr: Use vIOMMU translation for virtio by default
Message-ID: <20200213124643.7b205d44@bahia.lan>
In-Reply-To: <20200213005837.131791-1-david@gibson.dropbear.id.au>
References: <20200213005837.131791-1-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3977522897199536614
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrieekgdefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinheprhgvughhrghtrdgtohhmnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.44.197
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
Cc: pair@us.ibm.com, mst@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, mdroth@us.ibm.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 11:58:35 +1100
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

As expected, this breaks compatibility with existing RHEL 6.10 guests. Each
patch in this series requires an extra -global option to be specified on
the command line in order to boot successfully.

Patch 1: -global virtio-pci.disable-legacy=auto
Patch 2: -global virtio-pci.iommu_platform=off

As seen on the RH site [1], RHEL6 will reach "End of Maintenance Support
or Maintenance Support 2 (Product retirement)" on November 30, 2020 and
"End of Extended Life-cycle Support" on June 30, 2024.

Not sure if it's okay to drop support for RHEL6 this soon.

RHEL 7.7 guests seem to be unaffected.

[1] https://access.redhat.com/support/policy/updates/errata/#Life_Cycle_Dates

> Changes since v1:
>  * Added information on which guest kernel versions will no longer
>    work with these changes
>  * Use Michael Tsirkin's suggested better way of handling the machine
>    type change
> 
> David Gibson (2):
>   spapr: Disable legacy virtio devices for pseries-5.0 and later
>   spapr: Enable virtio iommu_platform=on by default
> 
>  hw/ppc/spapr.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 


