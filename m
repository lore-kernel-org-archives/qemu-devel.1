Received: from eggs.gnu.org ([2001:4830:134:3::10]:48816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejTcu-0004wN-Co
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejTct-0000IG-H4
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:35:20 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:39125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejTct-0000I2-Aa
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:35:19 -0500
Received: by mail-oi0-x236.google.com with SMTP id j188so1261917oib.6
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 09:35:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e06a8452-539e-8874-636e-97c51c3c8cb7@redhat.com>
References: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
	<20180206190432.GF3291@localhost.localdomain>
	<CAFEAcA8gwSqNpVD5xfk_yEz0OUMwa2rrfKaEhBXq5KravJmOag@mail.gmail.com>
	<f87c71eb-78b8-e7a8-ac77-575212a94c7e@redhat.com>
	<CAFEAcA-Y6C-E_2=dEuQAA1ryeyzmCYKZUf-Fh-4jaQMhnU9Kkg@mail.gmail.com>
	<3131facd-2630-a159-15c3-0013332bf805@redhat.com>
	<CAFEAcA-d_hPyotGd-qdRBKfAQ4RkD4q9Aodi2AtGE5FeftRSzw@mail.gmail.com>
	<e06a8452-539e-8874-636e-97c51c3c8cb7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Feb 2018 17:34:58 +0000
Message-ID: <CAFEAcA8pDtp_cu9tFPuRJ+qwyy_h=mjvvZyM6OsQDKSqkUvjMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 7 February 2018 at 17:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 07/02/2018 17:49, Peter Maydell wrote:
>>> Yeah, that's why I was wondering if buying an SoC as configurable IP was
>>> a thing at all.  In that case, I would just make things less
>>> configurable and, if needed, hack the configurability with -global.
>>
>> So is that a vote for the aspeed style "create N different
>> QOM types" ?
>
> Yeah, many types for the SoCs, each setting different properties on the
> CPU/nvic/timers/etc.
>
>> It doesn't necessarily help with 'armv7m', which isn't an
>> SoC, but just part of the way we currently model M profile CPUs.
>
> Does armv7m have a fixed or variable number of sub-objects?  If it's
> fixed, setting up forwarding properties is easy.  But if even parts of
> it are variable, it does get messy.

If the CPU supports the security extensions then it gets an
extra timer device. (That typically doesn't need any properties
forwarded it it, though.)

I'll have a look at refactoring armv7m (again ;-)) into
an armv7m-cortex-m3, armv7m-cortex-m4, and armv7m-cortex-m33.

thanks
-- PMM
