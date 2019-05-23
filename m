Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05FDC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6682081C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtSEzKKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6682081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37418 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToeS-000329-QI
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:25:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hToK1-0008FY-NL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hToJz-0006Bc-Ux
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:03:53 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hToJz-00068x-OT
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:03:51 -0400
Received: by mail-ot1-x344.google.com with SMTP id t24so5477275otl.12
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=/w5Igov04Qn3sR5EoOnVl+vg+to4ToAxYgQaSAYOiAE=;
	b=CtSEzKKF7NVlow8zd8mnHnqu1MnInAHkLKnAxM+RszljNj1PDLktElRyFTIG5fGuCX
	M2paMQjoUHN+0jiKSlODtxHszshxCBgfwe5a1hft95o5rpenRVGOmCpW3LXRdaAQRwhy
	zODKQ4TQlqoJ+/BmFw2JMV7+/irOzT3JAxuosh/ChrQqqUljPb16AgXUBLowp328ei2W
	11PPsVaR55J0rfr6TYevQyYJaaMC4m6gkchME+6W1BEAedzlmR0kGGazaeGIAEu+5SDU
	0gTKs+ZafOvqmETwN9B+cNCoy92A/52S4mA1FidCq1zpbZx0hmhNIs6/tZ2GLuwg/Lev
	9Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=/w5Igov04Qn3sR5EoOnVl+vg+to4ToAxYgQaSAYOiAE=;
	b=kewm5x2UM/us5kw5WOhPaNWguKWY6HArPgGlmm3oMeX4l9yW6lddl63v8IHkF2u6vX
	AZbcZQKNyydyeiUR9qsGcMh//zwBk+aAsVLCko9fuFQ6eGYc+7xo7uErhVvN/+Z2P1Yx
	0S7B8P42J0l4Qu+KgJ543bIy4kccbfpDq56njb7NISBf9+Wtuwr2tXIfWIeqwpzBLEs8
	bAyO4Wmv6zJH7pcXoBu8CZ99Sw9J1Fb+gBezo+xIKyi0hlS/HKFZWQeX4nzRysb8Qrsd
	1lHKGi/ndwDKhTgt8b6A/xTxrKvQvZ04bv/r0vzTqtRqRgy0asDr+bG/ThEbF3oPv0hi
	SXnA==
X-Gm-Message-State: APjAAAUnQ8DzJS1RM77RRqlquPS6nNcM1fVwAF/y6lTbhHRnvEpNrRlX
	1skqqi2saTcoH/Oi/Tgi6RT6e6ZvR69U2KrYHig=
X-Google-Smtp-Source: APXvYqxf1hJRc4WgV3Au7inRrrf0xv/1PDtMVZJJpleLTV0PTEVFgZoMDRUVeGJiXYNemDG0d97uzNctjgzKI/HoZpU=
X-Received: by 2002:a9d:7858:: with SMTP id c24mr330034otm.64.1558620227672;
	Thu, 23 May 2019 07:03:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Thu, 23 May 2019 07:03:47
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Thu, 23 May 2019 07:03:47
	-0700 (PDT)
In-Reply-To: <CAFEAcA_gW9PZFTB42LRXCPcD+aiWBdH3TQX7nHad_5=ioRm-ug@mail.gmail.com>
References: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAFEAcA_gW9PZFTB42LRXCPcD+aiWBdH3TQX7nHad_5=ioRm-ug@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 23 May 2019 16:03:47 +0200
Message-ID: <CAL1e-=gaTv8rAFyN89OOoob8G1LpwtNGrvtaCnrMVT8G_2vbOQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/5] linux-user: Support signal passing for
 targets having more signals than host
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	=?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <milos.stojanovic@rt-rk.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 23, 2019 3:46 PM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
>
> On Wed, 22 May 2019 at 19:57, Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
> >
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Most of the targets (including Intel) define 64 signals. This
> > creates difficulties for targets that define, for example, 128
> > signals. This series adds support for signal passing even if
> > the host defines less signals than the target.
>
> Could you elaborate a bit on how much functionality
> is provided for signal numbers which the target has
> but the host does not? For instance, it seems likely
> that attempts by the guest to kill(other_pid, sig) will
> fail if sig is not in the supported-by-the-target range.
> But is it possible for the guest process to deliver
> one of these signals to itself ?
>
> This patchset is interesting because in fact pretty much
> every target supports more signals than our host code
> can provide, because the host libc steals several
> signals for its own purposes and QEMU can't use them.
> Being able to multiplex several guest signals onto
> one host signal might let us run some guest binaries
> we currently can't handle correctly.
>

Hello, Peter.

I would ask the author, Milos Stojanovic, to provide us with details you
asked for.

I am here just the integrator and the submitter, and even though I could
perhaps answer your questions accurately, I would prefer Milos as the main
person to talk to.

I would like to add that this series is already in exploation here in Wave,
for some internal projects involving QEMU. People are happy with it, it
solved some long-standing problems, and there is no known open issue
related to this code.

The solution has its own limitations, as is spelled out in commit messages,
just to keep your expectations realistic, but overall I find it incredibly
useful, and very good, given the complex problem it tackles.

I would like now to pass the =E2=80=9Cfloor=E2=80=9D to Milos.

Yours,
Aleksandar

> thanks
> -- PMM
>
