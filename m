Received: from eggs.gnu.org ([2001:4830:134:3::10]:38114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVFXH-0001MM-T3
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVFXC-0001D3-R0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:10:27 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:57038 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVFXC-0001Cm-ER
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:10:22 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<87shi27zqz.fsf@linaro.org>
Date: Wed, 12 Jul 2017 14:10:12 +0300
In-Reply-To: <87shi27zqz.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Wed, 12 Jul 2017 10:47:48 +0100")
Message-ID: <878tjtewrv.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 00/27] translate: [tcg] Generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Alex Benn=C3=A9e writes:

> Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> writes:

>> This series proposes a generic (target-agnostic) instruction translation
>> framework.
>>=20
>> It basically provides a generic main loop for instruction disassembly, w=
hich
>> calls target-specific functions when necessary. This generalization makes
>> inserting new code in the main loop easier, and helps in keeping all tar=
gets in
>> synch as to the contents of it.

> As has been mentioned elsewhere I think we need to spend a little time
> making sure we have well defined common semantics for the as many of the
> translation exit conditions as possible so the others really are just
> special conditions for each architecture.

>> This series also paves the way towards adding events to trace guest code
>> execution (BBLs and instructions).

> I'm looking forward to it, it is certainly going in the right direction
> and will make instrumentation a lot easier ;-)

>> I've ported i386/x86-64 and arm/aarch64 as an example to see how it fits=
 in the
>> current organization, but will port the rest when this series gets
>> merged.

> Are you confident the other architectures will be as amenable to this
> port? I guess we want to avoid being in a position of having a partial
> port in progress for too long.

> Anyway I'm done with my review pass for now, I look forward to future
> revisions ;-)

I've only skimmed through a few other targets, but there seems to be a patt=
ern
that follows the same type of changes. In fact, most of them are just moving
code around into refactored hooks. But I don't want these to be my "last fa=
mous
words" :)


Thanks,
  Lluis
