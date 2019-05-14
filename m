Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773E0C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414F120879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDHb96zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414F120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43854 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQTaU-0003mP-Id
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 05:19:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQTZG-0003Fd-1A
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQTZ9-0006jA-2e
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:17:46 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQTZ6-0006gy-P4
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:17:41 -0400
Received: by mail-oi1-x241.google.com with SMTP id v10so11589716oib.1
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Nt77yL6LQ0dHa46IhCDOR95rom0GAkpLk3NLuu95UIs=;
	b=WDHb96ziYqhrSOsOmaRi7gb9gTJTVYna8xAvaAWjVjxhKilm99o2LQOFqEGxyZzc57
	VKvxvoibhFK/9EZuvyi0yklxTlrTSJrUNMsvY7pPYL51uxZDBGulxr7KNgnwrCOmX5Eq
	qb4uTGxg823/K1us6NoVC9FOeBJNVXy2+19LT4gF1IOVamZPSeelhiJKMOyCeBI9HHag
	YoLLFAj7hcbMygi3pNA6vmAJ9cyRzz3d9n0+E8V0gcUF0761ZYd/lSXt2fxG+i/mjb6J
	uYxwHJfrY5XwxuwD4R+fm14HK29KehucXBpkqygnFoYtyjFw7YgnlnWpxQlZKxigMosE
	/TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Nt77yL6LQ0dHa46IhCDOR95rom0GAkpLk3NLuu95UIs=;
	b=jcspgQ4Saue+6zAs6rvUJM7LSIilVNgFJjx8a+TsZ9c60Xng5XP+pqsM4tqKlf4Axe
	OoAD+PvWLhms3mPMc8/FmsVw5AnLrJ7w9Arc3skvWktEpN2vcC9fzPKD6VQWG5G/DYrx
	l4kNrgYHAgbC1CqE3y587OAZMugHysEkpY/nt2Mm+gvBuncXFaRkS/XdW31+oDIxy5F6
	84v9eIIJHHecszJ2EJqal7El5qZApa0X8c8OzIxFk6501OU2v9DHxDcn0cW4TmwEXWfg
	xnK3IyEQezmW43cya4uUDR1GgZ7LWBeURxyI2jEP+fkaw/RXWXBV7StXST0Xm0ruJqWD
	pccQ==
X-Gm-Message-State: APjAAAVWuEL2hNmmCFtFg/184Cx+gEmEmc/PxZKJOYZx00p2S/DANNaz
	XxM8Vqd6f1TPGi0SG9SYc+kcQ3OrZZ0yM7RmXXufrA==
X-Google-Smtp-Source: APXvYqw6RzvcoxmbCR3kvVTK9WLKp5bYbtxyWSOrXiA21Tfj5DQCEhuVaLtuhGmVmOB6WN5CQPLr12JIKRQyv5ndleU=
X-Received: by 2002:aca:5785:: with SMTP id l127mr2100572oib.48.1557825459368; 
	Tue, 14 May 2019 02:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190514064627.3838-1-clg@kaod.org>
In-Reply-To: <20190514064627.3838-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 May 2019 10:17:28 +0100
Message-ID: <CAFEAcA__w9ZXzvAVemstba1=tU6rpKn73m8E5+vJQaArkZzzVw@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH] docs: provide documentation on the POWER9
 XIVE interrupt controller
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
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
	Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 at 07:46, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> This documents the overall XIVE architecture and gives an overview of
> the QEMU models. It also provides documentation on the 'info pic'
> command.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  docs/index.rst     |   1 +
>  docs/ppc/index.rst |  13 ++
>  docs/ppc/xive.rst  | 344 +++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS        |   1 +
>  4 files changed, 359 insertions(+)
>  create mode 100644 docs/ppc/index.rst
>  create mode 100644 docs/ppc/xive.rst

Hi -- it's great to see this documentation. Unfortunately,
where you've put it doesn't match our intended layout for docs.

Each subdirectory of docs/ becomes its own manual, and
the intention is to eventually have five manuals
(as sketched out in https://wiki.qemu.org/Features/Documentation):
 * QEMU user mode emulation -- docs/user
 * QEMU full-system emulation user's guide -- docs/system
 * QEMU full-system emulation management and interoperability guide --
docs/interop
 * QEMU full-system emulation guest hardware specifications  -- docs/specs
 * QEMU developer's guide -- docs/devel

We don't want to have a separate PPC-specific manual.

Currently we only have interop and devel. I have on
my todo list to try to sort out the others, including
figuring out how to transition from our current set
of texinfo-based manuals to this layout.

I'm not sure exactly where this document should live.
From a quick scan it appears to be mixing together
information aimed at several different audiences --
the "Overview of the QEMU models for XIVE" part looks
like information about QEMU internals which belongs
in docs/devel, but some other parts seem to be user
facing information which should go in one of the
other manuals.

thanks
-- PMM

