Received: from eggs.gnu.org ([2001:4830:134:3::10]:39256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbq9M-0001lz-HK
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbq9J-0000uY-Cy
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:56:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cbq9J-0000tw-7x
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:56:41 -0500
Message-ID: <1486652198.3641.45.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 09 Feb 2017 15:56:38 +0100
In-Reply-To: <20170209140804.onpj3pniqim3qxr4@kamzik.brq.redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<20170209094259.nmli6yd5swxdujkm@kamzik.brq.redhat.com>
	<CAFEAcA8bRHuF_to0+whEhNF5oXp5_O63H8EV2JTXBngffufz9Q@mail.gmail.com>
	<1486637473.3641.36.camel@redhat.com>
	<20170209122819.ajgatpsnxj7cdjq2@kamzik.brq.redhat.com>
	<1486646865.3641.41.camel@redhat.com>
	<20170209140804.onpj3pniqim3qxr4@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, 2017-02-09 at 15:08 +0100, Andrew Jones wrote:
[...]
> Actually, I don't think anything is stopping me from using this
> file that way. I'll have to try the file name override that I
> suggested below, but
>=C2=A0
>=C2=A0=C2=A0qemu -nodefaults -readconfig configfile -m $MEM -machine acc=
el=3Dtcg
>=C2=A0
> should certainly override correctly.

I just tried and at least overriding the amount of memory
definitely works :)

> > > I agree with the comments of others that we should be using
> > > the PL011 instead. We should also set it up such that the
> > > monitor is multiplexed, so ^C won't terminate the guest and
> > > ^A will allow us to go to the monitor.
> >=C2=A0
> > That sounds awesome, how do I actually make it work from
> > the configuration file though?
>=C2=A0
> Sorry, dunno :-)

I don't think there's a way to make it work without adding
some parameters to the command line, I'm afraid :(

But if you use '-serial mon:stdio' you can indeed switch
between the serial console and the QEMU monitor at will,
and as a (quite interesting) side-effect Ctrl+C will no
longer kill QEMU :)

By the way, switching between serial and monitor is not
done with Ctrl+A but with Ctrl+A-c, which is not the most
convenient shortcut if you're running your guests on a
remote host due to GNU screen using the very same one ;)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
