Received: from eggs.gnu.org ([2001:4830:134:3::10]:60450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr6Di-0000z4-By
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr6Df-0001mx-9T
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:40:34 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:55578)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr6De-0001mf-U9
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:40:31 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	<20170906205947.GB25558@flamenco>
Date: Sun, 10 Sep 2017 20:40:19 +0300
In-Reply-To: <20170906205947.GB25558@flamenco> (Emilio G. Cota's message of
	"Wed, 6 Sep 2017 16:59:47 -0400")
Message-ID: <87poayzc3g.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/20] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Emilio G Cota writes:

> On Wed, Sep 06, 2017 at 20:22:41 +0300, Llu=C3=ADs Vilanova wrote:
>> This series adds an API to add instrumentation events.
>>=20
>> It also provides additional APIs for:
>> * Controlling tracing events

> hmm didn't Stefan say that tracing should be decoupled from this?

>> * Peek/poke guest memory
>>=20
>> There's still missing APIs for (can be added in later series?):
>> * Provide something like tracing's per-vCPU trace states (i.e., so that =
each
>> vCPU can have different instrumentation code). It's still not clear to m=
e if
>> we should extend the per-vCPU bitmap with instrumentation events, or oth=
erwise
>> somehow reuse the bits in tracing events (since they're currently limite=
d).

> As I said in the description of my alternative implementation [*], I don'=
t see
> much value in having per-vCPU events, as most instrumenters just care abo=
ut
> the guest application/system. I can only think of cases where the instrum=
enter
> is only interested in a guest process (in system-mode), but that'd be ugly
> anyway (would need to change both QEMU and the guest kernel to track the =
pid).

Yes, that's exactly what I was using it for (track guest processes in softm=
mu
mode).


> If the need ever arises, we could add __vcpu(cpu_index) registration func=
tions.

You still need the functionality I cited if you're using
"qi_event_gen_guest_mem_before_exec" or similar.


> [*] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01446.html

> 		E.

Cheers,
  Lluis
