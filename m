Received: from eggs.gnu.org ([209.51.188.92]:45462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipCH-00050t-4h
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 18:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipCG-0006rZ-7V
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 18:29:41 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:56668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipCG-0006po-0Q
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 18:29:40 -0500
Date: Mon, 14 Jan 2019 00:29:33 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190113232933.xbsbsighng5aqvuu@function>
References: <20190113175948.21076-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113175948.21076-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] slirp: check data length while
 emulating ident function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Kira <864786842@qq.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>

P J P, le dim. 13 janv. 2019 23:29:48 +0530, a ecrit:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While emulating identification protocol, tcp_emu() does not check
> available space in the 'sc_rcv->sb_data' buffer. It could lead to
> heap buffer overflow issue. Add check to avoid it.
> 
> Reported-by: Kira <864786842@qq.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Applied to my tree, thanks!

Samuel
