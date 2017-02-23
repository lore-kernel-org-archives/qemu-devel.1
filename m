Received: from eggs.gnu.org ([2001:4830:134:3::10]:33946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgpzx-0000HC-Fo
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgpzu-0005Vs-Dz
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:47:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgpzu-0005VB-7L
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:47:38 -0500
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
	<1487361200-29966-13-git-send-email-mst@redhat.com>
	<1487681835.2694.76.camel@redhat.com>
	<c0d16fc6-e149-861d-8f82-5a96619606bd@redhat.com>
	<83a2d0c9-23a4-32b1-ffe7-b33bbe9ea25d@redhat.com>
	<726a3292-9e27-6748-9669-a7c21cbf3b6e@redhat.com>
	<20170222173225.4f48dd99@t450s.home>
	<76987077-886a-5c6d-1291-c1734a5bc3b0@kaod.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <008174eb-429f-e2f8-f96d-52234dc1dffd@redhat.com>
Date: Thu, 23 Feb 2017 10:47:33 +0100
MIME-Version: 1.0
In-Reply-To: <76987077-886a-5c6d-1291-c1734a5bc3b0@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 12/23] virtio: use VRingMemoryRegionCaches
 for avail and used rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>, David Gibson <david@gibson.dropbear.id.au>



On 23/02/2017 10:33, C=E9dric Le Goater wrote:
> I still have migration issues with this patch on ppc, which fails
> on the target guest with :=20
>=20
> qemu-system-ppc64: VQ 0 size 0x80 < last_avail_idx 0xe1e - used_idx 0x0
> qemu-system-ppc64: Failed to load virtio-blk:virtio
> qemu-system-ppc64: error while loading state for instance 0x0 of device=
 'pci@800000020000000:01.0/virtio-blk'
> qemu-system-ppc64: load of migration failed: Operation not permitted

Stefan sent patches for that.  As a workaround, perhaps you can try
disabling virtio-modern.

Paolo
