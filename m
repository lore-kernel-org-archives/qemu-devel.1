Received: from eggs.gnu.org ([2001:4830:134:3::10]:35632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dtzYY-0007Dw-83
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dtzYT-0003EZ-70
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:10:02 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:48616)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dtzYS-0003Bw-RM
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:09:57 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
	<CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
	<87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
Date: Mon, 18 Sep 2017 20:09:36 +0300
In-Reply-To: <CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	(Peter Maydell's message of "Mon, 18 Sep 2017 15:41:38 +0100")
Message-ID: <87d16o53xr.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

Peter Maydell writes:

> On 15 September 2017 at 14:39, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> =
wrote:
>> Peter Maydell writes:
>>> This looks like it's exposing too much implementation detail.
>>> We should just provide an API for "hook to be called for
>>> memory writes" which gets all the information when it
>>> is called. I don't think we should expose any kind of
>>> "this hook is called at translation time" at all.
>>=20
>> The differentiation between translation-time and execution-time is key to
>> perform certain analysis efficiently.

> It's also exposing internal QEMU implementation detail.
> What if in future we decide to switch from our current
> setup to always interpreting guest instructions as a
> first pass with JITting done only in the background for
> hot code?

TCI still has a separation of translation-time (translate.c) and execution-=
time
(interpreting the TCG opcodes), and I don't think that's gonna go away anyt=
ime
soon.

Even if it did, I think there still will be a translation/execution separat=
ion
easy enough to hook into (even if it's a "fake" one for the cold-path
interpreted instructions).


> Sticking to instrumentation events that correspond exactly to guest
> execution events means they won't break or expose internals.

It also means we won't be able to "conditionally" instrument instructions (=
e.g.,
based on their opcode, address range, etc.).

Of course we can add the translation/execution differentiation later if we =
find
it necessary for performance, but I would rather avoid leaving "historical"
instrumentation points behind on the API.

What are the use-cases you're aiming for?


Cheers!
  Lluis
