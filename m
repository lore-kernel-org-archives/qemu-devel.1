Received: from eggs.gnu.org ([2001:4830:134:3::10]:60760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejSmM-0000C5-Jp
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejSmH-00085t-LF
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:41:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59438 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejSmH-00085e-H2
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:40:57 -0500
References: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
	<20180206190432.GF3291@localhost.localdomain>
	<CAFEAcA8gwSqNpVD5xfk_yEz0OUMwa2rrfKaEhBXq5KravJmOag@mail.gmail.com>
	<f87c71eb-78b8-e7a8-ac77-575212a94c7e@redhat.com>
	<CAFEAcA-Y6C-E_2=dEuQAA1ryeyzmCYKZUf-Fh-4jaQMhnU9Kkg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3131facd-2630-a159-15c3-0013332bf805@redhat.com>
Date: Wed, 7 Feb 2018 17:38:21 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Y6C-E_2=dEuQAA1ryeyzmCYKZUf-Fh-4jaQMhnU9Kkg@mail.gmail.com>
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

On 07/02/2018 17:22, Peter Maydell wrote:
>> Just to understand the context better, when you buy a SoC (presumably as
>> IP) can you also configure it to hardwire different CPU config signals?
>
> Usually if you buy an SoC you're buying the silicon, not
> the IP. I think the usual case is that the SoC ties the
> CPU config signals to 0 or 1 (part of the SoC designer's
> job is configuring the semi-configurable bits of IP the
> way they want when they put them all together). It would
> certainly be in theory possible for the SoC to instead
> route those signals out to pins on the SoC for the board
> to tie off, but my impression is that's not a likely design
> choice.

Yeah, that's why I was wondering if buying an SoC as configurable IP was
a thing at all.  In that case, I would just make things less
configurable and, if needed, hack the configurability with -global.

Paolo
