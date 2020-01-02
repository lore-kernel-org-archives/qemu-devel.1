Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD3FC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10D0215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTT99ImD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10D0215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imyyU-0007mc-OO
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 06:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imyxO-0006lq-Cj
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imyxJ-0003jy-Km
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:48:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20796
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imyxJ-0003iw-GN
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577965676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+axzXdeRPeyDgxt6HRcOouXDPgwONEFonfZ0uJemBQw=;
 b=WTT99ImDR5JfDBTSTVmAwfUsmkjM08Hdj+uR671LMz0P150n2EK4dyRxlRD935V55FX8Xp
 DBSxnMAB2EhY3wF25GQzXKjtjyx2Wxt+amGa5pNsfACYtFe5wEB2UwdQLZZcFd00smvfJv
 vhyWwt/3oLzepxBToL0K+Je6zvl+EOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-Z6H14xnhNQS9Zu5mBFxfeA-1; Thu, 02 Jan 2020 06:47:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D6C8107ACCD;
 Thu,  2 Jan 2020 11:47:52 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5516160BFB;
 Thu,  2 Jan 2020 11:47:51 +0000 (UTC)
Date: Thu, 2 Jan 2020 12:47:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 66/86] ppc:ppc440_bamboo/sam460ex: drop RAM size fixup
Message-ID: <20200102124749.03a0368d@redhat.com>
In-Reply-To: <alpine.BSF.2.21.99999.352.2001011235410.5612@zero.eik.bme.hu>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-67-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001011235410.5612@zero.eik.bme.hu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Z6H14xnhNQS9Zu5mBFxfeA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Jan 2020 12:54:37 +0100 (CET)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Tue, 31 Dec 2019, Igor Mammedov wrote:
> > If user provided non-sense RAM size, board will complain and
> > continue running with max RAM size supported.
> > Also RAM is going to be allocated by generic code, so it won't be
> > possible for board to fix things up for user.
> >
> > Make it error message and exit to force user fix CLI,
> > instead of accepting non-sense CLI values.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > include/hw/ppc/ppc4xx.h |  9 ++++-----
> > hw/ppc/ppc440_bamboo.c  | 11 ++++-------
> > hw/ppc/ppc4xx_devs.c    | 26 ++++++++++++++++----------
> > hw/ppc/sam460ex.c       |  5 ++---
> > 4 files changed, 26 insertions(+), 25 deletions(-)
> >
> > diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> > index 7d82259..1a28127 100644
> > --- a/include/hw/ppc/ppc4xx.h
> > +++ b/include/hw/ppc/ppc4xx.h
> > @@ -42,11 +42,10 @@ enum {
> > qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
> >                        uint32_t dcr_base, int has_ssr, int has_vr);
> >
> > -ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> > -                               MemoryRegion ram_memories[],
> > -                               hwaddr ram_bases[],
> > -                               hwaddr ram_sizes[],
> > -                               const ram_addr_t sdram_bank_sizes[]);
> > +void ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> > +                         MemoryRegion ram_memories[],
> > +                         hwaddr ram_bases[], hwaddr ram_sizes[],
> > +                         const ram_addr_t sdram_bank_sizes[]);  
> 
> With this change this function does not adjust ram size any more so it may 
> need to be renamed, e.g. ppc4xx_sdram_banks or something else.
> 
> A better patch title may be
> 
> ppc/{ppc440_bamboo,sam460x}: drop RAM size fixup
> 
> (or without curly braces at your preference).
I'll rename and use this subj as you suggest on v2.

> This is inconvenient for the user because it worked whatever number 
> they've given but now they have to do the math. So it suggests that what 
> you're replacing this with may not support all the existing use cases. If 
> that can't be fixed to allow checking and changing ram size (maybe via a 
> callback in board code similar to above adjust function returning adjusted 
> size) it may be OK to drop this convenience for the sake of cleaning up 
> code elsewhere.

There were few boards that did fix up and in all cases it was to cover up
invalid CLI input.
Creating callback for fixing user mistake doesn't seems to me justified,
I'd much prefer to have a hard error and consistent behavior across all
the boards versus being lax on error checking.

[...]


> > @@ -699,10 +698,19 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> >         }
> >     }
> >
> > -    ram_size -= size_left;
> >     if (size_left) {
> > -        error_report("Truncating memory to %" PRId64 " MiB to fit SDRAM"
> > -                     " controller limits", ram_size / MiB);
> > +        char *s = g_strdup("");
> > +        for (i = 0; sdram_bank_sizes[i]; i++) {
> > +            char *t = g_strdup_printf("%s%" PRIi64 "%s", s, sdram_bank_sizes[i],
> > +                                      sdram_bank_sizes[i + 1] ? " ," : "");
> > +            g_free(s);
> > +            s = t;
> > +        }
> > +        error_report("Invalid RAM size, unable to fit all RAM into RAM banks"
> > +                     " (unassigned RAM: %" PRIi64 ")",  size_left);
> > +        error_report("Supported: %d banks and sizes/bank: %s", nr_banks, s);

Do you have any suggestions how to make error message better?
(maybe do calculation here and dump all valid -m variants instead of "#bank,size/bank")

> > +        g_free(s);
> > +        exit(EXIT_FAILURE);
> >     }
> >
> >     memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_size);
> > @@ -725,8 +733,6 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> >             }
> >         }
> >     }
> > -
> > -    return ram_size;
> > }
> >
> > /*****************************************************************************/
> > diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> > index 437e214..f592816 100644
> > --- a/hw/ppc/sam460ex.c
> > +++ b/hw/ppc/sam460ex.c
> > @@ -324,9 +324,8 @@ static void sam460ex_init(MachineState *machine)
> >     /* SDRAM controller */
> >     /* put all RAM on first bank because board has one slot
> >      * and firmware only checks that */
> > -    machine->ram_size = ppc4xx_sdram_adjust(machine->ram_size, 1,
> > -                                   ram_memories, ram_bases, ram_sizes,
> > -                                   ppc460ex_sdram_bank_sizes);
> > +    ppc4xx_sdram_adjust(machine->ram_size, 1, ram_memories, ram_bases,
> > +                        ram_sizes, ppc460ex_sdram_bank_sizes);
> >
> >     /* FIXME: does 460EX have ECC interrupts? */
> >     ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
> >  
> 


