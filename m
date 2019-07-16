Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98127C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CB220880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CB220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnI46-0003fq-Nt
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 03:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49958)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hnI3v-0003BU-KS
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hnI3u-0004AF-8p
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:39:47 -0400
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:58089)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hnI3u-00048I-0x
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:39:46 -0400
Received: from player690.ha.ovh.net (unknown [10.109.146.211])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 84B8A21F076
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 09:39:41 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id 0E7267D9EA68;
 Tue, 16 Jul 2019 07:39:36 +0000 (UTC)
To: Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>
References: <20190716045633.15319-1-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6e98fffb-2642-3835-d3ba-f06b73ca2fdc@kaod.org>
Date: Tue, 16 Jul 2019 09:39:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716045633.15319-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9168484418162625344
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrheelgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.43.173
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Warn when using -initrd and low
 ram
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/07/2019 06:56, Joel Stanley wrote:
> When booting with the default amount of RAM the powernv machine will
> load the initrd above the top of RAM and cause the Linux kernel to crash
> when it attempts to access the initrd:
> 
>   Linux/PowerPC load:
>   Finalizing device tree... flat tree at 0x202770c0
>   [    0.070476] nvram: Failed to find or create lnx,oops-log partition, err -28
>   [    0.073270] nvram: Failed to initialize oops partition!
>   [    0.156302] BUG: Unable to handle kernel data access at 0xc000000060000000
>   [    0.158009] Faulting instruction address: 0xc000000001002e5c
>   cpu 0x0: Vector: 300 (Data Access) at [c00000003d1e3870]
>       pc: c000000001002e5c: unpack_to_rootfs+0xdc/0x2f0
>       lr: c000000001002df4: unpack_to_rootfs+0x74/0x2f0
>       sp: c00000003d1e3b00
>      msr: 9000000002009033
>      dar: c000000060000000
>    dsisr: 40000000
>     current = 0xc00000003d1c0000
>     paca    = 0xc000000001320000	 irqmask: 0x03	 irq_happened: 0x01
>       pid   = 1, comm = swapper/0
>   Linux version 5.2.0-10292-g040e2e618374 (joel@voyager) (gcc version 8.3.0 (Debian 8.3.0-2)) #1 SMP Tue Jul 16 13:50:32 ACST 2019
>   enter ? for help
>   [c00000003d1e3bb0] c000000001003c90 populate_rootfs+0x84/0x1dc
>   [c00000003d1e3c40] c00000000000f494 do_one_initcall+0x88/0x1d0
>   [c00000003d1e3d10] c000000001000fc4 kernel_init_freeable+0x24c/0x250
>   [c00000003d1e3db0] c00000000000f7a0 kernel_init+0x1c/0x150
>   [c00000003d1e3e20] c00000000000b8a4 ret_from_kernel_thread+0x5c/0x78
> 
> Provide a helpful message for users so they don't go reporting bugs to
> kernel developers.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> We could solve this in other ways, such as warn when loading the initrd
> outside of RAM, or load it within the known boundaries or RAM, but after
> hitting this myself I wanted to start the discussion.

We should also increase : 

    mc->default_ram_size = 1 * GiB;

to 2 or 4 GiB. I always use 4.

> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/ppc/pnv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index bd4531c82260..bbd596ab9eca 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -649,6 +649,13 @@ static void pnv_init(MachineState *machine)


at the beginning of this routine we have :

    /* allocate RAM */
    if (machine->ram_size < (1 * GiB)) {
        warn_report("skiboot may not work with < 1GB of RAM");
    }

and we should exit instead. 

>      /* load initrd */
>      if (machine->initrd_filename) {
> +        if (machine->ram_size <= (1.5 * GiB)) {
> +            /* INITRD_LOAD_ADDR is at 1.5GB, so we require at least that much RAM
> +             * when specifying the initrd on the command line */
> +            warn_report("initrd load requires > %ld MB of RAM",
> +                    INITRD_LOAD_ADDR / MiB);
> +        }

Shouldn't we take into account the initrd size also ? I don't know if it is 
relevant as it can be compressed.

>          pnv->initrd_base = INITRD_LOAD_ADDR;
>          pnv->initrd_size = load_image_targphys(machine->initrd_filename,
>                                    pnv->initrd_base, INITRD_MAX_SIZE);
> 


