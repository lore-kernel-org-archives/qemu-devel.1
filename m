Received: from eggs.gnu.org ([2001:4830:134:3::10]:55707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e41uC-0004p0-DS
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e41u8-0008Nq-Gf
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:41:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e41u8-0008NZ-7M
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:41:48 -0400
Date: Mon, 16 Oct 2017 17:41:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171016094140.GH4166@pxdev.xzpeter.org>
References: <20171016065216.18162-1-peterx@redhat.com>
	<150813912960.320.2215446747740356583@b58463cdfd5f>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150813912960.320.2215446747740356583@b58463cdfd5f>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/32] Migration: postcopy failure
 recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, aarcange@redhat.com, quintela@redhat.com, a.perevalov@samsung.com, dgilbert@redhat.com

On Mon, Oct 16, 2017 at 12:32:10AM -0700, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
>=20
> Type: series
> Subject: [Qemu-devel] [PATCH v3 00/32] Migration: postcopy failure reco=
very
> Message-id: 20171016065216.18162-1-peterx@redhat.com
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> # Testing script will be invoked under the git checkout with
> # HEAD pointing to a commit that has the patches applied on top of "bas=
e"
> # branch
> set -e
> echo "=3D=3D=3D ENV =3D=3D=3D"
> env
> echo "=3D=3D=3D PACKAGES =3D=3D=3D"
> rpm -qa
> echo "=3D=3D=3D TEST BEGIN =3D=3D=3D"
> CC=3D$HOME/bin/cc
> INSTALL=3D$PWD/install
> BUILD=3D$PWD/build
> echo -n "Using CC: "
> realpath $CC
> mkdir -p $BUILD $INSTALL
> SRC=3D$PWD
> cd $BUILD
> $SRC/configure --cc=3D$CC --prefix=3D$INSTALL
> make -j4
> # XXX: we need reliable clean up
> # make check -j4 V=3D1
> make install
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D

[...]

>   CC      migration/postcopy-ram.o
>   CC      migration/qjson.o
>   CC      migration/block.o
>   CC      net/net.o
>   CC      net/queue.o
> /var/tmp/patchew-tester-tmp-nm4b3qpv/src/migration/postcopy-ram.c: In f=
unction =E2=80=98postcopy_ram_fault_thread=E2=80=99:
> /var/tmp/patchew-tester-tmp-nm4b3qpv/src/migration/postcopy-ram.c:553:1=
3: error: ignoring return value of =E2=80=98read=E2=80=99, declared with =
attribute warn_unused_result [-Werror=3Dunused-result]
>              read(mis->userfault_event_fd, &tmp64, 8);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Need to capture read() return code.  Fixed.

I captured this as well using "make docker-test-build@fedora". Anyone
knows why I didn't encounter this on my Fedora 26 host?  My gcc
version: 7.2.1 20170915 (Red Hat 7.2.1-2), which seems to be quite new
as well.

Would also appreciate if anyone can provide a minimum docker test
subset (TEST & IMAGE) that I'd run before posting patches. TIA.

> cc1: all warnings being treated as errors
> /var/tmp/patchew-tester-tmp-nm4b3qpv/src/rules.mak:66: recipe for targe=
t 'migration/postcopy-ram.o' failed
> make: *** [migration/postcopy-ram.o] Error 1
> make: *** Waiting for unfinished jobs....
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

--=20
Peter Xu
