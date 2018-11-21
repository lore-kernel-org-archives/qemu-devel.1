Received: from eggs.gnu.org ([2001:4830:134:3::10]:54409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gPamT-0003e0-VE
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gPamP-0003Pz-MH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:15:33 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:44670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gPamP-0003JZ-AU
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:15:29 -0500
Date: Wed, 21 Nov 2018 23:15:16 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181121221516.zixijgq26oasey32@function>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
	<20181121220647.18844-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181121220647.18844-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-3.2 v2 02/30] slirp: drop <Vista
 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

Marc-Andr=C3=A9 Lureau, le jeu. 22 nov. 2018 02:06:19 +0400, a ecrit:
> Since commit 12f8def0e02232d7c6416ad9b66640f973c531d1 (v2.9), qemu
> requires Vista. Let's remove some conditional code.
>=20
> Note that this introduces a missing declaration warning with mingw.
> warning: implicit declaration of function 'inet_ntop'
>=20
> See also: https://sourceforge.net/p/mingw-w64/mailman/message/36473782/
>=20
> We could workaround it by declaring it ourself depending on __MINGW64_V=
ERSION_*:
> WINSOCK_API_LINKAGE INT WSAAPI inet_pton(int Family, PCTSTR pszAddrStri=
ng, PVOID pAddrBuf);
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Applied to my tree, thanks!
