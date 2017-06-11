Received: from eggs.gnu.org ([2001:4830:134:3::10]:40942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dK21n-0007JE-UI
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dK21k-000346-Pg
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:31:35 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:55782)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dK21k-00033N-Cz
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:31:32 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
	<20170601195544.GB10517@flamenco>
Date: Sun, 11 Jun 2017 15:31:18 +0300
In-Reply-To: <20170601195544.GB10517@flamenco> (Emilio G. Cota's message of
	"Thu, 1 Jun 2017 15:55:44 -0400")
Message-ID: <871sqqpuy1.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 0/7] trace: [tcg] Optimize per-vCPU
 tracing states with separate TB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Emilio G Cota writes:

> On Fri, Jan 13, 2017 at 21:48:09 +0100, Llu=C3=ADs Vilanova wrote:
> (snip)
>> To handle both issues, this series integrates the dynamic tracing event =
state
>> into the TB hashing function, so that vCPUs tracing different events wil=
l use
>> separate TBs. Note that only events with the 'vcpu' property are used for
>> hashing (as stored in the bitmap of CPUState->trace_dstate).

> Is this going to be picked up by anyone? AFAICT the patchset is close
> to being merge-ready.

> Llu=C3=ADs: I'm very interested in your instrumentation work [1]:

> - How much up to date are the branches in [1]? I couldn't find this
>   v7 iteration in there, although maybe I didn't look carefully enough.

> - Are you planning on upstreaming it? I have some time to help with
>   that if you're interested.

After your latest re-spin on this series, there's two basic pieces missing
upstream to have instrumentation:

* An interface to insert user callbacks on events.

* A useful mechanism to pass value place holders (values are later calculat=
ed)
  to these callbacks. This is useful when instrumenting an event before it
  happens (e.g., before an instruction is executed) to pass it some values =
that
  are only known afterwards (e.g., number of instructions in a BBL). I call=
ed
  them promises, and you can see an example in [2] (using an older API of Q=
DBI).


> - Do you have instrumentation examples beyond what's in
>   docs/instrumentation.txt? In particular I'd like to see how the basic
>   block (BBL) instrumentation works, i.e. how a 'skeleton' simulator
>   would work to decode the guest instructions and also track their
>   dependences.

No, sorry, I never got around to writing such type of instrumentation
example. The closest I have is [2].


[2] https://projects.gso.ac.upc.edu/projects/qdbi-simpoint


> Thanks,

> 		Emilio

> [1] https://projects.gso.ac.upc.edu/projects/qemu-dbi


Cheers,
  Lluis
