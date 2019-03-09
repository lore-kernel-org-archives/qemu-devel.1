Received: from eggs.gnu.org ([209.51.188.92]:36391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h2YSd-0002GT-IY
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h2YSc-0005zb-Pp
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:40:07 -0500
Date: Sat, 9 Mar 2019 10:40:00 +0100
From: Niels de Vos <ndevos@redhat.com>
Message-ID: <20190309094000.GB3535@ndevos-x270>
References: <20190305154634.4609-1-ndevos@redhat.com>
	<20190308131151.GA31583@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190308131151.GA31583@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, integration@gluster.org, qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>

On Fri, Mar 08, 2019 at 02:11:51PM +0100, Kevin Wolf wrote:
> Am 05.03.2019 um 16:46 hat Niels de Vos geschrieben:
> > Gluster 6 is currently available as release candidate. There have bee=
n a
> > few changes to libgfapi.so that need to be adapted by consuming proje=
cts
> > like QEMU. Fedora Rawhide already contains glusterfs-6.0-RC0, and thi=
s
> > prevents rebuilds of QEMU there (https://bugzilla.redhat.com/1684298)=
.
> >=20
> > The following two changes should be sufficient to consume Gluster 6 o=
nce
> > it is released. These have been tested on CentOS-7 with Gluster 5 and
> > Gluster 6 (minimal manual qemu-img tests only).
> >=20
> > This v2 post contains changes suggested by Daniel P. Berrang=E9 and K=
evin
> > Wolf. Thanks!
>=20
> Thanks, applied to the block branch.

Thanks! Stefano Garzarella gave a suggestion for further cleanup. I was
planning to address that (no #ifdef for function arguments) next week
when I'm back from a trip, Is that something you would also like to see,
or do you prefer the change to stay minimal/small as it is now? I'm
happy to send a followup if you agree that it is cleaner.

Niels
