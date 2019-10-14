Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D9C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3FB20673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVlmXMyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3FB20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJz73-0003Zb-Bd
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 08:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iJz3z-0001Xl-CI
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iJz3x-0000EP-PY
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:02:58 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iJz3x-0000DS-GA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:02:57 -0400
Received: by mail-oi1-x243.google.com with SMTP id k20so13513081oih.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hg+o/955aBq74DJogkOqR1JcpcJgUUKPGuj/QUQfQi4=;
 b=cVlmXMyq6+K5LWlutO6LxX7BMXoRZjMHOGqYPsPoV4jCQbe55XfGmDSFpKZIwsU1Wc
 dcwUXTpse7efIRn3S3RomYiMRwCqf0cffI/caN8zS/3c1jzxo8UZ6HSbJEgYdUKxTUE1
 bKvPle5eThar62z7hqGG88QPAW3a89Hbwgpac3HKLMzCqZtCzA6wemqHfeVDwPdso0aM
 Ft/Is67AAExiCxabs0Phu98XR3OYC61Je6MbuRFYGdPrkoNX3ZRivhSNRHrgxMjPWU2k
 4fwVDZ17dkgebVf7nVyIAzqH3lfhJqnZx1hlyNEI39XD//02wj0sw3vlW+f8SetGAfZN
 WYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hg+o/955aBq74DJogkOqR1JcpcJgUUKPGuj/QUQfQi4=;
 b=B7aYs717dVZQxYk8J6vT4fhYsR79kujAKXAYTM08es1vgNj+F7gMv1gru9JV3i49L/
 iyF4t3VvnWJlbQUsqAdjVgW4HyaHkxK1GmAJLYpNOn+VWrIAmBO4Pq95rgzYDPGCW3sp
 zL4XUYC/vUEIcc9eEtDuEc7dyL3Ga6IuHPKZTAoc0tkve2K9GUBf00ezzdTQpFgmu0sI
 zJIbdJrqTlwdVCpXZY1/jcqy6HreOR1c671woPbsWanowD0OE6M5jZnX/29m/4CyQxuH
 x9WMy1giohXpOkhWNDTcZNka4/R1RORaszlET6O5SDr74ckC9MC2BJchE0LCdIKOFFwx
 xMng==
X-Gm-Message-State: APjAAAXKtkeVF40cMZ7KYi9doq+JV53eFqIgc+0LzW+PJ26DUnO6GbLV
 iaVh7WUEhN4jNrvgAZYuUO9ixHMgijlLEtwjHtDljw==
X-Google-Smtp-Source: APXvYqwrlgMG1GViULZGpf+hAn6822DW4mQGcTQEYjspCVGPBNma5I46oynw3RkgyEi0yQ+hH5+f0U5QBT7sIX3j7Fo=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr22896073oik.146.1571054576289; 
 Mon, 14 Oct 2019 05:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <157087059993.19261.12706853972165466894@37313f22b938>
 <00a6687037f90374605d8f4f69b9d2b3d614040b.camel@intel.com>
 <20191012135158.GN4084@habkost.net>
In-Reply-To: <20191012135158.GN4084@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 13:02:44 +0100
Message-ID: <CAFEAcA8x-6zsz-aZShCheOnE_d-VnvJ9u7=0qmxXStBF7EUsNg@mail.gmail.com>
Subject: Re: sphinx-build parallel build failures (was Re: [PATCH v3]
 target/i386: Add Snowridge-v2 (no MPX) CPU model)
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Xiaoyao Li <xiaoyao.li@intel.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 12 Oct 2019 at 14:52, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Sat, Oct 12, 2019 at 07:40:30PM +0800, Xiaoyao Li wrote:
> > On Sat, 2019-10-12 at 01:56 -0700, no-reply@patchew.org wrote:
> > > Patchew URL:
> > > https://patchew.org/QEMU/20191012024748.127135-1-xiaoyao.li@intel.com/
> > >
> > >
> > >
> > > Hi,
> > >
> > > This series failed the docker-mingw@fedora build test. Please find the testing
> > > commands and
> > > their output below. If you have Docker installed, you can probably reproduce
> > > it
> > > locally.
> > >
> > > === TEST SCRIPT BEGIN ===
> > > #! /bin/bash
> > > export ARCH=x86_64
> > > make docker-image-fedora V=1 NETWORK=1
> > > time make docker-test-mingw@fedora J=14 NETWORK=1
> > > === TEST SCRIPT END ===
> > >
> > >   CC      stubs/machine-init-done.o
> > >   CC      stubs/migr-blocker.o
> > >   CC      stubs/change-state-handler.o
> > > make: *** [Makefile:994: docs/interop/index.html] Error 2
> > > make: *** Waiting for unfinished jobs....
>
> This looks like the sphinx-build parallel build failures I am
> also seeing in my builds:
> https://github.com/sphinx-doc/sphinx/issues/2946

Could you send your workaround patch:
https://github.com/ehabkost/qemu-hacks/commit/569f1dcb5764fccd5942ebbe39d3a8ed91cd632b
to qemu-devel? It seems like a reasonable way to avoid
the problem (just use different doctrees) and less complicated
than trying to serialize the two builds in the QEMU makefiles.
I think my only review comment would be to add a couple of
comment lines to the makefile, something like:
 # Note use of different doctrees for each (manual, builder) tuple;
 # this works around Sphinx not handling parallel invocation on
 # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946

so we don't forget why we had to do this.

If you do that you can add my
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
tag when you send the patch.

thanks
-- PMM

