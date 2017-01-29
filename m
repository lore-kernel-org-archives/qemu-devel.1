Received: from eggs.gnu.org ([2001:4830:134:3::10]:39132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cXoa2-0000cM-Qb
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 07:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cXoZz-0003au-MO
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 07:27:38 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:44236)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cXoZz-0003Zd-9z
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 07:27:35 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <147342618684.13303.1583142856242164602.stgit@fimbulvetr.bsc.es>
	<87vaxifx4y.fsf@fimbulvetr.bsc.es> <87inp08m1d.fsf@linaro.org>
Date: Sun, 29 Jan 2017 14:27:21 +0200
In-Reply-To: <87inp08m1d.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Fri, 27 Jan 2017 17:12:14 +0000")
Message-ID: <8737g2nj9y.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/6] translate: [tcg] Generic
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Alex Benn=C3=A9e writes:

> Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> writes:

>> Llu=C3=ADs Vilanova writes:
>>=20
>>> This series proposes a generic (target-agnostic) instruction translation
>>> framework.
>>=20
>>> It basically provides a generic main loop for instruction disassembly, =
which
>>> calls target-specific functions when necessary. This generalization mak=
es
>>> inserting new code in the main loop easier, and helps in keeping all ta=
rgets in
>>> synch as to the contents of it.
>>=20
>>> I've only ported i386 as an example to get some feedback, but I'm plann=
ing on
>>> porting ARM next to see how well it fits into the current organization.
>>=20
>>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>>> ---
>>=20
>>> Changes in v2
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>>> * Port ARM and AARCH64 targets.
>>> * Fold single-stepping checks into "max_insns" [Richard Henderson].
>>> * Move instruction start marks to target code [Richard Henderson].
>>> * Add target hook for TB start.
>>> * Check for TCG temporary leaks.
>>> * Move instruction disassembly into a target hook.
>>> * Make breakpoint_hit() return an enum to accomodate target's needs (AR=
M).
>> [...]
>>=20
>> I'm not sure if I CC'd the appropriate people, but I'd like to know if t=
his
>> seems like the proper approach to generalizing the main disassembly
>> loop.
>>=20
>> Every time someone updates a target it becomes a little cumbersome to ke=
ep this
>> type of patches in synch (for now, only in i386 and arm).

> I'm sorry this has been in my review queue so long that it no longer
> applies cleanly. However feel free to add me on the next iteration.

Will do.


> My only general comment is I think there is a bit too much churn in the
> per-arch changes from re-names that aren't really needed. Aside from
> that it would be useful to have an example of something that can be done
> more easily in the generic run-loop as part of the series. Otherwise I
> find the churn hard to justify.

For one, it's easier to keep all main loops in synch. I've found in previous
versions that some main loops perform some of the operations in a different
order (like the order between gen_io_start() and breakpoint checks; might be
synced now, I haven't checked again).

The most prominent example I have is a later series adding support to trace=
 what
code the guest executes on all targets (raising an event before and another
after each instruction/bbl).


Cheers,
  Lluis
