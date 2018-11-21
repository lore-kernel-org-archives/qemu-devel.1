Received: from eggs.gnu.org ([2001:4830:134:3::10]:51618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gPbNS-0004q3-N0
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:53:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gPbNK-0001jX-GI
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:53:46 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:45468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gPbNF-0001Yg-QG
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:53:35 -0500
Date: Wed, 21 Nov 2018 23:53:09 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181121225309.w2lpsfmrjsjduifd@function>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
	<20181121220647.18844-14-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181121220647.18844-14-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-3.2 v2 13/30] build-sys: use a
 seperate slirp-obj-y && slirp.mo
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

Marc-Andr=C3=A9 Lureau, le jeu. 22 nov. 2018 02:06:30 +0400, a ecrit:
> This will allow to have cflags for the whole slirp.mo -objs.
> It makes it possible to build tests that links only with
> slirp-obj-y (and not the whole common-obj).
>=20
> It is also a step towards building slirp as a shared library, although
> this requires a bit more thoughts to build with
> net/slirp.o (CONFIG_SLIRP would need to be 'm') and other build issues.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Applied to my tree, thanks!
