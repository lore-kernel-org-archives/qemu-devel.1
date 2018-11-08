Received: from eggs.gnu.org ([2001:4830:134:3::10]:41218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjongsma@redhat.com>) id 1gKnGi-00015O-49
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjongsma@redhat.com>) id 1gKnGd-0005db-TQ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:34:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjongsma@redhat.com>) id 1gKnGd-0005Uo-L6
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:34:51 -0500
Message-ID: <6e8c0068efa0fe492ac7473307f14681b7323b73.camel@redhat.com>
From: Jonathon Jongsma <jjongsma@redhat.com>
Date: Thu, 08 Nov 2018 10:34:21 -0600
In-Reply-To: <1541671510.16655.506.camel@redhat.com>
References: <20181107104921.20536-1-lhrazky@redhat.com>
	<20181107104921.20536-2-lhrazky@redhat.com>
	<20181108064927.i6llxv4kgcrdon7n@sirius.home.kraxel.org>
	<1541671510.16655.506.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Spice-devel] [RFC PATCH spice v3 1/3] QXL
 interface: add a function to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On Thu, 2018-11-08 at 11:05 +0100, Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD wrote=
:
> Hello,
>=20
> On Thu, 2018-11-08 at 07:49 +0100, Gerd Hoffmann wrote:
> >   Hi,
> >=20
> > > + * The device_display_id_{start,count} denotes the sequence of
> > > device display
> > > + * IDs that map to the zero-based sequence of monitor IDs
> > > provided by monitors
> > > + * config on this interface. For example with
> > > device_display_id_start =3D 2 and
> > > + * device_display_id_count =3D 3 you get the following mapping:
> > > + * monitor_id  ->  device_display_id
> > > + *          0  ->  2
> > > + *          1  ->  3
> > > + *          2  ->  4
> > > + *
> > > + * Note this example is unsupported in practice. The only
> > > supported cases are
> > > + * either a single device display ID (count =3D 1) or multiple
> > > device display IDs
> > > + * in a sequence starting from 0.
> >=20
> > This is confusing.  The usage of this api in the qemu counterpart
> > looks
> > sane though.
>=20
> Not sure what you find confusing in particular... The example? Using
> an
> example and then saying it's not supported? (I wated to use a
> nontrivial example that will show the concept...) Suggestions for
> improvement?

It is funny that you chose an unsupported example for demonstration,
but I can't think of a better option. The supported scenarios don't
demonstrate the full behavior very well...


>=20
> Thanks,
> Lukas
>=20
> > cheers,
> >   Gerd
> >=20
>=20
> _______________________________________________
> Spice-devel mailing list
> Spice-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/spice-devel
