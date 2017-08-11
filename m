Received: from eggs.gnu.org ([2001:4830:134:3::10]:34886)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<SRS0=J12V=7N=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dgHxG-0007rY-RZ
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 17:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<SRS0=J12V=7N=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dgHxC-0004Yt-0U
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 17:58:54 -0400
Received: from domu-toccata.ens-lyon.fr ([140.77.166.138]:48264
	helo=sonata.ens-lyon.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<SRS0=J12V=7N=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dgHxB-0004YB-Q1
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 17:58:49 -0400
Date: Fri, 11 Aug 2017 23:58:45 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] SLIRP warning messages displayed while compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Hello,

Programmingkid, on jeu. 10 ao=C3=BBt 2017 16:44:19 -0400, wrote:
> While compiling I saw these error messages:
>=20
> slirp/ip6_icmp.c:79:32: warning: taking address of packed member 'ip_sr=
c' of class or
>       structure 'ip6' may result in an unaligned pointer value
>       [-Waddress-of-packed-member]
>     if (IN6_IS_ADDR_MULTICAST(&ip->ip_src) ||
>                                ^~~~~~~~~~

> slirp/ip_input.c:159:43: warning: taking address of packed member 'ip_l=
ink' of class or
>       structure 'ipq' may result in an unaligned pointer value
>       [-Waddress-of-packed-member]
>                 for (l =3D slirp->ipq.ip_link.next; l !=3D &slirp->ipq.=
ip_link;
>                                                         ^~~~~~~~~~~~~~~=
~~~

Well, if the compiler was counting well, it would notice that the
structure are made so that even with packing, fields always get aligned
on proper bounds.

(and no, we don't want to remove QEMU_PACKED from struct ip6, at least,
since it *has* to be packed to match the ipv6 headers).

Samuel
