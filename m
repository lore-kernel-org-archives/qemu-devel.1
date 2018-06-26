Received: from eggs.gnu.org ([2001:4830:134:3::10]:54495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXpis-00082l-46
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXpir-0002Os-82
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:17:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fXpir-0002Ok-2h
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:17:37 -0400
Date: Tue, 26 Jun 2018 17:17:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180626171732.5038f53f.cohuck@redhat.com>
In-Reply-To: <20180626044650-mutt-send-email-mst@kernel.org>
References: <CADGSJ22B39JiS14L0yCYQ720-fZcwyUt1wCX1YO-6Y9FhmDKZg@mail.gmail.com>
	<20180622053141-mutt-send-email-mst@kernel.org>
	<CADGSJ23SBEFJCD50K-F-Gt86Q1-i_6iHTmSSjdXDzNnnpWZ_oQ@mail.gmail.com>
	<CADGSJ22nLcz_XaJNzUUdpjQaJY8b5wZs=ohm=B7c2qf2K7_yGA@mail.gmail.com>
	<20180623002628-mutt-send-email-mst@kernel.org>
	<CADGSJ20td7b6He6S1PBSJjCq=bNvgqMGbOjiho2eeQm2pgpK3g@mail.gmail.com>
	<20180623012406-mutt-send-email-mst@kernel.org>
	<CADGSJ211pWKYnuuzcgUqJZiHU+=7H3oQSpp1TnE=+EBjkdmCSQ@mail.gmail.com>
	<CADGSJ22DX8=rNPY+gNS_q=LCYLR5ieoE7oD8p4+8AnpzQsWSCg@mail.gmail.com>
	<da144f8f-65cd-45d9-3c81-6c8ca1fb25fe@intel.com>
	<20180626044650-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Siwei Liu <loseweigh@gmail.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com

On Tue, 26 Jun 2018 04:50:25 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jun 25, 2018 at 10:54:09AM -0700, Samudrala, Sridhar wrote:
> > > > > > Might not neccessarily be something wrong, but it's very limite=
d to
> > > > > > prohibit the MAC of VF from changing when enslaved by failover.=
 =20
> > > > > You mean guest changing MAC? I'm not sure why we prohibit that. =
=20
> > > > I think Sridhar and Jiri might be better person to answer it. My
> > > > impression was that sync'ing the MAC address change between all 3
> > > > devices is challenging, as the failover driver uses MAC address to
> > > > match net_device internally. =20
> >=20
> > Yes. The MAC address is assigned by the hypervisor and it needs to mana=
ge the movement
> > of the MAC between the PF and VF.=C2=A0 Allowing the guest to change th=
e MAC will require
> > synchronization between the hypervisor and the PF/VF drivers. Most of t=
he VF drivers
> > don't allow changing guest MAC unless it is a trusted VF. =20
>=20
> OK but it's a policy thing. Maybe it's a trusted VF. Who knows?
> For example I can see host just
> failing VIRTIO_NET_CTRL_MAC_ADDR_SET if it wants to block it.
> I'm not sure why VIRTIO_NET_F_STANDBY has to block it in the guest.
>=20

So, what I get from this is that QEMU needs to be able to control all
of standby, uuid, and mac to accommodate the different setups
(respectively have libvirt/management software set it up). Is the host
able to find out respectively define whether a VF is trusted?
