Received: from eggs.gnu.org ([2001:4830:134:3::10]:42908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cUW3e-00076R-MU
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cUW3d-00055w-Gj
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:04:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cUW3d-00055c-Bk
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:04:33 -0500
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
	<CAFEAcA_9rrsKkGetqQKRCGedx3E1PeE3OrS=Ea5N-qdK6PN7Cg@mail.gmail.com>
	<20170120102104.69dac2c7.cornelia.huck@de.ibm.com>
	<b3558860-1ef6-d39a-4b4f-bd5e042c84bb@redhat.com>
	<20170120110044.2127c9a9.cornelia.huck@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <234b3164-4884-208f-5e45-b6e519b0db74@redhat.com>
Date: Fri, 20 Jan 2017 11:04:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170120110044.2127c9a9.cornelia.huck@de.ibm.com>
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
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On 20.01.2017 11:00, Cornelia Huck wrote:
> On Fri, 20 Jan 2017 10:52:26 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 20.01.2017 10:21, Cornelia Huck wrote:
>>> On Thu, 19 Jan 2017 18:32:44 +0000
>>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>>
>>>> Hi; I'm afraid this fails to build on Windows:
>>>>
>>>> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c: In
>>>> function =E2=80=98s390_pci_get_iommu=E2=80=99:
>>>> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c:415:20=
:
>>>> error: cast from pointer to integer of different size
>>>> [-Werror=3Dpointer-to-int-cast]
>>>>      uint64_t key =3D (unsigned long)bus;
>>>>                     ^
>>>> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c: In
>>>> function =E2=80=98s390_pci_iommu_free=E2=80=99:
>>>> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c:539:20=
:
>>>> error: cast from pointer to integer of different size
>>>> [-Werror=3Dpointer-to-int-cast]
>>>>      uint64_t key =3D (unsigned long)bus;
>>>>                     ^
>>>> cc1: all warnings being treated as errors
>>>>
>>>>
>>>> You probably wanted uintptr_t.
>>>
>>> Fixed and v2 sent.
>>>
>>> I'm wondering if there is any way to catch this earlier (without
>>> actually building on Windows)? My mingw 4.8.2 cross-build worked fine=
...
>>
>> You likely got to use the 32-bit version of MinGW (or compile with -m3=
2
>> with any other version of GCC) to catch this issue, so that you get
>> sizeof(long) !=3D sizeof(void *).
>=20
> Well, I already do that (mingw32, and I see -m32 on the command line;
> that already caught sizeof(uint64_t) !=3D sizeof(void *) here.) But isn=
't
> sizeof(long) =3D=3D sizeof(void *) even in the -m32 case?

Yes, sorry, my bad, it's the 64-bit version of MinGW where sizeof(long)
is different to sizeof(void *), see
https://sourceforge.net/p/mingw-w64/bugs/58/ for example.

 Thomas
