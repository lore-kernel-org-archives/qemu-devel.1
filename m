Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_FUZZY_SPRM autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4934DC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 23:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1412320835
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 23:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVieuqQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1412320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35459 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNnHk-0003MO-RG
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 19:44:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hNnGp-00031f-Fg
	for qemu-devel@nongnu.org; Mon, 06 May 2019 19:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hNnGo-0004ld-Hg
	for qemu-devel@nongnu.org; Mon, 06 May 2019 19:43:43 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:47010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hNnGm-0004kS-Cu; Mon, 06 May 2019 19:43:40 -0400
Received: by mail-pf1-x444.google.com with SMTP id j11so7569173pff.13;
	Mon, 06 May 2019 16:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=QTTDdJDp/NVF6lNSbKsh7y74AuxkpcAS/Y7LLwzyp68=;
	b=nVieuqQpKOX2eOOQhA/qAtmofweu1jf2PDA8EaBVOEyc+INK0SbZs91R5KuuPaaS4P
	i0cX10s+y5+ImZvm4a79an2COkhttUp3m5J9qBTLeKqS+ZhlZUHZq1wdlxcet5qNHsFx
	BEibgCPKLnYf7KfHpKsrQhFc2MDvDCOoniqU580DNM8Or/mg8HK6Wzgdl/e9TCFclNZ/
	usDIEXS6PcMWorE0cFtyVm81KAgVjQNfpkEMUF0kmoqFom28ojwnVoYqIpRdP86hlp4J
	pnlsXYX4GDwiF9VS4iFLMU5L9sdyfx1gr8Fra/qu/OIEw+cY9F6pZs8EoaFIBAfzfsWN
	pbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=QTTDdJDp/NVF6lNSbKsh7y74AuxkpcAS/Y7LLwzyp68=;
	b=BlHeeNvmFB7+IJXvqY8/02dbw5Yp7rHyLOJIW2+k2tBbC3kSM2KUM2Lz87fpsWxf/O
	E5xC+uk2WOC5CXTgfUHfNkMiTsLSTZ56T3+5NXdFDLs5ffw3vJuk3fCjR/Iku9evjnY/
	PrCO8Pjn4eTEQPXb/K+H7eFElFQtFQwPd0RhtafOOo6TFxlhQD2pwr5LL+iJNUqLuV0r
	M4eN7Z6H1zE/e2QHueA3b+8Qvfiz8XFEA8n6gPsZ4rl4A2h9yoaXPmA8ie1nf0rIyoz0
	C+ZmsxtNszRNm2B40GEy23wjJZrORT5r6a/bAuoV9b650Y9lOj11pMsFREmlB4GsNC3E
	MYgA==
X-Gm-Message-State: APjAAAU2q2xmyH+J+zZhZLIcBFn/TDyzhGcUhfKj0bhjd6WklkGjhL9v
	qsLj3PT8p2vonHTIcoLxzGQ=
X-Google-Smtp-Source: APXvYqyslDf12FzV+rbebQONIDq245m7CXJiM+YiX6LlyXuEoOX/78XvkLwIOrb2mtPWadpKfkDaeA==
X-Received: by 2002:a65:5bc3:: with SMTP id o3mr36672894pgr.40.1557186219044; 
	Mon, 06 May 2019 16:43:39 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
	by smtp.googlemail.com with ESMTPSA id
	p2sm7669585pgd.63.2019.05.06.16.43.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 06 May 2019 16:43:38 -0700 (PDT)
Message-ID: <1557186214.6435.2.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 07 May 2019 09:43:34 +1000
In-Reply-To: <20190506032304.GB6790@umbus.fritz.box>
References: <20190506014803.21299-1-sjitindarsingh@gmail.com>
	<20190506032304.GB6790@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH] target/ppc: Add ibm,
 purr and ibm, spurr device-tree properties
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-05-06 at 13:23 +1000, David Gibson wrote:
> On Mon, May 06, 2019 at 11:48:03AM +1000, Suraj Jitindar Singh wrote:
> > The ibm,purr and ibm,spurr device tree properties are used to
> > indicate
> > that the processor implements the Processor Utilisation of
> > Resources
> > Register (PURR) and Scaled Processor Utilisation of Resources
> > Registers
> > (SPURR), respectively. Each property has a single value which
> > represents
> > the level of architecture supported. A value of 1 for ibm,purr
> > means
> > support for the version of the PURR defined in book 3 in version
> > 2.02 of
> > the architecture. A value of 1 for ibm,spurr means support for the
> > version of the SPURR defined in version 2.05 of the architecture.
> > 
> > Add these properties for all processors for which the PURR and
> > SPURR
> > registers are generated.
> 
> So.. what does the current empty property mean?  Is it just wrong by
> spec, or does it actually mean something incorrect?

Af far as I can tell, an empty property is invalid according to PAPR.
A level value is required to communicate the level of purr implemented.

Should probably have:

Fixes: 0da6f3fef9a "spapr: Reorganize CPU dt generation code"

> 
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  hw/ppc/spapr.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 2ef3ce4362..8580a8dc67 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -500,7 +500,10 @@ static void spapr_populate_cpu_dt(CPUState
> > *cs, void *fdt, int offset,
> >      _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
> >  
> >      if (env->spr_cb[SPR_PURR].oea_read) {
> > -        _FDT((fdt_setprop(fdt, offset, "ibm,purr", NULL, 0)));
> > +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,purr", 1)));
> > +    }
> > +    if (env->spr_cb[SPR_SPURR].oea_read) {
> > +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,spurr", 1)));
> >      }
> >  
> >      if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
> 
> 

