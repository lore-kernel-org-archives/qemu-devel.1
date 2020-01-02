Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E8C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 17:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D6621582
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 17:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lej4VOaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D6621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in48m-0008NO-7I
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 12:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1in48A-0007pS-H4
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1in488-0003Gy-67
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:19:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1in488-0003GW-2D
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577985567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qZA50ucQvHvGszmyxuzHR3QW3+N0qNrjv2H4UNxa7M4=;
 b=Lej4VOaXK6AhHFfkptBAFA+BAbcrz0MT+Wqe+iesBLM6alHJTbiO1f1rmg5C6Cdv6P80ho
 B3JYQEeAejxQse5omzmZj/PnyMpmoWKZgTD2tnJjusZ9GP+ZegdWufDyzIblMI7MkMD6P2
 hAlWV31ytQJvW5QPReGMFPa6B1bnOcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-R3R79ghNOwyMhAfz6o66kw-1; Thu, 02 Jan 2020 12:19:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4755C107ACC4;
 Thu,  2 Jan 2020 17:19:25 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A01AA4B60;
 Thu,  2 Jan 2020 17:19:24 +0000 (UTC)
Date: Thu, 2 Jan 2020 18:19:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 66/86] ppc:ppc440_bamboo/sam460ex: drop RAM size fixup
Message-ID: <20200102181922.771b76b9@redhat.com>
In-Reply-To: <alpine.BSF.2.21.99999.352.2001021642080.6073@zero.eik.bme.hu>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-67-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001011235410.5612@zero.eik.bme.hu>
 <20200102124749.03a0368d@redhat.com>
 <alpine.BSF.2.21.99999.352.2001021642080.6073@zero.eik.bme.hu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: R3R79ghNOwyMhAfz6o66kw-1
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

On Thu, 2 Jan 2020 16:52:50 +0100 (CET)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Thu, 2 Jan 2020, Igor Mammedov wrote:
> > On Wed, 1 Jan 2020 12:54:37 +0100 (CET)
> > BALATON Zoltan <balaton@eik.bme.hu> wrote:  
> >> On Tue, 31 Dec 2019, Igor Mammedov wrote:  
> >>> If user provided non-sense RAM size, board will complain and
> >>> continue running with max RAM size supported.
> >>> Also RAM is going to be allocated by generic code, so it won't be
> >>> possible for board to fix things up for user.
> >>>
> >>> Make it error message and exit to force user fix CLI,
> >>> instead of accepting non-sense CLI values.
> >>>
> >>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>> ---
> >>> include/hw/ppc/ppc4xx.h |  9 ++++-----
> >>> hw/ppc/ppc440_bamboo.c  | 11 ++++-------
> >>> hw/ppc/ppc4xx_devs.c    | 26 ++++++++++++++++----------
> >>> hw/ppc/sam460ex.c       |  5 ++---
> >>> 4 files changed, 26 insertions(+), 25 deletions(-)
> >>>
> >>> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> >>> index 7d82259..1a28127 100644
> >>> --- a/include/hw/ppc/ppc4xx.h
> >>> +++ b/include/hw/ppc/ppc4xx.h
> >>> @@ -42,11 +42,10 @@ enum {
> >>> qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
> >>>                        uint32_t dcr_base, int has_ssr, int has_vr);
> >>>
> >>> -ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> >>> -                               MemoryRegion ram_memories[],
> >>> -                               hwaddr ram_bases[],
> >>> -                               hwaddr ram_sizes[],
> >>> -                               const ram_addr_t sdram_bank_sizes[]);
> >>> +void ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> >>> +                         MemoryRegion ram_memories[],
> >>> +                         hwaddr ram_bases[], hwaddr ram_sizes[],
> >>> +                         const ram_addr_t sdram_bank_sizes[]);  
> >>
> >> With this change this function does not adjust ram size any more so it may
> >> need to be renamed, e.g. ppc4xx_sdram_banks or something else.
> >>
> >> A better patch title may be
> >>
> >> ppc/{ppc440_bamboo,sam460x}: drop RAM size fixup
> >>
> >> (or without curly braces at your preference).  
> > I'll rename and use this subj as you suggest on v2.
> >  
> >> This is inconvenient for the user because it worked whatever number
> >> they've given but now they have to do the math. So it suggests that what
> >> you're replacing this with may not support all the existing use cases. If
> >> that can't be fixed to allow checking and changing ram size (maybe via a
> >> callback in board code similar to above adjust function returning adjusted
> >> size) it may be OK to drop this convenience for the sake of cleaning up
> >> code elsewhere.  
> >
> > There were few boards that did fix up and in all cases it was to cover up
> > invalid CLI input.
> > Creating callback for fixing user mistake doesn't seems to me justified,
> > I'd much prefer to have a hard error and consistent behavior across all
> > the boards versus being lax on error checking.
> >
> > [...]
> >
> >  
> >>> @@ -699,10 +698,19 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> >>>         }
> >>>     }
> >>>
> >>> -    ram_size -= size_left;
> >>>     if (size_left) {
> >>> -        error_report("Truncating memory to %" PRId64 " MiB to fit SDRAM"
> >>> -                     " controller limits", ram_size / MiB);
> >>> +        char *s = g_strdup("");
> >>> +        for (i = 0; sdram_bank_sizes[i]; i++) {
> >>> +            char *t = g_strdup_printf("%s%" PRIi64 "%s", s, sdram_bank_sizes[i],
> >>> +                                      sdram_bank_sizes[i + 1] ? " ," : "");
> >>> +            g_free(s);
> >>> +            s = t;
> >>> +        }
> >>> +        error_report("Invalid RAM size, unable to fit all RAM into RAM banks"
> >>> +                     " (unassigned RAM: %" PRIi64 ")",  size_left);
> >>> +        error_report("Supported: %d banks and sizes/bank: %s", nr_banks, s);  
> >
> > Do you have any suggestions how to make error message better?
> > (maybe do calculation here and dump all valid -m variants instead of "#bank,size/bank")  
> 
> Listing the valid values would certainly help users who don't know what 
> the constraints of the SoC or SPD ROMs are (which I think most users don't 
> have a clue about and we should not expect them to know). I've also seen 
ok, I'll go ahead with it.

> similar concerns in another response for hppa machines so maybe having a 
> callback to allow adjusting user input to board constraints is not a bad 
> idea. It's not lax error checking but convenience for the average user 
> where board has specific constraints and cannot handle any mem size.
It could be usefull to generalize and probably introspect valid/supported
RAM sizes but I doubt it would be easy to sell a callback for fixing up
invalid user input vs just a hard error.
Anyways it looks out of scope of this series and could be done on top if
there is demand for that.

> Regards,
> BALATON Zoltan
> 


