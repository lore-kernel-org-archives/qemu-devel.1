Received: from eggs.gnu.org ([2001:4830:134:3::10]:49479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dSmow-0005Xp-Sp
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dSmot-0004nP-2Y
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:06:30 -0400
Date: Wed, 5 Jul 2017 12:06:18 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1661217396.47274977.1499270778716.JavaMail.zimbra@redhat.com>
In-Reply-To: <e8eeea5e-6ec5-d2ca-3ff2-631d493afe76@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-9-marcandre.lureau@redhat.com>
	<4ffefaff-3c04-9328-a27b-332d30153b0a@redhat.com>
	<2079725542.47180593.1499264497487.JavaMail.zimbra@redhat.com>
	<e8eeea5e-6ec5-d2ca-3ff2-631d493afe76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/35] block: all bdrv_aio callbacks are
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Hi

----- Original Message -----
>=20
>=20
> On 05/07/2017 16:21, Marc-Andr=C3=A9 Lureau wrote:
> >>
> >> They are, but it's an implementation detail.  Why is this patch necess=
ary?
> > I didn't think this would be controversial :) well, the checks I added =
to
> > clang verify function pointer share the coroutine attribute.
> >=20
> > The function themself are/need to be coroutine_fn (as they will call
> > coroutine_fn too)
>=20
> It's not controversial, I would not have expected the functions to call
> coroutine_fn. :)  How do they do that?
>=20

For example,  null_co_readv() calls  null_co_common() which calls co_aio_sl=
eep_ns()
