Received: from eggs.gnu.org ([2001:4830:134:3::10]:55275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1em39s-0007OZ-TH
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1em39o-0004JX-U3
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:56:01 -0500
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:42343)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1em39o-0004JG-Pb
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:55:56 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1EJqCxQ012440
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 14:55:55 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id DBEAB80
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 14:55:56 -0500 (EST)
Received: from sendprodmail04.cc.columbia.edu (sendprodmail04.cc.columbia.edu
	[128.59.72.16]) by hazelnut (Postfix) with ESMTP id BF88181
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 14:55:56 -0500 (EST)
Received: from mail-wr0-f198.google.com (mail-wr0-f198.google.com
	[209.85.128.198])
	by sendprodmail04.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1EJtskX031162
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 14:55:55 -0500
Received: by mail-wr0-f198.google.com with SMTP id 73so574131wrb.13
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 11:55:55 -0800 (PST)
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com.
	[74.125.82.49]) by smtp.gmail.com with ESMTPSA id
	q49sm3481818eda.42.2018.02.14.11.55.50 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 14 Feb 2018 11:55:51 -0800 (PST)
Received: by mail-wm0-f49.google.com with SMTP id t74so24961090wme.3
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 11:55:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHyh4xiTDwB2xG_bg00bMA0042yTRq7-dJ-+y3muR+=9N3Vx-g@mail.gmail.com>
References: <CAHyh4xiTDwB2xG_bg00bMA0042yTRq7-dJ-+y3muR+=9N3Vx-g@mail.gmail.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Wed, 14 Feb 2018 14:55:49 -0500
Message-ID: <CAHyh4xhW-5_vS2rVa=NzyHhZnRP+zgpHXQr82sHdaseuuzXf_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Assigning network devices to nested VMs results in
 driver errors in nested VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>, vfio-users@redhat.com
Cc: Peter Xu <peterx@redhat.com>

On Tue, Feb 13, 2018 at 11:44 PM, Jintack Lim <jintack@cs.columbia.edu> wrote:
> Hi,
>
> I'm trying to assign network devices to nested VMs on x86 using KVM,
> but I got network device driver errors in the nested VMs. (I've tried
> this about an year ago when vIOMMU patches were not upstreamed, and I
> got similar errors at that time.)
>
> This could be network driver issues, but I'd like to get some help if
> somebody encountered similar issues.
>
> I'm using v4.15.0 kernel and v2.11.0 QEMU, and I followed this [1]
> guide. I had no problem with assigning devices to the first level VMs
> (L1 VMs). And I also checked that the devices were assigned to nested
> VMs with the lspci command in the nested VMs. But network device
> drivers failed to initialize the device. I tried two network cards -
> Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection and
> Mellanox Technologies MT27500 Family.
>
> Intel driver error in the nested VM looks like this.
> [    1.939552] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver -
> version 5.1.0-k
> [    1.949796] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [    2.210024] ixgbe 0000:00:04.0: HW Init failed: -12
> [    2.218144] ixgbe: probe of 0000:00:04.0 failed with error -12
>

I was assigning PF to the L1 VMs and L2 VMs so far; I guess this is
not the right way. So I tried to assign VF to the L1 VM and assigned
the same VF to the L2 VM in turn. Then the device driver in L2 VM
didn't show any error, and I was able to configure the network
interface. But the network still didn't work.

I only tried Intel network device so far.

> and I saw lots of these messages in the host (L0) kernel log when
> booting the nested VM.
>
> [ 1557.404173] DMAR: DRHD: handling fault status reg 102
> [ 1557.409813] DMAR: [DMA Read] Request device [06:00.0] fault addr
> 90000 [fault reason 06] PTE Read access is not set
> [ 1561.383957] DMAR: DRHD: handling fault status reg 202
> [ 1561.389598] DMAR: [DMA Read] Request device [06:00.0] fault addr
> 90000 [fault reason 06] PTE Read access is not set
>

I still see similar error logs in the host kernel. The fault address
looks different, though.

[ 3228.636485] ixgbe 0000:06:00.0 eth2: VF Reset msg received from vf 0
[ 3236.023683] DMAR: DRHD: handling fault status reg 2
[ 3236.029129] DMAR: [DMA Read] Request device [06:10.0] fault addr
354748000 [fault reason 06] PTE Read access is not set
[ 3236.371711] DMAR: DRHD: handling fault status reg 102
[ 3236.377353] DMAR: [DMA Read] Request device [06:10.0] fault addr
354748000 [fault reason 06] PTE Read access is not set
[ 3236.595667] DMAR: DRHD: handling fault status reg 202
[ 3236.601307] DMAR: [DMA Read] Request device [06:10.0] fault addr
354748000 [fault reason 06] PTE Read access is not set
[ 3236.831863] DMAR: DRHD: handling fault status reg 302
[ 3236.837503] DMAR: [DMA Read] Request device [06:10.0] fault addr
370b7c000 [fault reason 06] PTE Read access is not set
[ 3237.647806] vfio-pci 0000:06:10.0: timed out waiting for pending
transaction; performing function level reset anyway

> This is Mellanox driver error in another nested VM.
> [    2.481694] mlx4_core: Initializing 0000:00:04.0
> [    3.519422] mlx4_core 0000:00:04.0: Installed FW has unsupported
> command interface revision 0
> [    3.537769] mlx4_core 0000:00:04.0: (Installed FW version is 0.0.000)
> [    3.551733] mlx4_core 0000:00:04.0: This driver version supports
> only revisions 2 to 3
> [    3.568758] mlx4_core 0000:00:04.0: QUERY_FW command failed, aborting
> [    3.582789] mlx4_core 0000:00:04.0: Failed to init fw, aborting.
>
> The host showed similar messages as above.
>
> I wonder what could be the cause of these errors. Please let me know
> if further information is needed.
>
> [1] https://wiki.qemu.org/Features/VT-d
>
> Thanks,
> Jintack
