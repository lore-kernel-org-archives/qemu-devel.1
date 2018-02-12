Received: from eggs.gnu.org ([2001:4830:134:3::10]:60986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elJYn-0005IJ-1Q
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elJYm-00083W-8P
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:14:40 -0500
Date: Mon, 12 Feb 2018 20:14:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180212191419.GK5103@localhost.localdomain>
References: <20180212184849.11858-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180212184849.11858-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qemu-io: fix EOF Ctrl-D handling in
 qemu-io readline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 12.02.2018 um 19:48 hat Daniel P. Berrang=E9 geschrieben:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> qemu-io puts the TTY into non-canonical mode, which means no EOF proces=
sing is
> done and thus getchar() will never return the EOF constant. Instead we =
have to
> query the TTY attributes to determine the configured EOF character (usu=
ally
> Ctrl-D / 0x4), and then explicitly check for that value. This fixes the
> regression that prevented Ctrl-D from triggering an exit of qemu-io tha=
t has
> existed since readline was first added in
>=20
>   commit 0cf17e181798063c3824c8200ba46f25f54faa1a
>   Author: Stefan Hajnoczi <stefanha@redhat.com>
>   Date:   Thu Nov 14 11:54:17 2013 +0100
>=20
>     qemu-io: use readline.c
>=20
> It also ensures that a newline is printed when exiting, to complete the
> line output by the "qemu-io> " prompt.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin
