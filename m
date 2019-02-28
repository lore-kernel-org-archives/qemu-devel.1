Received: from eggs.gnu.org ([209.51.188.92]:48866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gzSYN-0006DB-FU
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gzSYI-0003jh-QF
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:45:13 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:42390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gzSYF-0003h3-PP
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:45:08 -0500
Date: Thu, 28 Feb 2019 12:38:10 -0800
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190228203810.7l2f76by3hqf463l@function>
References: <155137655081.44146.7139636183950580495.stgit@bahia.lan>
	<CAFEAcA_p1fFQWKnDXfTw=7UY_pM3RfZ5pJbBATBzDK_6DN7HmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_p1fFQWKnDXfTw=7UY_pM3RfZ5pJbBATBzDK_6DN7HmQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>

Hello,

Peter Maydell, le jeu. 28 f=C3=A9vr. 2019 18:14:40 +0000, a ecrit:
> My guess is that this got a packed attribute mistakenly
> by analogy with the struct slirp_arphdr which is used in
> the ArpTable struct -- but that struct really is used to
> match on-the-wire data, and this one is not.

This looks like cargo-culted indeed. Greg, please repost with the size
constraint, we do not need it.

Samuel
