Received: from eggs.gnu.org ([2001:4830:134:3::10]:58428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLRoi-0006cF-Rg
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLRoh-0002zZ-HT
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:15:56 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLRoh-0002zJ-5O
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:15:55 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 36so14940063wry.3
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:15:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170614105547.Horde.Qq_wt1XJCR6spCHFrm8xE9K@www.quantumachine.net>
References: <20170614105547.Horde.Qq_wt1XJCR6spCHFrm8xE9K@www.quantumachine.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jun 2017 11:15:33 +0100
Message-ID: <CAFEAcA8idTcunTM61VVOnHSgryo1ZS5wK+MkZgCnn5C0h4+KuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] DragonFly BSD support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Antonio_Huete_Jim=C3=A9nez?= <tuxillo@quantumachine.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 June 2017 at 11:55, Antonio Huete Jim=C3=A9nez
<tuxillo@quantumachine.net> wrote:
> According to 2.9 changelog page, DragonFly BSD will be listed as unsuppor=
ted
> with the possibility of dropping support completely in the future:
>
> http://wiki.qemu.org/ChangeLog/2.9
>
> I'd like to volunteer so that qemu can keep DragonFly BSD as a supported
> platform.
> Could you please let me know the requirements needed to do so?

Thanks for volunteering!

So, what we need comes in two parts:
 (1) a machine we can use for our build tests (ie which I can have
an ssh account on; we may set up more formal continuous-integration
later). Since I don't know the BSDs somebody else needs to be
handling sysadmin work for it.
At a pinch, detailed instructions on how to set up a VM on
Linux running DragonFly BSD would do; we have those for some
of the BSDs here: http://wiki.qemu.org/Hosts/BSD

 (2) somebody who's prepared to list themselves as the maintainer
for the host OS, and respond to problems/patches relating to it.
In particular the first thing will be to ensure that QEMU actually
builds and passes 'make check' on this OS and submit any patches
needed to fix problems. If there are any non-upstream patches
lurking around in a ports system, then you'll also want to start
cleaning those up and getting them upstream.

When we get to the point where we have a machine in our
standard build-and-test setup which passes 'make && make check'
then we can drop the "this is unsupported" note from configure.

thanks
-- PMM
