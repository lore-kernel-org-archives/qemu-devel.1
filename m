Received: from eggs.gnu.org ([2001:4830:134:3::10]:35143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eyENS-00018s-35
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eyENM-0000g9-Hq
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:20:21 -0400
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:32883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eyENM-0000fn-Af
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:20:16 -0400
Received: from player758.ha.ovh.net (unknown [10.109.120.181])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id A4B491A6CA4
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 11:20:14 +0100 (CET)
Date: Tue, 20 Mar 2018 11:20:08 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180320112008.7acf2dfe@bahia.lan>
In-Reply-To: <1301d99e-9cc8-e481-985e-4afe9bd6b82c@redhat.com>
References: <152120204902.1103.7114773412109402452.stgit@bahia.lan>
	<181e938f-76b7-84b2-96f1-1f8832236e23@redhat.com>
	<1301d99e-9cc8-e481-985e-4afe9bd6b82c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] virtio_net: flush uncompleted TX on
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, R Nageswara Sastry <nasastry@in.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 20 Mar 2018 11:27:26 +0800
Jason Wang <jasowang@redhat.com> wrote:

> >> =C2=A0 -static
> >> =C2=A0 void qemu_flush_or_purge_queued_packets(NetClientState *nc, boo=
l=20
> >> purge)
> >> =C2=A0 {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc->receive_disabled =3D 0;
> >>
> >> =20
> >
> > Applied and queued for -stable.
> >
> > Thanks
> > =20
>=20
> Unfortunately, this breaks hotplug test:
>=20
>  =C2=A0TEST: tests/virtio-net-test... (pid=3D7117)
> /x86_64/virtio/net/pci/basic: OK
> /x86_64/virtio/net/pci/rx_stop_cont: OK
> /x86_64/virtio/net/pci/hotplug: Broken pipe
> FAIL
>=20
> Thanks

Hi Jason,

Yes, I've just realized this patch assumes the virtio-net device
does have an associated backend (ie, nc->peer !=3D NULL) otherwise
we segfault. This happens to be the case with the hotplug test.

I'll send a v3.

Cheers,

--
Greg
