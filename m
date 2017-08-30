Received: from eggs.gnu.org ([2001:4830:134:3::10]:38437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmtkW-0008Cr-Ul
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmtkT-0001V1-R6
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:33:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dmtkT-0001UK-H9
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:33:01 -0400
Date: Wed, 30 Aug 2017 11:32:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170830033255.GD4208@lemon.lan>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-7-famz@redhat.com>
	<518b29b0-654d-f438-7b18-0419987ba442@amsat.org>
	<9bb228d9-15ac-8721-9345-f2037635d063@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9bb228d9-15ac-8721-9345-f2037635d063@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/10] tests: Add NetBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Tue, 08/29 18:47, Philippe Mathieu-Daud=E9 wrote:
> Hi Fam,
>=20
> On 08/29/2017 09:09 AM, Philippe Mathieu-Daud=E9 wrote:
> [...]>> +if __name__ =3D=3D "__main__":
> > > +=A0=A0=A0 sys.exit(basevm.main(NetBSDVM))
> >=20
> > This one is failing:
> >=20
> > DEBUG:root:ssh_cmd: ssh -q -o StrictHostKeyChecking=3Dno -o
> > UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D1 -p 34091 -i
> > /tmp/qemu-vm-59XYOj/id_rsa qemu@127.0.0.1
> >  =A0=A0=A0=A0=A0=A0=A0 set -e;
> >  =A0=A0=A0=A0=A0=A0=A0 cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> >  =A0=A0=A0=A0=A0=A0=A0 tar -xf /dev/rld1a;
> >  =A0=A0=A0=A0=A0=A0=A0 ./configure --python=3Dpython2.7 ;
> >  =A0=A0=A0=A0=A0=A0=A0 gmake -j4;
> >  =A0=A0=A0=A0=A0=A0=A0 gmake check;
> >=20
> > ...
> >  =A0 CC=A0=A0=A0=A0=A0 bt-host.o
> >  =A0 CC=A0=A0=A0=A0=A0 bt-vhci.o
> >  =A0 CC=A0=A0=A0=A0=A0 dma-helpers.o
> >  =A0 CC=A0=A0=A0=A0=A0 vl.o
> >  =A0 CC=A0=A0=A0=A0=A0 tpm.o
> > In file included from vl.c:72:0:
> > /var/tmp/qemu-test.ht0XHU/include/hw/loader.h:4:29: fatal error:
> > hw/nvram/fw_cfg.h: No such file or directory
> >  =A0#include "hw/nvram/fw_cfg.h"
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 ^
> > compilation terminated.
> > /var/tmp/qemu-test.ht0XHU/rules.mak:66: recipe for target 'vl.o' fail=
ed
> > gmake: *** [vl.o] Error 1
> > gmake: *** Waiting for unfinished jobs....
> > tests/vm/Makefile.include:32: recipe for target 'vm-build-netbsd' fai=
led
> > make: *** [vm-build-netbsd] Error 3
>=20
> Probably false alarm, this seems to be an ENOMEM host error.
>=20
> I later got:
>=20
> 	CHK version_gen.h
> Makefile:342: recipe for target 'subdir-dtc' failed
> gmake[1]: *** No rule to make target 'dtc/libfdt/fdt.h', needed by
> 'libfdt/fdt.o'.  Stop.
> gmake: *** [subdir-dtc] Error 2
> gmake: *** Waiting for unfinished jobs....
>=20
> which I solved running "gmake -C dtc" after ./configure but I'm not sur=
e it
> is necessary or can come from my tree, this testing is veeeeeeery slow =
and
> mostly kill my laptop, I ended wondering on what kind of hardware you
> developed this series without going crazy nut :S

Not too beefy, just a Lenovo W541 laptop with i7-4810. To save you from b=
eing
killed again, maybe we should reduce the default -smp to nr_cores / 2?

Fam
