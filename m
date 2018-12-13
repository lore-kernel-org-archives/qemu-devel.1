Received: from eggs.gnu.org ([2001:4830:134:3::10]:37977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXSSn-0000b5-2o
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXSSj-0004wm-Sp
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:59:44 -0500
Date: Thu, 13 Dec 2018 15:59:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181213155937.1884ded4.cohuck@redhat.com>
In-Reply-To: <a1d0ebac-346a-18e0-b05b-42d2b051cff4@linux.ibm.com>
References: <20181022090255.19671-1-zyimin@linux.ibm.com>
	<698a7fdd-47cc-cb3e-a280-3c4b656d92ef@redhat.com>
	<20181023232517.6b93085b.cohuck@redhat.com>
	<494ff50b-8b0f-1393-fbc5-bf5033a246ce@linux.ibm.com>
	<20181031114954.5e51d0c2.cohuck@redhat.com>
	<d8e0621a-d11e-a172-e40e-ec96dd92d5cd@linux.ibm.com>
	<20181130102708.5d6ca0e0.cohuck@redhat.com>
	<a1d0ebac-346a-18e0-b05b-42d2b051cff4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Yi Min Zhao <zyimin@linux.ibm.com>

On Wed, 12 Dec 2018 15:25:57 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> On 11/30/2018 04:27 AM, Cornelia Huck wrote:
> > On Fri, 30 Nov 2018 10:23:14 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >  =20
> >> On 31/10/2018 11:49, Cornelia Huck wrote: =20
> >>> On Wed, 24 Oct 2018 11:58:33 +0800
> >>> Yi Min Zhao <zyimin@linux.ibm.com> wrote:
> >>>    =20
> >>>> =E5=9C=A8 2018/10/24 =E4=B8=8A=E5=8D=885:25, Cornelia Huck =E5=86=99=
=E9=81=93:   =20
> >>>>> On Mon, 22 Oct 2018 13:17:34 +0100
> >>>>> Thomas Huth <thuth@redhat.com> wrote:
> >>>>>      =20
> >>
> >> ...snip...
> >> =20
> >>>> If endianness has error, I think the values must looks wrong.
> >>>> The right thing is that values increase from 0 and intervally.
> >>>>   =20
> >>>
> >>> Thanks for pointing me to that file; when I run under tcg, the values
> >>> indeed look like they have an endianness issue:
> >>>
> >>> Update interval: 4000 ms
> >>> Samples: 637534208
> >>> Last update TOD: f4c01d0098000000
> >>>             Load operations:	10520408729537478656
> >>>            Store operations:	5980780305148018688
> >>>      Store block operations:	0
> >>>          Refresh operations:	0
> >>>             Allocated pages:	0
> >>>                Mapped pages:	0
> >>>              Unmapped pages:	0
> >>>
> >>> (virtio-net-pci device on a just-booted guest)
> >>>    =20
> >>
> >> Hy Conny,
> >>
> >> I saw we lack a response to Thomas.
> >> Otherwise have you any remark? =20
> >=20
> > I don't remember anything beyond the endianess issue.
> >  =20
>=20
> This patch looks sane to me (I've lost the parent email on my
> client, else I would've replied directly to that).
>=20
> I'm currently awaiting getting my system up-and-running to test
> this thoroughly. Shall we do one more round with the endianess=20
> addressed in the mean time?

Sure; I'll need to rely on your testing anyway (but I'll give it a
whirl with virtio-pci).
