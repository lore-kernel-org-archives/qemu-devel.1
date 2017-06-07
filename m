Received: from eggs.gnu.org ([2001:4830:134:3::10]:50899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dIYyr-0003Uf-Pk
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dIYym-0007yZ-R5
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:18:29 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:38408)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dIYym-0007yC-Av
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:18:24 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
	<20170606171320.GA8115@flamenco>
Date: Wed, 07 Jun 2017 14:12:44 +0300
In-Reply-To: <20170606171320.GA8115@flamenco> (Emilio G. Cota's message of
	"Tue, 6 Jun 2017 13:13:20 -0400")
Message-ID: <877f0o3vbn.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

Emilio G Cota writes:

> - Instrumentation. I think QEMU should have a good interface to enable
>   dynamic binary instrumentation. This has many uses and in fact there
>   are quite a few forks of QEMU doing this.
>   I think Llu=C3=ADs Vilanova's work [1] is a good start to eventually get
>   something upstream.

> [1] https://projects.gso.ac.upc.edu/projects/qemu-dbi

Hey, I'm really happy you think that's worth pursuing. Even if it doesn't l=
ook
like it, I keep working on this on small bits of free time. I have a few pa=
tch
series that were ready to send, but should now be rebased to upstream before
that. In fact, I have an academic paper on the back-burner describing the w=
ork I
did (there's some cool tricks), but was waiting to get the core
intrumentation-agnostic infrastructure upstreamed first.

My understanding was that adding a public instrumentation interface would a=
dd
too much code maintenance overhead for a feature that is not in QEMU's core
target.

During time, I've kept simplifying large parts of the intrumentation code b=
ase,
and maybe things have changed in QEMU enough to rethink if that's worth
integrating. Of course, I'm completely open to discuss it.


Cheers,
  Lluis
