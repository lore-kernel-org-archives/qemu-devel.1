Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910E1C282CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5693A2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uB3A2tMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5693A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48001 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEYgs-0006yz-CM
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 08:20:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEYfJ-0006Ni-Ko
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEYfH-0001q7-Me
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:18:49 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEYfE-0001mU-2k
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:18:45 -0400
Received: by mail-oi1-x241.google.com with SMTP id l203so4698659oia.3
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=5uDn2ZUjwTyOqfDEKC5PGB65jziL38BFw27hm01Tnro=;
	b=uB3A2tMUhvUkfXdbmXmds+5m0eo7PbAq2vCNG/tfMnsPAx5TSEKLLXg6GjgJWj2cxT
	ovW9NuLcwNmXVTAgeShePvpFJKnGNfcs5qkTuS/9dO8WHgmaCs5PiafjWcv7t5s81A9/
	t1YQzq3cmNzrs6kjg6VmnSRmC9ZsiDQQ5SqZm88GB9lsiKi1eN0IIo39yKiWelSboHFn
	81JA3C3GUraKaotzFgXXc+3fYeyf9WwEpGA+YYjUtmEjhPDcK7/X19yqG1RPb75RGIVp
	ydLaleLdwNeC3uzuQ0zgPacWCrZA9Fwmev0YZJr0pPUOUYJHCDtPypPiQbRoUhqeCM5N
	+1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=5uDn2ZUjwTyOqfDEKC5PGB65jziL38BFw27hm01Tnro=;
	b=Z/SqCLLl4kiMoMcjqL11rzsypWil/IP2WItOjkPWs2zzsujsCoCofpdiPr0CtVjrDV
	zl4TFil/6++cPs5TJjJ3MQseafLw1rhZH5S+VLHy3z3zq4fo30FM0/VfygcH2esg0StW
	0YNror2Zq/auHtE0mbvlm5oKx8hjVciYjMfQqDc58dwccA7tKHF7jFSypPIXwe0Yl13U
	VGtRokQF5TvSM77q3HmRdTDxJrQeVIU43GrMwWjGMbIim8Z58eDeFCTdT96h9NyTbR6W
	kjpBgSqTqRR+iZGpQ0xsZkqtrL4JYaodr6HWBko0szLRzC4AZdbCErG09LvBNeTs8+fp
	Ibtg==
X-Gm-Message-State: APjAAAUgxmDp9i/mf6/Reu/uAdGeH1qlRP7k83LgzXtWjswixpLG9Ebv
	vhgHyWoulWHUiArvziiMOpC8kLJjf9VAa4XlMGrzRw==
X-Google-Smtp-Source: APXvYqwoJCLsDnUs9nsSHz1AfXCGntkb4a6dm7kQoNg/yXwiShyGXXazL7vKnPOidT/ohDPEHo2mkicXTJ7LdJNZKQI=
X-Received: by 2002:aca:e84c:: with SMTP id f73mr5957965oih.163.1554985121752; 
	Thu, 11 Apr 2019 05:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<9043c3a6bc54faa98ed9fedc0c6c929c993a0bf9.1554937288.git.alistair.francis@wdc.com>
	<20190411140629.3a672b39@redhat.com>
In-Reply-To: <20190411140629.3a672b39@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 13:18:30 +0100
Message-ID:
 <CAFEAcA-oOfZD=tas4QP3SeSOJJ+eM_9o=v05U=scsc78Z4p3FQ@mail.gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
	"palmer@sifive.com" <palmer@sifive.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"ijc@hellion.org.uk" <ijc@hellion.org.uk>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411121830.p4TQW0RKry2qVXofjsG6gCoi0D79W2YhyTvCz8XNAEk@z>

On Thu, 11 Apr 2019 at 13:07, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Wed, 10 Apr 2019 23:11:00 +0000
> Alistair Francis <Alistair.Francis@wdc.com> wrote:
> > +    /* register system main memory (actual RAM) */
> > +    memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
> > +                           machine->ram_size, &error_fatal);
> do you really care about migration? if not then _nomigrate flavor would
> be more suitable.

Every machine model should care about migration, at least to
the extent of making savevm/loadvm snapshots work. Using
memory_region_init_ram_nomigrate() is a bad idea in new
code: it exists only for the benefit of older code which
is handling the migration of the backing RAM by hand for
migration-compatibility reasons.

> >      /* Initialize SOC */
> >      object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> >                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> > @@ -254,6 +343,12 @@ static void spike_v1_09_1_board_init(MachineState *machine)
> >      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> >      int i;
> >
> > +    if (!qtest_enabled()) {
> > +        info_report("The Spike v1.09.1 machine has been depreceated. "
> > +                    "Please use the deneric spike machine and specify the ISA "

"generic"

> > +                    "versions using -cpu.");
> > +    }
> > +

thanks
-- PMM

