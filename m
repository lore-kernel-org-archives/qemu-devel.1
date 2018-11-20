Received: from eggs.gnu.org ([2001:4830:134:3::10]:55808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOutx-0000ln-37
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:32:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOutt-00031P-E6
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:32:28 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:59170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gOutt-0002yX-3G
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:32:25 -0500
Date: Tue, 20 Nov 2018 02:32:22 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181120013222.x7dqtl6wn2ixjhm6@function>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-34-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114123643.24091-34-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 33/41] slirp: replace
 qemu_notify_event() with a callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

Marc-Andr=C3=A9 Lureau, le mer. 14 nov. 2018 16:36:35 +0400, a ecrit:
> Use a "slirp socket" helper function to call the callback when
> sbdrop() returns true.

It's really far from clear what this should be doing :)

I'd say find out how to rephrase 86073017e384 ("slirp: Signal free input
buffer space to io-thread") in a generic way.

Samuel
