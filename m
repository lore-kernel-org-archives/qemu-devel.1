Received: from eggs.gnu.org ([2001:4830:134:3::10]:56146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ci2yg-0008Le-5Y
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 12:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ci2yf-0006vt-7j
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 12:51:22 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ci2yf-0006v4-11
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 12:51:21 -0500
Received: by mail-wr0-x230.google.com with SMTP id m5so19958780wrm.0
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 09:51:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170226144353.2502-1-samuel.thibault@ens-lyon.org>
References: <20170226144353.2502-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 26 Feb 2017 17:50:57 +0000
Message-ID: <CAFEAcA_BuGGUMz8u_eWAYZ+nM41rNFVBawxXwsoLrXeEBYt8UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 26 February 2017 at 14:43, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> The following changes since commit 6528a4c1f20c1ba5a22ab84bec6788a574ac04c8:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-26 11:47:00 +0000)
>
> are available in the git repository at:
>
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to bd5d2353aa69e68e45d8a89787bab17c155e9e24:
>
>   slirp: tcp_listen(): Don't try to close() an fd we never opened (2017-02-26 15:39:29 +0100)
>
> ----------------------------------------------------------------
> slirp updates
>
> ----------------------------------------------------------------
> Peter Maydell (3):
>       slirp: Check qemu_socket() return value in udp_listen()
>       slirp: Convert mbufs to use g_malloc() and g_free()
>       slirp: tcp_listen(): Don't try to close() an fd we never opened
>
>  slirp/mbuf.c   | 30 ++++++++++++++----------------
>  slirp/socket.c |  4 +++-
>  slirp/udp.c    |  4 ++++
>  3 files changed, 21 insertions(+), 17 deletions(-)

Applied, thanks.

-- PMM
