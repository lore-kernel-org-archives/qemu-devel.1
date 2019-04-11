Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE13C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 20:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D312075B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 20:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erK7UiCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D312075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54643 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEgTS-0004Bb-M3
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 16:39:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hEgSk-0003sR-42
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hEgSh-0004Ty-By
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:38:20 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:40782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hEgSc-0003Tq-8i; Thu, 11 Apr 2019 16:38:14 -0400
Received: by mail-lf1-x144.google.com with SMTP id a28so5733476lfo.7;
	Thu, 11 Apr 2019 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=0ev+E7NnXTxi/GAb4MPGNTmPox7j5V2mGeDqP9uJcXo=;
	b=erK7UiCFWKTcM6ye86PlckzbMpJE9EhKZ8nB6vnfZ/SpyHnaM2CVD0qZ2uE//8SgM7
	wHGe2YzIXfp5FWVUDkQMzDqcZIvwonkN4jg6Qazd1RLVprNno3eB6nZqss8LQBS5Go+J
	3J08Zy9roP7yawazzuJnuz8OsyUZB0S0KWbi8nhNV6Zer7FaQvPtWXT61SNAPnXOzB1w
	b9bs0qGslbTQpilgJW6xZXkqlIAo/q9SELMcNn293RcCgxxwHuePtWsT0+TgGRsPYpE4
	yLnnci+MOWSwA4tND2kAXKSlNA7WNrL2FBgQLBnNhpiEtjTlgfo9kbGz2mZygLFaiS0K
	NSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=0ev+E7NnXTxi/GAb4MPGNTmPox7j5V2mGeDqP9uJcXo=;
	b=fcgg6SMcmn3g97Jnc1inFVSYmHD1d3rHC0oNp1kQOTwdK6Jo06/PITNRFzBlWva8ew
	WdvqMqf/aCw9Jyepah2UfxH78mF3+gAcfFEuqWPfGFKVD0tb8eWEW1QXaIDoJNpg73zC
	HfjXET+OnQJlQh7RC45X+H7xwA7+/DbYIsAa2nyXpKW3mLO9C3nBkoQJiYe30qIzkzoJ
	+rnEs6arArolYuGCObF0UCiOuo35Q01q9Qz8dtrBSzIYWpRewx7bStNa2L1wbtQfAouI
	64tqfpepMxkctsOobEXWdDW71JebYUXHqDq5DswjtQVfKotOSDIT+5EXInEgX1B6CAE8
	gfEw==
X-Gm-Message-State: APjAAAWiHqFc5kC8nPOOF2Ln6LUqWL1MDKGDIRRSlUlmCmuFOzmZtp+v
	gLNQM5h8AxOttJkstw8Hyhfg7BfY2Hv3Aur3U/4=
X-Google-Smtp-Source: APXvYqzNTRdaQzwdqWwLuHtO/DILM/LOXWUewWyLqztkitRfGxgEkD/BO4d8YeV8phntgBWbMhsrZWOSHTDZfCECC8o=
X-Received: by 2002:ac2:5326:: with SMTP id f6mr7351331lfh.100.1555015046315; 
	Thu, 11 Apr 2019 13:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<9043c3a6bc54faa98ed9fedc0c6c929c993a0bf9.1554937288.git.alistair.francis@wdc.com>
	<20190411140629.3a672b39@redhat.com>
	<CAFEAcA-oOfZD=tas4QP3SeSOJJ+eM_9o=v05U=scsc78Z4p3FQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-oOfZD=tas4QP3SeSOJJ+eM_9o=v05U=scsc78Z4p3FQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 11 Apr 2019 13:35:49 -0700
Message-ID:
 <CAKmqyKO779w8sYXcwtnJyCZN0TuKOAjUjd_xca4k2wff4vfEHQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3 6/6] riscv: Add a generic spike
 machine
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "ijc@hellion.org.uk" <ijc@hellion.org.uk>,
	"qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
	"palmer@sifive.com" <palmer@sifive.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411203549.Mf5imlYjEO033EKLyTo7ZHSRd8k8L25NLtxx191LEMQ@z>

On Thu, Apr 11, 2019 at 5:18 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 11 Apr 2019 at 13:07, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Wed, 10 Apr 2019 23:11:00 +0000
> > Alistair Francis <Alistair.Francis@wdc.com> wrote:
> > > +    /* register system main memory (actual RAM) */
> > > +    memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
> > > +                           machine->ram_size, &error_fatal);
> > do you really care about migration? if not then _nomigrate flavor would
> > be more suitable.
>
> Every machine model should care about migration, at least to
> the extent of making savevm/loadvm snapshots work. Using
> memory_region_init_ram_nomigrate() is a bad idea in new
> code: it exists only for the benefit of older code which
> is handling the migration of the backing RAM by hand for
> migration-compatibility reasons.

Ok, I'll leave this as is then.

>
> > >      /* Initialize SOC */
> > >      object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> > >                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> > > @@ -254,6 +343,12 @@ static void spike_v1_09_1_board_init(MachineState *machine)
> > >      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> > >      int i;
> > >
> > > +    if (!qtest_enabled()) {
> > > +        info_report("The Spike v1.09.1 machine has been depreceated. "
> > > +                    "Please use the deneric spike machine and specify the ISA "
>
> "generic"

Fixed in v4.

Alistair

>
> > > +                    "versions using -cpu.");
> > > +    }
> > > +
>
> thanks
> -- PMM

