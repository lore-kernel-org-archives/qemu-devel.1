Received: from eggs.gnu.org ([2001:4830:134:3::10]:32951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dnRFM-0004dE-M6
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dnRFH-0005zN-Qd
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:19:08 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:52975)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dnRFH-0005yv-En
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:19:03 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150142369849.12995.11229612194223213120.stgit@frigg.lan>
	<20170826003454.GA23546@flamenco>
	<20170831115935.GQ13619@stefanha-x1.localdomain>
Date: Thu, 31 Aug 2017 18:13:21 +0300
In-Reply-To: <20170831115935.GQ13619@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Thu, 31 Aug 2017 12:59:35 +0100")
Message-ID: <87wp5ju5wu.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 0/5] hypertrace: Lightweight
 guest-to-QEMU trace channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>

Stefan Hajnoczi writes:

> On Fri, Aug 25, 2017 at 08:34:54PM -0400, Emilio G. Cota wrote:
>> On Sun, Jul 30, 2017 at 17:08:18 +0300, Llu=C3=ADs Vilanova wrote:
>> > The hypertrace channel allows guest code to emit events in QEMU (the h=
ost) using
>> > its tracing infrastructure (see "docs/trace.txt"). This works in both =
'system'
>> > and 'user' modes, is architecture-agnostic and introduces minimal nois=
e on the
>> > guest.
>> >=20
>> > See first commit for a full description, use-cases and an example.
>> >=20
>> > Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>>=20
>> This would be indeed very useful once TCG instrumentation is in place.
>>=20
>> However, I'm not very excited about this being PCI-only and Linux-only f=
or
>> system mode
>> I wonder how we could make this work on all hosts -- did you consider us=
ing
>> "magic" instructions? We'd need a different magic instruction for each
>> guest ISA, but the library would hide that anyway (and the library code
>> would be the same for user and system modes).

> Magic instructions can potentially be implemented more efficiently in
> TCG too.  They wouldn't work under KVM/HAX/hvf accelerators though.

Yes, we discussed this on the first version of this series long ago. The sp=
ecial
device makes it work on both TCG and KVM (if it were possible to implement a
TCG-to/from-KVM mode switch that'd be awesome).

Also, both approaches have negligible performance impact on the *guest* tim=
e.


Cheers,
  Lluis
