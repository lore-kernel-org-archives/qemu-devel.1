Received: from eggs.gnu.org ([2001:4830:134:3::10]:54955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fmbF3-0002Q2-HX
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 04:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fmbEy-0005zk-JE
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 04:51:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fmbEy-0005yT-CW
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 04:51:48 -0400
References: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
	<d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
	<8bf07395-4872-ce74-c201-9fca232edd01@gmail.com>
	<80532e46-ffbf-9c87-5296-741bbb6f83ac@redhat.com>
	<d5ad3096-86b1-29e4-47bd-1ca71b8e7879@bluestop.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1feb3cc1-86ee-f708-6dc7-b9e20a7588ac@redhat.com>
Date: Mon, 6 Aug 2018 10:51:45 +0200
MIME-Version: 1.0
In-Reply-To: <d5ad3096-86b1-29e4-47bd-1ca71b8e7879@bluestop.org>
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
To: Rebecca Cran <rebecca@bluestop.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>, Kamil Rytarowski <kamil@netbsd.org>, Brad Smith <brad@comstyle.com>

On 07/28/2018 05:50 AM, Rebecca Cran wrote:
> On 7/25/18 5:14 AM, Thomas Huth wrote:
>=20
>>
>> Note that the error has been reported to happen on FreeBSD - so I doub=
t
>> that this <linux/types.h> header should be here.
>>
>> Anyway, our include/standard-headers/linux/types.h is also empty ... s=
o
>> could you try whether it compiles if you simply remove this #include
>> line, Rebecca?
>=20
>=20
> Sorry for the delay, I'm just getting back to this. Removing the includ=
e
> causes it to fail later on, with:
>=20
> /home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning:
> implicit declaration of function 'mremap' is invalid in C99
> [-Wimplicit-function-declaration]
> =C2=A0=C2=A0=C2=A0 host_virt =3D mremap(curr_page, 0, length, MREMAP_MA=
YMOVE);

OK, thanks for checking. According to

 https://www.freebsd.org/cgi/man.cgi?query=3Dmremap&manpath=3DNetBSD+5.0

that syscall should also be available on FreeBSD. So could you please do
one more test and see whether it works when you add the following line
somewhere at the beginning of the file:

  #include <sys/mman.h>

 Thanks,
  Thomas
