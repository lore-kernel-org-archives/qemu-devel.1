Received: from eggs.gnu.org ([2001:4830:134:3::10]:34773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGLVy-0005zk-9O
	for qemu-devel@nongnu.org; Wed, 09 May 2018 05:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGLVx-00031a-93
	for qemu-devel@nongnu.org; Wed, 09 May 2018 05:36:02 -0400
Date: Wed, 9 May 2018 17:35:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180509093552.GA14577@lemon.usersys.redhat.com>
References: <20180509055802.28423-1-famz@redhat.com>
	<152584609273.2673.17409124136571170302@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <152584609273.2673.17409124136571170302@71c20359a636>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] vmdk: Implement x-blockdev-create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com

On Tue, 05/08 23:08, no-reply@patchew.org wrote:
> /var/tmp/patchew-tester-tmp-rg1lnbdu/src/block/vmdk.c: In function =E2=80=
=98vmdk_co_do_create=E2=80=99:
> /var/tmp/patchew-tester-tmp-rg1lnbdu/src/block/vmdk.c:2153:8: error: =E2=
=80=98blk=E2=80=99 may be used uninitialized in this function [-Werror=3D=
maybe-uninitialized]
>      if (blk) {
>         ^
> cc1: all warnings being treated as errors

It's a genuine bug. blk should be initialized to NULL.

>   CC      block/dmg.o
> make: *** [/var/tmp/patchew-tester-tmp-rg1lnbdu/src/rules.mak:66: block=
/vmdk.o] Error 1
> make: *** Waiting for unfinished jobs....
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
