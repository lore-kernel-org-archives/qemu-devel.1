Received: from eggs.gnu.org ([2001:4830:134:3::10]:46092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gNWGX-0000yQ-Dq
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 00:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gNWGR-0002ah-Fw
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 00:02:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gNWGO-0002XW-DA
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 00:01:52 -0500
Date: Fri, 16 Nov 2018 13:01:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181116050134.GA16550@xz-x1>
References: <20181115085808.GH27915@xz-x1>
	<162b1a37-79d7-8133-22ee-688748fe62b1@redhat.com>
	<20181116025304.GC11565@xz-x1>
	<CANCZdfrozw4f+ntOyUuX+N1Ny1j+BBEqhuowPXk2sRTSBzCGEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANCZdfrozw4f+ntOyUuX+N1Ny1j+BBEqhuowPXk2sRTSBzCGEw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Are FreeBSD guest images working?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Warner Losh <imp@bsdimp.com>
Cc: philmd@redhat.com, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, armbru@redhat.com, Ilya Maximets <i.maximets@samsung.com>

On Thu, Nov 15, 2018 at 08:24:23PM -0700, Warner Losh wrote:
> On Thu, Nov 15, 2018 at 7:54 PM Peter Xu <peterx@redhat.com> wrote:
>=20
> > On Thu, Nov 15, 2018 at 11:05:33AM +0100, Philippe Mathieu-Daud=C3=A9=
 wrote:
> > > On 15/11/18 9:58, Peter Xu wrote:
> > > > Hi, the list,
> > > >
> > > > I am trying to boot a FreeBSD guest but failed.  It hangs at the
> > > > kernel booting phase:
> > > >
> > > > /boot/ker]el/kernel text=3D0x14ed860 data=3D0x132538+0x4baa68
> > syms=3D[0x8+0x159ee8+0x8
> > > > Booting...
> > > > (nothing more)
> > > >
> > > > It's just as simple as downloading the image and boot so I can't =
think
> > > > of anything strange within my procedures so far:
> > > >
> > > > https://wiki.qemu.org/Hosts/BSD#FreeBSD
> > > >
> > > > I also tried the latest image here:
> > > >
> > > >
> > https://download.freebsd.org/ftp/releases/VM-IMAGES/11.2-RELEASE/amd6=
4/Latest/FreeBSD-11.2-RELEASE-amd64.qcow2.xz
> > > >
> > > > but it's having the same problem as 11.0.
> > > >
> > > > Am downloading an fresh ISO, but before I continue I'm just curio=
us on
> > > > whether anyone is using these images and whether there's quick an=
swers
> > > > to what I have encountered.
> > > >
> > > > Thanks in advance,
> > >
> > > I use 'make vm-build-freebsd' which works, but the image comes
> > > pre-installed.
> >
> > It's because I'm always with no-gui mode and FreeBSD images has no
> > serial enabled by default.  I was possibly spoiled by the nice
> > virt-builder before with consoles setup already for all Linux guest
> > images.  Thanks for answering!
> >
>=20
> I'm coming to the game late...
>=20
> I run FreeBSD in qemu all the time, but I build images from source to t=
est
> the boot loader and it's all serial and my test scripts are tuned to th=
at.
> I rarely use the pre-built images, however.
>=20
> If there's ways that we can build images that work better than we're do=
ing
> right now to make the experience better, like making sure we enable the
> dual console support for them... We're late in our release cycle, but i=
f
> what we need to change is what I think we need to change, we still have
> time for it.
>=20
> In the mean time I'll read through wiki and see if there's anything
> obviously wrong...

I would guess there aren't many people like me to prefer booting a VM
using console, though I agree that it'll be nice if we put something
into the prebuilt images like what's suggested by Ilya (and so far I
don't see anything bad with that):

        [root@freebsd ~]# cat /boot/loader.conf
        boot_multicons=3D"YES"
        boot_serial=3D"YES"
        comconsole_speed=3D"115200"
        console=3D"comconsole,vidconsole"

Anyway, thanks for your work on either the wiki or the images, they
are really helpful to people like me.

Regards,

--=20
Peter Xu
