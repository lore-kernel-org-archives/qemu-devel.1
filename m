Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF12FC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825822073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825822073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieiUl-0003cT-Lv
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ieiR2-0007aN-2g
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ieiR0-0007pk-Th
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:32:27 -0500
Received: from 4.mo3.mail-out.ovh.net ([178.33.46.10]:49327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ieiR0-0007nm-NB
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:32:26 -0500
Received: from player795.ha.ovh.net (unknown [10.109.146.131])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 364712351D0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 17:32:23 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id AAE00CEFB913;
 Tue, 10 Dec 2019 16:32:08 +0000 (UTC)
Date: Tue, 10 Dec 2019 17:32:06 +0100
From: Greg Kurz <groug@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [for-5.0 PATCH v2 1/3] cpu: Introduce CPUReset callback typedef
Message-ID: <20191210173206.3b599b8c@bahia.tlslab.ibm.com>
In-Reply-To: <CAFEAcA8rVxtHbvEenxRsSFQWY7bE47e060NdxdVPXpCTrEOYHw@mail.gmail.com>
References: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
 <157591411864.46967.18244018296239778673.stgit@bahia.lan>
 <87pngw31ob.fsf@dusky.pond.sub.org>
 <CAFEAcA8rVxtHbvEenxRsSFQWY7bE47e060NdxdVPXpCTrEOYHw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14454021529746184465
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelfedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgepud
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.46.10
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Dec 2019 10:42:51 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 10 Dec 2019 at 10:39, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Greg Kurz <groug@kaod.org> writes:
> > > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > > index 77c6f0529903..047e3972ecaf 100644
> > > --- a/include/hw/core/cpu.h
> > > +++ b/include/hw/core/cpu.h
> > > @@ -74,6 +74,8 @@ typedef struct CPUWatchpoint CPUWatchpoint;
> > >
> > >  struct TranslationBlock;
> > >
> > > +typedef void (*CPUReset)(CPUState *cpu);
> > > +
> > >  /**
> > >   * CPUClass:
> > >   * @class_by_name: Callback to map -cpu command line model name to an
> > > @@ -165,7 +167,7 @@ typedef struct CPUClass {
> > >      ObjectClass *(*class_by_name)(const char *cpu_model);
> > >      void (*parse_features)(const char *typename, char *str, Error **errp);
> > >
> > > -    void (*reset)(CPUState *cpu);
> > > +    CPUReset reset;
> > >      int reset_dump_flags;
> > >      bool (*has_work)(CPUState *cpu);
> > >      void (*do_interrupt)(CPUState *cpu);
> > [...]
> >
> > Opinion, not objection: such typedefs make the code less obvious.
> 
> It's particularly odd here where this class has several
> methods but we've only chosen one to privilege with a typedef.
> 

Yes, children classes don't do the overloading-and-call-the-parent for
other methods which was the initial motivation for the typedef.

> Personal preference: if you use a typedef, typedef the
> function type, not the pointer-to-the-function-type.
> But I would just leave it be.
> 

Thinking again, I'm not sure the typedef really helps here. Markus
doesn't like it either. I'll try without.

> thanks
> -- PMM


