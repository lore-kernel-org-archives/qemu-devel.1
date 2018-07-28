Received: from eggs.gnu.org ([2001:4830:134:3::10]:53363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rebecca@bluestop.org>) id 1fjGFe-0006vD-Sx
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 23:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rebecca@bluestop.org>) id 1fjGFb-0006Zd-Bf
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 23:50:42 -0400
Received: from muon.bluestop.org ([96.73.9.1]:61713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rebecca@bluestop.org>)
	id 1fjGFa-0006Er-Rg
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 23:50:39 -0400
References: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
	<d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
	<8bf07395-4872-ce74-c201-9fca232edd01@gmail.com>
	<80532e46-ffbf-9c87-5296-741bbb6f83ac@redhat.com>
From: Rebecca Cran <rebecca@bluestop.org>
Message-ID: <d5ad3096-86b1-29e4-47bd-1ca71b8e7879@bluestop.org>
Date: Fri, 27 Jul 2018 21:50:00 -0600
MIME-Version: 1.0
In-Reply-To: <80532e46-ffbf-9c87-5296-741bbb6f83ac@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>

On 7/25/18 5:14 AM, Thomas Huth wrote:

>
> Note that the error has been reported to happen on FreeBSD - so I doubt
> that this <linux/types.h> header should be here.
>
> Anyway, our include/standard-headers/linux/types.h is also empty ... so
> could you try whether it compiles if you simply remove this #include
> line, Rebecca?


Sorry for the delay, I'm just getting back to this. Removing the include
causes it to fail later on, with:


/home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning:
implicit declaration of function 'mremap' is invalid in C99
[-Wimplicit-function-declaration]
=C2=A0=C2=A0=C2=A0 host_virt =3D mremap(curr_page, 0, length, MREMAP_MAYM=
OVE);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^
/home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning: this
function declaration is not a prototype [-Wstrict-prototypes]
/home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:60:46: error: use of
undeclared identifier 'MREMAP_MAYMOVE'
=C2=A0=C2=A0=C2=A0 host_virt =3D mremap(curr_page, 0, length, MREMAP_MAYM=
OVE);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
/home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:97:48: error: use of
undeclared identifier 'MREMAP_MAYMOVE'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mremap(curr_page, 0, TARGET_PA=
GE_SIZE, MREMAP_MAYMOVE |
MREMAP_FIXED,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
/home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:97:65: error: use of
undeclared identifier 'MREMAP_FIXED'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mremap(curr_page, 0, TARGET_PA=
GE_SIZE, MREMAP_MAYMOVE |
MREMAP_FIXED,


Since I'm not interested in RDMA support, I can work around it by
passing --disable-rdma on the command line.


--=20
Rebecca
