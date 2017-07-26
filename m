Received: from eggs.gnu.org ([2001:4830:134:3::10]:49774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daVHm-0006jX-Tl
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daVHh-0005Bn-VT
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:00:10 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-21-f4bug@amsat.org>
	<CAFEAcA9RvWoL0cr=irYQ0iphHT9E4pqoQKTW+Bu28uoEJGR3mA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6654b344-3f08-258c-aebc-0888e98efc71@amsat.org>
Date: Wed, 26 Jul 2017 20:00:00 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9RvWoL0cr=irYQ0iphHT9E4pqoQKTW+Bu28uoEJGR3mA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 20/35] arm/boot: fix undefined
 instruction on secondary smp cpu bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 07/24/2017 06:06 PM, Peter Maydell wrote:
> On 24 July 2017 at 19:27, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> In a ARM multicore system, write_secondary_boot() only initializes fixups for
>> FIXUP_GIC_CPU_IF and FIXUP_BOOTREG, while smpboot[] also uses FIXUP_DSB.
>> This results in write_bootloader() using uninitialized fixupcontext[FIXUP_DSB]
>> instruction in the bootloader code...
> 
> Hmm? The code does:
> 
>      if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
>          fixupcontext[FIXUP_DSB] = DSB_INSN;
>      } else {
>          fixupcontext[FIXUP_DSB] = CP15_DSB_INSN;
>      }
> 
> so fixupcontext[FIXUP_DSB] is guaranteed initialized,
> as are FIXUP_GIC_CPU_IF and FIXUP_BOOTREG, which are
> the only fixups that the smpboot[] code uses.

Indeed :)

Sorry for the noise, I'll add few hints to the analyzer.
