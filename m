Received: from eggs.gnu.org ([2001:4830:134:3::10]:52018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDqW3-0000EO-0L
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDqVz-0001Ao-1P
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:05:46 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:40463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDqVy-0001Ah-Oq
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:05:42 -0400
Received: by mail-oi0-x235.google.com with SMTP id c203-v6so12679186oib.7
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 05:05:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180502115844.GO3308@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
	<20180502115844.GO3308@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 May 2018 13:05:21 +0100
Message-ID: <CAFEAcA-e_=08658O8E3CAmYXvBbNWmznnhfMLUW+MXnxb_vKfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2 May 2018 at 12:58, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote=
:
> I'm curious what is the compelling benefit of having a single fat QEMU
> binary that included all archiectures at once ?

The motivation is "I want to model a board with an SoC that has
both Arm cores and Microblaze cores". One binary seems the most
sensible way to do that, since otherwise we'd end up with some
huge multiplication of binaries for all the possible architecture
combinations. It also would reduce the number of times we end up
recompiling and shipping any particular PCI device. From the
perspective of QEMU as emulation environment, it's a nice
simplification.

> From a security POV I find it desirable for us to go in the other directi=
on
> away from monolithic binaries that include everything. We've started that
> work with turning various pieces of QEMU into loadable modules. In the fu=
ture
> we might see some pieces being moved into completely separate binaries. e=
g we
> could have a core QEMU binary and separate binaries for GTK, SPICE, VNC, =
etc
> frontends.
>
> If each target architecture could be a loadable module, it might be
> acceptable, but I wouldn't much like the idea of having every architectur=
e
> compiled into a single binary. Distros like to build every QEMU feature,
> but users reasonably don't want to expand their attack surface by having
> all features installed, so being able to install packages for each target
> arch separately is a compelling benefit of current set of QEMU per-target
> binaries that I wouldn't want to loose.

Well, we already have issues with that where for instance
qemu-system-aarch64 has a lot of device models that the
typical KVM VM doesn't need. More modularity might help
(though we have shied away from having devices be modules
in the past).

thanks
-- PMM
