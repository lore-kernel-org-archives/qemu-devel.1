Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2AFC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 09:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C589220672
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 09:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HT5X6yIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C589220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50465 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inJgE-0002KW-SG
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 04:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1inJfK-0001Ud-BF
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1inJfG-0007mv-TF
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:54:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1inJfG-0007h2-Kc
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578045281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chwXm8F0j+wsremYIP1FM7M4tf6hopHxBqgIX+irzVk=;
 b=HT5X6yItmigBwdIgp1LXvfqI7/FQEqSxJELIJFUgDnp21XLTuxHhBQF9JowbOs8uZ00p5D
 bHuUt+wo77j8X8X8K0glRlF0epfflYhVXDHfz/XYJR4563rA2uK+WRVfiwQtnnl1ciey6j
 LwCHNyqSUl6RLCCT27eqOwsuczjVWCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-fBY7BQkPNLiYebmiuGBiTA-1; Fri, 03 Jan 2020 04:54:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42A47800D48;
 Fri,  3 Jan 2020 09:54:39 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06AFB60BF7;
 Fri,  3 Jan 2020 09:54:35 +0000 (UTC)
Date: Fri, 3 Jan 2020 10:54:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2] hppa: allow max ram size upto 4Gb
Message-ID: <20200103105434.050d28ea@redhat.com>
In-Reply-To: <2f226aa4-5f61-6e6d-d6b9-a98685a79e8c@gmx.de>
References: <27c3e31d-82ae-e62f-caba-a0a3fbd55e7c@redhat.com>
 <1577987162-150529-1-git-send-email-imammedo@redhat.com>
 <2f226aa4-5f61-6e6d-d6b9-a98685a79e8c@gmx.de>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: fBY7BQkPNLiYebmiuGBiTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Jan 2020 21:22:12 +0100
Helge Deller <deller@gmx.de> wrote:

> On 02.01.20 18:46, Igor Mammedov wrote:
> > Previous patch drops silent ram_size fixup and makes
> > QEMU error out with:
> >
> >  "RAM size more than 3840m is not supported"
> >
> > when user specified -m X more than supported value.
> >
> > User shouldn't be bothered with starting QEMU with valid CLI,
> > so for the sake of user convenience allow using -m 4G vs -m 3840M.
> >
> > Requested-by: Helge Deller <deller@gmx.de>
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v2:
> >   - make main ram -1 prio, so it wouldn't conflict with other regions
> >     starting from 0xf9000000
> >
> > I dislike it but if you feel it's really necessary feel free to ack it.
> >
> > should be applied on top of:
> >   "hppa: drop RAM size fixup"  
> 
> Hello Igor,
> I appreciate that you are trying to make it more cleaner.
> But, can't you merge both of your patches to one patch?
> Right now you have one patch "hppa: drop RAM size fixup", which is
> what I think is wrong. Then you add another one which somehow
> fixes it up again and adds other stuff.
1st patch bring it in line with other boards adding
proper error check but without changing RAM size.
While 2nd is changing device model (mapped RAM size) and
clearly documents that it's a hack for user convenience,
Hence I'd prefer to keep both separated.

> Having everything in one single patch makes your full change more
> understandable.
> 
> Is it necessary to introduce clamped_ram_size and not continue with
> ram_size (even if you would add it as static local variable)?
it's necessary since ram_size is global which should be kept == MachineState::ram_size.
Later on I plan to remove the former altogether and maybe
MachineState::ram_size aa well, since it could be read with
memory_region_size(MachineState::ram).

> Helge
> 
> 
> > ---
> >  hw/hppa/machine.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> > index ebbf44f..0302983 100644
> > --- a/hw/hppa/machine.c
> > +++ b/hw/hppa/machine.c
> > @@ -54,6 +54,7 @@ static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t addr)
> >
> >  static HPPACPU *cpu[HPPA_MAX_CPUS];
> >  static uint64_t firmware_entry;
> > +static ram_addr_t clamped_ram_size;
> >
> >  static void machine_hppa_init(MachineState *machine)
> >  {
> > @@ -74,8 +75,6 @@ static void machine_hppa_init(MachineState *machine)
> >      long i;
> >      unsigned int smp_cpus = machine->smp.cpus;
> >
> > -    ram_size = machine->ram_size;
> > -
> >      /* Create CPUs.  */
> >      for (i = 0; i < smp_cpus; i++) {
> >          char *name = g_strdup_printf("cpu%ld-io-eir", i);
> > @@ -90,12 +89,14 @@ static void machine_hppa_init(MachineState *machine)
> >      }
> >
> >      /* Limit main memory. */
> > -    if (ram_size > FIRMWARE_START) {
> > -        error_report("RAM size more than %d is not supported", FIRMWARE_START);
> > +    if (machine->ram_size > 4 * GiB) {
> > +        error_report("RAM size more than 4Gb is not supported");
> >          exit(EXIT_FAILURE);
> >      }
> > +    clamped_ram_size = machine->ram_size > FIRMWARE_START ?
> > +        FIRMWARE_START : machine->ram_size;
> >
> > -    memory_region_add_subregion(addr_space, 0, machine->ram);
> > +    memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1);
> >
> >      /* Init Dino (PCI host bus chip).  */
> >      pci_bus = dino_init(addr_space, &rtc_irq, &serial_irq);
> > @@ -151,7 +152,7 @@ static void machine_hppa_init(MachineState *machine)
> >      qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
> >                    "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
> >                    firmware_low, firmware_high, firmware_entry);
> > -    if (firmware_low < ram_size || firmware_high >= FIRMWARE_END) {
> > +    if (firmware_low < clamped_ram_size || firmware_high >= FIRMWARE_END) {
> >          error_report("Firmware overlaps with memory or IO space");
> >          exit(1);
> >      }
> > @@ -204,7 +205,7 @@ static void machine_hppa_init(MachineState *machine)
> >                 (1) Due to sign-extension problems and PDC,
> >                 put the initrd no higher than 1G.
> >                 (2) Reserve 64k for stack.  */
> > -            initrd_base = MIN(ram_size, 1 * GiB);
> > +            initrd_base = MIN(clamped_ram_size, 1 * GiB);
> >              initrd_base = initrd_base - 64 * KiB;
> >              initrd_base = (initrd_base - initrd_size) & TARGET_PAGE_MASK;
> >
> > @@ -232,7 +233,7 @@ static void machine_hppa_init(MachineState *machine)
> >       * various parameters in registers. After firmware initialization,
> >       * firmware will start the Linux kernel with ramdisk and cmdline.
> >       */
> > -    cpu[0]->env.gr[26] = ram_size;
> > +    cpu[0]->env.gr[26] = clamped_ram_size;
> >      cpu[0]->env.gr[25] = kernel_entry;
> >
> >      /* tell firmware how many SMP CPUs to present in inventory table */
> > @@ -255,11 +256,11 @@ static void hppa_machine_reset(MachineState *ms)
> >      }
> >
> >      /* already initialized by machine_hppa_init()? */
> > -    if (cpu[0]->env.gr[26] == ram_size) {
> > +    if (cpu[0]->env.gr[26] == clamped_ram_size) {
> >          return;
> >      }
> >
> > -    cpu[0]->env.gr[26] = ram_size;
> > +    cpu[0]->env.gr[26] = clamped_ram_size;
> >      cpu[0]->env.gr[25] = 0; /* no firmware boot menu */
> >      cpu[0]->env.gr[24] = 'c';
> >      /* gr22/gr23 unused, no initrd while reboot. */
> >  
> 


