Received: from eggs.gnu.org ([209.51.188.92]:53339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gikBK-0000Ba-V1
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 13:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gikBJ-0008Ki-8T
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 13:08:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gikBI-0008K4-TA
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 13:08:21 -0500
Date: Sun, 13 Jan 2019 23:38:14 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAJ+F1CLWzB7TGGstPZOVekfQ=pEbeu52mZU3FMnnhr2uUydrrQ@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1901132317230.18581@xnncv>
References: <20190111081909.11896-1-ppandit@redhat.com>
	<CAJ+F1C+VM8KCw3uqphK3PrJ386jABmHDJLe0dySg6T1RVMuZiw@mail.gmail.com>
	<nycvar.YSQ.7.76.1901111444171.11857@xnncv>
	<CAJ+F1CLWzB7TGGstPZOVekfQ=pEbeu52mZU3FMnnhr2uUydrrQ@mail.gmail.com>
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
| > | Check looks correct, it should probably return 1.
| >
| > Function comment says return 1 if 'm' is valid and should be appended=
 via
| > sbappend(). Not sure if unprocessed 'm' should go to sbappend().
|=20
| If you look at the rest of the function, many similar error cases retur=
n 1.

True, not sure if that's right in this case. Nonetheless, I have sent a=20
revised patch to return 1.
=20
| Ok, could you add it to the commit message ? :)

No, I'm afraid not.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
