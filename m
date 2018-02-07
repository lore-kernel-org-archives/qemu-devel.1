Received: from eggs.gnu.org ([2001:4830:134:3::10]:44310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejRqs-0003re-FY
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejRqp-000503-D3
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:41:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejRqp-0004zx-8S
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:41:35 -0500
References: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
	<20180206190432.GF3291@localhost.localdomain>
	<CAFEAcA8gwSqNpVD5xfk_yEz0OUMwa2rrfKaEhBXq5KravJmOag@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f87c71eb-78b8-e7a8-ac77-575212a94c7e@redhat.com>
Date: Wed, 7 Feb 2018 16:41:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8gwSqNpVD5xfk_yEz0OUMwa2rrfKaEhBXq5KravJmOag@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 06/02/2018 20:27, Peter Maydell wrote:
> armv7m creates the CPU object, but it's really the
> SoC which creates armv7m that wants to set various properties
> on the CPU. (The CPU properties being set are things like
> "initial vector address" which in real hardware are set by
> the SoC hard-wiring various config signals on the core to 1 or 0.)

Just to understand the context better, when you buy a SoC (presumably as
IP) can you also configure it to hardwire different CPU config signals?

Thanks,

Paolo
