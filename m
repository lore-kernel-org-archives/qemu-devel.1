Received: from eggs.gnu.org ([2001:4830:134:3::10]:33548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiEHU-0000dD-VF
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 03:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiEHS-0004gj-08
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 03:32:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fiEHR-0004er-Ql
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 03:32:17 -0400
References: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
Date: Wed, 25 Jul 2018 09:32:13 +0200
MIME-Version: 1.0
In-Reply-To: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
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
To: Rebecca Cran <rebecca@bluestop.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 25.07.2018 06:47, Rebecca Cran wrote:
> In commit 18a398f6a39df4b08ff86ac0d38384193ca5f4cc, ./configure on
> FreeBSD incorrectly detects RDMA support, with the build subsequently
> failing with:
>=20
> /home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:19:10: fatal error:
> 'linux/types.h' file not found
> #include <linux/types.h>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~
> 1 error generated.
> gmake[1]: *** [/home/bcran/workspace/qemu/rules.mak:69:
> hw/rdma/vmw/pvrdma_cmd.o] Error 1
> gmake[1]: *** Waiting for unfinished jobs....
> gmake: *** [Makefile:481: subdir-x86_64-softmmu] Error 2

When was it still working for you the last time? Was it still working
with v3.0-rc1 ? Or just with v2.12 ? Any chance that you could bisect
the problem to determine when it has been introduced?

 Thomas
