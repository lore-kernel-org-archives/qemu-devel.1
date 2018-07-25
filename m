Received: from eggs.gnu.org ([2001:4830:134:3::10]:52812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiHkd-0003Gw-S1
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 07:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiHka-0000RV-Q0
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 07:14:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fiHka-0000Lw-J9
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 07:14:36 -0400
References: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
	<d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
	<8bf07395-4872-ce74-c201-9fca232edd01@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <80532e46-ffbf-9c87-5296-741bbb6f83ac@redhat.com>
Date: Wed, 25 Jul 2018 13:14:26 +0200
MIME-Version: 1.0
In-Reply-To: <8bf07395-4872-ce74-c201-9fca232edd01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] RDMA wrongly detected as being supported on FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Rebecca Cran <rebecca@bluestop.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>

On 25.07.2018 12:48, Marcel Apfelbaum wrote:
> Hi,
>=20
> On 07/25/2018 10:32 AM, Thomas Huth wrote:
>> On 25.07.2018 06:47, Rebecca Cran wrote:
>>> In commit 18a398f6a39df4b08ff86ac0d38384193ca5f4cc, ./configure on
>>> FreeBSD incorrectly detects RDMA support,
>=20
> configure is looking for the rdma related libraries,=C2=A0 if they are =
there,
> the rdma code will be compiled into QEMU.
>=20
> You can try and run configure with --disable-rdma flag until we find
> a solution.
>=20
>>> =C2=A0 with the build subsequently
>>> failing with:
>>>
>>> /home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:19:10: fatal erro=
r:
>>> 'linux/types.h' file not found
>>> #include <linux/types.h>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~=
~
> Do you have the kernel-headers package installed?

Note that the error has been reported to happen on FreeBSD - so I doubt
that this <linux/types.h> header should be here.

Anyway, our include/standard-headers/linux/types.h is also empty ... so
could you try whether it compiles if you simply remove this #include
line, Rebecca?

 Thomas
