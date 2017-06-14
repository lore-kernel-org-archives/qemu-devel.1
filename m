Received: from eggs.gnu.org ([2001:4830:134:3::10]:40339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL7et-0007Pb-3q
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL7es-0003fZ-Fm
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:44:27 -0400
References: <20170609170100.3599-1-alex.bennee@linaro.org>
	<20170609170100.3599-4-alex.bennee@linaro.org>
	<fc351edb-7c08-c341-d8ee-85f6768e4931@twiddle.net>
	<87vao4b4z5.fsf@linaro.org>
	<9776b437-90b4-f2c2-4a0c-c1c6585379bf@twiddle.net>
	<20170611050730.GA12317@flamenco> <20170613225352.GA26288@flamenco>
	<db800d74-7cfa-d9e3-60d7-3e7b19565b9b@twiddle.net>
	<5036e9ad-257a-b098-5093-050fca825627@redhat.com>
	<87r2ymiyht.fsf@linaro.org>
	<9c7ea148-2ca7-ec56-48ed-eabac0fe7896@redhat.com>
	<87poe6ix5u.fsf@linaro.org>
	<f185840b-5390-7df7-2450-f846f6af8a84@redhat.com>
	<87o9tqiw6g.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab7ac96a-2c72-816d-0435-49e744522035@redhat.com>
Date: Wed, 14 Jun 2017 14:43:59 +0200
MIME-Version: 1.0
In-Reply-To: <87o9tqiw6g.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/aarch64: exit to main loop after
 handling MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, peter.maydell@linaro.org, edgar.iglesias@xilinx.com, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>



On 14/06/2017 14:35, Alex Benn=C3=A9e wrote:
>> That would cause an unnecessary slowdown in code that runs with
>> interrupts disabled but does a lot of indirect jumps...  ppc's SLOF
>> firmware probably qualifies.
>=20
> Really?

Yes. :)  SLOF basically runs a Forth interpreter.  If you run
"qemu-system-ppc64 -d in_asm", you'll see a lot of "bctr" and "bctrl"
instruction (respectively ARM's "br" and "blr" IIRC).

> I'd have to measure the change it makes. Is there a benchmark
> stanza for measuring the PPC slof firmware time?

Just booting.  PPC doesn't have tcg_gen_lookup_and_goto_ptr support yet,
so it would be a theoretical slowdown at this time.

Paolo

> I have 3 patches now which all fix the same thing so we can pick and
> choose which we should apply. Patches incoming...
