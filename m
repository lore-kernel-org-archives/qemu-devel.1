Received: from eggs.gnu.org ([209.51.188.92]:36362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gkGk7-0003zy-Cb
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 18:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gkGk6-0003xd-FG
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 18:06:35 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:37630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gkGk5-0003rV-Hc
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 18:06:34 -0500
Date: Fri, 18 Jan 2019 00:04:15 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190117230415.jmxjox3breoqj3g3@function>
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
>          /* XXX this blocks entire thread. Rewrite to use
>           * qemu_chr_fe_write and background I/O callbacks */

Seeing this, I guess a whole pass will be useful to turn these qemu
comment references into something that does not require knowledge of
qemu internals :)

Samuel
