Received: from eggs.gnu.org ([2001:4830:134:3::10]:47257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqKhF-0000XM-Gz
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqKhC-0002W9-7u
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:00:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqKh9-0002PQ-5H
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:00:21 -0400
References: <20180816151637.24553-1-marcel.apfelbaum@gmail.com>
	<e69c3f04-acce-b6e8-7254-22edd5d04e4e@redhat.com>
	<9a69b82b-77a3-db58-5fe6-c0f1fccc1aa6@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8f1b0512-89eb-6011-208b-b98ab3b5aef7@redhat.com>
Date: Thu, 16 Aug 2018 18:00:14 +0200
MIME-Version: 1.0
In-Reply-To: <9a69b82b-77a3-db58-5fe6-c0f1fccc1aa6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2] config: split PVRDMA from RDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, rebecca@bluestop.org, peter.maydell@linaro.org

On 08/16/2018 05:58 PM, Marcel Apfelbaum wrote:
> Hi Thomas,
>=20
> On 08/16/2018 06:48 PM, Thomas Huth wrote:
>> On 08/16/2018 05:16 PM, Marcel Apfelbaum wrote:
>>> In some BSD systems RDMA migration is possible while
>>> the pvrdma device can't be used because the mremap system call
>>> is missing.
>>>
>>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>> ---
>>> =C2=A0 configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 55 ++++++++++++++++++++++++++++++++++++++++++-
>>> =C2=A0 hw/rdma/Makefile.objs |=C2=A0 2 +-
>>> =C2=A0 2 files changed, 55 insertions(+), 2 deletions(-)
>> [...]
>>> diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
>>> index 3504c39d21..bd36cbf51c 100644
>>> --- a/hw/rdma/Makefile.objs
>>> +++ b/hw/rdma/Makefile.objs
>>> @@ -1,4 +1,4 @@
>>> -ifeq ($(CONFIG_RDMA),y)
>>> +ifeq ($(CONFIG_PVRDMA),y)
>>> =C2=A0 obj-$(CONFIG_PCI) +=3D rdma_utils.o rdma_backend.o rdma_rm.o
>>> =C2=A0 obj-$(CONFIG_PCI) +=3D vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o =
\
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmw/pvrdm=
a_qp_ops.o vmw/pvrdma_main.o
>>>
>=20
>> Again:
>=20
> Sorry for not seeing the comment earlier.
>=20
>> =C2=A0 Shouldn't the CONFIG_PVRDMA only guard the second line? I thoug=
ht
>> the first list should be fine with CONFIG_RDMA?
>=20
> Indeed, theoretically the first line can be compiled=C2=A0 with CONFIG_=
RDMA,
> however the only code that utilize the first line .o files is the pvrdm=
a
> code.
> So we will simply have a bigger binary without any reason.

Ok, thanks for the explanation! Patch looks fine to me in that case, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
