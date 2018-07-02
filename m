Received: from eggs.gnu.org ([2001:4830:134:3::10]:34534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZsBG-00062V-JH
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZsBF-0000PS-Ni
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:19:22 -0400
Date: Mon, 2 Jul 2018 14:19:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180702061912.GD26002@lemon.usersys.redhat.com>
References: <20180627144838.26772-1-stefanha@redhat.com>
	<153045709569.606.8754172359156428239@946cad8fd14e>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <153045709569.606.8754172359156428239@946cad8fd14e>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org

On Sun, 07/01 07:58, no-reply@patchew.org wrote:
> /var/tmp/patchew-tester-tmp-x_t1hkpk/src/block/file-posix.c:1853:13: er=
ror: redefinition of =E2=80=98raw_aio_attach_aio_context=E2=80=99
>  static void raw_aio_attach_aio_context(BlockDriverState *bs,
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-x_t1hkpk/src/block/file-posix.c:1837:13: no=
te: previous definition of =E2=80=98raw_aio_attach_aio_context=E2=80=99 w=
as here
>  static void raw_aio_attach_aio_context(BlockDriverState *bs,
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-x_t1hkpk/src/block/file-posix.c:1837:13: er=
ror: =E2=80=98raw_aio_attach_aio_context=E2=80=99 defined but not used [-=
Werror=3Dunused-function]
> cc1: all warnings being treated as errors
> make: *** [/var/tmp/patchew-tester-tmp-x_t1hkpk/src/rules.mak:69: block=
/file-posix.o] Error 1
> make: *** Waiting for unfinished jobs....

False positive. The patches are applied redundantly because patchew.org h=
as been
down for a few days.

Fam
