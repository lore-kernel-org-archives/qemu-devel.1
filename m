Received: from eggs.gnu.org ([2001:4830:134:3::10]:52799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPtlf-0007MS-Jn
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPscb-0006Zi-23
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:41:48 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:38076 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPsca-0006Ne-Mb
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:41:44 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838119390.6497.17430428991952287717.stgit@frigg.lan>
	<171b9eb8-87c3-f70f-2a6a-f9dc2a0c5743@twiddle.net>
Date: Tue, 27 Jun 2017 18:41:33 +0300
In-Reply-To: <171b9eb8-87c3-f70f-2a6a-f9dc2a0c5743@twiddle.net> (Richard
	Henderson's message of "Mon, 26 Jun 2017 19:39:28 -0700")
Message-ID: <87h8z1igk2.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 04/26] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Richard Henderson writes:

> On 06/25/2017 01:59 AM, Llu=C3=ADs Vilanova wrote:
[...]
>> +
>> +        /* Early exit before breakpoint checks */
>> +        if (unlikely(db->is_jmp !=3D DJ_NEXT)) {
>> +            break;
>> +        }

> This must be done at the end of the loop, not at the beginning of the nex=
t loop,
> after we've already emitted insn_start for the following insn.

> That said, you already do have that check below, so what is this intended=
 to do?

Some targets (for now, arm-linux-user) need to finish the translation loop
before even the first instruction.


Cheers,
  Lluis
