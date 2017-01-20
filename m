Received: from eggs.gnu.org ([2001:4830:134:3::10]:34848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cUVNv-0000Pq-Qi
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cUVNs-0006Tr-M0
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:21:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40555
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cUVNs-0006TM-GT
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:21:24 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0K9JRSk134582
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:21:24 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 283fpggc87-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:21:23 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 20 Jan 2017 09:21:20 -0000
Date: Fri, 20 Jan 2017 10:21:04 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <CAFEAcA_9rrsKkGetqQKRCGedx3E1PeE3OrS=Ea5N-qdK6PN7Cg@mail.gmail.com>
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
	<CAFEAcA_9rrsKkGetqQKRCGedx3E1PeE3OrS=Ea5N-qdK6PN7Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170120102104.69dac2c7.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 00/12] s390x update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 19 Jan 2017 18:32:44 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Hi; I'm afraid this fails to build on Windows:
>=20
> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c: In
> function =E2=80=98s390_pci_get_iommu=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c:415:20:
> error: cast from pointer to integer of different size
> [-Werror=3Dpointer-to-int-cast]
>      uint64_t key =3D (unsigned long)bus;
>                     ^
> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c: In
> function =E2=80=98s390_pci_iommu_free=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c:539:20:
> error: cast from pointer to integer of different size
> [-Werror=3Dpointer-to-int-cast]
>      uint64_t key =3D (unsigned long)bus;
>                     ^
> cc1: all warnings being treated as errors
>=20
>=20
> You probably wanted uintptr_t.

Fixed and v2 sent.

I'm wondering if there is any way to catch this earlier (without
actually building on Windows)? My mingw 4.8.2 cross-build worked fine...
