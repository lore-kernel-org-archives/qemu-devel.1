Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEC5C47409
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F752468E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F752468E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2dDU-0000eV-RP
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j2dCl-0007DT-8Z
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j2dCk-0007pg-08
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:48:35 -0500
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:50176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j2dCj-0007nB-QU
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:48:33 -0500
Received: from player791.ha.ovh.net (unknown [10.110.115.164])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8075015AE1E
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 16:48:31 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id 07403F56D516;
 Fri, 14 Feb 2020 15:48:23 +0000 (UTC)
Date: Fri, 14 Feb 2020 16:48:16 +0100
From: Greg Kurz <groug@kaod.org>
To: <pannengyuan@huawei.com>
Subject: Re: [PATCH] ppc: free 'fdt' after reset the machine
Message-ID: <20200214164816.137e1de7@bahia.lan>
In-Reply-To: <20200214033206.4395-1-pannengyuan@huawei.com>
References: <20200214033206.4395-1-pannengyuan@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13929352175840041236
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrjedtgdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejledurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.74.219
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 clg@kaod.org, euler.robot@huawei.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 11:32:06 +0800
<pannengyuan@huawei.com> wrote:

> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> 'fdt' forgot to clean both e500 and pnv when we call 'system_reset' on ppc,
> this patch fix it. The leak stacks are as follow:
> 
> Direct leak of 4194304 byte(s) in 4 object(s) allocated from:
>     #0 0x7fafe37dd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
>     #1 0x7fafe2e3149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x561876f7f80d in create_device_tree /mnt/sdb/qemu-new/qemu/device_tree.c:40
>     #3 0x561876b7ac29 in ppce500_load_device_tree /mnt/sdb/qemu-new/qemu/hw/ppc/e500.c:364
>     #4 0x561876b7f437 in ppce500_reset_device_tree /mnt/sdb/qemu-new/qemu/hw/ppc/e500.c:617
>     #5 0x56187718b1ae in qemu_devices_reset /mnt/sdb/qemu-new/qemu/hw/core/reset.c:69
>     #6 0x561876f6938d in qemu_system_reset /mnt/sdb/qemu-new/qemu/vl.c:1412
>     #7 0x561876f6a25b in main_loop_should_exit /mnt/sdb/qemu-new/qemu/vl.c:1645
>     #8 0x561876f6a398 in main_loop /mnt/sdb/qemu-new/qemu/vl.c:1679
>     #9 0x561876f7da8e in main /mnt/sdb/qemu-new/qemu/vl.c:4438
>     #10 0x7fafde16b812 in __libc_start_main ../csu/libc-start.c:308
>     #11 0x5618765c055d in _start (/mnt/sdb/qemu-new/qemu/build/ppc64-softmmu/qemu-system-ppc64+0x2b1555d)
> 
> Direct leak of 1048576 byte(s) in 1 object(s) allocated from:
>     #0 0x7fc0a6f1b970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
>     #1 0x7fc0a656f49d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x55eb05acd2ca in pnv_dt_create /mnt/sdb/qemu-new/qemu/hw/ppc/pnv.c:507
>     #3 0x55eb05ace5bf in pnv_reset /mnt/sdb/qemu-new/qemu/hw/ppc/pnv.c:578
>     #4 0x55eb05f2f395 in qemu_system_reset /mnt/sdb/qemu-new/qemu/vl.c:1410
>     #5 0x55eb05f43850 in main /mnt/sdb/qemu-new/qemu/vl.c:4403
>     #6 0x7fc0a18a9812 in __libc_start_main ../csu/libc-start.c:308
>     #7 0x55eb0558655d in _start (/mnt/sdb/qemu-new/qemu/build/ppc64-softmmu/qemu-system-ppc64+0x2b1555d)
> 
> Reported-by: Euler Robot <pannengyuan@huawei.com>

The recipient list and 'git log' seem to agree on the fact that 'Euler Robot'
has its own email address, that is not yours ;-)

Reported-by: Euler Robot <euler.robot@huawei.com>

I guess David can fix this when applying the patch. No need to repost
unless explicitly asked to do so.

> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/e500.c | 1 +
>  hw/ppc/pnv.c  | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 886442e54f..af537bba2b 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -594,6 +594,7 @@ done:
>          cpu_physical_memory_write(addr, fdt, fdt_size);
>      }
>      ret = fdt_size;
> +    g_free(fdt);
>  
>  out:
>      g_free(pci_map);
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 139c857b1e..e98038b809 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -582,6 +582,8 @@ static void pnv_reset(MachineState *machine)
>  
>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>      cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
> +
> +    g_free(fdt);
>  }
>  
>  static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)


