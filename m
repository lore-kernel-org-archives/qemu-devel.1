Received: from eggs.gnu.org ([209.51.188.92]:47855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3J4O-000632-5b
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3Iw4-0003P5-0j
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:17:36 -0400
Date: Mon, 11 Mar 2019 12:10:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190311111006.GD7899@localhost.localdomain>
References: <20190305154634.4609-1-ndevos@redhat.com>
	<20190308131151.GA31583@localhost.localdomain>
	<20190309094000.GB3535@ndevos-x270>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190309094000.GB3535@ndevos-x270>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/2] block: Gluster 6
 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Niels de Vos <ndevos@redhat.com>
Cc: qemu-block@nongnu.org, integration@gluster.org, qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>

Am 09.03.2019 um 10:40 hat Niels de Vos geschrieben:
> On Fri, Mar 08, 2019 at 02:11:51PM +0100, Kevin Wolf wrote:
> > Am 05.03.2019 um 16:46 hat Niels de Vos geschrieben:
> > > Gluster 6 is currently available as release candidate. There have b=
een a
> > > few changes to libgfapi.so that need to be adapted by consuming pro=
jects
> > > like QEMU. Fedora Rawhide already contains glusterfs-6.0-RC0, and t=
his
> > > prevents rebuilds of QEMU there (https://bugzilla.redhat.com/168429=
8).
> > >=20
> > > The following two changes should be sufficient to consume Gluster 6=
 once
> > > it is released. These have been tested on CentOS-7 with Gluster 5 a=
nd
> > > Gluster 6 (minimal manual qemu-img tests only).
> > >=20
> > > This v2 post contains changes suggested by Daniel P. Berrang=E9 and=
 Kevin
> > > Wolf. Thanks!
> >=20
> > Thanks, applied to the block branch.
>=20
> Thanks! Stefano Garzarella gave a suggestion for further cleanup. I was
> planning to address that (no #ifdef for function arguments) next week
> when I'm back from a trip, Is that something you would also like to see=
,
> or do you prefer the change to stay minimal/small as it is now? I'm
> happy to send a followup if you agree that it is cleaner.

I don't mind either way.

I'm going to send a pull request tomorrow for soft freeze, but if you
tell me that I should wait with this one, I can remove it from my queue
for now. It's a bug fix, so we can still apply an updated version during
the freeze.

A follow-up works for me, too, so whatever you prefer.

Kevin
