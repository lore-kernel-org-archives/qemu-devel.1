Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50083C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D03F206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D03F206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZdMv-0008B3-4Z
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 11:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iZdM4-0007ZZ-VR
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iZdM3-0004Gb-DP
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:06:20 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:46539)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iZdM3-0004F1-64
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:06:19 -0500
Received: from player734.ha.ovh.net (unknown [10.108.16.135])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 82D8E1B5556
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 17:06:16 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 683C7C7F9303;
 Tue, 26 Nov 2019 16:06:11 +0000 (UTC)
Date: Tue, 26 Nov 2019 17:06:09 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH for-5.0 0/4] spapr: Use less XIVE HW resources in KVM
Message-ID: <20191126170609.7fa7759a@bahia.w3ibm.bluemix.net>
In-Reply-To: <157478338194.62031.4716158446072147622.stgit@bahia.tlslab.ibm.com>
References: <157478338194.62031.4716158446072147622.stgit@bahia.tlslab.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5582211742014282214
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeifedgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.181.248
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Oops clumsy fingers, please ignore that ... :)

On Tue, 26 Nov 2019 16:50:38 +0100
Greg Kurz <groug@kaod.org> wrote:

> On POWER9 systems, the XICS-on-XIVE and XIVE KVM devices currently
> allocate a bunch of VPs in the XIVE HW to accomodate the highest
> VCPU id that may be possibly used in a VM. This limits the number
> of VMs that can run with an in-kernel interrupt controller to 63
> per POWER9 chip, irrespectively of its number of HW threads, eg.
> up to 96 on a POWER9 Nimbus socket. This is an unfortunate waste
> of scarce HW resources since a typical VM doesn't need that much
> VPs to run.
> 
> This series exploits new attributes of the XICS-on-XIVE and XIVE
> KVM devices that allow userspace to tune the numbers of VPs it
> really needs.
> 
> Patches 1 to 3 are preliminary work to teach the XICS and XIVE
> backends about the range of needed VCPU ids, according to the
> maximum number of VCPUs specified in the QEMU command line.
> 
> Patch 5 and 6 do the actual work of configuring the KVM devices,
> based on new defines brought by a patch 4. RFC since the patches
> for KVM are still being discussed on the kvm-ppc list:
> 
> https://patchwork.ozlabs.org/project/kvm-ppc/list/?series=132910
> 
> As a bonus, patch 7 allows the latest machine type to automatically
> set int KVM the guest core stride (VSMT) to be equal to the number
> of threads per core (-smp threads=N). This makes VCPU ids contiguous
> and allows to reduce the VP consumption even more.
> 
> Both KVM and QEMU changes are available here:
> https://github.com/gkurz/linux/commits/xive-nr-servers-5.3
> https://github.com/gkurz/qemu/commits/xive-nr-servers-for-4.2
> ---
> 
> Greg Kurz (4):
>       linux-headers: Update
>       spapr: Pass the maximum number of vCPUs to the KVM interrupt controller
>       spapr/xics: Configure number of servers in KVM
>       spapr/xive: Configure number of servers in KVM
> 
> 
>  hw/intc/spapr_xive.c                         |    6 ++++--
>  hw/intc/spapr_xive_kvm.c                     |   26 +++++++++++++++++++++++---
>  hw/intc/xics_kvm.c                           |   24 +++++++++++++++++++++---
>  hw/intc/xics_spapr.c                         |    5 +++--
>  hw/ppc/spapr_irq.c                           |    8 +++++---
>  include/hw/ppc/spapr_irq.h                   |   10 ++++++++--
>  include/hw/ppc/spapr_xive.h                  |    3 ++-
>  include/hw/ppc/xics_spapr.h                  |    3 ++-
>  include/standard-headers/linux/ethtool.h     |    6 ++++++
>  include/standard-headers/linux/virtio_ring.h |    2 +-
>  linux-headers/asm-arm/kvm.h                  |    3 ++-
>  linux-headers/asm-arm64/kvm.h                |    5 ++++-
>  linux-headers/asm-mips/unistd_n32.h          |    1 +
>  linux-headers/asm-mips/unistd_n64.h          |    1 +
>  linux-headers/asm-mips/unistd_o32.h          |    1 +
>  linux-headers/asm-powerpc/kvm.h              |    3 +++
>  linux-headers/linux/kvm.h                    |   11 +++++++++++
>  linux-headers/linux/psp-sev.h                |    3 +++
>  18 files changed, 101 insertions(+), 20 deletions(-)
> 
> 


