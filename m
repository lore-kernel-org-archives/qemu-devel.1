Received: from eggs.gnu.org ([2001:4830:134:3::10]:40415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIH5I-0007ny-V3
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIH5G-0003bA-9l
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:11:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dIH5F-0003ZL-Ss
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:11:54 -0400
Date: Tue, 6 Jun 2017 12:11:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170606161152.GA6109@flamenco>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-2-git-send-email-cota@braap.org>
	<CAJhHMCDHLrU5NEuZGJqkVcJyQnXYsrdcYbNiNw4DAgiT=0R9pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhHMCDHLrU5NEuZGJqkVcJyQnXYsrdcYbNiNw4DAgiT=0R9pQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] compiler: define QEMU_CACHELINE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jun 06, 2017 at 01:39:45 -0400, Pranith Kumar wrote:
> On Mon, Jun 5, 2017 at 6:49 PM, Emilio G. Cota <cota@braap.org> wrote:
> > This is a constant used as a hint for padding structs to hopefully avoid
> > false cache line sharing.
> >
> > The constant can be set at configure time by defining QEMU_CACHELINE_SIZE
> > via --extra-cflags. If not set there, we try to obtain the value from
> > the machine running the configure script. If we fail, we default to
> > reasonable values, i.e. 128 bytes for ppc64 and 64 bytes for all others.
(snip)
> Is there any reason not to use sysconf(_SC_LEVEL1_DCACHE_LINESIZE)?

I tried using sysconf, but it doesn't work on the PowerPC machine I have
access to (it returns 0). It might be a machine-specific thing though-I
don't know. Here's the machine's `uname -a':
  Linux gcc2-power8.osuosl.org 3.10.0-514.10.2.el7.ppc64le #1 SMP Fri Mar \
    3 16:16:38 GMT 2017 ppc64le ppc64le ppc64le GNU/Linux

		E.
