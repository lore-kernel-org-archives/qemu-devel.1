Received: from eggs.gnu.org ([209.51.188.92]:56209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nagarwal@xilinx.com>) id 1gz3Bf-0007Ah-II
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nagarwal@xilinx.com>) id 1gz3Be-0008G0-Jc
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:40:07 -0500
Received: from mail-eopbgr740051.outbound.protection.outlook.com
	([40.107.74.51]:46767
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nagarwal@xilinx.com>) id 1gz3Be-00085E-8p
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:40:06 -0500
From: Nikhil Agarwal <nagarwal@xilinx.com>
Date: Wed, 27 Feb 2019 17:39:46 +0000
Message-ID: <MN2PR02MB580695B27405FA206A38110FB6740@MN2PR02MB5806.namprd02.prod.outlook.com>
References: <MN2PR02MB580680857B3390A2447B512DB67B0@MN2PR02MB5806.namprd02.prod.outlook.com>
	<20190227152347.GF22539@stefanha-x1.localdomain>
In-Reply-To: <20190227152347.GF22539@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Virtio-net control queue handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "libvir-list@redhat.com" <libvir-list@redhat.com>

Hi Stefan,

Thanks for directing question to correct people, yes your understanding is =
correct.

I want virtio-net control virtqueue to be handled by vhost-user-net device =
based backend for vdpa use case where control message would do some configu=
ration on actual hw device. Or these changes should to be done in libvirt w=
here QMP event are being handled as of now?

Regards
Nikhil


-----Original Message-----
From: Stefan Hajnoczi <stefanha@gmail.com>=20
Sent: Wednesday, February 27, 2019 8:54 PM
To: Nikhil Agarwal <nagarwal@xilinx.com>
Cc: qemu-devel@nongnu.org; jasowang@redhat.com; libvir-list@redhat.com
Subject: Re: [Qemu-devel] Virtio-net control queue handling

On Tue, Feb 26, 2019 at 02:13:43PM +0000, Nikhil Agarwal wrote:
> Is there any option in QEMU to offload virtio device control queue handli=
ng to backend instead of deciphering and passing to libvirt via QMP? if not=
, is there any interface in libvirt which passes on these message to applic=
ation or i directly use QMP interface from QEMU?

I'm not sure I understand your question.  It could be because of
terminology:

"virtio device control queue" =3D=3D virtio-net control virtqueue?

"backend" =3D=3D vhost-user-net device backend?

"message" =3D=3D QMP event?

I have CCed Jason Wang, QEMU network subsystem maintainer, and the libvirt =
mailing list.

Stefan
