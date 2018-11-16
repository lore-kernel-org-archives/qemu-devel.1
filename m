Received: from eggs.gnu.org ([2001:4830:134:3::10]:57590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNdGn-0004Pw-SD
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 07:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNdGe-0001Px-FN
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 07:30:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNdGe-0001Og-80
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 07:30:36 -0500
Date: Fri, 16 Nov 2018 13:30:26 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181116123026.bcjmirbs2sl2phm7@sirius.home.kraxel.org>
References: <20181115085808.GH27915@xz-x1>
	<162b1a37-79d7-8133-22ee-688748fe62b1@redhat.com>
	<20181116025304.GC11565@xz-x1>
	<CANCZdfrozw4f+ntOyUuX+N1Ny1j+BBEqhuowPXk2sRTSBzCGEw@mail.gmail.com>
	<20181116050134.GA16550@xz-x1>
	<CAFEAcA_r6QmSHHpvRCAOic1EppZamfhwFVQ_R7dUvNzomfNsgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_r6QmSHHpvRCAOic1EppZamfhwFVQ_R7dUvNzomfNsgg@mail.gmail.com>
Subject: Re: [Qemu-devel] Are FreeBSD guest images working?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, Ilya Maximets <i.maximets@samsung.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Warner Losh <imp@bsdimp.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Nov 16, 2018 at 09:47:48AM +0000, Peter Maydell wrote:
> On 16 November 2018 at 05:01, Peter Xu <peterx@redhat.com> wrote:
> > I would guess there aren't many people like me to prefer booting a VM
> > using console, though I agree that it'll be nice if we put something
> > into the prebuilt images like what's suggested by Ilya (and so far I
> > don't see anything bad with that):
> 
> As it happens I would have preferred the instructions on
> the QEMU wiki to work with a pure serial console but was unable
> to get that working so defaulted to graphics. (I didn't try very
> hard: x86 in general is much worse for getting serial boot
> working than other architectures, partly because of the BIOS.)

qemu-system-x86_64 -machine graphics=off should work reasonable well
these days.

cheers,
  Gerd
