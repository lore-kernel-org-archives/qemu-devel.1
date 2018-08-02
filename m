Received: from eggs.gnu.org ([2001:4830:134:3::10]:47431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fl9j5-00034n-5x
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fl9j4-0007VY-6i
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:16:55 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fl9j4-0007VC-0u
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:16:54 -0400
Received: by mail-oi0-x242.google.com with SMTP id y207-v6so2626853oie.13
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 02:16:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180802070824.GC11211@umbus.fritz.box>
References: <20180801035357.7804-1-david@gibson.dropbear.id.au>
	<CAFEAcA-FitsqU3kQJTFGSFgOh6Zsf2Zy2fO3OTnL5c+Tzi5pog@mail.gmail.com>
	<alpine.BSF.2.21.1808011300070.7488@zero.eik.bme.hu>
	<CAFEAcA-=c7O+h3c-gQ=31q0oyLzJhDNmEBzv4X2Yp_TBfYhC-w@mail.gmail.com>
	<20180802070824.GC11211@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Aug 2018 10:16:32 +0100
Message-ID: <CAFEAcA8sGVjGgXxR8ivSWJ6oDKJPfEGnWUuHh_quZK2GDSgU2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 0/2] ppc-for-3.0 queue 20180801
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>

On 2 August 2018 at 08:08, David Gibson <david@gibson.dropbear.id.au> wrote:
> The macio fix, however, *is* a regression from 2.12.  Whether it's
> severe enough to warrant another -rc, I'm not sure.  It is a bad
> pointer access which is, well, bad.  It doesn't seem to bite
> obviously, needing valgrind to pick it up, but possibly that's just
> luck.

I thought those introspection-bugs like the macio ones weren't
regressions ? Certainly the devices have been leaking a refcount
in their init methods for a long time. I don't view these as
very important bugs, though, as they only manifest if you
try to introspect fixed-always-present device/SoC objects,
which in practice I don't think anybody does except as
part of "test every device via introspection" test cases.

thanks
-- PMM
