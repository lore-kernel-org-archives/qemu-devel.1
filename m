Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07690C31E41
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BE920859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9aB3IOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BE920859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haLjx-0007xd-2B
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 10:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40742)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haLjS-0007XM-Te
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haLjR-0003Us-L3
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:57:10 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haLjR-0003UW-CU
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:57:09 -0400
Received: by mail-ot1-x343.google.com with SMTP id n2so8539093otl.12
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d+sFl7/oeS84K3Kn4cdiA4k3TUnX0QDKCjpV6d6I0WI=;
 b=F9aB3IOZVqySmN+1IL21jfEmVO98x++2xA2zZwuAFcggg3LltGLRtrwYlEKeTFUVAG
 /blLhKVA0SYpQG2lapKszY22oG7XFe8IXByjGq9rTzOl3PQYwqEG8uVZ/Z8yuCDhAoH/
 aEshfC1ePhJcqspAljURdcqYeM0neFAhiOm5+TyOlHkghtxJPj4J+R+wR13uH8wG8ptS
 UMCgrgQanOe0/T2QnI69P7BuQx49kxn6ZI57LiDcn7mlRPYyxdz/osYRljy8mbg/htGT
 i3QKZFoA7OptuA3VPS3a+cysQ/3s6Oal6VV/TQH29JA8cFo9iAj+ppn9fXaOauEta8w2
 S8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d+sFl7/oeS84K3Kn4cdiA4k3TUnX0QDKCjpV6d6I0WI=;
 b=Fkw4lhsTEb9twGfFpZ1qbCfdF6LiYTthImenzzOwAPU6jeD/QRMBTQs1Pc8slaarcH
 8lvTTT5rYztdzen8Y5J9Qru2WtrJ/hJBlJRO2ngSxZYClYhA6WKnMKRXsoaGK9/SbQDs
 jhaK+roK3NLn5YuWFTuqFb4kz4eedtVbXEYwlXqkFIqa1OoTjEBkb/ZqCwpCmQf/LCeg
 0MgWZw+hZjIaPZhQ9zP5KPwWp/Tfrr7KeBTQBigtNC6eKDx1a39IANn1o9lp4pR0Ycmy
 NSYGZAG2PNkBtFNAKP+ORg+q+eyMnJ9OWwcoXKjsbQlXd86XID7KGzNSfhf1SnaDKqRU
 Nx8Q==
X-Gm-Message-State: APjAAAUjur5yK4jsBNXUr/wb03X5vakw5UYtFZRdcHW7SVKumR4ctDVb
 Mzg6xfqrgy10NtRKVTZtgTkTCaAELMGaKT1rwCJZrR4Cje4=
X-Google-Smtp-Source: APXvYqyRDMS9j5v1uH7FIo9gkmga+Ua3wdO37e0J0jTiJTZapaRQzReQLEBtD6QHjc8SphPRnhoE8LYaXXy6NZnvNL4=
X-Received: by 2002:a9d:630a:: with SMTP id q10mr9166611otk.91.1560178628192; 
 Mon, 10 Jun 2019 07:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190610134545.3743-1-peter.maydell@linaro.org>
In-Reply-To: <20190610134545.3743-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2019 15:56:57 +0100
Message-ID: <CAFEAcA911arQ6QtyD=-LCBtoQO30tkADiGV0fV8Zwn8+wd_GRw@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: Convert invocation documentation
 to rST
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Jun 2019 at 14:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The qemu-ga documentation is currently in qemu-ga.texi in
> Texinfo format, which we present to the user as:
>  * a qemu-ga manpage
>  * a section of the main qemu-doc HTML documentation
>
> Convert the documentation to rST format, and present it to
> the user as:
>  * a qemu-ga manpage
>  * part of the interop/ Sphinx manual
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is part of my general proposals about how we should
> transition away from texinfo to sphinx (written up at
> https://wiki.qemu.org/Features/Documentation). It's the
> first part of step 3 (convert standalone manpages), so it's
> interesting as a demonstration of Sphinx generating manpages
> as well as HTML. The format of the output manpage is broadly
> the same, though there are a few minor differences because
> rST doesn't support quite the same kinds of output. (It also
> fixes a bug where the current manpage renders some text intended
> to be in bold as literally "B<unix-listen>".)
>
> Having the infrastructure for creating a simple manpage via
> Sphinx should be a useful assist for the work in step 1 of the
> transition plan that involves conversion of the auto-generated
> qemu-ga-ref and qemu-qmp-ref (which need to produce manpages).
>
> The non-manpage HTML version of the doc moves from qemu-doc.html
> into docs/interop/ (its final location in the new 5-manual setup).
>
>  Makefile                 |  13 ++--
>  MAINTAINERS              |   2 +-
>  docs/conf.py             |  18 ++---
>  docs/interop/conf.py     |   7 ++
>  docs/interop/index.rst   |   1 +
>  docs/interop/qemu-ga.rst | 133 +++++++++++++++++++++++++++++++++++++
>  qemu-doc.texi            |   5 --
>  qemu-ga.texi             | 137 ---------------------------------------
>  8 files changed, 161 insertions(+), 155 deletions(-)
>  create mode 100644 docs/interop/qemu-ga.rst
>  delete mode 100644 qemu-ga.texi

I just realised that I forgot to update the Makefile 'install-manual'
macro to filter out the generated docs/interop/qemu-ga.8 file,
so at the moment 'make install' will put a copy into
/usr/local/share/doc/qemu/interop/ as well as into
/usr/local/share/man/man8/. I'll fix that in v2.

thanks
-- PMM

