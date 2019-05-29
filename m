Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111FAC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7D9205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7D9205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVy2O-0005BM-Nx
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 08:50:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVy0r-0004SQ-6T
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVy0p-0001Dv-Vu
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:49:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVy0p-00010d-Nb
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:48:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A3B53086225;
	Wed, 29 May 2019 12:48:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C1B5D7E306;
	Wed, 29 May 2019 12:47:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 411091138648; Wed, 29 May 2019 14:47:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
	<CAFEAcA_DdosM2mSo0FWMLjv2eBHscQGXw-_J6AefiwURZGCCrg@mail.gmail.com>
Date: Wed, 29 May 2019 14:47:50 +0200
In-Reply-To: <CAFEAcA_DdosM2mSo0FWMLjv2eBHscQGXw-_J6AefiwURZGCCrg@mail.gmail.com>
	(Peter Maydell's message of "Tue, 28 May 2019 19:32:51 +0100")
Message-ID: <87o93lfmvd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 29 May 2019 12:48:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <f4bug@amsat.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Edgar E.
	Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Marek Vasut <marex@denx.de>, Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	David Hildenbrand <david@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Laszlo Ersek <lersek@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Chris Wulff <crwulff@gmail.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 28 May 2019 at 19:12, Markus Armbruster <armbru@redhat.com> wrote:
>> I append the alphabetical list of headers without multiple inclusion
>> guards (as reported by scripts/clean-header-guards -nv), followed by the
>> same list sorted into maintainer buckets.  If you're cc'ed, please find
>> your bucket(s), and tell me which headers intentionally lack guards.
>
>> FPU emulation
>> M: Aurelien Jarno <aurelien@aurel32.net>
>> M: Peter Maydell <peter.maydell@linaro.org>
>> M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> fpu/softfloat-specialize.h
>> include/fpu/softfloat-macros.h
>
> I think that include/fpu/softfloat-macros.h should ideally
> have header guards.

I'll add one.

> fpu/softfloat-specialize.h is a bit odd as it's intended to be included
> exactly once, by fpu/softfloat.c. Guards wouldn't hurt, I think, but it
> might be cleanest to rename it to fpu/softfloat-specialize.inc.c
> to match our convention for "lump of C which is textually
> included but isn't a header".

Makes me wonder why we bother with a separate file.

Renaming it to .inc.c gets it out of check-headers' way.

>> ARM
>> M: Peter Maydell <peter.maydell@linaro.org>
>> target/arm/helper-a64.h
>> target/arm/helper-sve.h
>> target/arm/helper.h
>> target/arm/op_addsub.h
>
> All intentional -- target/*/helper.h and anything it includes
> is intended to be included multiple times for different
> purposes (the includer #defines various macros appropriately
> to produce different effects).

We have quite a few special headers of this kind.  The ones that require
macros to be defined should be excluded from check-headers.  The ones
that don't could instead skip the "#include a second time works" part of
the test.  We'll see.

>> Allwinner-a10
>> M: Beniamino Galvani <b.galvani@gmail.com>
>> M: Peter Maydell <peter.maydell@linaro.org>
>> include/hw/arm/allwinner-a10.h
>
> This appears to me to have an include guard:
> perhaps your check doesn't recognize the variant
> where the #define appears just before the #endif rather
> than just after the #ifndef ?

You're right, it doesn't.

We got a dozen headers with the #define in unusual places.  I'll
normalize them.

>> ARM PrimeCell and CMSDK devices
>> M: Peter Maydell <peter.maydell@linaro.org>
>> hw/display/pl110_template.h
>
> Intentional, like all the hw/display/*_template.h headers:
> they're included multiple times with various definitions
> of BITS to generate different functions. (Note that there's
> an item on the BiteSizedTasks page which suggests that
> we could clean up all of these because only the 32-bit
> case is used now that our display surfaces are always
> 32-bits-per-pixel.)

Another one for the "special headers" bucket.

>> Raspberry Pi
>> M: Peter Maydell <peter.maydell@linaro.org>
>> R: Andrew Baumann <Andrew.Baumann@microsoft.com>
>> R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> include/hw/arm/raspi_platform.h
>
> Mistake, should have a guard.

I'll add one.

>> PXA2XX
>> M: Andrzej Zaborowski <balrogg@gmail.com>
>> M: Peter Maydell <peter.maydell@linaro.org>
>> hw/display/pxa2xx_template.h
>
> Intentional, see above.

Another one for the "special headers" bucket.

>> Xilinx ZynqMP
>> M: Alistair Francis <alistair@alistair23.me>
>> M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>> M: Peter Maydell <peter.maydell@linaro.org>
>> include/hw/arm/xlnx-zynqmp.h
>> include/hw/display/xlnx_dp.h
>> include/hw/dma/xlnx-zynq-devcfg.h
>
> These all have guards in non-standard formats.

I'll normalize.

>> include/hw/timer/xlnx-zynqmp-rtc.h
>
> Mistake, should have a guard.

I'll add one.

>> OMAP
>> M: Peter Maydell <peter.maydell@linaro.org>
>> hw/display/omap_lcd_template.h
>
> Intentional, see above.

Another one for the "special headers" bucket.

>> include/hw/arm/omap.h
>
> Has a guard in a non-standard form.

I'll normalize.

>> UNMAINTAINED
>> ------------
>> hw/display/tc6393xb_template.h
>
> Intentional (see above)

Another one for the "special headers" bucket.

>> include/hw/char/cadence_uart.h
>
> Another with a guard which isn't of a style your check
> detects.

I'll normalize.

Thanks!

