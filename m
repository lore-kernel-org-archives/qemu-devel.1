Received: from eggs.gnu.org ([2001:4830:134:3::10]:59598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fNfDu-0003RN-4V
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fNfDp-0006Bo-3x
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:03:38 -0400
Date: Tue, 29 May 2018 15:03:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180529140316.GA2578@work-vm>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
	<20180524111713.GA4660@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180524111713.GA4660@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, kwolf@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

* Richard W.M. Jones (rjones@redhat.com) wrote:
> On Fri, May 18, 2018 at 06:09:56PM +0100, Daniel P. Berrang=E9 wrote:
> > The closest to a cross-hypervisor standard is OVF which can store
> > metadata about required hardware for a VM. I'm pretty sure it does
> > not have the concept of machine types, but maybe it has a way for
> > people to define metadata extensions. Since it is just XML at the
> > end of the day, even if there was nothing official in OVF, it would
> > be possible to just define a custom XML namespace and declare a
> > schema for that to follow.
>=20
> I have a great deal of experience with the OVF "standard".
> TL;DR: DO NOT USE IT.

In addition to the detail below, from reading DMTF's OVF spec (DSP0243 v
2.1.1) I see absolutely nothing specifying hardware type.
Sure it can specify size of storage, number of ether cards, MAC
addresses for them etc - but I don't see any where specify the type of=20
emualted system.

Dave

> Long answer copied from a rant I wrote on an internal mailing list a
> while back:
>=20
>   Don't make the mistake of confusing OVF for a format.  It's not,
>   there are at least 4 non-interoperable OVF "format"s around:
>=20
>    - 2 x oVirt OVF
>    - VMware's OVF used in exported OVA files
>    - VirtualBox's OVF used in their exported OVA files
>=20
>   These are all different and do not interoperate *at all*.  So before
>   you decide "let's parse OVF", be precise about which format(s) you
>   actually want to parse.
>=20
>   Also OVF is a hideous format.  Many fields are obviously internal dat=
a
>   dumps of VMware structures, complete with internal VMware IDs instead
>   of descriptive names.  Where there are descriptive names, they use
>   English strings instead of keywords, like: <rasd:AllocationUnits>Meta=
Bytes</>
>   or my particular WTF favourite, a meaningful field which references
>   English (only) Wikipedia:
>=20
>     <Disk ovf:format=3D"http://en.wikipedia.org/wiki/Byte">
>=20
>   File references are split over two places, and there are other
>   examples where data is needlessly duplicated or it's unclear what dat=
a
>   is supposed to be.
>=20
>   Of course VMware Inc. are not stupid enough to use this format for
>   their own purposes.  They use a completely different format (VMX)
>   which is a lot like YAML.
>=20
> Rich.
>=20
> --=20
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~=
rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> Fedora Windows cross-compiler. Compile Windows programs, test, and
> build Windows installers. Over 100 libraries supported.
> http://fedoraproject.org/wiki/MinGW
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
