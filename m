Received: from eggs.gnu.org ([2001:4830:134:3::10]:46446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejTWJ-0006SQ-OI
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejTWG-0003Ie-Iq
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:28:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37418 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejTWG-0003IP-FA
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:28:28 -0500
References: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
	<20180206190432.GF3291@localhost.localdomain>
	<CAFEAcA8gwSqNpVD5xfk_yEz0OUMwa2rrfKaEhBXq5KravJmOag@mail.gmail.com>
	<f87c71eb-78b8-e7a8-ac77-575212a94c7e@redhat.com>
	<CAFEAcA-Y6C-E_2=dEuQAA1ryeyzmCYKZUf-Fh-4jaQMhnU9Kkg@mail.gmail.com>
	<3131facd-2630-a159-15c3-0013332bf805@redhat.com>
	<CAFEAcA-d_hPyotGd-qdRBKfAQ4RkD4q9Aodi2AtGE5FeftRSzw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e06a8452-539e-8874-636e-97c51c3c8cb7@redhat.com>
Date: Wed, 7 Feb 2018 18:28:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-d_hPyotGd-qdRBKfAQ4RkD4q9Aodi2AtGE5FeftRSzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] how to handle QOM 'container' objects whose
 contents depend on QOM properties?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 07/02/2018 17:49, Peter Maydell wrote:
>> Yeah, that's why I was wondering if buying an SoC as configurable IP was
>> a thing at all.  In that case, I would just make things less
>> configurable and, if needed, hack the configurability with -global.
>
> So is that a vote for the aspeed style "create N different
> QOM types" ?

Yeah, many types for the SoCs, each setting different properties on the
CPU/nvic/timers/etc.

> It doesn't necessarily help with 'armv7m', which isn't an
> SoC, but just part of the way we currently model M profile CPUs.

Does armv7m have a fixed or variable number of sub-objects?  If it's
fixed, setting up forwarding properties is easy.  But if even parts of
it are variable, it does get messy.

Thanks,

Paolo

> In real hardware, the CPU includes all of the interrupt
> controller, timers, etc, which in QEMU are separate
> objects to the QEMU CPU object and wrapped up inside
> an armv7m container.
> 
> (It would I guess be possible to merge the 'armv7m' container
> entirely into the QEMU CPU object, so creating the CPU object
> gave you an nvic and the mmio register regions to map and so
> on. We don't do anything like that for other cpus right now,
> though...)
