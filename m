Received: from eggs.gnu.org ([2001:4830:134:3::10]:59515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr68Q-0007k6-M8
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr68N-0007vU-EX
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:35:06 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:40876)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr68L-0007sC-Qu
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:35:03 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	<87a826epxe.fsf@dusky.pond.sub.org> <20170907142152.GA19705@flamenco>
Date: Sun, 10 Sep 2017 20:34:48 +0300
In-Reply-To: <20170907142152.GA19705@flamenco> (Emilio G. Cota's message of
	"Thu, 7 Sep 2017 10:21:52 -0400")
Message-ID: <87zia2zccn.fsf@frigg.lan>
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Emilio G Cota writes:

> On Thu, Sep 07, 2017 at 12:58:05 +0200, Markus Armbruster wrote:
>> Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> writes:
>>=20
>> > This series adds an API to add instrumentation events.
>> >
>> > It also provides additional APIs for:
>> > * Controlling tracing events
>> > * Peek/poke guest memory
>> >
>> > There's still missing APIs for (can be added in later series?):
>> > * Provide something like tracing's per-vCPU trace states (i.e., so tha=
t each
>> >   vCPU can have different instrumentation code). It's still not clear =
to me if
>> >   we should extend the per-vCPU bitmap with instrumentation events, or=
 otherwise
>> >   somehow reuse the bits in tracing events (since they're currently li=
mited).
>> > * Peek/poke guest registers
>> >
>> > The instrumentation code is dynamically loaded as a library into QEMU =
either
>> > when it starts or later using its remote control interfaces.
>> >
>> > Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>>=20
>> Taking a step back.
>>=20
>> This looks like a way to dynamically load arbitrary code.  What
>> interfaces can this code use?  Your cover letter should answer this.
>>=20
>> As long as the answer is "everything the dynamic linker is willing to
>> resolve", this series heading nowhere.  We can talk about an interface
>> for plugins, but "anything goes" is not on the menu.

> A simple solution to this is to only export the API symbols by passing
> --dynamic-file to the linker -- see patch 2 of the following series for an
> example (ELF-only, although I'm pretty sure this can be achieved on Windo=
ws
> as well):
>   https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01446.html

Sorry, I adapted the instr series in a rush and missed your series. I'm now
preparing a new version that fixes this without the flags you mention (miss=
ed to
add a line in this series).


Thanks,
  Lluis
