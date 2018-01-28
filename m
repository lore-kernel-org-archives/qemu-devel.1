Received: from eggs.gnu.org ([2001:4830:134:3::10]:32930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agx@sigxcpu.org>) id 1efksk-0006ru-5F
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 06:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agx@sigxcpu.org>) id 1efksg-0000vk-S4
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 06:12:18 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:39023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agx@sigxcpu.org>) id 1efksg-0000uG-KU
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 06:12:14 -0500
Date: Sun, 28 Jan 2018 12:12:10 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Message-ID: <20180128111210.GA4791@bogon.m.sigxcpu.org>
References: <20180124130126.20871-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180124130126.20871-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/11] linux-user: improve NETLINK strace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

Hi,
On Wed, Jan 24, 2018 at 10:01:15AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Few patches I'v been writting while trying to figure out this issue:
> http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html

Whole series

Tested-By: Guido G=FCnther <agx@sigxcpu.org>

>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=E9 (11):
>   linux-user/strace: dump AF_NETLINK sockaddr content
>   linux-user/strace: improve sendto() output
>   linux-user/strace: add print_sockaddr_ptr() to handle plain/pointer a=
ddrlen
>   linux-user/strace: improve recvfrom() output
>   linux-user/strace: improve getsockname() output
>   linux-user/strace: improve recvmsg() output
>   linux-user/strace: improve bind() output
>   linux-user/strace: improve gettimeofday() output
>   linux-user/strace: improve capget()/capset() output
>   linux-user/syscall: verify recvfrom(addr) is user-writable
>   linux-user/syscall: simplify recvfrom()
>=20
>  linux-user/syscall_defs.h |   7 +++
>  linux-user/strace.c       | 122 ++++++++++++++++++++++++++++++++++++++=
+++++++-
>  linux-user/syscall.c      |  16 +++---
>  linux-user/strace.list    |  16 +++---
>  4 files changed, 144 insertions(+), 17 deletions(-)
>=20
> --=20
> 2.15.1
>=20
