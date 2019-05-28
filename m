Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C297C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559BB208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u44uJ5m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559BB208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40879 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVgwY-0003il-G6
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 14:35:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVguX-0002KB-U6
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVguS-0007KN-B6
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:33:18 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:32838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVguO-0007B6-Nb
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:33:14 -0400
Received: by mail-oi1-x22d.google.com with SMTP id q186so15102174oia.0
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=hflmveIUT9776d/4hJf9/0kiwLAc22FOLJGzIuxs74I=;
	b=u44uJ5m+xsmEkQAtFUp2+zT7BDF7ym0b9660XLb3qaP2812VvZUUG02y8QXxqpIUx/
	7AZpy2/faEWmXaEiFXA6K2q8kCE3vLZ7VQV/0DiadFOMEvevN9p0Qi3lyMLFB8pN1wv/
	Sbnnvw7+IiS8hpyr3VurmzH+r127/0azHwoz0fwLEAHY9qSc1hdblHbtI5KndAQcC1no
	bwpfmfkA5kDRYc6k49Fnol0v6RNrtIKXCrMJFf6RLg7TsCs1hasuCkyXqcygprNV63H0
	EdyKWMYF4yo4s48ACIyprzykFVBcVUac/i2LmfsSQByeJ2Masf3fA/MhLKlymLrgOcSu
	8NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=hflmveIUT9776d/4hJf9/0kiwLAc22FOLJGzIuxs74I=;
	b=LxE0XMaC2fWJluxt83JPJjMlh9xRNL8pIV3pexW98rUoMqQcpb5C4qpvMUEhufAo10
	gjQIQXHXsvO5QeLvbEIu3qbNpjyj/Vp5u24HATmQFWbOfviHpcmCFDSM2Ovk4Rl8mG5p
	s36bcILfANAkRs2lqYBuvCwe5YE48s3b02oKUHBid9GLg1ITuRJmM2PGT5oMR6vr0yFH
	aO5lyxCXs455GdK+9OHeTzQzFmbb7x84CwZ6AA4X+z0HmrxyPF9QJ/4D+Xw0nCiPvR6o
	q5/n8nAsOVV014mPseTUTlXXsgfKlhjnDjrhykVWb0Zh0ULYRBhxv+oFnQaflLFea5Kf
	N9bw==
X-Gm-Message-State: APjAAAWuw7+eVuBrr4AfMVJJsIfvjoxY3EB83rzPFjNNVARiwmorhyM6
	79YPqwrL+kkrQvETMkJTRhu53H0CZ6VHT+A9rQdhNw==
X-Google-Smtp-Source: APXvYqy5k/2a92r+bhbTL4lJxiqLsbW6v6K0zcj55PYGm/0OVqi3U1BFW0JTnlC4pruDf39SwtUlbd1y60h/O2HIf7c=
X-Received: by 2002:aca:cd12:: with SMTP id d18mr3399573oig.146.1559068382420; 
	Tue, 28 May 2019 11:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
In-Reply-To: <87lfyqla7r.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2019 19:32:51 +0100
Message-ID: <CAFEAcA_DdosM2mSo0FWMLjv2eBHscQGXw-_J6AefiwURZGCCrg@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
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
Cc: Chris Wulff <crwulff@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 May 2019 at 19:12, Markus Armbruster <armbru@redhat.com> wrote:
> I append the alphabetical list of headers without multiple inclusion
> guards (as reported by scripts/clean-header-guards -nv), followed by the
> same list sorted into maintainer buckets.  If you're cc'ed, please find
> your bucket(s), and tell me which headers intentionally lack guards.

> FPU emulation
> M: Aurelien Jarno <aurelien@aurel32.net>
> M: Peter Maydell <peter.maydell@linaro.org>
> M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> fpu/softfloat-specialize.h
> include/fpu/softfloat-macros.h

I think that include/fpu/softfloat-macros.h should ideally
have header guards.

fpu/softfloat-specialize.h is a bit odd as it's intended to be included
exactly once, by fpu/softfloat.c. Guards wouldn't hurt, I think, but it
might be cleanest to rename it to fpu/softfloat-specialize.inc.c
to match our convention for "lump of C which is textually
included but isn't a header".

> ARM
> M: Peter Maydell <peter.maydell@linaro.org>
> target/arm/helper-a64.h
> target/arm/helper-sve.h
> target/arm/helper.h
> target/arm/op_addsub.h

All intentional -- target/*/helper.h and anything it includes
is intended to be included multiple times for different
purposes (the includer #defines various macros appropriately
to produce different effects).

> Allwinner-a10
> M: Beniamino Galvani <b.galvani@gmail.com>
> M: Peter Maydell <peter.maydell@linaro.org>
> include/hw/arm/allwinner-a10.h

This appears to me to have an include guard:
perhaps your check doesn't recognize the variant
where the #define appears just before the #endif rather
than just after the #ifndef ?

> ARM PrimeCell and CMSDK devices
> M: Peter Maydell <peter.maydell@linaro.org>
> hw/display/pl110_template.h

Intentional, like all the hw/display/*_template.h headers:
they're included multiple times with various definitions
of BITS to generate different functions. (Note that there's
an item on the BiteSizedTasks page which suggests that
we could clean up all of these because only the 32-bit
case is used now that our display surfaces are always
32-bits-per-pixel.)

> Raspberry Pi
> M: Peter Maydell <peter.maydell@linaro.org>
> R: Andrew Baumann <Andrew.Baumann@microsoft.com>
> R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> include/hw/arm/raspi_platform.h

Mistake, should have a guard.

> PXA2XX
> M: Andrzej Zaborowski <balrogg@gmail.com>
> M: Peter Maydell <peter.maydell@linaro.org>
> hw/display/pxa2xx_template.h

Intentional, see above.

> Xilinx ZynqMP
> M: Alistair Francis <alistair@alistair23.me>
> M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> M: Peter Maydell <peter.maydell@linaro.org>
> include/hw/arm/xlnx-zynqmp.h
> include/hw/display/xlnx_dp.h
> include/hw/dma/xlnx-zynq-devcfg.h

These all have guards in non-standard formats.

> include/hw/timer/xlnx-zynqmp-rtc.h

Mistake, should have a guard.

> OMAP
> M: Peter Maydell <peter.maydell@linaro.org>
> hw/display/omap_lcd_template.h

Intentional, see above.

> include/hw/arm/omap.h

Has a guard in a non-standard form.

> UNMAINTAINED
> ------------
> hw/display/tc6393xb_template.h

Intentional (see above)

> include/hw/char/cadence_uart.h

Another with a guard which isn't of a style your check
detects.

thanks
-- PMM

