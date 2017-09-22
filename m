Received: from eggs.gnu.org ([2001:4830:134:3::10]:52889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvHiY-0002bD-DL
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvHiV-0003Yp-3l
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:45:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvHiU-0003Yd-MK
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:45:38 -0400
Date: Fri, 22 Sep 2017 14:45:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922064533.GH1397@lemon.lan>
References: <20170921150755.19914-1-famz@redhat.com>
	<20170921150755.19914-8-famz@redhat.com>
	<49d5d158-9103-d14d-8ce6-35196754aafb@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <49d5d158-9103-d14d-8ce6-35196754aafb@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 07/13] tests: Add FreeBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Fri, 09/22 03:09, Philippe Mathieu-Daud=E9 wrote:
> On 09/21/2017 12:07 PM, Fam Zheng wrote:
> > The image is prepared following instructions as in:
> >=20
> > https://wiki.qemu.org/Hosts/BSD
> >=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> $ QEMU=3D`pwd`/x86_64-softmmu/qemu-system-x86_64 make vm-build-freebsd =
V=3D1
> [...]
>   CC      tests/test-io-channel-socket.o
>   CC      tests/io-channel-helpers.o
>   LINK    tests/test-io-channel-socket
>=20
> the build hang here, stopping to use the cpu, keeping 2GB of resident
> physical memory until I hit ^C ... not enough ram for the guest? guest =
tmpfs
> full?

For how long? The four images doing "J=3D8" takes 1~2 hours here usually.=
  This
worked for me on at least two machines (one laptop and one server). :-/

>=20
> useful enough for:
> Tested-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Fam
