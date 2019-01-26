Received: from eggs.gnu.org ([209.51.188.92]:59435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnXgA-0008DC-LX
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 18:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnXg9-0007So-T7
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 18:48:02 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:37284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnXg9-0007RP-Mf
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 18:48:01 -0500
Date: Sun, 27 Jan 2019 00:47:58 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190126234758.5rpcprzi2hxxcxlf@function>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117114359.5164-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117114359.5164-2-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/27] slirp: generalize guestfwd with a
 callback based approach
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

Marc-Andr=C3=A9 Lureau, le jeu. 17 janv. 2019 15:43:33 +0400, a ecrit:
> Instead of calling into QEMU chardev directly, and mixing it with
> slirp_add_exec() handling, add a new function slirp_add_guestfwd()
> which takes a write callback.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

applied, thanks!
