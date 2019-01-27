Received: from eggs.gnu.org ([209.51.188.92]:44128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnZ65-0008UB-Lq
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnYwp-0006mf-Sr
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:09:20 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:38912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnYwo-0006mS-Jl
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:09:19 -0500
Date: Sun, 27 Jan 2019 02:09:16 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190127010916.pwisna27eh4prkvf@function>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117230853.lbuqljd5srd6wcpu@function>
	<CAJ+F1CKOT8Ph=F3btQFWA=d_KU7iC3_+dk0b5mNAGUJ3XkucFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKOT8Ph=F3btQFWA=d_KU7iC3_+dk0b5mNAGUJ3XkucFQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/27] slirp: make it again a standalone
 project (part 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau, le ven. 18 janv. 2019 15:02:46 +0400, a ecrit:
> > may want to change the API (nobody can do something perfect at first
> > try), and when that breaks qemu build it would nasty if people couldn=
't
> > just disable libslirp usage to get qemu built for needs which don't
> > require slirp.
>=20
> Certainly, however we will be careful to keep a stable API/ABI and
> have library deprecation policies.
>=20
> Major API/ABI break / rewrite could also use a different soname.

Sure, but at least the first release of libslirp needs to be usable by
qemu with the same API as what qemu had last :)

> > Also some people would really like to see the dreaded slirp stack off
> > their qemu binaries :)
>=20
> Fortunately, that's already possible with --disable-slirp.

Alright :)

Samuel
