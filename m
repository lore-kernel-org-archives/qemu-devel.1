Received: from eggs.gnu.org ([2001:4830:134:3::10]:33047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cgs9Z-00081z-5k
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cgs1J-0005iQ-50
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:57:16 -0500
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:55005)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cgs1I-0005gp-UG
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:57:13 -0500
Received: from player759.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 7F2D34A66D
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 12:56:58 +0100 (CET)
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
	<1487361200-29966-13-git-send-email-mst@redhat.com>
	<1487681835.2694.76.camel@redhat.com>
	<c0d16fc6-e149-861d-8f82-5a96619606bd@redhat.com>
	<83a2d0c9-23a4-32b1-ffe7-b33bbe9ea25d@redhat.com>
	<726a3292-9e27-6748-9669-a7c21cbf3b6e@redhat.com>
	<20170222173225.4f48dd99@t450s.home>
	<76987077-886a-5c6d-1291-c1734a5bc3b0@kaod.org>
	<008174eb-429f-e2f8-f96d-52234dc1dffd@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2c57c486-09cb-3f2f-5899-eb465a77e411@kaod.org>
Date: Thu, 23 Feb 2017 12:56:41 +0100
MIME-Version: 1.0
In-Reply-To: <008174eb-429f-e2f8-f96d-52234dc1dffd@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 02/23/2017 10:47 AM, Paolo Bonzini wrote:
>=20
>=20
> On 23/02/2017 10:33, C=E9dric Le Goater wrote:
>> I still have migration issues with this patch on ppc, which fails
>> on the target guest with :=20
>>
>> qemu-system-ppc64: VQ 0 size 0x80 < last_avail_idx 0xe1e - used_idx 0x=
0
>> qemu-system-ppc64: Failed to load virtio-blk:virtio
>> qemu-system-ppc64: error while loading state for instance 0x0 of devic=
e 'pci@800000020000000:01.0/virtio-blk'
>> qemu-system-ppc64: load of migration failed: Operation not permitted
>=20
> Stefan sent patches for that.  As a workaround, perhaps you can try
> disabling virtio-modern.

I just took the patches. All good now.

Thanks,

C.
