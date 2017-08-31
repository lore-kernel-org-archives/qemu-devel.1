Received: from eggs.gnu.org ([2001:4830:134:3::10]:56847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnJST-0004ab-IT
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnJSN-0005Yy-RC
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:00:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnJSN-0005YB-La
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:00:03 -0400
Date: Thu, 31 Aug 2017 14:59:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170831065959.GC14896@lemon.lan>
References: <20170725133425.436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170725133425.436-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 0/6] Various docker fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Tue, 07/25 14:34, Alex Benn=E9e wrote:
> Hi,
>=20
> Phillipe pointed out a few anomalies with the travis.docker image
> during review which has led to a couple more patches. As they are bug
> fixes I didn't race to get a pull-req out today for hard-freeze. I
> will roll a pull-req by the end of the week if there are no objections
> as I'll be away for the rc1/2 cycles.
>=20
> Alex Benn=E9e (6):
>   docker: ensure NOUSER for travis images
>   docker: fix dirty/stash detection on some systems
>   docker: ignore submodules when checking diff
>   docker: docker.py make --no-cache skip checksum test
>   docker: don't install device-tree-compiler build-deps in travis.docke=
r
>   docker: reduce noise when building travis.docker

Thanks, I've queued patches 1, 4, 5, 6 for 2.11. I intend to drop the cod=
e
touched by 2 and 3 with a dedicated script:

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06349.html
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06358.html

(It would be great if you can give some test/review there :)

Fam

>=20
>  tests/docker/Makefile.include          | 3 ++-
>  tests/docker/docker.py                 | 3 ++-
>  tests/docker/dockerfiles/travis.docker | 6 ++++--
>  3 files changed, 8 insertions(+), 4 deletions(-)
>=20
> --=20
> 2.13.0
>=20
