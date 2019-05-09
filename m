Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8A5C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC1B216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2Be26l8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC1B216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50929 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeqF-0001DC-4C
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:55:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOeo1-0008Gr-Cq
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOeo0-00077I-K5
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:53:33 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:36607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOeo0-00076k-FD
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:53:32 -0400
Received: by mail-ot1-x332.google.com with SMTP id c3so1597920otr.3
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 01:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=9tgr5jOglCE79HDmTY6YwZ6spoWQSi5fVFVTFdu7qls=;
	b=f2Be26l8j3hnR/LVlMO0rybI4kGtEWkoL8yEiZFUaLUjb1zxgT0mnxQTudpp/dyHab
	KaPpjUagVQOZxLSCBrU7M9DAPswk4+clysciS8Jjlf26ZmfaPbwtwjrn9ZFjyHPpREl1
	LJu07kagdFEE29MWgU4xPEDYkX17VmDeLkR4elYHQmMO9v4s31oH188AbZQgOK4JVEef
	FTjnoh6AKR0YUSLfMxGHrRoMU1Y/xJhDsfbgDW/Dmv6Jy9lYZRO5wjL6I2ZKnmZrPcJ1
	zzEtZebBdOW63gLLIYahPlhmOq02YbxSxBmFgkmTXArRB1AfgBG9ML3rjrZzNmafpSr8
	Rx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=9tgr5jOglCE79HDmTY6YwZ6spoWQSi5fVFVTFdu7qls=;
	b=W1Fel14MkM1WpBG4DUX1n5B4+p9RndoYrv1QIrDiHRldqY0xnQGdNles/DMIdM7hhW
	WGxhG7+XMafylEX1kge/HG+Qg9OJe8VUWxt/UpLrI+5+leZ0aiN8dwZb5bGgN//MNdDJ
	SLrlKvVi3JxnjtTE2gFv6niik5G19u6kDUDoz2L9SkH/HeG4TQcJZXkbucrG9aYZl67Q
	QzHRoGGBIBQBg3T13lCGRoFlDMd4XxTzEUWSlzdoZaoNuE+nbebCfpw6WlvcN3vxJm4b
	wFOVsRZHx1AIi9okmgMxc3OgGZxvFicqVlJupfwrbwU5d2LeVq1m1h0NDkL6craFzUOM
	Dksg==
X-Gm-Message-State: APjAAAU61kLb+jnVzcCvPMVE3He4XxAc2UU7USDZZmXDr/TMqkq9UcSL
	L3UcfYrgQzRHEZ5Sj+3U91wg8EHEKP4eHETpDQVUFA==
X-Google-Smtp-Source: APXvYqwRuP6Eh3oB7IcvNccUE5TaR2e60SOpnmm/ITefMFxN7cHLNlQBhH9syrJiGfa4gBLPtlxPvC3EyIgpCL8YxFE=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr820371oto.151.1557392011274; 
	Thu, 09 May 2019 01:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190502185835.15185-1-laurent@vivier.eu>
	<CAFEAcA9-hAU5dxUmSWtbvrPEXE-nCP1uLvLbOby-_EXZ27o+8g@mail.gmail.com>
	<87sgtv4wjo.fsf@zen.linaroharston> <87imulaude.fsf@dusky.pond.sub.org>
	<87tve53sy7.fsf@zen.linaroharston> <87zhnw58pa.fsf@dusky.pond.sub.org>
In-Reply-To: <87zhnw58pa.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 09:53:20 +0100
Message-ID: <CAFEAcA-s0UYr0VW3ccG07r=BiGCVtDHkRb6yW0X_ev-zAkOxvw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::332
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial branch patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
	Jason Wang <jasowang@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 May 2019 at 09:32, Markus Armbruster <armbru@redhat.com> wrote:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
> > I couldn't replicate the bug with access to my s390 account so I think
> > it might be existing build artefact related which is odd.
>
> Any ideas on how to debug this further?

It's consistently failed for me both times I've tried
to merge the pullreq, on both s390 and ppc (which is
doing a straightforward 'git merge, then do an incremental
build out-of-tree'). Alex has access to the s390 box,
and there's a ppc box in the gcc compile farm...

thanks
-- PMM

