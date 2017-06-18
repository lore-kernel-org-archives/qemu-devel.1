Received: from eggs.gnu.org ([2001:4830:134:3::10]:55675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbNf-0006O5-SP
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbNd-0004Ur-Nd
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:40:47 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:57379 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbNd-0004Q2-8S
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:40:45 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
	<20170615221911.GB26408@flamenco>
Date: Sun, 18 Jun 2017 17:20:25 +0300
In-Reply-To: <20170615221911.GB26408@flamenco> (Emilio G. Cota's message of
	"Thu, 15 Jun 2017 18:19:11 -0400")
Message-ID: <87wp89e5sm.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 3/6] target: [tcg] Add generic
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

> Some minor nits below.
> On Mon, Jun 12, 2017 at 17:54:09 +0300, Llu=C3=ADs Vilanova wrote:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> +/**
>> + * BreakpointHitType:
>> + * @BH_MISS: No hit
>> + * @BH_HIT_INSN: Hit, but continue translating instruction
>> + * @BH_HIT_TB: Hit, stop translating TB
>> + *
>> + * How to react to a breakpoint hit.
>> + */
>> +typedef enum BreakpointHitType {
>> +    BH_MISS,
>> +    BH_HIT_INSN,
>> +    BH_HIT_TB,
>> +} BreakpointHitType;

> BH_MISS reads out loud to "Breakpoint Hit Miss"; that's quite counterintu=
itive.
> Similarly for the others (e.g. "breakpoint Hit Hit -- ??".

> Can we just do BP_{MISS,HIT,etc}? Thinking about it, perhaps BP_NONE is
> better than BP_MISS.
[...]

Will do.


Cheers,
  Lluis
