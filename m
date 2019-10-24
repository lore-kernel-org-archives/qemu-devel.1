Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AC9CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8E8205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+uUksne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8E8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcb1-0006s1-Vp
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iNcGn-0005Uu-J7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iNcGl-0003si-0N
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:31:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iNcGj-0003q4-Ty; Thu, 24 Oct 2019 08:31:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so25448912wrb.2;
 Thu, 24 Oct 2019 05:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=19BvcLrhC04drBgyMJbcXDRsFfZF8OsuOsMBpt+cX/g=;
 b=f+uUksneANaoDpO9i7UyLisFVxC0Sj76AGpkDqqLr4sTS6UCxGCrKFnASzMrhjmefR
 dXr2xJ6a5s5dsfQUeAxovjppld3/tqcP9PNYLwDx0TTEAkOFSuDAJWOR1QdOxJHZOSMG
 Yt7GZpXB2UKV3HwuLOHJT3Bi2UApYeupj9IJLgOLxzcR0CgZFU3OZGeHeUZAfCY4EgmN
 ao3xXdLBGDzqmsFsHejXA2yOOchKt9m0EgMfd+D2cRTm7gArQjhB6C6EMTsYJWH0k09g
 Ggtrb2ukJRx9lDua2ZPjSNKCpVlULGEL4Y2L+bcAcqMgmSj4P5VibfAyFyXtY1YXEkn/
 0kcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=19BvcLrhC04drBgyMJbcXDRsFfZF8OsuOsMBpt+cX/g=;
 b=O3O1oDcBsW7JVm5d4JPcR0EpyMj2Hr6U/V7LyGOBScDXLPd2uZV+gf4ZuXTYzAsQrj
 rEOzLCg4hOf1zAb6fVdGqxRDSZFoTrWiqaZkAIB7+Ol8IQJQYso1Ui4zMSPwNBrvXwrL
 Iun9SYZ+jn0nBPNfcq/VjqhyFJ5rbJ3qTPlTLOarbCgnwECeA5GG8wfNBW7ar1FfiWSZ
 mpuNFWWBsaoIR4ETqR7R/+UHKL7WU6i5jLs9vLhuAQoYc1QGDJR2G6U6zTsN3YN7QUbE
 Goajv/UY1V68kRpfE0Z0mY8Dg3HlAXleL2B70yu69UfoYGZgIGkpqlK79qsAhj0/+RDy
 KHFA==
X-Gm-Message-State: APjAAAVwdY+WLpf2AtpiI6a0QS9W5XeYRSzXkwf3KB5ORJEdcSy+GkBu
 8uqSruymT1+xWV2VTW6NPy0=
X-Google-Smtp-Source: APXvYqxOEb7S0xXQCghJ+c1+W4+brbvJ1Wk03KzYHLtNGIIKOe47y0qgaBtNpdZxrBnW5kbqbXIGhQ==
X-Received: by 2002:adf:dc42:: with SMTP id m2mr3858484wrj.314.1571920267000; 
 Thu, 24 Oct 2019 05:31:07 -0700 (PDT)
Received: from Icho (x590ef5e8.dyn.telefonica.de. [89.14.245.232])
 by smtp.gmail.com with ESMTPSA id a13sm26827645wrf.73.2019.10.24.05.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 05:31:06 -0700 (PDT)
Message-ID: <7aa51490869f8bbb8f5122b07e42a6c1f7da56ee.camel@gmail.com>
Subject: Re: [RFC PATCH 14/14] hw/arm/raspi: Add the Raspberry Pi 4B board
From: Esteban Bosse <estebanbosse@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Date: Thu, 24 Oct 2019 14:26:59 +0200
In-Reply-To: <CAFEAcA9JXbqnKKK+m-7=FThXTa_x_kxRsvtwONWA69C2nb0=FA@mail.gmail.com>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-15-f4bug@amsat.org>
 <c8a8c7758104a1a5fe052743b5a22d3a1353de91.camel@gmail.com>
 <5f1dd044-2909-767d-5a79-8a40d330e129@amsat.org>
 <CAFEAcA9JXbqnKKK+m-7=FThXTa_x_kxRsvtwONWA69C2nb0=FA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: =?ISO-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El jue, 24-10-2019 a las 10:07 +0100, Peter Maydell escribió:
> On Tue, 8 Oct 2019 at 10:04, Philippe Mathieu-Daudé <f4bug@amsat.org>
> wrote:
> > Hi Esteban,
> > 
> > On 9/29/19 5:53 PM, Esteban Bosse wrote:
> > > > +static void raspi4_machine_init(MachineClass *mc)
> > > > +{
> > > > +    mc->desc = "Raspberry Pi 4B";
> > > > +    mc->init = raspi4_init;
> > > > +    mc->block_default_type = IF_SD;
> > > > +    mc->no_parallel = 1;
> > > > +    mc->no_floppy = 1;
> > > > +    mc->no_cdrom = 1;
> > > > +    mc->max_cpus = BCM283X_NCPUS;
> > > > +    mc->min_cpus = BCM283X_NCPUS;
> > > > +    mc->default_cpus = BCM283X_NCPUS;
> > > > +    mc->default_ram_size = 1 * GiB;
> > > The comercial models are: 1, 2 and 4 GiB. Why do you choose 1 GiB
> > > as
> > > default?
> > 
> > Well need one default, and 1GiB is the least beefy :)
> > You can start a VM with more using the '-m' switch.
> 
> Among other things, a 2GB or more board will fail
> 'make check' on a 32-bit host, because 'make check' tries
> to start all board models, and 32-bit hosts can only
> handle up to 2047MB of guest RAM.
> 
> thanks
> -- PMM

Understood, thanks again for the info :).


