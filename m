Received: from eggs.gnu.org ([2001:4830:134:3::10]:51476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsCuO-0002Mz-3y
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 15:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsCuJ-0001VX-4m
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 15:01:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dsCuI-0001US-Va
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 15:01:07 -0400
References: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <edda99a2-37b3-7428-027c-18f27a315056@redhat.com>
Date: Wed, 13 Sep 2017 21:00:53 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Virtio GPU for S390
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, kraxel@redhat.com

On 12.09.2017 16:26, Farhan Ali wrote:
> These patches wire up the virtio-gpu device for CCW bus for
> S390.
>=20
> For the S390 architecture which does not natively support any graphics
> device, virtio gpu in 2D mode could be used to emulate a simple graphic=
s
> card and use VNC as the display.
>=20
> eg: qemu-system-s390x ... -device virtio-gpu-ccw,devno=3Dfe.0.0101
>     -vnc host_ip_addr:5900
>=20
> Note, to actually see any display content the
> guest kernel needs to support DRM layer, Virtio GPU driver,
> the Virtual Terminal layer etc.

Do you have a list of CONFIG options that need to be enabled there?
Are there also any patches to the guest kernel driver required? Or did
that work out of the box once you've enabled the right CONFIG options?

> I would appreciate any feedback on these patches, specially the
> first patch.

Patches look good to me, but I'm not at all familiar with the virtio-gpu
code, so that likely does not count...

Anyway, thanks a lot for tackling this! It's pretty cool to finally have
a graphics card on s390x, too :-)

 Thomas
