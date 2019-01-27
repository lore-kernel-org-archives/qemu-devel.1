Received: from eggs.gnu.org ([209.51.188.92]:40765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnYiq-0003k0-Eg
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 19:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnYip-0000k2-Lq
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 19:54:52 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:38658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnYip-0000j2-Cs
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 19:54:51 -0500
Date: Sun, 27 Jan 2019 01:54:49 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190127005449.m5mg7jhct35zpfaf@function>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117114359.5164-23-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117114359.5164-23-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 22/27] slirp: improve send_packet() callback
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

Marc-Andr=C3=A9 Lureau, le jeu. 17 janv. 2019 15:43:54 +0400, a ecrit:
> Use a more descriptive name for the callback.
>=20
> Reuse the SlirpWriteCb type. Wrap it to check that all data has been wr=
itten.
>=20
> Return a ssize_t for potential error handling and data-loss reporting.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Applied, thanks!
