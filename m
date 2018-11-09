Received: from eggs.gnu.org ([2001:4830:134:3::10]:42085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gL3ko-0002gU-Nm
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gL3kl-0005Iy-Et
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:11:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gL3kl-0005I8-9H
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:11:03 -0500
Date: Fri, 9 Nov 2018 11:10:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181109101056.oyqapawhy5jmeut4@sirius.home.kraxel.org>
References: <20181107104921.20536-1-lhrazky@redhat.com>
	<20181107104921.20536-2-lhrazky@redhat.com>
	<20181108064927.i6llxv4kgcrdon7n@sirius.home.kraxel.org>
	<1541671510.16655.506.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1541671510.16655.506.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH spice v3 1/3] QXL interface: add a
 function to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On Thu, Nov 08, 2018 at 11:05:10AM +0100, Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD=
 wrote:
> Hello,
>=20
> On Thu, 2018-11-08 at 07:49 +0100, Gerd Hoffmann wrote:
> >   Hi,
> >=20
> > > + * The device_display_id_{start,count} denotes the sequence of dev=
ice display
> > > + * IDs that map to the zero-based sequence of monitor IDs provided=
 by monitors
> > > + * config on this interface. For example with device_display_id_st=
art =3D 2 and
> > > + * device_display_id_count =3D 3 you get the following mapping:
> > > + * monitor_id  ->  device_display_id
> > > + *          0  ->  2
> > > + *          1  ->  3
> > > + *          2  ->  4
> > > + *
> > > + * Note this example is unsupported in practice. The only supporte=
d cases are
> > > + * either a single device display ID (count =3D 1) or multiple dev=
ice display IDs
> > > + * in a sequence starting from 0.
> >=20
> > This is confusing.  The usage of this api in the qemu counterpart loo=
ks
> > sane though.
>=20
> Not sure what you find confusing in particular... The example? Using an
> example and then saying it's not supported?

Yes, that for example.  Also wondering why device_display_id doesn't
start at zero.

cheers,
  Gerd
