Received: from eggs.gnu.org ([2001:4830:134:3::10]:46987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fzgM6-0003Gv-SW
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 06:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fzg9b-000722-Hd
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 06:44:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fzg9b-00071k-Av
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 06:44:19 -0400
Date: Tue, 11 Sep 2018 12:44:17 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180911104417.o7d2jtqwhikc6nrs@sirius.home.kraxel.org>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180829095035.GI31005@redhat.com>
	<CAMxuvayUDC+dZegONEwto36qTqaJFUEF9UrvNiY+1HJ_6nrzYg@mail.gmail.com>
	<CAJ+F1CKcSkd6aKPBss6eNtaD8-NonafNdyLB_66BsH5sKParPA@mail.gmail.com>
	<20180911085928.rp5drknyoqcvs4xf@sirius.home.kraxel.org>
	<CAJ+F1CKPz=qnez+_9g6rDVrgW8bQTL9A90kJwO2TB7N6G1nGSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKPz=qnez+_9g6rDVrgW8bQTL9A90kJwO2TB7N6G1nGSw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/29] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, David Airlie <airlied@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Tue, Sep 11, 2018 at 01:16:22PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Sep 11, 2018 at 12:59 PM Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> >
> > > > >  $ ./vhost-user-gpu --virgl -s vgpu.sock &
> > > > >  $ qemu...
> > > > >    -chardev socket,id=3Dchr,path=3Dvgpu.sock
> > > > >    -object vhost-user-backend,id=3Dvug,chardev=3Dchr
> > > > >    -device vhost-user-vga,vhost-user=3Dvug
> > > >
> > > > That's a bit incovenient for qemu command line users. But who run=
s
> > > > qemu this way but some developers? (others have higher-level scri=
pts /
> > > > tools or libvirt)
> >
> > In practice this will *allways* run over a unix socket, right?
> > So I'm wondering whenever it makes sense to take the chardev
> > indirection here ...
>=20
> The management layer can set things up and pass fd around, avoiding
> socket paths etc.

But that fd will be a socket too ...

> > > - optionally? take a "--pid=3DPATH" argument, to write out the proc=
ess PID
> >
> > Do we need that?  When libvirt forks off the process it knows the PID
> > without pidfile, right?
>=20
> Yes I am not sure it is strictly necessary (that's why I put
> optionally). The helper could fork itself, for various reasons.

Ok, good point.  But then I'd make this mandatory, and maybe name it
--pidfile.  Shouldn't a big burden as you probably have code for that in
the vhost-user helper lib

> Unknown capabilities would be ignored.

Ok, so when libvirt ignores unknown stuff anyway a list of keywords is
good enough I guess.  And for humans having --help is more useful.

I'd include the protocol into the names, for robustness reasons, i.e.
use "input-grab" or "gpu-vulkan".

cheers,
  Gerd
