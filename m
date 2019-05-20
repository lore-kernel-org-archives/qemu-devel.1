Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C446C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 14:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE574216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 14:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8mp543I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE574216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36632 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSjTg-0003V1-Kr
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 10:41:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSjSk-000336-9k
	for qemu-devel@nongnu.org; Mon, 20 May 2019 10:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSjSj-0007Rd-7P
	for qemu-devel@nongnu.org; Mon, 20 May 2019 10:40:26 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hSjSj-0007QO-1y
	for qemu-devel@nongnu.org; Mon, 20 May 2019 10:40:25 -0400
Received: by mail-oi1-x242.google.com with SMTP id z65so10126826oia.11
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=01IjuQnP+T/Ox6Q/qbRtTUWD8wy88Jd8EHB679M1VfI=;
	b=Q8mp543IqMKZr2UqYl62Das/T5KMTQfRNWDJIDqwwb+nXLjGtoahLWZuAoMoPK7ztA
	XZvaXNUTHJ7wPxsVwA/QhrX0gEcBLfn7C6oDfdhZ8H6FCLDrToWI0jlXqyiS+7thjBid
	hNKMbD/ZE7+29TrVoYpvEb/lZkl7Lh2zlOhvCn0QDY/+vrlW6vjh8p4TBqrKrHQjPfAx
	xr8FjBGL1J5DAPYrEC38tqJEQzT/rGc/qStkjvXnY7l8NnRz4fgOrPmHndhUivN0pU4S
	D9V7ifvQcQFCDtWQoBARmRfyb/a2y789n+qRImnpii/IODiO+6xiC/nkj9fUbT2i0/EO
	CNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=01IjuQnP+T/Ox6Q/qbRtTUWD8wy88Jd8EHB679M1VfI=;
	b=IUqc8VatHX4yzDJLDQqpI2xAEamkwNOZsIve01aWx2/Bs4xcvITCEnDvv0r3drzxme
	+XFB1hd6yaGEPUCZ9LMZXQZ3qZ7CCrKfqAaWvt6W1dz2JBHAEXFn0wVdUc6rYc2eDCm/
	TUvk0FoN7Lh4A9CUnAmYRluJedi9B20sAVYOWZLmCkgE6oiAEgXdN43z71ogMMMXaUL7
	pm+J57+jCsUEOeo2cGioEYPLWAxmMHq5gK5cl1kQWg/qqFEzkU394GTyklFPXFJz/R97
	HVpTuloDBdwe8DKnaB/cx1D+PgxTS8Z5ck42mnl/AZU5CVoduAP0Hvce4VDfCZhrs4Pm
	RDAQ==
X-Gm-Message-State: APjAAAXOSdPaEj2yalhACsyJbtiIVfc0hySjSRA3jeCZsQD1Cre/1mRX
	vRo+rSON3OMqKJcUHOUUkXa0kYyfr/owMXPlO9Ra5g==
X-Google-Smtp-Source: APXvYqzl9zZYtlfeZIQHk9f82mUScdmx903y4HLG1DVyf7R7WBQtFo6tWVhjLejPCMxywbpPKNuH/6hG5o7NNmwa1vo=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr24595988oif.98.1558363223460;
	Mon, 20 May 2019 07:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553510737.git.damien.hedde@greensocs.com>
	<CAFEAcA-84KBmZhRqugQzmEkWVcFBuSAdLtp_HGjRxLeVj1SLXA@mail.gmail.com>
	<dac12db2-9583-4a30-2188-e5b101e13ecf@greensocs.com>
In-Reply-To: <dac12db2-9583-4a30-2188-e5b101e13ecf@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 15:40:12 +0100
Message-ID: <CAFEAcA-rBZRRV9GtUvD5qoYA5Fos_LwSq0cHBgRqtu-G6uEWGA@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [RFC 00/17] multi-phase reset mechanism
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
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Mark Burton <mark.burton@greensocs.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 at 15:32, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Hi,
>
> On 5/16/19 2:41 PM, Peter Maydell wrote:
> > Handling migration of the bus base class reset count is a little
> >  awkward -- we'll need to put it in a vmstate subsection which
> >  is part of the vmstate of the device which owns the bus.
> >  (I talked to David Gilbert on IRC about this and have some
> >  possibilities for how to do it, but will postpone writing them
> >  out until we've decided whether we like the APIs.)
>
> If:
>   1. we say we cannot use a Bus as holdable reset entry point (we can
> reset it but not (de)assert_reset it without passing by its parent Device)
>   2. if there is no additional reset dedicated state (right now a reset
> on a bus mostly propagates it to sub-devices)
> Then we have no state migration needed for buses and we can probably
> find a way to use the parent Device's reset_count.

Yeah, I thought about this, but I decided I didn't like having
"there's a Resettable interface but you have to know that
some implementations are special and it's not possible to
do the same things with them you can with some others".
Implementing migration of the child bus reset state as part of
the parent device's vmstate is a bit tedious but not impossible.
(Basically in the parent device's pre-save function you have
to create a temporary array, populate it by walking the list
of child buses and looking at their reset flags, then migrate
the contents of the array, and in post-load you do "walk child
buses and fill in the reset flags from the array". There's a
VMSTATE_WITH_TMP macro that can apparently assist with this.)

> This is somewhat related to the API TRANSITION part below but I was
> wondering if I should add some kind of flag in the interface class to
> indicate the support of "migration-during-reset" functionality. It could
> be used to at least warn when trying to hold the reset state in such an
> class.
> This flag will default to false and one would have to set it when
> implementing the functionality for a given object class (like I did with
> the cadence_uart device).

I think that migration-during-reset should Just Work, without
necessarily needing any specific changes for a device.
I'm not sure a warning that only prints when the guest does
something to cause device-reset is going to be very helpful:
what would be the thing that the warning would tell us we needed
to do?

thanks
-- PMM

