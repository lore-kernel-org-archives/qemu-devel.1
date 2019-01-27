Received: from eggs.gnu.org ([209.51.188.92]:35576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnY9P-00079g-4h
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 19:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnY9O-0005rS-Ep
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 19:18:15 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:34910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnY9O-0005qC-6n
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 19:18:14 -0500
Date: Sun, 27 Jan 2019 01:18:10 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190127001810.lfmmpgg5sj5jxusj@function>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117114359.5164-9-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117114359.5164-9-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/27] slirp: replace most qemu socket
 utilities with slirp own version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

Marc-Andr=C3=A9 Lureau, le jeu. 17 janv. 2019 15:43:40 +0400, a ecrit:
> qemu_set_nonblock() is slightly more problematic and will be dealt
> with in a separate patch.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Applied, I just added a -DWITH_QEMU in the Makefile, for inet_aton,
thanks!
