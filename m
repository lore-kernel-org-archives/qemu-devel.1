Received: from eggs.gnu.org ([2001:4830:134:3::10]:56434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejSUw-0003X8-4J
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejSUq-0003Ao-7U
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:23:02 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:40146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejSUq-0003AS-2R
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:22:56 -0500
Received: by mail-oi0-x231.google.com with SMTP id 8so1067465oix.7
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 08:22:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f87c71eb-78b8-e7a8-ac77-575212a94c7e@redhat.com>
References: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
	<20180206190432.GF3291@localhost.localdomain>
	<CAFEAcA8gwSqNpVD5xfk_yEz0OUMwa2rrfKaEhBXq5KravJmOag@mail.gmail.com>
	<f87c71eb-78b8-e7a8-ac77-575212a94c7e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Feb 2018 16:22:35 +0000
Message-ID: <CAFEAcA-Y6C-E_2=dEuQAA1ryeyzmCYKZUf-Fh-4jaQMhnU9Kkg@mail.gmail.com>
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

On 7 February 2018 at 15:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 06/02/2018 20:27, Peter Maydell wrote:
>> armv7m creates the CPU object, but it's really the
>> SoC which creates armv7m that wants to set various properties
>> on the CPU. (The CPU properties being set are things like
>> "initial vector address" which in real hardware are set by
>> the SoC hard-wiring various config signals on the core to 1 or 0.)
>
> Just to understand the context better, when you buy a SoC (presumably as
> IP) can you also configure it to hardwire different CPU config signals?

Usually if you buy an SoC you're buying the silicon, not
the IP. I think the usual case is that the SoC ties the
CPU config signals to 0 or 1 (part of the SoC designer's
job is configuring the semi-configurable bits of IP the
way they want when they put them all together). It would
certainly be in theory possible for the SoC to instead
route those signals out to pins on the SoC for the board
to tie off, but my impression is that's not a likely design
choice.

thanks
-- PMM
