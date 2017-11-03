Received: from eggs.gnu.org ([2001:4830:134:3::10]:55179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eAY0B-0003ag-27
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eAY05-0004j8-5a
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:10:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eAY04-0004iw-TM
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:10:53 -0400
Date: Fri, 3 Nov 2017 09:10:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171103091045.GA2616@work-vm>
References: <CADak6y5eSo9=C2FJx+cTdqxArWeQqNDAvVgY+vS7H-9yGeuZvw@mail.gmail.com>
	<20171101094537.GA2786@work-vm>
	<CADak6y485_OSHrzji4Wq7_3vOrK+ch6Vm1FW1RMidSzoO3U-kQ@mail.gmail.com>
	<CADak6y5mfPnDfQbQSBjY-iGXsFEAmRX6cd=Cv-z-kD5VArKA9Q@mail.gmail.com>
	<CADak6y5zT2qxHe8-iCQhpgxdAyHcerMMbcDNvRig8i2PvopHBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADak6y5zT2qxHe8-iCQhpgxdAyHcerMMbcDNvRig8i2PvopHBg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu disk use writeback don't take effect in
 centos 7.2 1511
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Schlacter <wlfightup@gmail.com>, stefanha@redhat.com
Cc: qemu-devel@nongnu.org

* Paul Schlacter (wlfightup@gmail.com) wrote:
> latest progress=EF=BC=9A
> use centos 7.2   https://cloud.centos.org/centos/7/images/
> test version: 1511  1601  1604 1606 1608
>=20
> From the above version in turn test, found the previous version 1511 16=
01
> 1603 have the problem,
> The latter two versions 1606 1608 are normal, dont't have the prblem,
> Normal is cache =3D writeback io significantly higher than none mode
>=20
> why?

It's a fun bug, but I don't know the cause - the fact it's dependent
on guest version but fixed, suggests something changed in the guest
kernel.  If you really wanted to figure out why I guess the only way
would be to walk through the CentOS guest kernel versions and find the
exact kernel that fixed it; then we could hunt down which change fixed
it.

(I've cc'd in Stefan for block stuff, but this is sounding more guest
than qemu)

Dave

> On Wed, Nov 1, 2017 at 8:03 PM, Paul Schlacter <wlfightup@gmail.com> wr=
ote:
>=20
> > Hi David:
> >      yes, with the same qemu,  centos 7.2 guest cache is writeback an=
d
> > none, the disk io almost, writeback feeling no effect.
> >       but 7.1/7.3/7.4  cache is writeback was significantly faster th=
an
> > none model
> >
> > On Wed, Nov 1, 2017 at 8:02 PM, Paul Schlacter <wlfightup@gmail.com>
> > wrote:
> >
> >> Hi David:
> >>      yes, with the same qemu,  centos 7.2 guest cache is writeback a=
nd
> >> none, the disk io almost, writeback feeling no effect.
> >>       but 7.1/7.3/7.4  cache is writeback was significantly faster t=
han
> >> none model
> >>
> >> On Wed, Nov 1, 2017 at 5:45 PM, Dr. David Alan Gilbert <
> >> dgilbert@redhat.com> wrote:
> >>
> >>> * Paul Schlacter (wlfightup@gmail.com) wrote:
> >>> > qemu version:  2.9.0
> >>> > image: centos 7.2 1511 raw
> >>> > cache mode: writeback
> >>> >
> >>> >
> >>> > In centos7.2 time, the use of writeback and none, the result of d=
d
> >>> disk is
> >>> > the same io, no change
> >>> >
> >>> > But I replaced centos7.1 centos7.3 centos7.4 when writeback was
> >>> > significantly faster than none
> >>> >
> >>> > Would like to ask what is going on, how to solve ?
> >>>
> >>> Hi Paul,
> >>>   Can you just clarify your setup please;  do you mean that
> >>> with the same qemu setup but a 7.2 guest rather than a 7.1/7.3 gues=
t
> >>> the behaviour changes?
> >>>
> >>> Dave
> >>>
> >>> --
> >>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>>
> >>
> >>
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
