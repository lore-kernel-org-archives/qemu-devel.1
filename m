Received: from eggs.gnu.org ([2001:4830:134:3::10]:39504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dcEfW-0002LZ-UU
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dcEfT-00006G-Q9
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:39:50 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:46962)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dcEfT-00005a-Ef
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:39:47 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170731140718.22010-1-stefanha@redhat.com>
	<20170731140718.22010-3-stefanha@redhat.com>
	<87d18g3anv.fsf@frigg.lan>
	<20170731163353.GA24783@stefanha-x1.localdomain>
Date: Mon, 31 Jul 2017 20:39:35 +0300
In-Reply-To: <20170731163353.GA24783@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 31 Jul 2017 17:33:53 +0100")
Message-ID: <87wp6o1p60.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] trace: add
 trace_event_get_state_backends()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>, "Daniel P. Berrange" <berrange@redhat.com>

Stefan Hajnoczi writes:

> On Mon, Jul 31, 2017 at 06:09:56PM +0300, Llu=C3=ADs Vilanova wrote:
>> Stefan Hajnoczi writes:
>>=20
>> > Code that checks dstate is unaware of SystemTap and LTTng UST dstate, =
so
>> > the following trace event will not fire when solely enabled by SystemT=
ap
>> > or LTTng UST:
>>=20
>> >   if (trace_event_get_state(TRACE_MY_EVENT)) {
>> >       str =3D g_strdup_printf("Expensive string to generate ...",
>> >                             ...);
>> >       trace_my_event(str);
>> >       g_free(str);
>> >   }
>>=20
>> I believe this should be trace_event_get_state_backends(). Same applies =
to the
>> cover letter.

> This instance and the cover letter are both showing the pattern in
> existing code.

> The description "event will not fire" is correct with
> trace_event_get_state().  If I change it to
> trace_event_get_state_backends() then the description is no longer
> correct :).

Woops, I read this too quickly and assumed it was a usage example, sorry :)

Cheers,
  Lluis
