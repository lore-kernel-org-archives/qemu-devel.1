Received: from eggs.gnu.org ([2001:4830:134:3::10]:39364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gH6b8-00043f-L1
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gH6b5-0006Js-DL
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:24:46 -0400
Received: from mail.ispras.ru ([83.149.199.45]:60068)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gH6b5-0005pQ-56
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:24:43 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<001201d45f99$4f710930$ee531b90$@ru> <87tvlvmsgg.fsf@linaro.org>
	<002501d45fab$71487f90$53d97eb0$@ru> <87sh1fmpwz.fsf@linaro.org>
	<000601d46f5b$88a3cbd0$99eb6370$@ru> <87d0rt9ei0.fsf@linaro.org>
In-Reply-To: <87d0rt9ei0.fsf@linaro.org>
Date: Mon, 29 Oct 2018 15:24:26 +0300
Message-ID: <000f01d46f82$552ad8d0$ff808a70$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH  00/21] Trace updates and plugin RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
> > One more question about your trace points.
> > In case of using trace point on every instruction execution, we may =
need
> > accessing vCPU registers (including the flags). Are they valid in =
such
> > cases?
>=20
> They are probably valid but the tricky bit will be doing it in a way
> that doesn't expose the internals of the TCG. Maybe we could exploit =
the
> GDB interface for this or come up with a named referencex API.
>=20
> > I'm asking, because at least i386 translation optimizes writebacks.
>=20
> How so? I have to admit the i386 translation code is the most opaque =
to
> me but I wouldn't have thought changing the semantics of the guests
> load/store operations would be a sensible idea.

Writeback to the registers (say EFLAGS), not to the memory.

Pavel Dovgalyuk
