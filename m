Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFA1C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CBE2238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CBE2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfCd-0003Uk-DY
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41604)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfCQ-00033z-WE
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfCP-00012d-MF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:58:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfCP-00012H-I6
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:58:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id t8so36644921qkt.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8VHAoOAgrND/ZCaKatcTgn3woS5gB0hXy9hKHKYDKNk=;
 b=Dgn+EpI4vZ/990DTI+oGRC29lsGYLox2Ta4eb6GGrTTYzEYR2YjnUaQDnEuRs4qEfJ
 iiH8BZCfVTWQK8hbQWOBEbDA9Dnt8e5qHo4pkODOZw4NB31xsaoKaQvSHa589XuP/WGv
 96ctifQHjr8xhQg2+kV8Cuyh79tngPl8PtS0ysIBMNfAsYvKSBgIY+RQ68OQeTfMHQJg
 mi5/NTNcjvwLW4mfTse9NVqmoXrky9U4/yN7aVCIoRT+aJPBY/lMb/9sh3bSdl6uvQTB
 1iWSOc7X6Fx+Devbs+DWS5eJiGJC1UvsWV2ynFzpeH252PRRomSx7qBY0JCDHcgbef6m
 mokQ==
X-Gm-Message-State: APjAAAV4MmsuuXPGfvJKJZdliirT/YxGqO0Kovt7aPsN4GBpVEV9UnQQ
 Om4T+57JCdLdK8e7fIMvRtr5Uw==
X-Google-Smtp-Source: APXvYqwmclFH9GtmdqG660gicaPCTq1mf4HKzOKdbfCdChI1nrTb0omY3x5js7XonixpIyQzo3ZYDA==
X-Received: by 2002:a37:bc03:: with SMTP id m3mr58778432qkf.199.1564066709063; 
 Thu, 25 Jul 2019 07:58:29 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 l6sm21021758qkc.89.2019.07.25.07.58.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 07:58:27 -0700 (PDT)
Date: Thu, 25 Jul 2019 10:58:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190725104721-mutt-send-email-mst@kernel.org>
References: <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com>
 <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
 <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
 <87muh2mazh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muh2mazh.fsf@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.194
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Maran Wilson <maran.wilson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 04:42:42PM +0200, Sergio Lopez wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > On 25/07/19 15:26, Stefan Hajnoczi wrote:
> >> The microvm design has a premise and it can be answered definitively
> >> through performance analysis.
> >> 
> >> If I had to explain to someone why PCI or ACPI significantly slows
> >> things down, I couldn't honestly do so.  I say significantly because
> >> PCI init definitely requires more vmexits but can it be a small
> >> number?  For ACPI I have no idea why it would consume significant
> >> amounts of time.
> >
> > My guess is that it's just a lot of code that has to run. :(
> 
> I think I haven't shared any numbers about ACPI.
> 
> I don't have details about where exactly the time is spent, but
> compiling a guest kernel without ACPI decreases the average boot time in
> ~12ms, and the kernel's unstripped ELF binary size goes down in a
> whooping ~300KiB.

At least the binary size is hardly surprising.

I'm guessing you built in lots of drivers.

It would be educational to try to enable ACPI core but disable all
optional features.


> On the other hand, removing ACPI from QEMU decreases its initialization
> time in ~5ms, and the binary size is ~183KiB smaller.

Yes - ACPI generation uses a ton of allocations and data copies.

Need to play with pre-allocation strategies. Maybe something
as simple as:

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f3fdfefcd5..24becc069e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2629,8 +2629,10 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_get_pci_holes(&pci_hole, &pci_hole64);
     acpi_get_slic_oem(&slic_oem);
 
+#define DEFAULT_ARRAY_SIZE 16
     table_offsets = g_array_new(false, true /* clear */,
-                                        sizeof(uint32_t));
+                                        sizeof(uint32_t),
+                                        DEFAULT_ARRAY_SIZE);
     ACPI_BUILD_DPRINTF("init ACPI tables\n");
 
     bios_linker_loader_alloc(tables->linker,

will already help a bit.

> 
> IMHO, those are pretty relevant savings on both fronts.
> 
> >> Until we have this knowledge, the premise of microvm is unproven and
> >> merging it would be premature because maybe we can get into the same
> >> ballpark by optimizing existing code.
> >> 
> >> I'm sorry for being a pain.  I actually think the analysis will
> >> support microvm, but it still needs to be done in order to justify it.
> >
> > No, you're not a pain, you're explaining your reasoning and that helps.
> >
> > To me *maintainability is the biggest consideration* when introducing a
> > new feature.  "We can do just as well with q35" is a good reason to
> > deprecate and delete microvm, but not a good reason to reject it now as
> > long as microvm is good enough in terms of maintainability.  Keeping it
> > out of tree only makes it harder to do this kind of experiment.  virtio
> > 1 seems to be the biggest remaining blocker and I think it'd be a good
> > thing to have even for the ARM virt machine type.
> >
> > FWIW the "PCI tax" seems to be ~10 ms in QEMU, ~10 ms in the firmware(*)
> > and ~25 ms in the kernel.  I must say that's pretty good, but it's still
> > 30% of the whole boot time and reducing it is the hardest part.  If
> > having microvm in tree can help reducing it, good.  Yes, it will get
> > users, but most likely they will have to support pc or q35 as a fallback
> > so we could still delete microvm at any time with the due deprecation
> > period if it turns out to be a failed experiment.
> >
> > Whether to use qboot or SeaBIOS for microvm is another story, but it's
> > an implementation detail as long as the ROM size doesn't change and/or
> > we don't do versioned machine types.  So we can switch from one to the
> > other at any time; we can also include qboot directly in QEMU's tree,
> > without going through a submodule, which also reduces the infrastructure
> > needed (mirrors, etc.) and makes it easier to delete it.
> >
> > Paolo
> >
> > (*) I measured 15ms in SeaBIOS and 5ms in qboot from the first to the
> > last write to 0xcf8.  I suspect part of qboot's 10ms boot time actually
> > end up measured as PCI in SeaBIOS, due to different init order, so the
> > real firmware cost of PAM and PCI initialization should be 5ms for qboot
> > and 10ms for SeaBIOS.
> 



