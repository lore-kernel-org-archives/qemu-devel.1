Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FAEC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C642073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C642073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieiQ8-0006g6-0c
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ieiOv-0005Rz-1X
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ieiOt-0006Zn-B4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:30:16 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:56516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ieiOt-0006Un-49
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:30:15 -0500
Received: from player746.ha.ovh.net (unknown [10.108.42.176])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 634AC14F517
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 17:30:11 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player746.ha.ovh.net (Postfix) with ESMTPSA id 608A8D37F922;
 Tue, 10 Dec 2019 16:29:56 +0000 (UTC)
Date: Tue, 10 Dec 2019 17:29:53 +0100
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [for-5.0 PATCH v2 1/3] cpu: Introduce CPUReset callback typedef
Message-ID: <20191210172953.2a99de1b@bahia.tlslab.ibm.com>
In-Reply-To: <87pngw31ob.fsf@dusky.pond.sub.org>
References: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
 <157591411864.46967.18244018296239778673.stgit@bahia.lan>
 <87pngw31ob.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14416866833598159246
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelfedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeegiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.78.111
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Dec 2019 11:39:00 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Greg Kurz <groug@kaod.org> writes:
> 
> > Use it in include/hw/core/cpu.h and convert all targets to use it as
> > well with:
> >
> > perl -pi \
> >  -e 's/void\s+\(\*(parent_reset)\)\(CPUState\s+\*\w+\)/CPUReset \1/;' \
> >  $(git ls-files 'target/*.h')
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  include/hw/core/cpu.h       |    4 +++-
> >  target/alpha/cpu-qom.h      |    2 +-
> >  target/arm/cpu-qom.h        |    2 +-
> >  target/cris/cpu-qom.h       |    2 +-
> >  target/hppa/cpu-qom.h       |    2 +-
> >  target/i386/cpu-qom.h       |    2 +-
> >  target/lm32/cpu-qom.h       |    2 +-
> >  target/m68k/cpu-qom.h       |    2 +-
> >  target/microblaze/cpu-qom.h |    2 +-
> >  target/mips/cpu-qom.h       |    2 +-
> >  target/moxie/cpu.h          |    2 +-
> >  target/nios2/cpu.h          |    2 +-
> >  target/openrisc/cpu.h       |    2 +-
> >  target/ppc/cpu-qom.h        |    2 +-
> >  target/riscv/cpu.h          |    2 +-
> >  target/s390x/cpu-qom.h      |    2 +-
> >  target/sh4/cpu-qom.h        |    2 +-
> >  target/sparc/cpu-qom.h      |    2 +-
> >  target/tilegx/cpu.h         |    2 +-
> >  target/tricore/cpu-qom.h    |    2 +-
> >  target/xtensa/cpu-qom.h     |    2 +-
> >  21 files changed, 23 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 77c6f0529903..047e3972ecaf 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -74,6 +74,8 @@ typedef struct CPUWatchpoint CPUWatchpoint;
> >  
> >  struct TranslationBlock;
> >  
> > +typedef void (*CPUReset)(CPUState *cpu);
> > +
> >  /**
> >   * CPUClass:
> >   * @class_by_name: Callback to map -cpu command line model name to an
> > @@ -165,7 +167,7 @@ typedef struct CPUClass {
> >      ObjectClass *(*class_by_name)(const char *cpu_model);
> >      void (*parse_features)(const char *typename, char *str, Error **errp);
> >  
> > -    void (*reset)(CPUState *cpu);
> > +    CPUReset reset;
> >      int reset_dump_flags;
> >      bool (*has_work)(CPUState *cpu);
> >      void (*do_interrupt)(CPUState *cpu);
> [...]
> 
> Opinion, not objection: such typedefs make the code less obvious.
> 

I merely followed what we have in qdev, but I tend to agree. And, as
mentioned by Peter in another mail, it looks odd to only convert the
reset method.

