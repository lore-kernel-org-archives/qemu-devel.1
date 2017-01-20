Received: from eggs.gnu.org ([2001:4830:134:3::10]:41112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cUVs1-0000Ge-U5
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cUVry-0006zz-Sr
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:52:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cUVry-0006y7-MX
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:52:30 -0500
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
	<CAFEAcA_9rrsKkGetqQKRCGedx3E1PeE3OrS=Ea5N-qdK6PN7Cg@mail.gmail.com>
	<20170120102104.69dac2c7.cornelia.huck@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b3558860-1ef6-d39a-4b4f-bd5e042c84bb@redhat.com>
Date: Fri, 20 Jan 2017 10:52:26 +0100
MIME-Version: 1.0
In-Reply-To: <20170120102104.69dac2c7.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/12] s390x update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On 20.01.2017 10:21, Cornelia Huck wrote:
> On Thu, 19 Jan 2017 18:32:44 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>=20
>> Hi; I'm afraid this fails to build on Windows:
>>
>> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c: In
>> function =E2=80=98s390_pci_get_iommu=E2=80=99:
>> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c:415:20:
>> error: cast from pointer to integer of different size
>> [-Werror=3Dpointer-to-int-cast]
>>      uint64_t key =3D (unsigned long)bus;
>>                     ^
>> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c: In
>> function =E2=80=98s390_pci_iommu_free=E2=80=99:
>> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c:539:20:
>> error: cast from pointer to integer of different size
>> [-Werror=3Dpointer-to-int-cast]
>>      uint64_t key =3D (unsigned long)bus;
>>                     ^
>> cc1: all warnings being treated as errors
>>
>>
>> You probably wanted uintptr_t.
>=20
> Fixed and v2 sent.
>=20
> I'm wondering if there is any way to catch this earlier (without
> actually building on Windows)? My mingw 4.8.2 cross-build worked fine..=
.

You likely got to use the 32-bit version of MinGW (or compile with -m32
with any other version of GCC) to catch this issue, so that you get
sizeof(long) !=3D sizeof(void *).

 Thomas
