Received: from eggs.gnu.org ([2001:4830:134:3::10]:39781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eyEdU-000891-Hs
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eyEdR-0005E8-DW
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:36:56 -0400
References: <20180319215335.1119213-1-eblake@redhat.com>
	<831cddaa-3803-10b1-8d6a-e878c97cca73@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <c2da3eac-9646-fd8e-87e7-59766d1eafab@redhat.com>
Date: Tue, 20 Mar 2018 12:36:44 +0200
MIME-Version: 1.0
In-Reply-To: <831cddaa-3803-10b1-8d6a-e878c97cca73@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] rdma: Fix 32-bit compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>

On 20/03/2018 0:08, Eric Blake wrote:
> On 03/19/2018 04:53 PM, Eric Blake wrote:
>> Use the correct printf formats, so that a 32-bit compile doesn't
>> spit out lots of warnings about %lx being incompatible with uint64_t.
>> Broken since initial commit ef6d4ccd.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> I don't know if 'make vm-build-ubuntu.i368' would catch this (it faile=
d
>> for me for other reasons); I found it via a 32-bit rawhide VM.
>=20
> That fixes most of the warnings,

Thanks!

> but not:
>=20
> /home/dummy/qemu/hw/rdma/rdma_backend.c: In function 'rdma_backend_crea=
te_mr':
> /home/dummy/qemu/hw/rdma/rdma_backend.c:409:37: error: cast to pointer =
from integer of different size
> [-Werror=3Dint-to-pointer-cast]
> =C2=A0=C2=A0=C2=A0=C2=A0 m4->ibmr =3D ibv_reg_m4(pd->ibpd, (void *)addr=
, length, access);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>=20

So the compilation actually brakes on 32bit machines?
I'll create a VM.

Thanks,
Marcel
