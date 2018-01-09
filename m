Received: from eggs.gnu.org ([2001:4830:134:3::10]:60814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZ14w-0004Tj-NB
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZ14s-0003e3-Dz
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:05:02 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:33660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eZ14s-0003cd-89
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:04:58 -0500
Date: Tue, 9 Jan 2018 22:04:51 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180109210451.lhucgkeukuwohref@var.youpi.perso.aquilenet.fr>
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180108172904.8772-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/12] slirp: avoid
 IN6_IS_ADDR_UNSPECIFIED(), rather use in6_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9, on lun. 08 janv. 2018 14:28:55 -0300, wrote:
> Host: Mac OS 10.12.5
> Compiler: Apple LLVM version 8.1.0 (clang-802.0.42)
>=20
>   slirp/ip6_icmp.c:80:38: warning: taking address of packed member 'ip_=
src' of class or
>         structure 'ip6' may result in an unaligned pointer value
>         [-Waddress-of-packed-member]
>               IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
>                                        ^~~~~~~~~~
>   /usr/include/netinet6/in6.h:238:42: note: expanded from macro 'IN6_IS=
_ADDR_UNSPECIFIED'
>           ((*(const __uint32_t *)(const void *)(&(a)->s6_addr[0]) =3D=3D=
 0) && \

I have applied it to my tree.

Thanks,
Samuel
