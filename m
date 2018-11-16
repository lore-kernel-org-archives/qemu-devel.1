Received: from eggs.gnu.org ([2001:4830:134:3::10]:47058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gNUFx-0005P8-59
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 21:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gNUFt-0004PU-46
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 21:53:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gNUFs-0004PM-VG
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 21:53:13 -0500
Date: Fri, 16 Nov 2018 10:53:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181116025304.GC11565@xz-x1>
References: <20181115085808.GH27915@xz-x1>
	<162b1a37-79d7-8133-22ee-688748fe62b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162b1a37-79d7-8133-22ee-688748fe62b1@redhat.com>
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Thu, Nov 15, 2018 at 11:05:33AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 15/11/18 9:58, Peter Xu wrote:
> > Hi, the list,
> >=20
> > I am trying to boot a FreeBSD guest but failed.  It hangs at the
> > kernel booting phase:
> >=20
> > /boot/ker]el/kernel text=3D0x14ed860 data=3D0x132538+0x4baa68 syms=3D=
[0x8+0x159ee8+0x8
> > Booting...
> > (nothing more)
> >=20
> > It's just as simple as downloading the image and boot so I can't thin=
k
> > of anything strange within my procedures so far:
> >=20
> > https://wiki.qemu.org/Hosts/BSD#FreeBSD
> >=20
> > I also tried the latest image here:
> >=20
> > https://download.freebsd.org/ftp/releases/VM-IMAGES/11.2-RELEASE/amd6=
4/Latest/FreeBSD-11.2-RELEASE-amd64.qcow2.xz
> >=20
> > but it's having the same problem as 11.0.
> >=20
> > Am downloading an fresh ISO, but before I continue I'm just curious o=
n
> > whether anyone is using these images and whether there's quick answer=
s
> > to what I have encountered.
> >=20
> > Thanks in advance,
>=20
> I use 'make vm-build-freebsd' which works, but the image comes
> pre-installed.

It's because I'm always with no-gui mode and FreeBSD images has no
serial enabled by default.  I was possibly spoiled by the nice
virt-builder before with consoles setup already for all Linux guest
images.  Thanks for answering!

Regards,

--=20
Peter Xu
