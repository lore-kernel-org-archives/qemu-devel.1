Received: from eggs.gnu.org ([2001:4830:134:3::10]:56515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBlg0-0004AH-60
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBlfz-0005ss-A3
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:31:28 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:37844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBlfz-0005sd-3f
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:31:27 -0400
Received: by mail-ot0-x229.google.com with SMTP id 77-v6so24433584otd.4
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 11:31:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2f69532c-8651-ef67-0910-1fad91808608@redhat.com>
References: <20180425153343.24023-1-alex.bennee@linaro.org>
	<cb41b3a5-0e3b-f30b-a02c-1cc333d38ab1@redhat.com>
	<87604ekl0c.fsf@linaro.org>
	<2f69532c-8651-ef67-0910-1fad91808608@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 19:31:05 +0100
Message-ID: <CAFEAcA_G0n2ar6PYOuxyppD5jBbs+fXEC=PGA9+-+BsyGNMX8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] hw/core: expand description of
 null-machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On 26 April 2018 at 19:18, Thomas Huth <thuth@redhat.com> wrote:
> I don't think it makes sense to instantiate e.g. an interrupt controller
> with the "none" machine automatically ... so the raw cortex-m3 core
> should either be usable without that, too

The interrupt controller in an M-profile core is an integral
part of the CPU itself (it happens to be accessible via
memory-mapped accesses); our "nvic" object in QEMU also
implements various other "core part of the CPU but the
interface is memory mapped registers" functionality that isn't
strictly part of the interrupt controller. A configuration
which has an M profile CPU and does not have these registers
and the interrupt controller isn't architecturally permitted
and is just not right. We shouldn't let users configure QEMU
that way.

It's not really clear to me what the "none" machine is for,
though...

> or there just should be an error message instead of a crash
> when the additional hardware is not available

This would certainly be a good start.

(M profile is significantly different from A profile in
this area, which is why A profile doesn't crash here.)

thanks
-- PMM
