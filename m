Received: from eggs.gnu.org ([2001:4830:134:3::10]:52680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1g9DET-0005tH-M2
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 13:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1g9DEQ-00028G-Be
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 13:52:45 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:38946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1g9DEP-000275-Pe
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 13:52:42 -0400
Date: Sun, 7 Oct 2018 19:52:38 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181007175238.ggxl6cqrdan6gqiv@var.youpi.perso.aquilenet.fr>
References: <20180830155757.103694-1-gavingrant@protonmail.com>
	<20180830155757.103694-2-gavingrant@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830155757.103694-2-gavingrant@protonmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Propagate host TCP RST packet to
 the guest after socket disconnected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gavin Grant <gavingrant@protonmail.com>
Cc: jan.kiszka@siemens.com, qemu-devel@nongnu.org

Hello,

Gavin Grant, le jeu. 30 ao=C3=BBt 2018 16:57:57 +0100, a ecrit:
> Commit 27d92ebc5ed1bb0b518d0ebc4c609182ad20a799 handled the case where =
the TCP
> connection is abruptly closed via a RST packet, by checking for the ECO=
NNRESET
> errno. However it does not consider the case where the connection has b=
een
> half-closed by the host (FIN/ACK), then the host socket is disconnected=
. For
> example, if the host application calls close() on the socket, then the
> application exits.
>=20
> In this case, the socket still exists due to the file descriptor in SLI=
RP, but
> it is disconnected. recv() does not indicate an error since an orderly =
socket
> close has previously occurred. The socket will then be stuck in FIN_WAI=
T_2,
> until the peer sends FIN/ACK or a timeout occurs. Instead we can send a=
 RST
> to the peer and transition to the CLOSED state.
>=20
> Signed-off-by: Gavin Grant <gavingrant@protonmail.com>

I have fixed it a bit and pushed to my tree, thanks!

Samuel
