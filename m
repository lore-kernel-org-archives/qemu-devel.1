Received: from eggs.gnu.org ([2001:4830:134:3::10]:56951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gH2GC-0006xh-KT
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 03:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gH2G5-0003bP-QK
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 03:46:52 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57146)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gH2G5-0003W3-Hb
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 03:46:45 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<001201d45f99$4f710930$ee531b90$@ru> <87tvlvmsgg.fsf@linaro.org>
	<002501d45fab$71487f90$53d97eb0$@ru> <87sh1fmpwz.fsf@linaro.org>
In-Reply-To: <87sh1fmpwz.fsf@linaro.org>
Date: Mon, 29 Oct 2018 10:46:42 +0300
Message-ID: <000601d46f5b$88a3cbd0$99eb6370$@ru>
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
>=20
> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
> >>
> >> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> >> >> Any serious analysis tool should allow for us to track all =
memory
> >> >> accesses so I think the guest_mem_before trace point should =
probably
> >> >> be split into guest_mem_before_store and guest_mem_after_load. =
We
> >> >> could go the whole hog and add potential trace points for =
start/end of
> >> >> all memory operations.
> >> >
> >> > I wanted to ask about memory tracing and found this one.
> >> > Is it possible to use tracepoints for capturing all memory =
accesses?
> >> > In our implementation we insert helpers before and after tcg
> >> > read/write operations.
> >>
> >> The current tracepoint isn't enough but yes I think we could. The =
first
> >> thing I need to do is de-macrofy the atomic helpers a little just =
to
> >> make it a bit simpler to add the before/after tracepoints.
> >
> > But memory accesses can use 'fast path' without the helpers.
> > Thus you still need inserting the new helper for that case.
>=20
> trace_guest_mem_before_tcg in tcg-op.c already does this but currently
> only before operations. That's why I want to split it and pass the
> load/store value register values into the helpers.

One more question about your trace points.
In case of using trace point on every instruction execution, we may need
accessing vCPU registers (including the flags). Are they valid in such =
cases?
I'm asking, because at least i386 translation optimizes writebacks.

Pavel Dovgalyuk
