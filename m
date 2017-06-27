Received: from eggs.gnu.org ([2001:4830:134:3::10]:51494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPojP-0002qn-1V
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPojL-0005OR-U2
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:32:31 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:56337)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPojL-0005Mr-Hc
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:32:27 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838119390.6497.17430428991952287717.stgit@frigg.lan>
	<20170626181226.GG17935@flamenco>
Date: Tue, 27 Jun 2017 14:32:12 +0300
In-Reply-To: <20170626181226.GG17935@flamenco> (Emilio G. Cota's message of
	"Mon, 26 Jun 2017 14:12:26 -0400")
Message-ID: <878tkdk6o3.fsf@frigg.lan>
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Emilio G Cota writes:

> On Sun, Jun 25, 2017 at 11:59:54 +0300, Llu=C3=ADs Vilanova wrote:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> Makefile.target                |    1=20
>> include/exec/gen-icount.h      |    2=20
>> include/exec/translate-block.h |  125 +++++++++++++++++++++++++++
>> include/qom/cpu.h              |   22 +++++
>> translate-block.c              |  185 ++++++++++++++++++++++++++++++++++=
++++++
>> 5 files changed, 334 insertions(+), 1 deletion(-)
>> create mode 100644 include/exec/translate-block.h
>> create mode 100644 translate-block.c
> (snip)
>> diff --git a/include/exec/translate-block.h b/include/exec/translate-blo=
ck.h
>> new file mode 100644
>> index 0000000000..d14d23f2cb
>> --- /dev/null
>> +++ b/include/exec/translate-block.h
> (snip)
>> +/**
>> + * DisasJumpType:
>> + * @DJ_NEXT: Next instruction in program order.
>> + * @DJ_TOO_MANY: Too many instructions translated.
>> + * @DJ_TARGET: Start of target-specific conditions.
>> + *
>> + * What instruction to disassemble next.
>> + */
>> +typedef enum DisasJumpType {
>> +    DJ_NEXT,
>> +    DJ_TOO_MANY,
>> +    DJ_TARGET,
>> +} DisasJumpType;

> I'd give up on the enum to avoid unnecessary casts. Just define DJ_TARGET
> (or rather, DISAS_TARGET :>) and let the architecture code add more defin=
e's
> using it.

I'm all for restoring the original name (haven't checked if it will produce=
 any
redefine errors).

But using an enum makes the API more explicit about the intended values. St=
ill,
if the churn of casting outweighs the API clarity, I can revert this.

Another option previously suggested on the list is defining DISAS_TARGET_[0=
..N]
on the enum, and letting targets simply define their own name when mapped to
those. I'll try that one before completely dropping the enum. That is, unle=
ss
someone is strongly for going back to defines.


Cheers,
  Lluis
