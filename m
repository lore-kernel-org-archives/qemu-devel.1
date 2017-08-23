Received: from eggs.gnu.org ([2001:4830:134:3::10]:42530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dkcFS-0007Mq-DL
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dkcFR-0007b9-A0
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:27:34 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:59603)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dkcFR-0007ag-1v
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:27:33 -0400
Date: Wed, 23 Aug 2017 22:27:28 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170823202728.dsmitbqt7bsezfgq@var.youpi.perso.aquilenet.fr>
References: <alpine.LFD.2.20.1708031718030.16909@wniryva>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1708031718030.16909@wniryva>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] A use-after-free in slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, wjjzhang <wjjzhang@tencent.com>, qemu-devel@nongnu.org

Hello,

P J P, on jeu. 03 ao=C3=BBt 2017 17:45:06 +0530, wrote:
> =3D=3D31922=3D=3DERROR: AddressSanitizer: heap-use-after-free on addres=
s 0x61400001ff8c at pc 0x56485de28ea0 bp 0x7f00f44fc950 sp 0x7f00f44fc940
> READ of size 4 at 0x61400001ff8c thread T2
>     #0 0x56485de28e9f in if_start slirp/if.c:230
>     #1 0x56485de28a58 in if_output slirp/if.c:141
>     #2 0x56485de35173 in ip_output slirp/ip_output.c:85
>     #3 0x56485de57c48 in tcp_respond slirp/tcp_subr.c:218
>     #4 0x56485de52440 in tcp_input slirp/tcp_input.c:1392
>     #5 0x56485de329ef in ip_input slirp/ip_input.c:206
>     #6 0x56485de3cf93 in slirp_input slirp/slirp.c:872
>     #7 0x56485de0726d in net_slirp_receive net/slirp.c:119
>     #8 0x56485ddee24d in nc_sendv_compat net/net.c:707
>     #9 0x56485ddee3dd in qemu_deliver_packet_iov net/net.c:734
>     #10 0x56485ddf422c in qemu_net_queue_deliver_iov net/queue.c:179
>     ...

Please don't strip the output :)
The most interesting part is what exactly freed this.

> A full trace output can be seen
>=20
>   here  -> https://paste.fedoraproject.org/paste/gh~hDctqUQ8uVt6UdG~zbg

The paste is not available any more. Is it really very large? It's
usually really better to just send it by mail, so it's archived in the
mailing list etc.

Samuel
