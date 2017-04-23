Received: from eggs.gnu.org ([2001:4830:134:3::10]:58337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2Elo-0006OA-R9
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 06:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2Ell-0002Fb-OF
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 06:29:32 -0400
References: <20170323113156.9277-1-marcandre.lureau@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <504762ea-025a-3c12-6674-93d074407de5@msgid.tls.msk.ru>
Date: Sun, 23 Apr 2017 13:29:27 +0300
MIME-Version: 1.0
In-Reply-To: <20170323113156.9277-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: tftp, copy sockaddr_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, QEMU Trivial <qemu-trivial@nongnu.org>

23.03.2017 14:31, Marc-Andr=C3=A9 Lureau wrote:
..
> The sockaddr_storage pointer is the sockaddr_in6 lhost on the
> stack. Copy only the source addr size.

Applied to -trivial, thanks!

/mjt
