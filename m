Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07933C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA590215A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwd8kzWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA590215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j192I-00036N-13
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j191N-00020I-N0
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:22:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j191M-0001xa-DI
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:22:41 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j191M-0001xA-6h
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:22:40 -0500
Received: by mail-ot1-x344.google.com with SMTP id z9so6268754oth.5
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 05:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SouamPx12wRHQqmxczl9h06Bf7YeoyaS4yJDJANfOQE=;
 b=gwd8kzWl5imjCR689lNHMW5Gg8lMn/yzC/W5Ow84iMoICKRFQgB/WOkyu0ci2hHm1/
 poND4eZyQN3hD/pB+DtxCGsMY0tL+t5qMsQvaw8rVx4ESR8OEdFXhphNUAJKGIZxU3Pk
 APZj9YIf3OY1LaEhjDnGF9TZAORjsg1OnhafZXAkuR9adMsmwe4D713VY/sOjP/IHNOd
 IuKfu7nVxMDhU9czbN2T2wUgs4bI80rAS3w0CZG4170ThTj/VIIUesyWtOY79+W9rX8t
 gncOvagwXEuLwynB6VbOBh69Q1Bl3ansyHoeELyEn35T2XhOL5ypJzvrFF3YTZNxyQuM
 hkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SouamPx12wRHQqmxczl9h06Bf7YeoyaS4yJDJANfOQE=;
 b=U/b+Eqmcbrr1yA7gSkrvZxiLNP+8Yqp/6nUk+jP+8PUQLA5zFLRBOMA5UCUdUlzvtW
 CHkf4oNWgpxbN7rUn80CRd42gl4H3fQCSNTIO8sFl3LLV40TnVwcs9ulin+G40BbnM6A
 MkG5ENnPMn6n6xKTrtjJtnvGSLKTI0ecgiTiEJrABW6B+RQXOB4uzvih/Y3g1H92XQnp
 bbeoEnDn+yM6CrM7Ng1Zrs4jNlg1ikgIiO0Sr6vjdr6qrNuPACxSyfQwBH4vfepghsuL
 n1BNahQxRRo1d50HZsPHMOg46iu3rOjY+gtEcVnCYN0J7a/wWbZJ04c8OZ91P1YI0psE
 393A==
X-Gm-Message-State: APjAAAUFj4R9PhL5+vtWIdY/NTjKYIjsOoIs0/5UNIp4gjKPN/9uI2L1
 57u/j0lFKsacCptIASCh2+FE16vvUfNZ0JW6JDojwg==
X-Google-Smtp-Source: APXvYqw78UUzOkHSdrWL18YHv/YFNl4t1uWmNtBAs3JogrMLwh6hw3Tkg01WQ7nrOQc4bSRoLn8Q39KA746/d6Y2RlI=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr1062906ota.232.1581340959077; 
 Mon, 10 Feb 2020 05:22:39 -0800 (PST)
MIME-Version: 1.0
References: <20200207161948.15972-1-philmd@redhat.com>
 <20200207161948.15972-2-philmd@redhat.com>
 <9590e020-226d-bc85-e496-95b4f0116f69@redhat.com>
 <e4157357-7697-a2d5-8662-f5bd12d74619@redhat.com>
 <f7b72c47-4202-d220-7b29-bd5ad6283700@redhat.com>
 <c775db8c-63ec-e88a-f643-63f31de26f2b@mail.uni-paderborn.de>
In-Reply-To: <c775db8c-63ec-e88a-f643-63f31de26f2b@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2020 13:22:28 +0000
Message-ID: <CAFEAcA_evEqBg160MWASS1izoMkEF7-7nnRn9xhpBJVPb5ehOQ@mail.gmail.com>
Subject: Re: Tricore default machine
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x <qemu-s390x@nongnu.org>, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Thomas Huth <huth@tuxfamily.org>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Feb 2020 at 12:33, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
>
>
> On 2/10/20 11:26 AM, Thomas Huth wrote:
> > On 10/02/2020 11.08, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 2/10/20 10:35 AM, Thomas Huth wrote:
> >>> On 07/02/2020 17.19, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> I wonder whether we should simply make that machine the default for
> >>> qemu-system-tricore? There is only one machine here, and not having a
> >>> default machine always causes some headaches in the tests...
> >>> (see e.g. tests/qemu-iotests/check for example)
> >> Or make it generic? If a architecture has a single machine, use it by
> >> default?
> > Sounds like a good idea, too ... we've got a couple of targets that hav=
e
> > only one machine.

> As far as I remember, I did not make it the default machine, since Peter
> Maydell advised against it. His argument was that defaults are really
> hard to get rid off since external tools (like libvirt) might rely on
> the defaults and we don't want to break those. Anyways, no objections
> from my side.

Yes; we have default machines partly for historical reasons
and partly because x86 does, but unless there's a good
reason for some architecture why this specific machine
should be the default, I don't think we should have a default:
making the user specify what they actually want helps to nudge
them into thinking about what they do want, rather than
assuming that QEMU will somehow magically be able to run
guest images built for any random machine for the architecture.

Anything in tests or whatever that breaks if there's no default
machine for the architecture should be improved to handle that
(it already needs to handle that case, though: arm does not
have a defined default machine).

thanks
-- PMM

