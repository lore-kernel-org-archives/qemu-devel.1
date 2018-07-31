Received: from eggs.gnu.org ([2001:4830:134:3::10]:51759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aoates@google.com>) id 1fke1A-0006FC-Ah
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 19:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aoates@google.com>) id 1fke19-0001Je-9J
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 19:25:28 -0400
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:55552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aoates@google.com>) id 1fke18-0001J8-Dv
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 19:25:26 -0400
Received: by mail-it0-x229.google.com with SMTP id p7-v6so7041023itf.5
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 16:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180729143545.6978-1-samuel.thibault@ens-lyon.org>
	<20180729143545.6978-2-samuel.thibault@ens-lyon.org>
	<CAFEAcA8tX0_MNg99oorgOWarJa8Oy+gFFwoRys-fU7ZX3_Ufng@mail.gmail.com>
	<CAJ1tprAuf1mWtpw+4M3QFZyrDz22TMcnGS9xkhQn6Q9UQTrwiw@mail.gmail.com>
	<CAFEAcA_pj4tFE2tyrbRtvJnPoeRekDXtVJCzgSeFiiK=sxg4Aw@mail.gmail.com>
In-Reply-To: <CAFEAcA_pj4tFE2tyrbRtvJnPoeRekDXtVJCzgSeFiiK=sxg4Aw@mail.gmail.com>
From: Andrew Oates <aoates@google.com>
Date: Tue, 31 Jul 2018 19:25:13 -0400
Message-ID: <CAJ1tprAyHqgH1mHkeLu6qU1Fr8O-B5ebJ3Cfw8e_nHMYSYXfmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 1/1] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, stefanha@redhat.com, "J. Kiszka" <jan.kiszka@siemens.com>

On Tue, Jul 31, 2018 at 6:22 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 31 July 2018 at 02:16, Andrew Oates <aoates@google.com> wrote:
> > Yeah, I suspect (but haven't tested) that this applies to all BSDs.  We
> > could switch CONFIG_DARWIN to CONFIG_BSD (happy to resend the patch, just
> > LMK).
> >
> > Agreed that platform-specific ifdefs are gross, but I don't see a better
> way
> > here :/  One option would be to look at the packet length and contents to
> > try to determine if there's an IP header before the ICMP header, but that
> > seems pretty iffy.  Creating ICMP sockets often requires special
> privileges
> > or configuration (e.g. on Linux) so I don't think it could easily be
> done at
> > configure-time to test the host machine's configuration.
>
> Mmm. I guess using CONFIG_BSD, or perhaps even not-CONFIG_LINUX,
> would be best. Is there an easy way to test this?
> (Our other two supported host OSes are the Solarises and Haiku;
> no idea if either of those support ICMP sockets or what their
> behaviour is here...)
>

Both CONFIG_BSD and not-CONFIG_LINUX work on macOS.  I unfortunately don't
have access to any other BSDs to test them, though.

~Andrew

>
> thanks
> -- PMM
>
