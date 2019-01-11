Received: from eggs.gnu.org ([209.51.188.92]:59585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ghsxq-0002y8-Ra
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ghsxq-0003WV-As
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:18:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ghsxq-0003WK-50
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:18:54 -0500
Date: Fri, 11 Jan 2019 14:48:41 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAJ+F1C+VM8KCw3uqphK3PrJ386jABmHDJLe0dySg6T1RVMuZiw@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1901111444171.11857@xnncv>
References: <20190111081909.11896-1-ppandit@redhat.com>
	<CAJ+F1C+VM8KCw3uqphK3PrJ386jABmHDJLe0dySg6T1RVMuZiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: check data length while emulating
 ident function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, Kira <864786842@qq.com>

+-- On Fri, 11 Jan 2019, Marc-Andr=C3=A9 Lureau wrote --+
| > +            if (m->m_len > so_rcv->sb_datalen
| > +                            - (so_rcv->sb_wptr - so_rcv->sb_data)) {
| > +                m_free(m);
| > +                return 0;
| > +            }
|=20
| Check looks correct, it should probably return 1.

Function comment says return 1 if 'm' is valid and should be appended via=
=20
sbappend(). Not sure if unprocessed 'm' should go to sbappend().

| Is there a reproducer?

Yes, I have one.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
