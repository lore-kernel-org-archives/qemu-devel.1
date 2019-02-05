Received: from eggs.gnu.org ([209.51.188.92]:45967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3Ll-0005lz-Ip
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:13:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3Lj-0005A8-KX
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:13:29 -0500
Date: Tue, 5 Feb 2019 17:13:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190205171309.314b1405.cohuck@redhat.com>
In-Reply-To: <56301fff-3643-516b-a475-0f39b6221c5f@linux.ibm.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-2-cohuck@redhat.com>
	<20190130195127.5ff3c849@oc2783563651>
	<20190131125220.285a4bc8.cohuck@redhat.com>
	<20190131133455.3097613f@oc2783563651>
	<20190204163102.33d744d8.cohuck@redhat.com>
	<20190205125229.56c6e252@oc2783563651>
	<20190205133540.573902d8.cohuck@redhat.com>
	<ad60e2d5-f222-da38-41fd-bcbd7c9965a0@linux.ibm.com>
	<56301fff-3643-516b-a475-0f39b6221c5f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/6] vfio-ccw: make it safe to access
 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Tue, 5 Feb 2019 10:14:46 -0500
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 02/05/2019 09:48 AM, Eric Farman wrote:

> >>> This patch-series is AFAICT a big improvement over what we have. I wo=
uld
> >>> like Farhan confirming that it makes these hick-ups when he used to h=
it
> >>> BUSY with another ssch request disappear. If it does (I hope it does)
> >>> it's definitely a good thing for anybody who wants to use vfio-ccw. =
=20
> >>
> >> Yep. There remains a lot to be done, but it's a first step. =20
> >=20
> > s/a first step/an excellent first step/=C2=A0 :)
> >=20
> > Can't speak for Farhan, but this makes things somewhat better for me.=20
> > I'm still getting some periodic errors, but they happen infrequently=20
> > enough now that debugging them is frustrating.=C2=A0 ;-)
> >=20
> >  =C2=A0- Eric
> >  =20
>=20
> I ran the my workloads/tests with the patches and like Eric I notice the=
=20
> errors I previously hit less frequently.

Great, thanks for testing!
