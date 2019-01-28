Received: from eggs.gnu.org ([209.51.188.92]:40433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1goCiG-00081R-62
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1goCiE-0001Rr-IL
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:36:55 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:44426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1goCiE-0001OT-BV
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:36:54 -0500
Date: Mon, 28 Jan 2019 20:36:50 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190128193650.wk3axz6jtnk5qwem@function>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA8zBxFFvBc3taTE3Q=JFdG9VgcCXnZ3=MNE7u8VyvKyrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8zBxFFvBc3taTE3Q=JFdG9VgcCXnZ3=MNE7u8VyvKyrQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/31] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

Peter Maydell, le lun. 28 janv. 2019 15:44:21 +0000, a ecrit:
> Note that g_spawn_async_with_fds() is one of the glib routines
> which we have a version of in glib-compat.h to cope with older
> glib versions -- have you removed the #include of that and
> not provided the equivalent code for slirp?

It seems to be so. Slirp is the only user of this, perhaps I should just
move it there?

> On OpenBSD there are lots of compiler errors, eg:
> 
> In file included from slirp/slirp.h:51:0,
>                  from slirp/arp_table.c:25:
> slirp/ip6.h: In function 'in6_equal':
> slirp/ip6.h:37:5: warning: implicit declaration of function 'memcmp'

Ok, I have folded including string.h inclusion in the corresponding
patch.

Samuel
