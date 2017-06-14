Received: from eggs.gnu.org ([2001:4830:134:3::10]:36798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL2Ym-0006zN-IW
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL2Yj-0001G4-E0
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:17:48 -0400
Date: Wed, 14 Jun 2017 15:17:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170614071741.GJ25748@lemon>
References: <20170614064452.23167-1-sjitindarsingh@gmail.com>
	<149742349493.876.11766335992909575820@4a9a010726c0>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149742349493.876.11766335992909575820@4a9a010726c0>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix return value in tcg radix
 mmu fault handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sjitindarsingh@gmail.com, agraf@suse.de, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On Tue, 06/13 23:58, no-reply@patchew.org wrote:
> In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
> /tmp/qemu-test/src/include/migration/register.h:18: error: redefinition=
 of typedef =E2=80=98LoadStateHandler=E2=80=99
> /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous decla=
ration of =E2=80=98LoadStateHandler=E2=80=99 was here
>   CC      hw/pcmcia/pcmcia.o
> make: *** [hw/net/vmxnet3.o] Error 1
> make: *** Waiting for unfinished jobs....
> tests/docker/Makefile.include:118: recipe for target 'docker-run' faile=
d
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-8uvtdvzp/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-q=
uick@centos6' failed
> make: *** [docker-run-test-quick@centos6] Error 2
> =3D=3D=3D OUTPUT END =3D=3D=3D

Not related to this patch. It is an issue on master.

Fam
