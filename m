Received: from eggs.gnu.org ([2001:4830:134:3::10]:59137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUHWE-0005zC-P8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUHWD-0001wP-Ty
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:33:06 -0500
Received: from mail-vk0-x235.google.com ([2607:f8b0:400c:c05::235]:33058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUHWD-0001vt-PB
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:33:05 -0500
Received: by mail-vk0-x235.google.com with SMTP id k127so36355328vke.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 10:33:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 18:32:44 +0000
Message-ID: <CAFEAcA_9rrsKkGetqQKRCGedx3E1PeE3OrS=Ea5N-qdK6PN7Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2017 at 08:56, Cornelia Huck <cornelia.huck@de.ibm.com> wrote=
:
> The following changes since commit 2ccede18bd24fce5db83fef3674563a1f25671=
7b:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-req=
uest' into staging (2017-01-16 12:41:35 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170117
>
> for you to fetch changes up to 5fd04a2b92bf81f39da63fba9e5ae563a8b929ae:
>
>   virtio-ccw: fix ring sizing (2017-01-16 16:23:27 +0100)
>
> ----------------------------------------------------------------
> First set of s390x patches for 2.9:
> - rework of the zpci code, giving us proper multibus support
> - introduction of the 2.9 machine
> - fixes and improvements
>
> ----------------------------------------------------------------

Hi; I'm afraid this fails to build on Windows:

/home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c: In
function =E2=80=98s390_pci_get_iommu=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c:415:20:
error: cast from pointer to integer of different size
[-Werror=3Dpointer-to-int-cast]
     uint64_t key =3D (unsigned long)bus;
                    ^
/home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c: In
function =E2=80=98s390_pci_iommu_free=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c:539:20:
error: cast from pointer to integer of different size
[-Werror=3Dpointer-to-int-cast]
     uint64_t key =3D (unsigned long)bus;
                    ^
cc1: all warnings being treated as errors


You probably wanted uintptr_t.

thanks
-- PMM
