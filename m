Received: from eggs.gnu.org ([2001:4830:134:3::10]:49105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds92W-0005P7-RP
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds92S-00032E-Tr
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:53:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds92S-00031M-OS
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:53:16 -0400
Message-ID: <1505314391.22749.9.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 16:53:11 +0200
In-Reply-To: <4c65d9e0-df2c-6838-22dc-46415cdd82f1@redhat.com>
References: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
	<a30f50d543182914e83cba5501f615a8ded2b858.1505225353.git.alifm@linux.vnet.ibm.com>
	<4c65d9e0-df2c-6838-22dc-46415cdd82f1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/2] virtio-gpu-ccw: Create a virtio gpu
 device for the ccw bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com

On Wed, 2017-09-13 at 14:09 +0200, David Hildenbrand wrote:
> > +=C2=A0=C2=A0=C2=A0 dc->props =3D virtio_ccw_gpu_properties;
> > +=C2=A0=C2=A0=C2=A0 dc->hotpluggable =3D false;
>=20
> Wonder if hotplug could work?

No, ui/* doesn't support hotplug.

cheers,
  Gerd
